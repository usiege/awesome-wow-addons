------------------------------------------------------------------------------
-- DevToolsVisFrame.lua
--
-- Frame (sort of tooltip-esque) for visualization of data
--
-- Globals: DevTools
---------------------------------------------------------------------------

local DT = DevTools;

local freePool = {};
local lastIndex = 0;

-- Table of methods, with additional boolean placeholders for values to
-- preserve between uses.
local visMethods = {
    fontStrings = true;
    lines = true;
    lineHeight = true;
    lineWidth = true;
    lineSpacing = true;
    handlers = true;
    SetScript = true;
    [0] = true;
};

function visMethods:Clear()
    local sfs = self.fontStrings;
    for i=1,self.lines do
        local fs = sfs[i];
        fs:Hide();
    end
    self.lines = 0;
    self.lineHeight = 0;
    self.lineWidth = 0;
end

function visMethods:AddLine(msg)
    local sfs = self.fontStrings;
    local l = self.lines + 1;
    local fs = sfs[l];
    local spc = self.lineSpacing or 1;
    if (not fs) then
        fs = self:CreateFontString();
        fs:SetFontObject(GameFontNormalSmall);
        fs:SetJustifyH("LEFT");
        sfs[l] = fs;
        fs:ClearAllPoints();
        if (l == 1) then
            fs:SetPoint("TOPLEFT", self, "TOPLEFT", 5, -5);
        else
            fs:SetPoint("TOPLEFT", sfs[l-1], "BOTTOMLEFT", 0, -spc);
        end
    end
    self.lines = l;
    fs:SetText(msg or "");
    self.lineHeight = self.lineHeight + fs:GetHeight() + spc;
    local w = fs:GetWidth();
    if (w > self.lineWidth) then
        self.lineWidth = w;
        self:SetWidth(self.lineWidth + 15);
    end
    fs:Show();
    self:SetHeight(self.lineHeight + 15);
end

function visMethods:Free()
    if (self.inFreePool) then
        message("visFrame:Free() called on free frame!");
        return;
    end
    self:UnregisterAllEvents();
    self:Hide();
    for h in pairs(self.handlers) do
        self:SetScript(h, nil);
    end

    for k,v in pairs(self) do
        if (not visMethods[k]) then
            self[k] = nil;
        end
    end

    self.inFreePool = true;
    self:SetClampedToScreen(false);
    table.insert(freePool, self);
end

local function createNewVisFrame()
    local n = lastIndex + 1;
    lastIndex = n;
    local visFrame = CreateFrame("Frame", "DevToolsVisFrame" .. n, UIParent);
    visFrame:SetFrameStrata("TOOLTIP");
    visFrame:SetWidth(100);
    visFrame:SetHeight(200);
    visFrame:ClearAllPoints();
    visFrame:SetPoint("CENTER", "UIParent", "CENTER");
    visFrame:SetBackdrop({bgFile = "Interface/Tooltips/UI-Tooltip-Background",
                             edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
                             tile = true, tileSize = 16, edgeSize = 16,
                             insets = { left = 5, right = 5,
                                 top = 5, bottom = 5 }}
                     );
    visFrame:SetBackdropBorderColor(0.0,0.8,0.0,1.0);
    visFrame:SetBackdropColor(0.2,0.2,0.2,1.0);
    visFrame:Hide();
    visFrame:SetFrameLevel(2);

    visFrame.fontStrings = {}
    visFrame.lines = 0;
    visFrame.lineHeight = 0;
    visFrame.lineWidth = 0;
    visFrame.lineSpacing = 1;

    visFrame.handlers = {};
    local oldSetScript = visFrame.SetScript;
    function visFrame:SetScript(handler, script, ...)
        if (script ~= nil) then
            self.handlers[handler] = true;
        else
            self.handlers[handler] = nil;
        end
        return oldSetScript(self, handler, script, ...);
    end

    for k,v in pairs(visMethods) do
        if (type(v) == "function") then
            visFrame[k] = v;
        end
    end

    visFrame:EnableMouse(true);

    return visFrame;
end

function DT:GetVisFrame()
    local fp = table.getn(freePool);
    if (fp == 0) then
        return createNewVisFrame();
    end
    local vf = table.remove(freePool);
    vf.inFreePool = false;
    return vf;
end

local cornerVisMethods = {};

function cornerVisMethods:OnEnter(...)
    self:OnShow();
end

function cornerVisMethods:OnShow(...)
    local parent = self:GetParent() or UIParent;
    local ps = parent:GetEffectiveScale();
    local px, py = parent:GetCenter();
    px, py = px * ps, py * ps;
    local x, y = GetCursorPosition();
    self:ClearAllPoints();
    if (x > px) then
        if (y > py) then
            self:SetPoint("BOTTOMLEFT", parent, "BOTTOMLEFT", 20, 20);
        else
            self:SetPoint("TOPLEFT", parent, "TOPLEFT", 20, -20);
        end
    else
        if (y > py) then
            self:SetPoint("BOTTOMRIGHT", parent, "BOTTOMRIGHT", -20, 20);
        else
            self:SetPoint("TOPRIGHT", parent, "TOPRIGHT", -20, -20);
        end
    end
end


function DT:GetCornerVisFrame()
    local visFrame = DT:GetVisFrame();

    for k,v in pairs(cornerVisMethods) do
        visFrame[k] = v;
    end

    visFrame:SetScript("OnShow", function(self, ...) self:OnShow(...) end);
    visFrame:SetScript("OnEnter", function(self, ...) self:OnEnter(...) end);

    return visFrame;
end
