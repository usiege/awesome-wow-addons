-- Author      : Kurapica
-- Create Date : 2012/11/07
-- Change Log  :

-- Check Version
local version = 3
if not IGAS:NewAddon("IGAS.Widget.Unit.IFPowerFrequent", version) then
	return
end

_IFPowerFrequentUnitList = _IFPowerFrequentUnitList or UnitList(_Name)
_IFPowerFrequentSmoothUnitList = _IFPowerFrequentSmoothUnitList or UnitList(_Name.."Smooth")
_IFPowerFrequentSmoothObjUnitList = _IFPowerFrequentSmoothObjUnitList or UnitList(_Name.."SmoothObj")

_IFPowerFrequentUnitPowerType = _IFPowerFrequentUnitPowerType or {}

_MinMax = MinMax(0, 1)

function _IFPowerFrequentUnitList:OnUnitListChanged()
	self:RegisterEvent("UNIT_POWER_FREQUENT")
	self:RegisterEvent("UNIT_MAXPOWER")
	self:RegisterEvent("UNIT_POWER_BAR_SHOW")
	self:RegisterEvent("UNIT_POWER_BAR_HIDE")
	self:RegisterEvent("UNIT_DISPLAYPOWER")
	self:RegisterEvent("PLAYER_ENTERING_WORLD")

	self.OnUnitListChanged = nil
end

function _IFPowerFrequentUnitList:ParseEvent(event, unit, type)
	if not self:HasUnit(unit) and not _IFPowerFrequentSmoothUnitList:HasUnit(unit) and event ~= "PLAYER_ENTERING_WORLD" then return end

	local powerType = unit and UnitPowerType(unit)

	if unit and powerType ~= _IFPowerFrequentUnitPowerType[unit] then
		_IFPowerFrequentUnitPowerType[unit] = powerType

		self:EachK(unit, "Refresh")
		_IFPowerFrequentSmoothUnitList:EachK(unit, "Refresh")
	elseif event == "UNIT_POWER_FREQUENT" then
		if powerType and ClassPowerMap[powerType] ~= type then return end

		local value = UnitPower(unit, powerType)

		self:EachK(unit, "Value", value)
		_IFPowerFrequentSmoothObjUnitList:EachK(unit, "RealValue", value)
	elseif event == "UNIT_MAXPOWER" then
		_MinMax.max = UnitPowerMax(unit, powerType)

		self:EachK(unit, "MinMaxValue", _MinMax)
		_IFPowerFrequentSmoothUnitList:EachK(unit, "MinMaxValue", _MinMax)

		local value = UnitPower(unit, powerType)

		self:EachK(unit, "Value", value)
		_IFPowerFrequentSmoothObjUnitList:EachK(unit, "RealValue", value)
	elseif event == "PLAYER_ENTERING_WORLD" then
		for unit in pairs(self) do
			self:EachK(unit, "Refresh")
			_IFPowerFrequentSmoothUnitList:EachK(unit, "Refresh")
		end
	end
end

__Doc__[[IFPowerFrequent is used to handle the unit frequent power updating]]
interface "IFPowerFrequent"
	extend "IFUnitElement"

	local function OnValueChanged(self, value)
		self.Owner.Value = value
	end

	local function SwapUnitList(self, value)
		if value then
			_IFPowerFrequentUnitList[self] = nil

			if not self._SmoothValueObj then
				self._SmoothValueObj = SmoothValue()
				self._SmoothValueObj.SmoothDelay = self.SmoothDelay
				self._SmoothValueObj.Owner = self
				self._SmoothValueObj.OnValueChanged = OnValueChanged
			end

			_IFPowerFrequentSmoothObjUnitList[self._SmoothValueObj] = self.Unit
			_IFPowerFrequentSmoothUnitList[self] = self.Unit
		else
			if self._SmoothValueObj then
				_IFPowerFrequentSmoothObjUnitList[self._SmoothValueObj] = nil
			end
			_IFPowerFrequentSmoothUnitList[self] = nil

			_IFPowerFrequentUnitList[self] = self.Unit
		end
	end

	------------------------------------------------------
	-- Method
	------------------------------------------------------
	function Refresh(self)
		local unit = self.Unit
		if not unit or not UnitExists(unit) then return end

		local powerType, powerToken, altR, altG, altB = UnitPowerType(unit)

		if self.UsePowerColor then
			local info = PowerBarColor[powerToken]

			info = info or (not altR and (PowerBarColor[powerType] or PowerBarColor["MANA"]))

			if ( info ) then
				if self:IsClass(StatusBar) then
					self:SetStatusBarColor(info.r, info.g, info.b)
				elseif self:IsClass(LayeredRegion) then
					self:SetVertexColor(info.r, info.g, info.b, 1)
				end
			else
				if self:IsClass(StatusBar) then
					self:SetStatusBarColor(altR, altG, altB)
				elseif self:IsClass(LayeredRegion) then
					self:SetVertexColor(altR, altG, altB, 1)
				end
			end
		end

		local min, max = UnitPower(unit, powerType), UnitPowerMax(unit, powerType)

		_MinMax.max = max
		self.MinMaxValue = _MinMax

		if UnitIsConnected(unit) then
			self.Value = min
		else
			self.Value = max
		end

		if self.Smoothing and self._SmoothValueObj then
			self._SmoothValueObj.Value = self.Value
			self._SmoothValueObj.RealValue = self.Value
		end
	end

	------------------------------------------------------
	-- Property
	------------------------------------------------------
	__Doc__[[Whether the object use auto power color, the object should be a fontstring or texture]]
	__Handler__(Refresh)
	property "UsePowerColor" { Type = Boolean }

	__Doc__[[Whether smoothing the value changes]]
	__Handler__(SwapUnitList)
	property "Smoothing" { Type = Boolean }

	__Doc__[[The delay time for smoothing value changes]]
	property "SmoothDelay" { Type = PositiveNumber, Default = 1 }

	__Doc__[[used to receive the min and max value of the power]]
	__Optional__() property "MinMaxValue" { Type = MinMax }

	__Doc__[[used to receive the power's value]]
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

			_IFPowerFrequentSmoothObjUnitList[self._SmoothValueObj] = self.Unit
			_IFPowerFrequentSmoothUnitList[self] = self.Unit
		else
			_IFPowerFrequentUnitList[self] = self.Unit
		end
	end

	------------------------------------------------------
	-- Dispose
	------------------------------------------------------
	function Dispose(self)
		_IFPowerFrequentUnitList[self] = nil
		_IFPowerFrequentSmoothUnitList[self] = nil

		if self._SmoothValueObj then
			_IFPowerFrequentSmoothObjUnitList[self._SmoothValueObj] = nil
			self._SmoothValueObj:Dispose()
			self._SmoothValueObj = nil
		end
	end

	------------------------------------------------------
	-- Constructor
	------------------------------------------------------
	function IFPowerFrequent(self)
		self.OnUnitChanged = self.OnUnitChanged + OnUnitChanged

		-- Default Texture
		if self:IsClass(StatusBar) then
			if not self.StatusBarTexturePath then
				self.StatusBarTexturePath = [[Interface\TargetingFrame\UI-StatusBar]]
			end
		end

		self.MouseEnabled = false
	end
endinterface "IFPowerFrequent"