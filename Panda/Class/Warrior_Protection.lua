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
["挫志怒吼"] = A_1,
["巨龙怒吼"] = A_2,
["无视苦痛"] = A_3,
["雷霆一击"] = A_4,
["战斗怒吼"] = A_5,
["破坏者"] = A_6,
["盾牌格挡"] = A_7,
["毁灭打击"] = A_8,
["盾牌猛击"] = A_9,
["复仇"] = A_0,

["天神下凡"] = C_5,
["艾泽拉斯之心精华"] = C_8,
["乘胜追击"] = C_9,
}

local Spell = {
["挫志怒吼"] = 1160,
["复仇"] = 6572,
["无视苦痛"] = 190456,
["战斗怒吼"] = 6673,
["天神下凡"] = 107574,
["毁灭打击"] = 20243,
["盾牌格挡"] = 2565,
["雷霆一击"] = 6343,
["破坏者"] = 228920,
["巨龙怒吼"] = 118000,
["盾牌猛击"] = 23922,
["艾泽拉斯之心精华"] = 296208,
["乘胜追击"] = 34428,
} 

local function WSKT()
local A=0
if IsTalent('震耳嗓音') and SpellCooldown(1160)==0 then
A=20
else
A=0
end
return A
end

local function Warrior_Protection()  --更新主图标及技能提示图标

local mainbutton = PDUI.mainbutton
local debutton = PDUI.debutton

if PlayerClass() == "WARRIOR" and Specialization() == "防护" then
--if Authorization() then



---------------------------------------------------------------------------
--[[                       编辑区                       ]]--
---------------------------------------------------------------------------
if PandaDB.KBZ_A5 ~= false  then
if Isuseable("战斗怒吼",6673) and (Aura_time("player","战斗怒吼")<1 and time_x(0)) then ShowColor(mainbutton.icon, 6603,Color["战斗怒吼"]);ShowSpell(debutton.icon,Spell["战斗怒吼"]) return end
end

if Isuseable("乘胜追击",34428) and PandaDB.FZ_C9 ~= false  and not IsTalent('胜利在望') and HealthPercent("player")<=80 then ShowColor(mainbutton.icon, 6603,Color["乘胜追击"]);ShowSpell(debutton.icon,Spell["乘胜追击"]) return end
if Isuseable("胜利在望",202168) and PandaDB.FZ_C9 ~= false  and IsTalent('胜利在望') and HealthPercent("player")<=80  then ShowColor(mainbutton.icon, 6603,Color["乘胜追击"]);ShowSpell(debutton.icon,Spell["乘胜追击"]) return end

if PandaDB.CcdSwitch ~= false   then 

if PandaDB.FZ_A3 ~= false  then
if Isuseable("无视苦痛",190456) and (Aura_time('player','无视苦痛','PLAYER|HELPFUL')==0) then ShowColor(mainbutton.icon, 6603,Color["无视苦痛"]);ShowSpell(debutton.icon,Spell["无视苦痛"]) return end
end

if PandaDB.FZ_C5 ~= false  then
if Isuseable("天神下凡",107574) then ShowColor(mainbutton.icon, 6603,Color["天神下凡"]);ShowSpell(debutton.icon,Spell["天神下凡"]) return end
end

--essences
if PandaDB.FZ_C8 then
if Isuseable("仇敌之血","仇敌之血") then ShowColor(mainbutton.icon, 6603,Color["艾泽拉斯之心精华"]);ShowSpell(debutton.icon,Spell["艾泽拉斯之心精华"]) return end
end

if PandaDB.FZ_C8 then
if Isuseable("艾泽拉斯守护者","艾泽拉斯守护者") then ShowColor(mainbutton.icon, 6603,Color["艾泽拉斯之心精华"]);ShowSpell(debutton.icon,Spell["艾泽拉斯之心精华"]) return end
end

if PandaDB.FZ_C8 then
if Isuseable("不羁之力","不羁之力") then ShowColor(mainbutton.icon, 6603,Color["艾泽拉斯之心精华"]);ShowSpell(debutton.icon,Spell["艾泽拉斯之心精华"]) return end
end

if PandaDB.FZ_C8 then
if Isuseable("聚能艾泽里特射线","聚能艾泽里特射线") and Useing_spell("player") ~= 295258 then ShowColor(mainbutton.icon, 6603,Color["艾泽拉斯之心精华"]);ShowSpell(debutton.icon,Spell["艾泽拉斯之心精华"]) return end
end

if PandaDB.FZ_C8 then
if Isuseable("火红烈焰","火红烈焰") then ShowColor(mainbutton.icon, 6603,Color["艾泽拉斯之心精华"]);ShowSpell(debutton.icon,Spell["艾泽拉斯之心精华"]) return end
end

if PandaDB.FZ_C8 then
if Isuseable("净化冲击","净化冲击") then ShowColor(mainbutton.icon, 6603,Color["艾泽拉斯之心精华"]);ShowSpell(debutton.icon,Spell["艾泽拉斯之心精华"]) return end
end

if PandaDB.FZ_C8 then
if Isuseable("世界血脉共鸣","世界血脉共鸣") then ShowColor(mainbutton.icon, 6603,Color["艾泽拉斯之心精华"]);ShowSpell(debutton.icon,Spell["艾泽拉斯之心精华"]) return end
end

if PandaDB.FZ_C8 then
if Isuseable("空间涟漪","空间涟漪") then ShowColor(mainbutton.icon, 6603,Color["艾泽拉斯之心精华"]);ShowSpell(debutton.icon,Spell["艾泽拉斯之心精华"]) return end
end

if PandaDB.FZ_C8 then
if Isuseable("清醒梦境之忆","清醒梦境之忆") then ShowColor(mainbutton.icon, 6603,Color["艾泽拉斯之心精华"]);ShowSpell(debutton.icon,Spell["艾泽拉斯之心精华"]) return end
end

if PandaDB.FZ_C8 then
if Isuseable("收割火焰","收割火焰")  then ShowColor(mainbutton.icon, 6603,Color["艾泽拉斯之心精华"]);ShowSpell(debutton.icon,Spell["艾泽拉斯之心精华"]) return end
end

if PandaDB.FZ_C8 then
if Isuseable("生命缚誓者之祈","生命缚誓者之祈")  then ShowColor(mainbutton.icon, 6603,Color["艾泽拉斯之心精华"]);ShowSpell(debutton.icon,Spell["艾泽拉斯之心精华"]) return end
end

if PandaDB.FZ_C8 then
if Isuseable("救世之魂","救世之魂")  then ShowColor(mainbutton.icon, 6603,Color["艾泽拉斯之心精华"]);ShowSpell(debutton.icon,Spell["艾泽拉斯之心精华"]) return end
end

if PandaDB.FZ_C8 then
if Isuseable("守护屏障","守护屏障")  then ShowColor(mainbutton.icon, 6603,Color["艾泽拉斯之心精华"]);ShowSpell(debutton.icon,Spell["艾泽拉斯之心精华"]) return end
end

if PandaDB.FZ_C8 then
if Isuseable("补充能量","补充能量")  then ShowColor(mainbutton.icon, 6603,Color["艾泽拉斯之心精华"]);ShowSpell(debutton.icon,Spell["艾泽拉斯之心精华"]) return end
end

if PandaDB.FZ_C8 then
if Isuseable("静滞","静滞")  then ShowColor(mainbutton.icon, 6603,Color["艾泽拉斯之心精华"]);ShowSpell(debutton.icon,Spell["艾泽拉斯之心精华"]) return end
end

if PandaDB.FZ_C8 then
if Isuseable("法力过载","法力过载")  then ShowColor(mainbutton.icon, 6603,Color["艾泽拉斯之心精华"]);ShowSpell(debutton.icon,Spell["艾泽拉斯之心精华"]) return end
end

if PandaDB.FZ_C8 then
if Isuseable("活力导管","活力导管")  then ShowColor(mainbutton.icon, 6603,Color["艾泽拉斯之心精华"]);ShowSpell(debutton.icon,Spell["艾泽拉斯之心精华"]) return end
end

if PandaDB.FZ_C8 then
if Isuseable("爆燃之拥","爆燃之拥")  then ShowColor(mainbutton.icon, 6603,Color["艾泽拉斯之心精华"]);ShowSpell(debutton.icon,Spell["艾泽拉斯之心精华"]) return end
end

if PandaDB.FZ_C8 then
if Isuseable("光荣时刻","光荣时刻")  then ShowColor(mainbutton.icon, 6603,Color["艾泽拉斯之心精华"]);ShowSpell(debutton.icon,Spell["艾泽拉斯之心精华"]) return end
end

if PandaDB.FZ_C8 then
if Isuseable("深渊之护","深渊之护")  then ShowColor(mainbutton.icon, 6603,Color["艾泽拉斯之心精华"]);ShowSpell(debutton.icon,Spell["艾泽拉斯之心精华"]) return end
end

if PandaDB.FZ_C8 then
if Isuseable("艾泽拉斯的不朽赐福","艾泽拉斯的不朽赐福")  then ShowColor(mainbutton.icon, 6603,Color["艾泽拉斯之心精华"]);ShowSpell(debutton.icon,Spell["艾泽拉斯之心精华"]) return end
end

if PandaDB.FZ_C8 then
if Isuseable("强化虚无屏障","强化虚无屏障")  then ShowColor(mainbutton.icon, 6603,Color["艾泽拉斯之心精华"]);ShowSpell(debutton.icon,Spell["艾泽拉斯之心精华"]) return end
end
---------------

end

if active_enemies()>=3 then

if PandaDB.FZ_A4 ~= false  then
if Isuseable("雷霆一击",6343) then ShowColor(mainbutton.icon, 6603,Color["雷霆一击"]);ShowSpell(debutton.icon,Spell["雷霆一击"]) return end
end

if PandaDB.FZ_A1 ~= false  then
if Isuseable("挫志怒吼",1160) and (IsTalent('震耳嗓音')) then ShowColor(mainbutton.icon, 6603,Color["挫志怒吼"]);ShowSpell(debutton.icon,Spell["挫志怒吼"]) return end
end

if PandaDB.FZ_A2 ~= false  then
if Isuseable("巨龙怒吼",118000) then ShowColor(mainbutton.icon, 6603,Color["巨龙怒吼"]);ShowSpell(debutton.icon,Spell["巨龙怒吼"]) return end
end

if PandaDB.FZ_A0 ~= false  then
if Isuseable("复仇",6572) and (Aura_time('player','无视苦痛','PLAYER|HELPFUL')>2 or Power('RAGE')>80 or  PandaDB.FZ_A3 == false  or PandaDB.CcdSwitch == false ) then ShowColor(mainbutton.icon, 6603,Color["复仇"]);ShowSpell(debutton.icon,Spell["复仇"]) return end
end

if PandaDB.FZ_A6 ~= false  and PandaDB.CcdSwitch ~= false  then
if Isuseable("破坏者",228920) then ShowColor(mainbutton.icon, 6603,Color["破坏者"]);ShowSpell(debutton.icon,Spell["破坏者"]) return end
end

if PandaDB.FZ_A7 ~= false  then
if Isuseable("盾牌格挡",2565) and ( (SpellallCharges(2565) >= 1.8 or SpellCooldown(23922)==0 ) and Aura_time('player','盾牌格挡','PLAYER|HELPFUL')==0) then ShowColor(mainbutton.icon, 6603,Color["盾牌格挡"]);ShowSpell(debutton.icon,Spell["盾牌格挡"]) return end
end

end

if PandaDB.FZ_A9 ~= false  then
if Isuseable("盾牌猛击",23922) then ShowColor(mainbutton.icon, 6603,Color["盾牌猛击"]);ShowSpell(debutton.icon,Spell["盾牌猛击"]) return end
end

if active_enemies()<3 then

if PandaDB.FZ_A4 ~= false  then
if Isuseable("雷霆一击",6343) and (IsTalent('无坚不摧之力') and Aura_time('player','天神下凡','PLAYER|HELPFUL')>0 or  PandaDB.FZ_C5 == false  or PandaDB.CcdSwitch == false ) then ShowColor(mainbutton.icon, 6603,Color["雷霆一击"]);ShowSpell(debutton.icon,Spell["雷霆一击"]) return end
end

if PandaDB.FZ_A7 ~= false  then
if Isuseable("盾牌格挡",2565) and ((SpellallCharges(2565) >= 1.8 or SpellCooldown(23922)==0 ) and Aura_time('player','盾牌格挡','PLAYER|HELPFUL')==0) then ShowColor(mainbutton.icon, 6603,Color["盾牌格挡"]);ShowSpell(debutton.icon,Spell["盾牌格挡"]) return end
end

if PandaDB.FZ_A9 ~= false  then
if Isuseable("盾牌猛击",23922) and (Aura_time('player','盾牌格挡','PLAYER|HELPFUL')>0) then ShowColor(mainbutton.icon, 6603,Color["盾牌猛击"]);ShowSpell(debutton.icon,Spell["盾牌猛击"]) return end
end

if PandaDB.FZ_A4 ~= false  then
if Isuseable("雷霆一击",6343) and (IsTalent('无坚不摧之力') and Aura_time('player','天神下凡','PLAYER|HELPFUL')>0 or  PandaDB.FZ_C5 == false  or PandaDB.CcdSwitch == false  ) then ShowColor(mainbutton.icon, 6603,Color["雷霆一击"]);ShowSpell(debutton.icon,Spell["雷霆一击"]) return end
end

if PandaDB.FZ_A1 ~= false  then
if Isuseable("挫志怒吼",1160) and (IsTalent('震耳嗓音')) then ShowColor(mainbutton.icon, 6603,Color["挫志怒吼"]);ShowSpell(debutton.icon,Spell["挫志怒吼"]) return end
end

if PandaDB.FZ_A9 ~= false  then
if Isuseable("盾牌猛击",23922) then ShowColor(mainbutton.icon, 6603,Color["盾牌猛击"]);ShowSpell(debutton.icon,Spell["盾牌猛击"]) return end
end

if PandaDB.FZ_A2 ~= false  then
if Isuseable("巨龙怒吼",118000) then ShowColor(mainbutton.icon, 6603,Color["巨龙怒吼"]);ShowSpell(debutton.icon,Spell["巨龙怒吼"]) return end
end

if PandaDB.FZ_A4 ~= false  then
if Isuseable("雷霆一击",6343) then ShowColor(mainbutton.icon, 6603,Color["雷霆一击"]);ShowSpell(debutton.icon,Spell["雷霆一击"]) return end
end

if PandaDB.FZ_A0 ~= false  then
if Isuseable("复仇",6572) and (Aura_time('player','无视苦痛','PLAYER|HELPFUL')>2 or Power('RAGE')>80 or  PandaDB.FZ_A3 == false  or PandaDB.CcdSwitch == false  ) then ShowColor(mainbutton.icon, 6603,Color["复仇"]);ShowSpell(debutton.icon,Spell["复仇"]) return end
end

if PandaDB.FZ_A6 ~= false  and PandaDB.CcdSwitch ~= false  then
if Isuseable("破坏者",228920) then ShowColor(mainbutton.icon, 6603,Color["破坏者"]);ShowSpell(debutton.icon,Spell["破坏者"]) return end
end

end

if PandaDB.FZ_A8 ~= false  then
if Isuseable("毁灭打击",20243) then ShowColor(mainbutton.icon, 6603,Color["毁灭打击"]);ShowSpell(debutton.icon,Spell["毁灭打击"]) return end
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

local Warrior_Protection = Warrior_Protection
ns.Warrior_Protection = Warrior_Protection


