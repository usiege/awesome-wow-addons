----------------------
-- Dont touch this! --
----------------------

local EKMinimap, ns = ...
	ns[1] = {} -- C, config
	ns[2] = {} -- G, globals (Optionnal)

local C, G = unpack(select(2, ...))

	G.Ccolors = (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)[select(2, UnitClass("player"))] -- Class color / 職業顏色

local MediaFolder = "Interface\\AddOns\\EKMinimap\\Media\\"

-------------------
-- Golbal / 全局 --
-------------------

	C.QuestWatch = true		-- Enable Quest Watch Frame Style / 啟用任務追蹤美化
	C.ClickMenu = true		-- Enable Minimap Click Menu / 啟用右鍵微型選單
	C.Map = true			-- Enable Map fadeout and custom size / 啟用大地圖增強
	
	-- alt+右鍵按住移動 / alt+right click to drag
	-- 小地圖右鍵微型選單 / right click on minimap: micro menu
	-- 滾輪縮放區域，alt+滾輪縮放大小 / scroll to scale zone, alt+scroll to scale minimap frame

	-- slash cmd / 指令
	-- /rm 重置小地圖位置 / reset minimap frame position
	-- /rq 重置任務追蹤為置 / reset quest watch frame position
	
--------------------
-- Texture / 材質 --
--------------------

	G.Tex = "Interface\\Buttons\\WHITE8x8"
	G.glow = MediaFolder.."glow.tga"
	G.mail = MediaFolder.."mail.blp"

------------------
-- Fonts / 字型 --
------------------

	G.font = STANDARD_TEXT_FONT		-- 字型 / Font
	-- Minimap font / 小地圖字型
	G.fontSize = 14					-- 大小 / size
	G.fontFlag = "THINOUTLINE"		-- 描邊 / outline
	-- QuestWatchFrame / 任務追蹤字型
	G.QfontSize = 18				-- 大小 / size
	G.QfontFlag = "OUTLINE"			-- 描邊 / outline

-------------------------------
-- Minimap settings / 小地圖 --
-------------------------------

	C.size = 160  				-- 尺寸 / Size
	C.anchor = "TOPRIGHT"		-- 錨點 / Anchor "TOPLEFT" "TOPRIGHT" "BOTTOMLEFT" "BOTTOMRIGHT" etc.
	C.Point = {-10, -10}		-- 位置 / Position

---------------------------
-- Map settings / 大地圖 --
---------------------------

	C.scale = 0.6				-- 縮放 / Scale
	C.fade = true				-- 移動時的淡出 / Fadeout when moving
	C.alpha = 0.6				-- 淡出透明度 / Fadeout alpha

-------------------------------------
-- Quest watch settings / 任務追蹤 --
-------------------------------------

	C.QWF = {"TOPLEFT", UIParent, "TOPRIGHT", -300, -200}			-- 位置 / Position

--------------------
-- Credits / 銘謝 --
--------------------

	-- Felix S., sakaras, ape47, iMinimap by Chiril, ooMinimap by Ooglogput, intMinimap by Int0xMonkey
	-- NeavUI by Neal
	-- https://www.wowinterface.com/downloads/info13981-NeavUI.html#info
	-- ClickMenu by 10leej
	-- https://www.wowinterface.com/downloads/info22660-ClickMenu.html
	-- rObjectiveTracker by zork
	-- https://www.wowinterface.com/downloads/info18322-rObjectiveTracker.html