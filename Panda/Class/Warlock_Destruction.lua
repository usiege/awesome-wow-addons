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
--[[                    变量                              ]]--
---------------------------------------------------------------------------
local function Havoc()
local A=0
local B=0
local C = false
local talent_1 = IsTalent("地狱烈火")
local talent_2 = IsTalent("Internal Combustion")

if talent_1 then A = 1 else A = 0 end
if talent_1 and talent_2 then B = 1 else B = 0 end

local REA_1 = Rang_enemies_Aura(40,"浩劫") 
local REA_2 = Rang_enemies_Aura(40,"浩劫灾祸")
local ems = active_enemies() 

if ( REA_1>0 or REA_2>0 ) and  ems <= 5 - A + B  then C = true else C = false end

return C
end

local function variable_pool_soul_shards()
if active_enemies()>1 and SpellCooldown(80240)<=10 or SpellCooldown(1122)<=20 and (IsTalent("统御魔典") or IsTalent("黑暗灵魂：动荡") and SpellCooldown(113858)<=20) or IsTalent("黑暗灵魂：动荡") and SpellCooldown(113858)<=20 and (SpellCooldown(1122)>TTD() or SpellCooldown(1122)+180>TTD() ) then return true else return false end
end


local function Warlock_Destruction()  --更新主图标及技能提示图标

local mainbutton = PDUI.mainbutton
local debutton = PDUI.debutton

if PlayerClass() == "WARLOCK" and Specialization() == "毁灭" then
--if Authorization() then


--开始循环
--自动拾取器

---------------------------------------------------------------------------
--[[                       编辑区                       ]]--
---------------------------------------------------------------------------


--变量
local summon_infernal_23 = Spell_Later(1122,7,30)
local summon_infernal_30 = Spell_Later(1122,0,30)
local summon_infernal_15 = Spell_Later(1122,15,30)
local DisReCast = Useing_spell("player") ~= 152108 and Useing_spell("player") ~= 348 and Last_Spell(1)~=348 and Last_Spell(1)~=152108

--最高优先级
--打球/图腾
if Teshuchuli() then
if PandaDB.HMS_C2 ~= false and Isuseable("暗影灼烧",17877) then ShowColor(mainbutton.icon, 6603,C_2);ShowSpell(debutton.icon, 17877)  return end
if PandaDB.HMS_C6 ~= false  and Isuseable("吸取生命",234153) and Useing_spell("player") ~= 234153 then ShowColor(mainbutton.icon, 6603,C_6);ShowSpell(debutton.icon, 234153)  return end
if PandaDB.HMS_A1 ~= false  and Isuseable("烧尽",29722) then ShowColor(mainbutton.icon, 6603,A_1);ShowSpell(debutton.icon, 29722)  return end
end
--------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------

--战斗前
if not InCombatLockdown() then

if PandaDB.CcdSwitch ~= false  then
if PandaDB.HMS_A5 ~= false  and Isuseable("大灾变",152108) and DisReCast  then
if IsTalent("大灾变") then ShowColor(mainbutton.icon, 6603,A_5);ShowSpell(debutton.icon, 152108)  return end
end
end

if PandaDB.HMS_A3 ~= false  and Isuseable("献祭",348) and DisReCast then
if ( not IsTalent("大灾变") or  PandaDB.CcdSwitch == false ) and Aura_time("TARGET","献祭","PLAYER|HARMFUL") < 18*0.3 then ShowColor(mainbutton.icon, 6603,A_3);ShowSpell(debutton.icon, 348)  return end
end

if Power("SOUL_SHARDS") ~= PowerMax("SOUL_SHARDS") then
if PandaDB.HMS_A9 ~= false  and Isuseable("灵魂之火",6353) and Useing_spell("player") ~= 6353  then ShowColor(mainbutton.icon, 6603,A_9);ShowSpell(debutton.icon, 6353)  return end
if PandaDB.HMS_A1 ~= false  and Isuseable("烧尽",29722) and not IsTalent("灵魂之火") then ShowColor(mainbutton.icon, 6603,A_1);ShowSpell(debutton.icon, 29722)  return end
end

end


--------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------
--大招
--call_action_list,name=cds
if PandaDB.CcdSwitch ~= false  then

--艾泽拉斯之心精华
--essences
if PandaDB.HMS_C8 then
if Isuseable("仇敌之血","仇敌之血") then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.HMS_C8 then
if Isuseable("艾泽拉斯守护者","艾泽拉斯守护者") then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.HMS_C8 then
if Isuseable("不羁之力","不羁之力") then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.HMS_C8 then
if Isuseable("聚能艾泽里特射线","聚能艾泽里特射线") and Useing_spell("player") ~= 295258 and Aura_time("PLAYER","风火雷电")==0 and Aura_time("PLAYER","屏气凝神")==0 then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.HMS_C8 then
if Isuseable("火红烈焰","火红烈焰") then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.HMS_C8 then
if Isuseable("净化冲击","净化冲击") then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.HMS_C8 then
if Isuseable("世界血脉共鸣","世界血脉共鸣") then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.HMS_C8 then
if Isuseable("空间涟漪","空间涟漪") then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.HMS_C8 then
if Isuseable("清醒梦境之忆","清醒梦境之忆") then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.HMS_C8 then
if Isuseable("收割火焰","收割火焰")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.HMS_C8 then
if Isuseable("生命缚誓者之祈","生命缚誓者之祈")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.HMS_C8 then
if Isuseable("救世之魂","救世之魂")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.HMS_C8 then
if Isuseable("守护屏障","守护屏障")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.HMS_C8 then
if Isuseable("补充能量","补充能量")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.HMS_C8 then
if Isuseable("静滞","静滞")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.HMS_C8 then
if Isuseable("法力过载","法力过载")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.HMS_C8 then
if Isuseable("活力导管","活力导管")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.HMS_C8 then
if Isuseable("爆燃之拥","爆燃之拥")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.HMS_C8 then
if Isuseable("光荣时刻","光荣时刻")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.HMS_C8 then
if Isuseable("深渊之护","深渊之护")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.HMS_C8 then
if Isuseable("艾泽拉斯的不朽赐福","艾泽拉斯的不朽赐福")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.HMS_C8 then
if Isuseable("强化虚无屏障","强化虚无屏障")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end
---------------
if PandaDB.HMS_A7 ~= false  and Isuseable("召唤地狱火",1122) then ShowColor(mainbutton.icon, 6603,A_7);ShowSpell(debutton.icon, 1122)  return end

if PandaDB.HMS_A6 ~= false  and Isuseable("黑暗灵魂：动荡",113858) then
if Power("SOUL_SHARDS")>=2 and ((IsTalent("统御魔典") and summon_infernal_23) or (not IsTalent("统御魔典") and summon_infernal_30 )) then ShowColor(mainbutton.icon, 6603,A_6);ShowSpell(debutton.icon, 113858)  return end
end

end
--------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------

--浩劫内
--actions=call_action_list,name=havoc 
if Havoc() then

if PandaDB.HMS_A4 ~= false  and Isuseable("燃烧",17962) then
if Aura_time("PLAYER","爆燃")==0 and Power("SOUL_SHARDS")>=1 and Power("SOUL_SHARDS")<=4 then ShowColor(mainbutton.icon, 6603,A_4);ShowSpell(debutton.icon, 17962)  return end
end

if PandaDB.HMS_A3 ~= false  and Isuseable("献祭",348) and DisReCast then
if IsTalent("Internal Combustion") and Aura_time("TARGET","献祭","PLAYER|HARMFUL") < 18*0.5 or not IsTalent("Internal Combustion") and Aura_time("TARGET","献祭","PLAYER|HARMFUL") < 18*0.3 then ShowColor(mainbutton.icon, 6603,A_3);ShowSpell(debutton.icon, 348)  return end
end

if PandaDB.HMS_A2 ~= false  and Isuseable("混乱之箭",116858) then ShowColor(mainbutton.icon, 6603,A_2);ShowSpell(debutton.icon, 116858)  return end

if PandaDB.HMS_A9 ~= false  and Isuseable("灵魂之火",6353) and Useing_spell("player") ~= 6353  then ShowColor(mainbutton.icon, 6603,A_9);ShowSpell(debutton.icon, 6353)  return end

if PandaDB.HMS_C2 ~= false  and Isuseable("暗影灼烧",17877) then
if active_enemies() <3 or not IsTalent("硫磺烈火") then ShowColor(mainbutton.icon, 6603,C_2);ShowSpell(debutton.icon, 17877)  return end
end

if PandaDB.HMS_A1 ~= false  and Isuseable("烧尽",29722) then ShowColor(mainbutton.icon, 6603,A_1);ShowSpell(debutton.icon, 29722)  return end

end
--------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------
if PandaDB.CcdSwitch  ~= false then

if PandaDB.HMS_A5 ~= false  and Isuseable("大灾变",152108) and DisReCast  then
if IsTalent("大灾变") then ShowColor(mainbutton.icon, 6603,A_5);ShowSpell(debutton.icon, 152108)  return end
end

end
--------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------
--AOE
--actions+=/call_action_list,name=aoe
if active_enemies() > 2 and Rang_enemies_Aura(40,"浩劫灾祸") == 0 then 

if PandaDB.HMS_A0 ~= false  and Isuseable("火焰之雨",5740) then
if summon_infernal_30 and ( Aura_time("PLAYER","粉碎混沌") == 0 or not IsTalent("统御魔典") ) and active_enemies() >4 then ShowColor(mainbutton.icon, 6603,A_0);ShowSpell(debutton.icon, 5740)  return end
end 

if PandaDB.HMS_A8 ~= false and Isuseable("恶魔之火",196447) and Useing_spell("player") ~= 196447 then ShowColor(mainbutton.icon, 6603,A_8);ShowSpell(debutton.icon, 196447)  return end

if PandaDB.HMS_A3 ~= false  and Isuseable("献祭",348) and DisReCast then
if Aura_time("TARGET","献祭","PLAYER|HARMFUL") < 5 and ( not IsTalent("大灾变") or SpellCooldown(152108) > Aura_time("TARGET","献祭","PLAYER|HARMFUL") or  PandaDB.CcdSwitch == false ) then ShowColor(mainbutton.icon, 6603,A_3);ShowSpell(debutton.icon, 348)  return end
end
--------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------
if PandaDB.CcdSwitch ~= false  then
if PandaDB.HMS_C1 ~= false  and Isuseable("浩劫灾祸",200546) then ShowColor(mainbutton.icon, 6603,C_1);ShowSpell(debutton.icon, 200546)  return end
if PandaDB.HMS_C1 ~= false  and Isuseable("浩劫",80240) and not useable("浩劫灾祸") then
if active_enemies()<5 then ShowColor(mainbutton.icon, 6603,C_1);ShowSpell(debutton.icon, 80240)  return end
end
end

if PandaDB.HMS_A2 ~= false  and Isuseable("混乱之箭",116858) then
if IsTalent("统御魔典") and summon_infernal_30 and (Rang_enemies_Aura(40,"浩劫")>0 or IsTalent("大灾变") or IsTalent("地狱烈火") and active_enemies()<=4 ) then ShowColor(mainbutton.icon, 6603,A_2);ShowSpell(debutton.icon, 116858)  return end
end

if PandaDB.HMS_A0 ~= false  and Isuseable("火焰之雨",5740) then 
if active_enemies() > 4 then ShowColor(mainbutton.icon, 6603,A_0);ShowSpell(debutton.icon, 5740)  return end
end

if PandaDB.CcdSwitch ~= false  then
if PandaDB.HMS_C1 ~= false  and Isuseable("浩劫",80240) and not useable("浩劫灾祸") and active_enemies()<5 then
if ( not IsTalent("统御魔典") or not IsTalent("地狱烈火") or IsTalent("统御魔典") and summon_infernal_15 ) then ShowColor(mainbutton.icon, 6603,C_1);ShowSpell(debutton.icon, 80240)  return end
end
end

if PandaDB.HMS_A1 ~= false  and Isuseable("烧尽",29722) then
if IsTalent("硫磺烈火") and Aura_time("PLAYER","爆燃")>0 and Power("SOUL_SHARDS") < 5 - 2*active_enemies() then ShowColor(mainbutton.icon, 6603,A_1);ShowSpell(debutton.icon, 29722)  return end
end

if PandaDB.HMS_A9 ~= false  and Isuseable("灵魂之火",6353) and Useing_spell("player") ~= 6353   then ShowColor(mainbutton.icon, 6603,A_9);ShowSpell(debutton.icon, 6353)  return end

if PandaDB.HMS_A4 ~= false and Isuseable("燃烧",17962) then
if Aura_time("PLAYER","爆燃")==0 then ShowColor(mainbutton.icon, 6603,A_4);ShowSpell(debutton.icon, 17962)  return end
end

if PandaDB.HMS_C2 ~= false  and Isuseable("暗影灼烧",17877) then
if not IsTalent("硫磺烈火") then ShowColor(mainbutton.icon, 6603,C_2);ShowSpell(debutton.icon, 17877)  return end
end


end
--------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------
if PandaDB.HMS_A3 ~= false  and Isuseable("献祭",348) and DisReCast then
if Aura_time("TARGET","献祭","PLAYER|HARMFUL") <18*0.3 and ( not IsTalent("大灾变") or SpellCooldown(152108) > Aura_time("TARGET","献祭","PLAYER|HARMFUL") or  PandaDB.CcdSwitch == false  ) then ShowColor(mainbutton.icon, 6603,A_3);ShowSpell(debutton.icon, 348) return end
end

if PandaDB.HMS_A3 ~= false  and Isuseable("献祭",348)  and DisReCast then
if IsTalent("Internal Combustion") and Aura_time("TARGET","献祭","PLAYER|HARMFUL") <18*0.5 then ShowColor(mainbutton.icon, 6603,A_3);ShowSpell(debutton.icon, 348) return end
end
--------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------
--大招
--call_action_list,name=cds
if PandaDB.CcdSwitch ~= false  then

--艾泽拉斯之心精华
--essences
if PandaDB.HMS_C8 then
if Isuseable("仇敌之血","仇敌之血") then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.HMS_C8 then
if Isuseable("艾泽拉斯守护者","艾泽拉斯守护者") then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.HMS_C8 then
if Isuseable("不羁之力","不羁之力") then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.HMS_C8 then
if Isuseable("聚能艾泽里特射线","聚能艾泽里特射线") and Useing_spell("player") ~= 295258 and Aura_time("PLAYER","风火雷电")==0 and Aura_time("PLAYER","屏气凝神")==0 then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.HMS_C8 then
if Isuseable("火红烈焰","火红烈焰") then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.HMS_C8 then
if Isuseable("净化冲击","净化冲击") then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.HMS_C8 then
if Isuseable("世界血脉共鸣","世界血脉共鸣") then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.HMS_C8 then
if Isuseable("空间涟漪","空间涟漪") then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.HMS_C8 then
if Isuseable("清醒梦境之忆","清醒梦境之忆") then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.HMS_C8 then
if Isuseable("收割火焰","收割火焰")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.HMS_C8 then
if Isuseable("生命缚誓者之祈","生命缚誓者之祈")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.HMS_C8 then
if Isuseable("救世之魂","救世之魂")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.HMS_C8 then
if Isuseable("守护屏障","守护屏障")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.HMS_C8 then
if Isuseable("补充能量","补充能量")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.HMS_C8 then
if Isuseable("静滞","静滞")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.HMS_C8 then
if Isuseable("法力过载","法力过载")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.HMS_C8 then
if Isuseable("活力导管","活力导管")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.HMS_C8 then
if Isuseable("爆燃之拥","爆燃之拥")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.HMS_C8 then
if Isuseable("光荣时刻","光荣时刻")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.HMS_C8 then
if Isuseable("深渊之护","深渊之护")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.HMS_C8 then
if Isuseable("艾泽拉斯的不朽赐福","艾泽拉斯的不朽赐福")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.HMS_C8 then
if Isuseable("强化虚无屏障","强化虚无屏障")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.HMS_A7 ~= false  and Isuseable("召唤地狱火",1122) then ShowColor(mainbutton.icon, 6603,A_7);ShowSpell(debutton.icon, 1122)  return end

if PandaDB.HMS_A6 ~= false  and Isuseable("黑暗灵魂：动荡",113858) then
if Power("SOUL_SHARDS")>=2 and ((IsTalent("统御魔典") and summon_infernal_23) or (not IsTalent("统御魔典") and summon_infernal_30 )) then ShowColor(mainbutton.icon, 6603,A_6);ShowSpell(debutton.icon, 113858)  return end
end

end
--------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------
if PandaDB.HMS_A8 ~= false  and Isuseable("恶魔之火",196447) and Useing_spell("player") ~= 196447 then ShowColor(mainbutton.icon, 6603,A_8);ShowSpell(debutton.icon, 196447)  return end

if active_enemies()>1 then
if PandaDB.CcdSwitch ~= false  then
if PandaDB.HMS_C1 ~= false  and Isuseable("浩劫",80240) and not useable("浩劫灾祸") and active_enemies()<5 then ShowColor(mainbutton.icon, 6603,C_1);ShowSpell(debutton.icon, 80240)  return end
if PandaDB.HMS_C1 ~= false  and Isuseable("浩劫灾祸",200546) then ShowColor(mainbutton.icon, 6603,C_1);ShowSpell(debutton.icon, 200546)  return end
end
end



if PandaDB.HMS_A9 ~= false  and Isuseable("灵魂之火",6353) and Useing_spell("player") ~= 6353  then ShowColor(mainbutton.icon, 6603,A_9);ShowSpell(debutton.icon, 6353)  return end

if PandaDB.HMS_A4 ~= false  and Isuseable("燃烧",17962) then
if Aura_time("PLAYER","爆燃")==0 and  Power("SOUL_SHARDS") >= 1 and not variable_pool_soul_shards() then ShowColor(mainbutton.icon, 6603,A_4);ShowSpell(debutton.icon, 17962)  return end
end

if PandaDB.HMS_C2 ~= false  and Isuseable("暗影灼烧",17877) then
if Power("SOUL_SHARDS")<2 and ( not variable_pool_soul_shards() or SpellallCharges(17877)>1 ) then ShowColor(mainbutton.icon, 6603,C_2);ShowSpell(debutton.icon, 17877)  return end
end

if PandaDB.HMS_A2 ~= false  and Isuseable("混乱之箭",116858) then 
if ( IsTalent("统御魔典") and summon_infernal_30 or AzltE("粉碎混沌")>0 and Aura_time("PLAYER","粉碎混沌")>1 ) or Aura_time("PLAYER","黑暗灵魂：动荡")>0 then ShowColor(mainbutton.icon, 6603,A_2);ShowSpell(debutton.icon, 116858)  return end
end

if PandaDB.HMS_A2 ~= false  and Isuseable("混乱之箭",116858) then 
if not variable_pool_soul_shards() and not IsTalent("灭杀") then ShowColor(mainbutton.icon, 6603,A_2);ShowSpell(debutton.icon, 116858)  return end
end

if PandaDB.HMS_A2 ~= false  and Isuseable("混乱之箭",116858) then 
if not variable_pool_soul_shards() and IsTalent("灭杀") and ( Aura_time("TARGET","灭杀","PLAYER|HARMFUL")<3 or Aura_time("PLAYER","爆燃")>0 ) then ShowColor(mainbutton.icon, 6603,A_2);ShowSpell(debutton.icon, 116858)  return end
end

if PandaDB.HMS_A2 ~= false  and Isuseable("混乱之箭",116858) then 
if Power("SOUL_SHARDS") >= 4 then ShowColor(mainbutton.icon, 6603,A_2);ShowSpell(debutton.icon, 116858)  return end
end

if PandaDB.HMS_A4 ~= false  and Isuseable("燃烧",17962) then
if SpellallCharges(17962)>1 then ShowColor(mainbutton.icon, 6603,A_4);ShowSpell(debutton.icon, 17962)  return end
end

if PandaDB.HMS_A1 ~= false  and Isuseable("烧尽",29722) then ShowColor(mainbutton.icon, 6603,A_1);ShowSpell(debutton.icon, 29722)  return end





---------------------------------------------------------------------------
--[[                       编辑区                       ]]--
---------------------------------------------------------------------------

ShowColor(mainbutton.icon, 6603,6603);ShowSpell(debutton.icon, 311923)	

--elseif not Authorization() then 
--print("|cffffe00a★Panda★:【|r|c00FF68CC 插件未激活 联系QQ:398371778 |r|cffffe00a】|r")

--end


end


end

local Warlock_Destruction = Warlock_Destruction
ns.Warlock_Destruction = Warlock_Destruction


