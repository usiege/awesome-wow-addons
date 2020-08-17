---------------------------------------------------------------------------
--[[《《《《《《《《《《《    宠物系统   》》》》》》》》》》》]]--
---------------------------------------------------------------------------
local addon, ns = ...

--需要召唤宠物
local function Summon_Pet()
local unit = "pet"
local PetExists = UnitExists(unit)
local Pet_Dead = UnitIsDead(unit)
if not PetExists or Pet_Dead then
return true else return false
end
end

---插件内接口
local Summon_Pet = Summon_Pet
ns.Summon_Pet = Summon_Pet