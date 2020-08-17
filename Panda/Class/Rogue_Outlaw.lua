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
--[[                   变量                      ]]--
---------------------------------------------------------------------------  

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

--狂徒
local function SZ()--骰子数               
    local buff_1 = Aura_time("PLAYER","强势连击")
    local buff_2 = Aura_time("PLAYER","残忍精准")
	local buff_3 = Aura_time("PLAYER","大乱斗")
	local buff_4 = Aura_time("PLAYER","骷髅黑帆")
	local buff_5 = Aura_time("PLAYER","精准定位") 
	local buff_6 = Aura_time("PLAYER","埋藏的宝藏")   
    local h=0
	if buff_1>0 then h=h+1 end
    if buff_2>0 then h=h+1 end
	if buff_3>0 then h=h+1 end
	if buff_4>0 then h=h+1 end
	if buff_5>0 then h=h+1 end
	if buff_6>0 then h=h+1 end
    
	
    return h
end 


local function buff_roll_the_bones()--骰子剩余时间
    local buff_1 = Aura_time("PLAYER","强势连击")
    local buff_2 = Aura_time("PLAYER","残忍精准")
	local buff_3 = Aura_time("PLAYER","大乱斗")
	local buff_4 = Aura_time("PLAYER","骷髅黑帆")
	local buff_5 = Aura_time("PLAYER","精准定位") 
	local buff_6 = Aura_time("PLAYER","埋藏的宝藏")   
    local t= {
	    buff_1,
        buff_2,
        buff_3,
        buff_4,
        buff_5,
        buff_6
    } 
    
    local maxOfT = floor(math.max(unpack(t)))--计算最大值
    return maxOfT
end

local function finish()--call_actions_finish
     
	local A = 0
	local B = 0
	local C = 0
	local buff_1 = Aura_time("PLAYER","强势连击")
	local buff_2 = Aura_time("PLAYER","可乘之机")
	local talent_1 = IsTalent("快速拔枪")
	local talent_2 = IsTalent("死亡标记") 
	local spell_1 =  SpellCooldown(137619)
	
    if buff_1 > 0 then A =1 else A=0 end 
    if buff_2 > 0 then B=1 else B=0 end 
    if talent_1 and ( not talent_2 or spell_1>1) then C=1 else C=0 end 
    
	local Y= (A+B)*C 
    
    return Y
end

local function SQ()--手枪
    local A = 0
    local B = 0
    local buff_1 = Aura_time("PLAYER","强势连击")
	local talent_1 = IsTalent("快速拔枪")
    if buff_1 > 0 then A=1 else A=0 end 
    if talent_1 then B=1 else B=0 end
    
	local C = A+B
    return C
end

local function variable_rtb_reroll()
local A = false
local shaizi = SZ()
local buff_1 = Aura_time("PLAYER","灌铅骰子")
local buff_2 = Aura_time("PLAYER","大乱斗")
local buff_3 = Aura_time("PLAYER","残忍精准")
local buff_4 = Aura_time("PLAYER","剑刃乱舞")
local TZ_sss = AzltE("神射手")
local TZ_qk = AzltE("袖里乾坤")
local Spellcd_1 = SpellCooldown(199804)

if ( ( shaizi<2 and (buff_1 > 0 or  buff_2 <= 0 and buff_3 <= 0) )
or ( ( TZ_sss>0 or TZ_qk>0 ) and ( shaizi<2 and (buff_1 > 0 or buff_3 <= Spellcd_1))) ) and  buff_4<= 0  then

A  = true else A =false 
 
end

 return A
 
end
 
local function variable_blade_flurry_sync()
local A = false
local ems = active_enemies()
local buffs = Aura_time("PLAYER","剑刃乱舞")
if ems<2 or  buffs> 0 then A  = true else A =false  end

return A
end
 



local function Rogue_Outlaw()  --更新主图标及技能提示图标

local mainbutton = PDUI.mainbutton
local debutton = PDUI.debutton

if PlayerClass()=="ROGUE" and Specialization()=="狂徒" then
--if Authorization() then
--开始循环
--自动拾取器


---------------------------------------------------------------------------
--[[                       编辑区                       ]]--
---------------------------------------------------------------------------

--战斗前
if not InCombatLockdown() then
if PandaDB.KTZ_C4 ~= false  and Isuseable("潜行",1784) then
if ( not Stealth()  ) then ShowColor(mainbutton.icon, 6603,C_4);ShowSpell(debutton.icon, 1784)   return end
end

if PandaDB.KTZ_A6 ~= false  and Isuseable("死亡标记",137619) then
if Power("COMBO_POINTS") <=2 then ShowColor(mainbutton.icon, 6603,A_6);ShowSpell(debutton.icon, 137619) return end
end

if PandaDB.KTZ_A3 ~= false  and Isuseable("命运骨骰",193316) then
if buff_roll_the_bones()<=3 then ShowColor(mainbutton.icon, 6603,A_3);ShowSpell(debutton.icon, 193316) return end
end

if PandaDB.KTZ_A3 ~= false  and Isuseable("切割",5171) and IsTalent("切割") then
if Aura_time("PLAYER","切割") <2 then ShowColor(mainbutton.icon, 6603,A_3);ShowSpell(debutton.icon, 5171) return end
end


end

--stealth
if PandaDB.KTZ_C6 ~= false  and Isuseable("伏击",8676) then
if ( Stealth()  and PowerMax("COMBO_POINTS")-Power("COMBO_POINTS")>=2 ) then ShowColor(mainbutton.icon, 6603,C_6);ShowSpell(debutton.icon, 8676)   return end
end

--CD
if PandaDB.CcdSwitch ~= false  then
--艾泽拉斯之心精华
--essences
if PandaDB.KTZ_C8 then
if Isuseable("仇敌之血","仇敌之血") then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.KTZ_C8 then
if Isuseable("艾泽拉斯守护者","艾泽拉斯守护者") then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.KTZ_C8 then
if Isuseable("不羁之力","不羁之力") then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.KTZ_C8 then
if Isuseable("聚能艾泽里特射线","聚能艾泽里特射线") and Useing_spell("player") ~= 295258 and Aura_time("PLAYER","风火雷电")==0 and Aura_time("PLAYER","屏气凝神")==0 then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.KTZ_C8 then
if Isuseable("火红烈焰","火红烈焰") then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.KTZ_C8 then
if Isuseable("净化冲击","净化冲击") then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.KTZ_C8 then
if Isuseable("世界血脉共鸣","世界血脉共鸣") then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.KTZ_C8 then
if Isuseable("空间涟漪","空间涟漪") then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.KTZ_C8 then
if Isuseable("清醒梦境之忆","清醒梦境之忆") then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.KTZ_C8 then
if Isuseable("收割火焰","收割火焰")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.KTZ_C8 then
if Isuseable("生命缚誓者之祈","生命缚誓者之祈")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.KTZ_C8 then
if Isuseable("救世之魂","救世之魂")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.KTZ_C8 then
if Isuseable("守护屏障","守护屏障")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.KTZ_C8 then
if Isuseable("补充能量","补充能量")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.KTZ_C8 then
if Isuseable("静滞","静滞")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.KTZ_C8 then
if Isuseable("法力过载","法力过载")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.KTZ_C8 then
if Isuseable("活力导管","活力导管")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.KTZ_C8 then
if Isuseable("爆燃之拥","爆燃之拥")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.KTZ_C8 then
if Isuseable("光荣时刻","光荣时刻")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.KTZ_C8 then
if Isuseable("深渊之护","深渊之护")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.KTZ_C8 then
if Isuseable("艾泽拉斯的不朽赐福","艾泽拉斯的不朽赐福")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.KTZ_C8 then
if Isuseable("强化虚无屏障","强化虚无屏障")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end
--------------
if PandaDB.KTZ_A4 ~= false  and Isuseable("冲动",13750) then
if ( Aura_time("PLAYER","冲动") ==  0 and (PowerMax("ENERGY")-Power("ENERGY"))/DYS()>1 ) then ShowColor(mainbutton.icon, 6603,A_4);ShowSpell(debutton.icon, 13750)   return end
end

end

if PandaDB.KTZ_A6 ~= false  and Isuseable("死亡标记",137619) then
if Power("COMBO_POINTS") <=2 then ShowColor(mainbutton.icon, 6603,A_6);ShowSpell(debutton.icon, 137619) return end
end

if PandaDB.KTZ_A5 ~= false  and Isuseable("剑刃乱舞",13877) then
if active_enemies()>=2 and  Aura_time("PLAYER","剑刃乱舞") <= 0 then ShowColor(mainbutton.icon, 6603,A_5);ShowSpell(debutton.icon, 13877) return end
end

if PandaDB.KTZ_A1 ~= false  and Isuseable("鬼魅攻击",196937) then
if (variable_blade_flurry_sync() and PowerMax("COMBO_POINTS") - Power("COMBO_POINTS")>=1 ) then ShowColor(mainbutton.icon, 6603,A_1);ShowSpell(debutton.icon, 196937) return end
end

if PandaDB.CcdSwitch ~= false  then
if PandaDB.KTZ_C1 ~= false  and Isuseable("影舞步",51690) then
if ( variable_blade_flurry_sync()and ((PowerMax("ENERGY")-Power("ENERGY"))/DYS()>1 or Power("ENERGY")<15 or active_enemies()>=3) ) then ShowColor(mainbutton.icon, 6603,C_1);ShowSpell(debutton.icon, 51690) return end
end

if PandaDB.KTZ_A0 ~= false  and Isuseable("刀锋冲刺",271877) then
if ( variable_blade_flurry_sync() and (PowerMax("ENERGY")-Power("ENERGY"))/DYS()>1 ) then ShowColor(mainbutton.icon, 6603,A_0);ShowSpell(debutton.icon, 271877) return end
end
end




--finish
if Power("COMBO_POINTS")>=PowerMax("COMBO_POINTS")- finish() then
if PandaDB.KTZ_A9 ~= false  and Isuseable("正中眉心",199804) then
if ( Aura_time("PLAYER","残忍精准") > 0  or (AzltE("神射手")>0 or AzltE("袖里乾坤")>0) and buff_roll_the_bones()>0 ) then ShowColor(mainbutton.icon, 6603,A_9);ShowSpell(debutton.icon, 199804) return end
end

if PandaDB.KTZ_A3 ~= false  and Isuseable("切割",5171) and IsTalent("切割") then
if Aura_time("PLAYER","切割") <2 then ShowColor(mainbutton.icon, 6603,A_3);ShowSpell(debutton.icon, 5171) return end
end

if PandaDB.KTZ_A3 ~= false  and Isuseable("命运骨骰",193316) then
if ( buff_roll_the_bones()<=3 or variable_rtb_reroll() ) then ShowColor(mainbutton.icon, 6603,A_3);ShowSpell(debutton.icon, 193316) return end
end

if PandaDB.KTZ_A9 ~= false  and Isuseable("正中眉心",199804) then
if ( AzltE("袖里乾坤")>0 or AzltE("神射手")>0 ) then ShowColor(mainbutton.icon, 6603,A_9);ShowSpell(debutton.icon, 199804) return end
end

if PandaDB.KTZ_C5 ~= false  and Isuseable("天降杀机",269513) then ShowColor(mainbutton.icon, 6603,C_5);ShowSpell(debutton.icon, 269513)   return end

if PandaDB.KTZ_A7 ~= false  and Isuseable("斩击",2098) then ShowColor(mainbutton.icon, 6603,A_7);ShowSpell(debutton.icon, 2098)   return end

--build
elseif Power("COMBO_POINTS")<PowerMax("COMBO_POINTS")- finish() then 

if PandaDB.KTZ_C2 ~= false  and Isuseable("手枪射击",185763) then
if ( PowerMax("COMBO_POINTS")-Power("COMBO_POINTS") > 1 + SQ() ) and (Aura_time("PLAYER","可乘之机") > 0 and (Aura_Stack("PLAYER","审时度势")<25 or Aura_time("PLAYER","神射手") > 0 or Power("ENERGY")<45)) then ShowColor(mainbutton.icon, 6603,C_2);ShowSpell(debutton.icon, 185763)   return end
end

if PandaDB.KTZ_A8 ~= false  and Isuseable("影袭",193315) then ShowColor(mainbutton.icon, 6603,A_8);ShowSpell(debutton.icon, 193315)  return end
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

local Rogue_Outlaw = Rogue_Outlaw
ns.Rogue_Outlaw = Rogue_Outlaw

