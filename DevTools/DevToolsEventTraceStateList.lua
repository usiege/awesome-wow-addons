------------------------------------------------------------------------------
-- DevToolsEventTraceStateList
--
-- State management object for EventList
--
-- Written by Iriel
--
-- Globals: DevTools
---------------------------------------------------------------------------

-- Basic object layout
--
-- the object contains all of the known values
-- it has a meta index that contains the various methods
-- it has a meta newindex for preventing new additions
-- the meta index has its own meta index for deriving new values somehow

local function print(...)
    DEFAULT_CHAT_FRAME:AddMessage("[DTESL] " .. string.format(...));
end

local DT = DevTools;

local DTSL = {};

local UNDERSCORE = string.byte("_", 1);

function DTSL:_Set(k, v, noNotify)
    -- print("Must set value [%s] -> [%s]", tostring(k), tostring(v));
    local old = rawget(self, k);
    if (old == v) then return; end
    if ((old == nil) or (v == nil)) then
        local meta = getmetatable(self);
        meta.addRemove = true;
    end
    rawset(self, k, v);
    if (not noNotify) then
        self:_Notify();
    end
end

function DTSL:_AddListener(obj, func)
    local meta = getmetatable(self);
    meta.listeners[obj] = func;
end

function DTSL:_RemoveListener(obj)
    local meta = getmetatable(self);
    meta.listeners[obj] = nil;
end

function DTSL:_DeriveValue(k)
    --print("Must derive value for [%s]", tostring(k));
    local meta = getmetatable(self);
    if (meta.deriveFunction) then
        return meta.deriveFunction(self, k);
    end
    return true;
end

function DTSL:_SetDeriveFunction(func)
    local meta = getmetatable(self);
    meta.deriveFunction = func;
end

function DTSL:_SetMeta(key, value)
    local meta = getmetatable(self);
    meta[key] = value;
end

function DTSL:_GetMeta(key)
    local meta = getmetatable(self);
    return meta[key];
end

function DTSL:_Notify()
    local meta = getmetatable(self);
    local addRemove = meta.addRemove;
    --if (addRemove) then
    --print("NOTIFY CHANGES - ADD/REMOVE");
    --else
    --print("NOTIFY CHANGES - VALUE ONLY");
    --end
    meta.addRemove = nil;
    for obj, func in pairs(meta.listeners) do
        if (type(func) == "string") then
            func = obj[func];
        end
        if (type(func) == "function") then
            pcall(func, obj, self, addRemove);
        end
    end
end

local function DTSL_META_NEWINDEX(t, k, v)
end

local function DTSL_META_INDEX(t, k)
    if ((type(k) == "string") and (k:byte(1) ~= UNDERSCORE)) then
        local val = t:_DeriveValue(k);
        if (val ~= nil) then
            t:_Set(k, val);
        end
        return val;
    else
        return DTSL[k];
    end
end

function DTSL:New()
    local obj = {};
    local objmeta = { listeners = {} };

    objmeta.__newindex = DTSL_META_NEWINDEX;
    objmeta.__index = DTSL_META_INDEX;
    setmetatable(obj, objmeta);

    return obj;
end

DT.EventTraceStateList = DTSL;
