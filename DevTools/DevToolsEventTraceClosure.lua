------------------------------------------------------------------------------
-- DevToolsEventTraceClosure.lua
--
-- Special closures for storing and managing event details, this may be
-- a bit odd and likely needs performance testing.
--
-- Written by Iriel
--
-- Globals: DevTools
---------------------------------------------------------------------------

local DT = DevTools;

local ARG_EXPRESSIONS = {
    [1] = "T[2]";
};

local function ArgExpressionIndex(t, k)
    if (not tonumber(k)) then
        return nil;
    end
    if (k ~= math.floor(k)) then
        return nil;
    end
    if (k < 1) then
        return nil;
    end
    local e = t[k - 1] .. ",T[" .. (k + 1) .. "]";
    t[k] = e;
    return e;
end

setmetatable( ARG_EXPRESSIONS, { __index = ArgExpressionIndex; } );

local INIT_EXPRESSIONS = {
    [1] = "0, 0";
};

local function InitExpressionIndex(t, k)
    if (not tonumber(k)) then
        return nil;
    end
    if (k ~= math.floor(k)) then
        return nil;
    end
    if (k < 1) then
        return nil;
    end
    local e = t[k - 1] .. ",1";
    t[k] = e;
    return e;
end

setmetatable( INIT_EXPRESSIONS, { __index = InitExpressionIndex; } );

local CREATE_CLOSURES = {
    [0] = function() return {} end;
};

local function CreateClosureIndex(t, k)
    local e = INIT_EXPRESSIONS[k];
    if (e == nil) then
        return nil;
    end
    local body = "return { " .. e .. " }";
    local f, e = loadstring(body);
    if (not f) then
        error(e);
    end
    t[k] = f;
    return f;
end

setmetatable( CREATE_CLOSURES, { __index = CreateClosureIndex; } );

function DT:GetEventEntryCreateClosureTable()
    return CREATE_CLOSURES;
end

local READ_CLOSURES = {
    [0] = function() end;
};

local function ReadClosureIndex(t, k)
    local e = ARG_EXPRESSIONS[k];
    if (e == nil) then
        return nil;
    end
    local body = "return function(T) return " .. e .. "; end";
    local f, e = loadstring(body);
    if (not f) then
        error(e);
    end
    f = f();
    t[k] = f;
    return f;
end

setmetatable( READ_CLOSURES, { __index = ReadClosureIndex; } );

function DT:GetEventEntryReadClosureTable()
    return READ_CLOSURES;
end

local WRITE_CLOSURES = {
    [0] = function() end;
};

local function WriteClosureIndex(t, k)
    local e = ARG_EXPRESSIONS[k];
    if (e == nil) then
        return nil;
    end
    local body = "return function(T, n, ...) T[1],"
        .. e .. " = n, ...; end";
    local f, e = loadstring(body);
    if (not f) then
        error(e);
    end
    f = f();
    t[k] = f;
    return f;
end

setmetatable( WRITE_CLOSURES, { __index = WriteClosureIndex; } );

function DT:GetEventEntryWriteClosureTable()
    return WRITE_CLOSURES;
end
