-- Author      : Kurapica
-- Create Date : 2012/07/12
-- Change Log  :

-- Check Version
local version = 1
if not IGAS:NewAddon("IGAS.Widget.Unit.IFCombat", version) then
	return
end

_IFCombatUnitList = _IFCombatUnitList or UnitList(_Name)

function _IFCombatUnitList:OnUnitListChanged()
	self:RegisterEvent("PLAYER_REGEN_DISABLED")
	self:RegisterEvent("PLAYER_REGEN_ENABLED")

	self.OnUnitListChanged = nil
end

function _IFCombatUnitList:ParseEvent(event, unit)
	self:EachK("player", "Refresh")
end

__Doc__[[IFCombat is used to check whether the player is in the combat]]
interface "IFCombat"
	extend "IFUnitElement"

	------------------------------------------------------
	-- Method
	------------------------------------------------------
	__Doc__[[The default refresh method, overridable]]
	function Refresh(self)
		self.Visible = self.Unit == 'player' and UnitAffectingCombat('player')
	end

	------------------------------------------------------
	-- Property
	------------------------------------------------------
	__Doc__[[which used to receive the check result]]
	__Optional__() property "Visible" { Type = Boolean }

	------------------------------------------------------
	-- Event Handler
	------------------------------------------------------
	local function OnUnitChanged(self)
		_IFCombatUnitList[self] = self.Unit
		Refresh(self)
	end

	------------------------------------------------------
	-- Dispose
	------------------------------------------------------
	function Dispose(self)
		_IFCombatUnitList[self] = nil
	end

	------------------------------------------------------
	-- Initializer
	------------------------------------------------------
	function IFCombat(self)
		self.OnUnitChanged = self.OnUnitChanged + OnUnitChanged

		-- Default Texture
		if self:IsClass(Texture) then
			if not self.TexturePath and not self.Color then
				self.TexturePath = [[Interface\CharacterFrame\UI-StateIcon]]
				self:SetTexCoord(.5, 1, 0, .49)
			end
		end
	end
endinterface "IFCombat"