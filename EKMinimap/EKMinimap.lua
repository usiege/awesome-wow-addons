local C, G = unpack(select(2, ...))

-- for k,v in pairs((select(2, ...))) do
--     print(k, v)
-- end

-- DEFAULT_CHAT_FRAME:AddMessage(...)
-- DEFAULT_CHAT_FRAME:AddMessage("C")
-- for k,v in pairs(C) do
-- 	print(k,v)
-- end

-- DEFAULT_CHAT_FRAME:AddMessage("G")
-- for k,v in pairs(G) do
-- 	print(k,v)
-- end
--====================================================--
-----------------    [[ Function ]]    -----------------
--====================================================--

-- Create font style / 字型
local function CreateFS(parent, justify)
	local frame = parent:CreateFontString(nil, "OVERLAY")
	
	frame:SetFont(G.font, G.fontSize, G.fontFlag)
	frame:SetShadowColor(0, 0, 0, 0)
	frame:SetShadowOffset(0, 0)
	
	if justify then
		frame:SetJustifyH(justify)
	end
	
	return frame
end

-- Create shadow border / 陰影邊框
local CreateShadow = function(parent, anchor, size)
	local sd = CreateFrame("Frame", nil, parent)
	local framelvl = parent:GetFrameLevel()
	
	sd:ClearAllPoints()
	sd:SetPoint("TOPLEFT", anchor, -size, size)
	sd:SetPoint("BOTTOMRIGHT", anchor, size, -size)
	sd:SetFrameLevel(framelvl == 0 and 0 or framelvl-1)
	sd:SetBackdrop({
		edgeFile = G.glow,	-- 陰影邊框
		edgeSize = size,	-- 邊框大小
	})
	--sd:SetBackdropColor(0, 0, 0, 1)
	sd:SetBackdropBorderColor(0, 0, 0, 1)
	
	return sd
end

--================================================--
-----------------    [[ Core ]]    -----------------
--================================================--

-- [[ Make A Square / 弄成方型 ]] --

function GetMinimapShape()
	return "SQUARE"
end

-- [[ Minimap ]] --

local Minimap = Minimap
	-- Core
	Minimap:SetMaskTexture(G.Tex)
	Minimap:SetSize(C.size, C.size)
	Minimap:SetScale(1)
	Minimap:SetFrameStrata("LOW")
	Minimap:SetFrameLevel(3)
	-- Position
	Minimap:ClearAllPoints()
	Minimap:SetPoint(C.anchor, UIParent, unpack(C.Point))
	MinimapCluster:ClearAllPoints()
	MinimapCluster:SetAllPoints(Minimap)
	-- 錨點於小地圖的其他元素，比如耐久度跟載具那些鬼玩意
	MinimapCluster:ClearAllPoints()
	MinimapCluster:SetAllPoints(Minimap)
	-- MinimapCluster:EnableMouse(false)
	-- Shadow Border
	Minimap.BG = CreateShadow(Minimap, Minimap, 5)

	-- Movable
	Minimap:SetMovable(true)
	Minimap:EnableMouse(true)
	-- Alt+right click to drag frame
	Minimap:RegisterForDrag("RightButton")
	Minimap:SetScript("OnDragStart", function(self)
		if IsAltKeyDown() then
			self:StartMoving()
		end
	end)
	Minimap:SetScript("OnDragStop", function(self)
		self:StopMovingOrSizing()
	end)
	-- Reset / 重置
	Minimap:SetUserPlaced(true)
	SlashCmdList["RESETMINIMAP"] = function()
		Minimap:SetUserPlaced(false)
		ReloadUI()
	end
	SLASH_RESETMINIMAP1 = "/resetminimap"
	SLASH_RESETMINIMAP2 = "/rm"

-- [[ Hide Script ]] --

-- Hide Clock / 隱藏時鐘
local ClockFrame = CreateFrame("Frame", nil, UIParent)
ClockFrame:SetScript("OnEvent", function(self, event, name)
	if name == "Blizzard_TimeManager" then
		TimeManagerClockButton:Hide()
		TimeManagerClockButton:SetScript("OnShow", function(self)
			TimeManagerClockButton:Hide()
		end)
	end
end)
ClockFrame:RegisterEvent("ADDON_LOADED")

-- Hide All / 隱藏各種
local HideAll = {
	"MinimapBorder",			-- 大圈
	"MinimapBorderTop",
	"MinimapNorthTag",			-- 指北針
	"MiniMapWorldMapButton",	-- 世界地圖
	"MinimapZoneTextButton",	-- 區域名字
	"MinimapToggleButton",
	"MinimapZoomIn",			-- 放大
	"MinimapZoomOut",			-- 縮小
	"GameTimeFrame",			-- 時間
	"SubZoneTextFrame",
	"DurabilityFrame",			-- 裝備耐久度
}
for i, v in pairs(HideAll) do
	getglobal(v).Show = function() end
	getglobal(v):Hide()
end

--=====================================================--
-----------------    [[ Indicator ]]    -----------------
--=====================================================--

-- Mail Frame / 信件提示
MiniMapMailFrame:ClearAllPoints()
MiniMapMailFrame:SetParent(Minimap)
if C.anchor == "TOPLEFT" or C.anchor == "BOTTOMLEFT" then
	MiniMapMailFrame:SetPoint("BOTTOMLEFT", Minimap, 0, 0)
else
	MiniMapMailFrame:SetPoint("BOTTOMRIGHT", Minimap, 0, 0)
end
MiniMapMailBorder:Hide()
MiniMapMailIcon:SetTexture(G.mail)

-- Minimap Tracker / 追蹤
MiniMapTrackingFrame:ClearAllPoints()
if C.anchor == "TOPLEFT" or C.anchor == "BOTTOMLEFT" then
	MiniMapTrackingFrame:SetPoint("BOTTOMRIGHT", Minimap, 0, 0)
else
	MiniMapTrackingFrame:SetPoint("BOTTOMLEFT", Minimap, 0, 0)
end
MiniMapTrackingBorder:Hide()
MiniMapTrackingIcon:SetScale(0.8)
MiniMapTrackingIcon:SetTexCoord(.08, .92, .08, .92)
MiniMapTrackingFrame.BG = CreateShadow(MiniMapTrackingFrame, MiniMapTrackingIcon, 3)

--================================================--
-----------------    [[ Misc ]]    -----------------
--================================================--

-- [[ Scroll ]] --

-- Scroll Zoom, Alt+Scroll Scale / 滾輪縮放區域，alt滾輪縮放大小
local function OnMouseWheel(self, delta)
	if IsAltKeyDown() then
		local i = Minimap:GetScale()
		 if delta > 0 and i < 4 then
			Minimap:SetScale(i+0.1)
		 elseif delta < 0 and i > 0.5 then
			Minimap:SetScale(i-0.1)
		end
	else
		if delta > 0 then
			Minimap_ZoomIn()
		else
			Minimap_ZoomOut()
		end
	end
end
Minimap:SetScript("OnMouseWheel", OnMouseWheel)

-- [[ Ping ]] --

-- Show minimap ping / 顯示誰點擊了小地圖
local WhoPing = CreateFrame("Frame", nil, Minimap)
	WhoPing:SetSize(100, 20)
	WhoPing:SetPoint("BOTTOM", Minimap, 0, 2)
	WhoPing:RegisterEvent("MINIMAP_PING")

	local WhoPingText = CreateFS(WhoPing, "CENTER")
	WhoPingText:SetPoint("CENTER")

	local anim = WhoPing:CreateAnimationGroup()
	anim:SetScript("OnPlay", function()
		WhoPing:SetAlpha(1)
	end)
	anim:SetScript("OnFinished", function()
		WhoPing:SetAlpha(0)
	end)
	anim.fader = anim:CreateAnimation("Alpha")
	anim.fader:SetFromAlpha(1)
	anim.fader:SetToAlpha(0)
	anim.fader:SetDuration(4)
	anim.fader:SetSmoothing("OUT")
	anim.fader:SetStartDelay(3)

	WhoPing:SetScript("OnEvent", function(_, _, unit)
		local class = select(2, UnitClass(unit))
		local name = GetUnitName(unit)
		local classcolor = 	(CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)[class]

		anim:Stop()
		WhoPingText:SetText(name)
		WhoPingText:SetTextColor(classcolor.r, classcolor.g, classcolor.b)
		anim:Play()
	end)