-- Author      : Kurapica
-- Create Date : 2012/07/14
-- Change Log  :

-- Check Version
local version = 3
if not IGAS:NewAddon("IGAS.Widget.Unit.IFRune", version) then
	return
end

_IFRuneUnitList = _IFRuneUnitList or UnitList(_Name)

SPELL_POWER_RUNES = ClassPowerMap.RUNES

function _IFRuneUnitList:OnUnitListChanged()
	self:RegisterEvent("RUNE_POWER_UPDATE")
	self:RegisterEvent("PLAYER_ENTERING_WORLD")
	self:RegisterEvent("UNIT_MAXPOWER")

	self.OnUnitListChanged = nil
end

function _IFRuneUnitList:ParseEvent(event, runeIndex, isEnergize)
	if event == "RUNE_POWER_UPDATE" then
		local max = UnitPowerMax("player", SPELL_POWER_RUNES)
		for obj in self:GetIterator("player") do
			obj:RefreshRunes(max)
		end
	elseif event == "UNIT_MAXPOWER" and runeIndex == "player" then
		local max = UnitPowerMax("player", SPELL_POWER_RUNES)
		for obj in self:GetIterator("player") do
			obj:SetMaxRune(max)
		end
	elseif event == "PLAYER_ENTERING_WORLD" then
		self:EachK("player", OnForceRefresh)
	end
end

function OnForceRefresh(self)
	if self.Unit == "player" then
		self:SetRuneVisible(true)

		local max = UnitPowerMax("player", SPELL_POWER_RUNES)

		self:SetMaxRune(max)
		self:RefreshRunes(max)
	else
		self:SetRuneVisible(false)
	end
end

__Doc__[[IFRune is used to handle the unit's rune power's updating]]
interface "IFRune"
	extend "IFUnitElement"

	------------------------------------------------------
	-- Method
	------------------------------------------------------
	function RefreshRunes(self, max)
	end

	__Doc__[[Set the max rune count to the element]]
	__Optional__() function SetMaxRune(self, max) end

	__Doc__[[Whether show or hide the rune bar]]
	__Optional__() function SetRuneVisible(self, show)
		self.Visible = show
	end

	------------------------------------------------------
	-- Property
	------------------------------------------------------

	------------------------------------------------------
	-- Event Handler
	------------------------------------------------------
	local function OnUnitChanged(self)
		if self.Unit == "player" then
			_IFRuneUnitList[self] = "player"
			self:SetRuneVisible(true)
		else
			_IFRuneUnitList[self] = nil
			self:SetRuneVisible(false)
		end
	end

	------------------------------------------------------
	-- Dispose
	------------------------------------------------------
	function Dispose(self)
		_IFRuneUnitList[self] = nil
	end

	------------------------------------------------------
	-- Initializer
	------------------------------------------------------
	function IFRune(self)
		if select(2, UnitClass("player")) == "DEATHKNIGHT" then
			self.OnUnitChanged = self.OnUnitChanged + OnUnitChanged
			self.OnForceRefresh = self.OnForceRefresh + OnForceRefresh
		else
			self:SetRuneVisible(false)
		end
	end
endinterface "IFRune"
