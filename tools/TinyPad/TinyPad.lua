local tinypad = TinyPad
local editBox = TinyPadEditBox

local current = 1 -- current page being viewed

TinyPadPages = {} -- the pages for TinyPad are in a numerically indexed table of strings (or tables for bookmarked pages)
TinyPadSettings = {} -- settings (Locked, Font)
local pages, settings -- will assign these in PLAYER_LOGIN after savedvars load
local undoPage -- the original contents of a page to undo to

-- list of fonts to cycle through
tinypad.fonts = {
	{"Fonts\\FRIZQT__.TTF",10},
	{"Fonts\\FRIZQT__.TTF",12}, -- default
	{"Fonts\\FRIZQT__.TTF",16},
	{"Fonts\\ARIALN.TTF",12},
	{"Fonts\\ARIALN.TTF",16},
	{"Fonts\\ARIALN.TTF",20},
	{"Fonts\\MORPHEUS.ttf",16,"OUTLINE"},
	{"Fonts\\MORPHEUS.ttf",24,"OUTLINE"},
	-- add fonts here
}

-- key binding interface constants
BINDING_HEADER_TINYPAD = "TinyPad"
BINDING_NAME_TINYPAD_TOGGLE = "Show/Hide TinyPad"
BINDING_NAME_TINYPAD_SEARCH = "Search within TinyPad"

function tinypad:PLAYER_LOGIN()
	-- savedvars
	pages = TinyPadPages
	settings = TinyPadSettings
	settings.Font = settings.Font or 2

	-- slash command stuff
	SlashCmdList["TINYPADSLASH"] = tinypad.SlashHandler
	SLASH_TINYPADSLASH1 = "/pad"
	SLASH_TINYPADSLASH2 = "/tinypad"
	-- setup the rest
	editBox:SetHyperlinksEnabled(true)
	self:SetMinResize(268,96)
	tinypad:UpdateLock()
	tinypad:UpdateFont()

	-- attach tooltip and OnClicks to each titlebar/search button
	for key,info in pairs({
		["close"] = {"Close","TinyPad version "..GetAddOnMetadata("TinyPad","Version"),tinypad.Toggle},
		["new"] = {"New","Add a new page after the last page.\n\n\124cFFA5A5A5Hold Shift to insert after the current page.",tinypad.NewPage},
		["delete"] = {"Delete","Permanently remove this page.\n\n\124cFFA5A5A5Hold Shift to delete without confirmation.",tinypad.DeletePage },
		["run"] = {"Run","Run this page as a lua script.",tinypad.RunPage},
		["undo"] = {"Undo","Revert this page to last saved text.",tinypad.Undo},
		["config"] = {"Options","Search pages for text, change font or lock window.",tinypad.TogglePanel},
		["bookmark"] = {"Bookmarks","Go to a bookmarked page or manage bookmarks.",tinypad.ToggleBookmarks},
		["first"] = {"First Page","Go to the first page\n\n\124cFFA5A5A5Hold Shift to move this page to the first page.",tinypad.FirstPage},
		["previous"] = {"Previous","Go to previous page.\n\n\124cFFA5A5A5Hold Shift to move this page back one page.",tinypad.PreviousPage},
		["next"] = {"Next","Go to next page.\n\n\124cFFA5A5A5Hold Shift to move this page forward one page.",tinypad.NextPage},
		["last"] = {"Last Page","Go to the last page.\n\n\124cFFA5A5A5Hold Shift to move this page to the last page.",tinypad.LastPage},
		["panel.find"] = {"Find Next","Find next page with this text.\n\n\124cFFA5A5A5Hold Shift to find last page with this text.",tinypad.SearchOnEnter},
		["panel.lock"] = {"Lock","Lock or unlock the window, preventing it from being moved or dismissed with the ESCape key.",tinypad.ToggleLock},
		["panel.font"] = {"Font","Cycle through different fonts.\n\n\124cFFA5A5A5Hold Shift to cycle backwards.",tinypad.NextFont},
      ["panel.size"] = {"Size","Toggle the size of TinyPad.",tinypad.ToggleSize},
		["bookmarks.add"] = {"Save Bookmark","Bookmark this page. When a page is bookmarked you can return to it later by selecting it in the menu below."},
		["bookmarks.remove"] = {"Remove Bookmark","Remove the bookmark for this page."},
	}) do
		local parentKey,subKey = key:match("(%w+)%.(%w+)")
		local button = parentKey and tinypad[parentKey][subKey] or tinypad[key]
		button.tooltipTitle = info[1]
		button.tooltipBody = info[2]
		if info[3] then
			button:SetScript("OnClick",info[3])
		end
	end

	-- if no pages made yet, create one
	if #pages==0 then
		tinsert(pages,"")
	end
	current = #pages

	self:RegisterEvent("PLAYER_LOGOUT")

	-- set up chat link hooks
	tinypad:RegisterEvent("ADDON_LOADED") -- tradeskill and achievement hooks need to wait for LoD bits
	local old_ChatEdit_InsertLink = ChatEdit_InsertLink
	function ChatEdit_InsertLink(text)
		if editBox:HasFocus() then
			editBox:Insert(text)
			return true -- prevents the stacksplit frame from showing
		else
			return old_ChatEdit_InsertLink(text)
		end
	end

end

function tinypad:PLAYER_LOGOUT()
	if tinypad:IsVisible() then
		tinypad:SaveCurrentPage()
	end
end

-- to insert tradeskills and achievements links, their hooks need to wait until those LoD bits load
function tinypad:ADDON_LOADED(addon)
	if addon=="Blizzard_TradeSkillUI" then
		local linkButton = TradeSkillFrame.LinkToButton
		local old = linkButton:GetScript("OnClick")
		linkButton:SetScript("OnClick",function(self,...)
			if editBox:HasFocus() then
				return editBox:Insert(C_TradeSkillUI.GetTradeSkillListLink())
			else
				return old(self,...)
			end
		end)
	elseif addon=="Blizzard_AchievementUI" then
		local old_AchievementButton_OnClick = AchievementButton_OnClick
		function AchievementButton_OnClick(self,...)
			if editBox:HasFocus() and IsModifiedClick("CHATLINK") then
				return editBox:Insert(GetAchievementLink(self.id))
			else
				return old_AchievementButton_OnClick(self,...)
			end
		end
	end
end

-- returns the body of given page number
function tinypad:GetPageText(page)
	local page = page or current
	if type(pages[page])=="table" then -- bookmarked
		return pages[page][2]
	else
		return pages[page] -- not bookmarked
	end
end

function tinypad:Toggle()
	tinypad:SetShown(not tinypad:IsVisible())
end

function tinypad:OnMouseDown()
	if not settings.Lock then
		tinypad:StartMoving()
	end
end

function tinypad:OnMouseUp()
	if not settings.Lock then
		tinypad:StopMovingOrSizing()
	end
end

function tinypad:OnShow()
	self:UpdateESCable()
   self:ShowPage(current)
   self:UpdateScale()
end

function tinypad:OnHide()
	tinypad:SaveCurrentPage()
	tinypad.panel:Hide()
	self:UpdateESCable()
end

function tinypad:OnTextChanged()
   tinypad.undo:SetEnabled(undoPage~=editBox:GetText())
   tinypad:SaveCurrentPage()
end

-- this mimics ScrollingEdit_OnCursorChanged in UIPanelTemplates.lua, but instead
-- of having an always-running OnUpdate, this just turns on the OnUpdate for one frame
function tinypad:OnCursorChanged(x,y,w,h)
	self.cursorOffset = y
	self.cursorHeight = h
	self.handleCursorChange = true;
	self:SetScript("OnUpdate",tinypad.OnCursorOnUpdate)
end

-- this is triggered from OnCursorChanged, and immediately shuts down and calls
-- ScrollingEdit_OnUpdate defined in UIPanelTemplates.lua
function tinypad:OnCursorOnUpdate(elapsed)
	self:SetScript("OnUpdate",nil)
	ScrollingEdit_OnUpdate(self,elapsed,self:GetParent())
end

-- when user clicks on a link in the main editbox, most stuff goes to SetItemRef
-- tradeskill and pet abilities will use extra handling to make them toggle
-- also if tradeskill is up, clicking a link should move to that item in the tradeskill frame
function tinypad:OnHyperlinkClick(link,text,button)
	if IsModifiedClick("CHATLINK") and not editBox:HasFocus() then
		SetItemRef(link,text,button) -- if shift down, send straight to SetItemRef
	else
		if link:match("^trade:") and TradeSkillFrame and TradeSkillFrame:IsVisible() then
			if text==GetTradeSkillListLink() then
				HideUIPanel(TradeSkillFrame) -- clicked tradeskill we're looking at, hide it
			else
				SetItemRef(link,text,button) -- clicked a different tradeskill, send it on
			end
		elseif link:match("^battlePetAbil:") and FloatingPetBattleAbilityTooltip:IsVisible() then
			FloatingPetBattleAbilityTooltip:Hide()
		else -- none of the above, let it go to SetItemRef
			if TradeSkillFrame and TradeSkillFrame:IsVisible() then -- if tradeskill up, see if it's something to jump to
				local itemName = GetItemInfo(link)
				for _,recipeID in ipairs(C_TradeSkillUI.GetAllRecipeIDs()) do
					if C_TradeSkillUI.GetRecipeInfo(recipeID).name==itemName then
						TradeSkillFrame.RecipeList:SelectedAndForceRecipeIDIntoView(recipeID)
						return
					end
				end
			end
			SetItemRef(link,text,button)
		end
	end
end

-- at most only one entry from TinyPad should be in UISpecialFrames, and only when visible:
-- TinyPadBookmarks > TinyPad
-- this will go through UISpecialFrames and ensure only the topmost frame is in the table and remove others
function tinypad:UpdateESCable()
	local specialFound
	local specialFrame = (tinypad.bookmarks:IsVisible() and "TinyPadBookmarks") or (not settings.Lock and tinypad:IsVisible() and "TinyPad")
	for i=#UISpecialFrames,1,-1 do
		local frameName = UISpecialFrames[i]
		if frameName=="TinyPad" or frameName=="TinyPadBookmarks" then
			if frameName~=specialFrame then
				tremove(UISpecialFrames,i)
			else
				specialFound = true
			end
		end
	end
	if not specialFound and specialFrame then
		tinsert(UISpecialFrames,specialFrame)
	end
end

-- when the window is locked, the border is black, grey when unlocked
function tinypad:UpdateLock()
	local c = settings.Lock and 0 or .75
	tinypad:SetBackdropBorderColor(c,c,c)
	tinypad.panel:SetBackdropBorderColor(c,c,c)
	tinypad.resize:SetShown(not settings.Lock)
end

function tinypad:UpdateFont()
	editBox:SetFont(unpack(tinypad.fonts[settings.Font]))
end

--[[ titlebar buttons ]]

function tinypad:UpdateButtonStates()
	tinypad.first:SetEnabled(current>1)
	tinypad.previous:SetEnabled(current>1)
	tinypad.next:SetEnabled(current<#pages)
	tinypad.last:SetEnabled(current<#pages)
	tinypad.undo:SetEnabled(undoPage~=pages[current])
end

function tinypad:SaveCurrentPage()
	if type(pages[current])=="table" then
		pages[current][2] = editBox:GetText()
	else
		pages[current] = editBox:GetText()
	end
end

function tinypad:ShowPage(page)
	if not tinypad:IsVisible() then
		tinypad:Show()
	end
   if page and page>0 and page<=#pages then
		current = page
      editBox:ClearFocus()
		editBox:SetText(tinypad:GetPageText())
		editBox:SetCursorPosition(0)
		tinypad.pageNumber:SetText(current)
		tinypad:UpdateButtonStates()
		tinypad.bookmarks:Hide()
      undoPage = tinypad:GetPageText()
	end
end

function tinypad:NewPage()
	tinypad:SaveCurrentPage()
	if IsShiftKeyDown() then
		tinsert(pages,current+1,"")
		tinypad:ShowPage(current+1)
	else
		tinsert(pages,"")
		tinypad:ShowPage(#pages)
	end
end

function tinypad:NextPage()
	tinypad:SaveCurrentPage()
	if IsShiftKeyDown() then
		tinypad:SwapPages(current,current+1)
	end
	current = min(#pages,current+1)
	tinypad:ShowPage(current)
end

function tinypad:PreviousPage()
	tinypad:SaveCurrentPage()
	if IsShiftKeyDown() then
		tinypad:SwapPages(current,current-1)
	end
	current = max(1,current-1)
	tinypad:ShowPage(current)
end

function tinypad:FirstPage()
	tinypad:SaveCurrentPage()
	if IsShiftKeyDown() then
		tinypad:MovePage(current,1)
	end
	current = 1
	tinypad:ShowPage(current)
end

function tinypad:LastPage()
	tinypad:SaveCurrentPage()
	if IsShiftKeyDown() then
		tinypad:MovePage(current,#pages)
	end
	current = #pages
	tinypad:ShowPage(current)
end

function tinypad:DeletePage(bypass)
	if IsShiftKeyDown() or bypass==true or editBox:GetText():len()==0 then
		tremove(pages,current)
		if #pages==0 then
			tinsert(pages,"")
		end
		tinypad:ShowPage(min(#pages,current))
	else
		StaticPopupDialogs["TINYPADCONFIRM"] = StaticPopupDialogs["TINYPADCONFIRM"] or { text="Delete this page?", button1=YES, button2=NO, timeout=0, whileDead=1, OnAccept=function() tinypad:DeletePage(true) end}
		StaticPopup_Show("TINYPADCONFIRM")
	end
end

function tinypad:RunPage(page)
	tinypad:SaveCurrentPage()
	RunScript(tinypad:GetPageText(tonumber(page)):gsub("^/run",""))
end

function tinypad:Undo()
	local position = editBox:GetCursorPosition()
	editBox:SetText(undoPage)
	editBox:SetCursorPosition(position)
end

--[[ moving pages ]]

-- swaps page number page1 with page number page2
function tinypad:SwapPages(page1,page2)
	if pages[page1] and pages[page2] then
		local save = pages[page1]
		pages[page1] = pages[page2]
		pages[page2] = save
	end
end

-- moves page number from to page number to
function tinypad:MovePage(from,to)
	if from<1 or from>#pages or to<1 or to>#pages then
		return -- don't allow a page to move beyond range of pages
	end
	local save = pages[from]
	tremove(pages,from)
	tinsert(pages,to,save)
end

--[[ panel ]]

function tinypad:TogglePanel()
	tinypad.bookmarks:Hide()
	tinypad.panel:SetShown(not tinypad.panel:IsShown())
	if not tinypad:IsVisible() then
		tinypad:Show()
	end
	if tinypad.panel:IsShown() then
		tinypad.panel.searchBox:SetFocus()
	end
end

function tinypad:ToggleLock()
	settings.Lock = not settings.Lock
	tinypad:UpdateESCable()
	tinypad:UpdateLock()
end

function tinypad:NextFont()
	local numFonts = #tinypad.fonts
	settings.Font = (settings.Font+(IsShiftKeyDown() and (numFonts-2) or 0))%numFonts + 1
	tinypad:UpdateFont()
end

function tinypad:ToggleSize()
   settings.LargeScale = not settings.LargeScale
   tinypad:UpdateScale()
end

function tinypad:UpdateScale()
   if settings.LargeScale then
      tinypad:SetScale(1.25)
      tinypad.bookmarks:SetScale(UIParent:GetEffectiveScale()/tinypad:GetEffectiveScale())
   else
      tinypad:SetScale(1)
      tinypad.bookmarks:SetScale(1)
   end
end

--[[ search ]]

local function literal(c) return "%"..c end
local function caseinsensitive(c) return format("[%s%s]",c:lower(),c:upper()) end

function tinypad:SearchOnTextChanged()
	if tinypad.undo:IsEnabled() then
		tinypad:SaveCurrentPage()
		tinypad.undo:Disable()
	end
	tinypad.searchText = self:GetText():gsub("[%(%)%.%%%+%-%*%?%[%]%^%$]",literal):gsub("%a",caseinsensitive)
	if tinypad.searchText:len()>0 then
		tinypad:UpdateSearchCount()
		tinypad.panel.searchBox.clear:Show()
		tinypad.panel.find:Enable()
	else
		tinypad.panel.result:SetText("Search:")
		tinypad.panel.searchBox.clear:Hide()
		tinypad.panel.find:Disable()
	end
end

function tinypad:UpdateSearchCount()
	local search = tinypad.searchText
	local count = 0
	for i=1,#pages do
		if tinypad:GetPageText(i):match(search) then
			count = count + 1
		end
	end
	tinypad.panel.result:SetText(format("%s\npages",count==0 and "no" or count))
end

function tinypad:SearchOnEnter()
	local search = tinypad.searchText
	if search and search:len()>0 then
		if tinypad.undo:IsEnabled() then
			tinypad:SaveCurrentPage()
			tinypad.undo:Disable()
			tinypad:UpdateSearchCount()
		end
		local page = current
		local numPages = #pages
		local direction = IsShiftKeyDown() and -2 or 0
		for i=1,numPages do
			page = (page+direction)%numPages+1
			if tinypad:GetPageText(page):match(search) then
				tinypad:ShowPage(page)
				return
			end
		end
	end
end

--[[ bookmarks ]]

function tinypad:ToggleBookmarks()
	tinypad.panel:Hide()
	if tinypad.bookmarks:IsVisible() then
		tinypad.bookmarks:Hide()
	else
		tinypad:UpdateBookmarks()
		tinypad.bookmarks:SetFrameLevel(tinypad:GetFrameLevel()+5)
		tinypad.bookmarks:Show()
	end
end

-- after a second of the mouse not being over bookmark button or bookmarks frame, bookmark frame hides
function tinypad:BookmarksOnUpdate(elapsed)
	if MouseIsOver(self) or MouseIsOver(tinypad.bookmark) or tinypad.bookmarks.prompt:HasFocus() then
		self.timer = 0
	else
		self.timer = self.timer + elapsed
		if self.timer > 1 then
			self:Hide()
		end
	end
end

-- returns an available bookmark button from a pool
function tinypad:GetBookmarkButton()
	for _,button in ipairs(tinypad.bookmarks.buttons) do
		if not button:IsShown() then
			return button
		end
	end
	local button = CreateFrame("Button",nil,tinypad.bookmarks,"TinyPadBookmarkTemplate")
	tinsert(tinypad.bookmarks.buttons,button)
	return button
end

-- updates the bookmarks window to display all bookmarked pages
function tinypad:UpdateBookmarks()
	local bookmarks = tinypad.bookmarks
	bookmarks.buttons = bookmarks.buttons or {}
	bookmarks.prompt:Hide()
	bookmarks.add:SetShown(type(pages[current])~="table")
	bookmarks.remove:SetShown(type(pages[current])=="table")
	for i=1,#bookmarks.buttons do
		bookmarks.buttons[i]:Hide()
	end
	local yoffset = -10
	local showBack = true
	for i=1,#pages do
		if type(pages[i])=="table" then
			local button = tinypad:GetBookmarkButton()
			button:SetID(i)
			yoffset = yoffset - 18
			button:SetPoint("TOP",0,yoffset)
			button.name:SetText(pages[i][1])
			button.back:SetShown(showBack)
			showBack = not showBack -- alternate whether back shows or not (lighter background)
			button.mark:SetShown(i==current) -- mark current page if it's this bookmark
			button.name:SetWidth(i==current and 132 or 140) -- and adjust width for mark
			button:Show()
		end
	end
	bookmarks:SetHeight(-yoffset+24)
end

function tinypad:BookmarkOnClick()
	if self:GetID()>0 then
		tinypad:ShowPage(self:GetID())
		if IsShiftKeyDown() then
			tinypad:RunPage()
		end
	end
end

function tinypad:BookmarkPromptOnTextChanged()
	local text = self:GetText()
	if text:len()==0 then
		self.enter:Disable()
		self.label:Show()
	else
		self.enter:Enable()
		self.label:Hide()
	end
end

function tinypad:BookmarkPromptOnEnter()
	local title = self:GetText()
	if title:len()>0 then
		pages[current] = { title, pages[current] }
	end
	tinypad:UpdateBookmarks()
end

function tinypad:BookmarkRemove()
	local text = self:GetPageText()
	pages[current] = text
	tinypad:UpdateBookmarks()
end

--[[ tooltips ]]

function tinypad:ShowTooltip()
	if self.tooltipTitle then
		GameTooltip_SetDefaultAnchor(GameTooltip,UIParent)
		GameTooltip:AddLine(self.tooltipTitle)
		if self.tooltipBody then
			GameTooltip:AddLine(self.tooltipBody,.95,.95,.95,true)
		end
		GameTooltip:Show()
	end
end

function tinypad:ShowBookmarkTooltip()
	local page = self:GetID()
	GameTooltip_SetDefaultAnchor(GameTooltip,UIParent)
	GameTooltip:AddLine(pages[page][1],1,.82,0,1)
	GameTooltip:AddLine(format("Page %d",page),.65,.65,.65)
	GameTooltip:AddLine(pages[page][2]:sub(1,128):gsub("\n"," "),.9,.9,.9,1)
	GameTooltip:AddLine("Hold Shift to run this page as a script.",.65,.65,.65,1)
	GameTooltip:Show()
end

--[[ slash handler ]]

-- /pad # will go to a page, /pad run # will run a page, /pad alone toggles window
function tinypad.SlashHandler(msg)
	msg = (msg or ""):lower()
	local runPage = tonumber(msg:match("run (%d+)"))
	local page = tonumber(msg:match("(%d+)"))
	if msg=="run" then -- run alone will run current page
		tinypad:RunPage()
	elseif runPage and pages[runPage] then -- run <num> will run page <num>
		tinypad:RunPage(runPage)
	elseif page and pages[page] then -- <num> alone will jump to page <num>
		tinypad:ShowPage(page)
	else
		tinypad:Toggle()
	end
end

--[[ functions for outside use ]]

-- TinyPad:Run(<number>) will run page <number>
function tinypad:Run(page)
	if type(self)=="number" then -- TinyPad.Run was used instead of TinyPad:Run
		page = self
	end
	if type(page)=="number" then
		tinypad:RunPage(page)
	end
end

-- this will delete all pages that contain a regex (ie "^Glyphioneer Suggestions"
-- will delete all pages that begin (^) with "Glyphioneer Suggestions".  This
-- is used primarily for addons that generate a report and want to clean up
-- old copies of data.  Use carefully!
function tinypad:DeletePagesContaining(regex)
	if type(self)=="string" then -- TinyPad.Delete... was used instead of TinyPad:Delete...
		regex = self
	end
	if type(regex)=="string" then
		for i=#pages,1,-1 do
			if tinypad:GetPageText(i):match(regex) then
				tremove(pages,i)
			end
		end
		if #pages==0 then
			tinsert(pages,"")
		end
		current = min(current,#pages)
		tinypad:ShowPage(current)
	end
end

-- TinyPad:Insert("body") -- creates a new page with "text"
-- TinyPad:Insert("body","title") -- creates a new page bookmarked as "title" that contains "text"
-- TinyPad:Insert("body",<number>) -- creates a new page with "text" at page <number>
-- TinyPad:Insert("body",<number>,"title") -- creates a new page bookmarked as "title" that contains "text" at page <number>
function tinypad:Insert(body,page,bookmark)
	if type(self)=="string" then -- TinyPad.Insert was used instead of TinyPad:Insert
		bookmark = page
		page = body
		body = self
	end
	if not type(body)=="string" then
		return -- a valid body not given, leave
	end
	if not page then -- ("body")
		tinsert(pages,body)
		current = #pages
	elseif type(page)=="string" then -- ("body","title")
		tinsert(pages,{page,body})
		current = #pages
	else -- page is a number
		page = max(1,min(#pages+1,page)) -- make sure it's in range
		if not bookmark then
			tinsert(pages,page,body) -- ("body",<number>)
		else
			tinsert(pages,page,{bookmark,body}) -- ("body",<number>,"title")
		end
		current = page
	end
	tinypad:ShowPage(current)
end
