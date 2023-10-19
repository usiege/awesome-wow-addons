-- Author      : Kurapica
-- Create Date : 2012/07/14
-- Change Log  :

-- Check Version
local version = 3
if not IGAS:NewAddon("IGAS.Widget.Unit.IFRune", version) then
	return
end

_All = "all"
_IFRuneUnitList = _IFRuneUnitList or UnitList(_Name)

SPELL_POWER_RUNES = _G.SPELL_POWER_RUNES

MAX_RUNES = 6

function _IFRuneUnitList:OnUnitListChanged()
	self:RegisterEvent("RUNE_POWER_UPDATE")
	self:RegisterEvent("RUNE_TYPE_UPDATE")
	self:RegisterEvent("PLAYER_ENTERING_WORLD")
	self:RegisterEvent("UNIT_MAXPOWER")

	self.OnUnitListChanged = nil
end

function _IFRuneUnitList:ParseEvent(event, runeIndex, isEnergize)
	if event == "RUNE_POWER_UPDATE" and  runeIndex then
		self:EachK(_All, UpdatePower, runeIndex, isEnergize)
	elseif event == "UNIT_MAXPOWER" and runeIndex == "player" then
		local max = UnitPowerMax("player", SPELL_POWER_RUNES)
		self:EachK(_All, "Max", max)
	elseif event == "RUNE_TYPE_UPDATE" and runeIndex then
		self:EachK(_All, UpdatePowerType, runeIndex)
	elseif event == "PLAYER_ENTERING_WORLD" then
		local max = UnitPowerMax("player", SPELL_POWER_RUNES)
		self:EachK(_All, "Max", max)
		for i = 1, max do
			self:EachK(_All, UpdatePower, i)
		end
	end
end

function UpdatePowerType(self, index)
	self:Refresh(index)
end

function UpdatePower(self, index, isEnergize)
	if self[index] then
		local start, duration, runeReady = GetRuneCooldown(index)

		if not runeReady then
			if start then
				self[index]:Fire("OnCooldownUpdate", start, duration)
			end
			self[index].Ready = false
		else
			self[index].Ready = true
		end

		self[index].Energize = isEnergize
	end
end

__Doc__[[
	<desc>IFRune is used to handle the unit's rune power's updating</desc>
	<optional name="Visible" type="property" valuetype="boolean">used to receive the check result that whether the rune power should be shown</optional>
	<usage>
		For default, the object should has MAX_RUNES elements, each elements should extend System.Widget.IFCooldown and with several properties :
			Ready property, boolean, whether the rune is Ready
			Energize property, boolean, whether the rune is energized
	</usage>
]]
interface "IFRune"
	extend "IFUnitElement"

	------------------------------------------------------
	-- Method
	------------------------------------------------------
	__Doc__[[The default refresh method, overridable]]
	function Refresh(self, index)
		if index then
			UpdatePower(self, i)
		else
			local max = UnitPowerMax("player", SPELL_POWER_RUNES)
			self.Max = max

			for i = 1, max do
				UpdatePower(self, i)
			end
		end
	end

	------------------------------------------------------
	-- Property
	------------------------------------------------------

	------------------------------------------------------
	-- Event Handler
	------------------------------------------------------
	local function OnUnitChanged(self)
		if self.Unit == "player" then
			_IFRuneUnitList[self] = _All
		else
			_IFRuneUnitList[self] = nil
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
		else
			self.Visible = false
		end
	end
endinterface "IFRune"