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
local function variable_blade_dance()
local a = 0
local value = false
if IsTalent("毁灭之痕") then a =1 end

if IsTalent("第一滴血") or active_enemies()> (3 - a) then
    value = true    
end
 return value
end

local function variable_waiting_for_nemesis()
local value= true
    if (not IsTalent("涅墨西斯") or SpellCooldown(206491)==0 or SpellCooldown(206491)>TTD() or SpellCooldown(206491)>60) then
        value = false 
	end
return value
end

local function variable_pooling_for_meta()
local value = false 
if not IsTalent("魔化") and SpellCooldown(191427)<6 and Power("FURY")>30 and (not variable_waiting_for_nemesis() or SpellCooldown(206491)<10) then
value = true
end
return value
end

local function variable_pooling_for_blade_dance()
local a = 0
local value = false
if IsTalent("第一滴血") then a =20 end
if variable_blade_dance() and (Power("FURY")< 75-a ) then
value =true
end
return value
end

local function variable_pooling_for_eye_beam()
local value = false 
if IsTalent("魔化") and not IsTalent("盲目之怒") and (SpellCooldown(198013)<(GCD_MAX()*2) or  PandaDB.HJ_A6 == false  ) and PowerMax("FURY") - Power("FURY")>60 then
value = true
end
return value
end

local function variable_waiting_for_dark_slash()
local value = false
if IsTalent("黑暗鞭笞") and not variable_pooling_for_blade_dance() and not variable_pooling_for_meta() and SpellCooldown(258860)>0 then
value = true
end
return value
end

local function variable_waiting_for_momentum()
local value = false 
if IsTalent("势如破竹") and Aura_time("PLAYER","势如破竹")==0 then
value = true
end
return value 
end






local function Demon_Hunter_Havoc()  --更新主图标及技能提示图标

local mainbutton = PDUI.mainbutton
local debutton = PDUI.debutton

if PlayerClass()=="DEMONHUNTER" and Specialization()=="浩劫"  then
--if Authorization() then

--开始循环
--自动拾取器

---------------------------------------------------------------------------
--[[                       浩劫                       ]]--
---------------------------------------------------------------------------

local desired_targets = 1
--最高优先级

if PandaDB.HJ_C1 ~= false  and Isuseable("投掷利刃",185123) then 
if UnitRange("TARGET")>15 and IsEnemy("TARGET") then ShowColor(mainbutton.icon, 6603,C_1);ShowSpell(debutton.icon,185123) return end
end

if PandaDB.HJ_A9 ~= false  and Isuseable("邪能之刃",232893) then
if UnitRange("TARGET")>15 and IsEnemy("TARGET") then ShowColor(mainbutton.icon, 6603,A_9);ShowSpell(debutton.icon,232893) return end
end



--战斗前

if not InCombatLockdown() then
if PandaDB.HJ_A8 ~= false  and Isuseable("献祭光环",258920) then ShowColor(mainbutton.icon, 6603,A_8);ShowSpell(debutton.icon,258920) return end

--强制开关
if PandaDB.CcdSwitch ~= false  then

if PandaDB.HJ_A1 ~= false  and Isuseable("恶魔变形",191427) and SpellCooldown(198013)> 8 then
if AzltE("混沌变身")==0 then ShowColor(mainbutton.icon, 6603,A_1);ShowSpell(debutton.icon,191427) return end
end

end

end


if PandaDB.HJ_A5 ~= false  and Isuseable("死亡横扫",210152) then
if SpellCooldown(191427)<3 then ShowColor(mainbutton.icon, 6603,A_5);ShowSpell(debutton.icon,210152) return end
end

--强制开关
if PandaDB.CcdSwitch ~= false  then
--艾泽拉斯之心精华

if PandaDB.HJ_A1 ~= false  and Isuseable("恶魔变形",191427) and SpellCooldown(198013)> 8 then
if not (IsTalent("魔化") or variable_pooling_for_meta() or variable_waiting_for_nemesis()) or TTD()<25 then ShowColor(mainbutton.icon, 6603,A_1);ShowSpell(debutton.icon,191427) return end
end

if PandaDB.HJ_A1 ~= false  and Isuseable("恶魔变形",191427)  and SpellCooldown(198013)> 8 then
if IsTalent("魔化") and (AzltE("混沌变身")==0 or (SpellCooldown(198013)>20 and (not variable_blade_dance() or SpellCooldown(188499)>GCD_MAX()))) then ShowColor(mainbutton.icon, 6603,A_1);ShowSpell(debutton.icon,191427) return end
end


if  PandaDB.HJ_A2 ~= false  and Isuseable("涅墨西斯",206491) then
if active_enemies()>1 and Aura_time("TARGET","涅墨西斯","PLAYER|HARMFUL")==0 then ShowColor(mainbutton.icon, 6603,A_2);ShowSpell(debutton.icon,206491) return end
end

if  PandaDB.HJ_A2 ~= false  and Isuseable("涅墨西斯",206491) then
if active_enemies()<=1 then ShowColor(mainbutton.icon, 6603,A_2);ShowSpell(debutton.icon,206491) return end
end

end


--actions+=/call_action_list,name=dark_slash
if IsTalent("黑暗鞭笞") and (variable_waiting_for_dark_slash() or Aura_time("TARGET","黑暗鞭笞","PLAYER|HARMFUL")>0 or SpellCooldown(258860)==0 ) then

if PandaDB.HJ_A3 ~= false  and Isuseable("黑暗鞭笞",258860) then
if Power("FURY")>=80 and (not variable_blade_dance() or SpellCooldown(188499)>0 ) then ShowColor(mainbutton.icon, 6603,A_3);ShowSpell(debutton.icon,258860) return end
end

if  PandaDB.HJ_A4 ~= false  and Isuseable("毁灭",201427) then
if Aura_time("TARGET","黑暗鞭笞","PLAYER|HARMFUL")>0 then ShowColor(mainbutton.icon, 6603,A_4);ShowSpell(debutton.icon,201427) return end
end

if PandaDB.HJ_A4 ~= false  and Isuseable("混乱打击",162794) then
if Aura_time("TARGET","黑暗鞭笞","PLAYER|HARMFUL")>0 then ShowColor(mainbutton.icon, 6603,A_4);ShowSpell(debutton.icon,162794) return end
end

end


--actions+=/run_action_list,name=demonic,if=talent.demonic.enabled
if IsTalent("魔化") then

if PandaDB.HJ_A5 ~= false  and Isuseable("死亡横扫",210152) then
if variable_blade_dance() then ShowColor(mainbutton.icon, 6603,A_5);ShowSpell(debutton.icon,210152) return end
end


if PandaDB.HJ_A6 ~= false  and Isuseable("眼棱",198013) and Useing_spell("player") ~= 198013 then ShowColor(mainbutton.icon, 6603,A_6);ShowSpell(debutton.icon,198013) return end
--强制开关
if PandaDB.CcdSwitch ~= false  then
if PandaDB.HJ_A7 ~= false  and Isuseable("邪能弹幕",258925) then 
if (SpellCooldown(198013)==0 or Aura_time("PLAYER","恶魔变形")>0) or active_enemies()>1 then ShowColor(mainbutton.icon, 6603,A_7);ShowSpell(debutton.icon,258925) return end
end

--essences
if PandaDB.HJ_C8 then
if Isuseable("仇敌之血","仇敌之血") then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.HJ_C8 then
if Isuseable("艾泽拉斯守护者","艾泽拉斯守护者") then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.HJ_C8 then
if Isuseable("不羁之力","不羁之力") then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.HJ_C8 then
if Isuseable("聚能艾泽里特射线","聚能艾泽里特射线") and Useing_spell("player") ~= 295258 then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.HJ_C8 then
if Isuseable("火红烈焰","火红烈焰") then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.HJ_C8 then
if Isuseable("净化冲击","净化冲击") then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.HJ_C8 then
if Isuseable("世界血脉共鸣","世界血脉共鸣") then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.HJ_C8 then
if Isuseable("空间涟漪","空间涟漪") then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.HJ_C8 then
if Isuseable("清醒梦境之忆","清醒梦境之忆") then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.HJ_C8 then
if Isuseable("收割火焰","收割火焰")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.HJ_C8 then
if Isuseable("生命缚誓者之祈","生命缚誓者之祈")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.HJ_C8 then
if Isuseable("救世之魂","救世之魂")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.HJ_C8 then
if Isuseable("守护屏障","守护屏障")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.HJ_C8 then
if Isuseable("补充能量","补充能量")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.HJ_C8 then
if Isuseable("静滞","静滞")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.HJ_C8 then
if Isuseable("法力过载","法力过载")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.HJ_C8 then
if Isuseable("活力导管","活力导管")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.HJ_C8 then
if Isuseable("爆燃之拥","爆燃之拥")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.HJ_C8 then
if Isuseable("光荣时刻","光荣时刻")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.HJ_C8 then
if Isuseable("深渊之护","深渊之护")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.HJ_C8 then
if Isuseable("艾泽拉斯的不朽赐福","艾泽拉斯的不朽赐福")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.HJ_C8 then
if Isuseable("强化虚无屏障","强化虚无屏障")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

end
-----------------------------

if PandaDB.HJ_A5 ~= false  and Isuseable("刃舞",188499) then
if variable_blade_dance() and (SpellCooldown(191427)>0 and SpellCooldown(198013)>(5-AzltE("旋转之刃")*3) or PandaDB.HJ_A6 == false  or  PandaDB.CcdSwitch == false  or  PandaDB.HJ_A1 == false ) then ShowColor(mainbutton.icon, 6603,A_5);ShowSpell(debutton.icon,188499) return end
end

if PandaDB.HJ_A8 ~= false  and Isuseable("献祭光环",258920) then ShowColor(mainbutton.icon, 6603,A_8);ShowSpell(debutton.icon,258920) return end

if PandaDB.HJ_A4 ~= false  and Isuseable("毁灭",201427) then
if not variable_pooling_for_blade_dance() then ShowColor(mainbutton.icon, 6603,A_4);ShowSpell(debutton.icon,201427) return end
end

if PandaDB.HJ_A9 ~= false  and Isuseable("邪能之刃",232893) then
if PowerMax("FURY") - Power("FURY")>=40 then ShowColor(mainbutton.icon, 6603,A_9);ShowSpell(debutton.icon,232893) return end
end

if PandaDB.HJ_A4 ~= false  and Isuseable("混乱打击",162794) then
if not variable_pooling_for_blade_dance() and not variable_pooling_for_eye_beam() then ShowColor(mainbutton.icon, 6603,A_4);ShowSpell(debutton.icon,162794) return end
end


if PandaDB.HJ_C1 ~= false  and Isuseable("投掷利刃",185123) then 
if IsTalent("恶魔之刃") then ShowColor(mainbutton.icon, 6603,C_1);ShowSpell(debutton.icon,185123) return end
end

if PandaDB.HJ_A0 ~= false  and Isuseable("恶魔之咬",162243) then ShowColor(mainbutton.icon, 6603,A_0);ShowSpell(debutton.icon,162243) return end


end


--actions+=/run_action_list,name=normal
--强制开关
if PandaDB.CcdSwitch ~= false  then

if PandaDB.HJ_A7 ~= false and Isuseable("邪能弹幕",258925) then 
if not variable_waiting_for_momentum() and (active_enemies()>1 or TTD()>30) then ShowColor(mainbutton.icon, 6603,A_7);ShowSpell(debutton.icon,258925) return end
end

end

if PandaDB.HJ_A5 ~= false  and Isuseable("死亡横扫",210152) then
if variable_blade_dance() then ShowColor(mainbutton.icon, 6603,A_5);ShowSpell(debutton.icon,210152) return end
end

if PandaDB.HJ_A8 ~= false  and Isuseable("献祭光环",258920) then ShowColor(mainbutton.icon, 6603,A_8);ShowSpell(debutton.icon,258920) return end



if  PandaDB.HJ_A6 ~= false  and Isuseable("眼棱",198013) and Useing_spell("player") ~= 198013 then 
if active_enemies()>1 and not variable_waiting_for_momentum() then ShowColor(mainbutton.icon, 6603,A_6);ShowSpell(debutton.icon,198013) return end
end



if  PandaDB.HJ_A5 ~= false  and Isuseable("刃舞",188499) then
if variable_blade_dance() then ShowColor(mainbutton.icon, 6603,A_5);ShowSpell(debutton.icon,188499) return end
end

if PandaDB.HJ_A9 ~= false  and Isuseable("邪能之刃",232893) then
if PowerMax("FURY") - Power("FURY")>=40 then ShowColor(mainbutton.icon, 6603,A_9);ShowSpell(debutton.icon,232893) return end
end



if PandaDB.HJ_A6 ~= false  and Isuseable("眼棱",198013) and Useing_spell("player") ~= 198013 then 
if not IsTalent("盲目之怒") and not variable_waiting_for_dark_slash() then ShowColor(mainbutton.icon, 6603,A_6);ShowSpell(debutton.icon,198013) return end
end



if PandaDB.HJ_A4 ~= false  and Isuseable("毁灭",201427) then
if (IsTalent("恶魔之刃") or not variable_waiting_for_momentum() or PowerMax("FURY") - Power("FURY")<30 or Aura_time("PLAYER","恶魔变形")<5) and not variable_pooling_for_blade_dance() and not variable_waiting_for_dark_slash() then ShowColor(mainbutton.icon, 6603,A_4);ShowSpell(debutton.icon,201427) return end
end

if PandaDB.HJ_A4 ~= false  and Isuseable("混乱打击",162794) then
if (IsTalent("恶魔之刃") or not variable_waiting_for_momentum() or PowerMax("FURY") - Power("FURY")<30) and not variable_pooling_for_meta() and not variable_pooling_for_blade_dance() and not variable_waiting_for_dark_slash() then ShowColor(mainbutton.icon, 6603,A_4);ShowSpell(debutton.icon,162794) return end
end



if  PandaDB.HJ_A6 ~= false  and Isuseable("眼棱",198013) and Useing_spell("player") ~= 198013 then 
if IsTalent("盲目之怒") then ShowColor(mainbutton.icon, 6603,A_6);ShowSpell(debutton.icon,198013) return end
end


if PandaDB.HJ_C1 ~= false  and Isuseable("投掷利刃",185123) then 
if IsTalent("恶魔之刃") then ShowColor(mainbutton.icon, 6603,C_1);ShowSpell(debutton.icon,185123) return end
end

if PandaDB.HJ_A9 ~= false  and Isuseable("邪能之刃",232893) then
if UnitRange("TARGET")>15 and IsEnemy("TARGET") then ShowColor(mainbutton.icon, 6603,A_9);ShowSpell(debutton.icon,232893) return end
end

if PandaDB.HJ_A0 ~= false and Isuseable("恶魔之咬",162243) then ShowColor(mainbutton.icon, 6603,A_0);ShowSpell(debutton.icon,162243) return end


   
	   
ShowColor(mainbutton.icon, 6603,6603);ShowSpell(debutton.icon, 311923)

--elseif not Authorization() then 
--print("|cffffe00a★Panda★:【|r|c00FF68CC 插件未激活 联系QQ:398371778 |r|cffffe00a】|r")
--end


end

end


local Demon_Hunter_Havoc = Demon_Hunter_Havoc
ns.Demon_Hunter_Havoc = Demon_Hunter_Havoc
