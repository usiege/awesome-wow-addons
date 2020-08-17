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


local function Paladin_Protection()  --更新主图标及技能提示图标

local mainbutton = PDUI.mainbutton
local debutton = PDUI.debutton

if PlayerClass() == "PALADIN" and Specialization() == "防护" then
--if Authorization() then

--开始循环
--自动拾取器

---------------------------------------------------------------------------
--[[                       编辑区                       ]]--
---------------------------------------------------------------------------

--precombat
if not InCombatLockdown() then
--actions.precombat+=/consecration
if PandaDB.FQ_A9 ~= false  and Isuseable("奉献",205228) then ShowColor(mainbutton.icon, 6603,A_9);ShowSpell(debutton.icon, 205228)  return end
end

--actions+=/call_action_list,name=cooldowns
if PandaDB.CcdSwitch ~= false  then
--actions.cooldowns+=/seraphim,if=cooldown.shield_of_the_righteous.charges_fractional>=2
if PandaDB.FQ_A3 ~= false  and Isuseable("炽天使",152262) then
if SpellallCharges(53600)>=2 then ShowColor(mainbutton.icon, 6603,A_3);ShowSpell(debutton.icon, 152262)  return end
end
--actions.cooldowns+=/avenging_wrath,if=buff.seraphim.up|cooldown.seraphim.remains<2|!talent.seraphim.enabled
if PandaDB.FQ_A1 ~= false  and Isuseable("复仇之怒",31884) then
if (Aura_time("PLAYER","炽天使") > 0 or SpellCooldown(152262)<2 or not IsTalent("炽天使")) then ShowColor(mainbutton.icon, 6603,A_1);ShowSpell(debutton.icon, 31884)  return end
end
--actions.cooldowns+=/bastion_of_light,if=cooldown.shield_of_the_righteous.charges_fractional<=0.5
if PandaDB.FQ_A5 ~= false  and Isuseable("圣光壁垒",204035) then
if SpellallCharges(53600)<=0.5 then ShowColor(mainbutton.icon, 6603,A_5);ShowSpell(debutton.icon, 204035)  return end
end

end

if PandaDB.CcdSwitch ~= false  then
--艾泽拉斯之心精华
--essences
if PandaDB.FQ_C8 then
if Isuseable("仇敌之血","仇敌之血") then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.FQ_C8 then
if Isuseable("艾泽拉斯守护者","艾泽拉斯守护者") then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.FQ_C8 then
if Isuseable("不羁之力","不羁之力") then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.FQ_C8 then
if Isuseable("聚能艾泽里特射线","聚能艾泽里特射线") and Useing_spell("player") ~= 295258 and Aura_time("PLAYER","风火雷电")==0 and Aura_time("PLAYER","屏气凝神")==0 then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.FQ_C8 then
if Isuseable("火红烈焰","火红烈焰") then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.FQ_C8 then
if Isuseable("净化冲击","净化冲击") then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.FQ_C8 then
if Isuseable("世界血脉共鸣","世界血脉共鸣") then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.FQ_C8 then
if Isuseable("空间涟漪","空间涟漪") then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.FQ_C8 then
if Isuseable("清醒梦境之忆","清醒梦境之忆") then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.FQ_C8 then
if Isuseable("收割火焰","收割火焰")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.FQ_C8 then
if Isuseable("生命缚誓者之祈","生命缚誓者之祈")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.FQ_C8 then
if Isuseable("救世之魂","救世之魂")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.FQ_C8 then
if Isuseable("守护屏障","守护屏障")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.FQ_C8 then
if Isuseable("补充能量","补充能量")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.FQ_C8 then
if Isuseable("静滞","静滞")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.FQ_C8 then
if Isuseable("法力过载","法力过载")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.FQ_C8 then
if Isuseable("活力导管","活力导管")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.FQ_C8 then
if Isuseable("爆燃之拥","爆燃之拥")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.FQ_C8 then
if Isuseable("光荣时刻","光荣时刻")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.FQ_C8 then
if Isuseable("深渊之护","深渊之护")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.FQ_C8 then
if Isuseable("艾泽拉斯的不朽赐福","艾泽拉斯的不朽赐福")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.FQ_C8 then
if Isuseable("强化虚无屏障","强化虚无屏障")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end


end

--actions+=/shield_of_the_righteous,if=(buff.avengers_valor.up&cooldown.shield_of_the_righteous.charges_fractional>=2.5)&(cooldown.seraphim.remains>gcd|!talent.seraphim.enabled)
if PandaDB.FQ_A4 ~= false  and Isuseable("正义盾击",53600) then
if (Aura_time("PLAYER","复仇者的勇气") > 0 and SpellallCharges(53600)>=2.5) then ShowColor(mainbutton.icon, 6603,A_4);ShowSpell(debutton.icon, 53600)  return end
end
--actions+=/shield_of_the_righteous,if=(buff.avenging_wrath.up&!talent.seraphim.enabled)|buff.seraphim.up&buff.avengers_valor.up
if PandaDB.FQ_A4 ~= false  and Isuseable("正义盾击",53600) then
if (Aura_time("PLAYER","复仇之怒") > 0 and not IsTalent("炽天使")) or Aura_time("PLAYER","炽天使") > 0 and Aura_time("PLAYER","复仇者的勇气") > 0 then ShowColor(mainbutton.icon, 6603,A_4);ShowSpell(debutton.icon, 53600)  return end
end
--actions+=/shield_of_the_righteous,if=(buff.avenging_wrath.up&buff.avenging_wrath.remains<4&!talent.seraphim.enabled)|(buff.seraphim.remains<4&buff.seraphim.up)
if PandaDB.FQ_A4 ~= false  and Isuseable("正义盾击",53600) then
if (Aura_time("PLAYER","复仇之怒") > 0 and Aura_time("PLAYER","复仇之怒")<4 and not IsTalent("炽天使")) or (Aura_time("PLAYER","炽天使")<4 and Aura_time("PLAYER","炽天使")>0) and (SpellCooldown(152262)>GCD_MAX() or not IsTalent("炽天使")) then ShowColor(mainbutton.icon, 6603,A_4);ShowSpell(debutton.icon, 53600)  return end
end
--守护之光
if PandaDB.FQ_A6 ~= false  and Isuseable("守护之光",184092) then
if HealthPercent("player")<=85 then ShowColor(mainbutton.icon, 6603,A_6);ShowSpell(debutton.icon, 184092)  return end
end
--守护者之手
if PandaDB.FQ_A6 ~= false  and Isuseable("守护者之手",213652) then
if HealthPercent("player")<=85 then ShowColor(mainbutton.icon, 6603,A_6);ShowSpell(debutton.icon, 213652)  return end
end
--actions+=/consecration,if=!consecration.up
if PandaDB.FQ_A9 ~= false  and Isuseable("奉献",205228) then
if Aura_count("PLAYER","奉献")==0 then ShowColor(mainbutton.icon, 6603,A_9);ShowSpell(debutton.icon, 205228)  return end
end

--actions+=/judgment,if=(cooldown.judgment.remains<gcd&cooldown.judgment.charges_fractional>1&cooldown_react)|!talent.crusaders_judgment.enabled
if PandaDB.FQ_A7 ~= false  and Isuseable("审判",20271) then
if (SpellCooldown(20271)<GCD_MAX() and SpellallCharges(20271)>1 ) or not IsTalent("十字军审判") then ShowColor(mainbutton.icon, 6603,A_7);ShowSpell(debutton.icon, 20271)  return end
end
--actions+=/avengers_shield,if=cooldown_react
if PandaDB.FQ_A2 ~= false  and Isuseable("复仇者之盾",31935) then
if SpellCooldown(31935)==0 then ShowColor(mainbutton.icon, 6603,A_2);ShowSpell(debutton.icon, 31935)  return end
end
--actions+=/judgment,if=cooldown_react|!talent.crusaders_judgment.enabled
if PandaDB.FQ_A7 ~= false  and Isuseable("审判",20271) then
if SpellCooldown(20271)==0 or not IsTalent("十字军审判") then ShowColor(mainbutton.icon, 6603,A_7);ShowSpell(debutton.icon, 20271)  return end
end
--actions+=/blessed_hammer,strikes=3
if PandaDB.FQ_A8 ~= false  and Isuseable("祝福之锤",204019) and IsTalent("祝福之锤") then
if SpellallCharges(204019)==3 then ShowColor(mainbutton.icon, 6603,A_8);ShowSpell(debutton.icon, 204019)  return end
end
--actions+=/hammer_of_the_righteous
if PandaDB.FQ_A8 ~= false  and Isuseable("正义之锤",53595) then
if not IsTalent("祝福之锤") then ShowColor(mainbutton.icon, 6603,A_8);ShowSpell(debutton.icon, 53595)  return end
end
--consecration
if PandaDB.FQ_A9 ~= false  and Isuseable("奉献",205228) then ShowColor(mainbutton.icon, 6603,A_9);ShowSpell(debutton.icon, 205228)  return end


---------------------------------------------------------------------------
--[[                       编辑区                       ]]--
---------------------------------------------------------------------------
ShowColor(mainbutton.icon, 6603,6603);ShowSpell(debutton.icon, 311923)	

--elseif not Authorization() then 
--print("|cffffe00a★Panda★:【|r|c00FF68CC 插件未激活 联系QQ:398371778 |r|cffffe00a】|r")

--end


end


end


local Paladin_Protection = Paladin_Protection
ns.Paladin_Protection = Paladin_Protection

