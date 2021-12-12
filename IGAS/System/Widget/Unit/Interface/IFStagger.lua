-- Author      : Kurapica
-- Create Date : 2013/03/09
-- Change Log  :

-- Check Version
local version = 1
if not IGAS:NewAddon("IGAS.Widget.Unit.IFStagger", version) then
	return
end

_IFStaggerUnitList = _IFStaggerUnitList or UnitList(_Name)
_IFStaggerUnitMaxHealthCache = _IFStaggerUnitMaxHealthCache or {}

_MinMax = MinMax(0, 1)

SPEC_MONK_BREWMASTER = _G.SPEC_MONK_BREWMASTER

function _IFStaggerUnitList:OnUnitListChanged()
	self:RegisterEvent("PLAYER_SPECIALIZATION_CHANGED")

	UpdateCondition(self)

	self.OnUnitListChanged = nil
end

function _IFStaggerUnitList:ParseEvent(event, unit)
	if unit and unit ~= "player" then return end

	if event == "UNIT_HEALTH_FREQUENT" then
		_MinMax.max = UnitHealthMax(unit)
		if _IFStaggerUnitMaxHealthCache[unit] ~= _MinMax.max then
			_IFStaggerUnitMaxHealthCache[unit] = _MinMax.max
			self:EachK(unit, "MinMaxValue", _MinMax)
		end

		self:EachK(unit, "Value", UnitStagger(unit) or 0)
	elseif event == "UNIT_MAXHEALTH" then
		_MinMax.max = UnitHealthMax(unit)
		_IFStaggerUnitMaxHealthCache[unit] = _MinMax.max
		self:EachK(unit, "MinMaxValue", _MinMax)

		self:EachK(unit, "Value", UnitStagger(unit) or 0)
	elseif event == "PLAYER_SPECIALIZATION_CHANGED" then
		UpdateCondition(self)
	end
end

function UpdateCondition(self)
	-- Only for player now
	if SPEC_MONK_BREWMASTER == GetSpecialization() then
		self:RegisterEvent("UNIT_MAXHEALTH")
		self:RegisterEvent("UNIT_HEALTH_FREQUENT")
		self:EachK("player", "Visible", true)
		self:EachK("player", "Refresh")
	else
		self:UnregisterEvent("UNIT_MAXHEALTH")
		self:UnregisterEvent("UNIT_HEALTH_FREQUENT")
		self:EachK("player", "Visible", false)
	end
end

__Doc__[[IFStagger is used to handle the unit's stagger]]
interface "IFStagger"
	extend "IFUnitElement"

	------------------------------------------------------
	-- Method
	------------------------------------------------------
	function Refresh(self)
		if self.Unit == "player" and select(2, UnitClass("player")) == "MONK" and SPEC_MONK_BREWMASTER == GetSpecialization() then
			_MinMax.max = UnitHealthMax("player")
			if _MinMax.max == 0 then _MinMax.max = 100 end -- Keep safe
			self.MinMaxValue = _MinMax
			self.Value = UnitStagger("player") or 0
		else
			self.Value = 0
			self.Visible = false
		end
	end

	------------------------------------------------------
	-- Property
	------------------------------------------------------
	__Doc__[[used to receive the min and max value of the health]]
	__Optional__() property "MinMaxValue" { Type = MinMax }

	__Doc__[[used to receive the stagger's value]]
	__Optional__() property "Value" { Type = Number }

	__Doc__[[used to receive the result whether should show the stagger value]]
	__Optional__() property "Visible" { Type = Boolean }

	------------------------------------------------------
	-- Event Handler
	------------------------------------------------------
	local function OnUnitChanged(self)
		if self.Unit == "player" then
			_IFStaggerUnitList[self] = self.Unit
		else
			_IFStaggerUnitList[self] = nil
		end
	end

	------------------------------------------------------
	-- Dispose
	------------------------------------------------------
	function Dispose(self)
		_IFStaggerUnitList[self] = nil
	end

	------------------------------------------------------
	-- Initializer
	------------------------------------------------------
	function IFStagger(self)
		if select(2, UnitClass("player")) == "MONK" then
			self.OnUnitChanged = self.OnUnitChanged + OnUnitChanged
			self.MouseEnabled = false
		else
			self.Visible = false
		end
	end
endinterface "IFStagger"