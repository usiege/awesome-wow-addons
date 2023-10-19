-- Author      : Kurapica
-- Create Date : 2013/11/25
-- Change Log  :

-- Check Version
local version = 1
if not IGAS:NewAddon("IGAS.Widget.Action.BagHandler", version) then
	return
end

import "System.Widget.Action.ActionRefreshMode"

enum "BagSlotCountStyle" {
	"Hidden",
	"Empty",
	"Total",
	"AllEmpty",
	"All",
}

_Enabled = false

_BagSlotMapTemplate = "_BagSlotMap[%d] = %d"

_BagSlotMap = {
	[0] = "BackSlot",
	"Bag0Slot",
	"Bag1Slot",
	"Bag2Slot",
	"Bag3Slot",
}

_ContainerMap = {}

function OnEnable(self)
	self:RegisterEvent("ITEM_LOCK_CHANGED")
	self:RegisterEvent("CURSOR_UPDATE")

	self:RegisterEvent("BAG_UPDATE_DELAYED")
	self:RegisterEvent("INVENTORY_SEARCH_UPDATE")

	local cache = {}
	for i, slot in pairs(_BagSlotMap) do
		local id, texture = GetInventorySlotInfo(slot)
		_BagSlotMap[i] = { id = id, texture = texture, slot = slot }
		tinsert(cache, _BagSlotMapTemplate:format(i, id))
	end

	if next(cache) then
		Task.NoCombatCall(function ()
			handler:RunSnippet( tblconcat(cache, ";") )

			for _, btn in handler() do
				local target = tonumber(btn.ActionTarget)

				if target == 0 then
					btn:SetAttribute("*type*", "macro")
					btn:SetAttribute("*macrotext*", "/click MainMenuBarBackpackButton")
				elseif target and target <= 4 then
					btn:SetAttribute("*type*", "macro")
					btn:SetAttribute("*macrotext*", "/click CharacterBag".. tostring(target-1) .."Slot")
				else
					btn:SetAttribute("*type*", nil)
					btn:SetAttribute("*macrotext*", nil)
				end
				local id = target ~= 0 and _BagSlotMap[target] and _BagSlotMap[target].id or target or false
				IFPushItemAnim.AttachBag(btn, id)
			end

			handler:Refresh()
		end)
	end

	OnEnable = nil
end

function ITEM_LOCK_CHANGED(self, bag, slot)
	if not slot then
		for i, map in pairs(_BagSlotMap) do
			if map.id == bag then
				local flag = IsInventoryItemLocked(bag)
				for _, btn in handler() do
					if btn.ActionTarget == i then btn.IconLocked = flag end
				end
				break
			end
		end
	end
end

function CURSOR_UPDATE(self)
	for _, btn in handler() do
		local target = _BagSlotMap[btn.ActionTarget]
		if target then
			btn.HighlightLocked = CursorCanGoInSlot(target.id)
		end
	end
end

function BAG_UPDATE_DELAYED(self)
	for _, btn in handler() do
		handler:Refresh(btn)
		local target = _BagSlotMap[btn.ActionTarget]
		if target then
			btn.IconLocked = IsInventoryItemLocked(target.id)
		end
	end
end

function INVENTORY_SEARCH_UPDATE(self)
	for _, btn in handler() do
		btn.ShowSearchOverlay = IsContainerFiltered(btn.ActionTarget)
	end
end

handler = ActionTypeHandler {
	Name = "bag",
	DragStyle = "Keep",
	ReceiveStyle = "Keep",
	InitSnippet = [[ _BagSlotMap = newtable() ]],
	PickupSnippet = [[
		return "clear", "bag", _BagSlotMap[...]
	]],
	ReceiveSnippet = "Custom",
	UpdateSnippet = [[
		local target = ...
		target = tonumber(target)

		if target == 0 then
			self:SetAttribute("*type*", "macro")
			self:SetAttribute("*macrotext*", "/click MainMenuBarBackpackButton")
		elseif target and target <= 4 then
			self:SetAttribute("*type*", "macro")
			self:SetAttribute("*macrotext*", "/click CharacterBag".. tostring(target-1) .."Slot")
		else
			self:SetAttribute("*type*", nil)
			self:SetAttribute("*macrotext*", nil)
		end

		Manager:CallMethod("UpdateForPushItemAnim", self:GetName(), target)
	]],
	ClearSnippet = [[
		self:SetAttribute("*type*", nil)
		self:SetAttribute("*macrotext*", nil)

		Manager:CallMethod("UpdateForPushItemAnim", self:GetName(), false)
	]],
	OnEnableChanged = function(self) _Enabled = self.Enabled end,
}

-- Use Manager to control the IFPushItemAnim
IGAS:GetUI(handler.Manager).UpdateForPushItemAnim = function (self, name, target)
	local id = target ~= 0 and _BagSlotMap[target] and _BagSlotMap[target].id or target or false
	return IFPushItemAnim.AttachBag(IGAS:GetWrapper(_G[name]), id)
end

-- Overwrite methods
function handler:ReceiveAction(target, detail)
	if target == 0 then
		return PutItemInBackpack()
	elseif target and target <= 4 then
		return PutItemInBag(_BagSlotMap[target].id)
	end
end

function handler:HasAction()
	return _BagSlotMap[self.ActionTarget] and true or false
end

function handler:GetActionTexture()
	if self.ActionTarget == 0 then return MainMenuBarBackpackButtonIconTexture:GetTexture() end
	local target = _BagSlotMap[self.ActionTarget]
	return target and GetInventoryItemTexture("player", target.id) or target.texture
end

function handler:GetActionCharges()
	local style = self.BagSlotCountStyle
	if style == "Hidden" then
		return nil
	elseif style == "Empty" or style == "Total" then
		local free, total = GetContainerNumFreeSlots(self.ActionTarget), GetContainerNumSlots(self.ActionTarget)
		if style == "Empty" then
			return free, total
		else
			return total, total
		end
	elseif style == "AllEmpty" or style == "All" then
		local sFree, sTotal, free, total, bagFamily = 0, 0
		local _, tarFamily = GetContainerNumFreeSlots(self.ActionTarget)
		if not tarFamily then return nil end
		for i = BACKPACK_CONTAINER, NUM_BAG_SLOTS do
			free, bagFamily = GetContainerNumFreeSlots(i)
			total = GetContainerNumSlots(i)
			if bagFamily == tarFamily then
				sFree = sFree + free
				sTotal = sTotal + total
			end
		end
		if self.ActionTarget == 0 then
			self.__BagHandler_FreeSlots = sFree
		end
		if style == "AllEmpty" then
			return sFree, sTotal
		else
			return sTotal, sTotal
		end
	end
end

function handler:IsActivedAction()
	local id = self.ActionTarget
	local containers = _ContainerMap[id]
	local flag = containers and containers[1] and containers[1].Visible
	if not flag and _ContainerMap[100] then
		for _, container in ipairs(_ContainerMap[100]) do
			if container.ID == id and container.Visible then
				return true
			end
		end
	end
	return flag
end

function handler:SetTooltip(GameTooltip)
	local target = self.ActionTarget
	if target == 0 then
		GameTooltip:SetOwner(self, "ANCHOR_LEFT")
		GameTooltip:SetText(BACKPACK_TOOLTIP, 1.0, 1.0, 1.0)
		local keyBinding = GetBindingKey("TOGGLEBACKPACK")
		if ( keyBinding ) then
			GameTooltip:AppendText(" "..NORMAL_FONT_COLOR_CODE.."("..keyBinding..")"..FONT_COLOR_CODE_CLOSE)
		end
		GameTooltip:AddLine(string.format(NUM_FREE_SLOTS, (self.__BagHandler_FreeSlots or 0)))
		GameTooltip:Show()
	elseif _BagSlotMap[target] then
		local id = _BagSlotMap[target].id
		if ( GameTooltip:SetInventoryItem("player", id) ) then
			local bindingKey = GetBindingKey("TOGGLEBAG"..(5 -  target))
			if ( bindingKey ) then
				GameTooltip:AppendText(" "..NORMAL_FONT_COLOR_CODE.."("..bindingKey..")"..FONT_COLOR_CODE_CLOSE)
			end
			if (not IsInventoryItemProfessionBag("player", ContainerIDToInventoryID(target))) then
				for i = LE_BAG_FILTER_FLAG_EQUIPMENT, NUM_LE_BAG_FILTER_FLAGS do
					if ( GetBagSlotFlag(target, i) ) then
						GameTooltip:AddLine(BAG_FILTER_ASSIGNED_TO:format(BAG_FILTER_LABELS[i]))
						break
					end
				end
			end
			GameTooltip:Show()
		else
			GameTooltip:SetText(EQUIP_CONTAINER, 1.0, 1.0, 1.0)
		end
	end
end

-- Expand IFActionHandler
interface "IFActionHandler"
	local function OnShowOrHide(self)
		return handler:Refresh(RefreshButtonState)
	end

	------------------------------------------------------
	-- Static Method
	------------------------------------------------------
	__Doc__[[
		<desc>Register container to control the bag slot button's button state</desc>
		<param name="container">the container frame</param>
		<param name="id" optional="true">the container index, un-register if false, use container's id if true</param>
	]]
	__Static__()  __Arguments__{ Region, Argument(Number) }
	function RegisterContainer(container, id)
		container.OnShow = container.OnShow - OnShowOrHide
		container.OnHide = container.OnHide - OnShowOrHide
		for k, v in pairs(_ContainerMap) do
			for i, c in ipairs(v) do
				if c == container then
					tremove(c, i)
					break
				end
			end
		end

		_ContainerMap[id] = _ContainerMap[id] or {}
		tinsert(_ContainerMap[id], 1, container)

		container.OnShow = container.OnShow + OnShowOrHide
		container.OnHide = container.OnHide + OnShowOrHide
	end

	__Static__()  __Arguments__{ Region, Argument(Boolean, true, true) }
	function RegisterContainer(container, id)
		container.OnShow = container.OnShow - OnShowOrHide
		container.OnHide = container.OnHide - OnShowOrHide
		for k, v in pairs(_ContainerMap) do
			for i, c in ipairs(v) do
				if c == container then
					tremove(c, i)
					break
				end
			end
		end
		if id ~= false then
			id = 100

			_ContainerMap[id] = _ContainerMap[id] or {}
			tinsert(_ContainerMap[id], container)

			container.OnShow = container.OnShow + OnShowOrHide
			container.OnHide = container.OnHide + OnShowOrHide
		end
	end

	------------------------------------------------------
	-- Property
	------------------------------------------------------
	__Doc__[[The action button's content if its type is 'bag']]
	property "BagSlot" {
		Get = function(self)
			return self:GetAttribute("actiontype") == "bag" and tonumber(self:GetAttribute("bag"))
		end,
		Set = function(self, value)
			self:SetAction("bag", value)
		end,
		Type = struct { 0,
			function (value)
				assert(type(value) == "number", "%s must be number.")
				assert(value >= 0 and value <= 4, "%s must between [0-4]")
				return math.floor(value)
			end
		},
	}

	__Doc__[[Whether the search overlay will be shown]]
	__Handler__(function (self, value)
		-- Create it when needed
		local overlay = self:GetChild("SearchOverlay")
		if value then
			if not overlay then
				overlay = Texture("SearchOverlay", self, "OVERLAY", nil, 2)
				overlay:SetAllPoints(self)
				overlay:SetTexture(0, 0, 0, 0.8)
			end
			overlay.Visible = true
		elseif overlay then
			overlay.Visible = false
		end
	end)
	property "ShowSearchOverlay" { Type = Boolean }

	__Doc__[[What to be shown as the count]]
	__Handler__(RefreshCount)
	property "BagSlotCountStyle" { Type = BagSlotCountStyle, Default = "Hidden" }
endinterface "IFActionHandler"

-- Init the _ContainerMap
for i=1, NUM_CONTAINER_FRAMES do IFActionHandler.RegisterContainer(IGAS["ContainerFrame"..i]) end