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

local Color = {
["剑刃风暴"] = A_1,
["巨龙怒吼"] = A_2,
["怒击"] = A_3,
["破城者"] = A_4,
["战斗怒吼"] = A_5,
["嗜血"] = A_6,
["斩杀"] = A_7,
["旋风斩"] = A_8,
["暴怒"] = A_9,
["鲁莽"] = A_0,
["狂暴挥砍"] = C_1,

["艾泽拉斯之心精华"] = C_8,
["乘胜追击"] = C_9,
}

local Spell = {
["怒击"] = 85288,
["战斗怒吼"] = 6673,
["嗜血"] = 23881,
["斩杀"] = 5308,
["旋风斩"] = 190411,
["暴怒"] = 184367,
["鲁莽"] = 1719,
["狂暴挥砍"] = 100130,
["巨龙怒吼"] = 118000,
["剑刃风暴"] = 46924,
["破城者"] = 280772,
["艾泽拉斯之心精华"] = 296208,
["乘胜追击"] = 34428,
} 


local function Warrior_Fury()  --更新主图标及技能提示图标

local mainbutton = PDUI.mainbutton
local debutton = PDUI.debutton

if PlayerClass() == "WARRIOR" and Specialization() == "狂怒" then
--if Authorization() then

--开始循环
--自动拾取器

---------------------------------------------------------------------------
--[[                       编辑区                       ]]--
---------------------------------------------------------------------------
if PandaDB.KBZ_A5 ~= false  then
if Isuseable("战斗怒吼",6673) and (Aura_time("player","战斗怒吼")<1 and time_x(0)) then ShowColor(mainbutton.icon, 6603,Color["战斗怒吼"]);ShowSpell(debutton.icon,Spell["战斗怒吼"]) return end
end

if Isuseable("乘胜追击",34428) and PandaDB.KBZ_C9 ~= false  and not IsTalent('胜利在望') and HealthPercent("player")<=80 then ShowColor(mainbutton.icon, 6603,Color["乘胜追击"]);ShowSpell(debutton.icon,Spell["乘胜追击"]) return end
if Isuseable("胜利在望",202168) and PandaDB.KBZ_C9 ~= false  and IsTalent('胜利在望') and HealthPercent("player")<=80  then ShowColor(mainbutton.icon, 6603,Color["乘胜追击"]);ShowSpell(debutton.icon,Spell["乘胜追击"]) return end

if PandaDB.KBZ_A9 ~= false  then
if Isuseable('暴怒',184367) and (SpellCooldown(1719)<3 or  PandaDB.KBZ_A0 == false  or  PandaDB.CcdSwitch == false ) then ShowColor(mainbutton.icon, 6603,Color["暴怒"]);ShowSpell(debutton.icon,Spell["暴怒"]) return end
end

if PandaDB.CcdSwitch ~= false  then


if PandaDB.KBZ_A0 ~= false  then
if Isuseable('鲁莽',1719) then ShowColor(mainbutton.icon, 6603,Color["鲁莽"]);ShowSpell(debutton.icon,Spell["鲁莽"]) return end
end

if PandaDB.KBZ_A4 ~= false  then
if Isuseable('破城者',280772) and active_enemies()<=1 then ShowColor(mainbutton.icon, 6603,Color["破城者"]);ShowSpell(debutton.icon,Spell["破城者"]) return end
end


--essences
if PandaDB.KBZ_C8 then
if Isuseable("仇敌之血","仇敌之血") and Aura_time('player','鲁莽')>0 then ShowColor(mainbutton.icon, 6603,Color["艾泽拉斯之心精华"]);ShowSpell(debutton.icon,Spell["艾泽拉斯之心精华"]) return end
end

if PandaDB.KBZ_C8 then
if Isuseable("艾泽拉斯守护者","艾泽拉斯守护者") then ShowColor(mainbutton.icon, 6603,Color["艾泽拉斯之心精华"]);ShowSpell(debutton.icon,Spell["艾泽拉斯之心精华"]) return end
end

if PandaDB.KBZ_C8 then
if Isuseable("不羁之力","不羁之力") then ShowColor(mainbutton.icon, 6603,Color["艾泽拉斯之心精华"]);ShowSpell(debutton.icon,Spell["艾泽拉斯之心精华"]) return end
end

if PandaDB.KBZ_C8 then
if Isuseable("聚能艾泽里特射线","聚能艾泽里特射线") and Useing_spell("player") ~= 295258 then ShowColor(mainbutton.icon, 6603,Color["艾泽拉斯之心精华"]);ShowSpell(debutton.icon,Spell["艾泽拉斯之心精华"]) return end
end

if PandaDB.KBZ_C8 then
if Isuseable("火红烈焰","火红烈焰") then ShowColor(mainbutton.icon, 6603,Color["艾泽拉斯之心精华"]);ShowSpell(debutton.icon,Spell["艾泽拉斯之心精华"]) return end
end

if PandaDB.KBZ_C8 then
if Isuseable("净化冲击","净化冲击") then ShowColor(mainbutton.icon, 6603,Color["艾泽拉斯之心精华"]);ShowSpell(debutton.icon,Spell["艾泽拉斯之心精华"]) return end
end

if PandaDB.KBZ_C8 then
if Isuseable("世界血脉共鸣","世界血脉共鸣") then ShowColor(mainbutton.icon, 6603,Color["艾泽拉斯之心精华"]);ShowSpell(debutton.icon,Spell["艾泽拉斯之心精华"]) return end
end

if PandaDB.KBZ_C8 then
if Isuseable("空间涟漪","空间涟漪") then ShowColor(mainbutton.icon, 6603,Color["艾泽拉斯之心精华"]);ShowSpell(debutton.icon,Spell["艾泽拉斯之心精华"]) return end
end

if PandaDB.KBZ_C8 then
if Isuseable("清醒梦境之忆","清醒梦境之忆") then ShowColor(mainbutton.icon, 6603,Color["艾泽拉斯之心精华"]);ShowSpell(debutton.icon,Spell["艾泽拉斯之心精华"]) return end
end

if PandaDB.KBZ_C8 then
if Isuseable("收割火焰","收割火焰")  then ShowColor(mainbutton.icon, 6603,Color["艾泽拉斯之心精华"]);ShowSpell(debutton.icon,Spell["艾泽拉斯之心精华"]) return end
end

if PandaDB.KBZ_C8 then
if Isuseable("生命缚誓者之祈","生命缚誓者之祈")  then ShowColor(mainbutton.icon, 6603,Color["艾泽拉斯之心精华"]);ShowSpell(debutton.icon,Spell["艾泽拉斯之心精华"]) return end
end

if PandaDB.KBZ_C8 then
if Isuseable("救世之魂","救世之魂")  then ShowColor(mainbutton.icon, 6603,Color["艾泽拉斯之心精华"]);ShowSpell(debutton.icon,Spell["艾泽拉斯之心精华"]) return end
end

if PandaDB.KBZ_C8 then
if Isuseable("守护屏障","守护屏障")  then ShowColor(mainbutton.icon, 6603,Color["艾泽拉斯之心精华"]);ShowSpell(debutton.icon,Spell["艾泽拉斯之心精华"]) return end
end

if PandaDB.KBZ_C8 then
if Isuseable("补充能量","补充能量")  then ShowColor(mainbutton.icon, 6603,Color["艾泽拉斯之心精华"]);ShowSpell(debutton.icon,Spell["艾泽拉斯之心精华"]) return end
end

if PandaDB.KBZ_C8 then
if Isuseable("静滞","静滞")  then ShowColor(mainbutton.icon, 6603,Color["艾泽拉斯之心精华"]);ShowSpell(debutton.icon,Spell["艾泽拉斯之心精华"]) return end
end

if PandaDB.KBZ_C8 then
if Isuseable("法力过载","法力过载")  then ShowColor(mainbutton.icon, 6603,Color["艾泽拉斯之心精华"]);ShowSpell(debutton.icon,Spell["艾泽拉斯之心精华"]) return end
end

if PandaDB.KBZ_C8 then
if Isuseable("活力导管","活力导管")  then ShowColor(mainbutton.icon, 6603,Color["艾泽拉斯之心精华"]);ShowSpell(debutton.icon,Spell["艾泽拉斯之心精华"]) return end
end

if PandaDB.KBZ_C8 then
if Isuseable("爆燃之拥","爆燃之拥")  then ShowColor(mainbutton.icon, 6603,Color["艾泽拉斯之心精华"]);ShowSpell(debutton.icon,Spell["艾泽拉斯之心精华"]) return end
end

if PandaDB.KBZ_C8 then
if Isuseable("光荣时刻","光荣时刻")  then ShowColor(mainbutton.icon, 6603,Color["艾泽拉斯之心精华"]);ShowSpell(debutton.icon,Spell["艾泽拉斯之心精华"]) return end
end

if PandaDB.KBZ_C8 then
if Isuseable("深渊之护","深渊之护")  then ShowColor(mainbutton.icon, 6603,Color["艾泽拉斯之心精华"]);ShowSpell(debutton.icon,Spell["艾泽拉斯之心精华"]) return end
end

if PandaDB.KBZ_C8 then
if Isuseable("艾泽拉斯的不朽赐福","艾泽拉斯的不朽赐福")  then ShowColor(mainbutton.icon, 6603,Color["艾泽拉斯之心精华"]);ShowSpell(debutton.icon,Spell["艾泽拉斯之心精华"]) return end
end

if PandaDB.KBZ_C8 then
if Isuseable("强化虚无屏障","强化虚无屏障")  then ShowColor(mainbutton.icon, 6603,Color["艾泽拉斯之心精华"]);ShowSpell(debutton.icon,Spell["艾泽拉斯之心精华"]) return end
end

end
----------------------------
if PandaDB.KBZ_A8 ~= false  then
if Isuseable('旋风斩',190411) and (active_enemies()>1 and Aura_time('player','旋风斩','PLAYER|HELPFUL')==0) then ShowColor(mainbutton.icon, 6603,Color["旋风斩"]);ShowSpell(debutton.icon,Spell["旋风斩"]) return end
end

if PandaDB.KBZ_A4 ~= false  then
if Isuseable('破城者',280772) and active_enemies()>1 and  Aura_time('player','旋风斩','PLAYER|HELPFUL')> 0 then ShowColor(mainbutton.icon, 6603,Color["破城者"]);ShowSpell(debutton.icon,Spell["破城者"]) return end
end


if PandaDB.KBZ_A2 ~= false  then
if Isuseable('巨龙怒吼',118000) and (Aura_time('player','激怒','PLAYER|HELPFUL')>0)  then ShowColor(mainbutton.icon, 6603,Color["巨龙怒吼"]);ShowSpell(debutton.icon,Spell["巨龙怒吼"]) return end
end

if PandaDB.KBZ_A9 ~= false  then
if Isuseable('暴怒',184367) and ((Aura_time('player','鲁莽','PLAYER|HELPFUL')>0 or Aura_time('player','清醒梦境之忆','PLAYER|HELPFUL')>0) or (IsTalent('暴乱狂战士') or IsTalent('屠戮') and (Aura_time('player','激怒','PLAYER|HELPFUL')<GCD_MAX() or Power('RAGE')>90) or IsTalent('屠杀') and (Aura_time('player','激怒','PLAYER|HELPFUL')<GCD_MAX() or Power('RAGE')>90))) then ShowColor(mainbutton.icon, 6603,Color["暴怒"]);ShowSpell(debutton.icon,Spell["暴怒"]) return end
end

if PandaDB.KBZ_A7 ~= false then
if Isuseable('斩杀',GetSpellID("斩杀")) and SpellCooldown(GetSpellID("斩杀"))==0 and (Aura_time("player","猝死")>0 or HealthPercent("target")<=20 or (IsTalent("屠杀") and HealthPercent("target")<=35 ) ) then ShowColor(mainbutton.icon, 6603,Color["斩杀"]);ShowSpell(debutton.icon,Spell["斩杀"]) return end
end

if PandaDB.KBZ_C1 ~= false  then
if Isuseable('狂暴挥砍',100130) and (Aura_time('player','嗜血','PLAYER|HELPFUL')==0 and Aura_Stack('player','狂暴挥砍','PLAYER|HELPFUL')<3) then ShowColor(mainbutton.icon, 6603,Color["狂暴挥砍"]);ShowSpell(debutton.icon,Spell["狂暴挥砍"]) return end
end

if PandaDB.KBZ_A1 ~= false  then
if Isuseable('剑刃风暴',46924) and (Last_Spell(1)==201363 ) then ShowColor(mainbutton.icon, 6603,Color["剑刃风暴"]);ShowSpell(debutton.icon,Spell["剑刃风暴"]) return end
end

if PandaDB.KBZ_A6 ~= false  then
if Isuseable('嗜血',23881) and (Aura_time('player','激怒','PLAYER|HELPFUL')==0 or AzltE('寒光热血')>1) then ShowColor(mainbutton.icon, 6603,Color["嗜血"]);ShowSpell(debutton.icon,Spell["嗜血"]) return end
end

if PandaDB.KBZ_A3 ~= false  then
if Isuseable('怒击',85288) and (SpellCharges(85288)==2) then ShowColor(mainbutton.icon, 6603,Color["怒击"]);ShowSpell(debutton.icon,Spell["怒击"]) return end
end

if PandaDB.KBZ_A6 ~= false  then
if Isuseable('嗜血',23881) then ShowColor(mainbutton.icon, 6603,Color["嗜血"]);ShowSpell(debutton.icon,Spell["嗜血"]) return end
end

if PandaDB.KBZ_A3 ~= false  then
if Isuseable('怒击',85288) and (IsTalent('屠戮') or (IsTalent('屠杀') and Power('RAGE')<80) or (IsTalent('暴乱狂战士') and Power('RAGE')<90)) then ShowColor(mainbutton.icon, 6603,Color["怒击"]);ShowSpell(debutton.icon,Spell["怒击"]) return end
end

if PandaDB.KBZ_C1 ~= false  then
if Isuseable('狂暴挥砍',100130) and (IsTalent('狂暴挥砍')) then ShowColor(mainbutton.icon, 6603,Color["狂暴挥砍"]);ShowSpell(debutton.icon,Spell["狂暴挥砍"]) return end
end

if PandaDB.KBZ_A8 ~= false  then
if Isuseable('旋风斩',190411) then ShowColor(mainbutton.icon, 6603,Color["旋风斩"]);ShowSpell(debutton.icon,Spell["旋风斩"]) return end
end

---------------------------------------------------------------------------
--[[                       编辑区                       ]]--
---------------------------------------------------------------------------

ShowColor(mainbutton.icon, 6603,311923);ShowSpell(debutton.icon, 311923)	

--elseif not Authorization() then 
--print("|cffffe00a★Panda★:【|r|c00FF68CC 插件未激活 联系QQ:398371778 |r|cffffe00a】|r")

--end


end


end

local Warrior_Fury = Warrior_Fury
ns.Warrior_Fury = Warrior_Fury


