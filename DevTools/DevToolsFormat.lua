------------------------------------------------------------------------------
-- DevToolsFormat.lua
--
-- Basic formatting methods for DevTools
--
-- Author: Iriel
--
-- Globals: DevTools
---------------------------------------------------------------------------

local DT = DevTools;
local UTIL = DT.utils;

-- Color and formatting settings

local DTF_SPACE_COLOR     = "|cff8888ee";
local DTF_SPACE_CHAR      = "_";
local DTF_NUMBER_COLOR    = "|cffeeeeee";
local DTF_BOOLEAN_COLOR   = "|cffeeeeee";
local DTF_FRAME_COLOR     = "|cff88ffff";
local DTF_TABLE_COLOR     = "|cff88ff88";
local DTF_OTHERTYPE_COLOR = "|cff88ff88";
local DTF_FUNCTION_COLOR  = "|cffff66aa";
local DTF_NIL_COLOR       = "|cffff0000";


local function ReplaceSpaceRun(spcs)
   local n = string.len(spcs);
   return DTF_SPACE_COLOR .. string.rep(DTF_SPACE_CHAR, n) .. "|r";
end

local function escapeString(str)
   local dnext = string.gsub(str,  "\"", "\\\"");
   dnext = string.gsub(dnext, "|", "||");
   dnext = string.gsub(dnext, "\n", "\\n");
   dnext = string.gsub(dnext, "  +", ReplaceSpaceRun);
   dnext = string.gsub(dnext, "^ ", ReplaceSpaceRun);
   return "\"" .. string.gsub(dnext, " $", ReplaceSpaceRun) .. "\"";
end

function UTIL.StringSummary(data, functionLookup)
   local dt = type(data);
   if (dt == "string") then
      local dl = string.len(data);
      if (dl > 80) then
         return escapeString(string.sub(data, 1, 80)) .. "...", true;
      else
         return escapeString(data);
      end
   elseif (dt == "number") then
      return DTF_NUMBER_COLOR .. tostring(data) .. "|r";
   elseif (dt == "boolean") then
      return DTF_BOOLEAN_COLOR .. tostring(data) .. "|r";
   elseif (dt == "function") then
      local s = (functionLookup and functionLookup[data]) or tostring(data);
      return DTF_FUNCTION_COLOR .. s .. "|r";
   elseif (dt == "table") then
      local ud = rawget(data, 0);
      if (type(ud) == "userdata") then
         local got = data.GetObjectType;
         local obj = got and got(data);
         if (obj) then
            local gn = data.GetName;
            if (gn) then gn = gn(data) end
            if (type(gn) == "string") then
               if (getglobal(gn) ~= data) then
                  gn = tostring(data) .. "(" ..
                     escapeString(gn) .. ")";
               else
                  gn = escapeString(gn);
               end
            else
               gn = tostring(data);
            end
            return DTF_FRAME_COLOR .. obj .. "|r:" .. gn, true;
         end
      end
      return DTF_TABLE_COLOR .. "<" .. dt .. ":" .. tostring(data)
         .. ">|r", true;
   elseif (dt ~= "nil") then
      return DTF_OTHERTYPE_COLOR .. "<" .. dt .. ":"
         .. tostring(data) .. ">|r";
   else
      return DTF_NIL_COLOR .. "nil|r";
   end
end


