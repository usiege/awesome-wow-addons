-- Author      : Kurapica
-- Create Date : 2012/06/25
-- Change Log  :

-- Check Version
local version = 3
if not IGAS:NewAddon("IGAS.Widget.Unit.HealthBar", version) then
	return
end

_DEBUFF_ABILITIES = {
	["WARRIOR"] = { },
	["ROGUE"] = { },
	["HUNTER"] = { },
	["MAGE"] = { Curse = true, },
	["DRUID"] = { Poison = true, Curse = true, Magic = true, },
	["PALADIN"] = { Poison = true, Disease = true, Magic = true, },
	["PRIEST"] = { Disease = true, Magic = true, },
	["SHAMAN"] = { Curse = true, Magic = true, },
	["WARLOCK"] = { Magic = true, },
	["DEATHKNIGHT"] = { },
	["MONK"] = { Poison = true, Disease = true, Magic = true, },
}

_DEBUFF_ABLE = _DEBUFF_ABILITIES[select(2, UnitClass('player'))] or {}
_DEBUFF_ABILITIES = nil

_ColorMap = {
	Magic = DebuffTypeColor.Magic,
	Curse = DebuffTypeColor.Curse,
	Disease = DebuffTypeColor.Disease,
	Poison = DebuffTypeColor.Poison,

	GlobalDefault = ColorType(0, 1, 0),

    HUNTER = RAID_CLASS_COLORS.HUNTER,
    WARLOCK = RAID_CLASS_COLORS.WARLOCK,
    PRIEST = RAID_CLASS_COLORS.PRIEST,
    PALADIN = RAID_CLASS_COLORS.PALADIN,
    MAGE = RAID_CLASS_COLORS.MAGE,
    ROGUE = RAID_CLASS_COLORS.ROGUE,
    DRUID = RAID_CLASS_COLORS.DRUID,
    SHAMAN = RAID_CLASS_COLORS.SHAMAN,
    WARRIOR = RAID_CLASS_COLORS.WARRIOR,
    DEATHKNIGHT = RAID_CLASS_COLORS.DEATHKNIGHT,
    MONK = RAID_CLASS_COLORS.MONK,
}

function HealthBar_OnStateChanged(self, value)
	if not self.Unit then return end
	local value = self.Value
	if not value then return end

	local color
	local r, g, b
	local min, max = self:GetMinMaxValues()
	if ( (value < min) or (value > max) ) then return end
	if ( (max - min) > 0 ) then
		value = (value - min) / (max - min)
	else
		value = 0
	end

	-- Choose color
	if self.UseDebuffColor and not UnitCanAttack("player", self.Unit) then
		if _DEBUFF_ABLE['Magic'] and self.HasMagic then
			color = "Magic"
		elseif _DEBUFF_ABLE['Curse'] and self.HasCurse then
			color = "Curse"
		elseif _DEBUFF_ABLE['Disease'] and self.HasDisease then
			color = "Disease"
		elseif _DEBUFF_ABLE['Poison'] and self.HasPoison then
			color = "Poison"
		end
	end

	if not color then
		color = self.DefaultColor and "Default" or self.UseClassColor and select(2, UnitClass(self.Unit)) or "GlobalDefault"

		if self.UseSmoothColor then
			value = floor(value * 10) / 10

			if self.__HealthBar_PreColor == color and self.__HealthBar_PreValue == value then return end

			if color == "Default" then
				r, g, b = self.DefaultColor.r, self.DefaultColor.g, self.DefaultColor.b
			else
				r, g, b = _ColorMap[color].r, _ColorMap[color].g, _ColorMap[color].b
			end

			self.__HealthBar_PreValue = value

			-- Smooth the color
			if value > 0.5 then
				r = (1 - value) * 2 * (1 - r) + r
				b = b - b * (1-value) * 2
			else
				r = 1
				g = g * value * 2
				b = 0
			end
		else
			if self.__HealthBar_PreColor == color then return end

			if color == "Default" then
				r, g, b = self.DefaultColor.r, self.DefaultColor.g, self.DefaultColor.b
			else
				r, g, b = _ColorMap[color].r, _ColorMap[color].g, _ColorMap[color].b
			end
		end
	else
		if self.__HealthBar_PreColor == color then return end

		r, g, b = _ColorMap[color].r, _ColorMap[color].g, _ColorMap[color].b
	end

	self.__HealthBar_PreColor = color

	return self:SetStatusBarColor(r, g, b)
end

__Doc__[[The health bar with debuff state]]
class "HealthBar"
	inherit "StatusBar"
	extend "IFHealth" "IFDebuffState"

	------------------------------------------------------
	-- Method
	------------------------------------------------------
	------------------------------------
	--- Refresh the element
	-- -- ------------------------------------
	function Refresh(self)
		IFHealth.Refresh(self)
		IFDebuffState.Refresh(self)
		return HealthBar_OnStateChanged(self)
	end

	------------------------------------------------------
	-- Property
	------------------------------------------------------
	__Doc__[[Whether use the debuff color]]
	__Handler__(HealthBar_OnStateChanged)
	property "UseDebuffColor" { Type = Boolean, }

	__Doc__[[Whether use the unit's class color]]
	__Handler__(HealthBar_OnStateChanged)
	property "UseClassColor" { Type = Boolean, }

	__Doc__[[Whether smoothing the color changing]]
	__Handler__(HealthBar_OnStateChanged)
	property "UseSmoothColor" { Type = Boolean, }

	__Doc__[[The default status bar's color]]
	__Handler__(HealthBar_OnStateChanged)
	property "DefaultColor" { Type = ColorType }

	------------------------------------------------------
	-- Constructor
	------------------------------------------------------
	function HealthBar(self, name, parent, ...)
		Super(self, name, parent, ...)

		self.OnStateChanged = self.OnStateChanged + HealthBar_OnStateChanged
		self.OnValueChanged = self.OnValueChanged + HealthBar_OnStateChanged

		self.FrameStrata = "LOW"
	end
endclass "HealthBar"

__Doc__[[The frequent health bar with debuff state]]
class "HealthBarFrequent"
	inherit "StatusBar"
	extend "IFHealthFrequent" "IFDebuffState"

	------------------------------------------------------
	-- Method
	------------------------------------------------------
	------------------------------------
	--- Refresh the element
	-- -- ------------------------------------
	function Refresh(self)
		IFHealthFrequent.Refresh(self)
		IFDebuffState.Refresh(self)
		HealthBar_OnStateChanged(self)
	end

	------------------------------------------------------
	-- Property
	------------------------------------------------------
	__Doc__[[Whether use the debuff color]]
	__Handler__(HealthBar_OnStateChanged)
	property "UseDebuffColor" { Type = Boolean, }

	__Doc__[[Whether use the unit's class color]]
	__Handler__(HealthBar_OnStateChanged)
	property "UseClassColor" { Type = Boolean, }

	__Doc__[[Whether smoothing the color changing]]
	__Handler__(HealthBar_OnStateChanged)
	property "UseSmoothColor" { Type = Boolean, }

	__Doc__[[The default status bar's color]]
	__Handler__(HealthBar_OnStateChanged)
	property "DefaultColor" { Type = ColorType }
	------------------------------------------------------
	-- Constructor
	------------------------------------------------------
	function HealthBarFrequent(self, name, parent, ...)
		Super(self, name, parent, ...)

		self.OnStateChanged = self.OnStateChanged + HealthBar_OnStateChanged
		self.OnValueChanged = self.OnValueChanged + HealthBar_OnStateChanged

		self.FrameStrata = "LOW"
	end
endclass "HealthBarFrequent"