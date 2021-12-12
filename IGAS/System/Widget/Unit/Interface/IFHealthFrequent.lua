-- Author      : Kurapica
-- Create Date : 2012/10/29
-- Change Log  :

-- Check Version
local version = 3
if not IGAS:NewAddon("IGAS.Widget.Unit.IFHealthFrequent", version) then
	return
end

_IFHealthFrequentUnitList = _IFHealthFrequentUnitList or UnitList(_Name)
_IFHealthFrequentSmoothUnitList = _IFHealthFrequentSmoothUnitList or UnitList(_Name.."Smooth")
_IFHealthFrequentSmoothObjUnitList = _IFHealthFrequentSmoothObjUnitList or UnitList(_Name.."SmoothObj")

_IFHealthFrequentUnitMaxHealthCache = _IFHealthFrequentUnitMaxHealthCache or {}

_MinMax = MinMax(0, 1)

function _IFHealthFrequentUnitList:OnUnitListChanged()
	self:RegisterEvent("UNIT_HEALTH_FREQUENT")
	self:RegisterEvent("UNIT_MAXHEALTH")
	self:RegisterEvent("PLAYER_ENTERING_WORLD")

	self.OnUnitListChanged = nil
end

function _IFHealthFrequentUnitList:ParseEvent(event, unit)
	if not self:HasUnit(unit) and not _IFHealthFrequentSmoothUnitList:HasUnit(unit) and event ~= "PLAYER_ENTERING_WORLD" then return end

	if event == "UNIT_HEALTH_FREQUENT" then
		_MinMax.max = UnitHealthMax(unit)
		if _IFHealthFrequentUnitMaxHealthCache[unit] ~= _MinMax.max then
			_IFHealthFrequentUnitMaxHealthCache[unit] = _MinMax.max

			self:EachK(unit, "MinMaxValue", _MinMax)
			_IFHealthFrequentSmoothUnitList:EachK(unit, "MinMaxValue", _MinMax)
		end

		local value = UnitIsConnected(unit) and UnitHealth(unit) or UnitHealthMax(unit)

		self:EachK(unit, "Value", value)
		_IFHealthFrequentSmoothObjUnitList:EachK(unit, "RealValue", value)
	elseif event == "UNIT_MAXHEALTH" then
		_MinMax.max = UnitHealthMax(unit)
		_IFHealthFrequentUnitMaxHealthCache[unit] = _MinMax.max

		self:EachK(unit, "MinMaxValue", _MinMax)
		_IFHealthFrequentSmoothUnitList:EachK(unit, "MinMaxValue", _MinMax)

		local value = UnitIsConnected(unit) and UnitHealth(unit) or UnitHealthMax(unit)

		self:EachK(unit, "Value", value)
		_IFHealthFrequentSmoothObjUnitList:EachK(unit, "RealValue", value)
	elseif event == "PLAYER_ENTERING_WORLD" then
		for unit in pairs(self) do
			self:EachK(unit, "Refresh")
			_IFHealthFrequentSmoothUnitList:EachK(unit, "Refresh")
		end
	end
end

__Doc__[[IFHealthFrequent is used to handle the unit frequent health updating]]
interface "IFHealthFrequent"
	extend "IFUnitElement"

	local function OnValueChanged(self, value)
		self.Owner.Value = value
	end

	local function SwapUnitList(self, value)
		if value then
			_IFHealthFrequentUnitList[self] = nil

			if not self._SmoothValueObj then
				self._SmoothValueObj = SmoothValue()
				self._SmoothValueObj.SmoothDelay = self.SmoothDelay
				self._SmoothValueObj.Owner = self
				self._SmoothValueObj.OnValueChanged = OnValueChanged
			end

			_IFHealthFrequentSmoothObjUnitList[self._SmoothValueObj] = self.Unit
			_IFHealthFrequentSmoothUnitList[self] = self.Unit
		else
			if self._SmoothValueObj then
				_IFHealthFrequentSmoothObjUnitList[self._SmoothValueObj] = nil
			end
			_IFHealthFrequentSmoothUnitList[self] = nil

			_IFHealthFrequentUnitList[self] = self.Unit
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
			self._SmoothValueObj.RealValue = self.Value
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

			_IFHealthFrequentSmoothObjUnitList[self._SmoothValueObj] = self.Unit
			_IFHealthFrequentSmoothUnitList[self] = self.Unit
		else
			_IFHealthFrequentUnitList[self] = self.Unit
		end
	end

	------------------------------------------------------
	-- Dispose
	------------------------------------------------------
	function Dispose(self)
		_IFHealthFrequentUnitList[self] = nil
		_IFHealthFrequentSmoothUnitList[self] = nil

		if self._SmoothValueObj then
			_IFHealthFrequentSmoothObjUnitList[self._SmoothValueObj] = nil
			self._SmoothValueObj:Dispose()
			self._SmoothValueObj = nil
		end
	end

	------------------------------------------------------
	-- Initializer
	------------------------------------------------------
	function IFHealthFrequent(self)
		self.OnUnitChanged = self.OnUnitChanged + OnUnitChanged

		-- Default Texture
		if self:IsClass(StatusBar) and not self.StatusBarTexture then
			self.StatusBarTexturePath = [[Interface\TargetingFrame\UI-StatusBar]]
			self.StatusBarColor = ColorType(0, 1, 0)
		end

		self.MouseEnabled = false
	end
endinterface "IFHealthFrequent"