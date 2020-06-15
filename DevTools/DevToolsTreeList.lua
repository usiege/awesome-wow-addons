------------------------------------------------------------------------------
-- DevToolsTreeList.lua
--
-- Convert a list of data into a tree structure for use in the event
-- monitor and stuff.
--
-- Written by Iriel
--
-- Globals: DevTools
---------------------------------------------------------------------------
--
--   T = DevTools:CreateTreeList();
--
--   T["SOME_ENTRY"] = "Some entry name";
--   T["SOME_OTHER_ENTRY"] = "Some other entry";
--
-- Then iterate over the resulting entries using the following special
-- values:
--
--   size = T['#'];
--   maxdepth = T['#maxdepth'];
--   rootKey = T[0];
--   rootentry = T['!'];
--
-- Iterating across the integer keys gives you the ID's of the various
-- tree headers and entries for a normal tree view, you can also lookup
-- entries by their ID. Header ID's begin with a !
--
-- The ID keyed entries are tables with the following members:
--
--   idx = integer index of this entry (or the ID it would have had if it
--         had been present)
--   parent = the ID of this entry's real parent
--   pidx = The integer ID of this entry's displayed parent
--   depth = The depth of this entry (or -1 if it's not displayed)
--   header = nil for non-headers, true for headers
--   size = nil for non headers, number of child rows for headers

local DT = DevTools;

---------------------------------------------------------------------------
local _scanSortEntries;

local function _scanSort(a,b)
    local ar,br = _scanSortEntries[a], _scanSortEntries[b];
    local an,bn = ar.name, br.name;
    if (an < bn) then
        return true;
    elseif (an == bn and bn.isHeader) then
        return true;
    end
end

local _scan;
-- size, maxdepth = _scan(key, entries, kids, depth, pidx)
function _scan(key, entries, kids, depth, pidx)
    local idx = #entries + 1;
    if (idx == 1 and key == "!") then
        idx = 0;
    end
    entries[idx] = key;
    local ent = entries[key];
    ent.idx = idx;
    ent.pidx = pidx;
    ent.depth = depth;

    local children = kids[key];

    if (not children) then
        return 1, depth;
    end

    _scanSortEntries = entries;
    table.sort(children, _scanSort);
    local size = 0;
    local maxdepth = depth;
    for n, cid in ipairs(children) do
        local count, mdepth = _scan(cid, entries, kids, depth + 1, idx);
        if (mdepth > maxdepth) then maxdepth = mdepth; end
        if (count > 1) then
            count = count + 1;
        end
        size = size + count;
    end
    ent.size = size;
    return size, maxdepth;
end

local function defaultGetParent(entryName, isHeader)
    local pname;
    if (not isHeader) then
        pname = entryName;
    else
        pname = entryName:match("^(.+)_");
    end
    if (pname) then
        return pname, pname;
    end
end

function DT:CreateTreeList(getParent)
    if (not getParent) then getParent = defaultGetParent; end
    local obj = {};
    local objMeta = {};
    setmetatable(obj, objMeta);
    local entries = {
        ["!"] = { idx = 1; depth = 0; name = "All", header = true; size = 0; };
    }
    local indexed = {};
    local stale = true;

    local refresh;

    function objMeta.__index(obj, k)
        if (stale) then refresh(); end
        local e = entries[k];
        return e;
    end

    function objMeta.__newindex(obj, k, v)
        if (v and type(k) == "string" and type(v) == "string" and
            not k:find("^[!#]")) then

            -- new entry (or entry name change)
            if (entries[k]) then
                if (entries[k].name ~= v) then
                    stale = true;
                    entries[k].name = v;
                end
                return;
            end

            --DEFAULT_CHAT_FRAME:AddMessage("Added " .. k);
            stale = true;
            local entry = {
                idx = -1; depth = -1; name = v; parent = "!"; pidx = -1;
            };
            entries[k] = entry;

            -- Set up parent entries
            local pid, pname = getParent(k, false);
            while (entry) do
                if (not pname) then
                    pname = pid or "!";
                end
                if (type(pid) == "string" and pid ~= "!") then
                    pid = "!" .. pid;
                else
                    pid = "!";
                end
                entry.parent = pid;

                entry = entries[pid];
                if (entry) then break; end
                entry = {
                    idx = -1; depth = -1; name = pname; pidx = -1;
                    header = true; size = 0;
                };
                entries[pid] = entry;

                pid, pname = getParent(pid:sub(2), true);
            end
        end
    end

    function refresh()
        stale = false;
        entries['#'] = nil;
        entries['#maxdepth'] = nil;
        local kids = {};
        -- Create child array
        for id, ent in pairs(entries) do
            if (type(id) ~= "string") then
                entries[id] = nil;
            else
                ent.idx = -1;
                ent.depth = -1;
                if (ent.size) then
                    ent.size = 0;
                end
                ent.pidx = ent.parent or -1;
                local pid = ent.parent;
                if (pid) then
                    local children = kids[pid];
                    if (not children) then
                        kids[pid] = { id };
                    else
                        table.insert(children, id);
                    end
                end
            end
        end
        -- Remove single child entries
        for id, children in pairs(kids) do
            if ((#children == 1) and (id ~= "!")) then
                local cid = children[1];
                local pid = entries[id].pidx;
                -- Set the child's parent to this one's parent
                entries[cid].pidx = pid;
                -- Replace the parent's entry for this one with the child
                local pkids = kids[pid];
                for n, pcid in ipairs(pkids) do
                    if (pcid == id) then
                        pkids[n] = cid;
                        break;
                    end
                end
                -- wipe out this one's parent
                entries[id].pidx = -1;
                -- And remember the child we inherited from
                kids[id] = cid;
            end
        end

        -- Wipe out old numeric data
        for n = #entries, 1, -1 do
            entries[n] = nil;
        end

        -- Fill in the counts
        local size, maxdepth = _scan("!", entries, kids, 0, 0);
        entries['#'] = size;
        entries['#maxdepth'] = maxdepth;


        -- Fill in info for the remapped kids
        for cid, children in pairs(kids) do
            local id;
            while (type(children) == "string") do
                id = children;
                children = kids[id];
            end
            if (id) then
                local ent = entries[cid];
                local cent = entries[id];
                local siz = cent.size;
                if (siz) then
                    ent.size = siz;
                    ent.idx = cent.idx;
                else
                    ent.size = 1;
                    ent.idx = cent.idx - 1;
                end
                ent.pidx = cent.pidx;
            end
        end
    end

    return obj;
end
