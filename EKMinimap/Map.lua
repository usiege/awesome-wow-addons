local C, G = unpack(select(2, ...))

if not C.Map then return end

--================================================--
-----------------    [[ Core ]]    -----------------
--================================================--

local WMF = WorldMapFrame
	WMF:SetScale(C.scale)						-- Scale / 縮放
	WMF.BlackoutFrame.Blackout:SetAlpha(0)		-- No background / 去背
	--WMF.BlackoutFrame.Blackout = function() end
	WMF.BlackoutFrame:EnableMouse(false)		-- Click through / 點擊穿透	
	-- Cursor match scale / 滑鼠跟隨縮放
	WMF.ScrollContainer.GetCursorPosition = function(f)
		local x,y = MapCanvasScrollControllerMixin.GetCursorPosition(f)
		local s = WorldMapFrame:GetScale()
		
		return x/s, y/s
	end
	
	-- Movable
	WMF:SetMovable(true)						-- 使地圖可移動
	WMF:SetUserPlaced(true)						-- 使框架可以超出畫面
	WMF:ClearAllPoints()
	WMF.ClearAllPoints = function() end			-- 使座標可自訂義
	WMF:SetPoint("LEFT", UIParent)				-- Default at left / 初始化於畫面左邊
	WMF.SetPoint = function() end				-- 使拖動過的位置可以被儲存
	
	-- Alt+right click to drag frame / alt+右鍵拖動
	WMF:RegisterForDrag("RightButton")
	WMF:SetScript("OnDragStart", function(self)
		if IsAltKeyDown() then
			self:StartMoving()
		end
	end)
	WMF:SetScript("OnDragStop", function(self)
		self:StopMovingOrSizing()
	end)
	
	-- Reset / 重置
	SlashCmdList["RESETMAP"] = function()
		WMF:SetUserPlaced(false)
		ReloadUI()
	end
	SLASH_RESETMAP1 = "/resetmap"
	SLASH_RESETMAP2 = "/rmp"
	
	-- Fadeout when moving / 移動時淡出
	local MoveFade = CreateFrame("Frame")
	MoveFade:SetScript("OnEvent", function(_, event, ...)
		local PMFF = PlayerMovementFrameFader
		
		if event == "PLAYER_STOPPED_MOVING" then
			PMFF.AddDeferredFrame(WMF, 1, 1, .5)
		elseif event == "PLAYER_STARTED_MOVING" then
			PMFF.AddDeferredFrame(WMF, C.alpha, 1, .5)
		end
	end)

	MoveFade:RegisterEvent("PLAYER_STARTED_MOVING")
	MoveFade:RegisterEvent("PLAYER_STOPPED_MOVING")