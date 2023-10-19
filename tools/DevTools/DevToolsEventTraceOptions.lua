------------------------------------------------------------------------------
-- DevToolsEventTraceOptions.lua
--
-- Options frame for event trace
--
-- Written by Kirov, Refactoring by Iriel
--
-- Globals: DevTools, FauxScrollFrame_GetOffset, FauxScrollFrame_Update
-- Globals: FauxScrollFrame_OnVerticalScroll, DevToolsEventTraceFont
---------------------------------------------------------------------------

DevTools_Events = {};

local DT = DevTools;
local ETOPT = {};

ETOPT.meta = { __index = ETOPT; }

local maxIndex = 24;

local ETVFONT = DevToolsEventTraceFont;

local function ETOPT_Button_OnEnter(self)
    local parent = self:GetParent();
    parent.highlight:SetPoint("TOPLEFT", self, "TOPLEFT");
    parent.highlight:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT");
    parent.highlight:Show();
end

local function ETOPT_Button_OnLeave(self)
    local parent = self:GetParent();
    parent.highlight:Hide();
end

local function ETOPT_OnUpdate(self, arg1)
    self.object:_Update();
end

---------------------------------------------------------------------------
local function getSubEventsState(treeList, filter, entry)
    local any, all = false, true;
    for i = entry.idx + 1, entry.idx + entry.size do
        local id = treeList[i];
        local ent = treeList[id]
        if (not ent.header) then
            if (filter[id]) then
                if (not all) then
                    return true, false;
                end
                any = true;
            else
                if (any) then
                    return true, false;
                end
                all = false;
            end
        end
    end
    return any, all and any;
end

local function setSubEventsState(treeList, filter, entry, value)
    for i = entry.idx + 1, entry.idx + entry.size do
        local id = treeList[i];
        local ent = treeList[id]
        if (not ent.header) then
            if (filter[id] ~= value) then
                filter:_Set(id, value);
            end
        end
    end
end

local function setSubHeadersCollapsed(treeList, self, entry, value)
    value = (value and true) or nil;
    local changes = nil;
    local collapsed = self.collapsed;

    for i = entry.idx, entry.idx + entry.size do
        local id = treeList[i];
        local ent = treeList[id]
        if (ent.header) then
            if (collapsed[id] ~= value) then
                collapsed[id] = value;
                changes = true;
            end
        end
    end
    if (changes) then
        self:_Refresh();
    end
end

local function getAllEventsState(treeList, filter, ignoreEntry)
    local imin, imax = -1, -1;
    if (ignoreEntry) then
        if (ignoreEntry.header) then
            imin = ignoreEntry.idx;
            imax = ignoreEntry.idx + ignoreEntry.size;
        else
            imin = ignoreEntry.idx;
            imax = imin;
        end
    end

    local any, all = false, true;
    local n = treeList['#'];
    for i = 1,n do
        if ((i < imin) or (i > imax)) then
            local id = treeList[i];
            local ent = treeList[id]
            if (not ent.header) then
                if (filter[id]) then
                    if (not all) then
                        return true, false;
                    end
                    any = true;
                else
                    if (any) then
                        return true, false;
                    end
                    all = false;
                end
            end
        end
    end
    return any, all and any;
end

local function setAllEventsState(treeList, filter, value, invertEntry)
    local imin, imax = -1, -1;
    if (invertEntry) then
        if (invertEntry.header) then
            imin = invertEntry.idx;
            imax = invertEntry.idx + invertEntry.size;
        else
            imin = invertEntry.idx;
            imax = imin;
        end
    end

    local n = treeList['#'];
    for i=1, n do
        local id = treeList[i];
        local entry = treeList[id];
        if (not entry.header) then
            local newvalue = value;
            if ((i >= imin) and (i <= imax)) then
                newvalue = not newvalue;
            end
            if (filter[value] ~= newvalue) then
                filter:_Set(id, newvalue);
            end
        end
    end
end

---------------------------------------------------------------------------

local function GetButtonTexture(button, type)
    local setfuncname = "Set" .. type .. "Texture";
    local funcname = "Get" .. type .. "Texture";
    button[setfuncname](button, button:CreateTexture());

    return button[funcname](button);
end

local function buildScrollLine(self,i)
    local button = CreateFrame("BUTTON", nil, self.frame);
    button.owner = self;
    button:SetWidth(482);
    button:SetHeight(16);

    button:SetFrameLevel(self.frame:GetFrameLevel() + 1);

    local normal = GetButtonTexture(button, 'Normal');
    normal:SetTexture("Interface\\Buttons\\UI-MinusButton-UP");
    normal:SetWidth(16);
    normal:SetHeight(16);
    normal:ClearAllPoints();
    normal:SetPoint("LEFT", button, "LEFT", 3, 0);

    local highlight = GetButtonTexture(button, 'Highlight');
    highlight:SetTexture("Interface\\Buttons\\UI-PlusButton-Hilight");
    highlight:SetBlendMode("ADD");
    highlight:SetWidth(16);
    highlight:SetHeight(16);
    highlight:ClearAllPoints();
    highlight:SetPoint("LEFT", button, "LEFT", 3, 0);

    local disabled = GetButtonTexture(button, 'Disabled');
    disabled:SetTexture("Interface\\Buttons\\UI-PlusButton-Disabled");
    disabled:SetBlendMode("ADD");
    disabled:SetWidth(16);
    disabled:SetHeight(16);
    disabled:ClearAllPoints();
    disabled:SetPoint("LEFT", button, "LEFT", 3, 0);

    local text = button:CreateFontString();
    button:SetFontString(text);
    text = button:GetFontString();
    text:SetHeight(13);
    text:ClearAllPoints();
    text:SetPoint("LEFT", highlight, "RIGHT", 2, 1);

    local subtext = button:CreateFontString(nil, "BACKGROUND");
    subtext:SetFontObject(ETVFONT);
    subtext:ClearAllPoints();
    subtext:SetPoint("LEFT", text, "LEFT", -6, 0);


    button:RegisterForClicks("LeftButtonUp", "RightButtonUp");
    local enable = CreateFrame("CheckButton", nil,
                                button, "UICheckButtonTemplate");
    enable.button = button;
    enable:SetWidth(24);
    enable:SetHeight(24);
    enable:SetHitRectInsets(3,3,4,4);
    enable:SetPoint("TOPRIGHT", highlight, "TOPLEFT",3,4);
    enable:SetScript("OnClick",
                     function(e)
                         local button = e.button;
                         button.owner:EntryCheckOnClick(button.evid)
                     end );
    button.enable = enable;

    button:SetNormalFontObject(NumberFontNormal);
    button:SetHighlightFontObject(NumberFontNormal);
    button:SetDisabledFontObject(GameFontDisable);

    button.subtext = subtext;
    button.normal = normal;
    button.highlight = highlight;
    button.disabled = disabled;
    button.text = text;

    button:SetScript("OnClick",function(b) b.owner:EntryOnClick(b.evid) end);
    button:SetScript("OnEnter",ETOPT_Button_OnEnter);
    button:SetScript("OnLeave",ETOPT_Button_OnLeave);
    button:SetID(i);
    button:Show();
    return button;
end

local strgmatch = string.gmatch or string.gfind;

local onUpdateEntry = {title="OnUpdate",event=true,depth=1};
local stopEntry = {title="Stop",event=true,depth=1};
local startEntry = {title="Start",event=true,depth=1};

function ETOPT:EntryCheckOnClick(id)
    local filter = self.filter;
    local eventTree = filter:_GetMeta("eventTree");
    local entry = eventTree[id];

    if (not entry) then
        return;
    end

    if (not entry.header) then
        filter:_Set(id, not filter[id]);
        return;
    end

    local any, all = getSubEventsState(eventTree, filter, entry);
    setSubEventsState(eventTree, filter, entry, not all);
end

function ETOPT:EntryOnClick(id)
    local filter = self.filter;
    local eventTree = filter:_GetMeta("eventTree");
    local entry = eventTree[id];

    if (not entry) then
        return;
    end

    if (not entry.header) then
        if ( IsControlKeyDown() ) then
            if (filter[id]) then
                local any, all = getAllEventsState(eventTree, filter, entry);
                if (not any) then
                    setAllEventsState(eventTree, filter, true);
                    return;
                end
            end

            setAllEventsState(eventTree, filter, false, entry);
            return;
        end

        filter:_Set(id, not filter[id]);
        return;
    end

    if (IsShiftKeyDown()) then
        local any, all = getSubEventsState(eventTree, filter, entry);
        setSubEventsState(eventTree, filter, entry, not all);
        return;
    end

    if (IsControlKeyDown()) then
        local any, all = getSubEventsState(eventTree, filter, entry);
        if (all) then
            any, all = getAllEventsState(eventTree, filter, entry);
            if (not any) then
                setAllEventsState(eventTree, filter, true);
                return;
            end
        end
        setAllEventsState(eventTree, filter, false, entry);
        return;
    end

    if (IsAltKeyDown()) then
        self.collapsed[id] = (not self.collapsed[id]) or nil;
        self:_Refresh();
    else
        setSubHeadersCollapsed(eventTree, self, entry, not self.collapsed[id]);
    end
end

local function getEntryCount(treeList, collapsed, findIndex)
    local n = treeList['#'];
    local size = 1;
    local found = nil;
    local i = 0;
    while (i <= n) do
        local id = treeList[i];
        local entry = treeList[id];
        local skip;
        if (not entry.header) then
            skip = collapsed[treeList[entry.pidx]];
        end
        i = i + 1;
        if (not skip) then
            size = size + 1;
            if (size == findIndex) then
                found = i;
            end
        end
    end
    return size, found;
end


function ETOPT:UpdateList()
    local indexOffset = FauxScrollFrame_GetOffset(self.frame.scrollframe);
    local filter = self.filter;
    local eventTree = filter:_GetMeta("eventTree");
    local collapsed = self.collapsed;

    local num, firstIndex = getEntryCount(eventTree, collapsed,
                                          indexOffset + 1);
    if (not firstIndex) then
        firstIndex = 0;
    end

    local idx = firstIndex;

    local frame = self.frame;
    local maxIndex = #frame;

    for i=1, maxIndex do
        local id = eventTree[idx];
        local entry = id and eventTree[id];
        while (id and (not entry.header)
               and (collapsed[eventTree[entry.pidx]])) do
            idx = idx + 1;
            id = eventTree[idx];
            entry = id and eventTree[id];
        end
        idx = idx + 1;

        local button = frame[i];
        button.evid = id;

        if ( not id ) then
            button:Hide();
        else
            button:Show();
            local header = entry.header;
            if ( not header ) then
                button.enable:SetCheckedTexture("Interface\\Buttons\\UI-CheckBox-Check");
                if ( filter[id] ) then
                    button.enable:SetChecked(1);
                    button.subtext:SetTextColor(1,1,1);
                else
                    button.enable:SetChecked(0);
                    button.subtext:SetTextColor(0.8,0,0);
                end
            else
                local any, all = getSubEventsState(eventTree, filter, entry);
                if ( not any ) then
                    button.enable:SetChecked(0);
                    button.text:SetTextColor(0.4,0.4,0.4);
                elseif ( not all ) then
                    button.enable:SetCheckedTexture("Interface\\Buttons\\UI-CheckBox-Check-Disabled");
                    button.enable:SetChecked(1);
                    button.text:SetTextColor(1,0.82,0);
                else
                    button.enable:SetCheckedTexture("Interface\\Buttons\\UI-CheckBox-Check");
                    button.enable:SetChecked(1);
                    button.text:SetTextColor(1,0.82,0);
                end
            end

            local offset = 18 + (entry.depth or 0) * 16;
            button.normal:SetPoint("TOPLEFT", button, "TOPLEFT", offset, 1);
            button.disabled:SetPoint("TOPLEFT", button, "TOPLEFT", offset, 1);
            button.highlight:SetPoint("TOPLEFT", button, "TOPLEFT", offset, 1);

            if ( not header ) then
                button.subtext:SetText(entry.name);
                button:SetText("");
            else
                button:SetText(entry.name);
                button.subtext:SetText("");
            end

            if ( not header ) then
                button:SetNormalTexture("");
                button:SetHighlightTexture("");
            else
                button:SetHighlightTexture("Interface\\Buttons\\UI-PlusButton-Hilight");
                if ( collapsed[id] ) then
                    button:SetNormalTexture("Interface\\Buttons\\UI-PlusButton-UP");
                else
                    button:SetNormalTexture("Interface\\Buttons\\UI-MinusButton-UP");
                end
            end
        end
    end

    FauxScrollFrame_Update(self.frame.scrollframe, num, maxIndex, 16, nil, nil, nil, nil, 482, 506 );
end

function ETOPT:_ListCallback(list, addRemove)
    if (list == self.filter) then
        -- Prepare this to self-update as soon as necessary
        self:_Refresh(addRemove);
    end
end

function ETOPT:_Refresh()
    self.frame:SetScript("OnUpdate", ETOPT_OnUpdate);
end

function ETOPT:_Update()
    self.frame:SetScript("OnUpdate", nil);
    self:UpdateList();
end

function ETOPT:Init(parent, filter)
    if ( self.frame ) then
        self.frame:SetFrameLevel(parent:GetFrameLevel() + 1);
        self.frame:Show()
        return
    end;

    local name = parent:GetName();

    local optionsname;
    if ( name ) then
        optionsname = name.."Options";
    else
        optionsname = "ETVISOptions";
    end

    local frame = CreateFrame("FRAME",optionsname,UIParent);
    self.frame = frame;
    frame:SetFrameLevel(parent:GetFrameLevel() + 1);
    frame.object = self;
    frame:SetWidth(512);
    frame:SetHeight(412);
    frame:SetScale(0.75);
    frame:SetAlpha(0.7);
    frame:ClearAllPoints();
    frame:SetPoint("TOPLEFT",parent,"TOPRIGHT",4,0);
    frame:SetClampedToScreen(1);
    frame:SetToplevel(true);
    frame:EnableMouse(1);
    frame:SetMovable(1);

    local titleregion = frame:CreateTitleRegion();
    titleregion:SetPoint("TOPLEFT", frame, "TOPLEFT", 0, 0);
    titleregion:SetPoint("BOTTOMRIGHT", frame, "TOPRIGHT", 0, -20);

    frame.titlebg = frame:CreateTexture(nil, "BORDER");
    frame.titlebg:SetPoint("TOPLEFT", frame, "TOPLEFT", 0, 0);
    frame.titlebg:SetPoint("BOTTOMRIGHT",
                           frame, "TOPRIGHT", 0, -20);
    frame.titlebg:SetTexture(0.4, 0.4, 0.4);
    frame.titlebg:SetGradientAlpha("VERTICAL", 0.5, 0.5, 0.5, 0.5, 1, 1, 1, 1 );

    frame.titletext = frame:CreateFontString(nil, "OVERLAY");
    frame.titletext:SetFontObject("GameFontNormal");
    frame.titletext:SetAllPoints(frame.titlebg);
    frame.titletext:SetText("Select Events...");

    local closebutton = CreateFrame("BUTTON", nil, frame, "UIPanelCloseButton");
    closebutton:SetPoint("TOPRIGHT", frame, "TOPRIGHT", 4, 6);

    local texture = frame:CreateTexture(nil,"BACKGROUND");
    texture:SetTexture(0,0,0);
    texture:SetAlpha(0.95);
    texture:SetAllPoints();

    frame.highlight = frame:CreateTexture(nil,"ARTWORK");
    frame.highlight:SetPoint("TOPLEFT", frame, "TOPLEFT", 0, 0);
    frame.highlight:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", 0, 0);
    frame.highlight:SetTexture(1, 1, 1);
    frame.highlight:SetGradientAlpha("HORIZONTAL", 1, 1, 1, 0.1, 1, 1, 1, 0.02 );
    frame.highlight:Hide();

    for i=1, maxIndex do
        local button = buildScrollLine(self, i);
        if (i == 1) then
            button:SetPoint("TOPLEFT", frame, "TOPLEFT", 8, -24);
        else
            button:SetPoint("TOPLEFT", frame[i - 1], "BOTTOMLEFT", 0, 0);
        end
        frame[i] = button;
    end

    local scrollframename = optionsname.."Scroll";
    frame.scrollframe = CreateFrame("ScrollFrame", scrollframename,
                                    frame, "FauxScrollFrameTemplate");
    frame.scrollframe:SetWidth(482);
    frame.scrollframe:SetHeight(384);
    frame.scrollframe:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -26, -24);
    frame.scrollframe:SetScript("OnVerticalScroll",
                                function(fself, offset) FauxScrollFrame_OnVerticalScroll(fself, offset, 16, function() self:_Refresh() end) end );

    self.collapsed = {};

    if (not filter) then
        filter = DT.EventTraceStateList:New();
    end
    self.filter = filter;
    filter:_AddListener(self, "_ListCallback");
    self:_Refresh();
end

function ETOPT:New(parent, filter)
    local obj = {};
    setmetatable(obj, self.meta);
    obj:Init(parent, filter);
    return obj;
end

DT.EventTraceOptions = ETOPT;

