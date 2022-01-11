-- Author      : Kurapica
-- Create Date : 2012/07/12
-- Change Log  :

-- Check Version
local version = 1
if not IGAS:NewAddon("IGAS.Widget.Unit.IFTarget", version) then
	return
end

_All = "all"
_IFTargetUnitList = _IFTargetUnitList or UnitList(_Name)

function _IFTargetUnitList:OnUnitListChanged()
	self:RegisterEvent("PLAYER_TARGET_CHANGED")

	self.OnUnitListChanged = nil
end

function _IFTargetUnitList:ParseEvent(event)
	self:EachK(_All, "Refresh")
end

__Doc__[[IFTarget is used to check whether the unit is the target]]
interface "IFTarget"
	extend "IFUnitElement"

	------------------------------------------------------
	-- Method
	------------------------------------------------------
	function Refresh(self)
		self.IsTarget = self.Unit and UnitExists('target') and UnitIsUnit(self.Unit, 'target')
	end

	------------------------------------------------------
	-- Property
	------------------------------------------------------
	__Doc__[[which used to receive the check result]]
	__Optional__() property "IsTarget" { Type = Boolean }

	------------------------------------------------------
	-- Dispose
	------------------------------------------------------
	function Dispose(self)
		_IFTargetUnitList[self] = nil
	end

	------------------------------------------------------
	-- Initializer
	------------------------------------------------------
	function IFTarget(self)
		_IFTargetUnitList[self] = _All
	end
endinterface "IFTarget"