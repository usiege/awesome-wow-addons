-- Author      : Kurapica
-- Create Date : 2012/06/25
-- Change Log  :

-- Check Version
local version = 1
if not IGAS:NewAddon("IGAS.Widget.Unit.CombatIcon", version) then
	return
end

__Doc__[[The combat indicator]]
class "CombatIcon"
	inherit "Texture"
	extend "IFCombat"

	------------------------------------------------------
	-- Constructor
	------------------------------------------------------
	function CombatIcon(self, name, parent, ...)
		Super(self, name, parent, ...)

		self.Height = 32
		self.Width = 32
	end
endclass "CombatIcon"