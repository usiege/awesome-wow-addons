-- Author      : Kurapica
-- Create Date : 2012/08/06
-- Change Log  :

-- Check Version
local version = 2
if not IGAS:NewAddon("IGAS.Widget.Unit.IFHealPrediction", version) then
	return
end

_IFMyHealPredictionUnitList = _IFMyHealPredictionUnitList or UnitList(_Name.."My")
_IFOtherHealPredictionUnitList = _IFOtherHealPredictionUnitList or UnitList(_Name.."Other")
_IFAllHealPredictionUnitList = _IFAllHealPredictionUnitList or UnitList(_Name.."All")
_IFAbsorbUnitList = _IFAbsorbUnitList or UnitList(_Name.."Absorb")
_IFHealAbsorbUnitList = _IFHealAbsorbUnitList or UnitList(_Name.."HealAbsorb")

_IFHealPredictionUnitMaxHealthCache = _IFHealPredictionUnitMaxHealthCache or {}

_MinMax = MinMax(0, 1)

local function OnUnitListChanged()
	_IFMyHealPredictionUnitList:RegisterEvent("UNIT_HEAL_PREDICTION")
	_IFMyHealPredictionUnitList:RegisterEvent("UNIT_ABSORB_AMOUNT_CHANGED")
	_IFMyHealPredictionUnitList:RegisterEvent("UNIT_MAXHEALTH")
	_IFMyHealPredictionUnitList:RegisterEvent("UNIT_HEALTH")
	_IFMyHealPredictionUnitList:RegisterEvent("UNIT_HEAL_ABSORB_AMOUNT_CHANGED")

	_IFMyHealPredictionUnitList.OnUnitListChanged = nil
	_IFOtherHealPredictionUnitList.OnUnitListChanged = nil
	_IFAllHealPredictionUnitList.OnUnitListChanged = nil
	_IFAbsorbUnitList.OnUnitListChanged = nil
	_IFHealAbsorbUnitList.OnUnitListChanged = nil
end

_IFMyHealPredictionUnitList.OnUnitListChanged = OnUnitListChanged
_IFOtherHealPredictionUnitList.OnUnitListChanged = OnUnitListChanged
_IFAllHealPredictionUnitList.OnUnitListChanged = OnUnitListChanged
_IFAbsorbUnitList.OnUnitListChanged = OnUnitListChanged
_IFHealAbsorbUnitList.OnUnitListChanged = OnUnitListChanged

MAX_INCOMING_HEAL_OVERFLOW = 1.0

function _IFMyHealPredictionUnitList:ParseEvent(event, unit)
	if _IFHealPredictionUnitMaxHealthCache[unit] then
		if event == "UNIT_MAXHEALTH" then
			_MinMax.max = UnitHealthMax(unit)
			_IFHealPredictionUnitMaxHealthCache[unit] = _MinMax.max

			_IFMyHealPredictionUnitList:EachK(unit, "MinMaxValue", _MinMax)
			_IFOtherHealPredictionUnitList:EachK(unit, "MinMaxValue", _MinMax)
			_IFAllHealPredictionUnitList:EachK(unit, "MinMaxValue", _MinMax)
			_IFAbsorbUnitList:EachK(unit, "MinMaxValue", _MinMax)
			_IFHealAbsorbUnitList:EachK(unit, "MinMaxValue", _MinMax)
		else
			local health = UnitHealth(unit)
			local maxHealth = UnitHealthMax(unit)

			local myIncomingHeal = UnitGetIncomingHeals(unit, "player") or 0
			local allIncomingHeal = UnitGetIncomingHeals(unit) or 0
			local totalAbsorb = UnitGetTotalAbsorbs(unit) or 0
			local myCurrentHealAbsorb = UnitGetTotalHealAbsorbs(unit) or 0

			-- Update max health
			if _IFHealPredictionUnitMaxHealthCache[unit] ~= maxHealth then
				_MinMax.max = maxHealth
				_IFHealPredictionUnitMaxHealthCache[unit] = maxHealth

				_IFMyHealPredictionUnitList:EachK(unit, "MinMaxValue", _MinMax)
				_IFOtherHealPredictionUnitList:EachK(unit, "MinMaxValue", _MinMax)
				_IFAllHealPredictionUnitList:EachK(unit, "MinMaxValue", _MinMax)
				_IFAbsorbUnitList:EachK(unit, "MinMaxValue", _MinMax)
				_IFHealAbsorbUnitList:EachK(unit, "MinMaxValue", _MinMax)
			end

			local overHealAbsorb = false
			local hasIncomingHeal = false
			local hasAbsorb = false

			--We don't fill outside the health bar with healAbsorbs.  Instead, an overHealAbsorbGlow is shown.
			if ( health < myCurrentHealAbsorb ) then
				overHealAbsorb = true
				myCurrentHealAbsorb = health
			end

			--See how far we're going over the health bar and make sure we don't go too far out of the frame.
			if ( health - myCurrentHealAbsorb + allIncomingHeal > maxHealth * MAX_INCOMING_HEAL_OVERFLOW ) then
				allIncomingHeal = maxHealth * MAX_INCOMING_HEAL_OVERFLOW - health + myCurrentHealAbsorb
			end

			local otherIncomingHeal = 0

			--Split up incoming heals.
			if ( allIncomingHeal >= myIncomingHeal ) then
				otherIncomingHeal = allIncomingHeal - myIncomingHeal
			else
				myIncomingHeal = allIncomingHeal
			end

			--We don't fill outside the the health bar with absorbs.  Instead, an overAbsorbGlow is shown.
			local overAbsorb = false
			if ( health - myCurrentHealAbsorb + allIncomingHeal + totalAbsorb >= maxHealth or health + totalAbsorb >= maxHealth ) then
				if ( totalAbsorb > 0 ) then
					overAbsorb = true
				end

				if ( allIncomingHeal > myCurrentHealAbsorb ) then
					totalAbsorb = max(0,maxHealth - (health - myCurrentHealAbsorb + allIncomingHeal))
				else
					totalAbsorb = max(0,maxHealth - health)
				end
			end

			--If allIncomingHeal is greater than myCurrentHealAbsorb, then the current
			--heal absorb will be completely overlayed by the incoming heals so we don't show it.
			if ( myCurrentHealAbsorb > allIncomingHeal ) then
				myCurrentHealAbsorb = myCurrentHealAbsorb - allIncomingHeal

				--If there are incoming heals the left shadow would be overlayed by the incoming heals
				--so it isn't shown.
				hasIncomingHeal = allIncomingHeal > 0

				-- The right shadow is only shown if there are absorbs on the health bar.
				hasAbsorb = totalAbsorb > 0
			else
				myCurrentHealAbsorb = 0
			end

			_IFMyHealPredictionUnitList:EachK(unit, "Value", myIncomingHeal)
			_IFOtherHealPredictionUnitList:EachK(unit, "Value", otherIncomingHeal)
			_IFAllHealPredictionUnitList:EachK(unit, "Value", allIncomingHeal)

			_IFAbsorbUnitList:EachK(unit, "Value", totalAbsorb)
			_IFAbsorbUnitList:EachK(unit, "OverAbsorb", overAbsorb)

			_IFHealAbsorbUnitList:EachK(unit, "Value", myCurrentHealAbsorb)
			_IFHealAbsorbUnitList:EachK(unit, "OverAbsorb", overHealAbsorb)
			_IFHealAbsorbUnitList:EachK(unit, "HasIncomingHeal", hasIncomingHeal)
			_IFHealAbsorbUnitList:EachK(unit, "HasAbsorb", hasAbsorb)
		end
	end
end

__Doc__[[IFMyHealPrediction is used to handle the unit's prediction health by the player]]
interface "IFMyHealPrediction"
	extend "IFUnitElement"

	------------------------------------------------------
	-- Method
	------------------------------------------------------
	function Refresh(self)
		if self.Unit then
			_MinMax.max = UnitHealthMax(self.Unit)
			self.MinMaxValue = _MinMax
			self.Value = 0
		else
			_MinMax.max = 100
			self.MinMaxValue = _MinMax
			self.Value = 0
		end
	end

	------------------------------------------------------
	-- Property
	------------------------------------------------------
	__Doc__[[used to receive the min and max value of the health]]
	__Optional__() property "MinMaxValue" { Type = MinMax }

	__Doc__[[used to receive the incoming heal of mine]]
	__Optional__() property "Value" { Type = Number }

	------------------------------------------------------
	-- Event Handler
	------------------------------------------------------
	local function OnUnitChanged(self)
		local unit = self.Unit
		_IFMyHealPredictionUnitList[self] = unit
		if unit then
			_IFHealPredictionUnitMaxHealthCache[unit] = _IFHealPredictionUnitMaxHealthCache[unit] or 1
		end
	end

	------------------------------------------------------
	-- Dispose
	------------------------------------------------------
	function Dispose(self)
		_IFMyHealPredictionUnitList[self] = nil
	end

	------------------------------------------------------
	-- Initializer
	------------------------------------------------------
	function IFMyHealPrediction(self)
		self.OnUnitChanged = self.OnUnitChanged + OnUnitChanged

		-- Default Texture
		if self:IsClass(StatusBar) and not self.StatusBarTexture then
			self.StatusBarTexturePath = [[Interface\TargetingFrame\UI-StatusBar]]
			self.StatusBarColor = ColorType(0, 0.827, 0.765)
		end

		self.MouseEnabled = false
	end
endinterface "IFMyHealPrediction"

__Doc__[[IFOtherHealPrediction is used to handle the unit's prediction health by other players]]
interface "IFOtherHealPrediction"
	extend "IFUnitElement"

	------------------------------------------------------
	-- Method
	------------------------------------------------------
	function Refresh(self)
		if self.Unit then
			_MinMax.max = UnitHealthMax(self.Unit)
			self.MinMaxValue = _MinMax
			self.Value = 0
		else
			_MinMax.max = 100
			self.MinMaxValue = _MinMax
			self.Value = 0
		end
	end

	------------------------------------------------------
	-- Property
	------------------------------------------------------
	__Doc__[[used to receive the min and max value of the health]]
	__Optional__() property "MinMaxValue" { Type = MinMax }

	__Doc__[[used to receive the incoming heal of others]]
	__Optional__() property "Value" { Type = Number }

	------------------------------------------------------
	-- Event Handler
	------------------------------------------------------
	local function OnUnitChanged(self)
		local unit = self.Unit
		_IFOtherHealPredictionUnitList[self] = unit
		if unit then
			_IFHealPredictionUnitMaxHealthCache[unit] = _IFHealPredictionUnitMaxHealthCache[unit] or 1
		end
	end

	------------------------------------------------------
	-- Dispose
	------------------------------------------------------
	function Dispose(self)
		_IFOtherHealPredictionUnitList[self] = nil
	end

	------------------------------------------------------
	-- Initializer
	------------------------------------------------------
	function IFOtherHealPrediction(self)
		self.OnUnitChanged = self.OnUnitChanged + OnUnitChanged

		-- Default Texture
		if self:IsClass(StatusBar) and not self.StatusBarTexture then
			self.StatusBarTexturePath = [[Interface\TargetingFrame\UI-StatusBar]]
			self.StatusBarColor = ColorType(0, 0.631, 0.557)
		end

		self.MouseEnabled = false
	end
endinterface "IFOtherHealPrediction"

__Doc__[[IFAllHealPrediction is used to handle the unit's prediction health by all player]]
interface "IFAllHealPrediction"
	extend "IFUnitElement"

	------------------------------------------------------
	-- Method
	------------------------------------------------------
	function Refresh(self)
		if self.Unit then
			_MinMax.max = UnitHealthMax(self.Unit)
			self.MinMaxValue = _MinMax
			self.Value = 0
		else
			_MinMax.max = 100
			self.MinMaxValue = _MinMax
			self.Value = 0
		end
	end

	------------------------------------------------------
	-- Property
	------------------------------------------------------
	__Doc__[[used to receive the min and max value of the health]]
	__Optional__() property "MinMaxValue" { Type = MinMax }

	__Doc__[[used to receive the incoming heal of all]]
	__Optional__() property "Value" { Type = Number }

	------------------------------------------------------
	-- Event Handler
	------------------------------------------------------
	local function OnUnitChanged(self)
		local unit = self.Unit
		_IFAllHealPredictionUnitList[self] = unit
		if unit then
			_IFHealPredictionUnitMaxHealthCache[unit] = _IFHealPredictionUnitMaxHealthCache[unit] or 1
		end
	end

	------------------------------------------------------
	-- Dispose
	------------------------------------------------------
	function Dispose(self)
		_IFAllHealPredictionUnitList[self] = nil
	end

	------------------------------------------------------
	-- Initializer
	------------------------------------------------------
	function IFAllHealPrediction(self)
		self.OnUnitChanged = self.OnUnitChanged + OnUnitChanged

		-- Default Texture
		if self:IsClass(StatusBar) and not self.StatusBarTexture then
			self.StatusBarTexturePath = [[Interface\TargetingFrame\UI-StatusBar]]
			self.StatusBarColor = ColorType(0, 0.631, 0.557)
		end

		self.MouseEnabled = false
	end
endinterface "IFAllHealPrediction"

__Doc__[[IFAbsorb is used to handle the unit's total absorb value]]
interface "IFAbsorb"
	extend "IFUnitElement"

	------------------------------------------------------
	-- Method
	------------------------------------------------------
	function Refresh(self)
		if self.Unit then
			_MinMax.max = UnitHealthMax(self.Unit)
			self.MinMaxValue = _MinMax
			self.Value = 0
			self.OverAbsorb = false
		else
			_MinMax.max = 100
			self.MinMaxValue = _MinMax
			self.Value = 0
			self.OverAbsorb = false
		end
	end

	------------------------------------------------------
	-- Property
	------------------------------------------------------
	__Doc__[[used to receive the min and max value of the health]]
	__Optional__() property "MinMaxValue" { Type = MinMax }

	__Doc__[[used to receive the value of the absorb]]
	__Optional__() property "Value" { Type = Number }

	__Doc__[[used to receive the result whether the unit's absorb effect is overdose]]
	__Optional__() property "OverAbsorb" { Type = Boolean }

	------------------------------------------------------
	-- Event Handler
	------------------------------------------------------
	local function OnUnitChanged(self)
		local unit = self.Unit
		_IFAbsorbUnitList[self] = unit
		if unit then
			_IFHealPredictionUnitMaxHealthCache[unit] = _IFHealPredictionUnitMaxHealthCache[unit] or 1
		end
	end

	------------------------------------------------------
	-- Dispose
	------------------------------------------------------
	function Dispose(self)
		_IFAbsorbUnitList[self] = nil
	end

	------------------------------------------------------
	-- Initializer
	------------------------------------------------------
	function IFAbsorb(self)
		self.OnUnitChanged = self.OnUnitChanged + OnUnitChanged

		-- Default Texture
		if self:IsClass(StatusBar) and not self.StatusBarTexture then
			self.StatusBarTexturePath = [[Interface\RaidFrame\Shield-Fill]]
		end

		self.MouseEnabled = false
	end
endinterface "IFAbsorb"

__Doc__[[IFHealAbsorb is used to handle the unit's total absorb value]]
interface "IFHealAbsorb"
	extend "IFUnitElement"

	------------------------------------------------------
	-- Method
	------------------------------------------------------
	function Refresh(self)
		if self.Unit then
			_MinMax.max = UnitHealthMax(self.Unit)
			self.MinMaxValue = _MinMax
			self.Value = 0
			self.OverAbsorb = false
			self.HasIncomingHeal = false
			self.HasAbsorb = false
		else
			_MinMax.max = 100
			self.MinMaxValue = _MinMax
			self.Value = 0
			self.OverAbsorb = false
			self.HasIncomingHeal = false
			self.HasAbsorb = false
		end
	end

	------------------------------------------------------
	-- Property
	------------------------------------------------------
	__Doc__[[used to receive the min and max value of the health]]
	__Optional__() property "MinMaxValue" { Type = MinMax }

	__Doc__[[used to receive the value of the health absorb]]
	__Optional__() property "Value" { Type = Number }

	__Doc__[[used to receive the result whether the unit's health absorb effect is overdose]]
	__Optional__() property "OverAbsorb" { Type = Boolean }

	------------------------------------------------------
	-- Event Handler
	------------------------------------------------------
	local function OnUnitChanged(self)
		local unit = self.Unit
		_IFHealAbsorbUnitList[self] = unit
		if unit then
			_IFHealPredictionUnitMaxHealthCache[unit] = _IFHealPredictionUnitMaxHealthCache[unit] or 1
		end
	end

	------------------------------------------------------
	-- Dispose
	------------------------------------------------------
	function Dispose(self)
		_IFHealAbsorbUnitList[self] = nil
	end

	------------------------------------------------------
	-- Initializer
	------------------------------------------------------
	function IFHealAbsorb(self)
		self.OnUnitChanged = self.OnUnitChanged + OnUnitChanged

		self.MouseEnabled = false
	end
endinterface "IFHealAbsorb"
