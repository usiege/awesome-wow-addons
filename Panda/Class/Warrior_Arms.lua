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
["剑刃风暴"] = A_1,
["巨人打击"] = A_2,
["碎颅打击"] = A_3,
["撕裂"] = A_4,
["战斗怒吼"] = A_5,
["压制"] = A_6,
["斩杀"] = A_7,
["旋风斩"] = A_8,
["横扫攻击"] = A_9,
["猛击"] = A_0,
["致死打击"] = C_1,
["灭战者"] = C_2,

["顺劈斩"] = C_4,
["天神下凡"] = C_5,
["致命平静"] = C_6,
["破坏者"] = C_7,
["艾泽拉斯之心精华"] = C_8,
["乘胜追击"] = C_9,
}

local Spell = {
["剑刃风暴"] = 227847,
["巨人打击"] = 167105,
["碎颅打击"] = 260643,
["撕裂"] = 772,
["战斗怒吼"] = 6673,
["压制"] = 7384,
["斩杀"] = 163201,
["旋风斩"] = 1680,
["横扫攻击"] = 260708,
["猛击"] = 1464,
["致死打击"] = 12294,
["灭战者"] = 262161,
["顺劈斩"] = 845,
["天神下凡"] = 107574,
["致命平静"] = 262228,
["破坏者"] = 152277,
["艾泽拉斯之心精华"] = 296208,
["乘胜追击"] = 34428,
} 


local function Zhanshachuli()
if (IsTalent('屠杀') and HealthPercent("target")<=35 or HealthPercent("target")<=20) then return true else return false end
end


local function Warrior_Arms()  --更新主图标及技能提示图标

local mainbutton = PDUI.mainbutton
local debutton = PDUI.debutton

if PlayerClass() == "WARRIOR" and Specialization() == "武器" then
--if Authorization() then

--开始循环
--自动拾取器

---------------------------------------------------------------------------
--[[                       编辑区                       ]]--
---------------------------------------------------------------------------
if PandaDB.WQZ_A5 ~= false  then
if Isuseable("战斗怒吼",6673) and (Aura_time("player","战斗怒吼")<1 and time_x(0)) then ShowColor(mainbutton.icon, 6603,Color["战斗怒吼"]);ShowSpell(debutton.icon,Spell["战斗怒吼"]) return end
end

if Isuseable("乘胜追击",34428) and PandaDB.WQZ_C9 ~= false  and not IsTalent('胜利在望') and HealthPercent("player")<=80 then ShowColor(mainbutton.icon, 6603,Color["乘胜追击"]);ShowSpell(debutton.icon,Spell["乘胜追击"]) return end
if Isuseable("胜利在望",202168) and PandaDB.WQZ_C9 ~= false  and IsTalent('胜利在望') and HealthPercent("player")<=80  then ShowColor(mainbutton.icon, 6603,Color["乘胜追击"]);ShowSpell(debutton.icon,Spell["乘胜追击"]) return end

--特殊处理
if Teshuchuli() then
if Isuseable("猛击",1464) and PandaDB.WQZ_A0 ~= false  then ShowColor(mainbutton.icon, 6603,Color["猛击"]);ShowSpell(debutton.icon,Spell["猛击"]) return end
end

--大招
if PandaDB.CcdSwitch ~= false  then

if Isuseable('天神下凡',107574) and PandaDB.WQZ_C5 ~= false  and ( SpellCooldown(167105)<8 and (IsTalent('灭战者') and SpellCooldown(262161)<8  ) ) then ShowColor(mainbutton.icon, 6603,Color["天神下凡"]);ShowSpell(debutton.icon,Spell["天神下凡"]) return end

--essences
if PandaDB.WQZ_C8 then
if Isuseable("仇敌之血","仇敌之血") then ShowColor(mainbutton.icon, 6603,Color["艾泽拉斯之心精华"]);ShowSpell(debutton.icon,Spell["艾泽拉斯之心精华"]) return end
end

if PandaDB.WQZ_C8 then
if Isuseable("艾泽拉斯守护者","艾泽拉斯守护者") then ShowColor(mainbutton.icon, 6603,Color["艾泽拉斯之心精华"]);ShowSpell(debutton.icon,Spell["艾泽拉斯之心精华"]) return end
end

if PandaDB.WQZ_C8 then
if Isuseable("不羁之力","不羁之力") then ShowColor(mainbutton.icon, 6603,Color["艾泽拉斯之心精华"]);ShowSpell(debutton.icon,Spell["艾泽拉斯之心精华"]) return end
end

if PandaDB.WQZ_C8 then
if Isuseable("聚能艾泽里特射线","聚能艾泽里特射线") and Useing_spell("player") ~= 295258 then ShowColor(mainbutton.icon, 6603,Color["艾泽拉斯之心精华"]);ShowSpell(debutton.icon,Spell["艾泽拉斯之心精华"]) return end
end

if PandaDB.WQZ_C8 then
if Isuseable("火红烈焰","火红烈焰") then ShowColor(mainbutton.icon, 6603,Color["艾泽拉斯之心精华"]);ShowSpell(debutton.icon,Spell["艾泽拉斯之心精华"]) return end
end

if PandaDB.WQZ_C8 then
if Isuseable("净化冲击","净化冲击") then ShowColor(mainbutton.icon, 6603,Color["艾泽拉斯之心精华"]);ShowSpell(debutton.icon,Spell["艾泽拉斯之心精华"]) return end
end

if PandaDB.WQZ_C8 then
if Isuseable("世界血脉共鸣","世界血脉共鸣") then ShowColor(mainbutton.icon, 6603,Color["艾泽拉斯之心精华"]);ShowSpell(debutton.icon,Spell["艾泽拉斯之心精华"]) return end
end

if PandaDB.WQZ_C8 then
if Isuseable("空间涟漪","空间涟漪") then ShowColor(mainbutton.icon, 6603,Color["艾泽拉斯之心精华"]);ShowSpell(debutton.icon,Spell["艾泽拉斯之心精华"]) return end
end

if PandaDB.WQZ_C8 then
if Isuseable("清醒梦境之忆","清醒梦境之忆") then ShowColor(mainbutton.icon, 6603,Color["艾泽拉斯之心精华"]);ShowSpell(debutton.icon,Spell["艾泽拉斯之心精华"]) return end
end

if PandaDB.WQZ_C8 then
if Isuseable("收割火焰","收割火焰")  then ShowColor(mainbutton.icon, 6603,Color["艾泽拉斯之心精华"]);ShowSpell(debutton.icon,Spell["艾泽拉斯之心精华"]) return end
end

if PandaDB.WQZ_C8 then
if Isuseable("生命缚誓者之祈","生命缚誓者之祈")  then ShowColor(mainbutton.icon, 6603,Color["艾泽拉斯之心精华"]);ShowSpell(debutton.icon,Spell["艾泽拉斯之心精华"]) return end
end

if PandaDB.WQZ_C8 then
if Isuseable("救世之魂","救世之魂")  then ShowColor(mainbutton.icon, 6603,Color["艾泽拉斯之心精华"]);ShowSpell(debutton.icon,Spell["艾泽拉斯之心精华"]) return end
end

if PandaDB.WQZ_C8 then
if Isuseable("守护屏障","守护屏障")  then ShowColor(mainbutton.icon, 6603,Color["艾泽拉斯之心精华"]);ShowSpell(debutton.icon,Spell["艾泽拉斯之心精华"]) return end
end

if PandaDB.WQZ_C8 then
if Isuseable("补充能量","补充能量")  then ShowColor(mainbutton.icon, 6603,Color["艾泽拉斯之心精华"]);ShowSpell(debutton.icon,Spell["艾泽拉斯之心精华"]) return end
end

if PandaDB.WQZ_C8 then
if Isuseable("静滞","静滞")  then ShowColor(mainbutton.icon, 6603,Color["艾泽拉斯之心精华"]);ShowSpell(debutton.icon,Spell["艾泽拉斯之心精华"]) return end
end

if PandaDB.WQZ_C8 then
if Isuseable("法力过载","法力过载")  then ShowColor(mainbutton.icon, 6603,Color["艾泽拉斯之心精华"]);ShowSpell(debutton.icon,Spell["艾泽拉斯之心精华"]) return end
end

if PandaDB.WQZ_C8 then
if Isuseable("活力导管","活力导管")  then ShowColor(mainbutton.icon, 6603,Color["艾泽拉斯之心精华"]);ShowSpell(debutton.icon,Spell["艾泽拉斯之心精华"]) return end
end

if PandaDB.WQZ_C8 then
if Isuseable("爆燃之拥","爆燃之拥")  then ShowColor(mainbutton.icon, 6603,Color["艾泽拉斯之心精华"]);ShowSpell(debutton.icon,Spell["艾泽拉斯之心精华"]) return end
end

if PandaDB.WQZ_C8 then
if Isuseable("光荣时刻","光荣时刻")  then ShowColor(mainbutton.icon, 6603,Color["艾泽拉斯之心精华"]);ShowSpell(debutton.icon,Spell["艾泽拉斯之心精华"]) return end
end

if PandaDB.WQZ_C8 then
if Isuseable("深渊之护","深渊之护")  then ShowColor(mainbutton.icon, 6603,Color["艾泽拉斯之心精华"]);ShowSpell(debutton.icon,Spell["艾泽拉斯之心精华"]) return end
end

if PandaDB.WQZ_C8 then
if Isuseable("艾泽拉斯的不朽赐福","艾泽拉斯的不朽赐福")  then ShowColor(mainbutton.icon, 6603,Color["艾泽拉斯之心精华"]);ShowSpell(debutton.icon,Spell["艾泽拉斯之心精华"]) return end
end

if PandaDB.WQZ_C8 then
if Isuseable("强化虚无屏障","强化虚无屏障")  then ShowColor(mainbutton.icon, 6603,Color["艾泽拉斯之心精华"]);ShowSpell(debutton.icon,Spell["艾泽拉斯之心精华"]) return end
end

end


if Isuseable('横扫攻击',260708) and PandaDB.WQZ_A9 ~= false  and (active_enemies()>=2 and (SpellCooldown(262161)>10 or SpellCooldown(167105)>8 or AzltE('力量的考验')>1)) then ShowColor(mainbutton.icon, 6603,Color["横扫攻击"]);ShowSpell(debutton.icon,Spell["横扫攻击"]) return end
--------ADD----------- 
if Isuseable("撕裂",772) and PandaDB.WQZ_A4 ~= false   and (Aura_time("target","撕裂","PLAYER|HARMFUL")<0.3*12 and (active_enemies()<=1 or Aura_time("player","横扫攻击","PLAYER|HELPFUL")>0) ) then ShowColor(mainbutton.icon, 6603,Color["撕裂"]);ShowSpell(debutton.icon,Spell["撕裂"]) return end
if Isuseable("碎颅打击",260643) and PandaDB.WQZ_A3 ~= false  and (Power("RAGE")<60 and (not IsTalent('致命平静') and Aura_time('player','清醒梦境之忆','PLAYER|HELPFUL')==0) )  then ShowColor(mainbutton.icon, 6603,Color["碎颅打击"]);ShowSpell(debutton.icon,Spell["碎颅打击"]) return end
if Isuseable("灭战者",262161) and PandaDB.WQZ_C2 ~= false  and IsTalent('灭战者') then ShowColor(mainbutton.icon, 6603,Color["灭战者"]);ShowSpell(debutton.icon,Spell["灭战者"]) return end
if Isuseable("巨人打击",167105) and PandaDB.WQZ_A2 ~= false  and not IsTalent('灭战者') then ShowColor(mainbutton.icon, 6603,Color["巨人打击"]);ShowSpell(debutton.icon,Spell["巨人打击"]) return end
--6目标以上
if active_enemies()>=6 then
if Isuseable("碎颅打击",260643) and PandaDB.WQZ_A3 ~= false   and (Power("RAGE")<60 and (SpellCooldown(262228)>3 or not IsTalent('致命平静')) ) then ShowColor(mainbutton.icon, 6603,Color["碎颅打击"]);ShowSpell(debutton.icon,Spell["碎颅打击"]) return end
if Isuseable("致命平静",262228) and PandaDB.WQZ_C6 ~= false  and PandaDB.CcdSwitch ~= false  and (((SpellCooldown(227847)>6 or PandaDB.WQZ_A1 == false  ) or IsTalent('破坏者') and SpellCooldown(152277)>6 or  PandaDB.WQZ_A1 == false  ) and (SpellCooldown(167105)<2 or (IsTalent('灭战者') and SpellCooldown(262161)<2))  ) then ShowColor(mainbutton.icon, 6603,Color["致命平静"]);ShowSpell(debutton.icon,Spell["致命平静"]) return end
if Isuseable("破坏者",152277) and PandaDB.WQZ_C7 ~= false  and PandaDB.CcdSwitch ~= false  and IsTalent('破坏者') and (SpellCooldown(167105)<2 or (IsTalent('灭战者') and SpellCooldown(262161)<2)) then ShowColor(mainbutton.icon, 6603,Color["破坏者"]);ShowSpell(debutton.icon,Spell["破坏者"]) return end
if Isuseable("巨人打击",167105) and PandaDB.WQZ_A2 ~= false  and not IsTalent('灭战者') and (IsTalent('愤怒掌握')) then ShowColor(mainbutton.icon, 6603,Color["巨人打击"]);ShowSpell(debutton.icon,Spell["巨人打击"]) return end
if Isuseable("灭战者",262161) and PandaDB.WQZ_C2 ~= false  and IsTalent('灭战者') and (IsTalent('愤怒掌握')) then ShowColor(mainbutton.icon, 6603,Color["灭战者"]);ShowSpell(debutton.icon,Spell["灭战者"]) return end
if Isuseable("剑刃风暴",227847) and PandaDB.WQZ_A1 ~= false  and PandaDB.CcdSwitch ~= false  and not IsTalent('破坏者') and (Aura_time("target","巨人打击","PLAYER|HARMFUL")>0 and ( (Aura_time("target","巨人打击","PLAYER|HARMFUL")>4.5 and AzltE('力量的考验')==0) or Aura_time("target","力量的考验","PLAYER|HARMFUL")>0  )) then ShowColor(mainbutton.icon, 6603,Color["剑刃风暴"]);ShowSpell(debutton.icon,Spell["剑刃风暴"]) return end
end

if Isuseable("致死打击",12294) and PandaDB.WQZ_C1 ~= false  and Aura_Stack("player","压制","PLAYER|HELPFUL")==2 then ShowColor(mainbutton.icon, 6603,Color["致死打击"]);ShowSpell(debutton.icon,Spell["致死打击"]) return end

if Isuseable("压制",7384) and PandaDB.WQZ_A6 ~= false  and (active_enemies()<=1 or (active_enemies()>=6 and AzltE('地震波')>1 )) then ShowColor(mainbutton.icon, 6603,Color["压制"]);ShowSpell(debutton.icon,Spell["压制"]) return end

if Isuseable("顺劈斩",845) and PandaDB.WQZ_C4 ~= false  and active_enemies()>2  then ShowColor(mainbutton.icon, 6603,Color["顺劈斩"]);ShowSpell(debutton.icon,Spell["顺劈斩"]) return end

if Isuseable("斩杀",GetSpellID("斩杀"))  and PandaDB.WQZ_A7 ~= false  and (active_enemies()<=1 or (not IsTalent('顺劈斩') and Aura_time("target","重伤","PLAYER|HARMFUL")<2 ) or Aura_time("player","猝死","PLAYER|HELPFUL")>0) then ShowColor(mainbutton.icon, 6603,Color["斩杀"]);ShowSpell(debutton.icon,Spell["斩杀"]) return end

if Isuseable("致死打击",12294) and PandaDB.WQZ_C1 ~= false  and (active_enemies()<=1 or (not IsTalent('顺劈斩') and Aura_time("target","重伤","PLAYER|HARMFUL")<2 )) then ShowColor(mainbutton.icon, 6603,Color["致死打击"]);ShowSpell(debutton.icon,Spell["致死打击"]) return end

if active_enemies()>=6 then 
if Isuseable("旋风斩",1680)  and PandaDB.WQZ_A8 ~= false  then ShowColor(mainbutton.icon, 6603,Color["旋风斩"]);ShowSpell(debutton.icon,Spell["旋风斩"]) return end
if Isuseable("压制",7384)  and PandaDB.WQZ_A6 ~= false  then ShowColor(mainbutton.icon, 6603,Color["压制"]);ShowSpell(debutton.icon,Spell["压制"]) return end
if Isuseable("旋风斩",1680) and PandaDB.WQZ_A8 ~= false  and ( IsTalent('战斗狂热')) then ShowColor(mainbutton.icon, 6603,Color["旋风斩"]);ShowSpell(debutton.icon,Spell["旋风斩"]) return end
end

if Isuseable("猛击",1464) and PandaDB.WQZ_A0 ~= false  and (not IsTalent('战斗狂热') and active_enemies()<=1 ) then ShowColor(mainbutton.icon, 6603,Color["猛击"]);ShowSpell(debutton.icon,Spell["猛击"]) return end

--------5目标----------- 
if active_enemies()==5 then
if Isuseable("碎颅打击",260643) and PandaDB.WQZ_A3 ~= false  and (Power("RAGE")<60 and (not IsTalent('致命平静') or Aura_time("player","致命平静","PLAYER|HELPFUL")==0) ) then ShowColor(mainbutton.icon, 6603,Color["碎颅打击"]);ShowSpell(debutton.icon,Spell["碎颅打击"]) return end

if Isuseable("破坏者",152277) and PandaDB.WQZ_C7 ~= false  and PandaDB.CcdSwitch ~= false  and IsTalent('破坏者') and (not IsTalent('灭战者') or SpellCooldown(262161)<2)  then ShowColor(mainbutton.icon, 6603,Color["破坏者"]);ShowSpell(debutton.icon,Spell["破坏者"]) return end

if Isuseable("巨人打击",167105) and PandaDB.WQZ_A2 ~= false  and not IsTalent('灭战者')  and (Aura_time("target","巨人打击","PLAYER|HARMFUL")==0)  then ShowColor(mainbutton.icon, 6603,Color["巨人打击"]);ShowSpell(debutton.icon,Spell["巨人打击"]) return end
if Isuseable("灭战者",262161) and PandaDB.WQZ_C2 ~= false  and IsTalent('灭战者') and (Aura_time("target","巨人打击","PLAYER|HARMFUL")==0)  then ShowColor(mainbutton.icon, 6603,Color["灭战者"]);ShowSpell(debutton.icon,Spell["灭战者"]) return end
if Isuseable("剑刃风暴",227847) and PandaDB.WQZ_A1 ~= false  and PandaDB.CcdSwitch ~= false   and not IsTalent('破坏者')  and (Aura_time("player","横扫攻击","PLAYER|HELPFUL")==0 and ( not IsTalent('致命平静') or Aura_time("player","致命平静","PLAYER|HELPFUL")==0) and ((Aura_time("target","巨人打击","PLAYER|HARMFUL")>4.5 and  AzltE('力量的考验')==0) or Aura_time("target","力量的考验","PLAYER|HARMFUL")>0))  then ShowColor(mainbutton.icon, 6603,Color["剑刃风暴"]);ShowSpell(debutton.icon,Spell["剑刃风暴"]) return end

if Isuseable("致命平静",262228)  and PandaDB.WQZ_C6 ~= false  and PandaDB.CcdSwitch ~= false  then ShowColor(mainbutton.icon, 6603,Color["致命平静"]);ShowSpell(debutton.icon,Spell["致命平静"]) return end
if Isuseable("顺劈斩",845) and PandaDB.WQZ_C4 ~= false   then ShowColor(mainbutton.icon, 6603,Color["顺劈斩"]);ShowSpell(debutton.icon,Spell["顺劈斩"]) return end
if Isuseable("斩杀",GetSpellID("斩杀"))  and PandaDB.WQZ_A7 ~= false  and ((not IsTalent('顺劈斩') and Aura_time("target","重伤","PLAYER|HARMFUL")<2 ) or (Aura_time("player","猝死","PLAYER|HELPFUL")>0 or Aura_time("player","石之心","PLAYER|HELPFUL")>0) and (Aura_time("player","横扫攻击","PLAYER|HELPFUL")>0 or SpellCooldown(260708)>8))  then ShowColor(mainbutton.icon, 6603,Color["斩杀"]);ShowSpell(debutton.icon,Spell["斩杀"]) return end

if Isuseable("致死打击",12294) and PandaDB.WQZ_C1 ~= false  and ((not IsTalent('顺劈斩') and Aura_time("target","重伤","PLAYER|HARMFUL")<2 ) or Aura_time("player","横扫攻击","PLAYER|HELPFUL")>0 and Aura_Stack("player","压制","PLAYER|HELPFUL")==2) and (IsTalent('悍勇无畏') or Aura_Stack("player","压制","PLAYER|HELPFUL")==2)   then ShowColor(mainbutton.icon, 6603,Color["致死打击"]);ShowSpell(debutton.icon,Spell["致死打击"]) return end

if Isuseable("旋风斩",1680) and PandaDB.WQZ_A8 ~= false  and (Aura_time("target","巨人打击","PLAYER|HARMFUL")>0 or ( Aura_time("player","碾压突袭","PLAYER|HELPFUL")>0 and IsTalent('战斗狂热')) )  then ShowColor(mainbutton.icon, 6603,Color["旋风斩"]);ShowSpell(debutton.icon,Spell["旋风斩"]) return end
if Isuseable("旋风斩",1680) and PandaDB.WQZ_A8 ~= false  and (Aura_time("player","致命平静","PLAYER|HELPFUL")>0 or Power("RAGE")>60 )  then ShowColor(mainbutton.icon, 6603,Color["旋风斩"]);ShowSpell(debutton.icon,Spell["旋风斩"]) return end
if Isuseable("压制",7384)  and PandaDB.WQZ_A6 ~= false   then ShowColor(mainbutton.icon, 6603,Color["压制"]);ShowSpell(debutton.icon,Spell["压制"]) return end
if Isuseable("旋风斩",1680) and PandaDB.WQZ_A8 ~= false  then ShowColor(mainbutton.icon, 6603,Color["旋风斩"]);ShowSpell(debutton.icon,Spell["旋风斩"]) return end

end



-----------------execute,if=(talent.massacre.enabled&target.health.pct<35)|target.health.pct<20-------------

if Zhanshachuli() then

if Isuseable("碎颅打击",260643) and PandaDB.WQZ_A3 ~= false   and (Power("RAGE")<60 and Aura_time("player","致命平静","PLAYER|HELPFUL")==0 and Aura_time('player','清醒梦境之忆','PLAYER|HELPFUL')==0  )  then ShowColor(mainbutton.icon, 6603,Color["碎颅打击"]);ShowSpell(debutton.icon,Spell["碎颅打击"]) return end
if Isuseable("破坏者",152277) and PandaDB.WQZ_C7 ~= false  and PandaDB.CcdSwitch ~= false   and IsTalent('破坏者') and (Aura_time("player","致命平静","PLAYER|HELPFUL")==0 and (SpellCooldown(167105)<2 or (IsTalent('灭战者') and SpellCooldown(262161)<2))    )  then ShowColor(mainbutton.icon, 6603,Color["破坏者"]);ShowSpell(debutton.icon,Spell["破坏者"]) return end

if Isuseable("巨人打击",167105) and PandaDB.WQZ_A2 ~= false  and not IsTalent('灭战者') then ShowColor(mainbutton.icon, 6603,Color["巨人打击"]);ShowSpell(debutton.icon,Spell["巨人打击"]) return end

if Isuseable("灭战者",262161) and PandaDB.WQZ_C2 ~= false  and IsTalent('灭战者') then ShowColor(mainbutton.icon, 6603,Color["灭战者"]);ShowSpell(debutton.icon,Spell["灭战者"]) return end
if Isuseable("致命平静",262228) and PandaDB.WQZ_C6  ~= false and PandaDB.CcdSwitch ~= false   then ShowColor(mainbutton.icon, 6603,Color["致命平静"]);ShowSpell(debutton.icon,Spell["致命平静"]) return end
if Isuseable("剑刃风暴",227847) and PandaDB.WQZ_A1 ~= false  and PandaDB.CcdSwitch ~= false  and not IsTalent('破坏者') and (Aura_time('player','清醒梦境之忆','PLAYER|HELPFUL')==0 and Aura_time("target","力量的考验","PLAYER|HARMFUL")>0 and Power("RAGE")<30 and Aura_time("player","致命平静","PLAYER|HELPFUL")==0)  then ShowColor(mainbutton.icon, 6603,Color["剑刃风暴"]);ShowSpell(debutton.icon,Spell["剑刃风暴"]) return end
if Isuseable("顺劈斩",845) and PandaDB.WQZ_C4 ~= false  and active_enemies()>2  then ShowColor(mainbutton.icon, 6603,Color["顺劈斩"]);ShowSpell(debutton.icon,Spell["顺劈斩"]) return end

if Isuseable("猛击",1464) and PandaDB.WQZ_A0 ~= false  and (Aura_time("target","巨人打击","PLAYER|HARMFUL")>0 and Aura_time('player','清醒梦境之忆','PLAYER|HELPFUL')==0 )  then ShowColor(mainbutton.icon, 6603,Color["猛击"]);ShowSpell(debutton.icon,Spell["猛击"]) return end

if Isuseable("致死打击",12294) and PandaDB.WQZ_C1 ~= false  and (Aura_Stack("player","压制","PLAYER|HELPFUL")==2 and (IsTalent('悍勇无畏') or Aura_Stack("player","压制","PLAYER|HELPFUL")==2) )  then ShowColor(mainbutton.icon, 6603,Color["致死打击"]);ShowSpell(debutton.icon,Spell["致死打击"]) return end
if Isuseable("斩杀",GetSpellID("斩杀"))  and PandaDB.WQZ_A7 ~= false  and (Aura_time('player','清醒梦境之忆','PLAYER|HELPFUL')>0 or Aura_time("player","致命平静","PLAYER|HELPFUL")>0 or (Aura_time("target","力量的考验","PLAYER|HARMFUL")>0 and SpellCooldown(298357)>94)  )  then ShowColor(mainbutton.icon, 6603,Color["斩杀"]);ShowSpell(debutton.icon,Spell["斩杀"]) return end

if Isuseable("压制",7384)  and PandaDB.WQZ_A6 ~= false   then ShowColor(mainbutton.icon, 6603,Color["压制"]);ShowSpell(debutton.icon,Spell["压制"]) return end
if Isuseable("斩杀",GetSpellID("斩杀"))  and PandaDB.WQZ_A7 ~= false   then ShowColor(mainbutton.icon, 6603,Color["斩杀"]);ShowSpell(debutton.icon,Spell["斩杀"]) return end

end

------------单体------------------

if Isuseable("撕裂",772) and PandaDB.WQZ_A4 ~= false  and (Aura_time("target","撕裂","PLAYER|HARMFUL")<0.3*12 and (Aura_time("target","巨人打击","PLAYER|HARMFUL")==0) )  then ShowColor(mainbutton.icon, 6603,Color["撕裂"]);ShowSpell(debutton.icon,Spell["撕裂"]) return end
if Isuseable("碎颅打击",260643) and PandaDB.WQZ_A3 ~= false   and (Power("RAGE")<60 and (not IsTalent('致命平静') and Aura_time('player','清醒梦境之忆','PLAYER|HELPFUL')==0) )  then ShowColor(mainbutton.icon, 6603,Color["碎颅打击"]);ShowSpell(debutton.icon,Spell["碎颅打击"]) return end

if Isuseable("破坏者",152277) and PandaDB.WQZ_C7 ~= false  and PandaDB.CcdSwitch ~= false   and IsTalent('破坏者') and (Aura_time("player","致命平静","PLAYER|HELPFUL")==0 and (SpellCooldown(167105)<2 or (IsTalent('灭战者') and SpellCooldown(262161)<2)) )  then ShowColor(mainbutton.icon, 6603,Color["破坏者"]);ShowSpell(debutton.icon,Spell["破坏者"]) return end
if Isuseable("巨人打击",167105) and PandaDB.WQZ_A2 ~= false   and not IsTalent('灭战者') then ShowColor(mainbutton.icon, 6603,Color["巨人打击"]);ShowSpell(debutton.icon,Spell["巨人打击"]) return end
if Isuseable("灭战者",262161) and PandaDB.WQZ_C2 ~= false  and IsTalent('灭战者')  then ShowColor(mainbutton.icon, 6603,Color["灭战者"]);ShowSpell(debutton.icon,Spell["灭战者"]) return end
if Isuseable("致命平静",262228) and PandaDB.WQZ_C6 ~= false  and PandaDB.CcdSwitch ~= false   then ShowColor(mainbutton.icon, 6603,Color["致命平静"]);ShowSpell(debutton.icon,Spell["致命平静"]) return end

if Isuseable("斩杀",GetSpellID("斩杀"))  and PandaDB.WQZ_A7 ~= false  and (Aura_time("player","猝死","PLAYER|HELPFUL")>0)  then ShowColor(mainbutton.icon, 6603,Color["斩杀"]);ShowSpell(debutton.icon,Spell["斩杀"]) return end
if Isuseable("剑刃风暴",227847) and PandaDB.WQZ_A1 ~= false  and PandaDB.CcdSwitch ~= false  and not IsTalent('破坏者') and (SpellCooldown(12294)>0 and (not IsTalent('致命平静') or Aura_time("player","致命平静","PLAYER|HELPFUL")==0 ) or ((Aura_time("target","巨人打击","PLAYER|HARMFUL")>0 and AzltE('力量的考验')==0) or Aura_time("target","力量的考验","PLAYER|HARMFUL")>0 ) and  Aura_time('player','清醒梦境之忆','PLAYER|HELPFUL')==0 and Power("RAGE")<60)  then ShowColor(mainbutton.icon, 6603,Color["剑刃风暴"]);ShowSpell(debutton.icon,Spell["剑刃风暴"]) return end

if Isuseable("顺劈斩",845) and PandaDB.WQZ_C4 ~= false  and active_enemies()>2  then ShowColor(mainbutton.icon, 6603,Color["顺劈斩"]);ShowSpell(debutton.icon,Spell["顺劈斩"]) return end

if Isuseable("压制",7384)  and PandaDB.WQZ_A6 ~= false  and ((Power("RAGE")<30 and Aura_time('player','清醒梦境之忆','PLAYER|HELPFUL')>0 and Aura_time("target","巨人打击","PLAYER|HARMFUL")>0) or (Power("RAGE")<70 ) and Aura_time('player','清醒梦境之忆','PLAYER|HELPFUL')==0  )  then ShowColor(mainbutton.icon, 6603,Color["压制"]);ShowSpell(debutton.icon,Spell["压制"]) return end
if Isuseable("致死打击",12294) and PandaDB.WQZ_C1 ~= false   then ShowColor(mainbutton.icon, 6603,Color["致死打击"]);ShowSpell(debutton.icon,Spell["致死打击"]) return end

if Isuseable("旋风斩",1680) and (IsTalent('战斗狂热') and (Aura_time('player','清醒梦境之忆','PLAYER|HELPFUL')>0 or Aura_time("target","巨人打击","PLAYER|HARMFUL")>0 or  Aura_time("player","致命平静","PLAYER|HELPFUL")>0 ) )  then ShowColor(mainbutton.icon, 6603,Color["旋风斩"]);ShowSpell(debutton.icon,Spell["旋风斩"]) return end
if Isuseable("压制",7384)  and PandaDB.WQZ_A6 ~= false   then ShowColor(mainbutton.icon, 6603,Color["压制"]);ShowSpell(debutton.icon,Spell["压制"]) return end
if Isuseable("旋风斩",1680) and (IsTalent('战斗狂热') and ( Aura_time("target","力量的考验","PLAYER|HARMFUL")>0 or Aura_time("target","巨人打击","PLAYER|HARMFUL")==0 and Aura_time("target","力量的考验","PLAYER|HARMFUL")==0 and Power("RAGE")>60) )  then ShowColor(mainbutton.icon, 6603,Color["旋风斩"]);ShowSpell(debutton.icon,Spell["旋风斩"]) return end
if Isuseable("猛击",1464) and PandaDB.WQZ_A0 ~= false  and (not IsTalent('战斗狂热')  )  then ShowColor(mainbutton.icon, 6603,Color["猛击"]);ShowSpell(debutton.icon,Spell["猛击"]) return end
---------------------------------------------------------------------------
--[[                       编辑区                       ]]--
---------------------------------------------------------------------------

ShowColor(mainbutton.icon, 6603,311923);ShowSpell(debutton.icon, 311923)	

--elseif not Authorization() then 
--print("|cffffe00a★Panda★:【|r|c00FF68CC 插件未激活 联系QQ:398371778 |r|cffffe00a】|r")

--end


end


end

local Warrior_Arms = Warrior_Arms
ns.Warrior_Arms = Warrior_Arms


