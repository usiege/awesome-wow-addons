-- Author      : Kurapica
-- Create Date : 2012/07/12
-- Change Log  :

-- Check Version
local version = 2
if not IGAS:NewAddon("IGAS.Widget.Unit.IFThreat", version) then
	return
end

_IFThreatUnitList = _IFThreatUnitList or UnitList(_Name)

function _IFThreatUnitList:OnUnitListChanged()
	self:RegisterEvent("UNIT_THREAT_SITUATION_UPDATE")
	self:RegisterEvent("PLAYER_REGEN_ENABLED")

	self.OnUnitListChanged = nil
end

function _IFThreatUnitList:ParseEvent(event, unit)
	if unit and self:HasUnit(unit) then
		self:EachK(unit, "ThreatLevel", UnitThreatSituation(unit) or 0)
	else
		for unit in pairs(self) do
			self:EachK(unit, "Refresh")
		end
	end
end

__Doc__[[IFThreat is used to handle the unit threat level's update]]
interface "IFThreat"
	extend "IFUnitElement"

	------------------------------------------------------
	-- Method
	------------------------------------------------------
	function Refresh(self)
		self.ThreatLevel = self.Unit and UnitThreatSituation(self.Unit) or 0
	end

	------------------------------------------------------
	-- Property
	------------------------------------------------------
	__Doc__[[The unit's threat level]]
	__Optional__() property "ThreatLevel" {
		Set = function(self, value)
			if self:IsClass(LayeredRegion) then
				if value > 0 then
					self:SetVertexColor(GetThreatStatusColor(value))
					self.Visible = true
				else
					self.Visible = false
				end
			end
		end,
		Type = Number,
	}

	------------------------------------------------------
	-- Event Handler
	------------------------------------------------------
	local function OnUnitChanged(self)
		_IFThreatUnitList[self] = self.Unit
	end

	------------------------------------------------------
	-- Dispose
	------------------------------------------------------
	function Dispose(self)
		_IFThreatUnitList[self] = nil
	end

	------------------------------------------------------
	-- Initializer
	------------------------------------------------------
	function IFThreat(self)
		self.OnUnitChanged = self.OnUnitChanged + OnUnitChanged
	end
endinterface "IFThreat"