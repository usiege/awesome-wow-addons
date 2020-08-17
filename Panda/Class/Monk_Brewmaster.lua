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

local function Monk_Brewmaster()  --更新主图标及技能提示图标

local mainbutton = PDUI.mainbutton
local debutton = PDUI.debutton

if PlayerClass()=="MONK" and Specialization()=="酒仙" then
--if Authorization() then
---simc变量声明

--开始循环

---------------------------------------------------------------------------
--[[                      酒仙僧                       ]]--
---------------------------------------------------------------------------

local Stagger = UnitStagger("player")


--战斗前
if not InCombatLockdown() then
if PandaDB.JX_A8 ~= false  and Isuseable("真气爆裂",123986) and Useing_spell("player") ~= 123986 then ShowColor(mainbutton.icon, 6603,A_8);ShowSpell(debutton.icon, 123986)   return end
if PandaDB.JX_A7 ~= false  and Isuseable("真气波",115098) then ShowColor(mainbutton.icon, 6603,A_7);ShowSpell(debutton.icon, 115098)  return end
end


--减伤组
if PandaDB.CcdSwitch ~= false  then
if PandaDB.JX_A5 ~= false  and Isuseable("金创药",122281) then
if ( ( SpellCharges(122281)==2 and HealthPercent("PLAYER")<=70 ) or HealthPercent("PLAYER")<=50 )then ShowColor(mainbutton.icon, 6603,A_5);ShowSpell(debutton.icon, 122281)   return end
end

if PandaDB.JX_A4 ~= false  and Isuseable("移花接木",115072) then
if HealthPercent("PLAYER")<=50 then ShowColor(mainbutton.icon, 6603,A_4);ShowSpell(debutton.icon, 115072)   return end
end

if PandaDB.JX_A0 ~= false  and Isuseable("铁骨酒",115308) then
if (( ( Aura_time("PLAYER","铁骨酒")==0 or SpellallCharges(115308)>=2.8 or ( IsTalent("玄牛酒") and SpellCooldown(115399)==0)) or ( Aura_time("PLAYER","幻灭连击")>0 and  Stagger >= HealthMax("PLAYER")*0.5 and SpellallCharges(115308)>=2)) and Aura_time("PLAYER","铁骨酒")<=16 ) then ShowColor(mainbutton.icon, 6603,A_0);ShowSpell(debutton.icon, 115308)   return end
end

if PandaDB.JX_C1 ~= false  and Isuseable("活血酒",119582) then
if Aura_count("player","重度醉拳","PLAYER|HARMFUL")>0 and Stagger >= HealthCurrent("PLAYER")*1.5 then ShowColor(mainbutton.icon, 6603,C_1);ShowSpell(debutton.icon, 119582) return end
end

if PandaDB.JX_C2 ~= false  and Isuseable("玄牛酒",115399) then
if ( SpellCharges(115308)<0.5 or ((Power("ENERGY")+(select( 2, GetPowerRegen() )*SpellCooldown(121253)))<40 and Aura_time("PLAYER","幻灭连击")==0 and SpellCooldown(121253)>0 )) then ShowColor(mainbutton.icon, 6603,C_2);ShowSpell(debutton.icon, 115399) return end
end

end

if PandaDB.JX_A9 ~= false  and Isuseable("碧玉疾风",116847) then
if Aura_time("PLAYER","碧玉疾风")<1 then ShowColor(mainbutton.icon, 6603,A_9);ShowSpell(debutton.icon, 116847) return end
end

--特殊处理
if Teshuchuli() then
if PandaDB.JX_A6 ~= false  and Isuseable("幻灭猛击",205523) then ShowColor(mainbutton.icon, 6603,A_6);ShowSpell(debutton.icon, 205523) return end
if PandaDB.JX_A2 ~= false  and Isuseable("猛虎掌",100780) then ShowColor(mainbutton.icon, 6603,A_2);ShowSpell(debutton.icon, 100780) return end
end

if PandaDB.CcdSwitch ~= false  then
--艾泽拉斯之心精华
--essences
if PandaDB.JX_C8 then
if Isuseable("仇敌之血","仇敌之血") then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.JX_C8 then
if Isuseable("艾泽拉斯守护者","艾泽拉斯守护者") then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.JX_C8 then
if Isuseable("不羁之力","不羁之力") then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.JX_C8 then
if Isuseable("聚能艾泽里特射线","聚能艾泽里特射线") and Useing_spell("player") ~= 295258 then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.JX_C8 then
if Isuseable("火红烈焰","火红烈焰") then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.JX_C8 then
if Isuseable("净化冲击","净化冲击") then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.JX_C8 then
if Isuseable("世界血脉共鸣","世界血脉共鸣") then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.JX_C8 then
if Isuseable("空间涟漪","空间涟漪") then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.JX_C8 then
if Isuseable("清醒梦境之忆","清醒梦境之忆") then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.JX_C8 then
if Isuseable("收割火焰","收割火焰")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.JX_C8 then
if Isuseable("生命缚誓者之祈","生命缚誓者之祈")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.JX_C8 then
if Isuseable("救世之魂","救世之魂")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.JX_C8 then
if Isuseable("守护屏障","守护屏障")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.JX_C8 then
if Isuseable("补充能量","补充能量")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.JX_C8 then
if Isuseable("静滞","静滞")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.JX_C8 then
if Isuseable("法力过载","法力过载")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.JX_C8 then
if Isuseable("活力导管","活力导管")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.JX_C8 then
if Isuseable("爆燃之拥","爆燃之拥")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.JX_C8 then
if Isuseable("光荣时刻","光荣时刻")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.JX_C8 then
if Isuseable("深渊之护","深渊之护")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.JX_C8 then
if Isuseable("艾泽拉斯的不朽赐福","艾泽拉斯的不朽赐福")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.JX_C8 then
if Isuseable("强化虚无屏障","强化虚无屏障")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

end

--攻击组
if PandaDB.JX_A1 ~= false  and Isuseable("醉酿投",121253) then
if active_enemies()>=2 then ShowColor(mainbutton.icon, 6603,A_1);ShowSpell(debutton.icon, 121253) return end
end

if PandaDB.JX_A2 ~= false  and Isuseable("猛虎掌",100780) then
if ( (IsTalent("碧玉疾风") and Aura_time("PLAYER","幻灭连击")>0 and Aura_time("PLAYER","碧玉疾风")>0 ) or ((IsTalent("玄牛砮皂")  or IsTalent("特别快递")) and Aura_time("PLAYER","幻灭连击")>0)) then ShowColor(mainbutton.icon, 6603,A_2);ShowSpell(debutton.icon, 100780) return end
end

if PandaDB.JX_A6 ~= false  and Isuseable("幻灭猛击",205523) then ShowColor(mainbutton.icon, 6603,A_6);ShowSpell(debutton.icon, 205523) return end

if PandaDB.JX_A1 ~= false  and Isuseable("醉酿投",121253) then ShowColor(mainbutton.icon, 6603,A_1);ShowSpell(debutton.icon, 121253) return end

if PandaDB.JX_A9 ~= false  and Isuseable("碧玉疾风",116847) then
if ( Aura_time("PLAYER","碧玉疾风")==0 ) then ShowColor(mainbutton.icon, 6603,A_9);ShowSpell(debutton.icon, 116847) return end
end

if PandaDB.JX_A3 ~= false  and Isuseable("火焰之息",115181) then
if ( Aura_time("PLAYER","幻灭连击")==0 ) then ShowColor(mainbutton.icon, 6603,A_3);ShowSpell(debutton.icon, 115181) return end
end

if PandaDB.JX_A8 ~= false  and Isuseable("真气爆裂",123986) and Useing_spell("player") ~= 123986 then ShowColor(mainbutton.icon, 6603,A_8);ShowSpell(debutton.icon, 123986)   return end

if PandaDB.JX_A2 ~= false  and Isuseable("猛虎掌",100780) then
if ( not IsTalent("幻灭连击") and SpellCooldown(121253)>GCD_MAX() and (Power("ENERGY")+(select( 2, GetPowerRegen() )*( SpellCooldown(121253)+GCD_MAX())))>=65) or ( (PowerMax("ENERGY")-Power("ENERGY"))/select( 2, GetPowerRegen() )<1 ) then ShowColor(mainbutton.icon, 6603,A_2);ShowSpell(debutton.icon, 100780) return end
end

if PandaDB.JX_A1 ~= false  and useable("醉酿投") then ShowColor(mainbutton.icon, 6603,A_1);ShowSpell(debutton.icon, 121253) return end

if PandaDB.JX_A9 ~= false  and Isuseable("碧玉疾风",116847)  then ShowColor(mainbutton.icon, 6603,A_9);ShowSpell(debutton.icon, 116847) return end


ShowColor(mainbutton.icon, 6603,108967);ShowSpell(debutton.icon, 311923)	   
   


--elseif not Authorization() then 
--print("|cffffe00a★Panda★:【|r|c00FF68CC 插件未激活 联系QQ:398371778 |r|cffffe00a】|r")

--end  
	   

end


end




local Monk_Brewmaster = Monk_Brewmaster
ns.Monk_Brewmaster = Monk_Brewmaster

