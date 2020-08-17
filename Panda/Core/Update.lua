local addon, ns = ...
local PDENV = ns.PDENV 

local OpenPandaGUI = ns.OpenPandaGUI
local UpdateClassInfo = ns.UpdateClassInfo
local UpdateSpecializationInfo = ns.UpdateSpecializationInfo
local UpdateTalentsInfo = ns.UpdateTalentsInfo

local UpdateAzerite = ns.UpdateAzerite 
local UpdateByDamage = ns.UpdateByDamage 
local UpdateAllSwitchbutton = ns.UpdateAllSwitchbutton 
local Updateshowbutton = ns.Updateshowbutton 


--local Update_Words = ns.Update_Words 



local Demon_Hunter_Havoc = ns.Demon_Hunter_Havoc
local Demon_Hunter_Vengeance = ns.Demon_Hunter_Vengeance

local Monk_Brewmaster = ns.Monk_Brewmaster 
local Monk_Windwalker = ns.Monk_Windwalker
local Monk_Wu = ns.Monk_Wu

local Paladin_Protection = ns.Paladin_Protection 
local Paladin_Retribution = ns.Paladin_Retribution
local Paladin_Shensheng = ns.Paladin_Shensheng

local Rogue_Assassination = ns.Rogue_Assassination 
local Rogue_Outlaw = ns.Rogue_Outlaw
local Rogue_Subtlety = ns.Rogue_Subtlety

local Hunter_Beast_Mastery = ns.Hunter_Beast_Mastery 
local Hunter_Marksmanship = ns.Hunter_Marksmanship
local Hunter_Survival = ns.Hunter_Survival

local Warlock_Destruction = ns.Warlock_Destruction 
local Warlock_Affliction = ns.Warlock_Affliction
local Warlock_Demonology = ns.Warlock_Demonology

local Death_Knight_Blood = ns.Death_Knight_Blood
local Death_Knight_Frost = ns.Death_Knight_Frost
local Death_Knight_Unholy = ns.Death_Knight_Unholy

local Druid_Balance = ns.Druid_Balance
local Druid_Feral = ns.Druid_Feral
local Druid_Guardian = ns.Druid_Guardian
local Druid_HuiFu = ns.Druid_HuiFu

local Mage_Arcane = ns.Mage_Arcane
local Mage_Fire = ns.Mage_Fire
local Mage_Frost = ns.Mage_Frost

local Priest_JieLv = ns.Priest_JieLv
local Priest_Shadow = ns.Priest_Shadow
local Priest_ShenSheng = ns.Priest_ShenSheng

local Shaman_Elemental = ns.Shaman_Elemental
local Shaman_Enhancement = ns.Shaman_Enhancement
local Shaman_Restoration = ns.Shaman_Restoration

local Warrior_Arms = ns.Warrior_Arms
local Warrior_Fury = ns.Warrior_Fury
local Warrior_Protection = ns.Warrior_Protection



local function UpdateClaas()
  local Class = select(2, UnitClass("player"))
  local Special = select(2, GetSpecializationInfo(GetSpecialization()))

  --DH
      if Class =="DEMONHUNTER" then
          if Special=="浩劫"  then
             Demon_Hunter_Havoc()
  		elseif Special =="复仇" then
             Demon_Hunter_Vengeance()
          end
      end
  --MONK	
  	if Class =="MONK" then
          if Special =="酒仙"  then
             Monk_Brewmaster()
  		elseif Special =="踏风" then
             Monk_Windwalker()
  		elseif Special =="织雾" then
             Monk_Wu()
          end
      end
  --PALADIN	
  	if Class == "PALADIN" then
  	
  	    if Special =="防护"  then
             Paladin_Protection()
  		elseif Special =="惩戒" then
             Paladin_Retribution()
  		elseif Special =="神圣" then
             Paladin_Shensheng()
          end
      end
  --ROGUE
    if Class =="ROGUE" then
        if Special =="奇袭"  then
           Rogue_Assassination()
    		elseif Special =="狂徒" then
               Rogue_Outlaw()
    		elseif Special =="敏锐" then
               Rogue_Subtlety()
        end
    end
  --HUNTER	
  	if Class =="HUNTER" then
          if Special =="野兽控制"  then
             Hunter_Beast_Mastery()
  		elseif Special =="射击" then
             Hunter_Marksmanship()
  		elseif Special =="生存" then
             Hunter_Survival()
          end	
  	end

  --WARLOCK	
  	if Class =="WARLOCK" then
          if Special =="毁灭"  then
             Warlock_Destruction()
  		elseif Special =="痛苦" then
             Warlock_Affliction()
  		elseif Special =="恶魔学识" then
             Warlock_Demonology()
          end		
      end

  --DRUID	
  	if Class =="DRUID" then
          if Special =="平衡"  then
             Druid_Balance()
  		elseif Special =="野性" then
             Druid_Feral()
  		elseif Special =="守护" then
             Druid_Guardian()
  		elseif Special =="恢复" then
             Druid_HuiFu()		   
          end		
      end
  	
  --DEATHKNIGHT	
  	if Class =="DEATHKNIGHT" then
          if Special =="鲜血"  then
             Death_Knight_Blood()
  		elseif Special =="冰霜" then
             Death_Knight_Frost()
  		elseif Special =="邪恶" then
             Death_Knight_Unholy()
          end		
      end

  --MAGE	
  	if Class =="MAGE" then
          if Special =="冰霜"  then
             Mage_Frost()
  		elseif Special =="火焰" then
             Mage_Fire()
  		elseif Special =="奥术" then
             Mage_Arcane()
          end		
      end
  	
  --PRIEST	
  	if Class =="PRIEST" then
          if Special =="戒律"  then
             Priest_JieLv()
  		elseif Special =="暗影" then
             Priest_Shadow()
  		elseif Special =="神圣" then
             Priest_ShenSheng()
          end		
      end
  	
  --SHAMAN	
  	if Class =="SHAMAN" then
          if Special =="元素"  then
             Shaman_Elemental()
  		elseif Special =="增强" then
             Shaman_Enhancement()
  		elseif Special =="恢复" then
             Shaman_Restoration()
          end		
      end

  --WARRIOR	
  	if Class =="WARRIOR" then
          if Special =="武器"  then
             Warrior_Arms()
  		elseif Special =="狂怒" then
             Warrior_Fury()
  		elseif Special =="防护" then
             Warrior_Protection()
          end		
      end

end




--登录游戏初始化
RegisterEvent("PLAYER_LOGIN", function(event)

    --伽马值
    SetCVar("Gamma",1)
    --对比度
    SetCVar("Contrast",50)
    --亮度
    SetCVar("Brightness",50)
    --插件尺寸
    PDUI:SetScale(PandaDB.scale)

    print("|cffffe00a★Panda★:【|r|c00FF68CC 输入命令 /PD 设置 |r|cffffe00a】|r ")

    if not PandaDB.AoeSwitch then  
    print("|cffffe00a★Panda★:【|r|c00FF68CC 当前模式:强制单体 |r|cffffe00a】|r ")  
    elseif PandaDB.AoeSwitch then  
    print("|cffffe00a★Panda★:【|r|c00FF68CC 当前模式:智能AOE |r|cffffe00a】|r ") 
    end
    	  
    if PandaDB.CcdSwitch then  
    print("|cffffe00a★Panda★:【|r|c00FF68CC 当前模式:开启大招 |r|cffffe00a】|r ")  
    elseif not PandaDB.CcdSwitch then  
    print("|cffffe00a★Panda★:【|r|c00FF68CC 当前模式:关闭大招 |r|cffffe00a】|r ") 
    end	
    	



    --更新基础信息	   
    UpdateAllSwitchbutton()
    UpdateClassInfo()
    UpdateSpecializationInfo()
    UpdateTalentsInfo()
    UpdateAzerite()

    UpdateClaas()
    --Update_Words()

    OpenPandaGUI()	
end)

--载入地图初始化
RegisterEvent("PLAYER_ENTERING_WORLD", function(event)
--伽马值
SetCVar("Gamma",1)
--对比度
SetCVar("Contrast",50)
--亮度
SetCVar("Brightness",50)

   UpdateAllSwitchbutton()

   UpdateClassInfo()
   UpdateSpecializationInfo()
   UpdateTalentsInfo()
   UpdateAzerite()

   --Update_Words()


   UpdateClaas()
end)



--玩家变更了专精的时候
RegisterEvent("PLAYER_SPECIALIZATION_CHANGED", function(arg1,arg2)
if arg2 == "player" then
--更新基础信息

UpdateSpecializationInfo()
UpdateTalentsInfo()
UpdateAzerite()

end
end)

--玩家变更了天赋的时候
RegisterEvent("PLAYER_TALENT_UPDATE", function()

UpdateSpecializationInfo()
UpdateTalentsInfo()

end)

	
--玩家变更了装备的时候
RegisterEvent("PLAYER_EQUIPMENT_CHANGED", function()
UpdateAzerite()

end)

--更换艾泽里特特质的时候
RegisterEvent("AZERITE_EMPOWERED_ITEM_SELECTION_UPDATED", function()
UpdateAzerite()
end)

--打开艾泽里特特质界面时候
RegisterEvent("RESPEC_AZERITE_EMPOWERED_ITEM_OPENED", function()
UpdateAzerite()
end)

--关闭艾泽里特特质界面时候
RegisterEvent("RESPEC_AZERITE_EMPOWERED_ITEM_CLOSED", function()
UpdateAzerite()
end)

--施法成功
RegisterEvent("UNIT_SPELLCAST_SUCCEEDED", function(arg1,arg2,arg3,arg4)

if arg2 == "player" then 
 UpdateClaas()
end

end)




--固定频率更新 ：
local updateInterval = 0.2 --统计间隔，单位：秒
local timeSinceLastUpdate = 0 --距离上次更新的时间
local Isuseable =ns.Isuseable
PDENV:SetScript("OnUpdate", function(self, elapsed)

   timeSinceLastUpdate = timeSinceLastUpdate + elapsed
   
   if timeSinceLastUpdate > updateInterval then
   
       UpdateByDamage()
       UpdateClaas()


       --Update_Words()

    	--collectgarbage("setpause",100)  
    	--collectgarbage("step",1000)
        --collectgarbage("setstepmul",200)  
    	
    	timeSinceLastUpdate = 0 
      
    end
end)