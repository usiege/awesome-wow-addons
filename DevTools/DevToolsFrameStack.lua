------------------------------------------------------------------------------
-- DevToolsFrameStack.lua
--
-- Frame stacking monitor
--
-- Globals: DevTools, SLASH_DEVTOOLS_FRAMESTACK1
-- Globals: BINDING_HEADER_DEVTOOLS
-- Globals: BINDING_NAME_DEVTOOLS_FRAMESTACK_*
---------------------------------------------------------------------------

local DT = DevTools;

local stratas = {
    "UNKNOWN", "BACKGROUND","LOW","MEDIUM",
    "HIGH", "DIALOG", "FULLSCREEN", "FULLSCREEN_DIALOG",
    "TOOLTIP"
};
local strataLevels = {}
for i,v in ipairs(stratas) do
    strataLevels[v] = i;
end

local frameStackStrata = {};
local frameStackLevels = {};
local frameStackActive = {};
local frameStackList = {};

local MOD = math.mod or math.fmod;

local function FrameStackSort(b,a)
    local sa = strataLevels[frameStackStrata[a]] or -1;
    local sb = strataLevels[frameStackStrata[b]] or -1;
    if (sa < sb) then
        return true;
    elseif (sa > sb) then
        return;
    end
    local sa = frameStackLevels[a] or -1;
    local sb = frameStackLevels[b] or -1;
    if (sa < sb) then
        return true;
    elseif (sa > sb) then
        return;
    end
    return a < b;
end

local colorSpecs = {
    "|cff6699ff",
    "|cff88dddd"
};

local activeColorSpecs = {
    "|cffff9966",
    "|cffdddd88"
};

local hiddenColorSpecs = {
    "|cff666666",
    "|cff888888"
};

local function UpdateFrameStack(visFrame, x, y)
    if (not (x and y)) then
        x,y = GetCursorPosition();
    end
    local nf = EnumerateFrames();
    local f;
    local l = table.getn(frameStackList);
    for i=1,l do frameStackList[i] = nil; end
    if (not table.maxn) then table.setn(frameStackList, 0); end
    for k in pairs(frameStackLevels) do
        frameStackLevels[k] = nil;
        frameStackStrata[k] = nil;
        frameStackActive[k] = nil;
    end
    while (nf) do
        f,nf = nf,EnumerateFrames(nf);
        local es = f:GetEffectiveScale() or 1;

        local Fl,Fb,Fr,Ft = f:GetRect();
        Fl = Fl or -1;
        Fb = Fb or -1;
        Fr = Fl + (Fr or -1)
        Ft = Fb + (Ft or -1)

        if ((x >= Fl * es) and (x <= Fr * es) and
            (y >= Fb * es) and (y <= Ft * es)) then
            local n = f:GetName();
            if (n and (getglobal(n) == f)) then
                -- Name is ok
            elseif (n) then
                n =  tostring(f) .. "(" .. n .. ")";
            else
                n =  tostring(f);
            end

            local s = f:GetFrameStrata() or 'nil';
            local l = f:GetFrameLevel() or -1;
            local a;
            if (f:IsVisible()) then
                if (f:IsMouseEnabled()) then
                    a = activeColorSpecs;
                else
                    a = colorSpecs;
                end
            else
                -- Change this to display hidden frames
                -- a = hiddenColorSpecs;
                a = nil
            end
            if (a) then
                frameStackLevels[n] = l;
                frameStackStrata[n] = s;
                frameStackActive[n] = a;
                table.insert(frameStackList, n);
            end
        end
    end
    frameStackList[table.getn(frameStackList)+1] = nil;

    table.sort(frameStackList, FrameStackSort);
    visFrame:Clear();

    visFrame:AddLine(string.format("Frame stack (%.2f,%.2f)", x, y));

    local cs, os, ol = 1,nil,nil;
    local cn = table.getn(colorSpecs);
    for _,n in ipairs(frameStackList) do
        local s,l,a = frameStackStrata[n], frameStackLevels[n], frameStackActive[n];
        if (os ~= s) then
            visFrame:AddLine("|cffffffff" .. s .. "|r");
            os = s;
            ol = nil;
            cs = 1;
        end
        if (l ~= ol) then
            cs = MOD(cs, cn) + 1;
            ol = l;
        end
        visFrame:AddLine("  " ..  (a[cs] or "|cff444444")
                         .. "<" .. l .. "> " .. n .. "|r");
    end
    visFrame:Show();
end

local curVisFrame;
local t = 0;
local REFRESH_TIME = 0.1;

local function FrameOnUpdate(self, elapsed)
    if (self ~= curVisFrame) then
        self:Free();
        return;
    end
    t = t - elapsed;
    if (t > 0) then
        return;
    end
    local x,y = GetCursorPosition();
    t = REFRESH_TIME;
    UpdateFrameStack(curVisFrame, x, y);
end

local function EnableStack()
    if (not curVisFrame) then
        curVisFrame = DevTools:GetCornerVisFrame()
        curVisFrame:SetScript("OnUpdate", FrameOnUpdate);
    end
    local x,y = GetCursorPosition();
    t = REFRESH_TIME;
    UpdateFrameStack(curVisFrame, x, y);
end

local function DisableStack()
    if (curVisFrame) then
        curVisFrame:Free();
        curVisFrame = nil;
    end
end

function DT:FrameStack_Toggle(newState)
    if (newState == true) then
        EnableStack();
    elseif (newState == false) then
        DisableStack();
    else
        if (curVisFrame) then
            DisableStack()
        else
            EnableStack();
        end
    end
end

SlashCmdList["DEVTOOLS_FRAMESTACK"] = function() DT:FrameStack_Toggle(); end
SLASH_DEVTOOLS_FRAMESTACK1 = "/dtframestack";

BINDING_HEADER_DEVTOOLS = "DevTools";
BINDING_NAME_DEVTOOLS_FRAMESTACK_ONHOLD = "Hold to toggle FrameStack display";
BINDING_NAME_DEVTOOLS_FRAMESTACK_CYCLE = "Toggle FrameStack display";
