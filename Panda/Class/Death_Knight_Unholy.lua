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

local DKRunes = ns.DKRunes
local Runes = ns.Runes

local ShowColor = ns.ShowColor 
local ShowSpell = ns.ShowSpell 
---------------------------------------------------------------------------
--[[                    变量                              ]]--
---------------------------------------------------------------------------

local Color = {
["亡者复生"] = A_1,
["爆发"] = A_2,
["凋零缠绕"] = A_3,
["脓疮打击"] = A_4,
["天灾打击"] = A_5,
["灵界打击"] = A_6,
["枯萎凋零"] = A_7,
["黑暗突变"] = A_8,
["天启"] = A_9,
["亡者大军"] = A_0,
["暗影之爪"] = C_1,
["邪恶虫群"] = C_2,

["灵魂收割"] = C_4,
["亵渎"] = C_5,
["传染"] = C_6,
["邪恶狂乱"] = C_7,
["艾泽拉斯之心精华"] = C_8,
["召唤石像鬼"] = C_9,
["培育憎恶"] = C_0,
}

local Spell = {
["亡者复生"] = 46584,
["爆发"] = 77575,
["凋零缠绕"] = 47541,
["脓疮打击"] = 85948,
["天灾打击"] = 55090,
["灵界打击"] = 49998,
["枯萎凋零"] = 43265,
["黑暗突变"] = 63560,
["天启"] = 275699,
["亡者大军"] = 42650,
["暗影之爪"] = 207311,
["邪恶虫群"] = 115989,

["灵魂收割"] = 130736,
["亵渎"] = 152280,
["传染"] = 207317,
["邪恶狂乱"] = 207289,
["艾泽拉斯之心精华"] = 296208,
["召唤石像鬼"] = 49206,
["培育憎恶"] = 288853,
} 

local function Avul()
local A=0
if Aura_time("player","邪恶狂乱","PLAYER|HELPFUL")>0 then A=1 end
return A
end



local function Death_Knight_Unholy()  --更新主图标及技能提示图标

local mainbutton = PDUI.mainbutton
local debutton = PDUI.debutton

if PlayerClass() == "DEATHKNIGHT" and Specialization() == "邪恶" then
--if Authorization() then
--if  then ShowColor(mainbutton.icon, 6603,Color["猛击"]);ShowSpell(debutton.icon,Spell["猛击"]) return end

--开始循环
--自动拾取器

---------------------------------------------------------------------------
--[[                       编辑区                       ]]--
---------------------------------------------------------------------------

--准备---
if PandaDB.XDK_A1 ~= false and Isuseable('亡者复生',46584) and Summon_Pet() then ShowColor(mainbutton.icon, 6603,Color["亡者复生"]);ShowSpell(debutton.icon,Spell["亡者复生"]) return end

if PandaDB.CcdSwitch ~= false and PandaDB.XDK_A0 ~= false and Isuseable('亡者大军',42650) then ShowColor(mainbutton.icon, 6603,Color["亡者大军"]);ShowSpell(debutton.icon,Spell["亡者大军"]) return end
if PandaDB.CcdSwitch ~= false  and PandaDB.XDK_A0 ~= false and Isuseable('培育憎恶',288853) then ShowColor(mainbutton.icon, 6603,Color["培育憎恶"]);ShowSpell(debutton.icon,Spell["培育憎恶"]) return end

if PandaDB.XDK_A6 and Isuseable("灵界打击",49998) and (HealthPercent("player")<=40 ) then ShowColor(mainbutton.icon, 6603,Color["灵界打击"]);ShowSpell(debutton.icon,Spell["灵界打击"]) return end

--特殊处理
if Teshuchuli() then
if PandaDB.XDK_A3 ~= false  and Isuseable("凋零缠绕",47541) then ShowColor(mainbutton.icon, 6603,Color["天灾打击"]);ShowSpell(debutton.icon,Spell["天灾打击"]) return end
if PandaDB.XDK_A5 ~= false  and Isuseable("天灾打击",55090) then ShowColor(mainbutton.icon, 6603,Color["凋零缠绕"]);ShowSpell(debutton.icon,Spell["凋零缠绕"]) return end
end
--------战斗开始-----------
--优先级最高--
if PandaDB.XDK_A2 ~= false  and Isuseable('爆发',77575) and (Aura_time("target","恶性瘟疫","PLAYER|HARMFUL")<=GCD_MAX()) then ShowColor(mainbutton.icon, 6603,Color["爆发"]);ShowSpell(debutton.icon,Spell["爆发"]) return end

--艾泽拉斯之心精华
if PandaDB.CcdSwitch ~= false then
--essences
if PandaDB.XDK_C8 then
if Isuseable("仇敌之血","仇敌之血") then ShowColor(mainbutton.icon, 6603,Color["艾泽拉斯之心精华"]);ShowSpell(debutton.icon,Spell["艾泽拉斯之心精华"]) return end
end

if PandaDB.XDK_C8 then
if Isuseable("艾泽拉斯守护者","艾泽拉斯守护者") then ShowColor(mainbutton.icon, 6603,Color["艾泽拉斯之心精华"]);ShowSpell(debutton.icon,Spell["艾泽拉斯之心精华"]) return end
end

if PandaDB.XDK_C8 then
if Isuseable("不羁之力","不羁之力") then ShowColor(mainbutton.icon, 6603,Color["艾泽拉斯之心精华"]);ShowSpell(debutton.icon,Spell["艾泽拉斯之心精华"]) return end
end

if PandaDB.XDK_C8 then
if Isuseable("聚能艾泽里特射线","聚能艾泽里特射线") and Useing_spell("player") ~= 295258 then ShowColor(mainbutton.icon, 6603,Color["艾泽拉斯之心精华"]);ShowSpell(debutton.icon,Spell["艾泽拉斯之心精华"]) return end
end

if PandaDB.XDK_C8 then
if Isuseable("火红烈焰","火红烈焰") then ShowColor(mainbutton.icon, 6603,Color["艾泽拉斯之心精华"]);ShowSpell(debutton.icon,Spell["艾泽拉斯之心精华"]) return end
end

if PandaDB.XDK_C8 then
if Isuseable("净化冲击","净化冲击") then ShowColor(mainbutton.icon, 6603,Color["艾泽拉斯之心精华"]);ShowSpell(debutton.icon,Spell["艾泽拉斯之心精华"]) return end
end

if PandaDB.XDK_C8 then
if Isuseable("世界血脉共鸣","世界血脉共鸣") then ShowColor(mainbutton.icon, 6603,Color["艾泽拉斯之心精华"]);ShowSpell(debutton.icon,Spell["艾泽拉斯之心精华"]) return end
end

if PandaDB.XDK_C8 then
if Isuseable("空间涟漪","空间涟漪") then ShowColor(mainbutton.icon, 6603,Color["艾泽拉斯之心精华"]);ShowSpell(debutton.icon,Spell["艾泽拉斯之心精华"]) return end
end

if PandaDB.XDK_C8 then
if Isuseable("清醒梦境之忆","清醒梦境之忆") then ShowColor(mainbutton.icon, 6603,Color["艾泽拉斯之心精华"]);ShowSpell(debutton.icon,Spell["艾泽拉斯之心精华"]) return end
end

if PandaDB.XDK_C8 then
if Isuseable("收割火焰","收割火焰")  then ShowColor(mainbutton.icon, 6603,Color["艾泽拉斯之心精华"]);ShowSpell(debutton.icon,Spell["艾泽拉斯之心精华"]) return end
end

if PandaDB.XDK_C8 then
if Isuseable("生命缚誓者之祈","生命缚誓者之祈")  then ShowColor(mainbutton.icon, 6603,Color["艾泽拉斯之心精华"]);ShowSpell(debutton.icon,Spell["艾泽拉斯之心精华"]) return end
end

if PandaDB.XDK_C8 then
if Isuseable("救世之魂","救世之魂")  then ShowColor(mainbutton.icon, 6603,Color["艾泽拉斯之心精华"]);ShowSpell(debutton.icon,Spell["艾泽拉斯之心精华"]) return end
end

if PandaDB.XDK_C8 then
if Isuseable("守护屏障","守护屏障")  then ShowColor(mainbutton.icon, 6603,Color["艾泽拉斯之心精华"]);ShowSpell(debutton.icon,Spell["艾泽拉斯之心精华"]) return end
end

if PandaDB.XDK_C8 then
if Isuseable("补充能量","补充能量")  then ShowColor(mainbutton.icon, 6603,Color["艾泽拉斯之心精华"]);ShowSpell(debutton.icon,Spell["艾泽拉斯之心精华"]) return end
end

if PandaDB.XDK_C8 then
if Isuseable("静滞","静滞")  then ShowColor(mainbutton.icon, 6603,Color["艾泽拉斯之心精华"]);ShowSpell(debutton.icon,Spell["艾泽拉斯之心精华"]) return end
end

if PandaDB.XDK_C8 then
if Isuseable("法力过载","法力过载")  then ShowColor(mainbutton.icon, 6603,Color["艾泽拉斯之心精华"]);ShowSpell(debutton.icon,Spell["艾泽拉斯之心精华"]) return end
end

if PandaDB.XDK_C8 then
if Isuseable("活力导管","活力导管")  then ShowColor(mainbutton.icon, 6603,Color["艾泽拉斯之心精华"]);ShowSpell(debutton.icon,Spell["艾泽拉斯之心精华"]) return end
end

if PandaDB.XDK_C8 then
if Isuseable("爆燃之拥","爆燃之拥")  then ShowColor(mainbutton.icon, 6603,Color["艾泽拉斯之心精华"]);ShowSpell(debutton.icon,Spell["艾泽拉斯之心精华"]) return end
end

if PandaDB.XDK_C8 then
if Isuseable("光荣时刻","光荣时刻")  then ShowColor(mainbutton.icon, 6603,Color["艾泽拉斯之心精华"]);ShowSpell(debutton.icon,Spell["艾泽拉斯之心精华"]) return end
end

if PandaDB.XDK_C8 then
if Isuseable("深渊之护","深渊之护")  then ShowColor(mainbutton.icon, 6603,Color["艾泽拉斯之心精华"]);ShowSpell(debutton.icon,Spell["艾泽拉斯之心精华"]) return end
end

if PandaDB.XDK_C8 then
if Isuseable("艾泽拉斯的不朽赐福","艾泽拉斯的不朽赐福")  then ShowColor(mainbutton.icon, 6603,Color["艾泽拉斯之心精华"]);ShowSpell(debutton.icon,Spell["艾泽拉斯之心精华"]) return end
end

if PandaDB.XDK_C8 then
if Isuseable("强化虚无屏障","强化虚无屏障")  then ShowColor(mainbutton.icon, 6603,Color["艾泽拉斯之心精华"]);ShowSpell(debutton.icon,Spell["艾泽拉斯之心精华"]) return end
end

end
----------------
if active_enemies()>=2 then
if  PandaDB.XDK_A7 ~= false  and Isuseable("枯萎凋零",43265) and not IsTalent('亵渎') then ShowColor(mainbutton.icon, 6603,Color["枯萎凋零"]);ShowSpell(debutton.icon,Spell["枯萎凋零"]) return end
if  PandaDB.XDK_C5 ~= false  and Isuseable("亵渎",152280) and IsTalent('亵渎')  then ShowColor(mainbutton.icon, 6603,Color["亵渎"]);ShowSpell(debutton.icon,Spell["亵渎"]) return end

if Aura_time("player","枯萎凋零","PLAYER|HELPFUL")>GCD_REMAINS() or Aura_time("player","亵渎","PLAYER|HELPFUL")>0 then
if  PandaDB.XDK_A8 ~= false  and Isuseable('黑暗突变',63560) then ShowColor(mainbutton.icon, 6603,Color["黑暗突变"]);ShowSpell(debutton.icon,Spell["黑暗突变"]) return end
if  PandaDB.XDK_A5 ~= false  and Isuseable("天灾打击",55090) and Aura_time("player","枯萎凋零","PLAYER|HELPFUL")>GCD_REMAINS() then ShowColor(mainbutton.icon, 6603,Color["天灾打击"]);ShowSpell(debutton.icon,Spell["天灾打击"]) return end
end

end

--------大招冷却-----------  
if  PandaDB.XDK_A9 ~= false  and Isuseable('天启',275699) and ( Aura_Stack("target","溃烂之伤","PLAYER|HARMFUL")>=4 and (active_enemies()>=2 or not Isuseable('完美愿景',"296325") or Isuseable('完美愿景',"296325") and (IsTalent('邪恶狂乱') and SpellCooldown(207289)<=3 or not IsTalent('邪恶狂乱') ) )) then ShowColor(mainbutton.icon, 6603,Color["天启"]);ShowSpell(debutton.icon,Spell["天启"]) return end
if  PandaDB.XDK_A8 ~= false  and Isuseable('黑暗突变',63560) then ShowColor(mainbutton.icon, 6603,Color["黑暗突变"]);ShowSpell(debutton.icon,Spell["黑暗突变"]) return end
if  PandaDB.XDK_C9 ~= false  and Isuseable("召唤石像鬼",49206) and (PowerMax("RUNIC_POWER") - Power("RUNIC_POWER")<14 ) then ShowColor(mainbutton.icon, 6603,Color["召唤石像鬼"]);ShowSpell(debutton.icon,Spell["召唤石像鬼"]) return end
if  PandaDB.XDK_C7 ~= false  and Isuseable("邪恶狂乱",207289) and (Isuseable('完美愿景',"296325") and not Summon_Pet() or Aura_Stack("target","溃烂之伤","PLAYER|HARMFUL")<4 and (not AzltE('亡灵魔导师') or AzltE('亡灵魔导师') and not Summon_Pet() ) ) then ShowColor(mainbutton.icon, 6603,Color["邪恶狂乱"]);ShowSpell(debutton.icon,Spell["邪恶狂乱"]) return end
if  PandaDB.XDK_C7 ~= false  and Isuseable("邪恶狂乱",207289) and (active_enemies()>=2 and (( SpellCooldown(43265)<=GCD_MAX() and not IsTalent('亵渎')) or (SpellCooldown(152280)<=GCD_MAX() and IsTalent('亵渎')) ) ) then ShowColor(mainbutton.icon, 6603,Color["邪恶狂乱"]);ShowSpell(debutton.icon,Spell["邪恶狂乱"]) return end
if  PandaDB.XDK_C4 ~= false  and Isuseable("灵魂收割",130736) and TTD()<8 and TTD()>4 then ShowColor(mainbutton.icon, 6603,Color["灵魂收割"]);ShowSpell(debutton.icon,Spell["灵魂收割"]) return end
if  PandaDB.XDK_C4 ~= false  and Isuseable("灵魂收割",130736) and (Runes()<=Avul()) then ShowColor(mainbutton.icon, 6603,Color["灵魂收割"]);ShowSpell(debutton.icon,Spell["灵魂收割"]) return end
if  PandaDB.XDK_C2 ~= false  and Isuseable("邪恶虫群",115989) then ShowColor(mainbutton.icon, 6603,Color["邪恶虫群"]);ShowSpell(debutton.icon,Spell["邪恶虫群"]) return end
  
--------AOE----------- 
if active_enemies()>=2 then

if  PandaDB.XDK_A7 ~= false  and Isuseable("枯萎凋零",43265) and not IsTalent('亵渎') and (SpellCooldown(275699)>0 or PandaDB.XDK_A9  == false  ) then ShowColor(mainbutton.icon, 6603,Color["枯萎凋零"]);ShowSpell(debutton.icon,Spell["枯萎凋零"]) return end
if  PandaDB.XDK_C5 ~= false  and Isuseable("亵渎",152280) and IsTalent('亵渎')  then ShowColor(mainbutton.icon, 6603,Color["亵渎"]);ShowSpell(debutton.icon,Spell["亵渎"]) return end
if  PandaDB.XDK_C6 ~= false  and Isuseable("传染",207317) and (Aura_time("player","枯萎凋零","PLAYER|HELPFUL")>GCD_REMAINS() and Runes()<2 and not (SpellCooldown(49206)<5 and IsTalent("召唤石像鬼"))) then ShowColor(mainbutton.icon, 6603,Color["传染"]);ShowSpell(debutton.icon,Spell["传染"]) return end
if  PandaDB.XDK_A3 ~= false  and Isuseable("凋零缠绕",47541) and (Aura_time("player","枯萎凋零","PLAYER|HELPFUL")>GCD_REMAINS() and Runes()<2 and not (SpellCooldown(49206)<5 and IsTalent("召唤石像鬼"))) then ShowColor(mainbutton.icon, 6603,Color["凋零缠绕"]);ShowSpell(debutton.icon,Spell["凋零缠绕"]) return end
if  PandaDB.XDK_A5 ~= false  and Isuseable("天灾打击",55090) and (Aura_time("player","枯萎凋零","PLAYER|HELPFUL")>GCD_REMAINS() and (SpellCooldown(275699)>0 or PandaDB.XDK_A9  == false  )) then ShowColor(mainbutton.icon, 6603,Color["天灾打击"]);ShowSpell(debutton.icon,Spell["天灾打击"]) return end
if  PandaDB.XDK_C1 ~= false  and Isuseable("暗影之爪",207311) and (Aura_time("player","枯萎凋零","PLAYER|HELPFUL")>GCD_REMAINS() and (SpellCooldown(275699)>0 or  PandaDB.XDK_A9  == false  )) then ShowColor(mainbutton.icon, 6603,Color["暗影之爪"]);ShowSpell(debutton.icon,Spell["暗影之爪"]) return end
if  PandaDB.XDK_C6 ~= false  and Isuseable("传染",207317) and (not (SpellCooldown(49206)<5 and IsTalent("召唤石像鬼"))) then ShowColor(mainbutton.icon, 6603,Color["传染"]);ShowSpell(debutton.icon,Spell["传染"]) return end
if  PandaDB.XDK_A4 ~= false  and Isuseable("脓疮打击",85948) and (Aura_Stack("target","溃烂之伤","PLAYER|HARMFUL")<=1 and SpellCooldown(43265)>0 ) then ShowColor(mainbutton.icon, 6603,Color["脓疮打击"]);ShowSpell(debutton.icon,Spell["脓疮打击"]) return end
if  PandaDB.XDK_A4 ~= false  and Isuseable("脓疮打击",85948) and (IsTalent("爆裂之疡") and active_enemies()>=2 and Aura_Stack("target","溃烂之伤","PLAYER|HARMFUL")<=1 ) then ShowColor(mainbutton.icon, 6603,Color["脓疮打击"]);ShowSpell(debutton.icon,Spell["脓疮打击"]) return end
if  PandaDB.XDK_A3 ~= false  and Isuseable("凋零缠绕",47541) and (Aura_time("player","末日降临","PLAYER|HELPFUL")>0 and (PowerMax("RUNES") - Runes()>=4)) then ShowColor(mainbutton.icon, 6603,Color["凋零缠绕"]);ShowSpell(debutton.icon,Spell["凋零缠绕"]) return end
if  PandaDB.XDK_A3 ~= false  and Isuseable("凋零缠绕",47541) and (Aura_time("player","末日降临","PLAYER|HELPFUL")>0 and not (SpellCooldown(49206)<5 and IsTalent("召唤石像鬼")) or not Summon_Pet()) then ShowColor(mainbutton.icon, 6603,Color["凋零缠绕"]);ShowSpell(debutton.icon,Spell["凋零缠绕"]) return end
if  PandaDB.XDK_A3 ~= false  and Isuseable("凋零缠绕",47541) and ((PowerMax("RUNIC_POWER") - Power("RUNIC_POWER")<14) and ((SpellCooldown(275699)>5  or PandaDB.XDK_A9  == false  ) or Aura_Stack("target","溃烂之伤","PLAYER|HARMFUL")>4) and not (SpellCooldown(49206)<5 and IsTalent("召唤石像鬼"))) then ShowColor(mainbutton.icon, 6603,Color["凋零缠绕"]);ShowSpell(debutton.icon,Spell["凋零缠绕"]) return end
if  PandaDB.XDK_A5 ~= false  and Isuseable("天灾打击",55090) and (((Aura_time("target","溃烂之伤","PLAYER|HARMFUL")>0 and (SpellCooldown(275699)>5   or PandaDB.XDK_A9  == false  )) or Aura_Stack("target","溃烂之伤","PLAYER|HARMFUL")>4) and ((SpellCooldown("亡者大军")>5 or  PandaDB.CcdSwitch == false  or   PandaDB.XDK_A0 == false ) or  Spell_Later(43265,1,10) and Aura_Stack("player","枯萎凋零","PLAYER|HELPFUL") ==0 )   ) then ShowColor(mainbutton.icon, 6603,Color["天灾打击"]);ShowSpell(debutton.icon,Spell["天灾打击"]) return end
if  PandaDB.XDK_C1 ~= false  and Isuseable("暗影之爪",207311) and (((Aura_time("target","溃烂之伤","PLAYER|HARMFUL")>0 and (SpellCooldown(275699)>5  or PandaDB.XDK_A9  == false  )) or Aura_Stack("target","溃烂之伤","PLAYER|HARMFUL")>4) and ((SpellCooldown("亡者大军")>5 or  PandaDB.CcdSwitch == false  or   PandaDB.XDK_A0 == false ) or  Spell_Later(43265,1,10) and Aura_Stack("player","枯萎凋零","PLAYER|HELPFUL") ==0 )   ) then ShowColor(mainbutton.icon, 6603,Color["暗影之爪"]);ShowSpell(debutton.icon,Spell["暗影之爪"]) return end
if  PandaDB.XDK_A3 ~= false  and Isuseable("凋零缠绕",47541) and (PowerMax("RUNIC_POWER") - Power("RUNIC_POWER")<20 and not (SpellCooldown(49206)<5 and IsTalent("召唤石像鬼")))then ShowColor(mainbutton.icon, 6603,Color["凋零缠绕"]);ShowSpell(debutton.icon,Spell["凋零缠绕"]) return end
if  PandaDB.XDK_A4 ~= false  and Isuseable("脓疮打击",85948) and (((((Aura_Stack("target","溃烂之伤","PLAYER|HARMFUL")<4 and Aura_time("player","邪恶狂乱","PLAYER|HELPFUL")==0) or Aura_Stack("target","溃烂之伤","PLAYER|HARMFUL")<3) and SpellCooldown(275699)<3) or Aura_Stack("target","溃烂之伤","PLAYER|HARMFUL")<1) and ((SpellCooldown("亡者大军")>5 or  PandaDB.CcdSwitch == false  ) or Spell_Later(43265,1,10) and Aura_Stack("player","枯萎凋零","PLAYER|HELPFUL") ==0)) then ShowColor(mainbutton.icon, 6603,Color["脓疮打击"]);ShowSpell(debutton.icon,Spell["脓疮打击"]) return end
if  PandaDB.XDK_A3 ~= false  and Isuseable("凋零缠绕",47541) and ( not (SpellCooldown(49206)<5 and IsTalent("召唤石像鬼"))) then ShowColor(mainbutton.icon, 6603,Color["凋零缠绕"]);ShowSpell(debutton.icon,Spell["凋零缠绕"]) return end

end

--------单目标----------- 
if  PandaDB.XDK_A3 ~= false  and Isuseable("凋零缠绕",47541) and (Aura_time("player","末日降临","PLAYER|HELPFUL")>0 and not (SpellCooldown(49206)<5 and IsTalent("召唤石像鬼")) or not Summon_Pet()) then ShowColor(mainbutton.icon, 6603,Color["凋零缠绕"]);ShowSpell(debutton.icon,Spell["凋零缠绕"]) return end
if  PandaDB.XDK_A3 ~= false  and Isuseable("凋零缠绕",47541) and ((PowerMax("RUNIC_POWER") - Power("RUNIC_POWER")<14) and ((SpellCooldown(275699)>5 or PandaDB.XDK_A9  == false ) or Aura_Stack("target","溃烂之伤","PLAYER|HARMFUL")>4) and not (SpellCooldown(49206)<5 and IsTalent("召唤石像鬼"))) then ShowColor(mainbutton.icon, 6603,Color["凋零缠绕"]);ShowSpell(debutton.icon,Spell["凋零缠绕"]) return end
if  PandaDB.XDK_A7 ~= false  and Isuseable("枯萎凋零",43265) and not IsTalent('亵渎') and (IsTalent('疫病') and (SpellCooldown(275699)>0 or PandaDB.XDK_A9  == false  )) then ShowColor(mainbutton.icon, 6603,Color["枯萎凋零"]);ShowSpell(debutton.icon,Spell["枯萎凋零"]) return end
if  PandaDB.XDK_C5 ~= false  and Isuseable("亵渎",152280) and  IsTalent('亵渎') and (SpellCooldown(275699)>0 or PandaDB.XDK_A9  == false  ) then ShowColor(mainbutton.icon, 6603,Color["亵渎"]);ShowSpell(debutton.icon,Spell["亵渎"]) return end
if  PandaDB.XDK_A5 ~= false  and Isuseable("天灾打击",55090) and (((Aura_time("target","溃烂之伤","PLAYER|HARMFUL")>0 and ((SpellCooldown(275699)>5 or PandaDB.XDK_A9  == false  ) and (not Isuseable('完美愿景',"296325") or not IsTalent('邪恶狂乱')) or Isuseable('完美愿景',"296325") and IsTalent('邪恶狂乱') and ((SpellCooldown(207289)>6 or  PandaDB.CcdSwitch == false ) and AzltE('亡灵魔导师') or not AzltE('亡灵魔导师') and (SpellCooldown(275699)>4 or PandaDB.XDK_A9  == false  )))) or Aura_Stack("target","溃烂之伤","PLAYER|HARMFUL")>4) and ((SpellCooldown("亡者大军")>5 or  PandaDB.CcdSwitch == false  or   PandaDB.XDK_A0 == false ) or Spell_Later(43265,1,10) and Aura_Stack("player","枯萎凋零","PLAYER|HELPFUL") ==0 )  ) then ShowColor(mainbutton.icon, 6603,Color["天灾打击"]);ShowSpell(debutton.icon,Spell["天灾打击"]) return end
if  PandaDB.XDK_C1 ~= false  and Isuseable("暗影之爪",207311) and (((Aura_time("target","溃烂之伤","PLAYER|HARMFUL")>0 and ((SpellCooldown(275699)>5 or PandaDB.XDK_A9  == false  ) and (not Isuseable('完美愿景',"296325") or not IsTalent('邪恶狂乱')) or Isuseable('完美愿景',"296325") and IsTalent('邪恶狂乱') and ((SpellCooldown(207289)>6 or  PandaDB.CcdSwitch == false ) and AzltE('亡灵魔导师') or not AzltE('亡灵魔导师') and (SpellCooldown(275699)>4 or PandaDB.XDK_A9  == false  )))) or Aura_Stack("target","溃烂之伤","PLAYER|HARMFUL")>4) and ((SpellCooldown("亡者大军")>5 or  PandaDB.CcdSwitch == false  or   PandaDB.XDK_A0 == false ) or Spell_Later(43265,1,10) and Aura_Stack("player","枯萎凋零","PLAYER|HELPFUL") ==0 )  ) then ShowColor(mainbutton.icon, 6603,Color["暗影之爪"]);ShowSpell(debutton.icon,Spell["暗影之爪"]) return end
if  PandaDB.XDK_A3 ~= false  and Isuseable("凋零缠绕",47541) and (PowerMax("RUNIC_POWER") - Power("RUNIC_POWER")<20 and not (SpellCooldown(49206)<5 and IsTalent("召唤石像鬼"))) then ShowColor(mainbutton.icon, 6603,Color["凋零缠绕"]);ShowSpell(debutton.icon,Spell["凋零缠绕"]) return end
if  PandaDB.XDK_A4 ~= false  and Isuseable("脓疮打击",85948) and (Aura_Stack("target","溃烂之伤","PLAYER|HARMFUL")<4 and ((not Isuseable('完美愿景',"296325") or not IsTalent('邪恶狂乱') or Isuseable('完美愿景',"296325") and IsTalent('邪恶狂乱') and (SpellCooldown(207289)<7 and AzltE('亡灵魔导师') or not AzltE('亡灵魔导师') )) )or Aura_Stack("target","溃烂之伤","PLAYER|HARMFUL")<1 and ( (SpellCooldown("亡者大军")>5 or  PandaDB.CcdSwitch == false  or  PandaDB.XDK_A0 == false ) or Spell_Later(43265,1,10) and Aura_Stack("player","枯萎凋零","PLAYER|HELPFUL") ==0 )  ) then ShowColor(mainbutton.icon, 6603,Color["脓疮打击"]);ShowSpell(debutton.icon,Spell["脓疮打击"]) return end
if  PandaDB.XDK_A3 ~= false  and Isuseable("凋零缠绕",47541) and ( not (SpellCooldown(49206)<5 and IsTalent("召唤石像鬼"))) then ShowColor(mainbutton.icon, 6603,Color["凋零缠绕"]);ShowSpell(debutton.icon,Spell["凋零缠绕"]) return end

-------------------------
if  PandaDB.XDK_A6 ~= false  and Isuseable("灵界打击",49998) and Aura_time("player","黑暗援助","PLAYER|HELPFUL")>0 then ShowColor(mainbutton.icon, 6603,Color["灵界打击"]);ShowSpell(debutton.icon,Spell["灵界打击"]) return end





---------------------------------------------------------------------------
--[[                       编辑区                       ]]--
---------------------------------------------------------------------------

ShowColor(mainbutton.icon, 6603,311923);ShowSpell(debutton.icon, 311923)	

--elseif not Authorization() then 
--print("|cffffe00a★Panda★:【|r|c00FF68CC 插件未激活 联系QQ:398371778 |r|cffffe00a】|r")

--end


end


end

local Death_Knight_Unholy = Death_Knight_Unholy
ns.Death_Knight_Unholy = Death_Knight_Unholy


