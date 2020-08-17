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
--[[                   猎人变量                          ]]--
---------------------------------------------------------------------------  
--兽王集中值恢复速度
local function Hunter_focus_regen()
    
    local R=GetPowerRegen()
    local C1=Aura_count("player","倒刺射击",filter)
    local C2=Aura_count("player","野性守护",filter)
    local C3=Aura_count("player","喷毒眼镜蛇",filter)
    
    if IsTalent("血之气息") then 
        a=8  
    else a=0 
    end
    
    if C1>0 then 
        d=((28+a)/8)*C1
    else d=0
    end
    
    if C2>0 then  b=5  else b=0 end
    if C3>0 then  c=2  else c=0 end
    
    return R+b+c+d
    
end
--射击多重射击
local function DCSJ()
local A = Aura_time("PLAYER","技巧射击") 
local B = Useing_spell("PLAYER")
if A == 0 or  B == 19434 or B == 257044 then return true else return false end
end


local function Hunter_Survival()  --更新主图标及技能提示图标

local mainbutton = PDUI.mainbutton
local debutton = PDUI.debutton

if PlayerClass()=="HUNTER" and Specialization()=="生存" then
--if Authorization() then

--开始循环
--自动拾取器


---------------------------------------------------------------------------
--[[                       编辑区                       ]]--
---------------------------------------------------------------------------

--打球/图腾
if Teshuchuli() then
if PandaDB.SC_A3 ~= false  and Isuseable("猛禽一击",186270) then  ShowColor(mainbutton.icon, 6603,A_3);ShowSpell(debutton.icon, 186270) return end
if PandaDB.SC_A3 ~= false and Isuseable("猫鼬撕咬",259387) then  ShowColor(mainbutton.icon, 6603,A_3);ShowSpell(debutton.icon, 259387) return end

end

--actions.cds+=/aspect_of_the_eagle,if=target.distance>=6

if PandaDB.CcdSwitch ~= false  then
if PandaDB.SC_A1 ~= false  and Isuseable("雄鹰守护",186289) then
if UnitRange("TARGET")>=6 and UnitCanAttack('player',"TARGET") then  ShowColor(mainbutton.icon, 6603,A_1);ShowSpell(debutton.icon, 186289) return end
end
end

if PandaDB.CcdSwitch ~= false  then
--艾泽拉斯之心精华
--essences
if PandaDB.SC_C8 then
if Isuseable("仇敌之血","仇敌之血") then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.SC_C8 then
if Isuseable("艾泽拉斯守护者","艾泽拉斯守护者") then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.SC_C8 then
if Isuseable("不羁之力","不羁之力") then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.SC_C8 then
if Isuseable("聚能艾泽里特射线","聚能艾泽里特射线") and Useing_spell("player") ~= 295258 then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.SC_C8 then
if Isuseable("火红烈焰","火红烈焰") then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.SC_C8 then
if Isuseable("净化冲击","净化冲击") then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.SC_C8 then
if Isuseable("世界血脉共鸣","世界血脉共鸣") then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.SC_C8 then
if Isuseable("空间涟漪","空间涟漪") then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.SC_C8 then
if Isuseable("清醒梦境之忆","清醒梦境之忆") then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.SC_C8 then
if Isuseable("收割火焰","收割火焰")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.SC_C8 then
if Isuseable("生命缚誓者之祈","生命缚誓者之祈")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.SC_C8 then
if Isuseable("救世之魂","救世之魂")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.SC_C8 then
if Isuseable("守护屏障","守护屏障")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.SC_C8 then
if Isuseable("补充能量","补充能量")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.SC_C8 then
if Isuseable("静滞","静滞")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.SC_C8 then
if Isuseable("法力过载","法力过载")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.SC_C8 then
if Isuseable("活力导管","活力导管")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.SC_C8 then
if Isuseable("爆燃之拥","爆燃之拥")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.SC_C8 then
if Isuseable("光荣时刻","光荣时刻")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.SC_C8 then
if Isuseable("深渊之护","深渊之护")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.SC_C8 then
if Isuseable("艾泽拉斯的不朽赐福","艾泽拉斯的不朽赐福")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

if PandaDB.SC_C8 then
if Isuseable("强化虚无屏障","强化虚无屏障")  then ShowColor(mainbutton.icon, 6603,C_8);ShowSpell(debutton.icon, 296208) return end
end

end
----------------------------------------------------------------------------------------------------------------------------------------------------------------
--actions+=/call_action_list,name=mb_ap_wfi_st,if=active_enemies<3&talent.wildfire_infusion.enabled&talent.alpha_predator.enabled&talent.mongoose_bite.enabled
if active_enemies()<3 and IsTalent("野火灌注") and IsTalent("捕食者头领") and IsTalent("猫鼬撕咬") then
--actions.mb_ap_wfi_st=serpent_sting,if=!dot.serpent_sting.ticking
if PandaDB.SC_A0 ~= false  and Isuseable("毒蛇钉刺",259491) then 
if ( Aura_time("target","毒蛇钉刺","PLAYER|HARMFUL") ==0 and  Last_Spell(1) ~= 259491 )then  ShowColor(mainbutton.icon, 6603,A_0);ShowSpell(debutton.icon, 259491) return end 
end
--actions.mb_ap_wfi_st+=/wildfire_bomb,if=full_recharge_time<gcd|(focus+cast_regen<focus.max)&(next_wi_bomb.volatile&dot.serpent_sting.ticking&dot.serpent_sting.refreshable|next_wi_bomb.pheromone&!buff.mongoose_fury.up&focus+cast_regen<focus.max-action.kill_command.cast_regen*3)
if PandaDB.SC_A6 ~= false  and Isuseable("野火炸弹",259495) then
if SpellFullCharges(259495)<GCD_MAX() or (Power("FOCUS")<PowerMax("FOCUS")) and (useable("动荡炸弹") and Aura_time("target","毒蛇钉刺","PLAYER|HARMFUL")>0 and Aura_time("target","毒蛇钉刺","PLAYER|HARMFUL")<=4 or useable("信息素炸弹") and Aura_time("PLAYER","猫鼬之怒")==0 and Power("FOCUS")<PowerMax("FOCUS")-45 ) then  ShowColor(mainbutton.icon, 6603,A_6);ShowSpell(debutton.icon, 259495) return end
end
--actions.mb_ap_wfi_st+=/coordinated_assault
if PandaDB.SC_A2 ~= false  and PandaDB.CcdSwitch ~= false  then
if Isuseable("协同进攻",266779)  then  ShowColor(mainbutton.icon, 6603,A_2);ShowSpell(debutton.icon, 266779) return end
end
--actions.mb_ap_wfi_st+=/a_murder_of_crows
if PandaDB.SC_A7 ~= false  and Isuseable("夺命黑鸦",131894) then  ShowColor(mainbutton.icon, 6603,A_7);ShowSpell(debutton.icon, 131894) return end
--actions.mb_ap_wfi_st+=/mongoose_bite,if=buff.mongoose_fury.remains&next_wi_bomb.pheromone
if PandaDB.SC_A3 ~= false  and Isuseable("猫鼬撕咬",259387) and IsTalent("猫鼬撕咬") then 
if Aura_time("PLAYER","猫鼬之怒")==0 and useable("信息素炸弹") then ShowColor(mainbutton.icon, 6603,A_3);ShowSpell(debutton.icon, 259387) return end
end
--actions.mb_ap_wfi_st+=/kill_command,if=focus+cast_regen<focus.max&(buff.mongoose_fury.stack<5|focus<action.mongoose_bite.cost)
if PandaDB.SC_A9 ~= false  and Isuseable("杀戮命令",259489) then
if Power("FOCUS")<PowerMax("FOCUS")-20 and (Aura_Stack("PLAYER","猫鼬之怒")<5 or Power("FOCUS")<30)then  ShowColor(mainbutton.icon, 6603,A_9);ShowSpell(debutton.icon, 259489) return end
end
--actions.mb_ap_wfi_st+=/wildfire_bomb,if=next_wi_bomb.shrapnel&focus>60&dot.serpent_sting.remains>3*gcd
if PandaDB.SC_A6 ~= false  and Isuseable("野火炸弹",259495) then
if useable("散射炸弹") and Power("FOCUS")>60 and Aura_time("target","毒蛇钉刺","PLAYER|HARMFUL")>3*GCD_MAX() then  ShowColor(mainbutton.icon, 6603,A_6);ShowSpell(debutton.icon, 259495) return end
end
--actions.mb_ap_wfi_st+=/serpent_sting,if=refreshable&(next_wi_bomb.volatile&!dot.shrapnel_bomb.ticking|azerite.latent_poison.enabled|azerite.venomous_fangs.enabled)
if PandaDB.SC_A0 ~= false  and Isuseable("毒蛇钉刺",259491) then 
if ( Aura_time("target","毒蛇钉刺","PLAYER|HARMFUL") <=4 and  Last_Spell(1) ~= 259491 ) and (useable("动荡炸弹") and Aura_time("target","散射炸弹","PLAYER|HARMFUL")==0 or AzltE("潜藏毒素")>0 or AzltE("剧毒之牙")>0)then  ShowColor(mainbutton.icon, 6603,A_0);ShowSpell(debutton.icon, 259491) return end 
end
--actions.mb_ap_wfi_st+=/mongoose_bite,if=buff.mongoose_fury.up|focus>60|dot.shrapnel_bomb.ticking
if PandaDB.SC_A3 ~= false  and Isuseable("猫鼬撕咬",259387) and IsTalent("猫鼬撕咬") then 
if Aura_time("PLAYER","猫鼬之怒")>0 or Power("FOCUS")>60 or Aura_time("target","散射炸弹","PLAYER|HARMFUL")>0 then ShowColor(mainbutton.icon, 6603,A_3);ShowSpell(debutton.icon, 259387) return end
end
--actions.mb_ap_wfi_st+=/serpent_sting,if=refreshable
if PandaDB.SC_A0 ~= false  and Isuseable("毒蛇钉刺",259491) then 
if Aura_time("target","毒蛇钉刺","PLAYER|HARMFUL") <=4 and  Last_Spell(1) ~= 259491 then  ShowColor(mainbutton.icon, 6603,A_0);ShowSpell(debutton.icon, 259491) return end 
end
--actions.mb_ap_wfi_st+=/wildfire_bomb,if=next_wi_bomb.volatile&dot.serpent_sting.ticking|next_wi_bomb.pheromone|next_wi_bomb.shrapnel&focus>50
if PandaDB.SC_A6 ~= false  and Isuseable("野火炸弹",259495) then
if useable("动荡炸弹") and Aura_time("target","毒蛇钉刺","PLAYER|HARMFUL")>0 or useable("信息素炸弹") or useable("散射炸弹") and Power("FOCUS")>50 then  ShowColor(mainbutton.icon, 6603,A_6);ShowSpell(debutton.icon, 259495) return end
end

---------------------------------------------------------------------------------------------
--actions+=/call_action_list,name=wfi_st,if=active_enemies<3&talent.wildfire_infusion.enabled
elseif active_enemies()<3 and IsTalent("野火灌注") then
--actions.wfi_st=a_murder_of_crows
if PandaDB.SC_A7 ~= false  and Isuseable("夺命黑鸦",131894) then  ShowColor(mainbutton.icon, 6603,A_7);ShowSpell(debutton.icon, 131894) return end
--actions.wfi_st+=/coordinated_assault
if PandaDB.CcdSwitch ~= false then
if PandaDB.SC_A2 ~= false  and Isuseable("协同进攻",266779)  then  ShowColor(mainbutton.icon, 6603,A_2);ShowSpell(debutton.icon, 266779) return end
end
--actions.wfi_st+=/mongoose_bite,if=azerite.wilderness_survival.enabled&next_wi_bomb.volatile&dot.serpent_sting.remains>2.1*gcd&dot.serpent_sting.remains<3.5*gcd&cooldown.wildfire_bomb.remains>2.5*gcd
if PandaDB.SC_A3 ~= false  and Isuseable("猫鼬撕咬",259387) and IsTalent("猫鼬撕咬") then 
if AzltE("荒野生存")>0 and useable("动荡炸弹") and Aura_time("target","毒蛇钉刺","PLAYER|HARMFUL")>2.1*GCD_MAX() and Aura_time("target","毒蛇钉刺","PLAYER|HARMFUL")<3.5 and SpellCooldown(259495)>2.5*GCD_MAX() then ShowColor(mainbutton.icon, 6603,A_3);ShowSpell(debutton.icon, 259387) return end
end
--actions.wfi_st+=/wildfire_bomb,if=full_recharge_time<gcd|(focus+cast_regen<focus.max)&(next_wi_bomb.volatile&dot.serpent_sting.ticking&dot.serpent_sting.refreshable|next_wi_bomb.pheromone&!buff.mongoose_fury.up&focus+cast_regen<focus.max-action.kill_command.cast_regen*3)
if PandaDB.SC_A6 ~= false  and Isuseable("野火炸弹",259495) then
if SpellFullCharges(259495)<GCD_MAX() or (Power("FOCUS")<PowerMax("FOCUS")) and (useable("动荡炸弹") and Aura_time("target","毒蛇钉刺","PLAYER|HARMFUL")>0 and Aura_time("target","毒蛇钉刺","PLAYER|HARMFUL")<=4 or useable("信息素炸弹") and Aura_time("PLAYER","猫鼬之怒")==0 and Power("FOCUS")<PowerMax("FOCUS")-45 ) then  ShowColor(mainbutton.icon, 6603,A_6);ShowSpell(debutton.icon, 259495) return end
end
--actions.wfi_st+=/kill_command,if=focus+cast_regen<focus.max&buff.tip_of_the_spear.stack<3&(!talent.alpha_predator.enabled|buff.mongoose_fury.stack<5|focus<action.mongoose_bite.cost)
if PandaDB.SC_A9 ~= false  and Isuseable("杀戮命令",259489) then
if Power("FOCUS")<PowerMax("FOCUS")-20 and Aura_Stack("PLAYER","利矛之刃")<3 and ( not IsTalent("捕食者头领") or Aura_Stack("PLAYER","猫鼬之怒")<5 or Power("FOCUS")<30 )then  ShowColor(mainbutton.icon, 6603,A_9);ShowSpell(debutton.icon, 259489) return end
end
--actions.wfi_st+=/raptor_strike,if=dot.internal_bleeding.stack<3&dot.shrapnel_bomb.ticking&!talent.mongoose_bite.enabled
if PandaDB.SC_A3 ~= false  and Isuseable("猛禽一击",186270) and not IsTalent("猫鼬撕咬") then 
if  Aura_Stack("target","内出血","PLAYER|HARMFUL")<3 and Aura_time("target","散射炸弹","PLAYER|HARMFUL")>0 and not IsTalent("猫鼬撕咬") then ShowColor(mainbutton.icon, 6603,A_3);ShowSpell(debutton.icon, 186270) return end
end
--actions.wfi_st+=/wildfire_bomb,if=next_wi_bomb.shrapnel&buff.mongoose_fury.down&(cooldown.kill_command.remains>gcd|focus>60)&!dot.serpent_sting.refreshable
if PandaDB.SC_A6 ~= false  and Isuseable("野火炸弹",259495) then
if useable("散射炸弹") and Aura_time("PLAYER","猫鼬之怒")==0 and (SpellCooldown(259489)>GCD_MAX() or Power("FOCUS")>60) and  Aura_time("target","毒蛇钉刺","PLAYER|HARMFUL")>4 then  ShowColor(mainbutton.icon, 6603,A_6);ShowSpell(debutton.icon, 259495) return end
end
--actions.wfi_st+=/flanking_strike,if=focus+cast_regen<focus.max
if PandaDB.SC_A5 ~= false  and Isuseable("侧翼打击",269751) then
if Power("FOCUS")<PowerMax("FOCUS") then  ShowColor(mainbutton.icon, 6603,A_5);ShowSpell(debutton.icon, 269751) return end
end
--actions.wfi_st+=/serpent_sting,if=buff.vipers_venom.react|refreshable&(!talent.mongoose_bite.enabled|!talent.vipers_venom.enabled|next_wi_bomb.volatile&!dot.shrapnel_bomb.ticking|azerite.latent_poison.enabled|azerite.venomous_fangs.enabled|buff.mongoose_fury.stack=5)
if PandaDB.SC_A0 ~= false  and Isuseable("毒蛇钉刺",259491) then 
if Aura_time("PLAYER","蝰蛇毒液") >0 or Aura_time("target","毒蛇钉刺","PLAYER|HARMFUL") <=4 and (not IsTalent("猫鼬撕咬") or not IsTalent("蝰蛇毒液") or useable("动荡炸弹") or Aura_time("target","散射炸弹","PLAYER|HARMFUL")==0 or AzltE("潜藏毒素")>0 or AzltE("剧毒之牙")>0 or Aura_Stack("PLAYER","猫鼬之怒")==5 ) then  ShowColor(mainbutton.icon, 6603,A_0);ShowSpell(debutton.icon, 259491) return end 
end
--actions.wfi_st+=/mongoose_bite,if=buff.mongoose_fury.up|focus>60|dot.shrapnel_bomb.ticking
if PandaDB.SC_A3 ~= false  and Isuseable("猫鼬撕咬",259387) and IsTalent("猫鼬撕咬") then 
if Aura_time("PLAYER","猫鼬之怒")>0 or Power("FOCUS")>60 or Aura_time("target","散射炸弹","PLAYER|HARMFUL")>0 then ShowColor(mainbutton.icon, 6603,A_3);ShowSpell(debutton.icon, 259387) return end
end
--actions.wfi_st+=/raptor_strike
if PandaDB.SC_A3 ~= false  and Isuseable("猛禽一击",186270) and not IsTalent("猫鼬撕咬") then ShowColor(mainbutton.icon, 6603,A_3);ShowSpell(debutton.icon, 186270) return end
--actions.wfi_st+=/serpent_sting,if=refreshable
if PandaDB.SC_A0 ~= false  and Isuseable("毒蛇钉刺",259491) then 
if Aura_time("target","毒蛇钉刺","PLAYER|HARMFUL") <=4 then  ShowColor(mainbutton.icon, 6603,A_0);ShowSpell(debutton.icon, 259491) return end 
end
--actions.wfi_st+=/wildfire_bomb,if=next_wi_bomb.volatile&dot.serpent_sting.ticking|next_wi_bomb.pheromone|next_wi_bomb.shrapnel&focus>50
if PandaDB.SC_A6 ~= false  and Isuseable("野火炸弹",259495) then
if useable("动荡炸弹") and Aura_time("target","毒蛇钉刺","PLAYER|HARMFUL")>0 or useable("信息素炸弹") or useable("散射炸弹") and Power("FOCUS")>50 then  ShowColor(mainbutton.icon, 6603,A_6);ShowSpell(debutton.icon, 259495) return end
end

--------------------------------------------------------------------------------------------------------------------------------------------------
---actions+=/call_action_list,name=st,if=active_enemies<2|azerite.blur_of_talons.enabled&talent.birds_of_prey.enabled&buff.coordinated_assault.up
elseif active_enemies()<2 or AzltE("迅疾爪击")>0 and IsTalent("猛禽狩猎") and  Aura_time("PLAYER","协同进攻")>0 then
--actions.st=a_murder_of_crows
if PandaDB.SC_A7 ~= false  and Isuseable("夺命黑鸦",131894) then  ShowColor(mainbutton.icon, 6603,A_7);ShowSpell(debutton.icon, 131894) return end
--actions.st+=/mongoose_bite,if=talent.birds_of_prey.enabled&buff.coordinated_assault.up&(buff.coordinated_assault.remains<gcd|buff.blur_of_talons.up&buff.blur_of_talons.remains<gcd)
if PandaDB.SC_A3 ~= false  and Isuseable("猫鼬撕咬",259387) and IsTalent("猫鼬撕咬") then 
if IsTalent("猛禽狩猎") and Aura_time("PLAYER","协同进攻")>0 and (Aura_time("PLAYER","协同进攻")<GCD_MAX() or Aura_time("PLAYER","迅疾爪击")>0 and Aura_time("PLAYER","迅疾爪击")<GCD_MAX())  then ShowColor(mainbutton.icon, 6603,A_3);ShowSpell(debutton.icon, 259387) return end
end
--actions.st+=/raptor_strike,if=talent.birds_of_prey.enabled&buff.coordinated_assault.up&(buff.coordinated_assault.remains<gcd|buff.blur_of_talons.up&buff.blur_of_talons.remains<gcd)
if PandaDB.SC_A3 ~= false  and Isuseable("猛禽一击",186270) and not IsTalent("猫鼬撕咬") then 
if IsTalent("猛禽狩猎") and Aura_time("PLAYER","协同进攻")>0 and (Aura_time("PLAYER","协同进攻")<GCD_MAX() or Aura_time("PLAYER","迅疾爪击")>0 and Aura_time("PLAYER","迅疾爪击")<GCD_MAX()) then ShowColor(mainbutton.icon, 6603,A_3);ShowSpell(debutton.icon, 186270) return end
end
--actions.st+=/serpent_sting,if=buff.vipers_venom.react&buff.vipers_venom.remains<gcd
if PandaDB.SC_A0 ~= false  and Isuseable("毒蛇钉刺",259491) then 
if Aura_time("PLAYER","蝰蛇毒液")>0 and Aura_time("PLAYER","蝰蛇毒液")<GCD_MAX() then  ShowColor(mainbutton.icon, 6603,A_0);ShowSpell(debutton.icon, 259491) return end 
end
--actions.st+=/kill_command,if=focus+cast_regen<focus.max&(!talent.alpha_predator.enabled|talent.alpha_predator.enabled&full_recharge_time<1.5*gcd&focus+cast_regen<focus.max-20)
if PandaDB.SC_A9 ~= false  and Isuseable("杀戮命令",259489) then
if Power("FOCUS")<PowerMax("FOCUS")-20 and ( not IsTalent("捕食者头领") or IsTalent("捕食者头领") and SpellFullCharges(259489)<1.5*GCD_MAX() and Power("FOCUS")<PowerMax("FOCUS")-20) then  ShowColor(mainbutton.icon, 6603,A_9);ShowSpell(debutton.icon, 259489) return end
end
--actions.st+=/wildfire_bomb,if=focus+cast_regen<focus.max&(full_recharge_time<gcd|!dot.wildfire_bomb.ticking&(buff.mongoose_fury.down|full_recharge_time<4.5*gcd))
if PandaDB.SC_A6 ~= false  and Isuseable("野火炸弹",259495) then
if Power("FOCUS")<PowerMax("FOCUS") and(SpellFullCharges(259495)<GCD_MAX() or Aura_time("target","野火炸弹","PLAYER|HARMFUL")==0 and (Aura_time("PLAYER","猫鼬之怒")==0 or SpellFullCharges(259495)<4.5*GCD_MAX() )) then  ShowColor(mainbutton.icon, 6603,A_6);ShowSpell(debutton.icon, 259495) return end
end
--actions.st+=/serpent_sting,if=buff.vipers_venom.react&dot.serpent_sting.remains<4*gcd|!talent.vipers_venom.enabled&!dot.serpent_sting.ticking&!buff.coordinated_assault.up
if PandaDB.SC_A0 ~= false  and Isuseable("毒蛇钉刺",259491) then 
if Aura_time("PLAYER","蝰蛇毒液")>0 and Aura_time("target","毒蛇钉刺","PLAYER|HARMFUL")<4 or not IsTalent("蝰蛇毒液") and Aura_time("target","毒蛇钉刺","PLAYER|HARMFUL")==0 and Aura_time("PLAYER","协同进攻")==0 then  ShowColor(mainbutton.icon, 6603,A_0);ShowSpell(debutton.icon, 259491) return end 
end
--actions.st+=/serpent_sting,if=refreshable&(azerite.latent_poison.rank>2|azerite.latent_poison.enabled&azerite.venomous_fangs.enabled|(azerite.latent_poison.enabled|azerite.venomous_fangs.enabled)&(!azerite.blur_of_talons.enabled|!talent.birds_of_prey.enabled|!buff.coordinated_assault.up))
if PandaDB.SC_A0 ~= false  and Isuseable("毒蛇钉刺",259491) then 
if Aura_time("target","毒蛇钉刺","PLAYER|HARMFUL") <=4 and (AzltE("潜藏毒素")>2 or AzltE("潜藏毒素")>0 and AzltE("剧毒之牙")>0 or (AzltE("潜藏毒素")>0 or AzltE("剧毒之牙")>0) and (AzltE("迅疾爪击")==0 or IsTalent("猛禽狩猎") or Aura_time("PLAYER","协同进攻")==0)) then  ShowColor(mainbutton.icon, 6603,A_0);ShowSpell(debutton.icon, 259491) return end 
end
--actions.st+=/coordinated_assault
if PandaDB.CcdSwitch ~= false  then
if PandaDB.SC_A2 ~= false  and Isuseable("协同进攻",266779)  then  ShowColor(mainbutton.icon, 6603,A_2);ShowSpell(debutton.icon, 266779) return end
end
--actions.st+=/chakrams
if PandaDB.SC_A8 ~= false  and Isuseable("飞轮",259391)  then  ShowColor(mainbutton.icon, 6603,A_8);ShowSpell(debutton.icon, 259391) return end
--actions.st+=/flanking_strike,if=focus+cast_regen<focus.max
if PandaDB.SC_A5 ~= false  and Isuseable("侧翼打击",269751) then
if Power("FOCUS")<PowerMax("FOCUS") then  ShowColor(mainbutton.icon, 6603,A_5);ShowSpell(debutton.icon, 269751) return end
end
--actions.st+=/kill_command,if=focus+cast_regen<focus.max&(buff.mongoose_fury.stack<4|focus<action.mongoose_bite.cost)
if PandaDB.SC_A9 ~= false  and Isuseable("杀戮命令",259489) then
if Power("FOCUS")<PowerMax("FOCUS")-20 and (Aura_Stack("PLAYER","猫鼬之怒")<4 or Power("FOCUS")<30 ) then  ShowColor(mainbutton.icon, 6603,A_9);ShowSpell(debutton.icon, 259489) return end
end
--actions.st+=/mongoose_bite,if=buff.mongoose_fury.up|(focus+cast_regen>focus.max-10|talent.vipers_venom.enabled&focus+cast_regen>focus.max-20)|buff.coordinated_assault.up
if PandaDB.SC_A3 ~= false  and Isuseable("猫鼬撕咬",259387) and IsTalent("猫鼬撕咬") then 
if Aura_time("PLAYER","猫鼬之怒")>0 or (Power("FOCUS")>PowerMax("FOCUS")-10 or IsTalent("蝰蛇毒液") and Power("FOCUS")>PowerMax("FOCUS")-20) or Aura_time("PLAYER","协同进攻")>0 then ShowColor(mainbutton.icon, 6603,A_3);ShowSpell(debutton.icon, 259387) return end
end
--actions.st+=/raptor_strike
if PandaDB.SC_A3 ~= false  and Isuseable("猛禽一击",186270) and not IsTalent("猫鼬撕咬") then  ShowColor(mainbutton.icon, 6603,A_3);ShowSpell(debutton.icon, 186270) return end
--actions.st+=/serpent_sting,if=dot.serpent_sting.refreshable&!buff.coordinated_assault.up
if PandaDB.SC_A0 ~= false  and Isuseable("毒蛇钉刺",259491) then 
if Aura_time("target","毒蛇钉刺","PLAYER|HARMFUL") <=4 and Aura_time("PLAYER","协同进攻")==0 then  ShowColor(mainbutton.icon, 6603,A_0);ShowSpell(debutton.icon, 259491) return end 
end
--actions.st+=/wildfire_bomb,if=dot.wildfire_bomb.refreshable
if PandaDB.SC_A6 ~= false  and Isuseable("野火炸弹",259495) then
if Aura_time("target","野火炸弹","PLAYER|HARMFUL")<1.8 then ShowColor(mainbutton.icon, 6603,A_6);ShowSpell(debutton.icon, 259495) return end
end
--------------------------------------------------------------------------------
--actions+=/call_action_list,name=cleave,if=active_enemies>1
elseif active_enemies()>1 then
--actions.cleave+=/a_murder_of_crows
if PandaDB.SC_A7 ~= false  and Isuseable("夺命黑鸦",131894) then  ShowColor(mainbutton.icon, 6603,A_7);ShowSpell(debutton.icon, 131894) return end
--actions.cleave+=/coordinated_assault
if PandaDB.CcdSwitch ~= false  then
if PandaDB.SC_A2 ~= false  and Isuseable("协同进攻",266779)  then  ShowColor(mainbutton.icon, 6603,A_2);ShowSpell(debutton.icon, 266779) return end
end
--actions.cleave+=/carve,if=dot.shrapnel_bomb.ticking
if PandaDB.SC_C1 ~= false  and Isuseable("削凿",187708) and not IsTalent("屠戮") then 
if Aura_time("target","散射炸弹","PLAYER|HARMFUL")>0 then ShowColor(mainbutton.icon, 6603,C_1);ShowSpell(debutton.icon, 187708) return end
end
--actions.cleave+=/wildfire_bomb,if=!talent.guerrilla_tactics.enabled|full_recharge_time<gcd
if PandaDB.SC_A6 ~= false  and Isuseable("野火炸弹",259495) then
if not IsTalent("游击战术") or SpellFullCharges(259495)<GCD_MAX() then ShowColor(mainbutton.icon, 6603,A_6);ShowSpell(debutton.icon, 259495) return end
end
--actions.cleave+=/mongoose_bite,target_if=max:debuff.latent_poison.stack,if=debuff.latent_poison.stack=10
if PandaDB.SC_A3 ~= false  and Isuseable("猫鼬撕咬",259387) and IsTalent("猫鼬撕咬") then 
if Aura_Stack("TARGET","潜藏毒素","PLAYER|HARMFUL")==10 then ShowColor(mainbutton.icon, 6603,A_3);ShowSpell(debutton.icon, 259387) return end
end
--actions.cleave+=/chakrams
if PandaDB.SC_A8 ~= false  and Isuseable("飞轮",259391) then ShowColor(mainbutton.icon, 6603,A_8);ShowSpell(debutton.icon, 259391) return end
--actions.cleave+=/kill_command,target_if=min:bloodseeker.remains,if=focus+cast_regen<focus.max
if PandaDB.SC_A9 ~= false  and Isuseable("杀戮命令",259489) then
if Power("FOCUS")<PowerMax("FOCUS")-20 then  ShowColor(mainbutton.icon, 6603,A_9);ShowSpell(debutton.icon, 259489) return end
end
--actions.cleave+=/butchery,if=full_recharge_time<gcd|!talent.wildfire_infusion.enabled|dot.shrapnel_bomb.ticking&dot.internal_bleeding.stack<3
if PandaDB.SC_C1 ~= false  and Isuseable("屠戮",212436) and IsTalent("屠戮") then 
if SpellFullCharges(212436)<GCD_MAX() and not IsTalent("野火灌注") or Aura_time("target","散射炸弹","PLAYER|HARMFUL")>0 and Aura_Stack("target","内出血","PLAYER|HARMFUL")<3 then ShowColor(mainbutton.icon, 6603,C_1);ShowSpell(debutton.icon, 212436) return end
end
--actions.cleave+=/carve,if=talent.guerrilla_tactics.enabled
if PandaDB.SC_C1 ~= false  and Isuseable("削凿",187708) and not IsTalent("屠戮") then 
if IsTalent("游击战术") then ShowColor(mainbutton.icon, 6603,C_1);ShowSpell(debutton.icon, 187708) return end
end
--actions.cleave+=/flanking_strike,if=focus+cast_regen<focus.max
if PandaDB.SC_A5 ~= false  and Isuseable("侧翼打击",269751) then
if Power("FOCUS")<PowerMax("FOCUS") then  ShowColor(mainbutton.icon, 6603,A_5);ShowSpell(debutton.icon, 269751) return end
end
--actions.cleave+=/wildfire_bomb,if=dot.wildfire_bomb.refreshable|talent.wildfire_infusion.enabled
if PandaDB.SC_A6 ~= false  and Isuseable("野火炸弹",259495) then
if not IsTalent("野火灌注") and Aura_time("target","野火炸弹","PLAYER|HARMFUL")<1.8 or IsTalent("野火灌注") then ShowColor(mainbutton.icon, 6603,A_6);ShowSpell(debutton.icon, 259495) return end
end
--actions.cleave+=/serpent_sting,target_if=min:remains,if=buff.vipers_venom.react
if PandaDB.SC_A0 ~= false  and Isuseable("毒蛇钉刺",259491) then 
if Aura_time("PLAYER","蝰蛇毒液")>0 then  ShowColor(mainbutton.icon, 6603,A_0);ShowSpell(debutton.icon, 259491) return end 
end
--actions.cleave+=/carve,if=cooldown.wildfire_bomb.remains>variable.carve_cdr%2
if PandaDB.SC_C1 ~= false  and Isuseable("削凿",187708) and not IsTalent("屠戮") then 
if SpellCooldown(259495)>2.5 then ShowColor(mainbutton.icon, 6603,C_1);ShowSpell(debutton.icon, 187708) return end
end

--actions.cleave+=/serpent_sting,target_if=min:remains,if=refreshable&buff.tip_of_the_spear.stack<3
if PandaDB.SC_A0 ~= false  and Isuseable("毒蛇钉刺",259491) then 
if Aura_time("target","毒蛇钉刺","PLAYER|HARMFUL") <=4 and Aura_Stack("PLAYER","利矛之刃")<3 then  ShowColor(mainbutton.icon, 6603,A_0);ShowSpell(debutton.icon, 259491) return end 
end
--actions.cleave+=/mongoose_bite,target_if=max:debuff.latent_poison.stack
if PandaDB.SC_A3 ~= false  and Isuseable("猫鼬撕咬",259387) and IsTalent("猫鼬撕咬") then 
if Aura_Stack("TARGET","潜藏毒素","PLAYER|HARMFUL")>0 then ShowColor(mainbutton.icon, 6603,A_3);ShowSpell(debutton.icon, 259387) return end
end
--actions.cleave+=/raptor_strike,target_if=max:debuff.latent_poison.stack
if PandaDB.SC_A3 ~= false  and Isuseable("猛禽一击",186270) and not IsTalent("猫鼬撕咬") then 
if Aura_Stack("TARGET","潜藏毒素","PLAYER|HARMFUL")>0 then ShowColor(mainbutton.icon, 6603,A_3);ShowSpell(debutton.icon, 186270) return end
end

if PandaDB.SC_C1 ~= false  and Isuseable("屠戮",212436) and IsTalent("屠戮") then ShowColor(mainbutton.icon, 6603,C_1);ShowSpell(debutton.icon, 212436) return end

if PandaDB.SC_C1 ~= false  and Isuseable("削凿",187708) and not IsTalent("屠戮") then ShowColor(mainbutton.icon, 6603,C_1);ShowSpell(debutton.icon, 187708) return end

if PandaDB.SC_A3 ~= false  and Isuseable("猫鼬撕咬",259387) and IsTalent("猫鼬撕咬") then 
if PowerMax("FOCUS") - Power("FOCUS")<=15 then ShowColor(mainbutton.icon, 6603,A_3);ShowSpell(debutton.icon, 259387) return end
end

if PandaDB.SC_A3 ~= false  and Isuseable("猛禽一击",186270) and not IsTalent("猫鼬撕咬") then
if PowerMax("FOCUS") - Power("FOCUS")<=15 then ShowColor(mainbutton.icon, 6603,A_3);ShowSpell(debutton.icon, 186270) return end
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


local Hunter_Survival = Hunter_Survival
ns.Hunter_Survival = Hunter_Survival

