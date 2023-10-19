-- Author      : Kurapica
-- Create Date : 2012/06/25
-- Change Log  :

-- Check Version
local version = 1
if not IGAS:NewAddon("IGAS.Widget.Unit.QuestBossIcon", version) then
	return
end

__Doc__[[The quest boss indicator]]
class "QuestBossIcon"
	inherit "Texture"
	extend "IFClassification"

	------------------------------------------------------
	-- Constructor
	------------------------------------------------------
	function QuestBossIcon(self, name, parent, ...)
		Super(self, name, parent, ...)

		self.Height = 32
		self.Width = 32
	end
endclass "QuestBossIcon"