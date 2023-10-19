-- Author      : Kurapica
-- Create Date : 2012/07/12
-- Change Log  :

-- Check Version
local version = 1
if not IGAS:NewAddon("IGAS.Widget.Unit.IFClassification", version) then
	return
end

_IFClassificationUnitList = _IFClassificationUnitList or UnitList(_Name)

function _IFClassificationUnitList:OnUnitListChanged()
	self:RegisterEvent("UNIT_CLASSIFICATION_CHANGED")

	self.OnUnitListChanged = nil
end

__Doc__[[IFClassification is used to check whether the unit's classification, the default refresh method is used to check if the unit is a quest boss]]
interface "IFClassification"
	extend "IFUnitElement"

	------------------------------------------------------
	-- Method
	------------------------------------------------------
	__Doc__[[The default refresh method, overridable]]
	function Refresh(self)
		self.Visible = self.Unit and UnitIsQuestBoss(self.Unit)
	end

	------------------------------------------------------
	-- Property
	------------------------------------------------------
	__Doc__[[which used to receive the check result]]
	property "Visible" { Type = Boolean }

	------------------------------------------------------
	-- Event Handler
	------------------------------------------------------
	local function OnUnitChanged(self)
		_IFClassificationUnitList[self] = self.Unit
	end

	------------------------------------------------------
	-- Dispose
	------------------------------------------------------
	function Dispose(self)
		_IFClassificationUnitList[self] = nil
	end

	------------------------------------------------------
	-- Initializer
	------------------------------------------------------
	function IFClassification(self)
		self.OnUnitChanged = self.OnUnitChanged + OnUnitChanged

		-- Default Texture
		if self:IsClass(Texture) then
			if not self.TexturePath and not self.Color then
				self.TexturePath = [[Interface\TargetingFrame\PortraitQuestBadge]]
			end
		end
	end
endinterface "IFClassification"