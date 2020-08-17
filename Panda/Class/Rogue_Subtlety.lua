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

local function Stealth()--潜行状态
      local A = Aura_count("PLAYER","潜行")
      local B = Aura_count("PLAYER","影遁")
      local C = Aura_count("PLAYER","消失")
	  local D = Aura_count("PLAYER","暗影之舞")
	  local E = Aura_time("target","暗影决斗","PLAYER|HARMFUL")
	  local F = Aura_count("PLAYER","潜伏帷幕")
	  local G = Aura_time("PLAYER","诡诈")
	  local n = false
	  if A>0 or B>0 or C>0 or D>0 or E>0 or F>0 or G>=1 then n = true else n = false end
	  return n
end
local function poisoned_bleeds()--流血目标数

    local B = Rang_enemies_Aura(20,"锁喉","致命药膏")
    local C = Rang_enemies_Aura(20,"割裂","致命药膏")
  
    return B+C
end

local function DYS()--回能计算
    local bleeds = poisoned_bleeds()
	local haste = GetHaste()
    local A= select( 2, GetPowerRegen())
    local B= bleeds*7/(2*haste)
    return A+B
    
end

local function DS()
    local A = 0 
    if IsTalent("深邃诡计") then 
        
        A=1      
    else
        
        A=0
    end
    return A
end  


 
 --敏锐
local function AYZW()--暗影之舞
    local A=0
	local talent = IsTalent("诡诈")
    if talent then A=1 else A=0 end
    return A
end

local function YFS()--影分身
    local A=0
    local B=0
    local talent_1 = IsTalent("黑暗之影")
	local talent_2 = IsTalent("夜行者")
    if talent_1 then A=1 else A=0 end 
    if talent_2 then B=1 else B=0 end
    
	local C=A+B
    return C
end

local function nightblade_refreshable()--夜刃可刷新公式
      local n = Aura_time("target","夜刃","PLAYER|HARMFUL")
	  local COMBO_POINTS = Power("COMBO_POINTS")
	  if ( n < (6+2*COMBO_POINTS)*0.3 ) and ( GetUnitName("TARGET") ~= "爆炸物"  and GetUnitName("TARGET") ~= "被折磨的幽魂" and GetUnitName("TARGET") ~= "失落的灵魂" and GetUnitName("TARGET") ~= "复生之魂" and  UnitCreatureType("target") ~="图腾" and TTD()>5 and HealthCurrent("target")>40000)then return true else return false end
end	

local function variable_stealth_threshold()
    local A=0
    local B=0
    local C=0
    local D=0
    local E=0
	local talent_1 = IsTalent("精力")
	local talent_2 = IsTalent("暗影大师")
	local talent_3 = IsTalent("暗影集中")
	local talent_4 = IsTalent("敏锐")
	local ems = active_enemies()
	
    if talent_1 then A=35 else A=0 end
    if talent_2 then B=25 else B=0 end
    if talent_3 then C=20 else C=0 end
    if talent_4 then D=10 else D=0 end 
    if ems >=3 then E=15 else E=0 end
    
	local X=25+A+B+C+D+E
    return X
end

local function STE()
    local A=0 
    local talent_1 = IsTalent("深邃诡计")
	local talent_2 = IsTalent("黑暗之影")
	local talent_3 = IsTalent("诡诈")
	local talent_4 = IsTalent("敏锐")
	local aura_1 = Aura_time("PLAYER","消失")
	local TZ_DYZW = AzltE("第一支舞")
	local ems = active_enemies()
	
    if ( talent_1 and (aura_1>0 or TZ_DYZW >0 and  not talent_2 and  not talent_3 and ems <3)) then A=1 else A=0 end 
    
	return A
end

local function YR()--夜刃
    local A=0
	local t = 10
	if time_x(t) then A=2  else A=0 end
    
	return A
end

local function variable_use_priority_rotation()
local priority_rotation = nil
if priority_rotation and active_enemies()>=2 then return true else return false end
end

local function variable_shd_combo_points()
local A = (PowerMax("COMBO_POINTS")-Power("COMBO_POINTS"))>=4
if AzltE("第一支舞")>0 then 
local B = (PowerMax("COMBO_POINTS")-Power("COMBO_POINTS"))<=1+2 and variable_use_priority_rotation() and (IsTalent("夜行者") or IsTalent("黑暗之影"))
else 
local B = (PowerMax("COMBO_POINTS")-Power("COMBO_POINTS"))<=1 and variable_use_priority_rotation() and (IsTalent("夜行者") or IsTalent("黑暗之影"))
end
if A==true or B==true then
return true else return false
end
end


local function Rogue_Subtlety()  --更新主图标及技能提示图标

local mainbutton = PDUI.mainbutton
local debutton = PDUI.debutton

if PlayerClass()=="ROGUE" and Specialization()=="敏锐" then
--if Authorization() then
--开始循环
--自动拾取器

---------------------------------------------------------------------------
--[[                       编辑区                       ]]--
---------------------------------------------------------------------------

--最高优先级

--战斗前
if not InCombatLockdown() then
if PandaDB.MRZ_C4 ~= false  and Isuseable("潜行",1784) then
if ( not Stealth() ) then ShowColor(mainbutton.icon, 6603,C_4);ShowSpell(debutton.icon, 1784)   return end
end

if PandaDB.MRZ_A6 ~= false  and Isuseable("死亡标记",137619) then
if Power("COMBO_POINTS") <=2 then ShowColor(mainbutton.icon, 6603,A_6);ShowSpell(debutton.icon, 137619) return end
end

if PandaDB.CcdSwitch ~= false  then
if PandaDB.MRZ_A4 ~= false  and Isuseable("暗影之刃",121471) then ShowColor(mainbutton.icon, 6603,A_4);ShowSpell(debutton.icon, 121471) return end
end

if Stealth() then
if PandaDB.MRZ_A8 ~= false  and Isuseable("暗影打击",185438) then ShowColor(mainbutton.icon, 6603,A_8);ShowSpell(debutton.icon, 185438)   return end
end

end

if PandaDB.CcdSwitch ~= false  then
--艾泽拉斯之心精华
--essences
if PandaDB.MRZ_C8 then
if Isuseable("仇敌之血","仇敌之血") then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.MRZ_C8 then
if Isuseable("艾泽拉斯守护者","艾泽拉斯守护者") then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.MRZ_C8 then
if Isuseable("不羁之力","不羁之力") then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.MRZ_C8 then
if Isuseable("聚能艾泽里特射线","聚能艾泽里特射线") and Useing_spell("player") ~= 295258 and Aura_time("PLAYER","风火雷电")==0 and Aura_time("PLAYER","屏气凝神")==0 then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.MRZ_C8 then
if Isuseable("火红烈焰","火红烈焰") then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.MRZ_C8 then
if Isuseable("净化冲击","净化冲击") then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.MRZ_C8 then
if Isuseable("世界血脉共鸣","世界血脉共鸣") then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.MRZ_C8 then
if Isuseable("空间涟漪","空间涟漪") then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.MRZ_C8 then
if Isuseable("清醒梦境之忆","清醒梦境之忆") then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.MRZ_C8 then
if Isuseable("收割火焰","收割火焰")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.MRZ_C8 then
if Isuseable("生命缚誓者之祈","生命缚誓者之祈")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.MRZ_C8 then
if Isuseable("救世之魂","救世之魂")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.MRZ_C8 then
if Isuseable("守护屏障","守护屏障")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.MRZ_C8 then
if Isuseable("补充能量","补充能量")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.MRZ_C8 then
if Isuseable("静滞","静滞")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.MRZ_C8 then
if Isuseable("法力过载","法力过载")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.MRZ_C8 then
if Isuseable("活力导管","活力导管")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.MRZ_C8 then
if Isuseable("爆燃之拥","爆燃之拥")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.MRZ_C8 then
if Isuseable("光荣时刻","光荣时刻")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.MRZ_C8 then
if Isuseable("深渊之护","深渊之护")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.MRZ_C8 then
if Isuseable("艾泽拉斯的不朽赐福","艾泽拉斯的不朽赐福")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.MRZ_C8 then
if Isuseable("强化虚无屏障","强化虚无屏障")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

end

--CDs
if PandaDB.CcdSwitch ~= false  then
if PandaDB.MRZ_A3 ~= false  and Isuseable("暗影之舞",185313) then
if (Aura_time("PLAYER","暗影之舞")==0 and Aura_time("PLAYER","袖剑旋风")>0 and Aura_time("PLAYER","袖剑旋风")<=3.5) then ShowColor(mainbutton.icon, 6603,A_3);ShowSpell(debutton.icon, 185313) return end
end

if PandaDB.MRZ_A1 ~= false  and Isuseable("死亡符记",212283) then
if (Aura_time("PLAYER","袖剑旋风")>0 and Aura_time("PLAYER","袖剑旋风")<=3.5) then ShowColor(mainbutton.icon, 6603,A_1);ShowSpell(debutton.icon, 212283) return end
end

if PandaDB.MRZ_A1 ~= false  and Isuseable("死亡符记",212283) then
if (Aura_time("target","夜刃","PLAYER|HARMFUL")>0 and ( not IsTalent("袖剑旋风") or IsTalent("暗影集中") or active_enemies()<3 or SpellCooldown(277925)==0)) then ShowColor(mainbutton.icon, 6603,A_1);ShowSpell(debutton.icon, 212283) return end
end

if PandaDB.MRZ_A6 ~= false  and Isuseable("死亡标记",137619) then
if (not Stealth() and Power("COMBO_POINTS")==0) then ShowColor(mainbutton.icon, 6603,A_6);ShowSpell(debutton.icon, 137619) return end
end

if PandaDB.MRZ_A4 ~= false  and Isuseable("暗影之刃",121471) then
if ((Stealth() and PowerMax("COMBO_POINTS")-Power("COMBO_POINTS")>=2+1) or (not Stealth() and PowerMax("COMBO_POINTS")-Power("COMBO_POINTS")>=2)  ) then ShowColor(mainbutton.icon, 6603,A_4);ShowSpell(debutton.icon, 121471) return end
end

if PandaDB.MRZ_A7 ~= false  and Isuseable("袖剑旋风",277925) then
if (active_enemies()>=3 and  not IsTalent("暗影集中") and Aura_time("target","夜刃","PLAYER|HARMFUL")>0 and  not Stealth() and SpellCooldown(212283)>0 and SpellCharges(185313)>=1) then ShowColor(mainbutton.icon, 6603,A_7);ShowSpell(debutton.icon, 277925)   return end
end

if PandaDB.MRZ_A7 ~= false  and Isuseable("袖剑旋风",277925) then
if (active_enemies()>=3 and IsTalent("暗影集中") and Aura_time("target","夜刃","PLAYER|HARMFUL")>0 and Aura_time("PLAYER","死亡符记")>0) then ShowColor(mainbutton.icon, 6603,A_7);ShowSpell(debutton.icon, 277925)   return end
end

if PandaDB.MRZ_A3 ~= false  and Isuseable("暗影之舞",185313) then
if ( Aura_time("PLAYER","暗影之舞")==0 and TTD()<=5+AYZW() ) then ShowColor(mainbutton.icon, 6603,A_3);ShowSpell(debutton.icon, 185313) return end
end
end

--stealthed
if Stealth() then

if PandaDB.MRZ_A8 ~= false  and Isuseable("暗影打击",185438) then
if ( (IsTalent("洞悉弱点") or active_enemies()<3) and (Aura_count("PLAYER","潜行")>0 or Aura_count("PLAYER","消失")>0) ) then ShowColor(mainbutton.icon, 6603,A_8);ShowSpell(debutton.icon, 185438)   return end
end

if (PowerMax("COMBO_POINTS")-Power("COMBO_POINTS"))<=1-STE() then
--finish
if PandaDB.MRZ_A9 ~= false  and Isuseable("刺骨",196819) then
if ((IsTalent("影分身") and IsTalent("暗影集中") and Aura_time("PLAYER","夜之复仇")>0 and active_enemies()>=2+3) or (not IsTalent("影分身") and IsTalent("暗影集中") and Aura_time("PLAYER","夜之复仇")>0 and active_enemies()>=2)) then ShowColor(mainbutton.icon, 6603,A_9);ShowSpell(debutton.icon, 196819)   return end
end

if PandaDB.MRZ_C2 ~= false  and Isuseable("夜刃",195452) then
if nightblade_refreshable() and ( ( not IsTalent("黑暗之影") or  Aura_time("PLAYER","暗影之舞")==0) and TTD()-Aura_time("target","夜刃","PLAYER|HARMFUL")>12 and Aura_time("target","夜刃","PLAYER|HARMFUL")<(2/(1+GetHaste()/100))*2 ) then ShowColor(mainbutton.icon, 6603,C_2);ShowSpell(debutton.icon, 195452)   return end
end

if PandaDB.MRZ_C2 ~= false  and Isuseable("夜刃",195452) then
if nightblade_refreshable() and ( Aura_time("target","夜刃","PLAYER|HARMFUL")<SpellCooldown(212283)+10 and SpellCooldown(212283)<=5 and TTD()-Aura_time("target","夜刃","PLAYER|HARMFUL")>SpellCooldown(212283)+10 ) then ShowColor(mainbutton.icon, 6603,C_2);ShowSpell(debutton.icon, 195452)   return end
end

if PandaDB.MRZ_C1 ~= false  and Isuseable("影分身",280719) then
if ( Aura_time("PLAYER","死亡符记")>0 and ( not IsTalent("黑暗之影") or Aura_time("PLAYER","暗影之舞")>0) ) then ShowColor(mainbutton.icon, 6603,C_1);ShowSpell(debutton.icon, 280719)   return end
end

if PandaDB.MRZ_C1 ~= false  and Isuseable("影分身",280719) then
if ( active_enemies()>=2+YFS() ) then ShowColor(mainbutton.icon, 6603,C_1);ShowSpell(debutton.icon, 280719)   return end
end

if PandaDB.MRZ_C5 ~= false  and Isuseable("天降杀机",269513) then ShowColor(mainbutton.icon, 6603,C_5);ShowSpell(debutton.icon, 269513)   return end

if PandaDB.MRZ_A9 ~= false  and Isuseable("刺骨",196819) then ShowColor(mainbutton.icon, 6603,A_9);ShowSpell(debutton.icon, 196819)   return end

end

if PandaDB.MRZ_A0 ~= false  and Isuseable("幽暗之刃",200758) then
if IsTalent("幽暗之刃")  and ( AzltE("洞穿")>=2 and active_enemies()<=2 ) then ShowColor(mainbutton.icon, 6603,A_0);ShowSpell(debutton.icon, 200758)   return end
end

if PandaDB.MRZ_A8 ~= false  and Isuseable("暗影打击",185438) then
if (IsTalent("影分身") and IsTalent("洞悉弱点") and Aura_time("target","洞悉弱点","PLAYER|HARMFUL")<1 and active_enemies()==2 and TTD()-Aura_time("target","夜刃","PLAYER|HARMFUL")>12) then ShowColor(mainbutton.icon, 6603,A_8);ShowSpell(debutton.icon, 185438)   return end
end

if PandaDB.MRZ_A8 ~= false  and Isuseable("暗影打击",185438) then
if (not IsTalent("深邃诡计") and AzltE("影中利刃")==3 and active_enemies()==3) then ShowColor(mainbutton.icon, 6603,A_8);ShowSpell(debutton.icon, 185438)   return end
end

if PandaDB.MRZ_A8 ~= false  and Isuseable("暗影打击",185438) then
if (variable_use_priority_rotation() and (IsTalent("洞悉弱点") and Aura_time("target","洞悉弱点","PLAYER|HARMFUL")<1 or IsTalent("武器掌握") and active_enemies()<=4 or AzltE("命中注定")>0 and Aura_time("PLAYER","死亡符记")>0 and active_enemies()<=3)) then ShowColor(mainbutton.icon, 6603,A_8);ShowSpell(debutton.icon, 185438)   return end
end

if PandaDB.MRZ_A5 ~= false  and Isuseable("袖剑风暴",197835) then
if (active_enemies()>=3) then ShowColor(mainbutton.icon, 6603,A_5);ShowSpell(debutton.icon, 197835)   return end
end

if PandaDB.MRZ_A8 ~= false  and Isuseable("暗影打击",185438) then ShowColor(mainbutton.icon, 6603,A_8);ShowSpell(debutton.icon, 185438)   return end

end
if PandaDB.MRZ_C2 ~= false  and Isuseable("夜刃",195452) then
if nightblade_refreshable() and ( TTD()>10 and Aura_time("target","夜刃","PLAYER|HARMFUL")<GCD_MAX() and Power("COMBO_POINTS")>=4-YR() ) then ShowColor(mainbutton.icon, 6603,C_2);ShowSpell(debutton.icon, 195452)   return end
end

--stealth_cds
if PandaDB.MRZ_A3 ~= false  and Isuseable("暗影之舞",185313) then
if SpellFullCharges(185313)<=GCD_MAX() then ShowColor(mainbutton.icon, 6603,A_3);ShowSpell(debutton.icon, 185313) return end
end

if PandaDB.CcdSwitch ~= false  then
if variable_use_priority_rotation() or (PowerMax("COMBO_POINTS")-Power("COMBO_POINTS"))<=variable_stealth_threshold() then 

if PandaDB.MRZ_A3 ~= false  and Isuseable("暗影之舞",185313) then
if ( variable_shd_combo_points() and ( not IsTalent("黑暗之影") or Aura_time("target","夜刃","PLAYER|HARMFUL")>=5) and (SpellallCharges(185313)>=1.75 or Aura_time("PLAYER","死亡符记")>=1.2 or active_enemies()>=4 and SpellCooldown(212283)>10)) then ShowColor(mainbutton.icon, 6603,A_3);ShowSpell(debutton.icon, 185313) return end
end

if PandaDB.MRZ_A3 ~= false  and Isuseable("暗影之舞",185313) then
if ( variable_shd_combo_points() and TTD()<SpellCooldown(212283)) then ShowColor(mainbutton.icon, 6603,A_3);ShowSpell(debutton.icon, 185313) return end
end

end
end


if PandaDB.MRZ_C2 ~= false  and Isuseable("夜刃",195452) then
if nightblade_refreshable()  and ( AzltE("夜之复仇")>0 and active_enemies()<2 and SpellCooldown(212283)<=3 and  Aura_time("PLAYER","夜之复仇")==0 and Power("COMBO_POINTS")>=2) then ShowColor(mainbutton.icon, 6603,C_2);ShowSpell(debutton.icon, 195452)   return end
end

--finish
if (PowerMax("COMBO_POINTS")-Power("COMBO_POINTS"))<=1 or TTD()<=1 and Power("COMBO_POINTS")>=3 then

if PandaDB.MRZ_A9 ~= false  and Isuseable("刺骨",196819) then
if ((IsTalent("影分身") and IsTalent("暗影集中") and Aura_time("PLAYER","夜之复仇")>0 and active_enemies()>=2+3) or (not IsTalent("影分身") and IsTalent("暗影集中") and Aura_time("PLAYER","夜之复仇")>0 and active_enemies()>=2)) then ShowColor(mainbutton.icon, 6603,A_9);ShowSpell(debutton.icon, 196819)   return end
end

if PandaDB.MRZ_C2 ~= false  and Isuseable("夜刃",195452) then
if nightblade_refreshable()  and ( ( not IsTalent("黑暗之影") or  Aura_time("PLAYER","暗影之舞")==0) and TTD()-Aura_time("target","夜刃","PLAYER|HARMFUL")>12 and Aura_time("target","夜刃","PLAYER|HARMFUL")<(2/(1+GetHaste()/100))*2 ) then ShowColor(mainbutton.icon, 6603,C_2);ShowSpell(debutton.icon, 195452)   return end
end

if PandaDB.MRZ_C2 ~= false  and Isuseable("夜刃",195452) then
if nightblade_refreshable()  and ( Aura_time("target","夜刃","PLAYER|HARMFUL")<SpellCooldown(212283)+10 and SpellCooldown(212283)<=5 and TTD()-Aura_time("target","夜刃","PLAYER|HARMFUL")>SpellCooldown(212283)+10 ) then ShowColor(mainbutton.icon, 6603,C_2);ShowSpell(debutton.icon, 195452)   return end
end

if PandaDB.MRZ_C1 ~= false  and Isuseable("影分身",280719) then
if ( Aura_time("PLAYER","死亡符记")>0 and ( not IsTalent("黑暗之影") or Aura_time("PLAYER","暗影之舞")>0) ) then ShowColor(mainbutton.icon, 6603,C_1);ShowSpell(debutton.icon, 280719)   return end
end

if PandaDB.MRZ_C1 ~= false  and Isuseable("影分身",280719) then
if ( active_enemies()>=2+YFS() ) then ShowColor(mainbutton.icon, 6603,C_1);ShowSpell(debutton.icon, 280719)   return end
end


if PandaDB.MRZ_C5 ~= false  and Isuseable("天降杀机",269513) then ShowColor(mainbutton.icon, 6603,C_5);ShowSpell(debutton.icon, 269513)   return end

if PandaDB.MRZ_A9 ~= false  and Isuseable("刺骨",196819) then ShowColor(mainbutton.icon, 6603,A_9);ShowSpell(debutton.icon, 196819)   return end

end

--finish
if ( active_enemies()>=4 and Power("COMBO_POINTS")>=4 ) then

if PandaDB.MRZ_A9 ~= false  and Isuseable("刺骨",196819) then
if ((IsTalent("影分身") and IsTalent("暗影集中") and Aura_time("PLAYER","夜之复仇")>0 and active_enemies()>=2+3) or (not IsTalent("影分身") and IsTalent("暗影集中") and Aura_time("PLAYER","夜之复仇")>0 and active_enemies()>=2)) then ShowColor(mainbutton.icon, 6603,A_9);ShowSpell(debutton.icon, 196819)   return end
end

if PandaDB.MRZ_C2 ~= false  and Isuseable("夜刃",195452) then
if nightblade_refreshable() and ( ( not IsTalent("黑暗之影") or  Aura_time("PLAYER","暗影之舞")==0) and TTD()-Aura_time("target","夜刃","PLAYER|HARMFUL")>12 and Aura_time("target","夜刃","PLAYER|HARMFUL")<(2/(1+GetHaste()/100))*2 ) then ShowColor(mainbutton.icon, 6603,C_2);ShowSpell(debutton.icon, 195452)   return end
end

if PandaDB.MRZ_C2 ~= false  and Isuseable("夜刃",195452) then
if nightblade_refreshable() and ( Aura_time("target","夜刃","PLAYER|HARMFUL")<SpellCooldown(212283)+10 and SpellCooldown(212283)<=5 and TTD()-Aura_time("target","夜刃","PLAYER|HARMFUL")>SpellCooldown(212283)+10 ) then ShowColor(mainbutton.icon, 6603,C_2);ShowSpell(debutton.icon, 195452)   return end
end

if PandaDB.MRZ_C1 ~= false  and Isuseable("影分身",280719) then
if ( Aura_time("PLAYER","死亡符记")>0 and ( not IsTalent("黑暗之影") or Aura_time("PLAYER","暗影之舞")>0) ) then ShowColor(mainbutton.icon, 6603,C_1);ShowSpell(debutton.icon, 280719)   return end
end

if PandaDB.MRZ_C1 ~= false  and Isuseable("影分身",280719) then
if ( active_enemies()>=2+YFS() ) then ShowColor(mainbutton.icon, 6603,C_1);ShowSpell(debutton.icon, 280719)   return end
end

if PandaDB.MRZ_C5 ~= false  and Isuseable("天降杀机",269513) then ShowColor(mainbutton.icon, 6603,C_5);ShowSpell(debutton.icon, 269513)   return end

if PandaDB.MRZ_A9 ~= false  and Isuseable("刺骨",196819) then ShowColor(mainbutton.icon, 6603,A_9);ShowSpell(debutton.icon, 196819)   return end

end
--build
if not Stealth() then
if (PowerMax("COMBO_POINTS")-Power("COMBO_POINTS"))<=variable_stealth_threshold() then

if PandaDB.MRZ_A5 ~= false  and Isuseable("袖剑风暴",197835) then
if (((IsTalent("幽暗之刃") and AzltE("洞穿")>=2) and active_enemies()>=2+1) or ((not IsTalent("幽暗之刃") or AzltE("洞穿")<2) and active_enemies()>=2)) then ShowColor(mainbutton.icon, 6603,A_5);ShowSpell(debutton.icon, 197835)   return end
end

if PandaDB.MRZ_A0 ~= false  and Isuseable("幽暗之刃",200758) then
if IsTalent("幽暗之刃")  then ShowColor(mainbutton.icon, 6603,A_0);ShowSpell(debutton.icon, 200758)   return end
end

if PandaDB.MRZ_A0 ~= false  and Isuseable("背刺",53)  then ShowColor(mainbutton.icon, 6603,A_0);ShowSpell(debutton.icon, 53)   return end

end
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

local Rogue_Subtlety = Rogue_Subtlety
ns.Rogue_Subtlety = Rogue_Subtlety

