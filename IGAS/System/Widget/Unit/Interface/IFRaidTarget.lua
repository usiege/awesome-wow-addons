-- Author      : Kurapica
-- Create Date : 2012/07/12
-- Change Log  :

-- Check Version
local version = 1
if not IGAS:NewAddon("IGAS.Widget.Unit.IFRaidTarget", version) then
	return
end

_All = "all"
_IFRaidTargetUnitList = _IFRaidTargetUnitList or UnitList(_Name)

function _IFRaidTargetUnitList:OnUnitListChanged()
	self:RegisterEvent("RAID_TARGET_UPDATE")

	self.OnUnitListChanged = nil
end

function _IFRaidTargetUnitList:ParseEvent(event)
	self:EachK(_All, "Refresh")
end

__Doc__[[IFRaidTarget is used to handle the unit's raid target icon's updating(only for texture)]]
interface "IFRaidTarget"
	extend "IFUnitElement"

	------------------------------------------------------
	-- Method
	------------------------------------------------------
	__Doc__[[The default refresh method, overridable]]
	function Refresh(self)
		if self:IsClass(Texture) then
			local index = self.Unit and GetRaidTargetIndex(self.Unit)

			if index then
				SetRaidTargetIconTexture(self, index)
				self.Visible = true
			else
				self.Visible = false
			end
		end
	end

	------------------------------------------------------
	-- Property
	------------------------------------------------------

	------------------------------------------------------
	-- Dispose
	------------------------------------------------------
	function Dispose(self)
		_IFRaidTargetUnitList[self] = nil
	end

	------------------------------------------------------
	-- Initializer
	------------------------------------------------------
	function IFRaidTarget(self)
		_IFRaidTargetUnitList[self] = _All

		-- Default Texture
		if self:IsClass(Texture) then
			if not self.TexturePath and not self.Color then
				self.TexturePath = [[Interface\TargetingFrame\UI-RaidTargetingIcons]]
			end
		end
	end
endinterface "IFRaidTarget"