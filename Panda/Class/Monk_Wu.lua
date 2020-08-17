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

local function Monk_Wu()  --更新主图标及技能提示图标

local mainbutton = PDUI.mainbutton
local debutton = PDUI.debutton

if PlayerClass()=="MONK" and Specialization()=="织雾" then
--if Authorization() then
---simc变量声明


---------------------------------------------------------------------------
--[[                       织雾僧                       ]]--
---------------------------------------------------------------------------

local Members = GetNumGroupMembers()

if PandaDB.CcdSwitch ~= false  then
--艾泽拉斯之心精华
--essences
if PandaDB.ZW_C8 then
if Isuseable("仇敌之血","仇敌之血") then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.ZW_C8 then
if Isuseable("艾泽拉斯守护者","艾泽拉斯守护者") then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.ZW_C8 then
if Isuseable("不羁之力","不羁之力") then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.ZW_C8 then
if Isuseable("聚能艾泽里特射线","聚能艾泽里特射线") and Useing_spell("player") ~= 295258 and Aura_time("PLAYER","风火雷电")==0 and Aura_time("PLAYER","屏气凝神")==0 then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.ZW_C8 then
if Isuseable("火红烈焰","火红烈焰") then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.ZW_C8 then
if Isuseable("净化冲击","净化冲击") then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.ZW_C8 then
if Isuseable("世界血脉共鸣","世界血脉共鸣") then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.ZW_C8 then
if Isuseable("空间涟漪","空间涟漪") then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.ZW_C8 then
if Isuseable("清醒梦境之忆","清醒梦境之忆") then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.ZW_C8 then
if Isuseable("收割火焰","收割火焰")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.ZW_C8 then
if Isuseable("生命缚誓者之祈","生命缚誓者之祈")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.ZW_C8 then
if Isuseable("救世之魂","救世之魂")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.ZW_C8 then
if Isuseable("守护屏障","守护屏障")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.ZW_C8 then
if Isuseable("补充能量","补充能量")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.ZW_C8 then
if Isuseable("静滞","静滞")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.ZW_C8 then
if Isuseable("法力过载","法力过载")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.ZW_C8 then
if Isuseable("活力导管","活力导管")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.ZW_C8 then
if Isuseable("爆燃之拥","爆燃之拥")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.ZW_C8 then
if Isuseable("光荣时刻","光荣时刻")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.ZW_C8 then
if Isuseable("深渊之护","深渊之护")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.ZW_C8 then
if Isuseable("艾泽拉斯的不朽赐福","艾泽拉斯的不朽赐福")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.ZW_C8 then
if Isuseable("强化虚无屏障","强化虚无屏障")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

end

--团刷组
--Raid
if IsInGroup() and IsInRaid() then

if PandaDB.CcdSwitch ~= false  then
if PandaDB.ZW_A0 ~= false  and Isuseable("朱鹤赤精",198664) then
if GroupNeedHealth(90,40)>=Members/3 then ShowColor(mainbutton.icon, 6603,A_0);ShowSpell(debutton.icon, 198664)   return end
end
end

if PandaDB.ZW_A9 ~= false  and Isuseable("碧愈疾风",196725) then
if Aura_time("PLAYER","碧愈疾风")==0 and GroupNeedHealth(95,10)>2 then ShowColor(mainbutton.icon, 6603,A_9);ShowSpell(debutton.icon, 196725) return end
end

if PandaDB.ZW_C5 ~= false  and Isuseable("精华之泉",191837)  then
if (SpellConut(191837)>=16 and GroupNeedHealth(80,40)>=5) or (SpellConut(191837)<16 and SpellConut(191837)>=8 and GroupNeedHealth(85,40)>=5) or (SpellConut(191837)<8 and GroupNeedHealth(90,40)>=5) then ShowColor(mainbutton.icon, 6603,C_5);ShowSpell(debutton.icon,191837) return end
end
end


--Party
if IsInGroup() and not IsInRaid() then

if PandaDB.CcdSwitch ~= false  then
if PandaDB.ZW_A0 ~= false  and Isuseable("朱鹤赤精",198664) then
if GroupNeedHealth(90,40)>=3 then ShowColor(mainbutton.icon, 6603,A_0);ShowSpell(debutton.icon, 198664)   return end
end
end

if PandaDB.ZW_A9 ~= false  and Isuseable("碧愈疾风",196725) then
if Aura_time("PLAYER","碧愈疾风")==0 and GroupNeedHealth(95,10)>1 then ShowColor(mainbutton.icon, 6603,A_9);ShowSpell(debutton.icon, 196725) return end
end

if PandaDB.ZW_C5 ~= false  and Isuseable("精华之泉",191837)  then
if (SpellConut(191837)>=16 and GroupNeedHealth(80,40)>=3) or (SpellConut(191837)<16 and SpellConut(191837)>=8 and GroupNeedHealth(85,40)>=3) or (SpellConut(191837)<8 and GroupNeedHealth(90,40)>=3) then ShowColor(mainbutton.icon, 6603,C_5);ShowSpell(debutton.icon,191837) return end
end
end


--攻击组
if UnitExists("target") and UnitCanAttack('player',"target") then

if Teshuchuli() then
if PandaDB.ZW_A1 ~= false  and Isuseable("旭日东升踢",107428) then ShowColor(mainbutton.icon, 6603,A_1);ShowSpell(debutton.icon,107428) return end
if PandaDB.ZW_A6 ~= false  and Isuseable("幻灭踢",100784) then  ShowColor(mainbutton.icon, 6603,A_6) ;ShowSpell(debutton.icon, 100784) return end
if PandaDB.ZW_A2 ~= false  and Isuseable("猛虎掌",100780) then ShowColor(mainbutton.icon, 6603,A_2);ShowSpell(debutton.icon, 100780)  return end
end

--战斗前
if not InCombatLockdown() then
if PandaDB.ZW_A8 ~= false  and Isuseable("真气爆裂",123986) and Useing_spell("player") ~= 123986 then ShowColor(mainbutton.icon, 6603,A_8);ShowSpell(debutton.icon, 123986)   return end
if PandaDB.ZW_A7 ~= false  and Isuseable("真气波",115098) then ShowColor(mainbutton.icon, 6603,A_7);ShowSpell(debutton.icon, 115098)  return end
end

if PandaDB.ZW_C1 ~= false  and Isuseable("神鹤引项踢",101546) then
if active_enemies()>=3 then ShowColor(mainbutton.icon, 6603,C_1);ShowSpell(debutton.icon, 101546)  return end
end

if PandaDB.ZW_A8 ~= false  and Isuseable("真气爆裂",123986) and Useing_spell("player") ~= 123986 then ShowColor(mainbutton.icon, 6603,A_8);ShowSpell(debutton.icon, 123986)   return end
if PandaDB.ZW_A7 ~= false  and Isuseable("真气波",115098) then ShowColor(mainbutton.icon, 6603,A_7);ShowSpell(debutton.icon, 115098)  return end

if PandaDB.ZW_A1 ~= false  and Isuseable("旭日东升踢",107428) then ShowColor(mainbutton.icon, 6603,A_1);ShowSpell(debutton.icon,107428) return end
if PandaDB.ZW_A6 ~= false  and Isuseable("幻灭踢",100784) then  ShowColor(mainbutton.icon, 6603,A_6) ;ShowSpell(debutton.icon, 100784) return end
if PandaDB.ZW_A2 ~= false  and Isuseable("猛虎掌",100780) then ShowColor(mainbutton.icon, 6603,A_2);ShowSpell(debutton.icon, 100780)  return end

end

--目标治疗组
if UnitExists("target") and not UnitCanAttack('player',"target") then

--急救
if HealthPercent("target")<=50 then

if PandaDB.ZW_C6 ~= false  and Isuseable("作茧缚命",116849) then ShowColor(mainbutton.icon, 6603,C_6);ShowSpell(debutton.icon,116849) return end

if PandaDB.ZW_A4 ~= false and Isuseable("复苏之雾",115151) then
if UnitSpeed("player")>0 and Aura_time("target","复苏之雾","PLAYER|HELPFUL")==0 then ShowColor(mainbutton.icon, 6603,A_4);ShowSpell(debutton.icon, 115151)   return end
end

if PandaDB.ZW_A3 ~= false  and Isuseable("抚慰之雾",115175) then
if Useing_spell("player","抚慰之雾")==0 then ShowColor(mainbutton.icon, 6603,A_3);ShowSpell(debutton.icon, 115175) return end
end

if PandaDB.ZW_A5 ~= false  and Isuseable("氤氲之雾",124682) then
if Aura_time("target","氤氲之雾","PLAYER|HELPFUL")==0 then ShowColor(mainbutton.icon, 6603,A_5);ShowSpell(debutton.icon, 124682)   return end
end

if PandaDB.ZW_C4 ~= false  and Isuseable("活血术",116670)  then 
if HealthPercent("target")<=90 then ShowColor(mainbutton.icon, 6603,C_4);ShowSpell(debutton.icon,116670) return end
end

end
--平刷
if HealthPercent("target")>=50 then

if PandaDB.ZW_A4 ~= false  and Isuseable("复苏之雾",115151) then
if ( HealthPercent("target")>=60 or UnitSpeed("player")>0 ) and HealthPercent("target")<=95 and Aura_time("target","复苏之雾","PLAYER|HELPFUL")==0 then ShowColor(mainbutton.icon, 6603,A_4);ShowSpell(debutton.icon, 115151)   return end
end

if PandaDB.ZW_A3 ~= false  and Isuseable("抚慰之雾",115175) then
if Useing_spell("player","抚慰之雾")==0 then ShowColor(mainbutton.icon, 6603,A_3);ShowSpell(debutton.icon, 115175) return end
end

if PandaDB.ZW_A5 ~= false  and Isuseable("氤氲之雾",124682) then
if Aura_time("target","氤氲之雾","PLAYER|HELPFUL")==0 and ( HealthPercent("target")<=70 or HealthPercent("target")<=85 and Aura_time("player","生生不息（氤氲之雾）","PLAYER|HELPFUL")>0) then ShowColor(mainbutton.icon, 6603,A_5);ShowSpell(debutton.icon, 124682)   return end
end

if PandaDB.ZW_C4 ~= false  and Isuseable("活血术",116670)  then 
if HealthPercent("target")<=90 then ShowColor(mainbutton.icon, 6603,C_4);ShowSpell(debutton.icon,116670) return end
end

end

end

--自我治疗组
if not UnitExists("target") then
--急救
if HealthPercent("player")<=50 then

if PandaDB.ZW_C6 ~= false  and Isuseable("作茧缚命",116849) then TargetUnit("PLAYER") ; ShowColor(mainbutton.icon, 6603,C_6);ShowSpell(debutton.icon,116849) return end

if PandaDB.ZW_A4 ~= false  and Isuseable("复苏之雾",115151) then
if UnitSpeed("player")>0 and Aura_time("player","复苏之雾","PLAYER|HELPFUL")==0 then ShowColor(mainbutton.icon, 6603,A_4);ShowSpell(debutton.icon, 115151)   return end
end

if PandaDB.ZW_A3 ~= false  and Isuseable("抚慰之雾",115175) then
if Useing_spell("player","抚慰之雾")==0 then ShowColor(mainbutton.icon, 6603,A_3);ShowSpell(debutton.icon, 115175) return end
end

if PandaDB.ZW_A5 ~= false  and Isuseable("氤氲之雾",124682) then
if Aura_time("player","氤氲之雾","PLAYER|HELPFUL")==0 then ShowColor(mainbutton.icon, 6603,A_5);ShowSpell(debutton.icon, 124682)   return end
end

if PandaDB.ZW_C4 ~= false  and Isuseable("活血术",116670)  then 
if HealthPercent("player")<=90 then ShowColor(mainbutton.icon, 6603,C_4);ShowSpell(debutton.icon,116670) return end
end

end
--平刷
if HealthPercent("player")>=50 then

if PandaDB.ZW_A4 ~= false  and Isuseable("复苏之雾",115151) then
if ( HealthPercent("player")>=60 or UnitSpeed("player")>0 ) and HealthPercent("player")<=95 and Aura_time("player","复苏之雾","PLAYER|HELPFUL")==0 then ShowColor(mainbutton.icon, 6603,A_4);ShowSpell(debutton.icon, 115151)   return end
end

if PandaDB.ZW_A3 ~= false  and Isuseable("抚慰之雾",115175) then
if Useing_spell("player","抚慰之雾")==0 then ShowColor(mainbutton.icon, 6603,A_3);ShowSpell(debutton.icon, 115175) return end
end

if PandaDB.ZW_A5 ~= false  and Isuseable("氤氲之雾",124682) then
if Aura_time("player","氤氲之雾","PLAYER|HELPFUL")==0 and ( HealthPercent("player")<=70 or HealthPercent("player")<=85 and Aura_time("player","生生不息（氤氲之雾）","PLAYER|HELPFUL")>0) then ShowColor(mainbutton.icon, 6603,A_5);ShowSpell(debutton.icon, 124682)   return end
end

if PandaDB.ZW_C4 ~= false  and Isuseable("活血术",116670)  then 
if HealthPercent("player")<=90 then ShowColor(mainbutton.icon, 6603,C_4);ShowSpell(debutton.icon,116670) return end
end

end

end





	   
ShowColor(mainbutton.icon, 6603,108967);ShowSpell(debutton.icon, 311923)	   
   


--elseif not Authorization() then 
--print("|cffffe00a★Panda★:【|r|c00FF68CC 插件未激活 联系QQ:398371778 |r|cffffe00a】|r")
--end


end

end


local Monk_Wu = Monk_Wu
ns.Monk_Wu = Monk_Wu

