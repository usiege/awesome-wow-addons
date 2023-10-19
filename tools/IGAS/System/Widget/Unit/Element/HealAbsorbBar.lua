-- Author      : Kurapica
-- Create Date : 2013/09/12
-- Change Log  :

-- Check Version
local version = 1
if not IGAS:NewAddon("IGAS.Widget.Unit.HealAbsorbBar", version) then
	return
end

__Doc__[[The heal absorb of the unit]]
class "HealAbsorbBar"
	inherit "StatusBar"
	extend "IFHealAbsorb"

	_HealAbsorbBarMap = _HealAbsorbBarMap or setmetatable({}, {__mode = "kv"})

	------------------------------------------------------
	-- Script Handler
	------------------------------------------------------
	local function OnSizeChanged(self)
		if _HealAbsorbBarMap[self] then
			_HealAbsorbBarMap[self].Size = self.Size
		end
	end

	------------------------------------------------------
	-- Method
	------------------------------------------------------
	local oldSetValue = Super.SetValue
	local oldSetMinMaxValues = Super.SetMinMaxValues
	local oldGetWidth = Super.GetWidth

	function SetValue(self, value)
		if self.__Value ~= value then
			self.__Value = value

			oldSetValue(self, value)

			local width = oldGetWidth(self)

			if self.__HealthBar then
				self:SetPoint("TOPLEFT", self.__HealthBar.StatusBarTexture, "TOPRIGHT", - width * value / self.__MaxHealth, 0)
			end
		end
	end

	function SetMinMaxValues(self, min, max)
		self.__MaxHealth = max
		oldSetMinMaxValues(self, min, max)
	end

	------------------------------------------------------
	-- Property
	------------------------------------------------------
	__Doc__[[The target health bar the prediction bar should attach to]]
	property "HealthBar" {
		Field = "__HealthBar",
		Set = function(self, value)
			if type(value) == "string" then
				value = self.Parent:GetChild(value)

				if not value then return end
			end

			if self.__HealthBar ~= value then
				if self.__HealthBar then
					self.__HealthBar.OnSizeChanged = self.__HealthBar.OnSizeChanged - OnSizeChanged
					_HealAbsorbBarMap[self.__HealthBar] = nil
				end

				self.__HealthBar = value
				_HealAbsorbBarMap[value] = self

				self:ClearAllPoints()
				self:SetPoint("TOPLEFT", value.StatusBarTexture, "TOPRIGHT")
				self.FrameLevel = value.FrameLevel + 2
				self.Size = value.Size

				self.OverGlow:ClearAllPoints()
				self.OverGlow:SetPoint("BOTTOMRIGHT", value, "BOTTOMLEFT", 7, 0)
				self.OverGlow:SetPoint("TOPRIGHT", value, "TOPLEFT", 7, 0)

				value.OnSizeChanged = value.OnSizeChanged + OnSizeChanged
			end
		end,
		--Type = StatusBarString,
	}

	__Handler__( function (self, value) self.OverGlow.Visible = value end )
	property "OverAbsorb" { }

	property "HasIncomingHeal" {
		Field = "__HasIncomingHeal",
		Set = function(self, value)
			if self.__Value == 0 then
				value = true
			end

			if self.__HasIncomingHeal ~= value then
				self.__HasIncomingHeal = value
				self.LeftShadow.Visible = not value
			end
		end,
	}

	__Handler__( function (self, value) self.RightShadow.Visible = value end )
	property "HasAbsorb" { }

	------------------------------------------------------
	-- Constructor
	------------------------------------------------------
    function HealAbsorbBar(self, name, parent, ...)
		Super(self, name, parent, ...)

    	self.__MaxHealth = 0

    	self.StatusBarTexturePath = [[Interface\RaidFrame\Absorb-Fill]]

    	local leftShadow = Texture("LeftShadow", self)
    	leftShadow.TexturePath = [[Interface\RaidFrame\Absorb-Edge]]
		leftShadow:SetPoint("TOPLEFT", self.StatusBarTexture, "TOPLEFT", 0, 0)
		leftShadow:SetPoint("BOTTOMLEFT", self.StatusBarTexture, "BOTTOMLEFT", 0, 0)
		leftShadow.Visible = false
		leftShadow.Width = 8

    	local rightShadow = Texture("RightShadow", self)
    	rightShadow.TexturePath = [[Interface\RaidFrame\Absorb-Edge]]
    	rightShadow:SetTexCoord(1, 0, 0, 1)
		rightShadow:SetPoint("TOPLEFT", self.StatusBarTexture, "TOPRIGHT", -8, 0)
		rightShadow:SetPoint("BOTTOMLEFT", self.StatusBarTexture, "BOTTOMRIGHT", -8, 0)
		rightShadow.Visible = false
		rightShadow.Width = 8

    	local overGlow = Texture("OverGlow", self)

    	overGlow.BlendMode = "ADD"
    	overGlow.TexturePath = [[Interface\RaidFrame\Absorb-Overabsorb]]
    	overGlow.Width = 16
    	overGlow.Visible = false
    end
endclass "HealAbsorbBar"