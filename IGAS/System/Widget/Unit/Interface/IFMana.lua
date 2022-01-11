-- Author      : Kurapica
-- Create Date : 2012/06/25
-- Change Log  :

-- Check Version
local version = 2
if not IGAS:NewAddon("IGAS.Widget.Unit.IFMana", version) then
	return
end

_IFManaUnitList = _IFManaUnitList or UnitList(_Name)
_IFManaSmoothUnitList = _IFManaSmoothUnitList or UnitList(_Name.."Smooth")
_IFManaSmoothObjUnitList = _IFManaSmoothObjUnitList or UnitList(_Name.."SmoothObj")

SPELL_POWER_MANA = _G.SPELL_POWER_MANA

_MinMax = MinMax(0, 1)

if select(2, UnitClass('player')) == 'DRUID' then
	_UseHiddenMana = true
else
	_UseHiddenMana = false
end

function _IFManaUnitList:OnUnitListChanged()
	self:RegisterEvent("UNIT_POWER")
	self:RegisterEvent("UNIT_MAXPOWER")
	self:RegisterEvent("UNIT_POWER_BAR_SHOW")
	self:RegisterEvent("UNIT_POWER_BAR_HIDE")
	self:RegisterEvent("UNIT_DISPLAYPOWER")
	self:RegisterEvent("PLAYER_ENTERING_WORLD")
	self:RegisterEvent("PLAYER_SPECIALIZATION_CHANGED")

	self.OnUnitListChanged = nil
end

function _IFManaUnitList:ParseEvent(event, unit, type)
	if (unit and unit ~= "player") or (type and type ~= "MANA") then return end

	if event == "UNIT_POWER" then
		local value = UnitPower(unit, SPELL_POWER_MANA)

		self:EachK("player", "Value", value)
		_IFManaSmoothObjUnitList:EachK("player", "RealValue", value)
	elseif event == "UNIT_MAXPOWER" then
		_MinMax.max = UnitPowerMax("player", SPELL_POWER_MANA)

		self:EachK("player", "MinMaxValue", _MinMax)
		_IFManaSmoothUnitList:EachK("player", "MinMaxValue", _MinMax)

		local value = UnitPower("player", SPELL_POWER_MANA)

		self:EachK("player", "Value", value)
		_IFManaSmoothObjUnitList:EachK("player", "RealValue", value)
	else
		self:EachK("player", "Refresh")
		_IFManaSmoothUnitList:EachK("player", "Refresh")
	end
end

__Doc__[[IFMana is used to handle the unit mana updating]]
interface "IFMana"
	extend "IFUnitElement"

	local function OnValueChanged(self, value)
		self.Owner.Value = value
	end

	local function SwapUnitList(self, value)
		if value then
			_IFManaUnitList[self] = nil

			if not self._SmoothValueObj then
				self._SmoothValueObj = SmoothValue()
				self._SmoothValueObj.SmoothDelay = self.SmoothDelay
				self._SmoothValueObj.Owner = self
				self._SmoothValueObj.OnValueChanged = OnValueChanged
			end

			_IFManaSmoothObjUnitList[self._SmoothValueObj] = self.Unit
			_IFManaSmoothUnitList[self] = self.Unit
		else
			if self._SmoothValueObj then
				_IFManaSmoothObjUnitList[self._SmoothValueObj] = nil
			end
			_IFManaSmoothUnitList[self] = nil

			_IFManaUnitList[self] = self.Unit
		end
	end

	------------------------------------------------------
	-- Method
	------------------------------------------------------
	function Refresh(self)
		if not _M._UseHiddenMana then return end

		if UnitPowerType('player') == SPELL_POWER_MANA then
			return self:Hide()
		else
			self:Show()
		end

		local min, max = UnitPower("player", SPELL_POWER_MANA), UnitPowerMax("player", SPELL_POWER_MANA)

		_MinMax.max = max
		self.MinMaxValue = _MinMax

		self.Value = min

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

	__Doc__[[used to receive the min and max value of the mana]]
	__Optional__() property "MinMaxValue" { Type = MinMax }

	__Doc__[[used to receive the mana's value]]
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

			_IFManaSmoothObjUnitList[self._SmoothValueObj] = self.Unit
			_IFManaSmoothUnitList[self] = self.Unit
		else
			_IFManaUnitList[self] = self.Unit
		end
	end

	------------------------------------------------------
	-- Dispose
	------------------------------------------------------
	function Dispose(self)
		_IFManaUnitList[self] = nil
		_IFManaSmoothUnitList[self] = nil

		if self._SmoothValueObj then
			_IFManaSmoothObjUnitList[self._SmoothValueObj] = nil
			self._SmoothValueObj:Dispose()
			self._SmoothValueObj = nil
		end
	end

	------------------------------------------------------
	-- Initializer
	------------------------------------------------------
	function IFMana(self)
		if _M._UseHiddenMana then
			self.OnUnitChanged = self.OnUnitChanged + OnUnitChanged

			-- Default Texture
			if self:IsClass(StatusBar) then
				if not self.StatusBarTexturePath then
					self.StatusBarTexturePath = [[Interface\TargetingFrame\UI-StatusBar]]
				end
			end

			local info = PowerBarColor['MANA']

			if self:IsClass(StatusBar) then
				self:SetStatusBarColor(info.r, info.g, info.b)
			elseif self:IsClass(LayeredRegion) then
				self:SetVertexColor(info.r, info.g, info.b, 1)
			end

			self.MouseEnabled = false
		else
			self.Visible = false
		end
	end
endinterface "IFMana"