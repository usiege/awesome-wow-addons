-- Author      : Kurapica
-- Create Date : 2012/08/06
-- Change Log  :

-- Check Version
local version = 2
if not IGAS:NewAddon("IGAS.Widget.Unit.IFAssistant", version) then
	return
end

_All = "all"
_IFAssistantUnitList = _IFAssistantUnitList or UnitList(_Name)

function _IFAssistantUnitList:OnUnitListChanged()
	self:RegisterEvent("GROUP_ROSTER_UPDATE")

	self.OnUnitListChanged = nil
end

function _IFAssistantUnitList:ParseEvent(event)
	self:EachK(_All, "Refresh")
end

__Doc__[[IFAssistant is used to check whether the unit is the assistant in the group]]
interface "IFAssistant"
	extend "IFUnitElement"

	------------------------------------------------------
	-- Method
	------------------------------------------------------
	__Doc__[[The default refresh method, overridable]]
	function Refresh(self)
		local unit = self.Unit
		self.Visible = unit and UnitInRaid(unit) and UnitIsGroupAssistant(unit) and not UnitIsGroupLeader(unit)
	end

	------------------------------------------------------
	-- Property
	------------------------------------------------------
	__Doc__[[which used to receive the check result]]
	__Optional__() property "Visible" { Type = Boolean }

	------------------------------------------------------
	-- Dispose
	------------------------------------------------------
	function Dispose(self)
		_IFAssistantUnitList[self] = nil
	end

	------------------------------------------------------
	-- Initializer
	------------------------------------------------------
	function IFAssistant(self)
		_IFAssistantUnitList[self] = _All

		-- Default Texture
		if self:IsClass(Texture) then
			if not self.TexturePath and not self.Color then
				self.TexturePath = [[Interface\GroupFrame\UI-Group-AssistantIcon]]
			end
		end
	end
endinterface "IFAssistant"