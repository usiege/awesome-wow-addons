---------------------------------------------------------------------------
--[[《《《《《《《《《《《    战斗系统   》》》》》》》》》》》]]--
---------------------------------------------------------------------------
local addon, ns = ...

local G_combat_time = G_combat_time or GetTime()
local G_incombat = G_incombat or false
local InCombat = InCombatLockdown()


--在战斗中
local function Combat()
local out = false
    if InCombatLockdown() then
        out = true
    else 
        out = false
    end
return out
end

--进入战斗 t 秒内 t 填时间
local function time_x(t)
    local out = false
	
    if not InCombat and G_incombat == true then
        G_incombat = false
    elseif  InCombat and G_incombat == false then
        G_incombat = true
        G_combat_time = GetTime()
    end
    
    if (G_incombat == true and GetTime() - G_combat_time  <t) or not InCombat then
        out = true
    end
    return out
end

--进入战斗 t 秒后 t 填时间
local function time_d(t)
    local out = false
	
    if not InCombat and G_incombat == true then
        G_incombat = false
    elseif  InCombat and G_incombat == false then
        G_incombat = true
        G_combat_time = GetTime()
    end
    
    if (G_incombat == true and GetTime() - G_combat_time  >t) then
        out = true
    end
    return out
end


---插件内接口
local Combat = Combat
ns.Combat = Combat

local time_x = time_x
ns.time_x = time_x

local time_d = time_d
ns.time_d = time_d