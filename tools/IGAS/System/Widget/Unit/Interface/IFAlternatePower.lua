-- Author      : Kurapica
-- Create Date : 2012/08/06
-- Change Log  :

-- Check Version
local version = 1
if not IGAS:NewAddon("IGAS.Widget.Unit.IFAlternatePower", version) then
	return
end

ALTERNATE_POWER_INDEX = _G.ALTERNATE_POWER_INDEX
ALT_POWER_TYPE_COUNTER = _G.ALT_POWER_TYPE_COUNTER

_IFAlternatePowerUnitList = _IFAlternatePowerUnitList or UnitList(_Name)

function _IFAlternatePowerUnitList:OnUnitListChanged()
	self:RegisterEvent("UNIT_MAXPOWER")
	self:RegisterEvent("UNIT_POWER")
	self:RegisterEvent("UNIT_POWER_BAR_SHOW")
	self:RegisterEvent("UNIT_POWER_BAR_HIDE")
	self.OnUnitListChanged = nil
end

function _IFAlternatePowerUnitList:ParseEvent(event, unit, powerType)
	if event == "UNIT_POWER_BAR_SHOW" or event == "UNIT_POWER_BAR_HIDE" then
		self:EachK(unit, UpdateBar)
	elseif event == "UNIT_MAXPOWER" and powerType == "ALTERNATE" then
		self:EachK(unit, "MinMaxValue", MinMax(select(2, UnitAlternatePowerInfo(unit)), UnitPowerMax(unit, ALTERNATE_POWER_INDEX)))
	elseif event == "UNIT_POWER" and powerType == "ALTERNATE" then
		self:EachK(unit, "Value", UnitPower(unit, ALTERNATE_POWER_INDEX))
	end
end

function UpdateBar(self)
	local barType, minPower, _, _, _, hideFromOthers = self.Unit and UnitAlternatePowerInfo(self.Unit)
	if ( barType and (not hideFromOthers or self.Unit == "player") ) then
		local currentPower = UnitPower(self.Unit, ALTERNATE_POWER_INDEX)
		local maxPower = UnitPowerMax(self.Unit, ALTERNATE_POWER_INDEX)

		self.BarType = barType
		self.MinMaxValue = Minmax(minPower, maxPower)
		self.Value = currentPower
		self.Visible = true
	else
		self.Visible = false
	end
end

__Doc__[[IFAlternatePower is used to handle the unit alternate power's update]]
interface "IFAlternatePower"
	extend "IFUnitElement"

	------------------------------------------------------
	-- Method
	------------------------------------------------------
	__Doc__[[The default refresh method, overridable]]
	function Refresh(self)
		return UpdateBar(self)
	end

	------------------------------------------------------
	-- Property
	------------------------------------------------------
	__Doc__[[the alternate power bar's type]]
	__Optional__() property "BarType" { Type = String }

	__Doc__[[the min and max power value]]
	__Optional__() property "MinMaxValue" { Type = MinMax }

	__Doc__[[the alternate power's value]]
	__Optional__() property "Value" { Type = Number }

	__Doc__[[the alternate power bar's visible]]
	__Optional__() property "Visible" { Type = Boolean }

	------------------------------------------------------
	-- Event Handler
	------------------------------------------------------
	local function OnUnitChanged(self)
		_IFAlternatePowerUnitList[self] = self.Unit
	end

	------------------------------------------------------
	-- Dispose
	------------------------------------------------------
	function Dispose(self)
		_IFAlternatePowerUnitList[self] = nil
	end

	------------------------------------------------------
	-- Initializer
	------------------------------------------------------
	function IFAlternatePower(self)
		self.OnUnitChanged = self.OnUnitChanged + OnUnitChanged
	end
endinterface "IFAlternatePower"