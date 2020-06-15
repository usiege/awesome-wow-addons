------------------------------------------------------------------------------
-- DevToolsEventTrace.lua
--
-- A low-impact event monitor
--
-- Written by Iriel
--
-- Globals: DevTools
-- Globals: BINDING_HEADER_DEVTOOLS, BINDING_NAME_DEVTOOLS_EVENTTRACE_*
-- Globals: SLASH_DEVTOOLS_EVENTTRACE*
---------------------------------------------------------------------------

local DT = DevTools;
DevTools_Events = {
    [" _OnUpdate"] = true,
    [" _Stop"] = true,
    [" _Start"] = true,
};
local OldEvents = DevTools_Events;

local function print(...)
    DEFAULT_CHAT_FRAME:AddMessage("[DTET] " .. strconcat(...));
end

-- Get closure utilities
local CREATE_CLOSURES = DT:GetEventEntryCreateClosureTable();
local READ_CLOSURES = DT:GetEventEntryReadClosureTable();
local WRITE_CLOSURES = DT:GetEventEntryWriteClosureTable();

-- Preallocate enough slots to hold 19 args (Max combat log event size)
local INITIAL_ARG_ALLOCATION = 19;

function DT:CreateEventBuffer(size)
    size = size or 1000;
    local pool = {};
    local lastIn = 0;
    local lastIdx = 0;
    local select = select;

    local entryAllocator = CREATE_CLOSURES[INITIAL_ARG_ALLOCATION + 3];

    for i = 1, size do
        pool[i] = entryAllocator();
    end

    return {
        pool = pool;

        GetSize = function(self) return size; end;

        Add = function(self, ...)
                  local idx = lastIdx + 1;
                  local n = lastIn + 1;
                  if (idx > size) then idx = 1; end
                  lastIn, lastIdx = n, idx;
                  local N = select('#', ...);
                  local T = pool[idx];
                  -- Testing has shown that there's a benefit to be
                  -- had in avoiding the function call for simple
                  -- argument lists.
                  if (N < 8) then
                      T[1], T[2], T[3], T[4], T[5], T[6], T[7], T[8] = N, ...;
                  elseif (N < 16) then
                      T[1], T[2], T[3], T[4], T[5], T[6], T[7], T[8],
                      T[9], T[10], T[11], T[12], T[13], T[14], T[15],
                      T[16] = N, ...;
                  else
                      -- Fallback to dynamic function
                      WRITE_CLOSURES[N](T, N, ...);
                  end
                  return n;
              end;

        Get = function(self, idx)
                  if (idx < 1) or (idx > lastIn) or (idx <= (lastIn - size)) then
                      return;
                  end
                  local T = pool[((idx-1) % size)+1];
                  local N = T[1];
                  return READ_CLOSURES[N](T);
              end;

        GetLastID = function(self) return lastIn; end;

        GetIDRange = function(self)
                         local first = lastIn - size + 1;
                         if (first < 1) then
                             first = 1;
                         end
                         return first, lastIn;
                     end;
    };
end

local EVTPool = nil;
local EVTPool_Add = nil;
local EVTFrame = CreateFrame("Frame", "DevToolsEventTraceFrame");
local EVTOnUpdateCount = 0;
local EVTOnUpdateElapsed = 0;
local EVTOnUpdateTime = 0;
local EVTNewEventCount = 0;
local EVTEventRegistries = {}
local EVTStopped = true;
local EVTCaptureLimit = nil;

local EVTInitializePool = nil;

local CONFIG_NAME_AUTO_START = "eventTraceAutoStart";

setmetatable(EVTEventRegistries, { __mode = "k"; })

local GET_TIME = GetTime;

local function EVTOnUpdate(self, elapsed)
    EVTOnUpdateTime = GET_TIME();
    EVTOnUpdateCount = EVTOnUpdateCount + 1;
    EVTOnUpdateElapsed = EVTOnUpdateElapsed + elapsed;
end

local function EVTNewEvent(event)
    EVTNewEventCount = EVTNewEventCount + 1;
--    print("New event discovered: ", event);
    for registry, v in pairs(EVTEventRegistries) do
        if (type(v) == "string") then
            registry[v](registry, event);
        else
            v(registry, event);
        end
    end
end

local function EVTStopCapture(reason)
    if (EVTStopped) then
        return;
    end
    EVTStopped = true;
    EVTPool_Add(EVTPool, GET_TIME(), " _Stop", reason or "");
end

local function EVTStartCapture(reason)
    if (not EVTStopped) then
        return;
    end
    if (EVTPool == nil) then EVTInitializePool(false); end
    EVTStopped = nil;
    EVTOnUpdateCount = 0;
    EVTOnUpdateElapsed = 0;
    EVTPool_Add(EVTPool, GET_TIME(), " _Start", reason or "");
end

local function EVTOnEvent(self, event, ...)
    local now = GET_TIME();
    local DTE = DevTools_Events;
    if (event == "ADDON_LOADED" and (...) == "DevTools") then
        if (type(DTE) ~= "table") then
            DevTools_Events = {};
            DTE = DevTools_Events;
        end

        if (OldEvents ~= DTE) then
            for oldEvent in pairs(DTE) do
                if (not OldEvents[oldEvent]) then
                    EVTNewEvent(oldEvent);
                else
                    OldEvents[oldEvent] = nil;
                end
            end
            for oldEvent in pairs(OldEvents) do
                DTE[oldEvent] = true;
                EVTNewEvent(oldEvent);
            end
            OldEvents = DTE;
        end

        if (DT:GetConfig(CONFIG_NAME_AUTO_START, false)) then
            DT:StartEventTraceCapture("DevTools Loaded");
        end
    end
    if (not DTE[event]) then
        DTE[event] = true;
        EVTNewEvent(event);
    end
    if (EVTStopped) then
        return;
    end
    local n = 1;
    if (EVTOnUpdateCount ~= 0) then
        EVTPool_Add(EVTPool, EVTOnUpdateTime,
                    " _OnUpdate",
                    string.format("%.3f sec", EVTOnUpdateElapsed),
                    EVTOnUpdateCount);
        EVTOnUpdateCount = 0;
        EVTOnUpdateElapsed = 0;
        n = n + 1;
    end
    EVTPool_Add(EVTPool, now, event, ...);
    if (EVTCaptureLimit ~= nil) then
        EVTCaptureLimit = EVTCaptureLimit - n;
        if (EVTCaptureLimit <= 0) then
            EVTCaptureLimit = nil;
            EVTStopCapture("Capture limit reached");
        end
    end
end

EVTFrame:SetScript("OnEvent", EVTOnEvent);
EVTFrame:RegisterEvent("ADDON_LOADED");
-- Make sure this can be hooked to AceEvents at some point
-- Note that ace allows up to 20 args for an event


function EVTInitializePool(autoStart)
    if (EVTPool) then
        return;
    end
    EVTPool = DT:CreateEventBuffer(2040);
    EVTPool_Add = EVTPool.Add;
    EVTFrame:SetScript("OnUpdate", EVTOnUpdate);
    EVTFrame:RegisterAllEvents();
    EVTFrame:Show();
    if (autoStart) then
        DT:StartEventTraceCapture("Event Trace Initialized");
    end
end

function DT:GetEventTracePool()
    if (EVTPool == nil) then EVTInitializePool(); end
    return EVTPool;
end

function DT:AddEventRegistry(registry, callback, scan)
    EVTEventRegistries[registry] = callback;
    if (scan) then
        if (type(callback) == "string") then
            callback = registry[callback];
        end

        for event in pairs(DevTools_Events) do
            callback(registry, event);
        end
    end
end

function DT:RemoveEventRegistry(registry)
    EVTEventRegistries[registry] = nil;
end

function DT:StartEventTraceCapture(reason)
    EVTStartCapture(reason);
end

function DT:StopEventTraceCapture(reason)
    EVTStopCapture(reason);
end

function DT:SetEventTraceCaptureLimit(limit)
    EVTCaptureLimit = limit;
end

function DT:GetEventTraceStatus()
    return (not EVTStopped), EVTCaptureLimit;
end

function DT:EventTrace_Start(toFill)
    if (toFill) then
        -- DT:SetEventTraceCaptureLimit(DT:GetEventTracePool():GetSize() - 3);
        DT:SetEventTraceCaptureLimit(50);
    else
        DT:SetEventTraceCaptureLimit(nil);
    end
    DT:StartEventTraceCapture("User command");
end

function DT:EventTrace_Stop()
    DT:StopEventTraceCapture("User command");
end

function DT:EventTrace_Toggle()
    if (EVTStopped) then
        DT:StartEventTraceCapture("User command");
    else
        DT:StopEventTraceCapture("User command");
    end
end

---------------------------------------------------------------------------

local visualizer;

function DT.EventTrace_SlashCommand(msg, editBox)
    if (msg == "stop") then
        DT:EventTrace_Stop();
        return;
    end

    if (msg == "start") then
        DT:EventTrace_Start(false);
        return;
    end

    if (msg == "fill") then
        DT:EventTrace_Start(true);
        return;
    end

    if (msg == "auto") then
        DT:SetConfig(CONFIG_NAME_AUTO_START, true, false);
        DEFAULT_CHAT_FRAME:AddMessage("Set to auto-start on UI reload");
        return;
    end

    if (msg == "noauto") then
        DT:SetConfig(CONFIG_NAME_AUTO_START, false, false);
        DEFAULT_CHAT_FRAME:AddMessage("Set to NOT auto-start on UI reload");
        return;
    end

    if ((msg ~= "") and (msg ~= "toggle")) then
        DEFAULT_CHAT_FRAME:AddMessage("Unknown option, try stop/start/fill/toggle/[no]auto (or no arguments for toggle");
        return;
    end

    if (visualizer) then
        if (visualizer.frame:IsShown()) then
            visualizer.frame:Hide();
        else
            visualizer.frame:Show();
        end
        return;
    end

    if (EVTPool == nil) then EVTInitializePool(true); end
    visualizer = DT.EventTraceVisualizer:New("EventTraceVisualFrame",
                                             UIParent);
end

SlashCmdList["DEVTOOLS_EVENTTRACE"] = DT.EventTrace_SlashCommand;
SLASH_DEVTOOLS_EVENTTRACE1 = "/dteventtrace";
SLASH_DEVTOOLS_EVENTTRACE2 = "/dtevents";

BINDING_HEADER_DEVTOOLS = "DevTools";
BINDING_NAME_DEVTOOLS_EVENTTRACE_START = "Start event tracing";
BINDING_NAME_DEVTOOLS_EVENTTRACE_STOP = "Stop event tracing";
BINDING_NAME_DEVTOOLS_EVENTTRACE_FILL = "Start event tracing until full";
BINDING_NAME_DEVTOOLS_EVENTTRACE_TOGGLE = "Toggle event tracing";
BINDING_NAME_DEVTOOLS_EVENTTRACE_ONHOLD = "Hold to toggle event trace";
BINDING_NAME_DEVTOOLS_EVENTTRACE_SHOW = "Toggle visibility of trace frame";

