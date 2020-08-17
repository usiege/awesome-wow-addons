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
["凛风冲击"] = A_1,
["冰川突进"] = A_2,
["冰霜打击"] = A_3,
["寒冰联结"] = A_4,
["冰霜之柱"] = A_5,
["冰龙吐息"] = A_6,
["符文武器增效"] = A_7,
["冰霜巨龙之怒"] = A_8,
["寒冰锁链"] = A_9,
["湮灭"] = A_0,
["冷酷严冬"] = C_1,
["冰霜之镰"] = C_2,
["远程拾取器"] = C_3,
["寒冬号角"] = C_4,
["艾泽拉斯之心精华"] = C_8,

}

local Spell = {
["凛风冲击"] = 49184,
["冰川突进"] = 194913,
["冰霜打击"] = 49143,
["寒冰联结"] = 305392,
["冰霜之柱"] = 51271,
["冰龙吐息"] = 152279,
["符文武器增效"] = 47568,
["冰霜巨龙之怒"] = 279302,
["寒冰锁链"] = 45524,
["湮灭"] = 49020,
["冷酷严冬"] = 196770,
["冰霜之镰"] = 207230,
["寒冬号角"] = 57330,
["艾泽拉斯之心精华"] = 296208,
} 


local function Death_Knight_Frost()  --更新主图标及技能提示图标

local mainbutton = PDUI.mainbutton
local debutton = PDUI.debutton

if PlayerClass() == "DEATHKNIGHT" and Specialization() == "冰霜" then
--if Authorization() then


--开始循环
--自动拾取器

---------------------------------------------------------------------------
--[[                       编辑区                       ]]--
---------------------------------------------------------------------------
if PandaDB.BDK_A1 then
if Isuseable("凛风冲击",49184) and (Aura_time("target","冰霜疫病","PLAYER|HARMFUL")==0 and (not IsTalent("冰龙吐息") or SpellCooldown(152279)>15 or PandaDB.BDK_A6 == false or PandaDB.CcdSwitch == false ) ) then ShowColor(mainbutton.icon, 6603,Color["凛风冲击"]);ShowSpell(debutton.icon,Spell["凛风冲击"]) return end
end

if PandaDB.BDK_A2 then
if Isuseable("冰川突进",194913) and (Aura_time("player","冰冷之爪")<=GCD_MAX() and Aura_time("player","冰冷之爪")>0 and active_enemies()>=2 and (not IsTalent("冰龙吐息") or SpellCooldown(152279)>15 or PandaDB.BDK_A6 == false or PandaDB.CcdSwitch == false )) then ShowColor(mainbutton.icon, 6603,Color["冰川突进"]);ShowSpell(debutton.icon,Spell["冰川突进"]) return end
end

if PandaDB.BDK_A3 then
if Isuseable("冰霜打击",49143) and (Aura_time("player","冰冷之爪")<=GCD_MAX() and Aura_time("player","冰冷之爪")>0 and (not IsTalent("冰龙吐息") or SpellCooldown(152279)>15 or PandaDB.BDK_A6 == false or PandaDB.CcdSwitch == false )) then ShowColor(mainbutton.icon, 6603,Color["冰霜打击"]);ShowSpell(debutton.icon,Spell["冰霜打击"]) return end
end

if PandaDB.CcdSwitch ~= false then
--essences
if PandaDB.BDK_C8 then
--if Isuseable("仇敌之血","仇敌之血") and (Aura_time("player","冰霜之柱")>0 and (Aura_time("player","冰霜之柱")<10 and (Aura_time("player","冰龙吐息")>0 or IsTalent("湮没") or IsTalent("冰盖") and AzltE("冰霜堡垒")==0) or Aura_time("player","冰霜堡垒")>0 and IsTalent("冰盖"))) then ShowColor(mainbutton.icon, 6603,Color["艾泽拉斯之心精华"]);ShowSpell(debutton.icon,Spell["艾泽拉斯之心精华"]) return end
if Isuseable("仇敌之血","仇敌之血") and (Aura_time("player","冰霜之柱")>0) then ShowColor(mainbutton.icon, 6603,Color["艾泽拉斯之心精华"]);ShowSpell(debutton.icon,Spell["艾泽拉斯之心精华"]) return end

end

if PandaDB.BDK_C8 then
if Isuseable("艾泽拉斯守护者","艾泽拉斯守护者") and (not IsTalent("冰盖") or IsTalent("冰盖") and AzltE("冰霜堡垒")>0 and Aura_time("player","冰霜之柱")<6 and Aura_time("player","冰霜之柱")>0 or IsTalent("冰盖") and AzltE("冰霜堡垒")==0) then ShowColor(mainbutton.icon, 6603,Color["艾泽拉斯之心精华"]);ShowSpell(debutton.icon,Spell["艾泽拉斯之心精华"]) return end
end

if PandaDB.BDK_A4 then
if Isuseable("寒冰联结",305392) and (Aura_time("player","冰霜之柱")<5 and Aura_time("player","冰霜之柱")>0 or TTD()<5) then ShowColor(mainbutton.icon, 6603,Color["寒冰联结"]);ShowSpell(debutton.icon,Spell["寒冰联结"]) return end
end

if PandaDB.BDK_C8 then
if Isuseable("不羁之力","不羁之力") and (Aura_time("player","无畏之力")>0 or Aura_Stack("player","无畏之力")<11) then ShowColor(mainbutton.icon, 6603,Color["艾泽拉斯之心精华"]);ShowSpell(debutton.icon,Spell["艾泽拉斯之心精华"]) return end
end

if PandaDB.BDK_C8 then
if Isuseable("聚能艾泽里特射线","聚能艾泽里特射线") and (Aura_time("player","冰霜之柱")==0 and Aura_time("player","冰龙吐息")==0) then ShowColor(mainbutton.icon, 6603,Color["艾泽拉斯之心精华"]);ShowSpell(debutton.icon,Spell["艾泽拉斯之心精华"]) return end
end

if PandaDB.BDK_C8 then
if Isuseable("火红烈焰","火红烈焰") and (Aura_time("player","冰霜之柱")==0 and Aura_time("player","冰龙吐息")==0 and Aura_time("target","火红烈焰","PLAYER|HARMFUL")==0) then ShowColor(mainbutton.icon, 6603,Color["艾泽拉斯之心精华"]);ShowSpell(debutton.icon,Spell["艾泽拉斯之心精华"]) return end
end

if PandaDB.BDK_C8 then
if Isuseable("净化冲击","净化冲击") and (Aura_time("player","冰霜之柱")==0 and Aura_time("player","冰龙吐息")==0) then ShowColor(mainbutton.icon, 6603,Color["艾泽拉斯之心精华"]);ShowSpell(debutton.icon,Spell["艾泽拉斯之心精华"]) return end
end

if PandaDB.BDK_C8 then
if Isuseable("世界血脉共鸣","世界血脉共鸣") and (Aura_time("player","冰霜之柱")>0 or Aura_time("player","符文武器增效")>0 or SpellCooldown(152279)>60+15 or PandaDB.BDK_A6 == false or PandaDB.CcdSwitch == false ) then ShowColor(mainbutton.icon, 6603,Color["艾泽拉斯之心精华"]);ShowSpell(debutton.icon,Spell["艾泽拉斯之心精华"]) return end
end

if PandaDB.BDK_C8 then
if Isuseable("空间涟漪","空间涟漪") and (Aura_time("player","冰霜之柱")==0 and Aura_time("player","冰龙吐息")==0) then ShowColor(mainbutton.icon, 6603,Color["艾泽拉斯之心精华"]);ShowSpell(debutton.icon,Spell["艾泽拉斯之心精华"]) return end
end

if PandaDB.BDK_C8 then
if Isuseable("清醒梦境之忆","清醒梦境之忆") and (Aura_time("player","符文武器增效")<5 and Aura_time("player","冰龙吐息")>0 or (Power("RUNIC_POWER")<50)) then ShowColor(mainbutton.icon, 6603,Color["艾泽拉斯之心精华"]);ShowSpell(debutton.icon,Spell["艾泽拉斯之心精华"]) return end
end

if PandaDB.BDK_C8 then
if Isuseable("收割火焰","收割火焰")  then ShowColor(mainbutton.icon, 6603,Color["艾泽拉斯之心精华"]);ShowSpell(debutton.icon,Spell["艾泽拉斯之心精华"]) return end
end

--cooldowns
if PandaDB.BDK_A5 then
if Isuseable("冰霜之柱",51271) and (SpellCooldown(47568)>0 or PandaDB.BDK_A7 == false or PandaDB.CcdSwitch == false or IsTalent("冰盖")) then ShowColor(mainbutton.icon, 6603,Color["冰霜之柱"]);ShowSpell(debutton.icon,Spell["冰霜之柱"]) return end
end

if PandaDB.BDK_A6 then
if Isuseable("冰龙吐息",152279) and ((SpellCooldown(47568)>0 or PandaDB.BDK_A7 == false or PandaDB.CcdSwitch == false) and (SpellCooldown(51271)>0 or PandaDB.BDK_A5 == false or PandaDB.CcdSwitch == false)) then ShowColor(mainbutton.icon, 6603,Color["冰龙吐息"]);ShowSpell(debutton.icon,Spell["冰龙吐息"]) return end
end


if PandaDB.BDK_A7 then
if Isuseable("符文武器增效",47568) and (SpellCooldown(51271)==0 and IsTalent("湮没") and Runes()<5 and PowerMax("RUNIC_POWER")-Power("RUNIC_POWER")>=10 or TTD()<20) then ShowColor(mainbutton.icon, 6603,Color["符文武器增效"]);ShowSpell(debutton.icon,Spell["符文武器增效"]) return end
end

if PandaDB.BDK_A7 then
if Isuseable("符文武器增效",47568) and ((Runes()<5 and SpellCooldown(51271)==0 or TTD()<20) and IsTalent("冰龙吐息") and Power("RUNIC_POWER")>60) then ShowColor(mainbutton.icon, 6603,Color["符文武器增效"]);ShowSpell(debutton.icon,Spell["符文武器增效"]) return end
end

if PandaDB.BDK_A7 then
if Isuseable("符文武器增效",47568) and (IsTalent("冰盖") and Runes()<5 ) then ShowColor(mainbutton.icon, 6603,Color["符文武器增效"]);ShowSpell(debutton.icon,Spell["符文武器增效"]) return end
end

end
---------------------------------
--call_action_list,name=cold_heart
if IsTalent("冷酷之心") and ( Aura_Stack("player","冷酷之心")>=10 ) then

if PandaDB.BDK_A9 then
if Isuseable("寒冰锁链",45524) and (Aura_Stack("player","冷酷之心")>5 and TTD()<=GCD_MAX()) then ShowColor(mainbutton.icon, 6603,Color["寒冰锁链"]);ShowSpell(debutton.icon,Spell["寒冰锁链"]) return end
end

if PandaDB.BDK_A9 then
if Isuseable("寒冰锁链",45524) and ((Aura_time("player","沸腾怒气")<GCD_MAX()) and Aura_time("player","沸腾怒气")>0) then ShowColor(mainbutton.icon, 6603,Color["寒冰锁链"]);ShowSpell(debutton.icon,Spell["寒冰锁链"]) return end
end

if PandaDB.BDK_A9 then
if Isuseable("寒冰锁链",45524) and ((Aura_time("player","冰霜之柱")<=GCD_MAX()*2 ) and Aura_time("player","冰霜之柱")>0 and (AzltE("冰霜堡垒")<=1 or Aura_time("player","冰龙吐息")>0) and not IsTalent("冰盖")) then ShowColor(mainbutton.icon, 6603,Color["寒冰锁链"]);ShowSpell(debutton.icon,Spell["寒冰锁链"]) return end
end

if PandaDB.BDK_A9 then
if Isuseable("寒冰锁链",45524) and (Aura_time("player","冰霜之柱")<8 and Aura_time("player","不洁之力")<GCD_MAX()*2 and Aura_time("player","不洁之力")>0 and Aura_time("player","冰霜之柱")>0 and (AzltE("冰霜堡垒")<=1 or Aura_time("player","冰龙吐息")>0) and not IsTalent("冰盖")) then ShowColor(mainbutton.icon, 6603,Color["寒冰锁链"]);ShowSpell(debutton.icon,Spell["寒冰锁链"]) return end
end

if PandaDB.BDK_A9 then
if Isuseable("寒冰锁链",45524) and ((Aura_time("player","冰霜堡垒")<4 ) and Aura_time("player","冰霜堡垒")>0 and AzltE("冰霜堡垒")>=2 and Aura_time("player","冰龙吐息")==0 and not IsTalent("冰盖")) then ShowColor(mainbutton.icon, 6603,Color["寒冰锁链"]);ShowSpell(debutton.icon,Spell["寒冰锁链"]) return end
end

if PandaDB.BDK_A9 then
if Isuseable("寒冰锁链",45524) and (Aura_time("player","冰霜堡垒")>0 and Aura_time("player","不洁之力")>0 and AzltE("冰霜堡垒")>=2 and Aura_time("player","冰龙吐息")==0 and not IsTalent("冰盖")) then ShowColor(mainbutton.icon, 6603,Color["寒冰锁链"]);ShowSpell(debutton.icon,Spell["寒冰锁链"]) return end
end

if PandaDB.BDK_A9 then
if Isuseable("寒冰锁链",45524) and (Aura_time("player","冰霜之柱")<4 and Aura_time("player","冰霜之柱")>0 and IsTalent("冰盖") and Aura_Stack("player","冷酷之心")>=18 and AzltE("冰霜堡垒")<=1) then ShowColor(mainbutton.icon, 6603,Color["寒冰锁链"]);ShowSpell(debutton.icon,Spell["寒冰锁链"]) return end
end

if PandaDB.BDK_A9 then
if Isuseable("寒冰锁链",45524) and (Aura_time("player","冰霜之柱")>0 and IsTalent("冰盖") and AzltE("冰霜堡垒")>=2 and (Aura_Stack("player","冷酷之心")>=19 and Aura_time("player","冰霜堡垒")<GCD_MAX() and Aura_time("player","冰霜堡垒")>0 or Aura_time("player","不洁之力")>0 and Aura_Stack("player","冷酷之心")>=18)) then ShowColor(mainbutton.icon, 6603,Color["寒冰锁链"]);ShowSpell(debutton.icon,Spell["寒冰锁链"]) return end
end


end

-------------------------------------------------
if PandaDB.CcdSwitch ~= false then

if PandaDB.BDK_A8 then
if Isuseable("冰霜巨龙之怒",279302) and ((Aura_time("player","冰霜之柱")>0 and AzltE("冰霜堡垒")<=1 and (Aura_time("player","冰霜之柱")<=GCD_MAX() or Aura_time("player","不洁之力")<=GCD_MAX() and Aura_time("player","不洁之力")>0))) then ShowColor(mainbutton.icon, 6603,Color["冰霜巨龙之怒"]);ShowSpell(debutton.icon,Spell["冰霜巨龙之怒"]) return end
end

if PandaDB.BDK_A8 then
if Isuseable("冰霜巨龙之怒",279302) and ((Aura_time("player","冰霜堡垒")>0 and not IsTalent("冰盖") and (Aura_time("player","不洁之力")>0 or Aura_time("player","冰霜堡垒")<=GCD_MAX())) or Aura_time("player","冰霜堡垒")>0 and Aura_time("player","冰霜堡垒")<=GCD_MAX() and IsTalent("冰盖") and Aura_time("player","冰霜之柱")>0) then ShowColor(mainbutton.icon, 6603,Color["冰霜巨龙之怒"]);ShowSpell(debutton.icon,Spell["冰霜巨龙之怒"]) return end
end

if PandaDB.BDK_A8 then
if Isuseable("冰霜巨龙之怒",279302) and (TTD()<GCD_MAX() or ((TTD()<SpellCooldown(51271) or PandaDB.BDK_A5 == false or PandaDB.CcdSwitch == false) and Aura_time("player","不洁之力")>0)) then ShowColor(mainbutton.icon, 6603,Color["冰霜巨龙之怒"]);ShowSpell(debutton.icon,Spell["冰霜巨龙之怒"]) return end
end
end

---bos_ticking
if Aura_time("player","冰龙吐息")>0 then

if PandaDB.BDK_A0 then
if Isuseable("湮灭",49020) and ((Aura_Stack("target","锋锐之霜","PLAYER|HARMFUL")<5 or Aura_time("target","锋锐之霜","PLAYER|HARMFUL")<10) and Power("RUNIC_POWER")<=32 and not IsTalent("冰霜之镰")) then ShowColor(mainbutton.icon, 6603,Color["湮灭"]);ShowSpell(debutton.icon,Spell["湮灭"]) return end
end

if PandaDB.BDK_A0 then
if Isuseable("湮灭",49020) and (Power("RUNIC_POWER")<=32) then ShowColor(mainbutton.icon, 6603,Color["湮灭"]);ShowSpell(debutton.icon,Spell["湮灭"]) return end
end

if PandaDB.BDK_C1 then
if Isuseable("冷酷严冬",196770) and (IsTalent("风暴汇聚")) then ShowColor(mainbutton.icon, 6603,Color["冷酷严冬"]);ShowSpell(debutton.icon,Spell["冷酷严冬"]) return end
end

if PandaDB.BDK_A1 then
if Isuseable("凛风冲击",49184) and (Aura_time("player","白霜")>0) then ShowColor(mainbutton.icon, 6603,Color["凛风冲击"]);ShowSpell(debutton.icon,Spell["凛风冲击"]) return end
end

if PandaDB.BDK_A0 then
if Isuseable("湮灭",49020) and ((Aura_Stack("target","锋锐之霜","PLAYER|HARMFUL")<5 or Aura_time("target","锋锐之霜","PLAYER|HARMFUL")<10) and Runes()>=6 or Power("RUNIC_POWER")<=45 and not IsTalent("冰霜之镰")) then ShowColor(mainbutton.icon, 6603,Color["湮灭"]);ShowSpell(debutton.icon,Spell["湮灭"]) return end
end

if PandaDB.BDK_A0 then
if Isuseable("湮灭",49020) and ( Runes()>=6 or Power("RUNIC_POWER")<=45 ) then ShowColor(mainbutton.icon, 6603,Color["湮灭"]);ShowSpell(debutton.icon,Spell["湮灭"]) return end
end

if PandaDB.BDK_C2 then
if Isuseable("冰霜之镰",207230) and ( Aura_time("player","杀戮机器")>0 and active_enemies()>=2 ) then ShowColor(mainbutton.icon, 6603,Color["冰霜之镰"]);ShowSpell(debutton.icon,Spell["冰霜之镰"]) return end
end

if PandaDB.BDK_C4 then
if Isuseable("寒冬号角",57330) and ( PowerMax("RUNIC_POWER")-Power("RUNIC_POWER")>=32 ) then ShowColor(mainbutton.icon, 6603,Color["寒冬号角"]);ShowSpell(debutton.icon,Spell["寒冬号角"]) return end
end

if PandaDB.BDK_C1 then
if Isuseable("冷酷严冬",196770) then ShowColor(mainbutton.icon, 6603,Color["冷酷严冬"]);ShowSpell(debutton.icon,Spell["冷酷严冬"]) return end
end

if PandaDB.BDK_C2 then
if Isuseable("冰霜之镰",207230) and ( active_enemies()>=2 ) then ShowColor(mainbutton.icon, 6603,Color["冰霜之镰"]);ShowSpell(debutton.icon,Spell["冰霜之镰"]) return end
end

if PandaDB.BDK_A0 then
if Isuseable("湮灭",49020) and ( (Aura_Stack("target","锋锐之霜","PLAYER|HARMFUL")<5 or Aura_time("target","锋锐之霜","PLAYER|HARMFUL")<10)and PowerMax("RUNIC_POWER")-Power("RUNIC_POWER")>25 or Runes()>3 and not IsTalent("冰霜之镰") ) then ShowColor(mainbutton.icon, 6603,Color["湮灭"]);ShowSpell(debutton.icon,Spell["湮灭"]) return end
end

if PandaDB.BDK_A0 then
if Isuseable("湮灭",49020) and ( PowerMax("RUNIC_POWER")-Power("RUNIC_POWER")>25 or Runes()>3 ) then ShowColor(mainbutton.icon, 6603,Color["湮灭"]);ShowSpell(debutton.icon,Spell["湮灭"]) return end
end

if PandaDB.BDK_A3 then
ShowColor(mainbutton.icon, 6603,Color["湮灭"]);ShowSpell(debutton.icon,Spell["湮灭"])
end

end

--bos_pooling
if IsTalent("冰龙吐息") and ((SpellCooldown(152279)==0 and SpellCooldown(51271)<10) or (SpellCooldown(152279)<20 and TTD()<35)) then

if PandaDB.BDK_A1 then
if Isuseable("凛风冲击",49184) and (Aura_time("player","白霜")>0) then ShowColor(mainbutton.icon, 6603,Color["凛风冲击"]);ShowSpell(debutton.icon,Spell["凛风冲击"]) return end
end

if PandaDB.BDK_A0 then
if Isuseable("湮灭",49020) and ((Aura_Stack("target","锋锐之霜","PLAYER|HARMFUL")<5 or Aura_time("target","锋锐之霜","PLAYER|HARMFUL")<10) and PowerMax("RUNIC_POWER")-Power("RUNIC_POWER")>=25 and not IsTalent("冰霜之镰")) then ShowColor(mainbutton.icon, 6603,Color["湮灭"]);ShowSpell(debutton.icon,Spell["湮灭"]) return end
end

if PandaDB.BDK_A0 then
if Isuseable("湮灭",49020) and (PowerMax("RUNIC_POWER")-Power("RUNIC_POWER")>=25) then ShowColor(mainbutton.icon, 6603,Color["湮灭"]);ShowSpell(debutton.icon,Spell["湮灭"]) return end
end

if PandaDB.BDK_A2 then
if Isuseable("冰川突进",194913) and (PowerMax("RUNIC_POWER")-Power("RUNIC_POWER")<20 and active_enemies()>=2 and (SpellCooldown(51271)>5 or PandaDB.BDK_A5 == false or PandaDB.CcdSwitch == false)) then ShowColor(mainbutton.icon, 6603,Color["冰川突进"]);ShowSpell(debutton.icon,Spell["冰川突进"]) return end
end

if PandaDB.BDK_A3 then
if Isuseable("冰霜打击",49143) and ((Aura_Stack("target","锋锐之霜","PLAYER|HARMFUL")<5 or Aura_time("target","锋锐之霜","PLAYER|HARMFUL")<10) and PowerMax("RUNIC_POWER")-Power("RUNIC_POWER")<20 and not IsTalent("冰霜之镰") and (SpellCooldown(51271)>5 or PandaDB.BDK_A5 == false or PandaDB.CcdSwitch == false)) then ShowColor(mainbutton.icon, 6603,Color["冰霜打击"]);ShowSpell(debutton.icon,Spell["冰霜打击"]) return end
end

if PandaDB.BDK_A3 then
if Isuseable("冰霜打击",49143) and (PowerMax("RUNIC_POWER")-Power("RUNIC_POWER")<20 and (SpellCooldown(51271)>5 or PandaDB.BDK_A5 == false or PandaDB.CcdSwitch == false)) then ShowColor(mainbutton.icon, 6603,Color["冰霜打击"]);ShowSpell(debutton.icon,Spell["冰霜打击"]) return end
end

if PandaDB.BDK_C2 then
if Isuseable("冰霜之镰",207230) and ( Aura_time("player","杀戮机器")>0 and PowerMax("RUNIC_POWER")-Power("RUNIC_POWER")>15 and active_enemies()>=2 ) then ShowColor(mainbutton.icon, 6603,Color["冰霜之镰"]);ShowSpell(debutton.icon,Spell["冰霜之镰"]) return end
end

if PandaDB.BDK_C2 then
if Isuseable("冰霜之镰",207230) and (PowerMax("RUNIC_POWER")-Power("RUNIC_POWER")>=35 and active_enemies()>=2) then ShowColor(mainbutton.icon, 6603,Color["冰霜之镰"]);ShowSpell(debutton.icon,Spell["冰霜之镰"]) return end
end

if PandaDB.BDK_A0 then
if Isuseable("湮灭",49020) and ((Aura_Stack("target","锋锐之霜","PLAYER|HARMFUL")<5 or Aura_time("target","锋锐之霜","PLAYER|HARMFUL")<10) and PowerMax("RUNIC_POWER")-Power("RUNIC_POWER")>=35 and not IsTalent("冰霜之镰")) then ShowColor(mainbutton.icon, 6603,Color["湮灭"]);ShowSpell(debutton.icon,Spell["湮灭"]) return end
end

if PandaDB.BDK_A0 then
if Isuseable("湮灭",49020) and (PowerMax("RUNIC_POWER")-Power("RUNIC_POWER")>=35) then ShowColor(mainbutton.icon, 6603,Color["湮灭"]);ShowSpell(debutton.icon,Spell["湮灭"]) return end
end

if PandaDB.BDK_A2 then
if Isuseable("冰川突进",194913) and (PowerMax("RUNIC_POWER")-Power("RUNIC_POWER")<40 and active_enemies()>=2) then ShowColor(mainbutton.icon, 6603,Color["冰川突进"]);ShowSpell(debutton.icon,Spell["冰川突进"]) return end
end


if PandaDB.BDK_A3 then
if Isuseable("冰霜打击",49143) and ((Aura_Stack("target","锋锐之霜","PLAYER|HARMFUL")<5 or Aura_time("target","锋锐之霜","PLAYER|HARMFUL")<10) and PowerMax("RUNIC_POWER")-Power("RUNIC_POWER")<40 and not IsTalent("冰霜之镰")) then ShowColor(mainbutton.icon, 6603,Color["冰霜打击"]);ShowSpell(debutton.icon,Spell["冰霜打击"]) return end
end

if PandaDB.BDK_A3 then
if Isuseable("冰霜打击",49143) and (PowerMax("RUNIC_POWER")-Power("RUNIC_POWER")<40) then ShowColor(mainbutton.icon, 6603,Color["冰霜打击"]);ShowSpell(debutton.icon,Spell["冰霜打击"]) return end
end


end
-------------
----obliteration
if Aura_time("player","冰霜之柱")>0 and IsTalent("湮没") then

if PandaDB.BDK_C1 then
if Isuseable("冷酷严冬",196770) and (IsTalent("风暴汇聚")) then ShowColor(mainbutton.icon, 6603,Color["冷酷严冬"]);ShowSpell(debutton.icon,Spell["冷酷严冬"]) return end
end

if PandaDB.BDK_A0 then
if Isuseable("湮灭",49020) and ((Aura_Stack("target","锋锐之霜","PLAYER|HARMFUL")<5 or Aura_time("target","锋锐之霜","PLAYER|HARMFUL")<10) and not IsTalent("冰霜之镰") and Aura_time("player","白霜")==0 and active_enemies()>=3 ) then ShowColor(mainbutton.icon, 6603,Color["湮灭"]);ShowSpell(debutton.icon,Spell["湮灭"]) return end
end

if PandaDB.BDK_A0 then
if Isuseable("湮灭",49020) and (not IsTalent("冰霜之镰") and Aura_time("player","白霜")==0 and active_enemies()>=3) then ShowColor(mainbutton.icon, 6603,Color["湮灭"]);ShowSpell(debutton.icon,Spell["湮灭"]) return end
end

if PandaDB.BDK_C2 then
if Isuseable("冰霜之镰",207230) and ( (Aura_time("player","杀戮机器")>0 or (Aura_time("player","杀戮机器")>0 and (Last_Spell(1)==49143 or Last_Spell(1)==49184 or Last_Spell(1)==194913 ))) and active_enemies()>=2 ) then ShowColor(mainbutton.icon, 6603,Color["冰霜之镰"]);ShowSpell(debutton.icon,Spell["冰霜之镰"]) return end
end

if PandaDB.BDK_A0 then
if Isuseable("湮灭",49020) and ((Aura_Stack("target","锋锐之霜","PLAYER|HARMFUL")<5 or Aura_time("target","锋锐之霜","PLAYER|HARMFUL")<10) and Aura_time("player","杀戮机器")>0 or (Aura_time("player","杀戮机器")>0 and (Last_Spell(1)==49143 or Last_Spell(1)==49184 or Last_Spell(1)==194913))) then ShowColor(mainbutton.icon, 6603,Color["湮灭"]);ShowSpell(debutton.icon,Spell["湮灭"]) return end
end

if PandaDB.BDK_A0 then
if Isuseable("湮灭",49020) and (Aura_time("player","杀戮机器")>0 or (Aura_time("player","杀戮机器")>0 and (Last_Spell(1)==49143 or Last_Spell(1)==49184 or Last_Spell(1)==194913))) then ShowColor(mainbutton.icon, 6603,Color["湮灭"]);ShowSpell(debutton.icon,Spell["湮灭"]) return end
end

if PandaDB.BDK_A2 then
if Isuseable("冰川突进",194913) and ((Aura_time("player","白霜")==0 or PowerMax("RUNIC_POWER")-Power("RUNIC_POWER")<10) and active_enemies()>=2) then ShowColor(mainbutton.icon, 6603,Color["冰川突进"]);ShowSpell(debutton.icon,Spell["冰川突进"]) return end
end

if PandaDB.BDK_A1 then 
if Isuseable("凛风冲击",49184) and (Aura_time("player","白霜")>0 and active_enemies()>=2) then ShowColor(mainbutton.icon, 6603,Color["凛风冲击"]);ShowSpell(debutton.icon,Spell["凛风冲击"]) return end
end

if PandaDB.BDK_A3 then
if Isuseable("冰霜打击",49143) and ((Aura_Stack("target","锋锐之霜","PLAYER|HARMFUL")<5 or Aura_time("target","锋锐之霜","PLAYER|HARMFUL")<10) and Aura_time("player","白霜")==0 or PowerMax("RUNIC_POWER")-Power("RUNIC_POWER")<10 ) then ShowColor(mainbutton.icon, 6603,Color["冰霜打击"]);ShowSpell(debutton.icon,Spell["冰霜打击"]) return end
end

if PandaDB.BDK_A3 then
if Isuseable("冰霜打击",49143) and (Aura_time("player","白霜")==0 or PowerMax("RUNIC_POWER")-Power("RUNIC_POWER")<10 ) then ShowColor(mainbutton.icon, 6603,Color["冰霜打击"]);ShowSpell(debutton.icon,Spell["冰霜打击"]) return end
end

if PandaDB.BDK_A1 then 
if Isuseable("凛风冲击",49184) and (Aura_time("player","白霜")>0) then ShowColor(mainbutton.icon, 6603,Color["凛风冲击"]);ShowSpell(debutton.icon,Spell["凛风冲击"]) return end
end

if PandaDB.BDK_A0 then
if Isuseable("湮灭",49020) and ((Aura_Stack("target","锋锐之霜","PLAYER|HARMFUL")<5 or Aura_time("target","锋锐之霜","PLAYER|HARMFUL")<10) and not IsTalent("冰霜之镰")) then ShowColor(mainbutton.icon, 6603,Color["湮灭"]);ShowSpell(debutton.icon,Spell["湮灭"]) return end
end

if PandaDB.BDK_A0 then
if Isuseable("湮灭",49020) then ShowColor(mainbutton.icon, 6603,Color["湮灭"]);ShowSpell(debutton.icon,Spell["湮灭"]) return end
end



end


---aoe
if active_enemies()>=2 then

if PandaDB.BDK_C1 then
if Isuseable("冷酷严冬",196770) and (IsTalent("风暴汇聚") or (AzltE("寒冰暴雨")>0  and active_enemies()>=3 and Aura_time("player","白霜")==0)) then ShowColor(mainbutton.icon, 6603,Color["冷酷严冬"]);ShowSpell(debutton.icon,Spell["冷酷严冬"]) return end
end

if PandaDB.BDK_A2 then
if Isuseable("冰川突进",194913) and (IsTalent("冰霜之镰")) then ShowColor(mainbutton.icon, 6603,Color["冰川突进"]);ShowSpell(debutton.icon,Spell["冰川突进"]) return end
end

if PandaDB.BDK_A3 then
if Isuseable("冰霜打击",49143) and ((Aura_Stack("target","锋锐之霜","PLAYER|HARMFUL")<5 or Aura_time("target","锋锐之霜","PLAYER|HARMFUL")<10) and SpellCooldown(196770)<=2*GCD_MAX() and IsTalent("风暴汇聚") and not IsTalent("冰霜之镰")) then ShowColor(mainbutton.icon, 6603,Color["冰霜打击"]);ShowSpell(debutton.icon,Spell["冰霜打击"]) return end
end

if PandaDB.BDK_A3 then
if Isuseable("冰霜打击",49143) and (SpellCooldown(196770)<=2*GCD_MAX() and IsTalent("风暴汇聚")) then ShowColor(mainbutton.icon, 6603,Color["冰霜打击"]);ShowSpell(debutton.icon,Spell["冰霜打击"]) return end
end

if PandaDB.BDK_A1 then
if Isuseable("凛风冲击",49184) and (Aura_time("player","白霜")>0) then ShowColor(mainbutton.icon, 6603,Color["凛风冲击"]);ShowSpell(debutton.icon,Spell["凛风冲击"]) return end
end

if PandaDB.BDK_C2 then
if Isuseable("冰霜之镰",207230) and Aura_time("player","杀戮机器")>0 then ShowColor(mainbutton.icon, 6603,Color["冰霜之镰"]);ShowSpell(debutton.icon,Spell["冰霜之镰"]) return end
end

if PandaDB.BDK_A2 then
if Isuseable("冰川突进",194913) and (PowerMax("RUNIC_POWER")-Power("RUNIC_POWER")<15) then ShowColor(mainbutton.icon, 6603,Color["冰川突进"]);ShowSpell(debutton.icon,Spell["冰川突进"]) return end
end

if PandaDB.BDK_A3 then
if Isuseable("冰霜打击",49143) and ((Aura_Stack("target","锋锐之霜","PLAYER|HARMFUL")<5 or Aura_time("target","锋锐之霜","PLAYER|HARMFUL")<10)  and PowerMax("RUNIC_POWER")-Power("RUNIC_POWER")<15 and not IsTalent("冰霜之镰")) then ShowColor(mainbutton.icon, 6603,Color["冰霜打击"]);ShowSpell(debutton.icon,Spell["冰霜打击"]) return end
end

if PandaDB.BDK_A3 then
if Isuseable("冰霜打击",49143) and (PowerMax("RUNIC_POWER")-Power("RUNIC_POWER")<15 and not IsTalent("冰霜之镰")) then ShowColor(mainbutton.icon, 6603,Color["冰霜打击"]);ShowSpell(debutton.icon,Spell["冰霜打击"]) return end
end


if PandaDB.BDK_C1 then
if Isuseable("冷酷严冬",196770) then ShowColor(mainbutton.icon, 6603,Color["冷酷严冬"]);ShowSpell(debutton.icon,Spell["冷酷严冬"]) return end
end

if PandaDB.BDK_C2 then
if Isuseable("冰霜之镰",207230) then ShowColor(mainbutton.icon, 6603,Color["冰霜之镰"]);ShowSpell(debutton.icon,Spell["冰霜之镰"]) return end
end

if PandaDB.BDK_A0 then
if Isuseable("湮灭",49020) and ((Aura_Stack("target","锋锐之霜","PLAYER|HARMFUL")<5 or Aura_time("target","锋锐之霜","PLAYER|HARMFUL")<10) and PowerMax("RUNIC_POWER")-Power("RUNIC_POWER")>25 and not IsTalent("冰霜之镰") ) then ShowColor(mainbutton.icon, 6603,Color["湮灭"]);ShowSpell(debutton.icon,Spell["湮灭"]) return end
end

if PandaDB.BDK_A0 then
if Isuseable("湮灭",49020) and (PowerMax("RUNIC_POWER")-Power("RUNIC_POWER")>25) then ShowColor(mainbutton.icon, 6603,Color["湮灭"]);ShowSpell(debutton.icon,Spell["湮灭"]) return end
end

if PandaDB.BDK_A2 then
if Isuseable("冰川突进",194913) then ShowColor(mainbutton.icon, 6603,Color["冰川突进"]);ShowSpell(debutton.icon,Spell["冰川突进"]) return end
end



if PandaDB.BDK_A3 then
if Isuseable("冰霜打击",49143) and ((Aura_Stack("target","锋锐之霜","PLAYER|HARMFUL")<5 or Aura_time("target","锋锐之霜","PLAYER|HARMFUL")<10) and not IsTalent("冰霜之镰")) then ShowColor(mainbutton.icon, 6603,Color["冰霜打击"]);ShowSpell(debutton.icon,Spell["冰霜打击"]) return end
end

if PandaDB.BDK_A3 then
if Isuseable("冰霜打击",49143) then ShowColor(mainbutton.icon, 6603,Color["冰霜打击"]);ShowSpell(debutton.icon,Spell["冰霜打击"]) return end
end

if PandaDB.BDK_C4 then
if Isuseable("寒冬号角",57330) then ShowColor(mainbutton.icon, 6603,Color["寒冬号角"]);ShowSpell(debutton.icon,Spell["寒冬号角"]) return end
end

end



---standard

if PandaDB.BDK_C1 then
if Isuseable("冷酷严冬",196770) then ShowColor(mainbutton.icon, 6603,Color["冷酷严冬"]);ShowSpell(debutton.icon,Spell["冷酷严冬"]) return end
end

if PandaDB.BDK_A3 then
if Isuseable("冰霜打击",49143) and (SpellCooldown(196770)<=2*GCD_MAX() and IsTalent("风暴汇聚")) then ShowColor(mainbutton.icon, 6603,Color["冰霜打击"]);ShowSpell(debutton.icon,Spell["冰霜打击"]) return end
end

if PandaDB.BDK_A1 then
if Isuseable("凛风冲击",49184) and (Aura_time("player","白霜")>0) then ShowColor(mainbutton.icon, 6603,Color["凛风冲击"]);ShowSpell(debutton.icon,Spell["凛风冲击"]) return end
end


if PandaDB.BDK_A0 then
if Isuseable("湮灭",49020) and (IsTalent("冰盖") and (Aura_time("player","冰霜之柱")>0 and AzltE("冰霜堡垒")>=2)) then ShowColor(mainbutton.icon, 6603,Color["湮灭"]);ShowSpell(debutton.icon,Spell["湮灭"]) return end
end


if PandaDB.BDK_A0 then
if Isuseable("湮灭",49020) and (Aura_time("player","冰霜脉冲")==0  and IsTalent("冰霜脉冲")) then ShowColor(mainbutton.icon, 6603,Color["湮灭"]);ShowSpell(debutton.icon,Spell["湮灭"]) return end
end

if PandaDB.BDK_A3 then
if Isuseable("冰霜打击",49143) and (PowerMax("RUNIC_POWER")-Power("RUNIC_POWER")<15) then ShowColor(mainbutton.icon, 6603,Color["冰霜打击"]);ShowSpell(debutton.icon,Spell["冰霜打击"]) return end
end

if PandaDB.BDK_C2 then
if Isuseable("冰霜之镰",207230) and (Aura_time("player","杀戮机器")>0) then ShowColor(mainbutton.icon, 6603,Color["冰霜之镰"]);ShowSpell(debutton.icon,Spell["冰霜之镰"]) return end
end



if PandaDB.BDK_A0 then
if Isuseable("湮灭",49020) and (PowerMax("RUNIC_POWER")-Power("RUNIC_POWER")>25) then ShowColor(mainbutton.icon, 6603,Color["湮灭"]);ShowSpell(debutton.icon,Spell["湮灭"]) return end
end

if PandaDB.BDK_A3 then
if Isuseable("冰霜打击",49143) and not IsTalent("冰龙吐息") or (IsTalent("冰龙吐息") and Aura_time("player","冰龙吐息")==0 and (SpellCooldown(152279)>2 or PandaDB.BDK_A6 == false or PandaDB.CcdSwitch == false)) then ShowColor(mainbutton.icon, 6603,Color["冰霜打击"]);ShowSpell(debutton.icon,Spell["冰霜打击"]) return end
end

if PandaDB.BDK_C4 then
if Isuseable("寒冬号角",57330) then ShowColor(mainbutton.icon, 6603,Color["寒冬号角"]);ShowSpell(debutton.icon,Spell["寒冬号角"]) return end
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

local Death_Knight_Frost = Death_Knight_Frost
ns.Death_Knight_Frost = Death_Knight_Frost


