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


local desired_targets = 1

local function Demon_Hunter_Vengeance()  --更新主图标及技能提示图标

local mainbutton = PDUI.mainbutton
local debutton = PDUI.debutton


if PlayerClass()=="DEMONHUNTER" and Specialization()=="复仇"  then
--if Authorization() then
---simc变量声明
--开始循环


--最高优先级


--战斗前

--# Fiery Brand Rotation
if PandaDB.FC_A3 ~= false  and Isuseable("烈焰咒符",204596) then
if SpellCooldown(204021)<2 then ShowColor(mainbutton.icon, 6603,A_3);ShowSpell(debutton.icon,204596) return end
end

if PandaDB.CcdSwitch ~= false  then
if PandaDB.FC_A2 ~= false  and Isuseable("烈火烙印",204021) then ShowColor(mainbutton.icon, 6603,A_2);ShowSpell(debutton.icon,204021) return end
end

if PandaDB.FC_A8 ~= false  and Isuseable("献祭光环",178740) then 
if Aura_time("TARGET","烈火烙印","PLAYER|HARMFUL")>0 then ShowColor(mainbutton.icon, 6603,A_8);ShowSpell(debutton.icon,178740) return end
end

if PandaDB.CcdSwitch ~= false  then
if PandaDB.FC_C2 ~= false  and Isuseable("邪能毁灭",212084) then 
if Aura_time("TARGET","烈火烙印","PLAYER|HARMFUL")>0 then ShowColor(mainbutton.icon, 6603,C_2);ShowSpell(debutton.icon,212084) return end
end
end

if PandaDB.FC_A3 ~= false  and Isuseable("烈焰咒符",204596) then
if Aura_time("TARGET","烈火烙印","PLAYER|HARMFUL")>0 then ShowColor(mainbutton.icon, 6603,A_3);ShowSpell(debutton.icon,204596) return end
end 


if PandaDB.FC_C1 ~= false  and Isuseable("投掷利刃",204157) and UnitRange("TARGET")>=20 and UnitCanAttack( 'player', "TARGET" ) then ShowColor(mainbutton.icon, 6603,C_1);ShowSpell(debutton.icon,204157) return end

if PandaDB.CcdSwitch ~= false  then
--艾泽拉斯之心精华
--essences
if PandaDB.FC_C8 then
if Isuseable("仇敌之血","仇敌之血") then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.FC_C8 then
if Isuseable("艾泽拉斯守护者","艾泽拉斯守护者") then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.FC_C8 then
if Isuseable("不羁之力","不羁之力") then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.FC_C8 then
if Isuseable("聚能艾泽里特射线","聚能艾泽里特射线") and Useing_spell("player") ~= 295258 then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.FC_C8 then
if Isuseable("火红烈焰","火红烈焰") then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.FC_C8 then
if Isuseable("净化冲击","净化冲击") then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.FC_C8 then
if Isuseable("世界血脉共鸣","世界血脉共鸣") then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.FC_C8 then
if Isuseable("空间涟漪","空间涟漪") then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.FC_C8 then
if Isuseable("清醒梦境之忆","清醒梦境之忆") then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.FC_C8 then
if Isuseable("收割火焰","收割火焰")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.FC_C8 then
if Isuseable("生命缚誓者之祈","生命缚誓者之祈")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.FC_C8 then
if Isuseable("救世之魂","救世之魂")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.FC_C8 then
if Isuseable("守护屏障","守护屏障")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.FC_C8 then
if Isuseable("补充能量","补充能量")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.FC_C8 then
if Isuseable("静滞","静滞")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.FC_C8 then
if Isuseable("法力过载","法力过载")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.FC_C8 then
if Isuseable("活力导管","活力导管")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.FC_C8 then
if Isuseable("爆燃之拥","爆燃之拥")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.FC_C8 then
if Isuseable("光荣时刻","光荣时刻")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.FC_C8 then
if Isuseable("深渊之护","深渊之护")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.FC_C8 then
if Isuseable("艾泽拉斯的不朽赐福","艾泽拉斯的不朽赐福")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.FC_C8 then
if Isuseable("强化虚无屏障","强化虚无屏障")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

end	   
	   
--# Defensives
if PandaDB.CcdSwitch ~= false  then
if PandaDB.FC_A6 ~= false  and Isuseable("恶魔尖刺",203720) then ShowColor(mainbutton.icon, 6603,A_6);ShowSpell(debutton.icon,203720) return end
if PandaDB.FC_A1 ~= false  and Isuseable("恶魔变形",187827) then ShowColor(mainbutton.icon, 6603,A_1);ShowSpell(debutton.icon,187827) return end
if PandaDB.FC_A2 ~= false  and Isuseable("烈火烙印",204021) then ShowColor(mainbutton.icon, 6603,A_2);ShowSpell(debutton.icon,204021) return end
end

--# Normal Rotation
if PandaDB.FC_A7 ~= false  and Isuseable("幽魂炸弹",247454) then 
if (( Aura_time("PLAYER","恶魔变形")>0 and Aura_Stack("PLAYER","灵魂残片","PLAYER|HELPFUL")>=3 ) or Aura_Stack("PLAYER","灵魂残片","PLAYER|HELPFUL")>=4 ) then ShowColor(mainbutton.icon, 6603,A_7);ShowSpell(debutton.icon,247454) return end
end


if  PandaDB.FC_A4 ~= false  and Isuseable("灵魂裂劈",228477) then
if (not IsTalent("幽魂炸弹") and (( Aura_time("PLAYER","恶魔变形")>0 and Aura_Stack("PLAYER","灵魂残片","PLAYER|HELPFUL")>=3 ) or Aura_Stack("PLAYER","灵魂残片","PLAYER|HELPFUL")>=4 )) then ShowColor(mainbutton.icon, 6603,A_4);ShowSpell(debutton.icon,228477) return end
end

if  PandaDB.FC_A4 ~= false  and Isuseable("灵魂裂劈",228477) then
if IsTalent("幽魂炸弹") and Aura_Stack("PLAYER","灵魂残片","PLAYER|HELPFUL")==0 then ShowColor(mainbutton.icon, 6603,A_4);ShowSpell(debutton.icon,228477) return end
end

if PandaDB.FC_A4 ~= false  and Isuseable("灵魂裂劈",228477) then
if PowerMax("PAIN") - Power("PAIN")<=10 then ShowColor(mainbutton.icon, 6603,A_4);ShowSpell(debutton.icon,228477) return end
end

if PandaDB.FC_A8 ~= false  and Isuseable("献祭光环",178740) then 
if Power("PAIN")<=90 then ShowColor(mainbutton.icon, 6603,A_8);ShowSpell(debutton.icon,178740) return end
end

if PandaDB.FC_A9 ~= false  and Isuseable("邪能之刃",232893) then
if Power("PAIN")<=70 then ShowColor(mainbutton.icon, 6603,A_9);ShowSpell(debutton.icon,232893) return end
end

if PandaDB.FC_A5 ~= false  and Isuseable("破裂",263642) and SpellCharges("破裂")>=1 then 
if IsTalent("破裂") and Aura_Stack("PLAYER","灵魂残片","PLAYER|HELPFUL")<=3 then ShowColor(mainbutton.icon, 6603,A_5);ShowSpell(debutton.icon,263642) return end
end

if PandaDB.CcdSwitch ~= false  then
if PandaDB.FC_C2 ~= false  and Isuseable("邪能毁灭",212084) then ShowColor(mainbutton.icon, 6603,C_2);ShowSpell(debutton.icon,212084) return end
end

if PandaDB.FC_A3 ~= false  and Isuseable("烈焰咒符",204596) then ShowColor(mainbutton.icon, 6603,A_3);ShowSpell(debutton.icon,204596) return end


if PandaDB.FC_A5 ~= false  and Isuseable("裂魂",203782) and not IsTalent("破裂")  then ShowColor(mainbutton.icon, 6603,A_5);ShowSpell(debutton.icon,203782) return end

 
if PandaDB.FC_C1 ~= false  and Isuseable("投掷利刃",204157) then ShowColor(mainbutton.icon, 6603,C_1);ShowSpell(debutton.icon,204157) return end

	   
ShowColor(mainbutton.icon, 6603,162243);ShowSpell(debutton.icon, 311923)

--elseif not Authorization() then 
--print("|cffffe00a★Panda★:【|r|c00FF68CC 插件未激活 联系QQ:398371778 |r|cffffe00a】|r")
--end


end

end


local Demon_Hunter_Vengeance = Demon_Hunter_Vengeance
ns.Demon_Hunter_Vengeance = Demon_Hunter_Vengeance
