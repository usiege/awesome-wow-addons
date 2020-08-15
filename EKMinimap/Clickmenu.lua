local C, G = unpack(select(2, ...))

if not C.ClickMenu then return end

--  [[ Click Menu ]] --

-- Right Click Menu List
local menuFrame = CreateFrame("Frame", "MinimapRightClickMenu", UIParent, "UIDropDownMenuTemplate")
local menuList = {
	{	-- 標題
		text = MAINMENU_BUTTON,
		isTitle = true,
		notCheckable = true,
	},
	{	-- 角色
		text = CHARACTER_BUTTON,
		icon = "Interface\\PaperDollInfoFrame\\UI-EquipmentManager-Toggle",
		func = function()
			securecall(ToggleCharacter, "PaperDollFrame") 
		end,
		notCheckable = true,
	},
	{	-- 法術書
		text = SPELLBOOK_ABILITIES_BUTTON,
		icon = "Interface\\MINIMAP\\TRACKING\\Class",
		func = function() 
			--securecall(ToggleSpellBook, SpellBookFrame)
			if not SpellBookFrame:IsShown() then
				ShowUIPanel(SpellBookFrame)
			else
				HideUIPanel(SpellBookFrame)
			end
		end,
		notCheckable = true,
	},
	{	--天賦
		text = TALENTS,
		icon = "Interface\\MINIMAP\\TRACKING\\Ammunition",
		func = function() 
			if (not PlayerTalentFrame) then
				LoadAddOn("Blizzard_TalentUI")
			end
			if (not GlyphFrame) then
				LoadAddOn("Blizzard_GlyphUI")
			end
			securecall(ToggleFrame, TalentFrame)
		end,
		notCheckable = true,
	},
	{	-- 任務日誌
		text = QUESTLOG_BUTTON,	-- OLD: QUESTLOG_BUTTON
		icon = "Interface\\GossipFrame\\ActiveQuestIcon",
		func = function()
			securecall(ToggleFrame, QuestLogFrame)
		end,
		notCheckable = true,
	},
	{	-- 地圖
		text = WORLD_MAP,	-- OLD: QUESTLOG_BUTTON
		--icon = "Interface\\GossipFrame\\ActiveQuestIcon",
		icon = "Interface\\WorldMap\\UI-World-Icon",
		func = function() 
			securecall(ToggleFrame, WorldMapFrame)
			MaximizeUIPanel(WorldMapFrame)
		end,
		notCheckable = true,
	},
	{	-- 好友
		text = SOCIAL_BUTTON,
		icon = "Interface\\FriendsFrame\\UI-Toast-ChatInviteIcon",
		func = function() 
			securecall(ToggleFriendsFrame, 1) 
		end,
		notCheckable = true,
	},
	{	-- 公會
		text = GUILD,
		icon = "Interface\\GossipFrame\\TabardGossipIcon",
		arg1 = IsInGuild("player"),
		func = function() 
			if (not GuildFrame) then
				LoadAddOn("Blizzard_GuildUI")
			end
			--GuildFrame_Toggle()
			securecall(ToggleFriendsFrame, 3)
		end,
		notCheckable = true,
	},
	{	-- 空行
		text = "",
		isTitle = true,
		notCheckable = true,
	},
	{	-- 其他
		text = OTHER,
		isTitle = true,
		notCheckable = true,
	},
	{	-- 背包
		text = BACKPACK_TOOLTIP,
		icon = "Interface\\MINIMAP\\TRACKING\\Banker",
		func = function()
			securecall(ToggleAllBags)
		end,
		notCheckable = true,
	},
	{	-- PVP
		text = PLAYER_V_PLAYER,
		icon = "Interface\\MINIMAP\\TRACKING\\BattleMaster",
		func = function() 
			--securecall(ToggleHonorFrame)
			securecall(ToggleCharacter, "HonorFrame")
		end,
		notCheckable = true,
	},
	{	-- 團隊
		text = RAID,
		icon = "Interface\\Buttons\\UI-GuildButton-PublicNote-Up",
		func = function() 
			securecall(ToggleFriendsFrame, 4)
		end,
		notCheckable = true,
	},
	{	-- 客服支援
		text = GM_EMAIL_NAME,
		icon = "Interface\\CHATFRAME\\UI-ChatIcon-Blizz",
		func = function() 
			securecall(ToggleHelpFrame) 
		end,
		notCheckable = true,
	},
	{	-- 語音
		text = CHANNEL,
		icon = "Interface\\CHATFRAME\\UI-ChatIcon-ArmoryChat-AwayMobile",
		func = function()
			ToggleChannelFrame()
		end,
		notCheckable = true
	},
	{	-- 區域地圖
		text = BATTLEFIELD_MINIMAP,
		colorCode = "|cff999999",
		func = function()
			if not BattlefieldMapFrame then 
				LoadAddOn("Blizzard_BattlefieldMap") 
			end
			BattlefieldMapFrame:Toggle()
		end,
		notCheckable = true,
	},
	{	-- 空行
		text = "",
		isTitle = true,
		notCheckable = true,
	},
	{	-- 重載
		text = RELOADUI,
		colorCode = "|cff999999",
		func = function()
			ReloadUI()
		end,
		notCheckable = true,
	},
}

-- Right Click for Game Menu / 右鍵遊戲選單
Minimap:SetScript("OnMouseUp", function(self, button)
	if button == "RightButton" then
		EasyMenu(menuList, menuFrame, self, (Minimap:GetWidth() * .7), -3, "MENU", 3)
	else
		Minimap_OnClick(self)
	end
end)

-- avoid taint / 避免taint
local initialize = CreateFrame("Frame")
initialize:SetScript("OnEvent", function()
	ShowUIPanel(SpellBookFrame)
	HideUIPanel(SpellBookFrame)
end)/
initialize:RegisterEvent("PLAYER_ENTERING_WORLD")