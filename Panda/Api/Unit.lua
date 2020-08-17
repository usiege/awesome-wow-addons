local addon, ns = ...

--单位移动速度
local function UnitSpeed(unit)
local speed = GetUnitSpeed(unit)
return speed
end

--单位距离
local function UnitRange(unit)
local RangeCheck = LibStub( "LibRangeCheck-2.0" )
local _, maxRange = RangeCheck:GetRange(unit) 
local Range


if UnitExists( unit ) == true then 
Range = maxRange 
else Range = 0 
end

if Range == nil then Range = 0  end

return Range
end
--单位存在
local function HaveUnit(unit)
    if UnitExists( unit ) then
        return true
    else
        return false
    end 
end
--单位是敌人
local function IsEnemy(unit)
    if not UnitIsFriend(unit,"player") then
        return true
    else
        return false
    end 
end
--单位是BOSS
local function IsBoss(unit)
local solout = false
if UnitCanAttack( "player", "target" ) and ( UnitClassification( "target" ) == "worldboss" or UnitLevel( "target" ) == -1 ) then
solout = true
end
return solout
end

--实时生命值
local function HealthCurrent(unit)  
    local health = UnitHealth(unit)
	local n = 0
	if UnitExists(unit) then
        return health
    else
        return n

    end
end

 --生命值最大值
local function HealthMax(unit) 
    local health_max = UnitHealthMax(unit)
	local n = 0
	if UnitExists(unit) then
        return health_max
    else
        return n
    end
end

 --生命值百分比
local function HealthPercent(unit) 
    if UnitExists(unit) then
        local Health_Percent = 0
        if UnitHealthMax(unit)~=0 and UnitHealthMax(unit) ~= nil then
            Health_Percent = UnitHealth(unit) / UnitHealthMax(unit)
        end
        return tonumber(string.format("%.3f",Health_Percent*100))
    else
        return 0
    end
end




local function ShowHealth(unit)
local T = math.ceil(HealthPercent(unit))
local W = ""

if T == 0 then
return W
else return T
end

end

---插件内接口
local HealthCurrent = HealthCurrent
ns.HealthCurrent = HealthCurrent

local HealthMax = HealthMax
ns.HealthMax = HealthMax

local HealthPercent = HealthPercent
ns.HealthPercent = HealthPercent

local HaveUnit = HaveUnit
ns.HaveUnit = HaveUnit

local IsEnemy = IsEnemy
ns.IsEnemy = IsEnemy

local UnitSpeed = UnitSpeed
ns.UnitSpeed = UnitSpeed

local UnitRange = UnitRange
ns.UnitRange = UnitRange

local IsBoss = IsBoss
ns.IsBoss = IsBoss

local ShowHealth = ShowHealth
ns.ShowHealth = ShowHealth