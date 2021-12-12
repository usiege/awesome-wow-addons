-- Author      : Kurapica
-- Create Date : 2012/06/25
-- Change Log  :

-- Check Version
local version = 3
if not IGAS:NewAddon("IGAS.Widget.Unit.IFHealth", version) then
	return
end

_IFHealthUnitList = _IFHealthUnitList or UnitList(_Name)
_IFHealthSmoothUnitList = _IFHealthSmoothUnitList or UnitList(_Name.."Smooth")
_IFHealthSmoothObjUnitList = _IFHealthSmoothObjUnitList or UnitList(_Name.."SmoothObj")

_IFHealthUnitMaxHealthCache = _IFHealthUnitMaxHealthCache or {}
_MinMax = MinMax(0, 1)

function _IFHealthUnitList:OnUnitListChanged()
	self:RegisterEvent("UNIT_HEALTH")
	self:RegisterEvent("UNIT_MAXHEALTH")
	self:RegisterEvent("PLAYER_ENTERING_WORLD")

	self.OnUnitListChanged = nil
end

function _IFHealthUnitList:ParseEvent(event, unit)
	if not self:HasUnit(unit) and not _IFHealthSmoothUnitList:HasUnit(unit) and event ~= "PLAYER_ENTERING_WORLD" then return end

	if event == "UNIT_HEALTH" then
		_MinMax.max = UnitHealthMax(unit)
		if _IFHealthUnitMaxHealthCache[unit] ~= _MinMax.max then
			_IFHealthUnitMaxHealthCache[unit] = _MinMax.max

			self:EachK(unit, "MinMaxValue", _MinMax)
			_IFHealthSmoothUnitList:EachK(unit, "MinMaxValue", _MinMax)
		end

		local value = UnitIsConnected(unit) and UnitHealth(unit) or UnitHealthMax(unit)

		self:EachK(unit, "Value", value)
		_IFHealthSmoothObjUnitList:EachK(unit, "RealValue", value)
	elseif event == "UNIT_MAXHEALTH" then
		_MinMax.max = UnitHealthMax(unit)
		_IFHealthUnitMaxHealthCache[unit] = _MinMax.max

		self:EachK(unit, "MinMaxValue", _MinMax)
		_IFHealthSmoothUnitList:EachK(unit, "MinMaxValue", _MinMax)

		local value = UnitIsConnected(unit) and UnitHealth(unit) or UnitHealthMax(unit)

		self:EachK(unit, "Value", value)
		_IFHealthSmoothObjUnitList:EachK(unit, "RealValue", value)
	elseif event == "PLAYER_ENTERING_WORLD" then
		for unit in pairs(self) do
			self:EachK(unit, "Refresh")
			_IFHealthSmoothUnitList:EachK(unit, "Refresh")
		end
	end
end

__Doc__[[IFHealth is used to handle the unit health updating]]
interface "IFHealth"
	extend "IFUnitElement"

	local function OnValueChanged(self, value)
		self.Owner.Value = value
	end

	local function SwapUnitList(self, value)
		if value then
			_IFHealthUnitList[self] = nil

			if not self._SmoothValueObj then
				self._SmoothValueObj = SmoothValue()
				self._SmoothValueObj.SmoothDelay = self.SmoothDelay
				self._SmoothValueObj.Owner = self
				self._SmoothValueObj.OnValueChanged = OnValueChanged
			end

			_IFHealthSmoothObjUnitList[self._SmoothValueObj] = self.Unit
			_IFHealthSmoothUnitList[self] = self.Unit
		else
			if self._SmoothValueObj then
				_IFHealthSmoothObjUnitList[self._SmoothValueObj] = nil
			end
			_IFHealthSmoothUnitList[self] = nil

			_IFHealthUnitList[self] = self.Unit
		end
	end

	------------------------------------------------------
	-- Method
	------------------------------------------------------
	function Refresh(self)
		if self.Unit then
			_MinMax.max = UnitHealthMax(self.Unit)
			self.MinMaxValue = _MinMax
			self.Value = UnitHealth(self.Unit)
		else
			self.Value = 0
		end

		if self.Smoothing and self._SmoothValueObj then
			self._SmoothValueObj.Value = self.Value
		end
	end

	------------------------------------------------------
	-- Property
	------------------------------------------------------
	__Doc__[[Whether smoothing the value changes]]
	__Handler__(SwapUnitList)
	property "Smoothing" { Type = Boolean }

	__Doc__[[The delay time for smoothing value changes]]
	property "SmoothDelay" { Type = PositiveNumber, Default = 1 }

	__Doc__[[used to receive the min and max value of the health]]
	__Optional__() property "MinMaxValue" { Type = MinMax }

	__Doc__[[used to receive the health's value]]
	__Optional__() property "Value" { Type = Number }

	------------------------------------------------------
	-- Event Handler
	------------------------------------------------------
	local function OnUnitChanged(self)
		if self.Smoothing then
			if not self._SmoothValueObj then
				self._SmoothValueObj = SmoothValue()
				self._SmoothValueObj.SmoothDelay = self.SmoothDelay
				self._SmoothValueObj.Owner = self
				self._SmoothValueObj.OnValueChanged = OnValueChanged
			end

			_IFHealthSmoothObjUnitList[self._SmoothValueObj] = self.Unit
			_IFHealthSmoothUnitList[self] = self.Unit
		else
			_IFHealthUnitList[self] = self.Unit
		end
	end

	------------------------------------------------------
	-- Dispose
	------------------------------------------------------
	function Dispose(self)
		_IFHealthUnitList[self] = nil
		_IFHealthSmoothUnitList[self] = nil

		if self._SmoothValueObj then
			_IFHealthSmoothObjUnitList[self._SmoothValueObj] = nil
			self._SmoothValueObj:Dispose()
			self._SmoothValueObj = nil
		end
	end

	------------------------------------------------------
	-- Initializer
	------------------------------------------------------
	function IFHealth(self)
		self.OnUnitChanged = self.OnUnitChanged + OnUnitChanged

		-- Default Texture
		if self:IsClass(StatusBar) and not self.StatusBarTexture then
			self.StatusBarTexturePath = [[Interface\TargetingFrame\UI-StatusBar]]
			self.StatusBarColor = ColorType(0, 1, 0)
		end

		self.MouseEnabled = false
	end
endinterface "IFHealth"