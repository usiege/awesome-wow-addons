local addon, ns = ...



---------------------------------------------------------------------------
--[[《《《《《《《《《《《    目标系统   》》》》》》》》》》》]]--
---------------------------------------------------------------------------

--不纳入目标计数的单位
local discountName = {
    ["女巫布里亚"] = true,
    ["女巫马拉迪"] = true,
    ["女巫索琳娜"] = true,
    ["爆炸物"] = true,
	["护盾发生器"] = true,
	
} 
--不纳入目标计数的生物类型
local discountType = {
    ["图腾"] = true,
    ["宠物"] = true,
    ["仆从"] = true,
    
} 
---------------------------------------------------------------------------
--[[                     由伤害统计目标数                               ]]--
---------------------------------------------------------------------------
local targetsCountByDamageTime = 4 --多长时间内受到伤害进行目标计数，单位：秒
local targetsCountByDamage = 0 --通过伤害进行的目标计数

local playerGUID
local UnitTable = {} --单位表

--初始化单位，入参只能为GUID
local function InitUnitTable(GUID)
    UnitTable[GUID] = UnitTable[GUID] or {}
end


--设置最后更新时间，入参可以是GUID也可以是unit
local function SetLastUpdateTime(GUID)
    if UnitTable[GUID] == nil then print(GUID .. "尚未初始化！就进行了SetLastUpdateTime") end
    UnitTable[GUID].lastUpdateTime = GetTime()
end

--设置最后受到伤害时间
local function SetLastDamageTime(GUID)
    InitUnitTable(GUID)
    UnitTable[GUID].lastDamageTime = GetTime()
    SetLastUpdateTime(GUID)
end

--清除数据
local function ClearData(GUID)
    UnitTable[GUID] = nil
end
-----------------------------------------------由造成伤害的事件统计GUID-----------------------------------------------------

--技能产生伤害后的处理
local discountName = discountName
local function SpellDamageHandler(...)
    local timestamp, type, hideCaster, sourceGUID, sourceName, sourceFlags, sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags, spellID, spellName, spellSchool, damage = select(1, ...)
    local playerGUID = UnitGUID("player")
    local petGUID = UnitGUID("pet") or 0
    
	
    if (sourceGUID == playerGUID or sourceGUID == petGUID) and not discountName[destName] and damage > 0 then
        InitUnitTable(destGUID)
        SetLastDamageTime(destGUID)
        
    end
end

--近战产生伤害后的处理
local function SwingDamageHandler(...)
    local timestamp, type, hideCaster, sourceGUID, sourceName, sourceFlags, sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags, damage = select(1, ...)
    local playerGUID = UnitGUID("player")
    local petGUID = UnitGUID("pet") or 0
    if (sourceGUID == playerGUID or sourceGUID == petGUID) and not discountName[destName] and damage > 0 then
        InitUnitTable(destGUID)
        SetLastDamageTime(destGUID)
    end
end

--远程产生伤害后的处理
local function RangeDamageHandler(...)
    local timestamp, type, hideCaster, sourceGUID, sourceName, sourceFlags, sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags, _, _, _, damage = select(1, ...)
    local playerGUID = UnitGUID("player")
    local petGUID = UnitGUID("pet") or 0
    if (sourceGUID == playerGUID or sourceGUID == petGUID) and not discountName[destName] and damage > 0 then
        InitUnitTable(destGUID)
        SetLastDamageTime(destGUID)

    end
end

--周期性DOT产生伤害后的处理
local function SPELL_PERIODIC_DAMAGE_Handler(...)
    local timestamp, type, hideCaster, sourceGUID, sourceName, sourceFlags, sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags, _, _, _, damage = select(1, ...)
    local playerGUID = UnitGUID("player")
    local petGUID = UnitGUID("pet") or 0
    if (sourceGUID == playerGUID or sourceGUID == petGUID) and not discountName[destName] and damage > 0 then
        InitUnitTable(destGUID)
        SetLastDamageTime(destGUID)
    end
end

--战斗日志处理
local function CombatLogHandler(timestamp, type, hideCaster, sourceGUID, sourceName, sourceFlags, sourceRaidFlags, destGUID, ...)

    local typeHandlerT = {
       
        --技能伤害子事件
        ["SPELL_DAMAGE"] = function(...) SpellDamageHandler(...) end,
        ["SWING_DAMAGE"] = function(...) SwingDamageHandler(...) end,
        ["RANGE_DAMAGE"] = function(...) RangeDamageHandler(...) end,
		["SPELL_PERIODIC_DAMAGE"] = function(...) SPELL_PERIODIC_DAMAGE_Handler(...) end,
	
    }

    --按照子事件类型分发处理函数
    if typeHandlerT[type] ~= nil then 
	typeHandlerT[type](timestamp, type, hideCaster, sourceGUID, sourceName, sourceFlags, sourceRaidFlags, destGUID, ...) end
    
	--当单位死亡时清除单位数据
    if type == "UNIT_DIED" and UnitTable[destGUID] then 
	   ClearData(destGUID)
	end

	
end

--战斗日志事件注册
RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED", function(event) CombatLogHandler(CombatLogGetCurrentEventInfo()) end)

--按固定频率更新目标数

local function UpdateByDamage()
    
    --遍历目标表
    targetsCountByDamage = 0
    
	for k, v in pairs(UnitTable) do
        --基于伤害的目标记数
        if v.lastDamageTime ~= nil and GetTime() - v.lastDamageTime <= targetsCountByDamageTime then
            targetsCountByDamage = targetsCountByDamage + 1
        end
		
    end
	
end


---------------------------

--由造成伤害统计目标数 (多用于远程) 
local function GetTargetsCountByDamage()
local targets = 0
--用来限制单体AOE自动判断
if PandaDB.AoeSwitch == false then targets = 1
elseif PandaDB.AoeSwitch ~= false then targets = targetsCountByDamage 
end
return targets

end

---------------------------------------------------------------------------
--[[                     姓名板统计范围内目标数统计                                ]]--
---------------------------------------------------------------------------
local showNPs = GetCVar( 'nameplateShowEnemies' ) == "1"

local targetCount = 0
local targets = {}
    
local myTargetCount = 0
local myTargets = {}
    
local nameplates = {}
local addMissingTargets = true
    
local npCount = 0
local lastNpCount = 0
local RangeCheck = LibStub( "LibRangeCheck-2.0" )

---范围内目标数
local function enemies(rang)
   
  for k,v in pairs( nameplates ) do
        
        nameplates[k] = nil
    end
    
    npCount = 0
    
    if showNPs then
        for i = 1, 80 do
            local unit = 'nameplate'..i
            local unitname = GetUnitName( unit )
            local unittype = UnitCreatureType( unit )
            local _, maxRange = RangeCheck:GetRange( unit )
            
            if maxRange and maxRange <= rang  and  UnitExists( unit ) and not discountName[unitname]  and not discountType[unittype] and ( not UnitIsDead( unit ) ) and UnitCanAttack( 'player', unit ) and ( UnitIsPVP( 'player' ) or not UnitIsPlayer( unit ) ) then
                nameplates[ UnitGUID( unit ) ] = maxRange
                npCount = npCount + 1
            end
        end
        
        for i = 1, 5 do
            local unit = 'boss'..i
            local guid = UnitGUID( unit )
            local unitname = GetUnitName( unit )
            local unittype = UnitCreatureType( unit )
		   if not nameplates[ guid ] then
                local maxRange = RangeCheck:GetRange( unit )
                
                if maxRange and maxRange <= rang and UnitExists( unit ) and not discountName[unitname] and ( not UnitIsDead( unit ) ) and UnitCanAttack( 'player', unit ) and ( UnitIsPVP( 'player' ) or not UnitIsPlayer( unit ) ) then
                    nameplates[ UnitGUID( unit ) ] = maxRange
                    npCount = npCount + 1
                end
            end
        end
    end
    
    if  not showNPs  then
        for k,v in pairs( myTargets ) do
            if not nameplates[ k ] then
                nameplates[ k ] = true
                npCount = npCount + 1
            end
        end
    end
    
	--PandaDB.AoeSwitch用来限制单体AOE自动判断，PandaDB.AoeSwitch则强制为单目标
    if PandaDB.AoeSwitch == false then npCount = 1
    elseif PandaDB.AoeSwitch ~= false then npCount = npCount 
    end

    return npCount

end

	
--目标数系统汇总
local function active_enemies()
local R_enemies = enemies(8)
local D_enemies = GetTargetsCountByDamage()
if R_enemies == 0 then R_enemies = D_enemies end

local Class = select(2, UnitClass("player"))
local Special = select(2, GetSpecializationInfo(GetSpecialization()))


if Class == "PALADIN" or Class == "DEMONHUNTER" or Class == "MONK" or Class == "ROGUE" or Class == "DEATHKNIGHT" or Class == "WARRIOR" or Special =="生存" or Special =="增强" or Special =="野性" or Special =="守护"  then
return R_enemies
else
return D_enemies
end

end


---范围内在战斗中的目标数
local function InCombat_enemies(rang)
   
  for k,v in pairs( nameplates ) do
        
        nameplates[k] = nil
    end
    
    npCount = 0
    
    if showNPs then
        for i = 1, 80 do
            local unit = 'nameplate'..i
            local unitname = GetUnitName( unit )
            local unittype = UnitCreatureType( unit )
            local _, maxRange = RangeCheck:GetRange( unit )
            
            if maxRange and maxRange <= rang  and  UnitExists( unit ) and UnitAffectingCombat( unit ) and not discountName[unitname]  and not discountType[unittype] and ( not UnitIsDead( unit ) ) and UnitCanAttack( 'player', unit ) and ( UnitIsPVP( 'player' ) or not UnitIsPlayer( unit ) ) then
                nameplates[ UnitGUID( unit ) ] = maxRange
                npCount = npCount + 1
            end
        end
        
        for i = 1, 5 do
            local unit = 'boss'..i
            local guid = UnitGUID( unit )
            local unitname = GetUnitName( unit )
            local unittype = UnitCreatureType( unit )
		   if not nameplates[ guid ] then
                local maxRange = RangeCheck:GetRange( unit )
                
                if maxRange and maxRange <= rang and UnitExists( unit ) and UnitAffectingCombat( unit ) and not discountName[unitname] and ( not UnitIsDead( unit ) ) and UnitCanAttack( 'player', unit ) and ( UnitIsPVP( 'player' ) or not UnitIsPlayer( unit ) ) then
                    nameplates[ UnitGUID( unit ) ] = maxRange
                    npCount = npCount + 1
                end
            end
        end
    end
    
    if  not showNPs  then
        for k,v in pairs( myTargets ) do
            if not nameplates[ k ] then
                nameplates[ k ] = true
                npCount = npCount + 1
            end
        end
    end
    
	--PandaDB.AoeSwitch用来限制单体AOE自动判断，PandaDB.AoeSwitch则强制为单目标
    if PandaDB.AoeSwitch == false then npCount = 1
    elseif PandaDB.AoeSwitch ~= false then npCount = npCount 
    end

    return npCount

end
	
---------------------------------------------------------------------------
--[[                    范围内有某光环的目标数                              ]]--
---------------------------------------------------------------------------
local function Rang_enemies_Aura(rang,name1,name2)--rang范围，name名字
 
	
    for k,v in pairs( nameplates ) do
        
        nameplates[k] = nil
    end
    
    npCount = 0
	if showNPs then
        for i = 1, 80 do
            local unit = 'nameplate'..i
            local unitname = GetUnitName( unit )
            local unittype = UnitCreatureType( unit )
            local _, maxRange = RangeCheck:GetRange( unit )
            local IsAura = false
		    local Aura_count = ns.Aura_count 
	    if name2 then 
		
		    if Aura_count(unit,name1,"PLAYER|HARMFUL")>0 and Aura_count(unit,name2,"PLAYER|HARMFUL")>0 then 
                
			     IsAura = true 
		    end	
		
	    elseif not name2 then 
		    if Aura_count(unit,name1,"PLAYER|HARMFUL")>0 then 
                
		         IsAura = true 
		    end	
	    end
            if maxRange and maxRange <= rang  and IsAura and UnitExists( unit ) and not discountName[unitname]  and not discountType[unittype] and ( not UnitIsDead( unit ) ) and UnitCanAttack( 'player', unit ) and ( UnitIsPVP( 'player' ) or not UnitIsPlayer( unit ) ) then
                nameplates[ UnitGUID( unit ) ] = maxRange
                npCount = npCount + 1
            end
        end
        
        for i = 1, 5 do
            local unit = 'boss'..i
            local guid = UnitGUID( unit )
            local unitname = GetUnitName( unit )
            local unittype = UnitCreatureType( unit )
            
			local IsAura = false
		    local Aura_count = ns.Aura_count
	        if name2 then 
		        if Aura_count(unit,name1,"PLAYER|HARMFUL")>0 and Aura_count(unit,name2,"PLAYER|HARMFUL")>0 then 
                
			     IsAura = true 
		        end	
		
	        elseif not name2 then 
		        if Aura_count(unit,name1,"PLAYER|HARMFUL")>0 then 
                
		         IsAura = true 
		        end	
	        end
			
			if not nameplates[ guid ] then
                local maxRange = RangeCheck:GetRange( unit )
                 
                if maxRange and maxRange <= rang and IsAura and UnitExists( unit ) and not discountName[unitname] and ( not UnitIsDead( unit ) ) and UnitCanAttack( 'player', unit ) and ( UnitIsPVP( 'player' ) or not UnitIsPlayer( unit ) ) then
                    nameplates[ UnitGUID( unit ) ] = maxRange
                    npCount = npCount + 1
                end
            end
        end
    end
    
    if  not showNPs  then
        for k,v in pairs( myTargets ) do
            if not nameplates[ k ] then
                nameplates[ k ] = true
                npCount = npCount + 1
            end
        end
    end
    
    return npCount
end


--死亡时间预测
--[[
local function TTD()
    local ceil = math.ceil
    local current_time = GetTime()
    g_T2D_targets = g_T2D_targets or {}
    function update_target_data()
        for i = 1, 100 do
            local unit = "nameplate "..i
            record_begins(unit)
        end
        for i = 1, 5 do
            unit = "boss "..i
            record_begins(unit)
        end
        unit = "target"
        if g_T2D_targets[UnitGUID(unit)] == nil and UnitExists(unit) then
            record_begins(unit)
        end
        return ture
    end
    function record_begins(unit)
        if UnitExists(unit) and not UnitIsDead(unit) and UnitHealth(unit) < UnitHealthMax(unit) then
            g_T2D_targets[UnitGUID(unit)] = g_T2D_targets[UnitGUID(unit)] or {}
            g_T2D_targets[UnitGUID(unit)].HEALTHSTART = g_T2D_targets[UnitGUID(unit)].HEALTHSTART or UnitHealth(unit)
            g_T2D_targets[UnitGUID(unit)].TIMESTART = g_T2D_targets[UnitGUID(unit)].TIMESTART or current_time
            if g_T2D_targets[UnitGUID(unit)].HEALTHSTART <= UnitHealth(unit) then
                g_T2D_targets[UnitGUID(unit)].HEALTHSTART = UnitHealth(unit)
                g_T2D_targets[UnitGUID(unit)].TIMESTART = current_time
            end
        end
        return ture
    end
    function cal_time_die()
        local time_left = 9999
		local wait_time = 1 --等待计算的时间
        --print(current_time - g_T2D_targets[UnitGUID("target")].TIMESTART)
        if UnitExists("target") and UnitCanAttack("player","target") and InCombatLockdown() and (not UnitIsDead("target")) and g_T2D_targets[UnitGUID("target")] ~= nil then
            if current_time - g_T2D_targets[UnitGUID("target")].TIMESTART > wait_time then
            g_T2D_targets[UnitGUID("target")].TIMEGONE = current_time - g_T2D_targets[UnitGUID("target")].TIMESTART
            g_T2D_targets[UnitGUID("target")].HEALTH = UnitHealth("target")
            if g_T2D_targets[UnitGUID("target")].HEALTHSTART >  g_T2D_targets[UnitGUID("target")].HEALTH then 
                g_T2D_targets[UnitGUID("target")].DPS = (g_T2D_targets[UnitGUID("target")].HEALTHSTART - g_T2D_targets[UnitGUID("target")].HEALTH)/g_T2D_targets[UnitGUID("target")].TIMEGONE
                time_left = ceil(g_T2D_targets[UnitGUID("target")].HEALTH/g_T2D_targets[UnitGUID("target")].DPS)
                --print("怪物距离死亡： "..time_left.." 秒")
            end
            end
        end
		    local unitname = GetUnitName(unit)
		    if unitname == "训练假人" or unitname == "团队副本训练假人" or unitname == "地下城训练假人" then
               time_left = 9999
            end

		
        return time_left
    end
    if update_target_data() ~= ture then print("数据更新报错") end
    return cal_time_die()
end

--]]

--新死亡时间预测

local TimeToDie={}
TimeToDie.tiemtest = 0
TimeToDie.healthtest = 0

RegisterEvent("PLAYER_TARGET_CHANGED", function()

TimeToDie.tiemtest = GetTime()
TimeToDie.healthtest = UnitHealth("target")

end)

local function TTD() --死亡时间预测
local timenow = GetTime()
local healthnow = UnitHealth("target")
local timegoon = timenow - TimeToDie.tiemtest 
local ceil = math.ceil
local abs = math.abs
local DPS = ( healthnow - TimeToDie.healthtest ) / timegoon
local timetodie = 9999
local wait = 1
local unitname = GetUnitName("target")

    if timegoon > wait and UnitExists("target") and not UnitIsDead("target") and UnitHealth("target") < UnitHealthMax("target") and DPS ~= 0 and unitname ~= "训练假人" and unitname ~= "团队副本训练假人" and unitname ~= "地下城训练假人" then
        timetodie = abs(healthnow / DPS)
    else timetodie = timetodie
    end

return ceil(timetodie)

end

--死亡时间预测的文字显示
local function TTD_SHOW()
local T = TTD()
local W = ""

if T == 9999 then
return W
else return T
end

end

--需要特殊处理的目标
local function Teshuchuli()
local HealthCurrent = ns.HealthCurrent

if (not UnitIsDead("target") and ( GetUnitName("TARGET") == "爆炸物" or UnitCreatureType("target") =="图腾" and HealthCurrent("target")<=10000)) then return true else return false end
end

---插件内接口
local UpdateByDamage = UpdateByDamage
ns.UpdateByDamage = UpdateByDamage

local active_enemies = active_enemies
ns.active_enemies = active_enemies

local Rang_enemies_Aura = Rang_enemies_Aura
ns.Rang_enemies_Aura = Rang_enemies_Aura

local InCombat_enemies = InCombat_enemies
ns.InCombat_enemies = InCombat_enemies

local TTD = TTD
ns.TTD = TTD

local TTD_SHOW = TTD_SHOW
ns.TTD_SHOW = TTD_SHOW

local Teshuchuli = Teshuchuli
ns.Teshuchuli = Teshuchuli




