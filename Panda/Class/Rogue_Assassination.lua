---------------------------------------------------------------------------
--[[                       图标更新循环                                  ]]--
---------------------------------------------------------------------------
local addon, ns = ...

local Aura_time = ns.Aura_time 
local Aura_count = ns.Aura_count 
local Aura_Stack = ns.Aura_Stack 
local IsBloodlust = ns.IsBloodlust 

local Combat = ns.Combat
local time_x = ns.time_x
local time_d = ns.time_d

local Group = ns.Group
local GroupNeedHealth = ns.GroupNeedHealth

local IsEquipped = ns.IsEquipped 
local ItemCooldown = ns.ItemCooldown 
local Itemuseable = ns.Itemuseable  
local AzltE = ns.AzltE  
local Tier = ns.Tier  

local Summon_Pet = ns.Summon_Pet  

local PlayerClass = ns.PlayerClass 
local Specialization = ns.Specialization 
local IsTalent = ns.IsTalent 

local Power = ns.Power 
local PowerMax = ns.PowerMax 
local PowerDft = ns.PowerDft 

local Rang_enemies_Aura = ns.Rang_enemies_Aura 
local InCombat_enemies = ns.InCombat_enemies 
local active_enemies = ns.active_enemies 
local TTD = ns.TTD 
local Teshuchuli = ns.Teshuchuli

local Time_fmod = ns.Time_fmod 
--local Authorization = ns.Authorization 

local HealthCurrent = ns.HealthCurrent 
local HealthMax = ns.HealthMax 
local HealthPercent = ns.HealthPercent 
local UnitSpeed = ns.UnitSpeed 
local UnitRange = ns.UnitRange 
local IsBoss = ns.IsBoss 
local HaveUnit = ns.HaveUnit
local IsEnemy = ns.IsEnemy

local GetSpellID = ns.GetSpellID
local useable = ns.useable 
local Isuseable = ns.Isuseable 
local GCD_MAX = ns.GCD_MAX 
local GCD_REMAINS = ns.GCD_REMAINS 
local SpellCooldown = ns.SpellCooldown 
local SpellCharges = ns.SpellCharges 
local SpellallCharges = ns.SpellallCharges
local SpellFullCharges = ns.SpellFullCharges 
local SpellConut = ns.SpellConut 
local cast_time = ns.cast_time 
local casting_time = ns.casting_time 
local channel_time = ns.channel_time
local Useing_spell = ns.Useing_spell
local Useingtime = ns.Useingtime
local Last_Spell = ns.Last_Spell 
local cast_In = ns.cast_In 
local cast_later = ns.cast_later 
local Prev_Spell = ns.Prev_Spell 
local Spell_Later = ns.Spell_Later 


local ShowColor = ns.ShowColor 
local ShowSpell = ns.ShowSpell 

---------------------------------------------------------------------------
--[[                   变量                      ]]--
---------------------------------------------------------------------------  
--快照：抽血存在？     
local DzChouXue = CreateFrame("frame")
DzChouXue:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
local DzChouXueTargetTable = {}
local Bleeding = { --流血
    [703] = true, -- Garrote
    [1079] = true, -- Rip
    [1822] = true, -- Rake
    [1943] = true, -- Rupture
    [11977] = true, -- Rend
    [16511] = true, -- Hemorrhage
    [77758] = true, -- Thrash
    [106830] = true, -- Thrash
    [115767] = true, -- Deep Wounds
    [155722] = true, -- Rake
    [162487] = true, -- Steel Trap (hunter talent)
    [185855] = true, -- Lacerate (Survival hunter)
    [194279] = true, -- Caltrops (hunter talent)
    [202028] = true, -- Brutal Slash (feral druid talent)
    [273794] = true, -- Rezan's Fury (general azerite trait)
}
local PlayerGUID = UnitGUID("player")
DzChouXue:SetScript("OnEvent", function(self,event)
        local  _, subtype, _, sourceGUID, sourceName, _, _, destGUID, destName, destFlags, _, spellID, spellName, _, amount, interrupt, a, b, c, d, offhand, multistrike = CombatLogGetCurrentEventInfo()
        if subtype == "SPELL_CAST_SUCCESS" and sourceGUID == PlayerGUID  and spellID == 200806 then
            local n = 1
            local AuraName,_, AuraCounts,AuraType, AuraDuration, AuraExpirationTime, unitCaster,isStealable, _, AuraSpellID = UnitAura("target",n,"PLAYER|HARMFUL")
            while AuraName do
                if Bleeding[AuraSpellID] then
                    DzChouXueTargetTable[destGUID] = DzChouXueTargetTable[destGUID] or {}
                    DzChouXueTargetTable[destGUID][AuraName] = AuraExpirationTime
                end
                n = n + 1
                AuraName,_, AuraCounts,AuraType, AuraDuration, AuraExpirationTime, unitCaster,isStealable, _, AuraSpellID = UnitAura("target",n,"PLAYER|HARMFUL")
            end
        end
end)
local function HasChouXue(SpellName) --添流血buff中文名
    local GUID = UnitGUID("target")
    if DzChouXueTargetTable[GUID] then 
        if type(DzChouXueTargetTable[GUID][SpellName]) == "number" then 
            if DzChouXueTargetTable[GUID][SpellName] > GetTime() then
                return true
            else
                DzChouXueTargetTable[GUID][SpellName] = nil
            end
        end
    end
    return false
end
----------------------------------------------------
local function poisoned_bleeds()--流血目标数

    local B = Rang_enemies_Aura(20,"锁喉","致命药膏")
    local C = Rang_enemies_Aura(20,"割裂","致命药膏")
  
    return B+C
end

local function DYS()--回能计算
    local bleeds = poisoned_bleeds()
	local haste = GetHaste()
    local A= select( 2, GetPowerRegen())
    local B= bleeds*7/(2*haste)
    return A+B
    
end

local function rupture_refreshable()--割裂可刷新公式
      local n = Aura_time("target","割裂","PLAYER|HARMFUL")
	  local COMBO_POINTS = Power("COMBO_POINTS")
	  if n < (4+4*COMBO_POINTS)*0.3 then return true else return false end
end

local function filler()--variable_use_filler 
local combo_points_deficit = PowerMax("COMBO_POINTS")- Power("COMBO_POINTS")
local energy_deficit = PowerMax("ENERGY")- Power("ENERGY")
local variable_energy_regen_combined = DYS()
local variable_single_target = active_enemies()<2
    return combo_points_deficit>1 or energy_deficit<=25+variable_energy_regen_combined or  not variable_single_target
end

  
local function Stealth()--潜行状态
      local A = Aura_count("PLAYER","潜行")
      local B = Aura_count("PLAYER","影遁")
      local C = Aura_count("PLAYER","消失")
	  local D = Aura_count("PLAYER","暗影之舞")
	  local E = Aura_time("target","暗影决斗","PLAYER|HARMFUL")
	  local F = Aura_count("PLAYER","潜伏帷幕")
	  local G = Aura_time("PLAYER","诡诈")
	  local n = false
	  if A>0 or B>0 or C>0 or D>0 or E>0 or F>0 or G>=1 then n = true else n = false end
	  return n
end

local function DS()
    local A = 0 
    if IsTalent("深邃诡计") then 
        
        A=1      
    else
        
        A=0
    end
    return A
end  

--[[

--快照：锁喉倍数

local Souhoutargets={}
local suohou = CreateFrame("frame")
suohou:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")

local PlayerGUID = UnitGUID("player")
suohou:SetScript("OnEvent", function(self,event)
local  _, subtype, _, sourceGUID, sourceName, _, _, destGUID, destName, destFlags, _, spellID, spellName, _, amount, interrupt, a, b, c, d, offhand, multistrike = CombatLogGetCurrentEventInfo()
    if Stealth() and IsTalent("诡诈") then
	    if subtype == "SPELL_CAST_SUCCESS" and sourceGUID == PlayerGUID  and spellID == 703 then
            table.insert(Souhoutargets,destGUID)
        end
    end
end)


local function SouHouBeiShu()
local out = 1

	for k, v in pairs(Souhoutargets) do
	    local GUID = UnitGUID("target")
	        if GUID ~= nil then
		        if GUID == v and Aura_time("target","锁喉","PLAYER|HARMFUL")>0 then 
                    out = 1.8 
 
                end
	        end

	end
    return out
end
--]]

local function Rogue_Assassination()  --更新主图标及技能提示图标

local mainbutton = PDUI.mainbutton
local debutton = PDUI.debutton


if PlayerClass()=="ROGUE" and Specialization()=="奇袭"  then
--if Authorization() then


--开始循环
--自动拾取器


---------------------------------------------------------------------------
--[[                       编辑区                       ]]--
---------------------------------------------------------------------------

--最高优先级

--战斗前
if not InCombatLockdown() then

if PandaDB.QXZ_C4 ~= false  and Isuseable("潜行",115191) then
if ( not Stealth() ) then ShowColor(mainbutton.icon, 6603,C_4);ShowSpell(debutton.icon, 115191)   return end
end

if PandaDB.QXZ_A1 ~= false  and Isuseable("致命药膏",2823) then
if ( Aura_time("PLAYER","致命药膏")<900 and Aura_time("PLAYER","致伤药膏")<600) then ShowColor(mainbutton.icon, 6603,A_1);ShowSpell(debutton.icon, 2823)   return end
end

if PandaDB.QXZ_A3 ~= false  and Isuseable("减速药膏",3408) then
if ( Aura_time("PLAYER","减速药膏")<900 ) then ShowColor(mainbutton.icon, 6603,A_3);ShowSpell(debutton.icon, 3408)   return end
end

if PandaDB.QXZ_A6 ~= false  and Isuseable("死亡标记",137619) then
if Power("COMBO_POINTS") <=2 then ShowColor(mainbutton.icon, 6603,A_6);ShowSpell(debutton.icon, 137619) return end
end
end

--stealth
if Stealth()  then
if PandaDB.QXZ_C1 ~= false  and Isuseable("锁喉",703) then
if ( Aura_time("PLAYER","潜行")>0 and not HasChouXue("锁喉")) then ShowColor(mainbutton.icon, 6603,C_1);ShowSpell(debutton.icon, 703)   return end
end

if PandaDB.QXZ_A7 ~= false  and Isuseable("割裂",1943) then
if ( Power("COMBO_POINTS")>=2 and Aura_time("target","割裂","PLAYER|HARMFUL")==0  and Aura_time("target","锁喉","PLAYER|HARMFUL")>0 ) then ShowColor(mainbutton.icon, 6603,A_7);ShowSpell(debutton.icon, 1943)   return end
end

if PandaDB.QXZ_C1 ~= false  and Isuseable("锁喉",703) then
if ( Stealth()  and not HasChouXue("锁喉") and active_enemies()>=3 and Aura_time("target","锁喉","PLAYER|HARMFUL")==0) then ShowColor(mainbutton.icon, 6603,C_1);ShowSpell(debutton.icon, 703)   return end
end

if PandaDB.QXZ_C1 ~= false  and Isuseable("锁喉",703) then
if ( Stealth()  and not HasChouXue("锁喉") and PowerMax("COMBO_POINTS") - Power("COMBO_POINTS")>0 ) then ShowColor(mainbutton.icon, 6603,C_1);ShowSpell(debutton.icon, 703)   return end
end
end

--大招
if PandaDB.QXZ_A6 ~= false  and Isuseable("死亡标记",137619) then
if Power("COMBO_POINTS") == 0  then ShowColor(mainbutton.icon, 6603,A_6);ShowSpell(debutton.icon, 137619)   return end
end

if PandaDB.CcdSwitch ~= false  then

if PandaDB.QXZ_A4 ~= false  and Isuseable("宿敌",79140) then
if Power("COMBO_POINTS")>=4 and not Stealth()  and  ( Aura_time("target","割裂","PLAYER|HARMFUL")>0 ) then ShowColor(mainbutton.icon, 6603,A_4);ShowSpell(debutton.icon, 79140)   return end
end

if PandaDB.QXZ_A2 ~= false  and Isuseable("消失",1856) then
if InCombatLockdown() and not Stealth()  and ( PowerMax("COMBO_POINTS") - Power("COMBO_POINTS")>=4 and Aura_time("target","锁喉","PLAYER|HARMFUL")<8 and Power("ENERGY")>40 ) then ShowColor(mainbutton.icon, 6603,A_2);ShowSpell(debutton.icon, 1856)   return end
end
end

if PandaDB.CcdSwitch ~= false  then
--艾泽拉斯之心精华
--essences
if PandaDB.QXZ_C8 then
if Isuseable("仇敌之血","仇敌之血") then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.QXZ_C8 then
if Isuseable("艾泽拉斯守护者","艾泽拉斯守护者") then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.QXZ_C8 then
if Isuseable("不羁之力","不羁之力") then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.QXZ_C8 then
if Isuseable("聚能艾泽里特射线","聚能艾泽里特射线") and Useing_spell("player") ~= 295258 and Aura_time("PLAYER","风火雷电")==0 and Aura_time("PLAYER","屏气凝神")==0 then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.QXZ_C8 then
if Isuseable("火红烈焰","火红烈焰") then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.QXZ_C8 then
if Isuseable("净化冲击","净化冲击") then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.QXZ_C8 then
if Isuseable("世界血脉共鸣","世界血脉共鸣") then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.QXZ_C8 then
if Isuseable("空间涟漪","空间涟漪") then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.QXZ_C8 then
if Isuseable("清醒梦境之忆","清醒梦境之忆") then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.QXZ_C8 then
if Isuseable("收割火焰","收割火焰")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.QXZ_C8 then
if Isuseable("生命缚誓者之祈","生命缚誓者之祈")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.QXZ_C8 then
if Isuseable("救世之魂","救世之魂")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.QXZ_C8 then
if Isuseable("守护屏障","守护屏障")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.QXZ_C8 then
if Isuseable("补充能量","补充能量")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.QXZ_C8 then
if Isuseable("静滞","静滞")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.QXZ_C8 then
if Isuseable("法力过载","法力过载")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.QXZ_C8 then
if Isuseable("活力导管","活力导管")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.QXZ_C8 then
if Isuseable("爆燃之拥","爆燃之拥")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.QXZ_C8 then
if Isuseable("光荣时刻","光荣时刻")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.QXZ_C8 then
if Isuseable("深渊之护","深渊之护")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.QXZ_C8 then
if Isuseable("艾泽拉斯的不朽赐福","艾泽拉斯的不朽赐福")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.QXZ_C8 then
if Isuseable("强化虚无屏障","强化虚无屏障")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

end

if PandaDB.QXZ_C2 ~= false  and Isuseable("抽血",200806) then
if ( not Stealth()  and Aura_time("target","锁喉","PLAYER|HARMFUL")>10 and Aura_time("target","割裂","PLAYER|HARMFUL")>18 ) then ShowColor(mainbutton.icon, 6603,C_2);ShowSpell(debutton.icon, 200806)   return end
end

if PandaDB.QXZ_A0 ~= false  and Isuseable("淬毒之刃",245388) then
if ( not Stealth()  and (Aura_time("target","宿敌","PLAYER|HARMFUL")>1 or (SpellCooldown(79140)<3 and PowerMax("COMBO_POINTS") - Power("COMBO_POINTS")>1) or SpellCooldown(79140)>10 or  PandaDB.QXZ_A4 == false  or  PandaDB.CcdSwitch == false ) ) then ShowColor(mainbutton.icon, 6603,A_0);ShowSpell(debutton.icon, 245388)   return end
end

--自定义特殊处理组
if Teshuchuli() then

if PandaDB.QXZ_A9 ~= false  and Isuseable("毒伤",32645) then
if ( Power("COMBO_POINTS")>=4 + DS() ) then ShowColor(mainbutton.icon, 6603,A_9);ShowSpell(debutton.icon, 32645)   return end
end

if PandaDB.QXZ_C5 ~= false  and Isuseable("天降杀机",269513) then
if ( Power("COMBO_POINTS")>=4 + DS() ) then ShowColor(mainbutton.icon, 6603,C_5);ShowSpell(debutton.icon, 269513)   return end
end

if PandaDB.QXZ_A5 ~= false  and Isuseable("刀扇",51723) then
if ( (active_enemies()>=3 or  Aura_Stack("PLAYER","隐刃")>=19) and Power("COMBO_POINTS")<4 + DS() ) then ShowColor(mainbutton.icon, 6603,A_5);ShowSpell(debutton.icon, 51723)   return end
end

if PandaDB.QXZ_C7 ~= false  and Isuseable("侧袭",111240) then
if ( Power("COMBO_POINTS")<PowerMax("COMBO_POINTS") and ( HealthPercent("target")<=35 or Aura_time("player","侧袭")>0)) then ShowColor(mainbutton.icon, 6603,C_7);ShowSpell(debutton.icon, 111240)   return end
end

if PandaDB.QXZ_A8 ~= false  and Isuseable("毁伤",1329) then
if ( active_enemies()<=3 ) then ShowColor(mainbutton.icon, 6603,A_8);ShowSpell(debutton.icon, 1329)   return end
end

end
------
if PandaDB.QXZ_A5 ~= false  and Isuseable("刀扇",51723) then
if ( Aura_Stack("PLAYER","隐刃")>=19 and Power("COMBO_POINTS")<4 + DS() ) then ShowColor(mainbutton.icon, 6603,A_5);ShowSpell(debutton.icon, 51723)   return end
end

if PandaDB.QXZ_C6 ~= false  and Isuseable("猩红风暴",121411) then
if ( active_enemies()>=3 and Power("COMBO_POINTS") >=4 and not Stealth()  and Aura_time("target","猩红风暴","PLAYER|HARMFUL")<2 ) then ShowColor(mainbutton.icon, 6603,C_6);ShowSpell(debutton.icon, 121411)   return end
end

if PandaDB.QXZ_A7 ~= false  and Isuseable("割裂",1943) then
if TTD()>10 and  rupture_refreshable() and ( Power("COMBO_POINTS")>=4 or active_enemies()>=3 and Power("COMBO_POINTS")>=2 ) then ShowColor(mainbutton.icon, 6603,A_7);ShowSpell(debutton.icon, 1943) return end
end


if PandaDB.QXZ_C5 ~= false  and Isuseable("天降杀机",269513) then
if ( Power("COMBO_POINTS")>=4 ) then ShowColor(mainbutton.icon, 6603,C_5);ShowSpell(debutton.icon, 269513)   return end
end

if PandaDB.QXZ_A9 ~= false  and Isuseable("毒伤",32645) then
if ( Power("COMBO_POINTS")>=4 + DS() and (Aura_time("target","宿敌","PLAYER|HARMFUL")>0 or Aura_time("target","淬毒之刃","PLAYER|HARMFUL")>0 or UnitIsPlayer("target") and UnitCanAttack( 'player', "target" ) or (PowerMax("ENERGY")- Power("ENERGY")<=25+DYS()) )) then ShowColor(mainbutton.icon, 6603,A_9);ShowSpell(debutton.icon, 32645)   return end
end

if PandaDB.QXZ_C1 ~= false  and Isuseable("锁喉",703) then
if Aura_time("target","锁喉","PLAYER|HARMFUL")<6 then ShowColor(mainbutton.icon, 6603,C_1);ShowSpell(debutton.icon, 703)   return end
end

if PandaDB.QXZ_A5 ~= false  and Isuseable("刀扇",51723) then
if ( active_enemies()>=3 and Power("COMBO_POINTS")<4 + DS() ) then ShowColor(mainbutton.icon, 6603,A_5);ShowSpell(debutton.icon, 51723)   return end
end

if PandaDB.QXZ_C7 ~= false  and Isuseable("侧袭",111240) then
if ( Power("COMBO_POINTS")<PowerMax("COMBO_POINTS") and ( HealthPercent("target")<=35 or Aura_time("player","侧袭")>0)) then ShowColor(mainbutton.icon, 6603,C_7);ShowSpell(debutton.icon, 111240)   return end
end

if PandaDB.QXZ_A8 ~= false  and Isuseable("毁伤",1329) then
if ( active_enemies()<=3 and Power("COMBO_POINTS")<4 + DS() and Power("ENERGY")>=60+DYS() ) then ShowColor(mainbutton.icon, 6603,A_8);ShowSpell(debutton.icon, 1329)   return end
end


---------------------------------------------------------------------------
--[[                       编辑区                       ]]--
---------------------------------------------------------------------------
ShowColor(mainbutton.icon, 6603,6603);ShowSpell(debutton.icon, 311923)	

--elseif not Authorization() then 
--print("|cffffe00a★Panda★:【|r|c00FF68CC 插件未激活 联系QQ:398371778 |r|cffffe00a】|r")

--end


end

end

local Rogue_Assassination = Rogue_Assassination
ns.Rogue_Assassination = Rogue_Assassination

