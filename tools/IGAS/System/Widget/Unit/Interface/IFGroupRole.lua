-- Author      : Kurapica
-- Create Date : 2012/07/12
-- Change Log  :

-- Check Version
local version = 2
if not IGAS:NewAddon("IGAS.Widget.Unit.IFGroupRole", version) then
	return
end

_All = "all"
_IFGroupRoleUnitList = _IFGroupRoleUnitList or UnitList(_Name)

function _IFGroupRoleUnitList:OnUnitListChanged()
	self:RegisterEvent("PLAYER_ROLES_ASSIGNED")
	self:RegisterEvent("GROUP_ROSTER_UPDATE")

	self.OnUnitListChanged = nil
end

function _IFGroupRoleUnitList:ParseEvent(event)
	self:EachK(_All, "Refresh")
end

__Doc__[[IFGroupRole is used to handle group role's updating]]
interface "IFGroupRole"
	extend "IFUnitElement"

	------------------------------------------------------
	-- Dispose
	------------------------------------------------------
	function Dispose(self)
		_IFGroupRoleUnitList[self] = nil
	end

	------------------------------------------------------
	-- Initializer
	------------------------------------------------------
	function IFGroupRole(self)
		_IFGroupRoleUnitList[self] = _All
	end
endinterface "IFGroupRole"