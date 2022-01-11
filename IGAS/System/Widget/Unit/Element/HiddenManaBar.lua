-- Author      : Kurapica
-- Create Date : 2012/06/25
-- Change Log  :

-- Check Version
local version = 1
if not IGAS:NewAddon("IGAS.Widget.Unit.HiddenManaBar", version) then
	return
end

__Doc__[[The mana bar shown for druid and monk when the unit's power type is not mana]]
class "HiddenManaBar"
	inherit "StatusBar"
	extend "IFMana"

	------------------------------------------------------
	-- Constructor
	------------------------------------------------------
	function HiddenManaBar(self, name, parent, ...)
		Super(self, name, parent, ...)

		self.FrameStrata = "LOW"
	end
endclass "HiddenManaBar"
