-- Author      : Kurapica
-- Create Date : 2012/09/01
-- Change Log  :

-- Check Version
local version = 2
if not IGAS:NewAddon("IGAS.Widget.Action.ActionButton", version) then
	return
end

__Doc__[[the base action button template]]
class "ActionButton"
	inherit "CheckButton"
	extend "IFActionHandler" "IFKeyBinding" "IFCooldownIndicator"

	RANGE_INDICATOR = "●"

	local function UpdateHotKey(self, value)
		local hotKey = self:GetChild("HotKey")

		if hotKey.Text == RANGE_INDICATOR then
			if value == true then
				hotKey:Show()
				hotKey:SetVertexColor(1, 1, 1)
			elseif value == false then
				hotKey:Show()
				hotKey:SetVertexColor(1, 0, 0)
			else
				hotKey:Hide()
			end
		else
			hotKey:Show()
			if value == false then
				hotKey:SetVertexColor(1, 0, 0)
			else
				hotKey:SetVertexColor(1, 1, 1)
			end
		end
	end

	------------------------------------------------------
	-- Event
	------------------------------------------------------

	------------------------------------------------------
	-- Method
	------------------------------------------------------
	__Doc__[[Update the action button when content is changed]]
	function UpdateAction(self)
		if self:HasAction() then
			self.NormalTexturePath = [[Interface\Buttons\UI-Quickslot2]]
		else
			self.NormalTexturePath = [[Interface\Buttons\UI-Quickslot]]
		end
	end

	__Doc__[[
		<desc>Set flyoutDirection for action button</desc>
		<param name="dir">System.Widget.Action.IFActionHandler.FlyoutDirection</param>
	]]
	function SetFlyoutDirection(self, dir)
		IFActionHandler.SetFlyoutDirection(self, dir)

		dir = self:GetAttribute("flyoutDirection")

		dir = dir == "UP" and "TOP"
			or dir == "DOWN" and "BOTTOM"
			or dir

		self:GetChild("FlyoutArrow"):ClearAllPoints()
		local point = dir == "TOP" and "BOTTOM"
							or dir == "BOTTOM" and "TOP"
							or dir == "LEFT" and "RIGHT"
							or dir == "RIGHT" and "LEFT"
		local angle = dir == "TOP" and 0
							or dir == "BOTTOM" and 180
							or dir == "LEFT" and 270
							or dir == "RIGHT" and 90
		self:GetChild("FlyoutArrow"):SetPoint(point, self, dir)
		self:GetChild("FlyoutArrow"):RotateDegree(angle)
	end

	------------------------------------------------------
	-- Property
	------------------------------------------------------
	__Doc__[[the action button icon's image file path, accessed by IFActionHandler]]
	property "Icon" {
		Get = function(self)
			return self:GetChild("Icon").TexturePath
		end,
		Set = function(self, value)
			self:GetChild("Icon").TexturePath = value
		end,
		Type = String+Number,
	}

	__Doc__[[the action's count, like item's count, accessed by IFActionHandler]]
	property "Count" {
		Get = function(self)
			return self:GetChild("Count").Text
		end,
		Set = function(self, value)
			self:GetChild("Count").Text = tostring(value or "")
		end,
		Type = StringNumber,
	}

	__Doc__[[the action's text, accessed by IFActionHandler]]
	property "Text" {
		Get = function(self)
			return self:GetChild("Name").Text
		end,
		Set = function(self, value)
			self:GetChild("Name").Text = value or ""
		end,
		Type = String,
	}

	__Doc__[[the action button's hotkey]]
	property "HotKey" {
		Get = function(self)
			return self:GetChild("HotKey").Text
		end,
		Set = function(self, value)
			self:GetChild("HotKey").Text = value or RANGE_INDICATOR
			UpdateHotKey(self)
		end,
		Type = String,
	}

	__Doc__[[the visible of the flash, accessed by IFActionHandler]]
	property "FlashVisible" {
		Get = function(self)
			return self:GetChild("Flash").Visible
		end,
		Set = function(self, value)
			self:GetChild("Flash").Visible = value
		end,
	}

	__Doc__[[the visible of the flyout arrow, accessed by IFActionHandler]]
	property "FlyoutVisible" {
		Get = function(self)
			return self:GetChild("FlyoutArrow").Visible
		end,
		Set = function(self, value)
			self:GetChild("FlyoutArrow").Visible = value
		end,
		Type = Boolean,
	}

	__Doc__[[whether the flyout action bar is shown, accessed by IFActionHandler]]
	property "Flyouting" {
		Get = function(self)
			return self:GetChild("FlyoutBorder").Visible
		end,
		Set = function(self, value)
			self:GetChild("FlyoutBorder").Visible = value
			self:GetChild("FlyoutBorderShadow").Visible = value
		end,
		Type = Boolean,
	}

	__Doc__[[whether the target is in range, accessed by IFActionHandler]]
	__Handler__( UpdateHotKey )
	property "InRange" { Type = BooleanNil_01 }

	__Doc__[[whether the action is usable, accessed by IFActionHandler]]
	__Handler__( function (self, value)
		if value then
			self:GetChild("Icon"):SetVertexColor(1.0, 1.0, 1.0)
		else
			self:GetChild("Icon"):SetVertexColor(0.4, 0.4, 0.4)
		end
	end )
	property "Usable" { Type = BooleanNil }

	__Doc__[[whether the action is auto castable, accessed by IFActionHandler]]
	__Handler__( function (self, value)
		if value then
			if not self:GetChild("AutoCastable") then
		    	local autoCast = Texture("AutoCastable", self, "OVERLAY")
		    	autoCast.Visible = false
		    	autoCast.TexturePath = [[Interface\Buttons\UI-AutoCastableOverlay]]
		    	autoCast:SetPoint("TOPLEFT", -14, 14)
		    	autoCast:SetPoint("BOTTOMRIGHT", 14, -14)
			end
			self:GetChild("AutoCastable").Visible = true
		else
			if self:GetChild("AutoCastable") then
				self:GetChild("AutoCastable").Visible = false
			end
		end
	end )
	property "AutoCastable" { Type = BooleanNil }

	__Doc__[[whether the action is now auto-casting, accessed by IFActionHandler]]
	__Handler__( function (self, value)
		if value then
			if not self:GetChild("AutoCastShine") then AutoCastShine("AutoCastShine", self) end
			self:GetChild("AutoCastShine"):Start()
		else
			if self:GetChild("AutoCastShine") then self:GetChild("AutoCastShine"):Stop() end
		end
	end )
	property "AutoCasting" { Type = BooleanNil }

	__Doc__[[Whether an indicator should be shown for equipped item]]
	__Handler__( function (self, value)
		if value then
			self.Border:SetVertexColor(0, 1.0, 0, 0.35)
			self.Border.Visible = true
		else
			self.Border.Visible = false
		end
	end )
	property "EquippedItemIndicator" { Type = BooleanNil }

	__Doc__[[Whether the action button's icon is locked]]
	__Handler__( function (self, value)
		self:GetChild("Icon"):SetDesaturated(value)
	end )
	property "IconLocked" { Type = BooleanNil }

	------------------------------------------------------
	-- Event Handler
	------------------------------------------------------

	------------------------------------------------------
	-- Constructor
	------------------------------------------------------
	function Constructor(self, name, parent, template)
    	if type(template) ~= "string" or strtrim(template) == "" then
    		return CreateFrame("CheckButton", name, parent, "SecureActionButtonTemplate")
    	else
    		if not template:find("SecureActionButtonTemplate") then
    			template = "SecureActionButtonTemplate,"..template
    		end
    		return CreateFrame("CheckButton", name, parent, template)
    	end
	end

    function ActionButton(self, ...)
    	Super(self, ...)

		self.Height = 36
		self.Width = 36

		-- Button Texture
		--- NormalTexture
		self.NormalTexturePath = [[Interface\Buttons\UI-Quickslot]]
		self.NormalTexture:ClearAllPoints()
		self.NormalTexture:SetPoint("TOPLEFT", -15, 15)
		self.NormalTexture:SetPoint("BOTTOMRIGHT", 15, -15)

		--- PushedTexture
		self.PushedTexturePath = [[Interface\Buttons\UI-Quickslot-Depress]]

		--- HighlightTexture
		self.HighlightTexturePath = [[Interface\Buttons\ButtonHilight-Square]]
		self.HighlightTexture.BlendMode = "Add"

		--- CheckedTexture
		self.CheckedTexturePath = [[Interface\Buttons\CheckButtonHilight]]
		self.CheckedTexture.BlendMode = "Add"

		-- BACKGROUND
		local icon = Texture("Icon", self, "BACKGROUND")
		icon:SetAllPoints(self)

		-- ARTWORK-1
		local flash = Texture("Flash", self, "ARTWORK", nil, 1)
		flash.Visible = false
		flash.TexturePath = [[Interface\Buttons\UI-QuickslotRed]]
		flash:SetAllPoints(self)

		local flyoutBorder = Texture("FlyoutBorder", self, "ARTWORK", nil, 1)
		flyoutBorder.Visible = false
		flyoutBorder.TexturePath = [[Interface\Buttons\ActionBarFlyoutButton]]
		flyoutBorder:SetTexCoord(0.01562500, 0.67187500, 0.39843750, 0.72656250)
		flyoutBorder:SetPoint("TOPLEFT", -3, 3)
		flyoutBorder:SetPoint("BOTTOMRIGHT", 3, -3)

		local flyoutBorderShadow = Texture("FlyoutBorderShadow", self, "ARTWORK", nil, 1)
		flyoutBorderShadow.Visible = false
		flyoutBorderShadow.TexturePath = [[Interface\Buttons\ActionBarFlyoutButton]]
		flyoutBorderShadow:SetTexCoord(0.01562500, 0.76562500, 0.00781250, 0.38281250)
		flyoutBorderShadow:SetPoint("TOPLEFT", -6, 6)
		flyoutBorderShadow:SetPoint("BOTTOMRIGHT", 6, -6)

		-- ARTWORK-2
		local flyoutArrow = Texture("FlyoutArrow", self, "ARTWORK", nil, 2)
		flyoutArrow.Visible = false
		flyoutArrow.TexturePath = [[Interface\Buttons\ActionBarFlyoutButton]]
		flyoutArrow:SetTexCoord(0.62500000, 0.98437500, 0.74218750, 0.82812500)
		flyoutArrow.Width = 23
		flyoutArrow.Height = 11
		flyoutArrow:SetPoint("BOTTOM", self, "TOP")

		local hotKey = FontString("HotKey", self, "ARTWORK", "NumberFontNormal", 2)
		hotKey.JustifyH = "Right"
		hotKey.Height = 10
		hotKey:SetPoint("TOPLEFT", 1, -3)
		hotKey:SetPoint("TOPRIGHT", -1, -3)

		local count = FontString("Count", self, "ARTWORK", "NumberFontNormal", 2)
		count.JustifyH = "Right"
		count:SetPoint("BOTTOMRIGHT", -2, 2)

		-- OVERLAY
		local name = FontString("Name", self, "OVERLAY", "GameFontHighlightSmallOutline")
		name.JustifyH = "Center"
		name.Height = 10
		name:SetPoint("BOTTOMLEFT", 0, 2)
		name:SetPoint("BOTTOMRIGHT", 0, 2)

		local border = Texture("Border", self, "OVERLAY")
		border.BlendMode = "Add"
		border.Visible = false
		border.TexturePath = [[Interface\Buttons\UI-ActionButton-Border]]
		border:SetPoint("TOPLEFT", -8, 8)
		border:SetPoint("BOTTOMRIGHT", 8, -8)
    end
endclass "ActionButton"