local addon, ns = ...

--时间能整除
local function Time_fmod(mathString)
local ceil = math.ceil
local fmod = math.fmod

local V1 = ceil(GetTime())
local V2 = fmod(V1,mathString)

local slout = false
if V2 == 0 then
slout = true   
else slout = false
end

return slout
end



--[[
G_TimeInfo = {
   Auth = {},
    MONK = {},
	ROGUE = {},
	HUNTER = {},
	PALADIN = {},
    DEMONHUNTER = {}
}


local function string2time( timeString )
    local Y = string.sub(timeString , 1, 4)
    local M = string.sub(timeString , 5, 6)
    local D = string.sub(timeString , 7, 8)
	local T = time({year=Y, month=M, day=D, hour=0,min=0,sec=0})
    return T
end

local function CheckFriend()
local solot = false
local _,Myname = BNGetInfo()
	for i=1,1000 do
    local _,_,username = BNGetFriendInfo(i)
	local ARname = "旧城往事绕#5300"
	    if username == ARname or Myname == ARname then
		solot = true 
	    end
    end
return solot

end

local function UpdateTimeInfo()
local Authtime = string2time(20200601000)
   
    if CheckFriend() == true then
        G_TimeInfo.Auth = Authtime
    else G_TimeInfo.Auth = 0
    end

end


RegisterEvent("PLAYER_LOGIN", function(event)
UpdateTimeInfo()
end)

RegisterEvent("BN_FRIEND_INFO_CHANGED", function(event)
UpdateTimeInfo()
end)



local function Authorization()
    local T1=time()
    if T1 < G_TimeInfo.Auth
    then return true
    else return false
    end
end



--]]


---插件内接口
local Time_fmod = Time_fmod
ns.Time_fmod = Time_fmod

--local UpdateTimeInfo = UpdateTimeInfo
--ns.UpdateTimeInfo = UpdateTimeInfo

--local Authorization = Authorization
--ns.Authorization = Authorization

--local CheckFriend = CheckFriend
--ns.CheckFriend = CheckFriend