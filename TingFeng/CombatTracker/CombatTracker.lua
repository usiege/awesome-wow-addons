-- Set up some local variables to track time and damage
local start_time = 0
local end_time = 0
local total_time = 0
local total_damage = 0
local average_dps = 0

function CombatTracker_OnLoad(frame)
    frame:RegisterEvent("UNIT_COMBAT")
    frame:RegisterEvent("PLAYER_REGEN_ENABLED")
    frame:RegisterEvent("PLAYER_REGEN_DISABLED")
    frame:RegisterForClicks("RightButtonUp")
    frame:RegisterForDrag("LeftButton")
end

function CombatTracker_OnEvent(frame, event, ...)
    if event == "PLAYER_REGEN_ENABLED" then
        -- this event is called when the player exits combat
        end_time = GetTime()
        total_time = end_time - start_time
        CombatTracker_UpdateText()
    elseif event == "PLAYER_REGEN_DISABLED" then
        -- this event is called when we enter combat 
        -- reset the damage total and start the timer
        CombatTrackerFrameText:SetText("In Combat")
        total_damage = 0
        start_time = GetTime()
    elseif event == "UNIT_COMBAT" then
        if not InCombatLockdown() then
            -- we are not in combat, so ignore the event
        else
            local unit, action, modifier, damage, damagetype = ...
            if unit == "player" and action ~= "HEAL" then
                total_damage = total_damage + damage
                end_time = GetTime()
                total_time = end_time - start_time
                average_dps = total_damage / total_time
                CombatTracker_UpdateText()
            end
        end
    end 
end

function CombatTracker_UpdateText()
    local status = string.format("%d s | %d dmg | %.2f dps", total_time, total_damage, average_dps)
    CombatTrackerFrameText:SetText(status)
end

function CombatTracker_ReportDPS()
    local msgformat = "%d seconds spent in combat with %d incoming damage. \
    Average incoming DPS was %.2f"
    local msg = string.format(msgformat, total_time, total_damage, average_dps)
    ChatFrame3:AddMessage(msg)
end
