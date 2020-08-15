local name, addon = ...
ADDON05 = addon
print(name)
print(addon)

-- 这里的addon是一个空的table
local main_frame = MainFrame
local main_width = MainFrame:GetWidth()
local main_height = MainFrame:GetHeight()

-- 标题 纹理
local tex = main_frame:CreateTexture(nil, "ARTWORK") --ARTWORK表示从Frame的模板默认层继承
tex:SetTexture("Interface/DialogFrame/UI-DialogBox-Header")
tex:SetWidth(main_width/2.0)
tex:SetHeight(64)
tex:SetPoint("TOP", main_frame, 0, 15)
main_frame.texture = tex

--  给标题添加文字
local title = main_frame:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
title:SetText("控件基础")
title:SetPoint('TOP', main_frame.texture, 0, -15)


-- 写一个类似于系统设置的页面
--------------------------------------------------------------
-- 							选项条目							--
--------------------------------------------------------------
local y_pad = -5
local h_pad = 45
local item_frame = CreateFrame("Frame", "item_frame", main_frame)
item_frame:SetWidth(main_width/3.0-15)
item_frame:SetHeight(main_height-h_pad)
item_frame:SetPoint("LEFT", main_frame, "LEFT", 15, y_pad)
item_frame:SetBackdrop({
	--bgFile = "Interface\\ItemTextFrame\\Book",s
	bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
	edgeSize = "Interface\\DialogFrame\\UI-DialogBox-Border",
	title = false,
	tileSize = 0, edgeSize = 0,
	insets = { left = 0, right = 0, top = 0, bottom = 0 }
})





--------------------------------------------------------------
-- 							具体内容							--
--------------------------------------------------------------
-- 具体内容
local record_frame = CreateFrame("Frame", "record_frame", main_frame)
record_frame:SetWidth(main_width/3.0*2-20)
record_frame:SetHeight(main_height-h_pad)
record_frame:SetPoint("LEFT", item_frame, "RIGHT", 5, 0)
record_frame:SetBackdrop({
	bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
	edgeSize = "Interface\\DialogFrame\\UI-DialogBox-Border",
	title = false,
	tileSize = 0, edgeSize = 0,
	insets = { left = 0, right = 0, top = 0, bottom = 0 }
})


