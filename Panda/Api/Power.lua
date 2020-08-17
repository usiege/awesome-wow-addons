---------------------------------------------------------------------------
--[[《《《《《《《《《《《       能量       》》》》》》》》》》》]]--
---------------------------------------------------------------------------
local addon, ns = ...

local PowerTypeList = {
    ["MANA"] = 0,--蓝
    ["RAGE"] = 1,--怒气
    ["FOCUS"] = 2,--集中值
    ["ENERGY"] = 3,--能量
    ["COMBO_POINTS"] = 4,--连击点
    ["RUNES"] = 5,--DK符文
    ["RUNIC_POWER"] = 6,--符文能量
    ["SOUL_SHARDS"] = 7,--术士灵魂碎片
    ["LUNAR_POWER"] = 8,--星界能量
    ["HOLY_POWER"] = 9,--神圣能量
    ["ALTERNATE_POWER"] = 10,
    ["MAELSTROM"] = 11,--漩涡值
    ["CHI"] = 12,--真气
    ["INSANITY"] = 13,--狂乱值
    ["OBSOLETE"] = 14,--未知
    ["OBSOLETE2"] = 15,--未知
    ["ARCANE_CHARGES"] = 16,--奥法
    ["FURY"] = 17,--浩劫怒气
    ["PAIN"] = 18,--复仇怒气
	

}

---实时能量 powername填上面表中的
local function Power(powername)
   local PowerType = PowerTypeList[powername]
   local power_current = UnitPower("player",PowerType)
    if PowerTypeList[powername] then
        return power_current
    end
end

--能量最大值 powername填上面表中的
local function PowerMax(powername)
    local PowerType = PowerTypeList[powername]
	local power_max = UnitPowerMax("player",PowerType)
    if PowerTypeList[powername] then
        return power_max
    end
end

--能量不足值 powername填上面表中的
local function PowerDft(powername)
    local Powercurrent = Power(powername)
	local power_max = PowerMax(powername)

    return power_max - Powercurrent
end


local function DKRunes()---DK符文剩余
local runeAmount = 0
for i=1,6 do
  local start, duration, runeReady = GetRuneCooldown(i)
  if runeReady == true then
    runeAmount = runeAmount+1
  end
end
return runeAmount
end

local function Runes()---DK符文剩余 和前面效果一样
local total = 0
for i=1,6 do
    total = total + GetRuneCount(i)
end
return total
end


local function ShowPower()

local ClassPowerTable = {

["MONK"] = {
		["酒仙"] = UnitStagger("player"),
		["踏风"] = Power("CHI"),	
		["织雾"] = math.ceil((Power("MANA")/PowerMax("MANA"))*100),	
			
},

["DEMONHUNTER"] = {
		["浩劫"] = Power("FURY"),
		["复仇"] = Power("PAIN"),	
			
},

["HUNTER"] = {
		["野兽控制"] = Power("FOCUS"),
		["射击"] = Power("FOCUS"),	
		["生存"] = Power("FOCUS"),			
			
},


["PALADIN"] = {
		["防护"] = math.ceil((Power("MANA")/PowerMax("MANA"))*100),
		["惩戒"] = Power("HOLY_POWER"),	
		["神圣"] = math.ceil((Power("MANA")/PowerMax("MANA"))*100),			
			
},

["ROGUE"] = {
		["奇袭"] = Power("COMBO_POINTS"),
		["狂徒"] = Power("COMBO_POINTS"),	
		["敏锐"] = Power("COMBO_POINTS"),			
			
},

["WARLOCK"] = {
		["痛苦"] = Power("SOUL_SHARDS"),
		["毁灭"] = Power("SOUL_SHARDS"),	
		["恶魔学识"] = Power("SOUL_SHARDS"),			
			
},

["WARRIOR"] = {
		["武器"] = Power("RAGE"),
		["防护"] = Power("RAGE"),	
		["狂怒"] = Power("RAGE"),			
			
},

["SHAMAN"] = {
		["增强"] = Power("MAELSTROM"),
		["元素"] = Power("MAELSTROM"),	
		["恢复"] = math.ceil((Power("MANA")/PowerMax("MANA"))*100),			
			
},

["DEATHKNIGHT"] = {
		["鲜血"] = Power("RUNIC_POWER"),
		["冰霜"] = Power("RUNIC_POWER"),	
		["邪恶"] = Power("RUNIC_POWER"),			
			
},

["MAGE"] = {
		["冰霜"] = math.ceil((Power("MANA")/PowerMax("MANA"))*100),
		["火焰"] = math.ceil((Power("MANA")/PowerMax("MANA"))*100),	
		["奥术"] = Power("ARCANE_CHARGES"),			
			
},

["PRIEST"] = {
		["暗影"] = Power("INSANITY"),
		["戒律"] = math.ceil((Power("MANA")/PowerMax("MANA"))*100),	
		["神圣"] = math.ceil((Power("MANA")/PowerMax("MANA"))*100),			
			
},

["DRUID"] = {
		["平衡"] = Power("LUNAR_POWER"),
		["野性"] = Power("COMBO_POINTS"),	
		["守护"] = Power("RAGE"),		
		["恢复"] = math.ceil((Power("MANA")/PowerMax("MANA"))*100),			
			
},


}

local Powershow = 0
local Class = select(2, UnitClass("player"))
local Special = select(2, GetSpecializationInfo(GetSpecialization()))

if ClassPowerTable[Class][Special] ~= nil then
Powershow = ClassPowerTable[Class][Special]
end			

return Powershow
end



---插件内接口
local Power = Power
ns.Power = Power

local PowerMax = PowerMax
ns.PowerMax = PowerMax

local PowerDft = PowerDft
ns.PowerDft = PowerDft

local DKRunes = DKRunes
ns.DKRunes = DKRunes

local Runes = Runes
ns.Runes = Runes

local ShowPower = ShowPower
ns.ShowPower = ShowPower

