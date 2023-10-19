------------------------------------------------------------------------------
-- DevToolsChatEvent.lua
--
-- /dtchatevent Implementation
--
-- Globals: SetItemRef, DevTools, SLASH_DEVTOOLS_CHATEVENT1
-- Globals: event, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9
---------------------------------------------------------------------------
-- This may be a bit ugly

local DT = DevTools;

local ChatFrame_AddMessage_old = {};
local ChatFrame_AddMessage_new;
local ChatFrame_AddMessage_active;

local MOD = math.mod or math.fmod;

local function HookChatFrame(frame)
   if (not ChatFrame_AddMessage_old[frame]) then
      ChatFrame_AddMessage_old[frame] = frame.AddMessage;
      frame.AddMessage = ChatFrame_AddMessage_new;
   end
end

local function UnhookChatFrame(frame)
   local oldHook = ChatFrame_AddMessage_old[frame];
   if (oldHook) then
      local curFunc = frame.AddMessage;
      if (curFunc == oldHook) then
         frame.AddMessage = oldHook;
         ChatFrame_AddMessage_old[frame] = nil;
      end
   end
end

local SetItemRef_old;
local SetItemRef_new;

local function ActivateChatHooks()
   if (ChatFrame_AddMessage_active) then
      return;
   end
   local i = 0;
   while true do
      i = i + 1;
      local name = "ChatFrame" .. i;
      local frame = getglobal(name);
      if (not frame) then break; end
      HookChatFrame(frame);
   end
   ChatFrame_AddMessage_active = true;
   if (not SetItemRef_old) then
      SetItemRef_old = SetItemRef;
      SetItemRef = SetItemRef_new;
   end
end

local function DeactivateChatHooks()
   if (not ChatFrame_AddMessage_active) then
      return;
   end
   for frame in pairs(ChatFrame_AddMessage_old) do
      UnhookChatFrame(frame);
   end
   ChatFrame_AddMessage_active = nil;
end

local lastEventId = 0;
local curEvent;
local curArg1, curArg2, curArg3, curArg4, curArg5;
local curArg6, curArg7, curArg8, curArg9;

local eventBuffer = {};
local EVENT_BUFFER_SIZE = 1000;

local function SetBufferSize(newSize)
   -- noop if no change.
   if (newSize == EVENT_BUFFER_SIZE) then
      return true;
   end

   local ns = tonumber(newSize);
   if (not ns) then
      message("DevToolsChatEvent: Cannot set buffer to non-numeric value");
      return;
   end

   ns = math.floor(ns);
   if (ns < 1) then
      message("DevToolsChatEvent: Cannot set buffer to size  < 1");
      return;
   end
   newSize = ns;

   -- If the buffer isn't full yet, then just set the size
   if ((lastEventId <= newSize) and (lastEventId <= EVENT_BUFFER_SIZE)) then
      EVENT_BUFFER_SIZE = newSize;
      return true;
   end

   local min = lastEventId - EVENT_BUFFER_SIZE + 1;
   local max = lastEventId;
   if (min < 1) then min = 1; end
   if (min < (max - newSize + 1)) then
      min = max - newSize + 1;
   end

   local newBuf = {};
   for i=min, max do
      local evb = eventBuffer[MOD(i - 1, EVENT_BUFFER_SIZE) + 1];
      if (evb) then
         local idx = MOD(i - 1, newSize) + 1;
         newBuf[idx] = evb;
      end
   end
   eventBuffer = newBuf;
   EVENT_BUFFER_SIZE = newSize;
   return true;
end

-- Declared local above
ChatFrame_AddMessage_new = function(self, message, r, g, b, id)
   if (not ChatFrame_AddMessage_active) then
      return ChatFrame_AddMessage_old[self](self, message, r, g, b, id);
   end

   local newEvent = event;
   local newArg1 = arg1;
   local newArg2 = arg2;
   local newArg3 = arg3;
   local newArg4 = arg4;
   local newArg5 = arg5;
   local newArg6 = arg6;
   local newArg7 = arg7;
   local newArg8 = arg8;
   local newArg9 = arg9;

   if ((curEvent == newEvent)
       and (curArg1 == newArg1)
          and (curArg2 == newArg2)
          and (curArg3 == newArg3)
          and (curArg4 == newArg4)
          and (curArg5 == newArg5)
          and (curArg6 == newArg6)
          and (curArg7 == newArg7)
          and (curArg8 == newArg8)
          and (curArg9 == newArg9)) then
   elseif (newEvent) then
      lastEventId = lastEventId + 1;
      local idx = MOD(lastEventId - 1, EVENT_BUFFER_SIZE) + 1;
      local evb = eventBuffer[idx];
      if (evb == nil) then
         evb = {};
         eventBuffer[idx] = evb;
      end
      curEvent = newEvent;
      curArg1, curArg2, curArg3 = newArg1, newArg2, newArg3;
      curArg4, curArg5, curArg6 = newArg4, newArg5, newArg6;
      curArg7, curArg8, curArg9 = newArg7, newArg8, newArg9;

      evb[1] = curEvent;
      evb[2], evb[3], evb[4] = curArg1, curArg2, curArg3;
      evb[5], evb[6], evb[7] = curArg4, curArg5, curArg6;
      evb[8], evb[9], evb[10] = curArg7, curArg8, curArg9;
   end

   if (newEvent) then
      message = "|cffffdd00|HDevTools:ce:" .. lastEventId .. "|h[#]|h|r " .. message;
   else
      message = "|cff888888[#]|r " .. message;
   end
   return ChatFrame_AddMessage_old[self](self, message, r, g, b, id);
end

local EVKEYS = {
   "event",
   "arg1", "arg2", "arg3", "arg4", "arg5",
   "arg6", "arg7", "arg8", "arg9"
};

local function ReplaceSpaceRun(spcs)
   local n = string.len(spcs);
   --return "|cffccccee<" .. string.len(spcs) .. " spaces>|r";
   return "|cff8888ee" .. string.rep('_', n) .. "|r";
end

local strsub = string.sub;

-- Declared local above
SetItemRef_new = function(link, text, button)
   if (strsub(link, 1, 9) ~= "DevTools:") then
      return SetItemRef_old(link, text, button);
   end
   local b,e,num = string.find(link, "^DevTools:ce:(%d+)$");
   if (num) then
      num = tonumber(num);
      local evb;

      if (not num) then
         return;
      end

      if ((num >= 1) and (num <= lastEventId)
          and (num > (lastEventId - EVENT_BUFFER_SIZE))) then
         evb = eventBuffer[MOD(num - 1, EVENT_BUFFER_SIZE) + 1];
      end

      if (not ItemRefTooltip:IsVisible()) then
         ItemRefTooltip:SetOwner(UIParent, "ANCHOR_PRESERVE");
      end

      ItemRefTooltip:ClearLines();

      if (not evb) then
         ItemRefTooltip:AddLine("|cffff0000Event " .. num
                                .. " no longer in buffer|r");
         ItemRefTooltip:Show();
         return;
      end

      for i,lbl in ipairs(EVKEYS) do
         local data = evb[i];
         local dt = type(data);
         local denc;
         if (dt == "string") then
            local dl = string.len(data);
            local ll = 80;
            for ls=1,dl,ll do
               local le = ls+ll-1;
               if (le > dl) then
                  le = dl;
               end
               local dnext = string.gsub(string.sub(data,ls,le),
                                         "\"", "\\\"");
               dnext = string.gsub(dnext, "|", "||");
               dnext = string.gsub(dnext, "\n", "\\n");
               dnext = string.gsub(dnext, "  +", ReplaceSpaceRun);
               dnext = string.gsub(dnext, "^ ", ReplaceSpaceRun);
               dnext = string.gsub(dnext, " $", ReplaceSpaceRun);
               if (denc) then
                  denc = denc .. "\n    ..\"" .. dnext .. "\"";
               else
                  denc = lbl .. "=\"" .. dnext .. "\"";
               end
            end
         elseif (dt == "number") then
            denc = lbl .. "=" .. tostring(data);
         elseif (dt ~= "nil") then
            denc = lbl .. "=<" .. dt .. ">";
         end
         if (denc) then
            ItemRefTooltip:AddLine(denc);
         end
      end
      ItemRefTooltip:Show();
   end
end

function DT:ChatEvent_Init()
   if (self:GetConfig("ChatEventEnabled")) then
      ActivateChatHooks();
   end
   local bufferSize = self:GetConfig("ChatEventBufferSize");
   if (bufferSize) then
      SetBufferSize(bufferSize);
   end
end

DT:AddInitializer("ChatEvent_Init");

function DT:ChatEvent_Command(msg)
   if (msg == "buffer") then
      self:WriteMessage("Chat event buffer size: " .. EVENT_BUFFER_SIZE);
      return;
   end
   msg = msg or '';
   local _,n;
   _,_,n = string.find(msg, "^buffer%s+(%d+)$");
   if (n) then
      if (SetBufferSize(n)) then
         self:WriteMessage("Chat event buffer size now: " .. EVENT_BUFFER_SIZE);
         self:SetConfig("ChatEventBufferSize", EVENT_BUFFER_SIZE);
      end
      return;
   end
   if (msg == "") then
      self:ChatEvent_Toggle();
      return;
   end
   self:WriteMessage("Unknown command option: '" .. msg .. "'");
end

function DT:ChatEvent_Toggle()
   local newOpt = not self:GetConfig("ChatEventEnabled");
   self:SetConfig("ChatEventEnabled", newOpt, false);
   if (newOpt) then
      ActivateChatHooks();
      self:WriteMessage("Chat event monitoring enabled");
   else
      DeactivateChatHooks();
      self:WriteMessage("Chat event monitoring disabled");
   end
end

SlashCmdList["DEVTOOLS_CHATEVENT"] =
   function(msg, editBox) DT:ChatEvent_Command(msg); end
SLASH_DEVTOOLS_CHATEVENT1 = "/dtchatevent";

