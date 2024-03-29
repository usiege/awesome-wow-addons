-- Author      : Kurapica
-- Create Date : 2013/09/12
-- Change Log  :

-- Check Version
local version = 1
if not IGAS:NewAddon("IGAS.Widget.Unit.MyHealPredictionBar", version) then
	return
end

__Doc__[[The prediction heal of the player]]
class "MyHealPredictionBar"
	inherit "StatusBar"
	extend "IFMyHealPrediction"

	_MyHealPredictionBarMap = _MyHealPredictionBarMap or setmetatable({}, {__mode = "kv"})

	------------------------------------------------------
	-- Script Handler
	------------------------------------------------------
	local function OnSizeChanged(self)
		if _MyHealPredictionBarMap[self] then
			_MyHealPredictionBarMap[self].Size = self.Size
		end
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
					_MyHealPredictionBarMap[self.__HealthBar] = nil
				end

				self.__HealthBar = value
				_MyHealPredictionBarMap[value] = self

				self:ClearAllPoints()
				self:SetPoint("TOPLEFT", value.StatusBarTexture, "TOPRIGHT")
				self.FrameLevel = value.FrameLevel + 2
				self.Size = value.Size

				value.OnSizeChanged = value.OnSizeChanged + OnSizeChanged
			end
		end,
		--Type = StatusBarString,
	}

	------------------------------------------------------
	-- Constructor
	------------------------------------------------------
    function MyHealPredictionBar(self, name, parent, ...)
		Super(self, name, parent, ...)

		self.StatusBarTexturePath = [[Interface\Tooltips\UI-Tooltip-Background]]
		self.StatusBarColor = ColorType(0, 0.827, 0.765)
    end
endclass "MyHealPredictionBar"