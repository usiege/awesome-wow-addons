-- Author      : Kurapica
-- Create Date : 2012/07/12
-- Change Log  :

-- Check Version
local version = 2
if not IGAS:NewAddon("IGAS.Widget.Unit.IFRaidRoster", version) then
	return
end

_All = "all"
_IFRaidRosterUnitList = _IFRaidRosterUnitList or UnitList(_Name)

function _IFRaidRosterUnitList:OnUnitListChanged()
	self:RegisterEvent("GROUP_ROSTER_UPDATE")

	self.OnUnitListChanged = nil
end

function _IFRaidRosterUnitList:ParseEvent(event)
	self:EachK(_All, "Refresh")
end

__Doc__[[IFRaidRoster is used to handle the unit raid roster state's updating]]
interface "IFRaidRoster"
	extend "IFUnitElement"

	------------------------------------------------------
	-- Dispose
	------------------------------------------------------
	function Dispose(self)
		_IFRaidRosterUnitList[self] = nil
	end

	------------------------------------------------------
	-- Constructor
	------------------------------------------------------
	function IFRaidRoster(self)
		_IFRaidRosterUnitList[self] = _All
	end
endinterface "IFRaidRoster"