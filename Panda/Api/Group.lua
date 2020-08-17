local addon, ns = ...
local HealthPercent = ns.HealthPercent
local UnitRange = ns.UnitRange

local function Group(Type)--Type : 填 "raid" 队伍是否团队  "party" 队伍是否小队
local out = false
    if Type == "" then return end

    if Type == "raid" then 
        if IsInGroup() and IsInRaid() then 
            out = true 
        else 
            out = false  
        end
    end
 
    if Type == "party" then 
        if IsInGroup() and not IsInRaid() then 
            out = true 
        else 
            out = false  
        end
    end
return out
end


local function GroupNeedHealth(Percent,ranges) ---返回生命值百分比低于Percent的团队成员数量
local n = 0
local Members = GetNumGroupMembers() - 1
local Type = ""


    if IsInGroup() and IsInRaid() then
        Type = "raid"
    elseif IsInGroup() and not IsInRaid() then
        Type = "party"
    end

    for i = 1, Members do
        local unit = Type..i
		
        if 	HealthPercent(unit) <= Percent and not UnitIsDead(unit) and UnitRange(unit) < ranges and UnitRange(unit) ~= 0 then
            n = n + 1
        end
    end

    if HealthPercent("PLAYER") <= Percent and not UnitIsDead("PLAYER") then
        n = n + 1
    end
    
  return n
end 

local Group = Group
ns.Group = Group

local GroupNeedHealth = GroupNeedHealth
ns.GroupNeedHealth = GroupNeedHealth