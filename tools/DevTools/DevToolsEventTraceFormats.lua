--------------------------------------------------------------------------------
-- DevToolsEventTraceFormats.lua
--
-- Special formats and labels for known events
--
-- Written by Iriel
--
-- Globals: DevTools, SPELL_POWER_*, SCHOOL_MASK_*
---------------------------------------------------------------------------

local DT = DevTools;

local FMT = DT:GetPackage("eventTraceFormatters");

local band = bit.band;
local rshift = bit.rshift;

local function ReplaceSpaceRun(spcs)
    local n = string.len(spcs);
    --return "|cffccccee<" .. string.len(spcs) .. " spaces>|r";
    return "|cff8888ee" .. string.rep('_', n) .. "|r";
end

function FMT.formatStandard(data)
    local dt = type(data);
    if (dt == "string") then
        local dl = string.len(data);
        local denc;
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
            dnext = string.gsub(dnext, "\r", "\\r");
            dnext = string.gsub(dnext, "  +", ReplaceSpaceRun);
            dnext = string.gsub(dnext, "^ ", ReplaceSpaceRun);
            dnext = string.gsub(dnext, " $", ReplaceSpaceRun);
            if (denc) then
                denc = denc .. "\n    ..\"" .. dnext .. "\"";
            else
                denc = "\"" .. dnext .. "\"";
            end
        end
        return denc;
    elseif (dt == "number") then
        return tostring(data);
    elseif (dt == "boolean") then
        return tostring(data);
    elseif (dt == "nil") then
        return "nil";
    elseif (dt ~= "nil") then
        return "<" .. dt .. ">";
    end
end

function FMT.formatTime(data)
    local s = data;
    local m = math.floor(math.floor(s) / 60);
    local h = math.floor(m / 60);
    s = s - 60 * m;
    m = m - 60 * h;
    h = h % 100;
    return string.format("%.2d:%.2d:%06.3f (%s)", h, m, s, data);
end

local HEX = { "0", "1", "2", "3", "4", "5", "6", "7", "8", "9",
    "A", "B", "C", "D", "E", "F" };

function FMT.formatHex(data)
    if (data == 0) then
        return "0x0 (0)";
    end
    local result = " (" .. data .. ")";
    while (data ~= 0) do
        local last = band(data, 15);
        data = rshift(data, 4);
        result = HEX[last + 1] .. result;
    end
    return "0x" .. result;
end

local function append(base, new)
    if (base) then
        return base .. " " .. new;
    else
        return new;
    end
end

function FMT.formatCombatSpellSchool(data)
    local base = FMT.formatHex(data);
    local desc = nil;

    if (data == SCHOOL_MASK_NONE) then
        desc = append(desc, "NONE");
    end
    if (band(data, SCHOOL_MASK_PHYSICAL) ~= 0) then
        desc = append(desc, "PHYSICAL");
    end
    if (band(data, SCHOOL_MASK_HOLY) ~= 0) then
        desc = append(desc, "HOLY");
    end
    if (band(data, SCHOOL_MASK_FIRE) ~= 0) then
        desc = append(desc, "FIRE");
    end
    if (band(data, SCHOOL_MASK_NATURE) ~= 0) then
        desc = append(desc, "NATURE");
    end
    if (band(data, SCHOOL_MASK_FROST) ~= 0) then
        desc = append(desc, "FROST");
    end
    if (band(data, SCHOOL_MASK_SHADOW) ~= 0) then
        desc = append(desc, "SHADOW");
    end
    if (band(data, SCHOOL_MASK_ARCANE) ~= 0) then
        desc = append(desc, "ARCANE");
    end
    if (desc) then
        desc = "SCHOOL: " .. desc;
    end
    return base, desc;
end

SPELL_POWER_MANA = 1
SPELL_POWER_RAGE = 2
SPELL_POWER_FOCUS = 3
SPELL_POWER_ENERGY = 4
SPELL_POWER_HAPPINESS = 5
SPELL_POWER_RUNES = 6

local POWER_TYPES = {
    [SPELL_POWER_MANA] = "MANA",
    [SPELL_POWER_RAGE] = "RAGE",
    [SPELL_POWER_FOCUS] = "FOCUS",
    [SPELL_POWER_ENERGY] = "ENERGY",
    [SPELL_POWER_HAPPINESS] = "HAPPINESS",
    [SPELL_POWER_RUNES] = "RUNES",
    [-2] = "HEALTH"
}

function FMT.formatCombatPowerType(data)
    local prefix = POWER_TYPES[data]
    if (prefix) then
        return tostring(data) .. " (" .. prefix .. ")";
    else
        return FMT.formatStandard(data);
    end
end

local function maskAppend(line, value, ...)
    for i = 1, select('#', ...), 2 do
        local flag, label = select(i, ...);
        if (band(value, flag) ~= 0) then
            line = line .. " " .. label;
        end
    end
    return line;
end

local function BuildCombatLogObjectLookup(prefix, mask, symbols)
    local VALUE_SYMBOLS = {};
    local prefixMatch = "^" .. prefix .. "_(..*)$";
    local T = {};
    for k, v in pairs(symbols) do
        if (type(k) == "string") then
            if (band(mask, v) ~= 0) then
                local nk = string.match(k, prefixMatch);
                if (nk) then
                    k = nk;
                end
                table.insert(VALUE_SYMBOLS, k);
                T[k] = v;
            end
        end
    end
    table.sort(VALUE_SYMBOLS);
    T._label = prefix .. ":";
    T._mask = mask;
    T._symbols = VALUE_SYMBOLS;
    return T;
end

local COMBAT_OBJECT_LOOKUPS = {};

local function BuildCombatLogObjectTables()
    local _G = getfenv(0);
    local SYMBOLS = {};
    local MASKS = {};
    local MASK_VALUES = {};
    for k, v in pairs(_G) do
        if (type(k) == "string" and type(v) == "number") then
            local suffix = string.match(k, "^COMBATLOG_OBJECT_(.*)$");
            if (suffix) then
                local count = 0;
                local cv = v;
                while (cv ~= 0) do
                    cv = rshift(cv, 1);
                    count = count + 1;
                end
                local prefix = string.match(suffix, "^(.*)_MASK$");
                if (prefix) then
                    MASKS[prefix] = v;
                    MASKS[v] = count;
                    table.insert(MASK_VALUES, count);
                else
                    SYMBOLS[suffix] = v;
                    SYMBOLS[v] = count;
                end
            end
        end
    end

    table.sort(MASK_VALUES);
    for _, count in ipairs(MASK_VALUES) do
        for maskName, maskValue in pairs(MASKS) do
            if (type(maskName) == "string") then
                if (MASKS[maskValue] == count) then
                    MASKS[maskValue] = -1;
                    local T =
                        BuildCombatLogObjectLookup(maskName, maskValue,
                                                   SYMBOLS);
                    table.insert(COMBAT_OBJECT_LOOKUPS, T);
                end
            end
        end
    end
end

BuildCombatLogObjectTables();

local TEMP = {};
function FMT.formatCombatFlags(data)
    local base = FMT.formatHex(data);
    local idx = 0;

    for _, group in ipairs(COMBAT_OBJECT_LOOKUPS) do
        local masked = band(data, group._mask);
        if (masked ~= 0) then
            idx = idx + 1;
            local line = group._label;
            for _, sym in ipairs(group._symbols) do
                local value = group[sym];
                if (band(masked, value) == value) then
                    line = line .. " " .. sym;
                end
            end
            TEMP[idx] = line;
        end
    end

    if (idx == 0) then
        return base;
    end
    TEMP[idx + 1 ] = nil;
    return base, unpack(TEMP);
end

local STANDARD_FORMATTERS = {
    ["time"] = FMT.formatTime;
}

local function StandardFormatters_Index(t, k)
    return FMT.formatStandard;
end

setmetatable(STANDARD_FORMATTERS, { __index = StandardFormatters_Index; } );

local STANDARD_LABELS = {};

function DT:GetEventTraceStandardFormats()
    return STANDARD_FORMATTERS;
end

---------------------------------------------------------------------------
local EVENTS = DT:GetPackage("eventTraceEvents");

-- Get field names and formatters for the specified event.
-- Params:
--  event -- the event name
--  evData -- the event data
--  evKeys -- the map from field keys to ids and vice-versa
--
-- Returns:
--  A table with the following structure, or nil
--
--   origKey --> newLabel mappings (String to String)
--   _special = true -- If set then dont show original field names
--   _labelFunc = function -- If set then function is invoked for each
--                            label as function(keyName, evData, evKeys)
--   _formats = table -- If set then map of newLabel --> format Function
--   _formatFunc = function -- If set then function is invokved for each
--                             formatter as function(keyName, labelName,
--                             evData, evKeys)
function DT:GetEventFormat(event, evData, evKeys)
    local eventInfo = EVENTS[event];
    local eventFormats;
    local et = type(eventInfo);
    if (et == "function") then
        return eventInfo(event, evData, evKeys);
    end
    return eventInfo;
end

---------------------------------------------------------------------------
-- Special code to handle labels for combat log events
-- Data from WoWWiki 2008-02-18

local function addArg(result, argIndex, label)
    result["arg" .. argIndex] = label;
    return argIndex + 1;
end

local COMBAT_SUFFIX_TABLE = {
    _DAMAGE = { "amount", "school", "resisted", "blocked", "absorbed",
        "critical", "glancing", "crushing" };
    _MISSED = { "missType" };
    _HEAL = { "amount", "critical" };
    _ENERGIZE = { "amount", "powerType" };
    _DRAIN = { "amount", "powerType", "extraAmount" };
    _LEECH = { "amount", "powerType", "extraAmount" };
    _INTERRUPT = { "extraSpellId", "extraSpellName", "extraSpellSchool" };
    _DISPELL_FAILED = { "extraSpellId", "extraSpellName", "extraSpellSchool" };
    _AURA_FAILED = { "extraSpellId", "extraSpellName", "extraSpellSchool",
        "auraType"};
    _AURA_STOLEN = { "extraSpellId", "extraSpellName", "extraSpellSchool" };
    _EXTRA_ATTACKS = { "amount" };
    _AURA_APPLIED = { "auraType" };
    _AURA_REMOVED = { "auraType" };
    _AURA_APPLIED_DOSE = { "auraType", "amount" };
    _AURA_REMOVED_DOSE = { "auraType", "amount" };
    _CAST_FAILED = { "failedType" };
}

local function ParseCombatEventSuffix(event, suffix, result, argIndex)
    local fields = COMBAT_SUFFIX_TABLE[suffix];
    if (fields) then
        for i, label in ipairs(fields) do
            argIndex = addArg(result, argIndex, label);
        end
    end
    return argIndex;
end

local function ParseCombatEvent(event, result, argIndex)
    local rest;
    rest = string.match(event, "^SPELL_PERIODIC(_.*)");
    if (not rest) then
        rest = string.match(event, "^SPELL(_.*)");
    end
    if (not rest) then
        rest = string.match(event, "^RANGE(_.*)");
    end
    if (rest) then
        argIndex = addArg(result, argIndex, "spellId");
        argIndex = addArg(result, argIndex, "spellName");
        argIndex = addArg(result, argIndex, "spellSchool");
        return ParseCombatEventSuffix(event, rest, result, argIndex);
    end

    rest = string.match(event, "^ENVIRONMENTAL(_.*)");
    if (rest) then
        argIndex = addArg(result, argIndex, "environmentalType");
        return ParseCombatEventSuffix(event, rest, result, argIndex);
    end

    rest = string.match(event, "^SWING(_.*)");
    if (rest) then
        return ParseCombatEventSuffix(event, rest, result, argIndex);
    end

    return argIndex;
end

local COMMON_COMBAT_FIELDS = {
    arg1 = "timestamp",
    arg2 = "combatEvent",
    arg3 = "sourceGUID",
    arg4 = "sourceName",
    arg5 = "sourceFlags",
    arg6 = "destGUID",
    arg7 = "destName",
    arg8 = "destFlags",
}

local COMBAT_SPECIAL_FIELDS = {
}

local function CombatSpecialFieldsIndex(t, k)
    local T = {};
    ParseCombatEvent(k, T, 9);
    t[k] = T;
    return T;
end

setmetatable(COMBAT_SPECIAL_FIELDS, { __index = CombatSpecialFieldsIndex } );

---------------------------------------------------------------------------
EVENTS[" _OnUpdate"] = {
    _special = true,
    arg1 = "elapsed",
    arg2 = "frames"
};

EVENTS["UPDATE_CHAT_COLOR"] = {
    arg1 = "type",
    arg2 = "red",
    arg3 = "green",
    arg4 = "blue"
};

EVENTS["COMBAT_LOG_EVENT"] = {
    _labelFunc = function(keyName, evData, evKeys)
                     local label = COMMON_COMBAT_FIELDS[keyName];
                     if (label) then return label; end
                     local fields = COMBAT_SPECIAL_FIELDS[evData["arg2"]];
                     return fields[keyName];
                 end;

    _formats = {
        sourceFlags = FMT.formatCombatFlags;
        destFlags = FMT.formatCombatFlags;
        spellSchool = FMT.formatCombatSpellSchool;
        extraSpellSchool = FMT.formatCombatSpellSchool;
        powerType = FMT.formatCombatPowerType;
    }
};
EVENTS["COMBAT_LOG_EVENT_UNFILTERED"] = EVENTS["COMBAT_LOG_EVENT"];
