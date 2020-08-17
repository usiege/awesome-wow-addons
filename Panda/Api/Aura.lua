---------------------------------------------------------------------------
--[[《《《《《《《《《《《    光环系统   》》》》》》》》》》》]]--
---------------------------------------------------------------------------
local addon, ns = ...
--某光环剩余时间
local function Aura_time(unit,name,filter)--"格式：Aura_time("player","中文名","PLAYER|HELPFUL") 或 Aura_time("target","中文名","PLAYER|HARMFUL")
    local n = 0
    local G_time = GetTime()
	
	if not unit or not name then return end
    
	for z = 1, 200 do
        local AuraName,_, AuraCounts, _, AuraDuration, AuraExpirationTime, unitCaster, _, _, AuraSpellID = UnitAura(unit, z, filter)
        
        if  AuraName == name then
            return AuraExpirationTime - G_time
        end
    end
    
    return n
end

--某光环个数
local function Aura_count(unit,name,filter)--"格式：Aura_count("player","中文名","PLAYER|HELPFUL") 或 Aura_count("target","中文名","PLAYER|HARMFUL")
    local n = 0

    if not unit or not name then return end

    for z = 1, 200 do
        local AuraName,_, AuraCounts, _, AuraDuration, AuraExpirationTime, unitCaster, _, _, AuraSpellID = UnitAura(unit, z, filter)
        
		if not AuraName then
            return n
        elseif AuraName == name then
            n = n + 1
        end
		
    end
    
    return n
end

--某光环层数
local function Aura_Stack(unit,name,filter)--"Aura_Stack("player","中文名","PLAYER|HELPFUL") 或 Aura_time("target","中文名","PLAYER|HARMFUL")
    local n = 0
	
	if not unit or not name then return end
    
	for z = 1, 200 do
        local AuraName,_, AuraCounts, _, AuraDuration, AuraExpirationTime, unitCaster, _, _, AuraSpellID = UnitAura(unit, z, filter)
        
        if  AuraName == name then
            return AuraCounts - n
        end
		
    end
    
    return n
end

---有无嗜血                        
local function IsBloodlust()
local A1 = Aura_count("player","英勇")
local A2 = Aura_count("player","嗜血")
local A3 = Aura_count("player","原始暴怒")
local A4 = Aura_count("player","时间扭曲")
local A5 = Aura_count("player","暴怒之鼓")
local A6 = Aura_count("player","漩涡战鼓")
local A7 = Aura_count("player","狂怒战鼓")
local A8 = Aura_count("player","高山战鼓")
local A9 = Aura_count("player","虚空之风")
local A0 = Aura_count("player","远古狂乱")
local Solout = false
if A0>0 or A1>0 or A2>0 or A3>0 or A4>0 or A5>0 or A6>0 or A7>0 or A8>0 or A9>0 then
Solout = true else Solout = false
end
return Solout
end

---插件内接口
local Aura_time = Aura_time
ns.Aura_time = Aura_time
local Aura_count = Aura_count
ns.Aura_count = Aura_count
local Aura_Stack = Aura_Stack
ns.Aura_Stack = Aura_Stack
local IsBloodlust = IsBloodlust
ns.IsBloodlust = IsBloodlust

------未使用
--[[
local function NewAura(types,unit,name,filter)-----新Aura types：time count stack

    local n = 1
    local G_time = GetTime()
	
	local aura = 0
	
	if not types or not unit or not name then return end
    
    local AuraName,_, AuraCounts,AuraType, AuraDuration, AuraExpirationTime, unitCaster,isStealable, _, AuraSpellID = UnitAura(unit, n, filter)
       
	while AuraName do
        if AuraName == name then
		    if types == "time" then   
			    aura =  AuraExpirationTime - G_time
			 elseif types == "count" then
			    aura =  aura + 1
			 elseif types == "stack" then	
			    aura =  AuraCounts - aura
            end
		end 
            n = n + 1
            AuraName,_, AuraCounts,AuraType, AuraDuration, AuraExpirationTime, unitCaster,isStealable, _, AuraSpellID = UnitAura(unit, n, filter)
    end
	

    
    return aura	
end
--]]