------------------------------------------------------------------------------
-- DevTools.lua
--
-- Author: Daniel Stephens www.cheeseplant.org
--
-- Globals: DevTools, SLASH_DEVTOOLSRELOAD1
-----------------------------------------------------------------------------

DevTools = { utils = {} };
_G.DevTools = DevTools
local DT = DevTools;

function DT:GetPackage(name)
    local pkg = self[name];
    if (not pkg) then
        pkg = {};
        self[name] = pkg;
    end
    return pkg;
end

local function WriteMessage(msg)
    DEFAULT_CHAT_FRAME:AddMessage(msg);
end

function DT:WriteMessage(msg)
    WriteMessage(msg);
end

function DT:GetConfig(name, default)
    local opt = DevTools_Options;
    if (not opt) then return default; end
    local val = opt[name];
    if (val == nil) then return default; end
    return val;
end

function DT:SetConfig(name, value, default)
    local opt = DevTools_Options;
    if (not opt) then
        if (value ~= default) then
            opt = {};
            opt[name] = value;
            DevTools_Options = opt;
        end
        return;
    end
    local val = opt[name];
    if (val == value) then
        return;
    end
    if (val == nil) then
        if (value ~= default) then
            opt[name] = value;
        end
        return;
    end
    if ((value == nil) or (value == default)) then
        opt[name] = nil;
        if (next(opt) == nil) then
            DevTools_Options = nil;
        end
        return;
    end
    opt[name] = value;
end

DT.initializers = {};

function DT:OnEvent(frame, event, arg1)
    if ((event == "ADDON_LOADED") and (arg1 == "DevTools")) then
        for _,initFunc in ipairs(self.initializers) do
            local func = self[initFunc];
            if (func) then func(self) end
        end
        frame:UnregisterEvent("ADDON_LOADED");
    end
    return;
end

function DT:AddInitializer(methodName)
    table.insert(self.initializers, methodName);
end

DT.eventFrame = CreateFrame("Frame");
DT.eventFrame:SetScript("OnEvent", function(...) DT:OnEvent(...) end);
DT.eventFrame:RegisterEvent("ADDON_LOADED");

SLASH_DEVTOOLSRELOAD1 = "/reload";
SlashCmdList["DEVTOOLSRELOAD"] = function(msg, self) ReloadUI(); end

