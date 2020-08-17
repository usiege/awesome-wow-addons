---------------------------------------------------------------------------
--[[《《《《《《《《《《《    装备系统   》》》》》》》》》》》]]--
---------------------------------------------------------------------------
local addon, ns = ...


--已穿 XX 装备 itemid填装备ID
local function IsEquipped(itemid) 
    local IsEquipped = IsEquippedItem(itemid)    
    if IsEquipped  == true  then   
    return true  
	else return false
    end
end


--物品、玩具、饰品、装备的冷却时间 itemid填装备ID      
local function ItemCooldown(Itemid)         
    local s,d,e=GetSpellCooldown("193455");
    local s1,d1,e1 = GetItemCooldown(Itemid)
    local gcd=0
    local cd = 0
    if d1 >0 then
        gcd=s+d-GetTime()
        cd=s1+d1-GetTime()
    end 
    if gcd >=  cd then
        return 0
    else
        return cd
    end    
end

--判断物品、玩具、饰品、装备是否能使用  name填中文名字 ID填装备ID
local function Itemuseable(name,ID)
local value
local A = IsUsableSpell(name)
local B = ItemCooldown(ID)

 if A == true and B == 0 then
 value = true 
 else value = false
 end
 return value
end

--更新艾泽里特特质

local slot_table = {1, 3, 5}
local AZLT = {}

local function UpdateAzerite()
 wipe(AZLT)  
    for k, v in pairs(slot_table) do
        local itemLink = GetInventoryItemLink("player", v)
        local itemL = Item:CreateFromEquipmentSlot(v)
        local ItemLocation = itemL:GetItemLocation()
        if C_AzeriteEmpoweredItem.IsAzeriteEmpoweredItemByID(itemLink) then
            local allTierInfo = C_AzeriteEmpoweredItem.GetAllTierInfoByItemID(itemLink)
            for k, v in pairs(allTierInfo) do
                for k1, PowerID in pairs(allTierInfo[k].azeritePowerIDs) do
                    local powerInfo = C_AzeriteEmpoweredItem.GetPowerInfo(PowerID)
                    if (powerInfo) then
                        local azeriteSpellID = powerInfo["spellID"]
                        local azeritePowerName = GetSpellInfo(azeriteSpellID)
                        local isSelected = C_AzeriteEmpoweredItem.IsPowerSelected(ItemLocation,PowerID)
                        if isSelected then
                            AZLT[azeritePowerName] = AZLT[azeritePowerName] or 0
                            AZLT[azeritePowerName] = AZLT[azeritePowerName] + 1
                        end
                    end
                end
            end
        end
    end
end

--有效的艾泽里特特质数量 azlt_name 填特质中文名字	
local function AzltE(azlt_name)
    if AZLT[azlt_name] ~= nil then
        return AZLT[azlt_name]
    else
        return 0
    end
	
end

---旧版本套装数 x填T几套装 K填数量   
local function Tier(x,k)             
    local h=0
    for itemid=147157,147162
    do
        if  IsEquippedItem(itemid) == true
        then
            x=20;
            h=h+1
        end
    end
    for itemid=152148,152153
    do
        if  IsEquippedItem(itemid) == true
        then
            x=21;
            h=h+1
        end
    end
    if h>=k then return true
        
    end
    
end


---插件内接口
local IsEquipped = IsEquipped
ns.IsEquipped = IsEquipped

local ItemCooldown = ItemCooldown
ns.ItemCooldown = ItemCooldown

local Itemuseable = Itemuseable
ns.Itemuseable = Itemuseable

local UpdateAzerite = UpdateAzerite
ns.UpdateAzerite = UpdateAzerite

local AzltE = AzltE
ns.AzltE = AzltE

local Tier = Tier
ns.Tier = Tier