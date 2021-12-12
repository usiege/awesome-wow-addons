-- Author      : Kurapica
-- Create Date : 2012/06/25
-- Change Log  :

-- Check Version
local version = 1
if not IGAS:NewAddon("IGAS.Widget.Unit.NameLabel", version) then
	return
end

__Doc__[[The unit name label with faction color settings]]
class "NameLabel"
	inherit "FontString"
	extend "IFUnitName" "IFFaction"

	_DefaultColor = ColorType(1, 1, 1)

	------------------------------------------------------
	-- Method
	------------------------------------------------------
	function Refresh(self)
		IFUnitName.Refresh(self)

		-- Handle the text color
		if self.Unit then
			if self.UseTapColor then
				if UnitIsTapDenied(self.Unit) then
					return self:SetTextColor(0.5, 0.5, 0.5)
				end
			end

			if self.UseSelectionColor and not UnitIsPlayer(self.Unit) then
				self:SetTextColor(UnitSelectionColor(self.Unit))
			elseif self.UseClassColor then
				self.TextColor = RAID_CLASS_COLORS[select(2, UnitClass(self.Unit))] or _DefaultColor
			end
		end
	end

	------------------------------------------------------
	-- Property
	------------------------------------------------------
	__Doc__[[Whether using the tap color, default false]]
	__Handler__( Refresh )
	property "UseTapColor" { Type = Boolean }

	__Doc__[[Whether using the selection color, default false]]
	__Handler__( Refresh )
	property "UseSelectionColor" { Type = Boolean }

	__Doc__[[Whether using the class color, default false]]
	__Handler__( Refresh )
	property "UseClassColor" { Type = Boolean }

	------------------------------------------------------
	-- Constructor
	------------------------------------------------------
	function NameLabel(self, name, parent, ...)
		Super(self, name, parent, ...)

		self.DrawLayer = "BORDER"
		self.TextColor = _DefaultColor
	end
endclass "NameLabel"