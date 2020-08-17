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
--[[                    术士变量                              ]]--
---------------------------------------------------------------------------

local function Soul_full()
if (Useing_spell("player") == 686 or Useing_spell("player") == 29722) and PowerMax("SOUL_SHARDS")-Power("SOUL_SHARDS")<=1 then
return true else return false
end
end


local function Warlock_Demonology()  --更新主图标及技能提示图标

local mainbutton = PDUI.mainbutton
local debutton = PDUI.debutton

if PlayerClass() == "WARLOCK" and Specialization() == "恶魔学识" then
--if Authorization() then


--开始循环
--自动拾取器

---------------------------------------------------------------------------
--[[                       编辑区                       ]]--
---------------------------------------------------------------------------

--变量
local summon_dreadstalkers_12 = Spell_Later(104316,0,12)

--最高优先级
----------------------------------------------
if PandaDB.CcdSwitch  ~= false then
if PandaDB.EMS_A7 ~= false  and Isuseable("召唤恶魔暴君",265187) and Useing_spell("player") ~= 265187 then
if IsTalent("恶魔吞噬") and SpellConut(196277)>=9 and Power("SOUL_SHARDS")<3 then ShowColor(mainbutton.icon, 6603,A_7);ShowSpell(debutton.icon, 265187)  return end
end
end

--召唤宠物
if Summon_Pet() and (Spell_Later(30146,2) or Spell_Later(112870,2) or Last_Spell(1)~=30146 and Last_Spell(1)~=112870) then

if PandaDB.EMS_C7 ~= false  and Isuseable("召唤愤怒卫士",112870) and Useing_spell("player") ~= 112870 then
if Power("SOUL_SHARDS")~=0 then ShowColor(mainbutton.icon, 6603,C_7);ShowSpell(debutton.icon, 112870)  return end

elseif PandaDB.EMS_C7 ~= false  and Isuseable("召唤恶魔卫士",30146) and Useing_spell("player") ~= 30146 then
if Power("SOUL_SHARDS")~=0 then ShowColor(mainbutton.icon, 6603,C_7);ShowSpell(debutton.icon, 30146)  return end

elseif PandaDB.EMS_C4 ~= false  and Isuseable("暗影箭",686)  and not Soul_full() and Power("SOUL_SHARDS")==0 then ShowColor(mainbutton.icon, 6603,C_4);ShowSpell(debutton.icon, 686)  return end

end


--打球/图腾
if Teshuchuli() then
if PandaDB.EMS_C2 ~= false  and Isuseable("灵魂打击",264057) then ShowColor(mainbutton.icon, 6603,C_2);ShowSpell(debutton.icon, 264057)  return end
if PandaDB.EMS_A2 ~= false  and Isuseable("恶魔之箭",264178) and Useing_spell("player") ~= 264178  then 
if Power("SOUL_SHARDS")<=3 and Aura_Stack("PLAYER","恶魔之核")>0 then ShowColor(mainbutton.icon, 6603,A_2);ShowSpell(debutton.icon, 264178)  return end
end
if PandaDB.EMS_C6 ~= false  and Isuseable("吸取生命",234153) and Useing_spell("player") ~= 234153 then ShowColor(mainbutton.icon, 6603,C_6);ShowSpell(debutton.icon, 234153)  return end
end
----------------------------------------------

--战斗前
if not InCombatLockdown() then
--防溢出
if PandaDB.EMS_A1 ~= false  and Isuseable("古尔丹之手",105174) and Useing_spell("player") ~= 105174 then
if Power("SOUL_SHARDS")==PowerMax("SOUL_SHARDS") then ShowColor(mainbutton.icon, 6603,A_1);ShowSpell(debutton.icon, 105174)  return end
end

if PandaDB.EMS_A1 ~= false  and Isuseable("古尔丹之手",105174) and Useing_spell("player") ~= 105174 then
if Soul_full() then ShowColor(mainbutton.icon, 6603,A_1);ShowSpell(debutton.icon, 105174)  return end
end
if PandaDB.EMS_C4 ~= false  and Isuseable("暗影箭",686)  and not Soul_full() and Useing_spell("player") ~= 686 and PowerMax("SOUL_SHARDS")-Power("SOUL_SHARDS")==1 then ShowColor(mainbutton.icon, 6603,C_4);ShowSpell(debutton.icon, 686)  return end
if PandaDB.EMS_A2 ~= false  and Isuseable("恶魔之箭",264178) and Useing_spell("player") ~= 264178 and PowerMax("SOUL_SHARDS")-Power("SOUL_SHARDS")>=2 and IsBoss("target") then ShowColor(mainbutton.icon, 6603,A_2);ShowSpell(debutton.icon, 264178)  return end
if PandaDB.EMS_C4 ~= false  and Isuseable("暗影箭",686)  and not Soul_full() and Useing_spell("player") ~= 686 and Power("SOUL_SHARDS")<=PowerMax("SOUL_SHARDS") and not IsBoss("target") then ShowColor(mainbutton.icon, 6603,C_4);ShowSpell(debutton.icon, 686)  return end
end

----------------------------------------------
if PandaDB.CcdSwitch ~= false  then
--艾泽拉斯之心精华
--essences
if PandaDB.EMS_C8 then
if Isuseable("仇敌之血","仇敌之血") then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.EMS_C8 then
if Isuseable("艾泽拉斯守护者","艾泽拉斯守护者") then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.EMS_C8 then
if Isuseable("不羁之力","不羁之力") then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.EMS_C8 then
if Isuseable("聚能艾泽里特射线","聚能艾泽里特射线") and Useing_spell("player") ~= 295258 and Aura_time("PLAYER","风火雷电")==0 and Aura_time("PLAYER","屏气凝神")==0 then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.EMS_C8 then
if Isuseable("火红烈焰","火红烈焰") then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.EMS_C8 then
if Isuseable("净化冲击","净化冲击") then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.EMS_C8 then
if Isuseable("世界血脉共鸣","世界血脉共鸣") then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.EMS_C8 then
if Isuseable("空间涟漪","空间涟漪") then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.EMS_C8 then
if Isuseable("清醒梦境之忆","清醒梦境之忆") then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.EMS_C8 then
if Isuseable("收割火焰","收割火焰")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.EMS_C8 then
if Isuseable("生命缚誓者之祈","生命缚誓者之祈")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.EMS_C8 then
if Isuseable("救世之魂","救世之魂")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.EMS_C8 then
if Isuseable("守护屏障","守护屏障")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.EMS_C8 then
if Isuseable("补充能量","补充能量")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.EMS_C8 then
if Isuseable("静滞","静滞")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.EMS_C8 then
if Isuseable("法力过载","法力过载")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.EMS_C8 then
if Isuseable("活力导管","活力导管")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.EMS_C8 then
if Isuseable("爆燃之拥","爆燃之拥")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.EMS_C8 then
if Isuseable("光荣时刻","光荣时刻")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.EMS_C8 then
if Isuseable("深渊之护","深渊之护")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.EMS_C8 then
if Isuseable("艾泽拉斯的不朽赐福","艾泽拉斯的不朽赐福")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.EMS_C8 then
if Isuseable("强化虚无屏障","强化虚无屏障")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

end

--防溢出
if PandaDB.EMS_A1 ~= false  and Isuseable("古尔丹之手",105174) and Useing_spell("player") ~= 105174 then
if Power("SOUL_SHARDS")==PowerMax("SOUL_SHARDS") then ShowColor(mainbutton.icon, 6603,A_1);ShowSpell(debutton.icon, 105174)  return end
end

if PandaDB.EMS_A1 ~= false  and Isuseable("古尔丹之手",105174) and Useing_spell("player") ~= 105174 then
if Soul_full() then ShowColor(mainbutton.icon, 6603,A_1);ShowSpell(debutton.icon, 105174)  return end
end

----------------------------------------------
--/call_action_list,name=dcon_opener
if not IsTalent("虚空传送门") and time_x(30) and SpellCooldown(265187)==0 then

if PandaDB.CcdSwitch ~= false  then
if PandaDB.EMS_A7 ~= false  and Isuseable("召唤恶魔暴君",265187) and Useing_spell("player") ~= 265187 then
if SpellConut(196277)>=3 and Power("SOUL_SHARDS")<3 and ((Prev_Spell(1)==105174 and Prev_Spell(2)==105174) or (Prev_Spell(1)==105174 and Prev_Spell(2)==264057 and Prev_Spell(3)==105174) or (Prev_Spell(1)==105174 and Prev_Spell(2)==264178 and Prev_Spell(3)==105174)) then ShowColor(mainbutton.icon, 6603,A_7);ShowSpell(debutton.icon, 265187)  return end
end
end

if PandaDB.EMS_C2 ~= false  and Isuseable("灵魂打击",264057) then 
if Prev_Spell(1)==105174 and Power("SOUL_SHARDS")<3 then ShowColor(mainbutton.icon, 6603,C_2);ShowSpell(debutton.icon, 264057)  return end
end

if PandaDB.EMS_A1 ~= false  and Isuseable("古尔丹之手",105174) and Useing_spell("player") ~= 105174 then
if Power("SOUL_SHARDS")>=2 and AzltE("爆破潜能")>0 then ShowColor(mainbutton.icon, 6603,A_1);ShowSpell(debutton.icon, 105174)  return end
end

--[[
if not PandaDB.CcdSwitch then
if Isuseable("内爆",196277) then
if AzltE("爆破潜能")>0 and SpellConut(196277)>2 and Aura_time("PLAYER","爆破潜能")==0 then ShowColor(mainbutton.icon, 6603,A_4);ShowSpell(debutton.icon, 196277)  return end
end
end
--]]
if PandaDB.EMS_A9 ~= false  and Isuseable("厄运",265412) then
if Aura_time("TARGET","厄运","PLAYER|HARMFUL") == 0 then ShowColor(mainbutton.icon, 6603,A_9);ShowSpell(debutton.icon, 265412)  return end
end

if PandaDB.EMS_A1 ~= false  and Isuseable("古尔丹之手",105174) and Useing_spell("player") ~= 105174 then
if Prev_Spell(1)==105174 and Power("SOUL_SHARDS")>=2 and Prev_Spell(2)==264057 then ShowColor(mainbutton.icon, 6603,A_1);ShowSpell(debutton.icon, 105174)  return end
end

if PandaDB.CcdSwitch ~= false  then
if PandaDB.EMS_C1 ~= false  and Isuseable("恶魔力量",267171) and Aura_time("PET","魔刃风暴")==0 then 
if Prev_Spell(1)==105174 and Prev_Spell(2)~=105174 and SpellConut(196277)>1 then ShowColor(mainbutton.icon, 6603,C_1);ShowSpell(debutton.icon, 267171)  return end
end
end

if PandaDB.EMS_A8 ~= false  and Isuseable("灾怨轰炸",267211) then ShowColor(mainbutton.icon, 6603,A_8);ShowSpell(debutton.icon, 267211)  return end

if PandaDB.EMS_C2 ~= false  and Isuseable("灵魂打击",264057) then 
if not IsBloodlust() or time_d(5) and Prev_Spell(1)==105174 then ShowColor(mainbutton.icon, 6603,C_2);ShowSpell(debutton.icon, 264057)  return end
end

if PandaDB.EMS_A3 ~= false  and Isuseable("召唤邪犬",264119) and Useing_spell("player") ~= 264119 then
if Power("SOUL_SHARDS")==5 then ShowColor(mainbutton.icon, 6603,A_3);ShowSpell(debutton.icon, 264119) return end
end

if PandaDB.CcdSwitch ~= false  then
if PandaDB.EMS_A6 ~= false  and Isuseable("魔典：恶魔卫士",111898) then
if Power("SOUL_SHARDS")==5 then ShowColor(mainbutton.icon, 6603,A_6);ShowSpell(debutton.icon, 111898)  return end
end
end

if PandaDB.EMS_A5 ~= false  and Isuseable("召唤恐惧猎犬",104316) and Useing_spell("player") ~= 104316 then
if Power("SOUL_SHARDS")==5 then ShowColor(mainbutton.icon, 6603,A_5);ShowSpell(debutton.icon, 104316)  return end
end

if PandaDB.EMS_A1 ~= false  and Isuseable("古尔丹之手",105174) and Useing_spell("player") ~= 105174 then
if Power("SOUL_SHARDS")==5 then ShowColor(mainbutton.icon, 6603,A_1);ShowSpell(debutton.icon, 105174)  return end
end

if PandaDB.EMS_A1 ~= false  and Isuseable("古尔丹之手",105174) and Useing_spell("player") ~= 105174 then
if Power("SOUL_SHARDS")>=3 and Prev_Spell(2)==105174 and time_d(5) and (Prev_Spell(1)==264057 or not IsTalent("灵魂打击") and Prev_Spell(1)==686) then ShowColor(mainbutton.icon, 6603,A_1);ShowSpell(debutton.icon, 105174)  return end
end

if PandaDB.EMS_C2 ~= false  and Isuseable("灵魂打击",264057) then 
if Prev_Spell(1)==105174 and Power("SOUL_SHARDS")==2 then ShowColor(mainbutton.icon, 6603,C_2);ShowSpell(debutton.icon, 264057)  return end
end

if PandaDB.CcdSwitch ~= false  then
if PandaDB.EMS_A7 ~= false  and Isuseable("召唤恶魔暴君",265187) and Useing_spell("player") ~= 265187 then
if SpellConut(196277)>=3 and Power("SOUL_SHARDS")<3 and (Prev_Spell(1)==267171 or Prev_Spell(1)==105174 and Prev_Spell(2)==105174 or not IsTalent("恶魔力量") and SpellConut(196277) + (2000/GetHaste()*100) >=6) then ShowColor(mainbutton.icon, 6603,A_7);ShowSpell(debutton.icon, 265187)  return end
end
end

if PandaDB.EMS_A2 ~= false  and Isuseable("恶魔之箭",264178) and Useing_spell("player") ~= 264178  then 
if Power("SOUL_SHARDS")<=3 and Aura_time("PLAYER","恶魔之核")>0 then ShowColor(mainbutton.icon, 6603,A_2);ShowSpell(debutton.icon, 264178)  return end
end
--/call_action_list,name=build_a_shard
if PandaDB.EMS_C2 ~= false  and Isuseable("灵魂打击",264057) then
if not IsTalent("恶魔吞噬") or time_d(15) or Prev_Spell(1)==105174 and not IsBloodlust() then ShowColor(mainbutton.icon, 6603,C_2);ShowSpell(debutton.icon, 264057)  return end
end
if PandaDB.EMS_C4 ~= false  and Isuseable("暗影箭",686)  and not Soul_full() and Power("SOUL_SHARDS")<PowerMax("SOUL_SHARDS")  then ShowColor(mainbutton.icon, 6603,C_4);ShowSpell(debutton.icon, 686)  return end

end
----------------------------------------------
----------------------------------------------

if PandaDB.EMS_A1 ~= false  and Isuseable("古尔丹之手",105174) and Useing_spell("player") ~= 105174 then
if AzltE("爆破潜能")>0 and time_x(5) and Power("SOUL_SHARDS") >2 and  Aura_time("PLAYER","爆破潜能")==0 and SpellConut(196277)<3 and Prev_Spell(1)~=105174 and Prev_Spell(2)~=105174 then ShowColor(mainbutton.icon, 6603,A_1);ShowSpell(debutton.icon, 105174)  return end
end

if PandaDB.EMS_A2 ~= false and Isuseable("恶魔之箭",264178) and Useing_spell("player") ~= 264178  then 
if Power("SOUL_SHARDS")<=3 and Aura_time("PLAYER","恶魔之核")>0 and Aura_Stack("PLAYER","恶魔之核")==4 then ShowColor(mainbutton.icon, 6603,A_2);ShowSpell(debutton.icon, 264178)  return end
end

if PandaDB.EMS_A4 ~= false  and Isuseable("内爆",196277) then
if AzltE("爆破潜能")>0 and SpellConut(196277)>2 and Aura_time("PLAYER","爆破潜能")<cast_time(686) and ( not IsTalent("恶魔吞噬") or SpellCooldown(265187)>12 ) then ShowColor(mainbutton.icon, 6603,A_4);ShowSpell(debutton.icon, 196277)  return end
end

if PandaDB.EMS_A9 ~= false  and Isuseable("厄运",265412) then
if Aura_time("TARGET","厄运","PLAYER|HARMFUL") == 0 and TTD()>30 and active_enemies()<2 and Aura_time("PLAYER","虚空传送门")==0 then ShowColor(mainbutton.icon, 6603,A_9);ShowSpell(debutton.icon, 265412)  return end
end

if PandaDB.EMS_A8 ~= false  and Isuseable("灾怨轰炸",267211) then
if AzltE("爆破潜能")>0 and time_x(10) and active_enemies()<2 and summon_dreadstalkers_12 and IsTalent("虚空传送门") then ShowColor(mainbutton.icon, 6603,A_8);ShowSpell(debutton.icon, 267211)  return end
end

if PandaDB.CcdSwitch ~= false  then
if PandaDB.EMS_C1 ~= false  and Isuseable("恶魔力量",267171) and Aura_time("PET","魔刃风暴")==0 then 
if ( SpellConut(196277)<6 or Aura_time("PLAYER","恶魔之力")>0 ) or active_enemies()<2 then ShowColor(mainbutton.icon, 6603,C_1);ShowSpell(debutton.icon, 267171)  return end
end
end

------------------------------------
------------------------------------
--call_action_list,name=nether_portal
if IsTalent("虚空传送门") and active_enemies()<=2 then
------------------------------------
--call_action_list,name=nether_portal_building
if SpellCooldown(267217)<20 and PandaDB.CcdSwitch ~= false  then

if PandaDB.EMS_C5 ~= false  and Isuseable("虚空传送门",267217) and Useing_spell("player") ~= 267217 then 
if Power("SOUL_SHARDS")>=5 then ShowColor(mainbutton.icon, 6603,C_5);ShowSpell(debutton.icon, 267217)  return end
end

if PandaDB.EMS_A5 ~= false  and Isuseable("召唤恐惧猎犬",104316) and Useing_spell("player") ~= 104316 and time_d(30) then ShowColor(mainbutton.icon, 6603,A_5);ShowSpell(debutton.icon, 104316)  return end

if PandaDB.EMS_A1 ~= false  and Isuseable("古尔丹之手",105174) and Useing_spell("player") ~= 105174 then
if time_d(30) and SpellCooldown(104316)>18 and Power("SOUL_SHARDS")>=3 then ShowColor(mainbutton.icon, 6603,A_1);ShowSpell(debutton.icon, 105174)  return end
end

if PandaDB.EMS_A0 ~= false  and Isuseable("能量虹吸",264130) then 
if time_d(30) and SpellConut(196277)>=2 and Aura_Stack("PLAYER","恶魔之核")<=2 and Aura_time("PLAYER","恶魔之力")==0 and Power("SOUL_SHARDS")>=3 then ShowColor(mainbutton.icon, 6603,A_0);ShowSpell(debutton.icon, 264130)  return end
end

if PandaDB.EMS_A1 ~= false  and Isuseable("古尔丹之手",105174) and Useing_spell("player") ~= 105174 then
if time_d(30) and Power("SOUL_SHARDS")>=5 then ShowColor(mainbutton.icon, 6603,A_1);ShowSpell(debutton.icon, 105174)  return end
end

--/call_action_list,name=build_a_shard
if PandaDB.EMS_C2 ~= false  and Isuseable("灵魂打击",264057) then
if not IsTalent("恶魔吞噬") or time_d(15) or Prev_Spell(1)==105174 and not IsBloodlust() then ShowColor(mainbutton.icon, 6603,C_2);ShowSpell(debutton.icon, 264057)  return end
end
if PandaDB.EMS_C4 ~= false  and Isuseable("暗影箭",686)  and not Soul_full() and Power("SOUL_SHARDS")<PowerMax("SOUL_SHARDS")  then ShowColor(mainbutton.icon, 6603,C_4);ShowSpell(debutton.icon, 686)  return end

------------------------------------
--/call_action_list,name=nether_portal_active
elseif SpellCooldown(267217)>165 or  PandaDB.CcdSwitch  == false then

if PandaDB.EMS_A8 ~= false  and Isuseable("灾怨轰炸",267211) then ShowColor(mainbutton.icon, 6603,A_8);ShowSpell(debutton.icon, 267211)  return end

if PandaDB.CcdSwitch ~= false  then
if PandaDB.EMS_A6 ~= false  and Isuseable("魔典：恶魔卫士",111898) then ShowColor(mainbutton.icon, 6603,A_6);ShowSpell(debutton.icon, 111898)  return end
end

if PandaDB.EMS_A3 ~= false  and Isuseable("召唤邪犬",264119) and Useing_spell("player") ~= 264119 then 
if SpellCooldown(265187)>40 or SpellCooldown(265187)<12 then ShowColor(mainbutton.icon, 6603,A_3);ShowSpell(debutton.icon, 264119) return end
end

if PandaDB.EMS_A5 ~= false  and Isuseable("召唤恐惧猎犬",104316) and Useing_spell("player") ~= 104316 then 
if (SpellCooldown(265187)<9 and Aura_time("PLAYER","魔性征召")>0) or (SpellCooldown(265187)<11 and Aura_time("PLAYER","魔性征召")==0) or SpellCooldown(265187)>14 then ShowColor(mainbutton.icon, 6603,A_5);ShowSpell(debutton.icon, 104316)  return end
end

if  Power("SOUL_SHARDS")==1 and (SpellCooldown(104316)<cast_time(686) or (IsTalent("灾怨轰炸") and SpellCooldown(267211)<cast_time(686)) ) then
--/call_action_list,name=build_a_shard
if PandaDB.EMS_C2 ~= false  and Isuseable("灵魂打击",264057) then
if not IsTalent("恶魔吞噬") or time_d(15) or Prev_Spell(1)==105174 and not IsBloodlust() then ShowColor(mainbutton.icon, 6603,C_2);ShowSpell(debutton.icon, 264057)  return end
end
if PandaDB.EMS_C4 ~= false  and Isuseable("暗影箭",686)  and not Soul_full() and Power("SOUL_SHARDS")<PowerMax("SOUL_SHARDS")  then ShowColor(mainbutton.icon, 6603,C_4);ShowSpell(debutton.icon, 686)  return end
end

if PandaDB.EMS_A1 ~= false  and Isuseable("古尔丹之手",105174) and Useing_spell("player") ~= 105174 and Power("SOUL_SHARDS")>=2 then
if ( (SpellCooldown(104316)>cast_time(264178) ) and ( SpellCooldown(104316)>cast_time(686) ) ) and SpellCooldown(267217)>(165+cast_time(105174)) or PandaDB.CcdSwitch == false  then ShowColor(mainbutton.icon, 6603,A_1);ShowSpell(debutton.icon, 105174)  return end
end

if PandaDB.CcdSwitch ~= false  then
if PandaDB.EMS_A7 ~= false  and Isuseable("召唤恶魔暴君",265187) and Useing_spell("player") ~= 265187  then
if Aura_time("PLAYER","虚空传送门")<5 or Power("SOUL_SHARDS")==0 then ShowColor(mainbutton.icon, 6603,A_7);ShowSpell(debutton.icon, 265187)  return end
end
if PandaDB.EMS_A7 ~= false  and Isuseable("召唤恶魔暴君",265187) and Useing_spell("player") ~= 265187  then
if Aura_time("PLAYER","虚空传送门")<cast_time(265187)+0.5 then ShowColor(mainbutton.icon, 6603,A_7);ShowSpell(debutton.icon, 265187)  return end
end
end

if PandaDB.EMS_A2 ~= false  and Isuseable("恶魔之箭",264178) and Useing_spell("player") ~= 264178  then 
if Aura_time("PLAYER","恶魔之核")>0 and Power("SOUL_SHARDS")<=3 then ShowColor(mainbutton.icon, 6603,A_2);ShowSpell(debutton.icon, 264178)  return end
end
--/call_action_list,name=build_a_shard
if PandaDB.EMS_C2 ~= false  and Isuseable("灵魂打击",264057) then
if not IsTalent("恶魔吞噬") or time_d(15) or Prev_Spell(1)==105174 and not IsBloodlust() then ShowColor(mainbutton.icon, 6603,C_2);ShowSpell(debutton.icon, 264057)  return end
end
if PandaDB.EMS_C4 ~= false  and Isuseable("暗影箭",686)  and not Soul_full() and Power("SOUL_SHARDS")<PowerMax("SOUL_SHARDS")  then ShowColor(mainbutton.icon, 6603,C_4);ShowSpell(debutton.icon, 686)  return end

end



end

--/call_action_list,name=implosion
if active_enemies()>1 then

if PandaDB.EMS_A4 ~= false  and Isuseable("内爆",196277) then
if (SpellConut(196277)>=6 and (Power("SOUL_SHARDS")<3 or Prev_Spell(1)==104316 or SpellConut(196277)>=9 or Prev_Spell(1)==267211 or ( Prev_Spell(1)~=105174 and Prev_Spell(2)~=105174 )) and Prev_Spell(1)~=105174 and Prev_Spell(2)~=105174 and Aura_time("PLAYER","恶魔之力")==0) or ( TTD()<3 and SpellConut(196277)>0) or (Prev_Spell(2)==104316 and SpellConut(196277)>2 and not IsTalent("魔性征召") ) then ShowColor(mainbutton.icon, 6603,A_4);ShowSpell(debutton.icon, 196277)  return end
end

if PandaDB.CcdSwitch ~= false  then
if PandaDB.EMS_A6 ~= false  and Isuseable("魔典：恶魔卫士",111898) then ShowColor(mainbutton.icon, 6603,A_6);ShowSpell(debutton.icon, 111898)  return end
end

if PandaDB.EMS_A5 ~= false  and Isuseable("召唤恐惧猎犬",104316) and Useing_spell("player") ~= 104316 then
if (SpellCooldown(265187)<9 and Aura_time("PLAYER","魔性征召")>0) or (SpellCooldown(265187)<11 and Aura_time("PLAYER","魔性征召")==0 ) or SpellCooldown(265187)>14 or  PandaDB.CcdSwitch == false  then ShowColor(mainbutton.icon, 6603,A_5);ShowSpell(debutton.icon, 104316)  return end
end

if PandaDB.CcdSwitch ~= false  and active_enemies()>=3 then
if PandaDB.EMS_A7 ~= false  and Isuseable("召唤恶魔暴君",265187) and Useing_spell("player") ~= 265187 and ( Power("SOUL_SHARDS")<3 or AzltE("怨毒祷告") == 0 ) then ShowColor(mainbutton.icon, 6603,A_7);ShowSpell(debutton.icon, 265187)  return end
end

if PandaDB.EMS_A1 ~= false  and Isuseable("古尔丹之手",105174) and Useing_spell("player") ~= 105174 then
if Power("SOUL_SHARDS")>=5 then ShowColor(mainbutton.icon, 6603,A_1);ShowSpell(debutton.icon, 105174)  return end
end

if PandaDB.EMS_A1 ~= false  and Isuseable("古尔丹之手",105174) and Useing_spell("player") ~= 105174 then
if Power("SOUL_SHARDS")>=3 and (((Prev_Spell(2)==105174 or SpellConut(196277)>=3 ) and SpellConut(196277)<9 ) or (SpellCooldown(265187)<GCD_MAX()*2 or  PandaDB.CcdSwitch == false  ) or Aura_time("PLAYER","恶魔之力")>GCD_MAX()*2) then ShowColor(mainbutton.icon, 6603,A_1);ShowSpell(debutton.icon, 105174)  return end
end

if PandaDB.EMS_A2 ~= false  and Isuseable("恶魔之箭",264178) and Useing_spell("player") ~= 264178  then 
if Prev_Spell(1)==105174 and Power("SOUL_SHARDS")>=1 and (SpellConut(196277)<=3 or Prev_Spell(3)==105174 ) and Power("SOUL_SHARDS")<4 and Aura_time("PLAYER","恶魔之核")>0 then ShowColor(mainbutton.icon, 6603,A_2);ShowSpell(debutton.icon, 264178)  return end
end

if PandaDB.EMS_A3 ~= false  and Isuseable("召唤邪犬",264119) and Useing_spell("player") ~= 264119 then 
if (SpellCooldown(265187)>40 and active_enemies()<=2) or SpellCooldown(265187)<12 or  PandaDB.CcdSwitch == false  then ShowColor(mainbutton.icon, 6603,A_3);ShowSpell(debutton.icon, 264119) return end
end

if PandaDB.EMS_A8 ~= false  and Isuseable("灾怨轰炸",267211) then 
if SpellCooldown(265187)>9 or  PandaDB.CcdSwitch == false  then ShowColor(mainbutton.icon, 6603,A_8);ShowSpell(debutton.icon, 267211)  return end
end

if PandaDB.EMS_C2 ~= false  and Isuseable("灵魂打击",264057) then
if Power("SOUL_SHARDS")<5 and Aura_Stack("PLAYER","恶魔之核")<=2 then ShowColor(mainbutton.icon, 6603,C_2);ShowSpell(debutton.icon, 264057)  return end
end

if PandaDB.EMS_A2 ~= false  and Isuseable("恶魔之箭",264178) and Useing_spell("player") ~= 264178  then 
if Power("SOUL_SHARDS")<=3 and Aura_time("PLAYER","恶魔之核")>0 and (Aura_Stack("PLAYER","恶魔之核")>=3 or Aura_time("PLAYER","恶魔之核")<=GCD_MAX()*5.7) then ShowColor(mainbutton.icon, 6603,A_2);ShowSpell(debutton.icon, 264178)  return end
end

if PandaDB.EMS_A9 ~= false and Isuseable("厄运",265412) then
if IsTalent("厄运") and Aura_time("TARGET","厄运","PLAYER|HARMFUL")<24*0.3 then ShowColor(mainbutton.icon, 6603,A_9);ShowSpell(debutton.icon, 265412)  return end
end

--/call_action_list,name=build_a_shard
if PandaDB.EMS_C2 ~= false  and Isuseable("灵魂打击",264057) then
if not IsTalent("恶魔吞噬") or time_d(15) or Prev_Spell(1)==105174 and not IsBloodlust() then ShowColor(mainbutton.icon, 6603,C_2);ShowSpell(debutton.icon, 264057)  return end
end
if PandaDB.EMS_C4 ~= false  and Isuseable("暗影箭",686) and not Soul_full() and Power("SOUL_SHARDS")<PowerMax("SOUL_SHARDS")  then ShowColor(mainbutton.icon, 6603,C_4);ShowSpell(debutton.icon, 686)  return end

end

if PandaDB.CcdSwitch ~= false  then
if PandaDB.EMS_A6 ~= false  and Isuseable("魔典：恶魔卫士",111898) then
if TTD()>120 or TTD()<SpellCooldown(265187)+15 or SpellCooldown(265187)<13 then ShowColor(mainbutton.icon, 6603,A_6);ShowSpell(debutton.icon, 111898)  return end
end
end

if PandaDB.EMS_A3 ~= false  and Isuseable("召唤邪犬",264119) and Useing_spell("player") ~= 264119 then
if SpellCooldown(265187)>40 or SpellCooldown(265187)<12 or  PandaDB.CcdSwitch == false  then ShowColor(mainbutton.icon, 6603,A_3);ShowSpell(debutton.icon, 264119) return end
end

if PandaDB.EMS_A5 ~= false  and Isuseable("召唤恐惧猎犬",104316) and Useing_spell("player") ~= 104316 then
if ( SpellCooldown(265187)<9 and Aura_time("PLAYER","魔性征召")>0 ) or (SpellCooldown(265187)<11 and Aura_time("PLAYER","魔性征召")==0) or SpellCooldown(265187)>14 or  PandaDB.CcdSwitch == false  then ShowColor(mainbutton.icon, 6603,A_5);ShowSpell(debutton.icon, 104316)  return end
end

if PandaDB.EMS_A8 ~= false  and Isuseable("灾怨轰炸",267211) then ShowColor(mainbutton.icon, 6603,A_8);ShowSpell(debutton.icon, 267211)  return end

if PandaDB.EMS_A1 ~= false  and Isuseable("古尔丹之手",105174) and Useing_spell("player") ~= 105174 and Power("SOUL_SHARDS")>=2 then
if ( AzltE("怨毒祷告")>0 or IsTalent("恶魔吞噬") ) and Prev_Spell(1)==105174 and SpellCooldown(265187)<2 then ShowColor(mainbutton.icon, 6603,A_1);ShowSpell(debutton.icon, 105174)  return end
end

if PandaDB.CcdSwitch ~= false  then
if PandaDB.EMS_A7 ~= false  and Isuseable("召唤恶魔暴君",265187) and Useing_spell("player") ~= 265187 then
if SpellConut(196277)>=3 and Power("SOUL_SHARDS")<3 and ((Prev_Spell(1)==105174 and Prev_Spell(2)==105174 and Prev_Spell(3)==105174) or (Prev_Spell(1)==105174 and Prev_Spell(2)==264057 and Prev_Spell(3)==105174) or (Prev_Spell(1)==105174 and Prev_Spell(2)==105174 and Prev_Spell(3)==264178 and Prev_Spell(4)==105174) or (Prev_Spell(1)==105174 and Prev_Spell(2)==264178 and Prev_Spell(3)==105174 and Prev_Spell(4)==105174)) then ShowColor(mainbutton.icon, 6603,A_7);ShowSpell(debutton.icon, 265187)  return end
end
end

if PandaDB.EMS_C2 ~= false  and Isuseable("灵魂打击",264057) then 
if Prev_Spell(1)==105174 and Power("SOUL_SHARDS")<3 then ShowColor(mainbutton.icon, 6603,C_2);ShowSpell(debutton.icon, 264057)  return end
end

if PandaDB.CcdSwitch ~= false  then
if PandaDB.EMS_A7 ~= false  and Isuseable("召唤恶魔暴君",265187) and Useing_spell("player") ~= 265187 then
if SpellConut(196277)>=3 and (Power("SOUL_SHARDS")<3 and ( not IsTalent("恶魔吞噬") or SpellConut(196277) + (2000/GetHaste()*100) >=9 ) or TTD()<20) then ShowColor(mainbutton.icon, 6603,A_7);ShowSpell(debutton.icon, 265187)  return end
end
end

if PandaDB.EMS_A0 ~= false  and Isuseable("能量虹吸",264130) then 
if SpellConut(196277)>=2 and Aura_Stack("PLAYER","恶魔之核")<=2 and Aura_time("PLAYER","恶魔之力")==0 and active_enemies()<2 then ShowColor(mainbutton.icon, 6603,A_0);ShowSpell(debutton.icon, 264130)  return end
end

if PandaDB.EMS_A9 ~= false  and Isuseable("厄运",265412) then
if IsTalent("厄运") and Aura_time("TARGET","厄运","PLAYER|HARMFUL")<24*0.3 and TTD()>(Aura_time("TARGET","厄运","PLAYER|HARMFUL")+30) then ShowColor(mainbutton.icon, 6603,A_9);ShowSpell(debutton.icon, 265412)  return end
end

if PandaDB.EMS_A1 ~= false  and Isuseable("古尔丹之手",105174) and Useing_spell("player") ~= 105174 then
if Power("SOUL_SHARDS") >=5 or (Power("SOUL_SHARDS") >=3 and SpellCooldown(104316)>4 and (SpellCooldown(265187)>20 or (SpellCooldown(265187)<GCD_MAX()*2 and IsTalent("恶魔吞噬") or SpellCooldown(265187)<GCD_MAX()*4 and not IsTalent("恶魔吞噬") )) and (not IsTalent("召唤邪犬") or SpellCooldown(264119)>3) ) then ShowColor(mainbutton.icon, 6603,A_1);ShowSpell(debutton.icon, 105174)  return end
end

if PandaDB.EMS_C2 ~= false  and Isuseable("灵魂打击",264057) then
if Power("SOUL_SHARDS")<5 and Aura_Stack("PLAYER","恶魔之核")<=2 then ShowColor(mainbutton.icon, 6603,C_2);ShowSpell(debutton.icon, 264057)  return end
end

if PandaDB.EMS_A2 ~= false  and Isuseable("恶魔之箭",264178) and Useing_spell("player") ~= 264178  then 
if Power("SOUL_SHARDS")<=3 and Aura_time("PLAYER","恶魔之核")>0 and (( SpellCooldown(265187)<6 or SpellCooldown(265187)>22 and AzltE("暗影之咬")==0 ) or Aura_Stack("PLAYER","恶魔之核")>=3 or Aura_time("PLAYER","恶魔之核")<7 or TTD()<25 or Aura_time("PLAYER","暗影之咬")>0 ) then ShowColor(mainbutton.icon, 6603,A_2);ShowSpell(debutton.icon, 264178)  return end
end

--/call_action_list,name=build_a_shard
if PandaDB.EMS_C2 ~= false  and Isuseable("灵魂打击",264057) then
if not IsTalent("恶魔吞噬") or time_d(15) or Prev_Spell(1)==105174 and not IsBloodlust() then ShowColor(mainbutton.icon, 6603,C_2);ShowSpell(debutton.icon, 264057)  return end
end
if PandaDB.EMS_C4 ~= false  and Isuseable("暗影箭",686)  and not Soul_full() and Power("SOUL_SHARDS")<PowerMax("SOUL_SHARDS")  then ShowColor(mainbutton.icon, 6603,C_4);ShowSpell(debutton.icon, 686)  return end












---------------------------------------------------------------------------
--[[                       编辑区                       ]]--
---------------------------------------------------------------------------

ShowColor(mainbutton.icon, 6603,6603);ShowSpell(debutton.icon, 311923)	

--elseif not Authorization() then 
--print("|cffffe00a★Panda★:【|r|c00FF68CC 插件未激活 联系QQ:398371778 |r|cffffe00a】|r")

--end


end


end

local Warlock_Demonology = Warlock_Demonology
ns.Warlock_Demonology = Warlock_Demonology


