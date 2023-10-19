-- Author      : Kurapica
-- Create Date : 2013/11/25
-- Change Log  :

-- Check Version
local version = 1
if not IGAS:NewAddon("IGAS.Widget.Action.BagSlotHandler", version) then
	return
end

import "System.Widget.Action.ActionRefreshMode"

_Enabled = false

-- Event handler
function OnEnable(self)
	self:RegisterEvent("BAG_UPDATE")
	self:RegisterEvent("BAG_UPDATE_COOLDOWN")
	self:RegisterEvent("PLAYER_EQUIPMENT_CHANGED")
	self:RegisterEvent("PLAYER_REGEN_ENABLED")
	self:RegisterEvent("PLAYER_REGEN_DISABLED")

	OnEnable = nil

	return handler:Refresh()
end

function BAG_UPDATE(self)
	handler:Refresh(RefreshCount)
	return handler:Refresh(RefreshUsable)
end

function BAG_UPDATE_COOLDOWN(self)
	return handler:Refresh(RefreshCooldown)
end

function PLAYER_EQUIPMENT_CHANGED(self)
	return handler:Refresh()
end

function PLAYER_REGEN_ENABLED(self)
	handler:Refresh(RefreshCount)
	return handler:Refresh(RefreshUsable)
end

function PLAYER_REGEN_DISABLED(self)
	return handler:Refresh(RefreshUsable)
end

handler = ActionTypeHandler {
	Name = "bagslot",
	Target = "bag",
	Detail = "slot",

	DragStyle = "Keep",
	ReceiveStyle = "Keep",

	InitSnippet = [[
		_PickupContainerItem = [=[
			self:GetFrameRef("IFActionHandler_Manager"):RunFor(
				self, [==[
					Manager:CallMethod("PickupContainerItem", self:GetName())
				]==]
			)
		]=]
	]],
	UpdateSnippet = [[
		self:SetAttribute("type2", "item")
		self:SetAttribute("_bagslot", _PickupContainerItem)
	]],
	ClearSnippet = [[
		self:SetAttribute("type2", nil)
		self:SetAttribute("_bagslot", nil)
	]],
	ReceiveSnippet = "Custom",

	OnEnableChanged = function(self) _Enabled = self.Enabled end,
}

-- Click handler
IGAS:GetUI(handler.Manager).PickupContainerItem = function (self, btnName)
	self = rawget(_G, btnName)

	if self:GetAttribute("actiontype") == "bagslot" then
		local bag = tonumber(self:GetAttribute("bag"))
		local slot = tonumber(self:GetAttribute("slot"))

		if bag and slot then
			return PickupContainerItem(target, detail)
		end
	end
end

-- Overwrite methods
function handler:ReceiveAction(target, detail)
	return PickupContainerItem(target, detail)
end

function handler:HasAction()
	return true
end

function handler:GetActionTexture()
	local bag = self.ActionTarget
	local slot = self.ActionDetail

	return (GetContainerItemInfo(bag, slot))
end

function handler:GetActionCount()
	local bag = self.ActionTarget
	local slot = self.ActionDetail

	return (select(2, GetContainerItemInfo(bag, slot)))
end

function handler:GetActionCooldown()
	local bag = self.ActionTarget
	local slot = self.ActionDetail

	return GetContainerItemCooldown(bag, slot)
end

function handler:IsEquippedItem()
	local item = GetContainerItemID(self.ActionTarget, self.ActionDetail)

	return item and IsEquippedItem(item)
end

function handler:IsActivedAction()
	return false
end

function handler:IsUsableAction()
	local item = GetContainerItemID(self.ActionTarget, self.ActionDetail)

	return item and IsUsableItem(item)
end

function handler:IsConsumableAction()
	local item = GetContainerItemID(self.ActionTarget, self.ActionDetail)
	if not item then return false end

	local maxStack = select(8, item) or 0

	return IsUsableItem(item) and maxStack > 1
end

function handler:IsInRange()
	return IsItemInRange(GetContainerItemID(self.ActionTarget, self.ActionDetail), self:GetAttribute("unit"))
end

function handler:SetTooltip()
	GameTooltip:SetBagItem(self.ActionTarget, self.ActionDetail)
end

-- Expand IFActionHandler
interface "IFActionHandler"
	------------------------------------------------------
	-- Property
	------------------------------------------------------
	__Doc__[[The action button's content if its type is 'bag']]
	property "ItemBag" {
		Get = function(self)
			return self:GetAttribute("actiontype") == "bagslot" and tonumber(self:GetAttribute("bag"))
		end,
		Set = function(self, value)
			self:SetAction("bag", value)
		end,
		Type = Number,
	}

	__Doc__[[description]]
	property "ItemSlot" {
		Get = function(self)
			return self:GetAttribute("actiontype") == "bagslot" and tonumber(self:GetAttribute("slot"))
		end,
		Set = function(self, value)
			self:SetAction("slot", value)
		end,
		Type = Number,
	}
endinterface "IFActionHandler"