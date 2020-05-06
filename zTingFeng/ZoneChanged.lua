WelcomeHome = LibStub("AceAddon-3.0"):NewAddon("WelcomeHome", "AceConsole-3.0", "AceEvent-3.0")

function WelcomeHome:OnInitialize()
    -- Called when the addon is loaded
end

function WelcomeHome:OnEnable()
	-- 区域发生变化时
    self:RegisterEvent("ZONE_CHANGED")
end

function WelcomeHome:ZONE_CHANGED()
    self:Print("You have changed zones!")

    -- 当前炉石所在区域
    self:Print(GetBindLocation())
    self:Print("================")
    -- 当前所在区域
    self:Print(GetSubZoneText())
end