-- Author      : Kurapica
-- Create Date : 2012/06/25
-- Change Log  :

-- Check Version
local version = 2
if not IGAS:NewAddon("IGAS.Widget.Unit.RoleIcon", version) then
	return
end

_M:RegisterEvent"PLAYER_REGEN_DISABLED"
_M:RegisterEvent"PLAYER_REGEN_ENABLED"

_RoleIcon_HideInCombat = _RoleIcon_HideInCombat or {}

_InCombat = false

function PLAYER_REGEN_DISABLED(self)
	_InCombat = true
	for icon in pairs(_RoleIcon_HideInCombat) do
		icon:Refresh()
	end
end

function PLAYER_REGEN_ENABLED(self)
	_InCombat = false
	for icon in pairs(_RoleIcon_HideInCombat) do
		icon:Refresh()
	end
end

__Doc__[[The group role indicator]]
class "RoleIcon"
	inherit "Texture"
	extend "IFGroupRole"

	------------------------------------------------------
	-- Method
	------------------------------------------------------
	------------------------------------
	--- Refresh the element
	-- -- ------------------------------------
	function Refresh(self)
		if not _M._InCombat or self.ShowInCombat then
			local role = self.Unit and UnitGroupRolesAssigned(self.Unit)

			if role == 'TANK' or role == 'HEALER' or role == 'DAMAGER' then
				if self:IsClass(Texture) then
					self:SetTexCoord(GetTexCoordsForRoleSmallCircle(role))
				end
				self.Visible = true
			else
				self.Visible = false
			end
		else
			self.Visible = false
		end
	end

	------------------------------------------------------
	-- Property
	------------------------------------------------------
	__Handler__( function (self, value)
		if value then
			_RoleIcon_HideInCombat[self] = nil
		else
			_RoleIcon_HideInCombat[self] = true
		end
		self:Refresh()
	end )
	property "ShowInCombat" { Type = Boolean }

	------------------------------------------------------
	-- Constructor
	------------------------------------------------------
	function RoleIcon(self, name, parent, ...)
		Super(self, name, parent, ...)

		self.Height = 16
		self.Width = 16

		self.TexturePath = [[Interface\LFGFrame\UI-LFG-ICON-PORTRAITROLES]]

		_RoleIcon_HideInCombat[self] = true
	end
endclass "RoleIcon"