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


local function Monk_Windwalker()  --更新主图标及技能提示图标

local mainbutton = PDUI.mainbutton
local debutton = PDUI.debutton


if PlayerClass()=="MONK" and Specialization()=="踏风" then
--if Authorization() then
---simc变量声明

--开始循环

---------------------------------------------------------------------------
--[[                       踏风僧                       ]]--
---------------------------------------------------------------------------

--最高优先级
if PandaDB.TAF_A4 ~= false  and Isuseable("反向伤害",287771) and HealthPercent("PLAYER")<92 then ShowColor(mainbutton.icon, 6603,A_4);ShowSpell(debutton.icon, 287771)  return end

if PandaDB.TAF_C1 ~= false  and Isuseable("神鹤引项踢",101546) then
if ( Prev_Spell(1)~=101546 and Aura_time("PLAYER","赤精之舞")>0 ) then ShowColor(mainbutton.icon, 6603,C_1);ShowSpell(debutton.icon, 101546)  return end
end

if PandaDB.TAF_A3 ~= false  and Isuseable("怒雷破",113656) and Useing_spell("player") ~= 113656 then
if UnitIsPlayer("target") and UnitCanAttack( 'player',"target") then ShowColor(mainbutton.icon, 6603,A_3);ShowSpell(debutton.icon, 113656) return end
end

if PandaDB.TAF_A6 ~= false  and Isuseable("幻灭踢",100784) then
if ( Power("CHI")>2 and not useable("旭日东升踢") ) then  ShowColor(mainbutton.icon, 6603,A_6);ShowSpell(debutton.icon, 100784)return end
end

if PandaDB.TAF_A7 ~= false  and Isuseable("真气波",115098) then
if  ( Prev_Spell(1)==100780 and Power("CHI")<2 )then ShowColor(mainbutton.icon, 6603,A_7);ShowSpell(debutton.icon, 115098) return end
end

if PandaDB.TAF_A6 ~= false  and Isuseable("幻灭踢",100784) then
if ( Prev_Spell(1)==100780 and Power("CHI")<2 ) then  ShowColor(mainbutton.icon, 6603,A_6);ShowSpell(debutton.icon, 100784) return end
end

if PandaDB.TAF_A2 ~= false  and Isuseable("猛虎掌",100780) then
if ( Prev_Spell(1)==100780 and not Isuseable("幻灭踢",100784) ) then ShowColor(mainbutton.icon, 6603,A_2);ShowSpell(debutton.icon, 100780)   return end
end

--战斗前
if not InCombatLockdown() then
if PandaDB.TAF_A8 ~= false  and Isuseable("真气爆裂",123986) and Useing_spell("player") ~= 123986 then
if ( ( not IsTalent("屏气凝神") or  not IsTalent("白虎拳")) ) then ShowColor(mainbutton.icon, 6603,A_8);ShowSpell(debutton.icon, 123986)   return end
end

if PandaDB.TAF_A7 ~= false  and Isuseable("真气波",115098)  then ShowColor(mainbutton.icon, 6603,A_7);ShowSpell(debutton.icon, 115098)  return end
end


--屏气凝神
if Aura_time("PLAYER","屏气凝神")>0 then
if PandaDB.TAF_A1 ~= false  and Isuseable("旭日东升踢",107428) then
if ( ( active_enemies()<3 or Prev_Spell(1)==101546 ) ) then ShowColor(mainbutton.icon, 6603,A_1);ShowSpell(debutton.icon,107428) return end
end

if PandaDB.TAF_A3 ~= false  and Isuseable("怒雷破",113656) and Useing_spell("player") ~= 113656 then ShowColor(mainbutton.icon, 6603,A_3);ShowSpell(debutton.icon,113656) return end

if PandaDB.TAF_C1 ~= false  and Isuseable("神鹤引项踢",101546) then
if ( Prev_Spell(1)~=101546 and (active_enemies()>=3 or (active_enemies()==2 and Prev_Spell(1)==100784)) ) then ShowColor(mainbutton.icon, 6603,C_1);ShowSpell(debutton.icon,101546) return end
end

if PandaDB.TAF_A6 ~= false  and Isuseable("幻灭踢",100784) then  ShowColor(mainbutton.icon, 6603,A_6);ShowSpell(debutton.icon,100784) return end
end

if PandaDB.TAF_A0 ~= false  and Isuseable("白虎拳",261947)  then
if ( ((PowerMax("ENERGY")-Power("ENERGY"))/select( 2, GetPowerRegen() )<2 or (IsTalent("屏气凝神") and SpellCooldown(152173)<2)) and PowerMax("CHI")-Power("CHI")>=3 ) then ShowColor(mainbutton.icon, 6603,A_0);ShowSpell(debutton.icon,261947) return end
end

if PandaDB.TAF_A2 ~= false  and Isuseable("猛虎掌",100780) then
if ( ((PowerMax("ENERGY")-Power("ENERGY"))/select( 2, GetPowerRegen() )<2 or (IsTalent("屏气凝神") and SpellCooldown(152173)<2)) and PowerMax("CHI")-Power("CHI")>=2 and Prev_Spell(1)~=100780 ) then ShowColor(mainbutton.icon, 6603,A_2);ShowSpell(debutton.icon, 100780) return end
end


--自定义特殊处理组
if Teshuchuli() then

if PandaDB.TAF_A1 ~= false  and Isuseable("旭日东升踢",107428) then ShowColor(mainbutton.icon, 6603,A_1);ShowSpell(debutton.icon,107428) return end

if PandaDB.TAF_A6 ~= false  and Isuseable("幻灭踢",100784) then
if (Aura_time("PLAYER","屏气凝神")>0 or Prev_Spell(1)~=100784)then  ShowColor(mainbutton.icon, 6603,A_6);ShowSpell(debutton.icon, 100784) return end
end

if PandaDB.TAF_A7 ~= false  and Isuseable("真气波",115098)  then ShowColor(mainbutton.icon, 6603,A_7);ShowSpell(debutton.icon, 115098) return end

if PandaDB.TAF_A0 ~= false  and Isuseable("白虎拳",261947)  then
if ( Power("CHI")<=2 ) then ShowColor(mainbutton.icon, 6603,A_0);ShowSpell(debutton.icon, 261947) return end
end

if PandaDB.TAF_A2 ~= false  and Isuseable("猛虎掌",100780) then
if ( Prev_Spell(1)~=100780 and PowerMax("CHI")-Power("CHI")>=2 ) then ShowColor(mainbutton.icon, 6603,A_2);ShowSpell(debutton.icon, 100780)  return end
end
end

--大招

if PandaDB.CcdSwitch ~= false  then


--艾泽拉斯之心精华
--essences

if PandaDB.TAF_C8 then
if Isuseable("艾泽拉斯守护者","艾泽拉斯守护者") then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.TAF_C8 then
if Isuseable("不羁之力","不羁之力") then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.TAF_C8 then
if Isuseable("聚能艾泽里特射线","聚能艾泽里特射线") and Useing_spell("player") ~= 295258 and Aura_time("PLAYER","风火雷电")==0 and Aura_time("PLAYER","屏气凝神")==0 then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, "聚能艾泽里特射线") return end
end

if PandaDB.TAF_C8 then
if Isuseable("火红烈焰","火红烈焰") then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.TAF_C8 then
if Isuseable("净化冲击","净化冲击") then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.TAF_C8 then
if Isuseable("世界血脉共鸣","世界血脉共鸣") then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.TAF_C8 then
if Isuseable("空间涟漪","空间涟漪") then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.TAF_C8 then
if Isuseable("清醒梦境之忆","清醒梦境之忆") then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end


if PandaDB.TAF_C8 then
if Isuseable("生命缚誓者之祈","生命缚誓者之祈")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.TAF_C8 then
if Isuseable("救世之魂","救世之魂")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.TAF_C8 then
if Isuseable("守护屏障","守护屏障")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.TAF_C8 then
if Isuseable("补充能量","补充能量")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.TAF_C8 then
if Isuseable("静滞","静滞")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.TAF_C8 then
if Isuseable("法力过载","法力过载")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.TAF_C8 then
if Isuseable("活力导管","活力导管")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.TAF_C8 then
if Isuseable("爆燃之拥","爆燃之拥")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.TAF_C8 then
if Isuseable("光荣时刻","光荣时刻")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.TAF_C8 then
if Isuseable("深渊之护","深渊之护")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.TAF_C8 then
if Isuseable("艾泽拉斯的不朽赐福","艾泽拉斯的不朽赐福")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.TAF_C8 then
if Isuseable("强化虚无屏障","强化虚无屏障")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end
-------------------------


if PandaDB.TAF_C4 ~= false  and Isuseable("白虎下凡",123904)  then ShowColor(mainbutton.icon, 6603,C_4);ShowSpell(debutton.icon,123904) return end

if PandaDB.TAF_C5 ~= false  and Isuseable("轮回之触",115080)  then
if ( not UnitExists("TARGET") or ( TTD()>9 and HealthCurrent("target") >= HealthMax("PLAYER")/2 )) then ShowColor(mainbutton.icon, 6603,C_5);ShowSpell(debutton.icon,115080) return end
end

if PandaDB.TAF_C8 then
if Isuseable("仇敌之血","仇敌之血") then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.TAF_C8 then
if Isuseable("收割火焰","收割火焰")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.TAF_C6 ~= false  and Isuseable("风火雷电",137639) then
if not IsTalent("屏气凝神") and Aura_time("PLAYER","风火雷电")==0 and ( SpellCharges(137639)==2 or (SpellCooldown(113656)<=8 and Power("CHI")>=3 and SpellCooldown(107428)<=3) ) then ShowColor(mainbutton.icon, 6603,C_6);ShowSpell(debutton.icon,137639) return end
end

if PandaDB.TAF_C6 ~= false  and Isuseable("屏气凝神",152173) then
if IsTalent("屏气凝神") and Aura_time("PLAYER","屏气凝神")==0 and ( SpellCooldown(107428)<=2 ) then ShowColor(mainbutton.icon, 6603,C_6);ShowSpell(debutton.icon,152173) return end
end

end





--ST
if active_enemies()<3 then
if PandaDB.TAF_A5 ~= false  and Isuseable("升龙霸",152175) then  ShowColor(mainbutton.icon, 6603,A_5);ShowSpell(debutton.icon, 152175) return end

if PandaDB.TAF_A1 ~= false  and Isuseable("旭日东升踢",107428) then
if (Power("CHI")>=5) then  ShowColor(mainbutton.icon, 6603,A_1);ShowSpell(debutton.icon,107428) return end
end

if PandaDB.TAF_A3 ~= false  and Isuseable("怒雷破",113656) and Useing_spell("player") ~= 113656 then ShowColor(mainbutton.icon, 6603,A_3);ShowSpell(debutton.icon, 113656) return end
--自定义旭日东升踢（防止延迟怒雷）

if PandaDB.TAF_A1 ~= false  and Isuseable("旭日东升踢",107428) then
if SpellCooldown(113656)>2 then  ShowColor(mainbutton.icon, 6603,A_1);ShowSpell(debutton.icon,107428) return end
end

if PandaDB.TAF_C1 ~= false  and Isuseable("神鹤引项踢",101546) then
if ( Prev_Spell(1)~=101546 and Aura_time("PLAYER","赤精之舞")>0 ) then ShowColor(mainbutton.icon, 6603,C_1);ShowSpell(debutton.icon, 101546)  return end
end

if PandaDB.TAF_A9 ~= false  and Isuseable("碧玉疾风",116847) then
if ( Aura_time("PLAYER","碧玉疾风")==0 and active_enemies()>1 ) then ShowColor(mainbutton.icon, 6603,A_9);ShowSpell(debutton.icon, 116847)  return end
end

if PandaDB.TAF_A0 ~= false  and Isuseable("白虎拳",261947) then
if ( Power("CHI")<=2 ) then ShowColor(mainbutton.icon, 6603,A_0);ShowSpell(debutton.icon, 261947)  return end
end

if PandaDB.TAF_C2 ~= false  and Isuseable("豪能酒",115288) then
if ( Power("CHI")<=3 and Power("ENERGY")<50 ) then ShowColor(mainbutton.icon, 6603,C_2);ShowSpell(debutton.icon, 115288) return end
end

--自定义幻灭踢（防止延迟怒雷）
if PandaDB.TAF_A6 ~= false  and Isuseable("幻灭踢",100784) then
if Prev_Spell(1)==100780 and (SpellCooldown(107428) == 0 and SpellCooldown(113656)<=2 and Power("CHI") == 2 )then  ShowColor(mainbutton.icon, 6603,A_6);ShowSpell(debutton.icon, 100784) return end
end

if PandaDB.TAF_A6 ~= false  and Isuseable("幻灭踢",100784) then
if ( Prev_Spell(1)~=100784 and (SpellCooldown(107428)>3 or Power("CHI")>=3) and (SpellCooldown(113656)>4 or Power("CHI")>=4 or (Power("CHI")==2 and Prev_Spell(1)==100780)) and Aura_Stack("PLAYER","神龙摆尾")<2 ) then  ShowColor(mainbutton.icon, 6603,A_6);ShowSpell(debutton.icon, 100784) return end
end

if PandaDB.TAF_A7 ~= false  and Isuseable("真气波",115098) then ShowColor(mainbutton.icon, 6603,A_7);ShowSpell(debutton.icon, 115098) return end

if PandaDB.TAF_A8 ~= false  and Isuseable("真气爆裂",123986) and Useing_spell("player") ~= 123986 then
if ( PowerMax("CHI")-Power("CHI")>=1 and active_enemies()==1 or PowerMax("CHI")-Power("CHI")>=2 ) then ShowColor(mainbutton.icon, 6603,A_8);ShowSpell(debutton.icon, 123986)  return end
end

if PandaDB.TAF_A2 ~= false  and Isuseable("猛虎掌",100780) then
if ( Prev_Spell(1)~=100780 and PowerMax("CHI")-Power("CHI")>=2 ) then ShowColor(mainbutton.icon, 6603,A_2);ShowSpell(debutton.icon, 100780) return end
end

--AOE
elseif active_enemies()>=3 then
if PandaDB.TAF_A1 ~= false  and Isuseable("旭日东升踢",107428) then
if ((IsTalent("升龙霸") and SpellCooldown(152175)<5) and SpellCooldown(113656)>3) then  ShowColor(mainbutton.icon, 6603,A_1);ShowSpell(debutton.icon,107428) return end
end

if PandaDB.TAF_A5 ~= false  and Isuseable("升龙霸",152175) then  ShowColor(mainbutton.icon, 6603,A_5);ShowSpell(debutton.icon, 152175) return end

if PandaDB.TAF_C2 ~= false  and Isuseable("豪能酒",115288) then
if ( Prev_Spell(1)~=100780 and Power("CHI")<=1 and Power("ENERGY")<50 ) then ShowColor(mainbutton.icon, 6603,C_2);ShowSpell(debutton.icon, 115288) return end
end

if PandaDB.TAF_A3 ~= false  and Isuseable("怒雷破",113656) and Useing_spell("player") ~= 113656 then  ShowColor(mainbutton.icon, 6603,A_3);ShowSpell(debutton.icon, 113656)  return end

if PandaDB.TAF_C1 ~= false  and Isuseable("神鹤引项踢",101546) then
if ( Prev_Spell(1)~=101546 and Aura_time("PLAYER","赤精之舞")>0 ) then ShowColor(mainbutton.icon, 6603,C_1);ShowSpell(debutton.icon, 101546)  return end
end

if PandaDB.TAF_A9 ~= false  and Isuseable("碧玉疾风",116847) then
if ( Aura_time("PLAYER","碧玉疾风")==0 ) then ShowColor(mainbutton.icon, 6603,A_9);ShowSpell(debutton.icon, 116847) return end
end

if PandaDB.TAF_C1 ~= false  and Isuseable("神鹤引项踢",101546) then
if ( Prev_Spell(1)~=101546 and (((Power("CHI")>3 or SpellCooldown(113656)>6) and (Power("CHI")>=5 or SpellCooldown(113656)>2)) or (PowerMax("ENERGY")-Power("ENERGY"))/select( 2, GetPowerRegen() )<=3) ) then ShowColor(mainbutton.icon, 6603,C_1);ShowSpell(debutton.icon, 101546) return end
end

if PandaDB.TAF_A8 ~= false  and Isuseable("真气爆裂",123986) and Useing_spell("player") ~= 123986 then
if ( Power("CHI")<=3 ) then ShowColor(mainbutton.icon, 6603,A_8);ShowSpell(debutton.icon, 123986)  return end
end

if PandaDB.TAF_A0 ~= false  and Isuseable("白虎拳",261947)  then
if (PowerMax("CHI")-Power("CHI")>=3 ) then ShowColor(mainbutton.icon, 6603,A_0);ShowSpell(debutton.icon, 261947) return end
end

if PandaDB.TAF_A2 ~= false  and Isuseable("猛虎掌",100780) then
if ( PowerMax("CHI")-Power("CHI")>=2 and ( not IsTalent("连击") or  Prev_Spell(1)~=100780) ) then ShowColor(mainbutton.icon, 6603,A_2);ShowSpell(debutton.icon, 100780) return end
end

if PandaDB.TAF_A7 ~= false  and Isuseable("真气波",115098)  then ShowColor(mainbutton.icon, 6603,A_7);ShowSpell(debutton.icon, 115098) return end


if PandaDB.TAF_A6 ~= false  and Isuseable("幻灭踢",100784) then
if Prev_Spell(1)~=100784 and ( (Aura_time("PLAYER","幻灭踢！")>0 or ( IsTalent("连击") and Prev_Spell(1)==100780 and Power("CHI")<4))) then  ShowColor(mainbutton.icon, 6603,A_6) ;ShowSpell(debutton.icon, 100784)return end
end
end

--能量不足显示
if PandaDB.TAF_A2 ~= false  and Power("CHI")<3 and ( not IsTalent("连击") or  Prev_Spell(1)~=100780 ) then ShowColor(mainbutton.icon, 6603,A_2);ShowSpell(debutton.icon, 100780) return end
if PandaDB.TAF_A2 ~= false  and (PowerMax("ENERGY")-Power("ENERGY"))/select( 2, GetPowerRegen() )<1 and ( not IsTalent("连击") or Prev_Spell(1)~=100780 ) then ShowColor(mainbutton.icon, 6603,A_2);ShowSpell(debutton.icon, 100780) return end

	   
ShowColor(mainbutton.icon, 6603,108967);ShowSpell(debutton.icon, 311923)	   
   


--elseif not Authorization() then 
--print("|cffffe00a★Panda★:【|r|c00FF68CC 插件未激活 联系QQ:398371778 |r|cffffe00a】|r")
--end


end

end


local Monk_Windwalker = Monk_Windwalker
ns.Monk_Windwalker = Monk_Windwalker

