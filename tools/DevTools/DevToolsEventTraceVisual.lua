------------------------------------------------------------------------------
-- DevToolsEventTraceVisual.lua
--
-- Visual display for DevTools Event Trace
--
-- Written by Iriel, Updates by Kirov
--
-- Globals: DevTools
---------------------------------------------------------------------------

local DT = DevTools;

local function print(...)
    DEFAULT_CHAT_FRAME:AddMessage("[DTETV] " .. strconcat(...));
end

---------------------------------------------------------------------------

local ON_UPDATE_COLOR = "|cffcccc88";

local SPECIAL_NAMES = {
    [" _OnUpdate"] = "OnUpdate";
    [" _Stop"] = "Stop";
    [" _Start"] = "Start";
};

local function EVENT_TREE_GET_PARENT(entryName, isHeader)
    if (not isHeader) then
        return entryName;
    end

    local pname = entryName:match("^(.+)_");
    if (pname == " ") then
        return pname, "*Special Entries*";
    end
    return pname;
end

local EVENT_TREE = DT:CreateTreeList(EVENT_TREE_GET_PARENT);

local function EventTree_NewEvent(tree, event)
    EVENT_TREE[event] = SPECIAL_NAMES[event] or event;
end

DT:AddEventRegistry(EVENT_TREE, EventTree_NewEvent, true);

local function EventTree_Deriver(filterlist, event)
    local tree = filterlist:_GetMeta("eventTree");
    local entry = tree[event];
    if (not entry) then
        -- Should never happen, but just in case
        return false;
    end

    local parent = tree[entry.pidx];
    while (parent) do
        local pentry = tree[parent]
        local idx = pentry.idx;
        local size = pentry.size;
        local any;
        local anyOff;
        for i = idx + 1, idx + size do
            local ev = tree[i];
            local val = rawget(filterlist, ev);
            if (val ~= nil) then
                any = true;
                if (not val) then
                    anyOff = true;
                    break;
                end
            end
        end

        if (any) then
            return not anyOff;
        end

        -- If we fall through then this event was no good, try the
        -- next parent up if there is one.

        if (parent == "!") then
            return true;
        end

        parent = tree[pentry.pidx];
    end

    return true;
end

---------------------------------------------------------------------------

local EVKEYS = {
    "time",
    "event",
    "arg1", "arg2", "arg3", "arg4", "arg5",
    "arg6", "arg7", "arg8", "arg9"
};

for k, v in ipairs(EVKEYS) do
    EVKEYS[v] = k;
end

local function EVKEYS_Index(t, k)
    if (tonumber(k) and k > 3) then
        local r = "arg" .. (k - 2);
        t[k] = r;
        t[r] = k;
        return r;
    end
end

setmetatable(EVKEYS, { __index = EVKEYS_Index; } );

local READ_CLOSURES = DT:GetEventEntryReadClosureTable();
local WRITE_CLOSURES = DT:GetEventEntryWriteClosureTable();

local select = select;
local maxN = 0;
local function ExpandEventData(evData, ...)
    local N = select('#', ...);
    WRITE_CLOSURES[N](evData, ...);
    evData[0] = N;
    if (N > maxN) then
        for i = maxN + 1, N do
            local _ = EVKEYS[i]; -- Force expansion
        end
        maxN = N;
    end
    return N;
end

local function RemapEventDataIndex(t, k)
    if (type(k) == "string") then
        local N = t[0];
        local idx = EVKEYS[k];
        if (idx) then
            if (idx > N) then
                return nil;
            else
                return t[idx];
            end
        end
    end

    return nil;
end

local EXTRA_LINE_PREFIX = "    |cffcccccc";

local function appendField(frame, label, first, ...)
    frame:AddLine(label .. "=" .. tostring(first));
    for i = 1, select('#', ...) do
        local line = select(i, ...);
        if (line) then
            frame:AddLine( EXTRA_LINE_PREFIX .. tostring(line) );
        end
    end
end

local evData = {};
setmetatable(evData, { __index = RemapEventDataIndex } );

local function PopulateEventDetails(VF, pool, id)
    local evCount = ExpandEventData(evData, pool:Get(id));

    VF:Clear();

    local standardFormats = DT:GetEventTraceStandardFormats();

    if (evCount < 2) then
        VF:AddLine("|cffff0000Event no longer in buffer|r");
        VF:Show();
        return;
    end

    local eventType = evData[2] or "";
    local override = DT:GetEventFormat(eventType, evData, EVKEYS);

    local special = override and override._special;
    local labelFunc = override and override._labelFunc;
    local formatFunc = override and override._formatFunc;
    local formats = override and override._formats;

    VF:AddLine("DevTools Trace #" .. id);

    for i = 1, evCount do
        local lbl = EVKEYS[i] or tostring(i);
        local origLbl = lbl;
        local newLbl = lbl;
        if (override) then
            newLbl = nil;
            if (labelFunc) then
                newLbl = labelFunc(origLbl, evData, EVKEYS);
            end
            if (not newLbl) then
                newLbl = override[lbl];
            end
            if (newLbl) then
                newLbl = tostring(newLbl);
                if (special) then
                    lbl = newLbl;
                else
                    lbl = lbl .. " (" .. newLbl .. ")";
                end
            else
                newLbl = lbl;
            end
        end
        local formatter;
        if (formatFunc) then
            formatter = formatFunc(origLbl, newLbl, evData, EVKEYS);
        end
        if (not formatter and formats) then
            formatter = formats[newLbl];
        end
        if (not formatter) then
            formatter = standardFormats[newLbl];
        end
        local data = evData[i];
        local dt = type(data);
        appendField(VF, lbl, formatter(data));
    end
    VF:Show();
end

local ETVIS = {};

ETVIS.meta = { __index = ETVIS; }

local ETVFONT = CreateFont("DevToolsEventTraceFont");
ETVFONT:SetFontObject("NumberFontNormalSmall");
ETVFONT:SetShadowOffset(0,0);
ETVFONT:SetShadowColor(0,0,0,1);
local font, size, flags = ETVFONT:GetFont();
ETVFONT:SetFont(font, 10, nil);

local function ETVIS_Button_OnClick(self)
    local idx = self.evid;
    local parent = self:GetParent();

    parent.object:SelectEvent(idx);
end

local function ETVIS_Button_OnEnter(self)
    local parent = self:GetParent();
    local hl = parent.highlight;
    hl:SetParent(self);
    hl:SetPoint("TOPLEFT", self, "TOPLEFT", 0, 1);
    hl:SetPoint("BOTTOMLEFT", self, "BOTTOMLEFT", 0, 0);
    hl:Show();
end

local function ETVIS_Button_OnLeave(self)
    local parent = self:GetParent();
    parent.highlight:Hide();
end

local function ETVIS_CreateButton(parent, width, height, rowPad,
                                  timeWidth, colPad)
    local b = CreateFrame("Button", nil, parent);
    b:RegisterForClicks("LeftButtonUp", "RightButtonUp");
    b:SetScript("OnClick", ETVIS_Button_OnClick);
    b:SetScript("OnEnter", ETVIS_Button_OnEnter);
    b:SetScript("OnLeave", ETVIS_Button_OnLeave);
    b:SetHeight(height + rowPad);
    b:SetWidth(width);

    local t = b:CreateFontString(nil, "ARTWORK");
    t:SetFontObject(ETVFONT);
    t:SetWidth(timeWidth);
    t:SetJustifyH("RIGHT");
    t:SetPoint("TOPLEFT", b, "TOPLEFT", 0, 0);
    t:SetPoint("BOTTOMRIGHT", b, "TOPLEFT", timeWidth, -height);
    t:Show();
    b[1] = t;

    t = b:CreateFontString(nil, "ARTWORK");
    t:SetFontObject(ETVFONT);
    t:SetJustifyH("LEFT");
    t:SetWidth(width - timeWidth - colPad);
    t:SetPoint("TOPLEFT", b, "TOPLEFT", timeWidth + colPad, 0);
    t:SetPoint("BOTTOMRIGHT", b, "BOTTOMRIGHT", 0, 0);
    t:Show();
    b[2] = t;

    return b;
end

function ETVIS:Init(name, parent)
    local frame = CreateFrame("Frame", name, parent);
    self.frame = frame;
    frame.object = self;

    frame:SetScale(1.0);
    frame:SetWidth(300);
    frame:SetHeight(600);

    self.titleHeight = 20;
    self.dataHeight  = 11;
    self.dataPad     = 1;
    self.timeWidth   = 80;
    self.colPad      = 5;

    frame:ClearAllPoints();
    frame:SetPoint("TOPLEFT", parent, "TOPLEFT", 20, -20);
    frame:SetToplevel(true);
    frame:SetMovable(true);
    frame:EnableMouse(true);
    frame:EnableMouseWheel(true);

    frame:SetAlpha(0.7);

    frame.bg = frame:CreateTexture(nil, "BACKGROUND");
    frame.bg:SetAllPoints(frame);
    frame.bg:SetTexture(0.0, 0.0, 0.0);
    frame.bg:SetAlpha(0.9);

    frame.title = frame:CreateTitleRegion();
    frame.title:ClearAllPoints();
    frame.title:SetPoint("TOPLEFT", frame, "TOPLEFT", 0, 0);
    frame.title:SetPoint("BOTTOMRIGHT",
                         frame, "TOPRIGHT", 0, -self.titleHeight);

    frame.titlebg = frame:CreateTexture(nil, "BORDER");
    frame.titlebg:SetPoint("TOPLEFT", frame, "TOPLEFT", 0, 0);
    frame.titlebg:SetPoint("BOTTOMRIGHT",
                           frame, "TOPRIGHT", 0, -self.titleHeight);
    frame.titlebg:SetTexture(1.0, 1.0, 1.0);

    frame.titletext = frame:CreateFontString(nil, "OVERLAY");
    frame.titletext:SetFontObject("GameFontNormal");
    frame.titletext:SetAllPoints(frame.titlebg);

    frame.titletext:SetText("DevTools EventTrace");


    local timeWidth = self.timeWidth;
    local colPad = self.colPad;
    local frameWidth = 300;
    local scrollbarWidth = 16;
    local scrollbuttonHeight = 16;
    local rows = math.floor((frame:GetHeight() - self.titleHeight - self.dataPad)
                            / (self.dataHeight + self.dataPad));

    self.rows = rows;
    self.colA = {};
    for i=1,rows do
        local b = ETVIS_CreateButton(frame,
                                     frameWidth - colPad*3 - scrollbarWidth,
                                     self.dataHeight, self.dataPad,
                                     timeWidth, colPad);
        if (i == 1) then
            b:SetPoint("TOPLEFT", frame,
                       "TOPLEFT", colPad, -(self.titleHeight + self.dataPad));
        else
            b:SetPoint("TOPLEFT", self.colA[i-1], "BOTTOMLEFT",
                       0, 0);
        end
        self.colA[i] = b;

        b:Show();
    end

    local sb = CreateFrame("Slider", name .. "Scroll", frame);
    local sbt = sb:CreateTexture();
    sbt:SetTexture("Interface\\Buttons\\UI-ScrollBar-Knob");
    sbt:SetTexCoord(0.25, 0.75, 0.25, 0.75);
    sbt:SetWidth(scrollbarWidth);
    sbt:SetHeight(scrollbarWidth);
    sb:SetThumbTexture(sbt);
    sb:SetValueStep(1);
    sb:SetWidth(scrollbarWidth);

    sb:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -colPad, -self.titleHeight -self.dataPad);
    sb:SetHeight(self.rows * (self.dataHeight + self.dataPad) - self.dataPad);
    sb:SetScript("OnValueChanged", nil);
    sb:SetOrientation("VERTICAL");

    local sbb = sb:CreateTexture(nil, "BACKGROUND");
    sbb:SetTexture(0.3, 0.3, 0.5);
    sbb:SetAlpha(0.25);
    sbb:SetAllPoints(sb);
    sbb:Show();

    self.scrollbar = sb;

    local hl = frame:CreateTexture(nil,"MEDIUM");
    hl:SetHeight(1);
    hl:SetWidth(frameWidth - colPad * 2);
    hl:SetTexture(0.2, 0.3, 0.6);
    -- hl:SetGradientAlpha("HORIZONTAL", 1, 1, 1, 0.1, 1, 1, 1, 0 ); -- Not visible enough
    hl:SetAlpha(0.5);
    hl:Hide();
    frame.highlight = hl;

    hl = frame:CreateTexture(nil,"HIGH");
    hl:SetWidth(frameWidth - colPad * 2);
    hl:SetHeight(1);
    hl:SetTexture(0.6, 0.2, 0.0);
    hl:SetAlpha(0.8);
    hl:Hide();
    self.selhighlight = hl;

    frame.closebutton = CreateFrame("BUTTON", nil, frame, "UIPanelCloseButton");
    frame.closebutton:SetPoint("TOPRIGHT", frame, "TOPRIGHT", 4, 6);

    self.filter = DT.EventTraceStateList:New();
    self.filter:_SetMeta("eventTree", EVENT_TREE);
    self.filter:_SetDeriveFunction(EventTree_Deriver);
    self.filter:_AddListener(self, "OnFilterChanged");
    self.filter:_Notify();

    self:InitOptions(frame);

    frame:SetScript("OnUpdate", function(x, ...) self:OnUpdate(...); end);
    frame:SetScript("OnShow", function(f,...) f.object:OnShow(...); end);
    frame:SetScript("OnHide", function(f,...) f.object:OnHide(...); end);
    frame:SetScript("OnKeyDown",
                    function(f, ...) f.object:OnKeyDown(...); end);
    frame:SetScript("OnKeyUp",
                    function(f, ...) f.object:OnKeyUp(...); end);
    frame:SetScript("OnMouseWheel",
                    function(f, ...) f.object:OnMouseWheel(...); end);

    frame:Show();
end

function ETVIS:New(name, parent)
    local obj = {};
    setmetatable(obj, self.meta);
    obj:Init(name, parent);
    return obj;
end

function ETVIS:OnFilterChanged()
    self.needUpdate = "filter";
end

function ETVIS:OnMouseWheel(delta)
    local scroll = self.scrollbar;
    local min, max = scroll:GetMinMaxValues();
    local val = scroll:GetValue();
    local nval = val - delta * 5;
    if (nval < min) then
        nval = min;
    elseif (nval > max) then
        nval = max;
    end
    if (nval ~= val) then
        scroll:SetValue(nval);
    end
end

function ETVIS:Update(pool)
    local firstId, lastId = pool:GetIDRange();
    local lastScroll = self.lastScroll;
    local curScroll = math.ceil(self.scrollbar:GetValue() or 0);

    local realFirstId = firstId;
    -- firstId = firstId + self.rows - 1;

    local forcedMove = false;

    if (firstId >= lastId) then
        self.scrollbar:SetMinMaxValues(firstId - 1, lastId);
    else
        self.scrollbar:SetMinMaxValues(firstId, lastId);
    end
    if (curScroll < firstId) then
        curScroll = firstId;
        self.scrollbar:SetValue(curScroll);
        forcedMove = true;
    elseif (curScroll > lastId) then
        curScroll = lastId;
        self.scrollbar:SetValue(curScroll);
        forcedMove = true;
    end

    if (self.selected_index) then
        local sel = self.selected_index;
        if (sel < realFirstId) then
            sel = nil;
            self:SelectEvent(nil);
        else
            if (forcedMove and self.selhighlight:IsShown()) then
                self.forceOnScreen = true;
            end
        end
    end

    local rowdata = self.rowdata;
    if (not rowdata) then
        rowdata = {};
        self.rowdata = rowdata;
    end

    if (self.lastEventId ~= lastId) then
        if (lastScroll == self.lastEventId) then
            if (not self.selected_index) then
                curScroll = lastId;
                self.scrollbar:SetValue(curScroll);
                self.needUpdate = "autoscrolled";
            end
        end
        if (lastId > (self.lastShownId or 0)) then
            self.needUpdate = "expired";
        end
        self.lastEventId = lastId;
        -- If the window isn't full yet then we need to update it
        if (not rowdata[0]) then
            self.needUpdate = "notfull";
        end
    end

    if (curScroll ~= lastScroll) then
        self.needUpdate = "scrolled";
        self.lastScroll = curScroll;
    end

    if (self.needUpdate) then
        --print("Doing visual update... ",self.needUpdate,
        --" ", tostring(curScroll));
        self.needUpdate = nil;
        local row = self.rows;
        local index = curScroll + 1;
        local filter = self.filter;
        while (row >= 0) do
            while (index > 0) do
                index = index - 1;
                local t, ev, a1 = pool:Get(index);
                if (not t) then
                    index = 0;
                    break;
                end
                if (filter[ev]) then
                    rowdata[row] = index;
                    row = row - 1;
                    break;
                end
            end
            if (index <= 0) then
                rowdata[row] = 0;
                row = row - 1;
            end
        end

        local selindex = self.selected_index;
        local selbutton = nil;
        local selmatch = false;

        if (not selindex) then
            selbutton = -1;
        end

        self.lastShownId = nil;
        local lastShownId = nil;

        local lt = nil;
        local tfmt = nil
        local colA = self.colA;
        for i=0,self.rows do
            local idx = rowdata[i];
            local t, ev, a1, a2 = pool:Get(idx);
            local b = colA[i];

            if (idx and not selbutton and selindex <= idx) then
                selbutton = i;
                if (idx == selindex) then
                    selmatch = true;
                end
            end

            if (not t) then
                if (b) then
                    b:Hide();
                    b.evid = 0;
                end
            else
                if (not lastShownId) then
                    lastShownId = idx;
                    self.lastShownId = idx;
                end

                if (ev == " _OnUpdate") then
                    if (b) then
                        b[1]:SetText(ON_UPDATE_COLOR .. ev .. "|r");
                        b[2]:SetText(ON_UPDATE_COLOR ..
                                     string.format("%s (%d frame(s))", a1, a2)
                                         .. "|r");
                        b.evid = idx;
                        b:Show();
                    end
                else
                    local fmt;
                    if (t == lt) then
                        fmt = "|c888888cc%s|r";
                    else
                        fmt = "%s";
                        lt = t;
                        local s = t;
                        local m = math.floor(math.floor(s) / 60);
                        local h = math.floor(m / 60);
                        s = s - 60 * m;
                        m = m - 60 * h;
                        h = h % 100;
                        tfmt = string.format("%.2d:%.2d:%06.3f", h, m, s);
                    end
                    if (b) then
                        b[1]:SetText(string.format(fmt,tfmt));
                        b[2]:SetText(ev);
                        b:Show();
                        b.evid = idx;
                    end
                end
            end
        end

        if (selbutton == 0) then
            selbutton = 1;
            selmatch = false;
        end
        local hl = self.selhighlight;
        if (selbutton == -1) then
            hl:Hide();
        elseif (not selbutton) then
            local b = colA[self.rows];
            hl:SetParent(b);
            hl:SetPoint("TOPLEFT", b, "BOTTOMLEFT", 0, 3);
            hl:SetPoint("BOTTOMLEFT", b, "BOTTOMLEFT", 0, -2);
            hl:Show();
        elseif (selmatch) then
            local b = colA[selbutton];
            hl:SetParent(b);
            hl:SetPoint("TOPLEFT", b, "TOPLEFT", 0, 1);
            hl:SetPoint("BOTTOMLEFT", b, "BOTTOMLEFT", 0, 0);
            hl:Show();
        else
            local b = colA[selbutton];
            hl:SetParent(b);
            hl:SetPoint("TOPLEFT", b, "TOPLEFT", 0, 3);
            hl:SetPoint("BOTTOMLEFT", b, "TOPLEFT", 0, -2);
            hl:Show();
        end
    end

    self:UpdateKeyboardFocus();
end

function ETVIS:InitOptions(frame)
    frame.options = CreateFrame("BUTTON", nil, frame);
    frame.options:SetNormalFontObject(GameFontNormal);
    frame.options:SetHighlightFontObject(GameFontHighlight);
    frame.options:SetWidth(20);
    frame.options:SetHeight(20);
    frame.options:SetText("?");
    frame.options:SetPoint("TOPLEFT", frame, "TOPLEFT", 0, 0);
    frame.options:SetScript("OnClick", function()
                                           if ( not self.options ) then
                                               self.options = DT.EventTraceOptions:New(self.frame, self.filter);
                                           else
                                               self.options.frame:Show();
                                           end
                                       end
                        );
end

function ETVIS:UpdateKeyboardFocus()
    local selected = false;
    local frame = self.frame;
    local focus = GetMouseFocus();
    if (not self.selected_index) then
        selected = false;
    elseif (focus == frame) then
        selected = true;
    elseif (focus and focus:GetParent() == frame) then
        selected = true
    end

    if (selected ~= self.hasFocus) then
        self.hasFocus = selected;
        if (selected) then
            frame.titlebg:SetGradientAlpha("VERTICAL",
                                           0.7, 0.2, 0.1,   1.0,
                                           1.0, 0.4, 0.2,   1.0 );
            frame:EnableKeyboard(true);
        else
            frame.titlebg:SetGradientAlpha("VERTICAL",
                                           0.5, 0.5, 0.5,   0.5,
                                           1.0, 1.0, 1.0,   1.0 );
            frame:EnableKeyboard(false);
        end
    end
end

function ETVIS:OnShow()
    self.needUpdate = "onshow";
    self:Update(DT:GetEventTracePool());
    if (self.selected_index and self.visframe) then
        self.visframe:Show();
    end
end

function ETVIS:OnHide()
    if (self.visframe) then
        self.visframe:Hide();
    end
end


function ETVIS:OnUpdate(elapsed)
    self:Update(DT:GetEventTracePool());
end

function ETVIS:OnKeyUp(key)
end

function ETVIS:FindNextIndex(idx, direction, filter)
    if (not idx) then
        return;
    end
    local pool = DT:GetEventTracePool();
    local lo, hi = pool:GetIDRange();
    local incr = 1;
    if (direction < 0) then
        incr = -1;
        if (idx > hi) then
            idx = hi;
        else
            idx = idx - 1;
        end
    else
        if (idx < lo) then
            idx = lo;
        else
            idx = idx + 1;
        end
    end

    while ((idx >= lo) and (idx <= hi)) do
        if (not filter or filter(self, pool, idx)) then
            return idx;
        end
        idx = idx + incr;
    end
end

local function filterByFilter(self, pool, idx)
    local t, ev, a1 = pool:Get(idx);
    if (ev and self.filter[ev]) then
        return true;
    end
end

local function filterByName(self, pool, idx)
    local t, ev, a1 = pool:Get(idx);
    if (ev and ev == self.findName) then
        return true;
    end
end

function ETVIS:OnKeyDown(key)
    if (key == "ESCAPE") then
        if (self.selected_index) then
            self:SelectEvent(nil);
        else
            self.frame:Hide();
        end
        return;
    end

    if ((key == "UP") or (key == "DOWN")) then
        local dir = 1;
        if (key == "UP") then
            dir = -1;
        end

        local idx = self.selected_index;
        if (idx) then
            local filterFunc = filterByFilter;
            if (IsShiftKeyDown()) then
                filterFunc = nil;
            elseif (IsControlKeyDown()) then
                local t, ev = DT:GetEventTracePool():Get(idx);
                self.findName = ev;
                filterFunc = filterByName;
            end
            idx = self:FindNextIndex(idx, dir, filterFunc);
            if (idx) then
                self:SelectEvent(idx, true);
            else
                PlaySound("igAbilityClose");
            end
        end
        return;
    end

    if (key == "PAGEUP") then
        self.scrollbar:SetValue(self.scrollbar:GetValue() - self.rows + 1);
        return;
    end

    if (key == "PAGEDOWN") then
        self.scrollbar:SetValue(self.scrollbar:GetValue() + self.rows - 1);
        return;
    end

    if (key == "HOME") then
        local min, max = self.scrollbar:GetMinMaxValues();
        self.scrollbar:SetValue(min);
        return;
    end

    if (key == "END") then
        local min, max = self.scrollbar:GetMinMaxValues();
        self.scrollbar:SetValue(max);
        return;
    end

end

local function GetFrameBorders(frame, relframe)
    if (not relframe) then relframe = frame:GetParent(); end
    local fs = frame:GetEffectiveScale();
    local rs = relframe:GetEffectiveScale();
    local fl,fb,fw,fh = frame:GetRect();
    local rl,rb,rw,rh = relframe:GetRect();
    fs = fs / rs;

    fl, fb, fw, fh = fl/fs, fb/fs, fw/fs, fh/fs;

    local lgap = (fl - rl) / rw;
    local rgap = ((rl + rw) - (fl + fw)) / rw;

    return lgap, rgap;
end

function ETVIS:SelectEvent(idx, onScreen)
    if (self.selected_index ~= idx) then
        self.needUpdate = "selection";
    end

    self.selected_index = idx;

    if (idx) then
        if (onScreen) then
            self.forceOnScreen = true;
        end
        local frame = self.frame;
        local visframe = self.visframe;

        if (not visframe) then
            visframe = DT:GetVisFrame();
            self.visframe = visframe;
        end

        visframe:SetClampedToScreen(true);
        visframe:ClearAllPoints();

        -- Determine which side of the frame has a larger gap..
        local lgap, rgap = GetFrameBorders(frame);

        if (rgap >= lgap * 0.9) then
            visframe:SetPoint("TOPLEFT", self.selhighlight, "TOPRIGHT", 0, 0);
        else
            visframe:SetPoint("TOPRIGHT", self.selhighlight, "TOPLEFT", 0, 0);
        end

        PopulateEventDetails(visframe, DT:GetEventTracePool(), idx);
    else
        self.forceOnScreen = nil;
        if (self.visframe) then
            self.visframe:Hide();
        end
    end
end



DT.EventTraceVisualizer = ETVIS;
