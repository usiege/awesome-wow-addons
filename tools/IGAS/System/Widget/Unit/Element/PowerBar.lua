-- Author      : Kurapica
-- Create Date : 2012/06/25
-- Change Log  :

-- Check Version
local version = 1
if not IGAS:NewAddon("IGAS.Widget.Unit.PowerBar", version) then
	return
end

__Doc__[[The power bar]]
class "PowerBar"
	inherit "StatusBar"
	extend "IFPower"

	------------------------------------------------------
	-- Constructor
	------------------------------------------------------
	function PowerBar(self, name, parent, ...)
		Super(self, name, parent, ...)

		self.FrameStrata = "LOW"
		self.UsePowerColor = true
	end
endclass "PowerBar"

__Doc__[[The frequent power bar]]
class "PowerBarFrequent"
	inherit "StatusBar"
	extend "IFPowerFrequent"

	------------------------------------------------------
	-- Constructor
	------------------------------------------------------
	function PowerBarFrequent(self, name, parent, ...)
		Super(self, name, parent, ...)

		self.FrameStrata = "LOW"
		self.UsePowerColor = true
	end
endclass "PowerBarFrequent"