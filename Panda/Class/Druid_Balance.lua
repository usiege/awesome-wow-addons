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
["枭兽形态"] = A_1,
["阳炎之怒"] = A_2,
["星涌术"] = A_3,
["艾露恩的战士"] = A_4,
["激活"] = A_5,
["自然之力"] = A_6,
["化身：艾露恩之眷"] = A_7,
["超凡之盟"] = A_8,
["艾露恩之怒"] = A_9,
["星辰坠落"] = A_0,
["阳炎术"] = C_1,
["月火术"] = C_2,
["新月"] = C_4,
["明月打击"] = C_5,
["星辰耀斑"] = C_6,
["艾泽拉斯之心精华"] = C_8,


}


local function variable_sf_targets()
local value = 4
local op1 = AzltE("奥能脉冲星")>0 
local op2 = IsTalent("星辰领主")
local op3 = AzltE("飞驰流星")>2 and AzltE("奥能脉冲星")>0
local op4 = not IsTalent("双月")

if op1 then
value = value + 1
end

if op2 then
value = value + 1
end

if op3 then
value = value + 1
end

if op4 then
value = value - 1
end

return value

end

local function Druid_Balance()  --更新主图标及技能提示图标

local mainbutton = PDUI.mainbutton
local debutton = PDUI.debutton

if PlayerClass() == "DRUID" and Specialization() == "平衡" then
--if Authorization() then

--开始循环
--自动拾取器

---------------------------------------------------------------------------
--[[                       编辑区                       ]]--
---------------------------------------------------------------------------
if PandaDB.PHD_A1 then
if Isuseable("枭兽形态","枭兽形态") and (Aura_count("Player","枭兽形态")==0) then ShowColor(mainbutton.icon, 6603,Color["枭兽形态"]);ShowSpell(debutton.icon,"枭兽形态") return end
end

if not Combat() then

if PandaDB.PHD_A2 then
if Isuseable("阳炎之怒","阳炎之怒") then ShowColor(mainbutton.icon, 6603,Color["阳炎之怒"]);ShowSpell(debutton.icon,"阳炎之怒") return end
end

if PandaDB.PHD_A3 then
if Isuseable("星涌术","星涌术") then ShowColor(mainbutton.icon, 6603,Color["星涌术"]);ShowSpell(debutton.icon,"星涌术") return end
end

end

if PandaDB.CcdSwitch ~= false then

if PandaDB.PHD_C8 then
if Isuseable("艾泽拉斯守护者","艾泽拉斯守护者") and ((not IsTalent("星辰领主") or Aura_time("Player","星辰领主")>0 ) and Aura_time("Player","化身：艾露恩之眷")==0 and Aura_time("Player","超凡之盟")==0 and Aura_time("target","月火术","PLAYER|HARMFUL")>0 and Aura_time("target","阳炎术","PLAYER|HARMFUL")>0 and (not IsTalent("星辰耀斑") or Aura_time("target","星辰耀斑","PLAYER|HARMFUL")>0)) then ShowColor(mainbutton.icon, 6603,Color["艾泽拉斯之心精华"]);ShowSpell(debutton.icon,"艾泽拉斯守护者") return end
end

if PandaDB.PHD_C8 then
if Isuseable("仇敌之血","仇敌之血") and (SpellCooldown("超凡之盟")>30 or (PandaDB.CcdSwitch == false or PandaDB.PHD_A8 == false or PandaDB.PHD_A7 == false)) then ShowColor(mainbutton.icon, 6603,Color["艾泽拉斯之心精华"]);ShowSpell(debutton.icon,"仇敌之血") return end
end

if PandaDB.PHD_C8 then
if Isuseable("清醒梦境之忆","清醒梦境之忆") and (Aura_time("Player","化身：艾露恩之眷")==0 and Aura_time("Player","超凡之盟")==0 and (Power("LUNAR_POWER")<25 or SpellCooldown("超凡之盟")>30 or (PandaDB.CcdSwitch == false or PandaDB.PHD_A8 == false or PandaDB.PHD_A7 == false)) and Aura_time("target","月火术","PLAYER|HARMFUL")>10 and Aura_time("target","阳炎术","PLAYER|HARMFUL")>10 and (not IsTalent("星辰耀斑") or Aura_time("target","星辰耀斑","PLAYER|HARMFUL")>10)) then ShowColor(mainbutton.icon, 6603,Color["艾泽拉斯之心精华"]);ShowSpell(debutton.icon,"清醒梦境之忆") return end
end

if PandaDB.PHD_C8 then
if Isuseable("净化冲击","净化冲击") then ShowColor(mainbutton.icon, 6603,Color["艾泽拉斯之心精华"]);ShowSpell(debutton.icon,"净化冲击") return end
end

if PandaDB.PHD_C8 then
if Isuseable("空间涟漪","空间涟漪") then ShowColor(mainbutton.icon, 6603,Color["艾泽拉斯之心精华"]);ShowSpell(debutton.icon,"空间涟漪") return end
end

if PandaDB.PHD_C8 then
if Isuseable("火红烈焰","火红烈焰") and ((Aura_time("Player","化身：艾露恩之眷")==0 and Aura_time("Player","超凡之盟")==0 or (SpellCharges("火红烈焰")==2)) and Last_Spell(1)~=295373 and Aura_time("target","火红烈焰","PLAYER|HARMFUL")==0) then ShowColor(mainbutton.icon, 6603,Color["艾泽拉斯之心精华"]);ShowSpell(debutton.icon,"火红烈焰") return end
end

if PandaDB.PHD_C8 then
if Isuseable("不羁之力","不羁之力") and (Aura_time("player","无畏之力")>0 or Aura_Stack("player","无畏之力")<5 and Aura_time("target","月火术","PLAYER|HARMFUL")>0 and Aura_time("target","阳炎术","PLAYER|HARMFUL")>0 and (not IsTalent("星辰耀斑") or Aura_time("target","星辰耀斑","PLAYER|HARMFUL")>0)) then ShowColor(mainbutton.icon, 6603,Color["艾泽拉斯之心精华"]);ShowSpell(debutton.icon,"不羁之力") return end
end

if PandaDB.PHD_C8 then
if Isuseable("世界血脉共鸣","世界血脉共鸣") and (Aura_time("Player","化身：艾露恩之眷")==0 and Aura_time("Player","超凡之盟")==0 and Aura_time("target","月火术","PLAYER|HARMFUL")>0 and Aura_time("target","阳炎术","PLAYER|HARMFUL")>0 and (not IsTalent("星辰耀斑") or Aura_time("target","星辰耀斑","PLAYER|HARMFUL")>0)) then ShowColor(mainbutton.icon, 6603,Color["艾泽拉斯之心精华"]);ShowSpell(debutton.icon,"世界血脉共鸣") return end
end

if PandaDB.PHD_C8 then
if Isuseable("收割火焰","收割火焰") and (Aura_time("Player","化身：艾露恩之眷")==0 and Aura_time("Player","超凡之盟")==0) then ShowColor(mainbutton.icon, 6603,Color["艾泽拉斯之心精华"]);ShowSpell(debutton.icon,"收割火焰") return end
end

if PandaDB.PHD_C8 then
if Isuseable("聚能艾泽里特射线","聚能艾泽里特射线") and ((AzltE("飞驰流星")==0 or Aura_time("Player","化身：艾露恩之眷")==0 and Aura_time("Player","超凡之盟")==0 ) and Aura_time("target","月火术","PLAYER|HARMFUL")>0 and Aura_time("target","阳炎术","PLAYER|HARMFUL")>0 and (not IsTalent("星辰耀斑") or Aura_time("target","星辰耀斑","PLAYER|HARMFUL")>0)) then ShowColor(mainbutton.icon, 6603,Color["艾泽拉斯之心精华"]);ShowSpell(debutton.icon,"聚能艾泽里特射线") return end
end

end

if PandaDB.PHD_A4 then
if Isuseable("艾露恩的战士","艾露恩的战士") then ShowColor(mainbutton.icon, 6603,Color["艾露恩的战士"]);ShowSpell(debutton.icon,"艾露恩的战士") return end
end

if PandaDB.CcdSwitch ~= false then
if PandaDB.PHD_A5 then
if Isuseable("激活","激活") and (AzltE("活跃精神")>0 and (SpellCooldown("超凡之盟")<2 or SpellCooldown("超凡之盟")<12)) then ShowColor(mainbutton.icon, 6603,Color["激活"]);ShowSpell(debutton.icon,"激活") return end
end
end

if PandaDB.PHD_A6 then
if Isuseable("自然之力","自然之力") and ((AzltE("飞驰流星")>0 and Aura_time("Player","化身：艾露恩之眷")==0 and Aura_time("Player","超凡之盟")==0  or AzltE("飞驰流星")==0 and ((Aura_time("Player","化身：艾露恩之眷")>0 or Aura_time("Player","超凡之盟")>0) or SpellCooldown("超凡之盟")>30 or (PandaDB.CcdSwitch == false or PandaDB.PHD_A8 == false or PandaDB.PHD_A7 == false)))) then ShowColor(mainbutton.icon, 6603,Color["自然之力"]);ShowSpell(debutton.icon,"自然之力") return end
end

if PandaDB.CcdSwitch ~= false then

if PandaDB.PHD_A8 then
if Isuseable("超凡之盟","超凡之盟") and (Aura_time("Player","化身：艾露恩之眷")==0 and Aura_time("Player","超凡之盟")==0 and Aura_time("target","月火术","PLAYER|HARMFUL")>0 and Aura_time("target","阳炎术","PLAYER|HARMFUL")>0 and (not IsTalent("星辰耀斑") or Aura_time("target","星辰耀斑","PLAYER|HARMFUL")>0)) then ShowColor(mainbutton.icon, 6603,Color["超凡之盟"]);ShowSpell(debutton.icon,"超凡之盟") return end
end

if PandaDB.PHD_A7 then
if Isuseable("化身：艾露恩之眷","化身：艾露恩之眷") and (Aura_time("Player","化身：艾露恩之眷")==0 and Aura_time("Player","超凡之盟")==0 and Aura_time("target","月火术","PLAYER|HARMFUL")>0 and Aura_time("target","阳炎术","PLAYER|HARMFUL")>0 and (not IsTalent("星辰耀斑") or Aura_time("target","星辰耀斑","PLAYER|HARMFUL")>0)) then ShowColor(mainbutton.icon, 6603,Color["化身：艾露恩之眷"]);ShowSpell(debutton.icon,"化身：艾露恩之眷") return end
end

end

--[[
if PandaDB.PHD_A8 then
if Isuseable("超凡之盟","超凡之盟") and (Aura_time("Player","化身：艾露恩之眷")==0 and Aura_time("Player","超凡之盟")==0 and (not IsTalent("星辰领主") or Aura_time("Player","星辰领主")>0) and (Aura_time("Player","清醒梦境之忆")>0 or ((SpellCooldown("清醒梦境之忆")>20 or not useable("清醒梦境之忆")))) and (Aura_time("Player","清醒梦境之忆")>0) and Aura_time("target","月火术","PLAYER|HARMFUL")>0 and Aura_time("target","阳炎术","PLAYER|HARMFUL")>0 and (not IsTalent("星辰耀斑") or Aura_time("target","星辰耀斑","PLAYER|HARMFUL")>0)) then ShowColor(mainbutton.icon, 6603,Color["超凡之盟"]);ShowSpell(debutton.icon,"超凡之盟") return end
end

if PandaDB.PHD_A7 then
if Isuseable("化身：艾露恩之眷","化身：艾露恩之眷") and (Aura_time("Player","化身：艾露恩之眷")==0 and Aura_time("Player","超凡之盟")==0 and (Aura_time("Player","清醒梦境之忆")>0 or ((SpellCooldown("清醒梦境之忆")>20 or not useable("清醒梦境之忆")))) and (Aura_time("Player","清醒梦境之忆")>0) and Aura_time("target","月火术","PLAYER|HARMFUL")>0 and Aura_time("target","阳炎术","PLAYER|HARMFUL")>0 and (not IsTalent("星辰耀斑") or Aura_time("target","星辰耀斑","PLAYER|HARMFUL")>0)) then ShowColor(mainbutton.icon, 6603,Color["化身：艾露恩之眷"]);ShowSpell(debutton.icon,"化身：艾露恩之眷") return end
end
--]]
if PandaDB.PHD_A9 then
if Isuseable("艾露恩之怒","艾露恩之怒") and (((Aura_time("Player","化身：艾露恩之眷")>0 or Aura_time("Player","超凡之盟")>0) or SpellCooldown("超凡之盟")>30 or (PandaDB.CcdSwitch == false or PandaDB.PHD_A8 == false or PandaDB.PHD_A7 == false))) then ShowColor(mainbutton.icon, 6603,Color["艾露恩之怒"]);ShowSpell(debutton.icon,"艾露恩之怒") return end
end

if PandaDB.PHD_A0 then
if Isuseable("星辰坠落","星辰坠落") and ((PowerMax("LUNAR_POWER")-Power("LUNAR_POWER")<8 or (Aura_Stack("Player","星辰领主")<3 or Aura_time("Player","星辰领主")>=8) and (TTD()+1)*active_enemies()>8/2.5) and active_enemies()>=variable_sf_targets()) then ShowColor(mainbutton.icon, 6603,Color["星辰坠落"]);ShowSpell(debutton.icon,"星辰坠落") return end
end

if PandaDB.PHD_A2 then
if Isuseable("阳炎之怒","阳炎之怒") and (Aura_Stack("Player","日光增效")==3 ) then ShowColor(mainbutton.icon, 6603,Color["阳炎之怒"]);ShowSpell(debutton.icon,"阳炎之怒") return end
end

if PandaDB.PHD_C5 then
if Isuseable("明月打击","明月打击") and ( Aura_Stack("Player","月光增效")==3 ) then ShowColor(mainbutton.icon, 6603,Color["明月打击"]);ShowSpell(debutton.icon,"明月打击") return end
end

if PandaDB.PHD_A3 then
if Isuseable("星涌术","星涌术") and active_enemies()<variable_sf_targets() and (((IsTalent("星辰领主") and (Aura_Stack("Player","星辰领主")<3 or Aura_time("Player","星辰领主")>=5 and Aura_Stack("Player","奥能脉冲星")<8) or not IsTalent("星辰领主") and (Aura_Stack("Player","奥能脉冲星")<8 or (Aura_time("Player","化身：艾露恩之眷")>0 or Aura_time("Player","超凡之盟")>0))) and Aura_Stack("Player","日光增效")<3 and Aura_Stack("Player","月光增效")<3 and Aura_Stack("player","无畏之力")<19 or Aura_time("player","无畏之力")>0 ) and active_enemies()<variable_sf_targets() and (AzltE("飞驰流星")==0 or Aura_time("Player","化身：艾露恩之眷")==0 and Aura_time("Player","超凡之盟")==0 or Last_Spell(1)~=78674) or TTD()<=4 or PowerMax("LUNAR_POWER")-Power("LUNAR_POWER")>8) then ShowColor(mainbutton.icon, 6603,Color["星涌术"]);ShowSpell(debutton.icon,"星涌术") return end
end

if PandaDB.PHD_C1 then
if Isuseable("阳炎术","阳炎术") and ((Aura_time("Player","化身：艾露恩之眷")>0 and Aura_time("Player","化身：艾露恩之眷")<GCD_MAX() or Aura_time("Player","超凡之盟")>0 and Aura_time("Player","超凡之盟")<GCD_MAX()) and AzltE("飞驰流星")>0 and Aura_time("target","月火术","PLAYER|HARMFUL")>Aura_time("target","阳炎术","PLAYER|HARMFUL")) then ShowColor(mainbutton.icon, 6603,Color["阳炎术"]);ShowSpell(debutton.icon,"阳炎术") return end
end

if PandaDB.PHD_C2 then
if Isuseable("月火术","月火术") and ((Aura_time("Player","化身：艾露恩之眷")>0 and Aura_time("Player","化身：艾露恩之眷")<GCD_MAX() or Aura_time("Player","超凡之盟")>0 and Aura_time("Player","超凡之盟")<GCD_MAX()) and AzltE("飞驰流星")>0) then ShowColor(mainbutton.icon, 6603,Color["月火术"]);ShowSpell(debutton.icon,"月火术") return end
end


if PandaDB.PHD_C1 then
if Isuseable("阳炎术","阳炎术") and (Aura_time("target","阳炎术","PLAYER|HARMFUL")<=18*0.3 and math.floor(TTD()/(2*GetHaste()))*active_enemies()>=math.ceil(math.floor(2/active_enemies())*1.5)+2*active_enemies() and (active_enemies()>1) and (AzltE("飞驰流星")==0 or Aura_time("Player","化身：艾露恩之眷")==0 and Aura_time("Player","超凡之盟")==0 or Last_Spell(1)~=93402) and ((Aura_time("Player","化身：艾露恩之眷")>Aura_time("target","阳炎术","PLAYER|HARMFUL") or Aura_time("Player","超凡之盟")>Aura_time("target","阳炎术","PLAYER|HARMFUL")) or (Aura_time("Player","化身：艾露恩之眷")==0 and Aura_time("Player","超凡之盟")==0))) then ShowColor(mainbutton.icon, 6603,Color["阳炎术"]);ShowSpell(debutton.icon,"阳炎术") return end
end

if PandaDB.PHD_C2 then
if Isuseable("月火术","月火术") and (Aura_time("target","月火术","PLAYER|HARMFUL")<=22*0.3 and math.floor(TTD()/(2*GetHaste()))*active_enemies()>=6 and (AzltE("飞驰流星")==0 or Aura_time("Player","化身：艾露恩之眷")==0 and Aura_time("Player","超凡之盟")==0 or Last_Spell(1)~=8921) and ((Aura_time("Player","化身：艾露恩之眷")>Aura_time("target","月火术","PLAYER|HARMFUL") or Aura_time("Player","超凡之盟")>Aura_time("target","月火术","PLAYER|HARMFUL")) or (Aura_time("Player","化身：艾露恩之眷")==0 and Aura_time("Player","超凡之盟")==0))) then ShowColor(mainbutton.icon, 6603,Color["月火术"]);ShowSpell(debutton.icon,"月火术") return end
end


if PandaDB.PHD_C2 then
if Isuseable("月火术","月火术") and (Aura_time("target","月火术","PLAYER|HARMFUL")<=22*0.3 ) then ShowColor(mainbutton.icon, 6603,Color["月火术"]);ShowSpell(debutton.icon,"月火术") return end
end

if PandaDB.PHD_C1 then
if Isuseable("阳炎术","阳炎术") and (Aura_time("target","阳炎术","PLAYER|HARMFUL")<=18*0.3 ) then ShowColor(mainbutton.icon, 6603,Color["阳炎术"]);ShowSpell(debutton.icon,"阳炎术") return end
end

if PandaDB.PHD_C6 then
if Isuseable("星辰耀斑","星辰耀斑") and (Aura_time("target","星辰耀斑","PLAYER|HARMFUL")<=24*0.3 and math.floor(TTD()/(2*GetHaste()))>=5 and (AzltE("飞驰流星")==0 or Aura_time("Player","化身：艾露恩之眷")==0 and Aura_time("Player","超凡之盟")==0 or Last_Spell(1)~=202347 )) then ShowColor(mainbutton.icon, 6603,Color["星辰耀斑"]);ShowSpell(debutton.icon,"星辰耀斑") return end
end

if PandaDB.PHD_C4 then
if Isuseable("新月","新月") and (PowerMax("LUNAR_POWER")-Power("LUNAR_POWER")>10) then ShowColor(mainbutton.icon, 6603,Color["新月"]);ShowSpell(debutton.icon,"新月") return end
end

if PandaDB.PHD_C4 then
if Isuseable("半月","半月") and (PowerMax("LUNAR_POWER")-Power("LUNAR_POWER")>20) then ShowColor(mainbutton.icon, 6603,Color["新月"]);ShowSpell(debutton.icon,"半月") return end
end

if PandaDB.PHD_C4 then
if Isuseable("满月","满月") and (PowerMax("LUNAR_POWER")-Power("LUNAR_POWER")>40) then ShowColor(mainbutton.icon, 6603,Color["新月"]);ShowSpell(debutton.icon,"满月") return end
end

if PandaDB.PHD_C5 then
if Isuseable("明月打击","明月打击") and (Aura_Stack("Player","日光增效")<3 and (PowerMax("LUNAR_POWER")-Power("LUNAR_POWER")<12 or Aura_Stack("Player","月光增效")==3) and ((Aura_time("Player","艾露恩的战士")>0 or Aura_Stack("Player","月光增效")>0 or active_enemies()>=2 and Aura_Stack("Player","日光增效")==0) and (AzltE("飞驰流星")==0 or Aura_time("Player","化身：艾露恩之眷")==0 and Aura_time("Player","超凡之盟")==0) or AzltE("飞驰流星")>0 and (Aura_time("Player","化身：艾露恩之眷")>0 or Aura_time("Player","超凡之盟")>0) and Last_Spell(1)==190984)) then ShowColor(mainbutton.icon, 6603,Color["明月打击"]);ShowSpell(debutton.icon,"明月打击") return end
end

if PandaDB.PHD_C5 then
if Isuseable("明月打击","明月打击") and ( Aura_Stack("Player","月光增效")>0 or active_enemies()>=variable_sf_targets()) then ShowColor(mainbutton.icon, 6603,Color["明月打击"]);ShowSpell(debutton.icon,"明月打击") return end
end

if PandaDB.PHD_A2 then
if Isuseable("阳炎之怒","阳炎之怒") and (active_enemies()>=variable_sf_targets() and Aura_Stack("Player","日光增效")>0 and Aura_Stack("Player","月光增效")==0) then ShowColor(mainbutton.icon, 6603,Color["阳炎之怒"]);ShowSpell(debutton.icon,"阳炎之怒") return end
end

if PandaDB.PHD_A2 then
if Isuseable("阳炎之怒","阳炎之怒") and active_enemies()<variable_sf_targets() and (AzltE("飞驰流星")<3 or Aura_time("Player","化身：艾露恩之眷")==0 and Aura_time("Player","超凡之盟")==0 or Last_Spell(1)~=190984) then ShowColor(mainbutton.icon, 6603,Color["阳炎之怒"]);ShowSpell(debutton.icon,"阳炎之怒") return end
end

if PandaDB.PHD_C1 then
if Isuseable("阳炎术","阳炎术") then ShowColor(mainbutton.icon, 6603,Color["阳炎术"]);ShowSpell(debutton.icon,"阳炎术") return end
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

local Druid_Balance = Druid_Balance
ns.Druid_Balance = Druid_Balance


