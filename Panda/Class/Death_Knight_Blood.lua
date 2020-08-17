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
["符文刃舞"] = A_1,
["墓石"] = A_2,
["灵界打击"] = A_3,
["饮血者"] = A_4,
["骨髓分裂"] = A_5,
["血液沸腾"] = A_6,
["白骨风暴"] = A_7,
["枯萎凋零"] = A_8,
["符文打击"] = A_9,
["心脏打击"] = A_0,
["吞噬"] = C_1,
["死神的抚摩"] = C_2,

["艾泽拉斯之心精华"] = C_8,
}

local Spell = {
["符文刃舞"] = 49028,
["墓石"] = 219809,
["灵界打击"] = 49998,
["饮血者"] = 206931,
["骨髓分裂"] = 195182,
["血液沸腾"] = 50842,
["白骨风暴"] = 194844,
["枯萎凋零"] = 43265,
["符文打击"] = 210764,
["心脏打击"] = 206930,
["吞噬"] = 274156,
["死神的抚摩"] = 195292,
["远程拾取器"] = 175039,
["艾泽拉斯之心精华"] = 296208,
} 

local function Death_Knight_Blood()  --更新主图标及技能提示图标

local mainbutton = PDUI.mainbutton
local debutton = PDUI.debutton

if PlayerClass() == "DEATHKNIGHT" and Specialization() == "鲜血" then
--if Authorization() then

--if  then ShowColor(mainbutton.icon, 6603,Color["猛击"]);ShowSpell(debutton.icon,Spell["猛击"]) return end

--开始循环
--自动拾取器

---------------------------------------------------------------------------
--[[                       编辑区                       ]]--
---------------------------------------------------------------------------
--最高优先级

if Isuseable('死神的抚摩',195292) and PandaDB.DKT_C2 ~= false  and UnitRange("TARGET")>15 and Aura_time("target","血之疫病","PLAYER|HARMFUL")<3 then ShowColor(mainbutton.icon, 6603,Color["死神的抚摩"]);ShowSpell(debutton.icon,Spell["死神的抚摩"]) return end

if Isuseable('灵界打击',49998) and PandaDB.DKT_A3 ~= false and (HealthPercent("player")<=30 and (not IsTalent("白骨风暴") or SpellCooldown(194844)>1 or  PandaDB.DKT_A7 == false or PandaDB.CcdSwitch == false)) then ShowColor(mainbutton.icon, 6603,Color["灵界打击"]);ShowSpell(debutton.icon,Spell["灵界打击"]) return end
------

if PandaDB.CcdSwitch ~= false then
--essences
if PandaDB.DKT_C8 then
if Isuseable("仇敌之血","仇敌之血") then ShowColor(mainbutton.icon, 6603,Color["艾泽拉斯之心精华"]);ShowSpell(debutton.icon,Spell["艾泽拉斯之心精华"]) return end
end

if PandaDB.DKT_C8 then
if Isuseable("艾泽拉斯守护者","艾泽拉斯守护者") then ShowColor(mainbutton.icon, 6603,Color["艾泽拉斯之心精华"]);ShowSpell(debutton.icon,Spell["艾泽拉斯之心精华"]) return end
end

if PandaDB.DKT_C8 then
if Isuseable("不羁之力","不羁之力") then ShowColor(mainbutton.icon, 6603,Color["艾泽拉斯之心精华"]);ShowSpell(debutton.icon,Spell["艾泽拉斯之心精华"]) return end
end

if PandaDB.DKT_C8 then
if Isuseable("聚能艾泽里特射线","聚能艾泽里特射线") and Useing_spell("player") ~= 295258 then ShowColor(mainbutton.icon, 6603,Color["艾泽拉斯之心精华"]);ShowSpell(debutton.icon,Spell["艾泽拉斯之心精华"]) return end
end

if PandaDB.DKT_C8 then
if Isuseable("火红烈焰","火红烈焰") then ShowColor(mainbutton.icon, 6603,Color["艾泽拉斯之心精华"]);ShowSpell(debutton.icon,Spell["艾泽拉斯之心精华"]) return end
end

if PandaDB.DKT_C8 then
if Isuseable("净化冲击","净化冲击") then ShowColor(mainbutton.icon, 6603,Color["艾泽拉斯之心精华"]);ShowSpell(debutton.icon,Spell["艾泽拉斯之心精华"]) return end
end

if PandaDB.DKT_C8 then
if Isuseable("世界血脉共鸣","世界血脉共鸣") then ShowColor(mainbutton.icon, 6603,Color["艾泽拉斯之心精华"]);ShowSpell(debutton.icon,Spell["艾泽拉斯之心精华"]) return end
end

if PandaDB.DKT_C8 then
if Isuseable("空间涟漪","空间涟漪") then ShowColor(mainbutton.icon, 6603,Color["艾泽拉斯之心精华"]);ShowSpell(debutton.icon,Spell["艾泽拉斯之心精华"]) return end
end

if PandaDB.DKT_C8 then
if Isuseable("清醒梦境之忆","清醒梦境之忆") then ShowColor(mainbutton.icon, 6603,Color["艾泽拉斯之心精华"]);ShowSpell(debutton.icon,Spell["艾泽拉斯之心精华"]) return end
end

if PandaDB.DKT_C8 then
if Isuseable("收割火焰","收割火焰")  then ShowColor(mainbutton.icon, 6603,Color["艾泽拉斯之心精华"]);ShowSpell(debutton.icon,Spell["艾泽拉斯之心精华"]) return end
end

if PandaDB.DKT_C8 then
if Isuseable("生命缚誓者之祈","生命缚誓者之祈")  then ShowColor(mainbutton.icon, 6603,Color["艾泽拉斯之心精华"]);ShowSpell(debutton.icon,Spell["艾泽拉斯之心精华"]) return end
end

if PandaDB.DKT_C8 then
if Isuseable("救世之魂","救世之魂")  then ShowColor(mainbutton.icon, 6603,Color["艾泽拉斯之心精华"]);ShowSpell(debutton.icon,Spell["艾泽拉斯之心精华"]) return end
end

if PandaDB.DKT_C8 then
if Isuseable("守护屏障","守护屏障")  then ShowColor(mainbutton.icon, 6603,Color["艾泽拉斯之心精华"]);ShowSpell(debutton.icon,Spell["艾泽拉斯之心精华"]) return end
end

if PandaDB.DKT_C8 then
if Isuseable("补充能量","补充能量")  then ShowColor(mainbutton.icon, 6603,Color["艾泽拉斯之心精华"]);ShowSpell(debutton.icon,Spell["艾泽拉斯之心精华"]) return end
end

if PandaDB.DKT_C8 then
if Isuseable("静滞","静滞")  then ShowColor(mainbutton.icon, 6603,Color["艾泽拉斯之心精华"]);ShowSpell(debutton.icon,Spell["艾泽拉斯之心精华"]) return end
end

if PandaDB.DKT_C8 then
if Isuseable("法力过载","法力过载")  then ShowColor(mainbutton.icon, 6603,Color["艾泽拉斯之心精华"]);ShowSpell(debutton.icon,Spell["艾泽拉斯之心精华"]) return end
end

if PandaDB.DKT_C8 then
if Isuseable("活力导管","活力导管")  then ShowColor(mainbutton.icon, 6603,Color["艾泽拉斯之心精华"]);ShowSpell(debutton.icon,Spell["艾泽拉斯之心精华"]) return end
end

if PandaDB.DKT_C8 then
if Isuseable("爆燃之拥","爆燃之拥")  then ShowColor(mainbutton.icon, 6603,Color["艾泽拉斯之心精华"]);ShowSpell(debutton.icon,Spell["艾泽拉斯之心精华"]) return end
end

if PandaDB.DKT_C8 then
if Isuseable("光荣时刻","光荣时刻")  then ShowColor(mainbutton.icon, 6603,Color["艾泽拉斯之心精华"]);ShowSpell(debutton.icon,Spell["艾泽拉斯之心精华"]) return end
end

if PandaDB.DKT_C8 then
if Isuseable("深渊之护","深渊之护")  then ShowColor(mainbutton.icon, 6603,Color["艾泽拉斯之心精华"]);ShowSpell(debutton.icon,Spell["艾泽拉斯之心精华"]) return end
end

if PandaDB.DKT_C8 then
if Isuseable("艾泽拉斯的不朽赐福","艾泽拉斯的不朽赐福")  then ShowColor(mainbutton.icon, 6603,Color["艾泽拉斯之心精华"]);ShowSpell(debutton.icon,Spell["艾泽拉斯之心精华"]) return end
end

if PandaDB.DKT_C8 then
if Isuseable("强化虚无屏障","强化虚无屏障")  then ShowColor(mainbutton.icon, 6603,Color["艾泽拉斯之心精华"]);ShowSpell(debutton.icon,Spell["艾泽拉斯之心精华"]) return end
end

end
-------------

if Isuseable("符文刃舞",49028) and PandaDB.DKT_A1 ~= false and PandaDB.CcdSwitch ~= false and (not IsTalent("饮血者") or SpellCooldown(206931)>0) then ShowColor(mainbutton.icon, 6603,Color["符文刃舞"]);ShowSpell(debutton.icon,Spell["符文刃舞"]) return end

if Isuseable("墓石",219809) and PandaDB.DKT_A2 ~= false and PandaDB.CcdSwitch ~= false and (Aura_Stack("player","白骨之盾","PLAYER|HELPFUL")>=7) then ShowColor(mainbutton.icon, 6603,Color["墓石"]);ShowSpell(debutton.icon,Spell["墓石"]) return end
----standard
if Isuseable('灵界打击',49998) and PandaDB.DKT_A3 ~= false and ((PowerMax("RUNIC_POWER") - Power("RUNIC_POWER")<=10) and (not IsTalent("白骨风暴") or SpellCooldown(194844)>1 or  PandaDB.DKT_A7 == false or  PandaDB.CcdSwitch == false)) then ShowColor(mainbutton.icon, 6603,Color["灵界打击"]);ShowSpell(debutton.icon,Spell["灵界打击"]) return end

if Isuseable('饮血者',206931) and PandaDB.DKT_A4 ~= false and (Aura_time("player","符文刃舞","PLAYER|HELPFUL")==0) then ShowColor(mainbutton.icon, 6603,Color["饮血者"]);ShowSpell(debutton.icon,Spell["饮血者"]) return end

if Isuseable('骨髓分裂',195182) and PandaDB.DKT_A5 ~= false and ( (Aura_Stack("player","白骨之盾","PLAYER|HELPFUL")<=6 or  Aura_time("player","白骨之盾","PLAYER|HELPFUL")<3) and  (PowerMax("RUNIC_POWER") - Power("RUNIC_POWER"))>20  ) then ShowColor(mainbutton.icon, 6603,Color["骨髓分裂"]);ShowSpell(debutton.icon,Spell["骨髓分裂"]) return end

if Isuseable('白骨风暴',194844) and PandaDB.DKT_A7 ~= false and PandaDB.CcdSwitch ~= false and (Power("RUNIC_POWER")>=100 and Aura_time("player","符文刃舞","PLAYER|HELPFUL")==0) then ShowColor(mainbutton.icon, 6603,Color["白骨风暴"]);ShowSpell(debutton.icon,Spell["白骨风暴"]) return end

if Isuseable('血液沸腾',50842) and PandaDB.DKT_A6 ~= false and ( SpellallCharges(50842)>=1.8 and (Aura_Stack("player","鲜血禁闭","PLAYER|HELPFUL")<=(5-active_enemies()) or active_enemies()>2)) then ShowColor(mainbutton.icon, 6603,Color["血液沸腾"]);ShowSpell(debutton.icon,Spell["血液沸腾"]) return end

if Isuseable('骨髓分裂',195182) and PandaDB.DKT_A5 ~= false and (Aura_Stack("player","白骨之盾","PLAYER|HELPFUL")<5 and IsTalent("埋骨之所") and (PowerMax("RUNIC_POWER") - Power("RUNIC_POWER"))>=15) then ShowColor(mainbutton.icon, 6603,Color["骨髓分裂"]);ShowSpell(debutton.icon,Spell["骨髓分裂"]) return end


if Isuseable('灵界打击',49998) and PandaDB.DKT_A3 ~= false and (PowerMax("RUNIC_POWER") - Power("RUNIC_POWER")<=15) then ShowColor(mainbutton.icon, 6603,Color["灵界打击"]);ShowSpell(debutton.icon,Spell["灵界打击"]) return end


if Isuseable('枯萎凋零',43265) and PandaDB.DKT_A8 ~= false and (active_enemies()>=3) then ShowColor(mainbutton.icon, 6603,Color["枯萎凋零"]);ShowSpell(debutton.icon,Spell["枯萎凋零"]) return end


if Isuseable('符文打击',210764) and PandaDB.DKT_A9 ~= false and ((SpellallCharges(210764)>=1.8 or Aura_time("player","符文刃舞","PLAYER|HELPFUL")>0) ) then ShowColor(mainbutton.icon, 6603,Color["符文打击"]);ShowSpell(debutton.icon,Spell["符文打击"]) return end

if Isuseable('心脏打击',206930) and PandaDB.DKT_A0 ~= false and (Aura_time("player","符文刃舞","PLAYER|HELPFUL")>0 ) then ShowColor(mainbutton.icon, 6603,Color["心脏打击"]);ShowSpell(debutton.icon,Spell["心脏打击"]) return end

if Isuseable('血液沸腾',50842) and PandaDB.DKT_A6 ~= false and (Aura_time("player","符文刃舞","PLAYER|HELPFUL")>0 ) then ShowColor(mainbutton.icon, 6603,Color["血液沸腾"]);ShowSpell(debutton.icon,Spell["血液沸腾"]) return end

if Isuseable('枯萎凋零',43265) and PandaDB.DKT_A8 ~= false and (Aura_time("player","赤色天灾","PLAYER|HELPFUL")>0 or IsTalent("迅速凋零") or active_enemies()>=2 ) then ShowColor(mainbutton.icon, 6603,Color["枯萎凋零"]);ShowSpell(debutton.icon,Spell["枯萎凋零"]) return end

if Isuseable('吞噬',274156) and PandaDB.DKT_C1 ~= false then ShowColor(mainbutton.icon, 6603,Color["吞噬"]);ShowSpell(debutton.icon,Spell["吞噬"]) return end

if Isuseable('血液沸腾',50842) and PandaDB.DKT_A6 ~= false then ShowColor(mainbutton.icon, 6603,Color["血液沸腾"]);ShowSpell(debutton.icon,Spell["血液沸腾"]) return end

if Isuseable('心脏打击',206930) and PandaDB.DKT_A0 ~= false and (Aura_Stack("player","白骨之盾","PLAYER|HELPFUL")>6) then ShowColor(mainbutton.icon, 6603,Color["心脏打击"]);ShowSpell(debutton.icon,Spell["心脏打击"]) return end

if Isuseable('符文打击',210764) and PandaDB.DKT_A9 ~= false and Runes()<5 then ShowColor(mainbutton.icon, 6603,Color["符文打击"]);ShowSpell(debutton.icon,Spell["符文打击"]) return end

if Isuseable('心脏打击',206930) and PandaDB.DKT_A0 ~= false then ShowColor(mainbutton.icon, 6603,Color["心脏打击"]);ShowSpell(debutton.icon,Spell["心脏打击"]) return end



---------------------------------------------------------------------------
--[[                       编辑区                       ]]--
---------------------------------------------------------------------------

ShowColor(mainbutton.icon, 6603,311923);ShowSpell(debutton.icon, 311923)	

--elseif not Authorization() then 
--print("|cffffe00a★Panda★:【|r|c00FF68CC 插件未激活 联系QQ:398371778 |r|cffffe00a】|r")

--end


end


end

local Death_Knight_Blood = Death_Knight_Blood
ns.Death_Knight_Blood = Death_Knight_Blood


