---------------------------------------------------------------------------
--[[《《《《《《《《《《《 职业、专精、天赋》》》》》》》》》》》]]--
---------------------------------------------------------------------------
local addon, ns = ...


G_PlayerInfo = {
    Class = {},
    Talent = {},
    Specialization = {}
}

--更新职业
local function UpdateClassInfo()
local name = select(2, UnitClass("player"))
G_PlayerInfo.Class = name
end

--玩家职业
local function PlayerClass()
return G_PlayerInfo.Class
end

--更新专精
local function UpdateSpecializationInfo()
local id, name = GetSpecializationInfo(GetSpecialization())
G_PlayerInfo.Specialization = name
end

--玩家专精
local function Specialization()
return G_PlayerInfo.Specialization
end

--更新天赋
local function UpdateTalentsInfo()
    for i=1,7 do
        for j=1,3 do
            local _,TalentName,_,IsEnabled = GetTalentInfo(i,j,1)
            if TalentName then
                G_PlayerInfo.Talent[TalentName] = IsEnabled
            end
        end
    end
end

--玩家天赋 TalentName 填天赋中文名
local function IsTalent(TalentName)
    return G_PlayerInfo.Talent[TalentName]
end


---插件内接口
local UpdateClassInfo = UpdateClassInfo
ns.UpdateClassInfo = UpdateClassInfo

local PlayerClass = PlayerClass
ns.PlayerClass = PlayerClass

local UpdateSpecializationInfo = UpdateSpecializationInfo
ns.UpdateSpecializationInfo = UpdateSpecializationInfo

local Specialization = Specialization
ns.Specialization = Specialization

local UpdateTalentsInfo = UpdateTalentsInfo
ns.UpdateTalentsInfo = UpdateTalentsInfo

local IsTalent = IsTalent
ns.IsTalent = IsTalent