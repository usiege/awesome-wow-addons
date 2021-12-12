-- Author      : Kurapica
-- Create Date : 2012/06/25
-- Change Log  :
--               2013/04/08 Reduce the refresh times
--               2013/09/12 Fix for wow 5.4.0

-- Check Version
local version = 5
if not IGAS:NewAddon("IGAS.Widget.Unit.IFUnitName", version) then
	return
end

_IFUnitNameUnitList = _IFUnitNameUnitList or UnitList(_Name)

function _IFUnitNameUnitList:OnUnitListChanged()
	self:RegisterEvent("UNIT_NAME_UPDATE")
	self:RegisterEvent("GROUP_ROSTER_UPDATE")

	self.OnUnitListChanged = nil
end

function _IFUnitNameUnitList:ParseEvent(event, unit)
	if event == "UNIT_NAME_UPDATE" and self:HasUnit(unit) then
		self:EachK(unit, "Refresh")
	elseif event == "GROUP_ROSTER_UPDATE" then
		for unit in pairs(self) do
			self:EachK(unit, "Refresh")
		end
	end
end

__Doc__[[IFUnitName is used to handle the unit name's update]]
interface "IFUnitName"
	extend "IFUnitElement"

	------------------------------------------------------
	-- Method
	------------------------------------------------------
	function Refresh(self)
		if self.Unit then
			self.Text = GetUnitName(self.Unit, self.WithServerName) or self.Unit
		else
			self.Text = ""
		end
	end

	------------------------------------------------------
	-- Property
	------------------------------------------------------
	__Doc__[[Whether show the server name]]
	__Handler__(Refresh)
	property "WithServerName" { Type = Boolean }

	__Doc__[[Which used to receive the unit's name]]
	__Optional__() property "Text" { Type = String }

	------------------------------------------------------
	-- Event Handler
	------------------------------------------------------
	local function OnUnitChanged(self)
		_IFUnitNameUnitList[self] = self.Unit
	end

	------------------------------------------------------
	-- Dispose
	------------------------------------------------------
	function Dispose(self)
		_IFUnitNameUnitList[self] = nil
	end

	------------------------------------------------------
	-- Constructor
	------------------------------------------------------
	function IFUnitName(self)
		self.OnUnitChanged = self.OnUnitChanged + OnUnitChanged
	end
endinterface "IFUnitName"