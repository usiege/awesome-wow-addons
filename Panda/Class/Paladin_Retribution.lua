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
--[[                     变量                             ]]--
---------------------------------------------------------------------------
local function variable_ds_castable()
local A = active_enemies()
local B = IsTalent("正义裁决")
if A>=2 and not B==true or A>=3 and B==true then
return true else return false end
end


local function variable_HoW() 
local A = IsTalent("愤怒之锤")
local B = HealthPercent("target")
local C = Aura_time("PLAYER","复仇之怒")
local D = Aura_time("PLAYER","征伐")
if ( not A or B>=20 and (C == 0 or D == 0)) then 
return true else return false
end
end


local function Paladin_Retribution()  --更新主图标及技能提示图标

local mainbutton = PDUI.mainbutton
local debutton = PDUI.debutton

if PlayerClass() == "PALADIN" and Specialization() == "惩戒" then
--if Authorization() then


--开始循环

---------------------------------------------------------------------------
--[[                       编辑区                       ]]--
---------------------------------------------------------------------------

--cooldown
if PandaDB.CcdSwitch ~= false  then

if PandaDB.CJQ_A1 ~= false  and Isuseable("复仇之怒",31884) and not IsTalent("征伐") then
if (Aura_time("PLAYER","异端裁决") > 0 or not IsTalent("异端裁决")) then ShowColor(mainbutton.icon, 6603,A_1);ShowSpell(debutton.icon, 31884)  return end
end

if PandaDB.CJQ_A1 ~= false  and Isuseable("征伐",231895) then
if (Power("HOLY_POWER")>=4) then ShowColor(mainbutton.icon, 6603,A_1);ShowSpell(debutton.icon, 231895)  return end
end


end

if PandaDB.CcdSwitch ~= false  then
--艾泽拉斯之心精华
--essences
if PandaDB.CJQ_C8 then
if Isuseable("仇敌之血","仇敌之血") then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.CJQ_C8 then
if Isuseable("艾泽拉斯守护者","艾泽拉斯守护者") then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.CJQ_C8 then
if Isuseable("不羁之力","不羁之力") then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.CJQ_C8 then
if Isuseable("聚能艾泽里特射线","聚能艾泽里特射线") and Useing_spell("player") ~= 295258 and Aura_time("PLAYER","风火雷电")==0 and Aura_time("PLAYER","屏气凝神")==0 then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.CJQ_C8 then
if Isuseable("火红烈焰","火红烈焰") then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.CJQ_C8 then
if Isuseable("净化冲击","净化冲击") then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.CJQ_C8 then
if Isuseable("世界血脉共鸣","世界血脉共鸣") then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.CJQ_C8 then
if Isuseable("空间涟漪","空间涟漪") then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.CJQ_C8 then
if Isuseable("清醒梦境之忆","清醒梦境之忆") then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.CJQ_C8 then
if Isuseable("收割火焰","收割火焰")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.CJQ_C8 then
if Isuseable("生命缚誓者之祈","生命缚誓者之祈")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.CJQ_C8 then
if Isuseable("救世之魂","救世之魂")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.CJQ_C8 then
if Isuseable("守护屏障","守护屏障")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.CJQ_C8 then
if Isuseable("补充能量","补充能量")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.CJQ_C8 then
if Isuseable("静滞","静滞")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.CJQ_C8 then
if Isuseable("法力过载","法力过载")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.CJQ_C8 then
if Isuseable("活力导管","活力导管")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.CJQ_C8 then
if Isuseable("爆燃之拥","爆燃之拥")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.CJQ_C8 then
if Isuseable("光荣时刻","光荣时刻")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.CJQ_C8 then
if Isuseable("深渊之护","深渊之护")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.CJQ_C8 then
if Isuseable("艾泽拉斯的不朽赐福","艾泽拉斯的不朽赐福")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.CJQ_C8 then
if Isuseable("强化虚无屏障","强化虚无屏障")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

end

--finishers
if Power("HOLY_POWER")>=5 then

if PandaDB.CJQ_A2 ~= false  and Isuseable("异端裁决",84963) then
if (Aura_time("PLAYER","异端裁决") == 0 or Aura_time("PLAYER","异端裁决")<5 and Power("HOLY_POWER")>=3 or IsTalent("处决宣判") and SpellCooldown(267798)<10 and Aura_time("PLAYER","异端裁决")<15 or SpellCooldown(31884)<15 and Aura_time("PLAYER","异端裁决")<20 and Power("HOLY_POWER")>=3 ) then ShowColor(mainbutton.icon, 6603,A_2);ShowSpell(debutton.icon, 84963)  return end
end

if PandaDB.CJQ_C1 ~= false  and Isuseable("处决宣判",267798) then
if ( active_enemies()<=2 and (  PandaDB.CJQ_A1 == false or PandaDB.CcdSwitch == false  or not IsTalent("征伐") or SpellCooldown(231895)>GCD_MAX()*2) ) then ShowColor(mainbutton.icon, 6603,C_1);ShowSpell(debutton.icon, 267798)  return end
end

if PandaDB.CJQ_A3 ~= false  and Isuseable("神圣风暴",53385) then
if (variable_ds_castable() and Aura_time("PLAYER","神圣意志") > 0) then ShowColor(mainbutton.icon, 6603,A_3);ShowSpell(debutton.icon, 53385)  return end
end

if PandaDB.CJQ_A3 ~= false  and Isuseable("神圣风暴",53385) then
if (variable_ds_castable() and (  PandaDB.CJQ_A1 == false or PandaDB.CcdSwitch == false  or not IsTalent("征伐") or SpellCooldown(231895)>GCD_MAX()*2) or Aura_time("PLAYER","苍穹之力") > 0 and Aura_time("TARGET","审判","PLAYER|HARMFUL") == 0 and Aura_time("PLAYER","神圣意志") == 0) then ShowColor(mainbutton.icon, 6603,A_3);ShowSpell(debutton.icon, 53385)  return end
end

if PandaDB.CJQ_A4 ~= false  and Isuseable("圣殿骑士的裁决",85256) then
if (Aura_time("PLAYER","神圣意志") > 0) then ShowColor(mainbutton.icon, 6603,A_4);ShowSpell(debutton.icon, 85256)  return end
end

if PandaDB.CJQ_A4 ~= false  and Isuseable("圣殿骑士的裁决",85256) then
if ((  PandaDB.CJQ_A1 == false or PandaDB.CcdSwitch == false  or not IsTalent("征伐") or SpellCooldown(231895)>GCD_MAX() *3) and ( not IsTalent("处决宣判") or Aura_time("PLAYER","征伐") > 0 and Aura_Stack("PLAYER","征伐")<10 or SpellCooldown(267798)>GCD_MAX() *2)) then ShowColor(mainbutton.icon, 6603,A_4);ShowSpell(debutton.icon, 85256)  return end
end
end
--generators
if PandaDB.CJQ_A5 ~= false   and Isuseable("灰烬觉醒",255937) then
if (Power("HOLY_POWER")<=0 or Power("HOLY_POWER")==1 and SpellCooldown(184575)>GCD_MAX() ) then ShowColor(mainbutton.icon, 6603,A_5);ShowSpell(debutton.icon, 255937)  return end
end

if PandaDB.CJQ_A6 ~= false   and Isuseable("公正之剑",184575) then
if (Power("HOLY_POWER")<=2 or (Power("HOLY_POWER")==3 and (SpellCooldown(24275)>GCD_MAX() *2 or variable_HoW()))) then ShowColor(mainbutton.icon, 6603,A_6);ShowSpell(debutton.icon, 184575)  return end
end

if PandaDB.CJQ_A7 ~= false   and Isuseable("审判",20271) then
if (Power("HOLY_POWER")<=2 or (Power("HOLY_POWER")<=4 and (SpellCooldown(184575)>GCD_MAX() *2 or variable_HoW()))) then ShowColor(mainbutton.icon, 6603,A_7);ShowSpell(debutton.icon, 20271)  return end
end

if PandaDB.CJQ_A8 ~= false   and Isuseable("愤怒之锤",24275) then
if (Power("HOLY_POWER")<=4) then ShowColor(mainbutton.icon, 6603,A_8);ShowSpell(debutton.icon, 24275)  return end
end

if PandaDB.CJQ_A9 ~= false   and Isuseable("奉献",205228) then
if (Power("HOLY_POWER")<=2 or Power("HOLY_POWER")<=3 and SpellCooldown(184575)>GCD_MAX() *2 or Power("HOLY_POWER")==4 and SpellCooldown(184575)>GCD_MAX() *2 and SpellCooldown(20271)>GCD_MAX() *2) then ShowColor(mainbutton.icon, 6603,A_9);ShowSpell(debutton.icon, 205228)  return end
end

--finishers
if IsTalent("愤怒之锤") and HealthPercent("target")<=20 or Aura_time("PLAYER","复仇之怒") > 0 or Aura_time("PLAYER","征伐") > 0 then


if PandaDB.CJQ_A2 ~= false   and Isuseable("异端裁决",84963) then
if (Aura_time("PLAYER","异端裁决") == 0 or Aura_time("PLAYER","异端裁决")<5 and Power("HOLY_POWER")>=3 or IsTalent("处决宣判") and SpellCooldown(267798)<10 and Aura_time("PLAYER","异端裁决")<15 or SpellCooldown(31884)<15 and Aura_time("PLAYER","异端裁决")<20 and Power("HOLY_POWER")>=3 ) then ShowColor(mainbutton.icon, 6603,A_2);ShowSpell(debutton.icon, 84963)  return end
end

if PandaDB.CJQ_C1 ~= false   and Isuseable("处决宣判",267798) then
if ( active_enemies()<=2 and (  PandaDB.CJQ_A1 == false or PandaDB.CcdSwitch == false  or not IsTalent("征伐") or SpellCooldown(231895)>GCD_MAX() *2) ) then ShowColor(mainbutton.icon, 6603,C_1);ShowSpell(debutton.icon, 267798)  return end
end

if PandaDB.CJQ_A3 ~= false  and Isuseable("神圣风暴",53385) then
if (variable_ds_castable() and Aura_time("PLAYER","神圣意志") > 0) then ShowColor(mainbutton.icon, 6603,A_3);ShowSpell(debutton.icon, 53385)  return end
end

if PandaDB.CJQ_A3 ~= false  and Isuseable("神圣风暴",53385) then
if (variable_ds_castable() and (  PandaDB.CJQ_A1 == false or PandaDB.CcdSwitch == false  or not IsTalent("征伐") or SpellCooldown(231895)>GCD_MAX() *2) or Aura_time("PLAYER","苍穹之力") > 0 and Aura_time("TARGET","审判","PLAYER|HARMFUL") == 0 and Aura_time("PLAYER","神圣意志") == 0) then ShowColor(mainbutton.icon, 6603,A_3);ShowSpell(debutton.icon, 53385)  return end
end

if PandaDB.CJQ_A4 ~= false  and Isuseable("圣殿骑士的裁决",85256) then
if (Aura_time("PLAYER","神圣意志") > 0) then ShowColor(mainbutton.icon, 6603,A_4);ShowSpell(debutton.icon, 85256)  return end
end

if PandaDB.CJQ_A4 ~= false  and Isuseable("圣殿骑士的裁决",85256) then
if ((  PandaDB.CJQ_A1 == false or PandaDB.CcdSwitch == false  or not IsTalent("征伐") or SpellCooldown(231895)>GCD_MAX() *3) and ( not IsTalent("处决宣判") or Aura_time("PLAYER","征伐") > 0 and Aura_Stack("PLAYER","征伐")<10 or SpellCooldown(267798)>GCD_MAX() *2)) then ShowColor(mainbutton.icon, 6603,A_4);ShowSpell(debutton.icon, 85256)  return end
end
end

if PandaDB.CJQ_A0 ~= false  and Isuseable("十字军打击",35395) then
if (SpellallCharges(35395)>=1.75 and (Power("HOLY_POWER")<=2 or Power("HOLY_POWER")<=3 and SpellCooldown(184575)>GCD_MAX() *2 or Power("HOLY_POWER")==4 and SpellCooldown(184575)>GCD_MAX() *2 and SpellCooldown(20271)>GCD_MAX() *2 and SpellCooldown(205228)>GCD_MAX() *2)) then ShowColor(mainbutton.icon, 6603,A_0);ShowSpell(debutton.icon, 35395)  return end
end

--finishers
if PandaDB.CJQ_A2 ~= false  and Isuseable("异端裁决",84963) then
if (Aura_time("PLAYER","异端裁决") == 0 or Aura_time("PLAYER","异端裁决")<5 and Power("HOLY_POWER")>=3 or IsTalent("处决宣判") and SpellCooldown(267798)<10 and Aura_time("PLAYER","异端裁决")<15 or SpellCooldown(31884)<15 and Aura_time("PLAYER","异端裁决")<20 and Power("HOLY_POWER")>=3 ) then ShowColor(mainbutton.icon, 6603,A_2);ShowSpell(debutton.icon, 84963)  return end
end

if PandaDB.CJQ_C1 ~= false  and Isuseable("处决宣判",267798) then
if ( active_enemies()<=2 and (  PandaDB.CJQ_A1 == false or PandaDB.CcdSwitch == false  or not IsTalent("征伐") or SpellCooldown(231895)>GCD_MAX() *2) ) then ShowColor(mainbutton.icon, 6603,C_1);ShowSpell(debutton.icon, 267798)  return end
end

if PandaDB.CJQ_A3 ~= false  and Isuseable("神圣风暴",53385) then
if (variable_ds_castable() and Aura_time("PLAYER","神圣意志") > 0) then ShowColor(mainbutton.icon, 6603,A_3);ShowSpell(debutton.icon, 53385)  return end
end

if PandaDB.CJQ_A3 ~= false  and Isuseable("神圣风暴",53385) then
if (variable_ds_castable() and (  PandaDB.CJQ_A1 == false or PandaDB.CcdSwitch == false  or not IsTalent("征伐") or SpellCooldown(231895)>GCD_MAX() *2) or Aura_time("PLAYER","苍穹之力") > 0 and Aura_time("TARGET","审判","PLAYER|HARMFUL") == 0 and Aura_time("PLAYER","神圣意志") == 0) then ShowColor(mainbutton.icon, 6603,A_3);ShowSpell(debutton.icon, 53385)  return end
end

if PandaDB.CJQ_A4 ~= false  and Isuseable("圣殿骑士的裁决",85256) then
if (Aura_time("PLAYER","神圣意志") > 0) then ShowColor(mainbutton.icon, 6603,A_4);ShowSpell(debutton.icon, 85256)  return end
end

if PandaDB.CJQ_A4 ~= false  and Isuseable("圣殿骑士的裁决",85256) then
if ((  PandaDB.CJQ_A1 == false or PandaDB.CcdSwitch == false   or not IsTalent("征伐") or SpellCooldown(231895)>GCD_MAX()*3) and ( not IsTalent("处决宣判") or Aura_time("PLAYER","征伐") > 0 and Aura_Stack("PLAYER","征伐")<10 or SpellCooldown(267798)>GCD_MAX() *2)) then ShowColor(mainbutton.icon, 6603,A_4);ShowSpell(debutton.icon, 85256)  return end
end
--------
if PandaDB.CJQ_A0 ~= false  and Isuseable("十字军打击",35395) then
if (Power("HOLY_POWER")<=4) then ShowColor(mainbutton.icon, 6603,A_0);ShowSpell(debutton.icon, 35395)  return end
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


local Paladin_Retribution = Paladin_Retribution
ns.Paladin_Retribution = Paladin_Retribution

