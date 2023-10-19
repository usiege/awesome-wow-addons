-- Author      : Kurapica
-- Create Date : 2012/07/22
-- Change Log  :

-- Check Version
local version = 1
if not IGAS:NewAddon("IGAS.Widget.Unit.TotemBar", version) then
	return
end

__Doc__[[The totem bar]]
class "TotemBar"
	inherit "LayoutPanel"
	extend "IFTotem"

	MAX_TOTEMS = _G.MAX_TOTEMS

	-----------------------------------------------
	--- Totem
	-- -- -----------------------------------------------
	class "Totem"
		inherit "Button"
		extend "IFCooldownIndicator"

		_Border = {
		    edgeFile = [[Interface\ChatFrame\CHATFRAMEBACKGROUND]],
		    edgeSize = 2,
		}

		_BorderColor = ColorType(0, 0, 0)

		------------------------------------------------------
		-- Property
		------------------------------------------------------
		-- Icon
		property "Icon" {
			Get = function(self)
				return self:GetChild("Icon").TexturePath
			end,
			Set = function(self, value)
				self:GetChild("Icon").TexturePath = value
			end,
			Type = String,
		}

		local function OnClick(self)
			if self.Slot then
				DestroyTotem(self.Slot)
			end
		end

		local function UpdateTooltip(self)
			self = IGAS:GetWrapper(self)
			if self.Slot then
				IGAS.GameTooltip:SetTotem(self.Slot)
			end
		end

		local function OnEnter(self)
			if self.Visible and self.Slot then
				IGAS.GameTooltip:SetOwner(self, "ANCHOR_BOTTOMRIGHT")
				UpdateTooltip(self)
			end
		end

		local function OnLeave(self)
			IGAS.GameTooltip:Hide()
		end

		------------------------------------------------------
		-- Constructor
		------------------------------------------------------
	    function Totem(self, name, parent, ...)
    		Super(self, name, parent, ...)

			self.Visible = false
			self:SetSize(36, 36)

			self:RegisterForClicks("RightButtonUp")

			local icon = Texture("Icon", self, "BACKGROUND")
			icon:SetPoint("TOPLEFT", 1, -1)
			icon:SetPoint("BOTTOMRIGHT", -1, 1)

			self.Backdrop = _Border
			self.BackdropBorderColor = RAID_CLASS_COLORS[select(2, UnitClass("player"))]

			self.OnEnter = self.OnEnter + OnEnter
			self.OnLeave = self.OnLeave + OnLeave
			IGAS:GetUI(self).UpdateTooltip = UpdateTooltip
	    end
	endclass "Totem"

	------------------------------------------------------
	-- Constructor
	------------------------------------------------------
	function TotemBar(self, name, parent, ...)
		Super(self, name, parent, ...)

		local pct = floor(100 / MAX_TOTEMS)
		local margin = (100 - pct * MAX_TOTEMS) / 2

		self.FrameStrata = "LOW"
		self.Toplevel = true
		self:SetSize(108, 24)

		local btnTotem

		for i = 1, MAX_TOTEMS do
			btnTotem = Totem("Totem"..i, self)
			btnTotem.ID = i

			self:AddWidget(btnTotem)

			self:SetWidgetLeftWidth(btnTotem, margin + (i-1)*pct, "pct", pct-1, "pct")

			self[i] = btnTotem
		end
	end
endclass "TotemBar"