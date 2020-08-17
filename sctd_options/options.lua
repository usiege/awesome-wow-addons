--The Options Page variables and functions

--check SCT version
if (not SCT) or (tonumber(SCT.version) < 6.0) then
	StaticPopup_Show("SCTD_VERSION");
	if (SCTOptionsFrame_Misc103) then
		SCTOptionsFrame_Misc103:Hide();
	end
	return;
end

--add tab to sct tab table
SCT.OptionFrames["SCTOptionsFrame_Misc103"] = "SCTDOptions";

SCTD.OptionFrames = {["SCTOptionsFrame_Misc104"] = "SCTDOptions_EventsFrame",
										 ["SCTOptionsFrame_Misc105"] = "SCTDOptions_DisplayFrame",
										 ["SCTOptionsFrame_Misc106"] = "SCTDOptions_FrameFrame"}

--Event and Damage option values
SCT.OPTIONS.FrameEventFrames [SCT.LOCALS.OPTION_EVENT101.name] = { index = 101, tooltipText = SCT.LOCALS.OPTION_EVENT101.tooltipText, SCTVar = "SCTD_SHOWMELEE"};
SCT.OPTIONS.FrameEventFrames [SCT.LOCALS.OPTION_EVENT102.name] = { index = 102, tooltipText = SCT.LOCALS.OPTION_EVENT102.tooltipText, SCTVar = "SCTD_SHOWPERIODIC"};
SCT.OPTIONS.FrameEventFrames [SCT.LOCALS.OPTION_EVENT103.name] = { index = 103, tooltipText = SCT.LOCALS.OPTION_EVENT103.tooltipText, SCTVar = "SCTD_SHOWSPELL"};
SCT.OPTIONS.FrameEventFrames [SCT.LOCALS.OPTION_EVENT104.name] = { index = 104, tooltipText = SCT.LOCALS.OPTION_EVENT104.tooltipText, SCTVar = "SCTD_SHOWPET"};
SCT.OPTIONS.FrameEventFrames [SCT.LOCALS.OPTION_EVENT105.name] = { index = 105, tooltipText = SCT.LOCALS.OPTION_EVENT105.tooltipText, SCTVar = "SCTD_SHOWCOLORCRIT"};
SCT.OPTIONS.FrameEventFrames [SCT.LOCALS.OPTION_EVENT106.name] = { index = 106, tooltipText = SCT.LOCALS.OPTION_EVENT106.tooltipText, SCTVar = "SCTD_SHOWINTERRUPT"};
SCT.OPTIONS.FrameEventFrames [SCT.LOCALS.OPTION_EVENT107.name] = { index = 107, tooltipText = SCT.LOCALS.OPTION_EVENT107.tooltipText, SCTVar = "SCTD_SHOWDMGSHIELD"};

--Check Button option values
SCT.OPTIONS.FrameCheckButtons [SCT.LOCALS.OPTION_CHECK101.name] = { index = 101, tooltipText = SCT.LOCALS.OPTION_CHECK101.tooltipText, SCTVar = "SCTD_ENABLED"};
SCT.OPTIONS.FrameCheckButtons [SCT.LOCALS.OPTION_CHECK102.name] = { index = 102, tooltipText = SCT.LOCALS.OPTION_CHECK102.tooltipText, SCTVar = "SCTD_FLAGDMG"};
SCT.OPTIONS.FrameCheckButtons [SCT.LOCALS.OPTION_CHECK103.name] = { index = 103, tooltipText = SCT.LOCALS.OPTION_CHECK103.tooltipText, SCTVar = "SCTD_SHOWDMGTYPE"};
SCT.OPTIONS.FrameCheckButtons [SCT.LOCALS.OPTION_CHECK104.name] = { index = 104, tooltipText = SCT.LOCALS.OPTION_CHECK104.tooltipText, SCTVar = "SCTD_SHOWSPELLNAME"};
SCT.OPTIONS.FrameCheckButtons [SCT.LOCALS.OPTION_CHECK105.name] = { index = 105, tooltipText = SCT.LOCALS.OPTION_CHECK105.tooltipText, SCTVar = "SCTD_SHOWRESIST"}
SCT.OPTIONS.FrameCheckButtons [SCT.LOCALS.OPTION_CHECK106.name] = { index = 106, tooltipText = SCT.LOCALS.OPTION_CHECK106.tooltipText, SCTVar = "SCTD_SHOWTARGETS"};
SCT.OPTIONS.FrameCheckButtons [SCT.LOCALS.OPTION_CHECK107.name] = { index = 107, tooltipText = SCT.LOCALS.OPTION_CHECK107.tooltipText, SCTVar = "SCTD_DMGFONT"};
SCT.OPTIONS.FrameCheckButtons [SCT.LOCALS.OPTION_CHECK108.name] = { index = 108, tooltipText = SCT.LOCALS.OPTION_CHECK108.tooltipText, SCTVar = "SCTD_TARGET"};
SCT.OPTIONS.FrameCheckButtons [SCT.LOCALS.OPTION_CHECK109.name] = { index = 109, tooltipText = SCT.LOCALS.OPTION_CHECK109.tooltipText, SCTVar = "SCTD_NAMEPLATES"};
SCT.OPTIONS.FrameCheckButtons [SCT.LOCALS.OPTION_CHECK110.name] = { index = 110, tooltipText = SCT.LOCALS.OPTION_CHECK110.tooltipText, SCTVar = "SCTD_USESCT"};
SCT.OPTIONS.FrameCheckButtons [SCT.LOCALS.OPTION_CHECK111.name] = { index = 111, tooltipText = SCT.LOCALS.OPTION_CHECK111.tooltipText, SCTVar = "SCTD_STICKYCRIT"};
SCT.OPTIONS.FrameCheckButtons [SCT.LOCALS.OPTION_CHECK112.name] = { index = 112, tooltipText = SCT.LOCALS.OPTION_CHECK112.tooltipText, SCTVar = "SCTD_SPELLCOLOR"};
SCT.OPTIONS.FrameCheckButtons [SCT.LOCALS.OPTION_CHECK113.name] = { index = 113, tooltipText = SCT.LOCALS.OPTION_CHECK113.tooltipText, SCTVar = "DIRECTION", SCTTable = SCT.FRAME3};
SCT.OPTIONS.FrameCheckButtons [SCT.LOCALS.OPTION_CHECK114.name] = { index = 114, tooltipText = SCT.LOCALS.OPTION_CHECK114.tooltipText, SCTVar = "SCTD_TRUNCATE"};
SCT.OPTIONS.FrameCheckButtons [SCT.LOCALS.OPTION_CHECK115.name] = { index = 115, tooltipText = SCT.LOCALS.OPTION_CHECK115.tooltipText, SCTVar = "SCTD_CUSTOMEVENTS"};

--Slider options values
SCT.OPTIONS.FrameSliders [SCT.LOCALS.OPTION_SLIDER101.name] = { index = 101, SCTVar = "XOFFSET", minValue = -600, maxValue = 600, valueStep = 10, minText=SCT.LOCALS.OPTION_SLIDER101.minText, maxText=SCT.LOCALS.OPTION_SLIDER101.maxText, tooltipText = SCT.LOCALS.OPTION_SLIDER101.tooltipText, SCTTable = SCT.FRAME3};
SCT.OPTIONS.FrameSliders [SCT.LOCALS.OPTION_SLIDER102.name] = { index = 102, SCTVar = "YOFFSET", minValue = -400, maxValue = 400, valueStep = 10, minText=SCT.LOCALS.OPTION_SLIDER102.minText, maxText=SCT.LOCALS.OPTION_SLIDER102.maxText, tooltipText = SCT.LOCALS.OPTION_SLIDER102.tooltipText, SCTTable = SCT.FRAME3};
SCT.OPTIONS.FrameSliders [SCT.LOCALS.OPTION_SLIDER103.name] = { index = 103, SCTVar = "FADE", minValue = 1, maxValue = 3, valueStep = .5, minText=SCT.LOCALS.OPTION_SLIDER103.minText, maxText=SCT.LOCALS.OPTION_SLIDER103.maxText, tooltipText = SCT.LOCALS.OPTION_SLIDER103.tooltipText, SCTTable = SCT.FRAME3};
SCT.OPTIONS.FrameSliders [SCT.LOCALS.OPTION_SLIDER104.name] = { index = 104, SCTVar = "TEXTSIZE", minValue = 8, maxValue = 36, valueStep = 1, minText=SCT.LOCALS.OPTION_SLIDER104.minText, maxText=SCT.LOCALS.OPTION_SLIDER104.maxText, tooltipText = SCT.LOCALS.OPTION_SLIDER104.tooltipText, SCTTable = SCT.FRAME3};
SCT.OPTIONS.FrameSliders [SCT.LOCALS.OPTION_SLIDER105.name] = { index = 105, SCTVar = "ALPHA", minValue = 10, maxValue = 100, valueStep = 10, minText=SCT.LOCALS.OPTION_SLIDER105.minText, maxText=SCT.LOCALS.OPTION_SLIDER105.maxText, tooltipText = SCT.LOCALS.OPTION_SLIDER105.tooltipText, SCTTable = SCT.FRAME3};
SCT.OPTIONS.FrameSliders [SCT.LOCALS.OPTION_SLIDER106.name] = { index = 106, SCTVar = "GAPDIST", minValue = 0, maxValue = 200, valueStep = 10, minText=SCT.LOCALS.OPTION_SLIDER106.minText, maxText=SCT.LOCALS.OPTION_SLIDER106.maxText, tooltipText = SCT.LOCALS.OPTION_SLIDER106.tooltipText, SCTTable = SCT.FRAME3};
SCT.OPTIONS.FrameSliders [SCT.LOCALS.OPTION_SLIDER107.name] = { index = 107, SCTVar = "SCTD_DMGFILTER", minValue = 0, maxValue = 10000, valueStep = 100, minText=SCT.LOCALS.OPTION_SLIDER107.minText, maxText=SCT.LOCALS.OPTION_SLIDER107.maxText, tooltipText = SCT.LOCALS.OPTION_SLIDER107.tooltipText};

--Selection Boxes
SCT.OPTIONS.FrameSelections [SCT.LOCALS.OPTION_SELECTION101.name] = { index = 101, SCTVar = "FONT", SCTValueSave=1, tooltipText = SCT.LOCALS.OPTION_SELECTION101.tooltipText, table = SCT.LOCALS.OPTION_SELECTION101.table, SCTTable = SCT.FRAME3};
SCT.OPTIONS.FrameSelections [SCT.LOCALS.OPTION_SELECTION102.name] = { index = 102, SCTVar = "FONTSHADOW", tooltipText = SCT.LOCALS.OPTION_SELECTION102.tooltipText, table = SCT.LOCALS.OPTION_SELECTION102.table, SCTTable = SCT.FRAME3};
SCT.OPTIONS.FrameSelections [SCT.LOCALS.OPTION_SELECTION103.name] = { index = 103, SCTVar = "ANITYPE", tooltipText = SCT.LOCALS.OPTION_SELECTION103.tooltipText, table = SCT.LOCALS.OPTION_SELECTION103.table, SCTTable = SCT.FRAME3};
SCT.OPTIONS.FrameSelections [SCT.LOCALS.OPTION_SELECTION104.name] = { index = 104, SCTVar = "ANISIDETYPE", tooltipText = SCT.LOCALS.OPTION_SELECTION104.tooltipText, table = SCT.LOCALS.OPTION_SELECTION104.table, SCTTable = SCT.FRAME3};
SCT.OPTIONS.FrameSelections [SCT.LOCALS.OPTION_SELECTION105.name] = { index = 105, SCTVar = "ALIGN", tooltipText = SCT.LOCALS.OPTION_SELECTION105.tooltipText, table = SCT.LOCALS.OPTION_SELECTION105.table, SCTTable = SCT.FRAME3};
SCT.OPTIONS.FrameSelections [SCT.LOCALS.OPTION_SELECTION106.name] = { index = 106, SCTVar = "ICONSIDE", tooltipText = SCT.LOCALS.OPTION_SELECTION106.tooltipText, table = SCT.LOCALS.OPTION_SELECTION106.table, SCTTable = SCT.FRAME3};

--Other Options
SCT.OPTIONS.FrameMisc [SCT.LOCALS.OPTION_MISC101.name] = {index = 101, tooltipText = SCT.LOCALS.OPTION_MISC101.tooltipText}
--SCT.OPTIONS.FrameMisc [SCT.LOCALS.OPTION_MISC102.name] = {index = 102, tooltipText = SCT.LOCALS.OPTION_MISC102.tooltipText}
SCT.OPTIONS.FrameMisc [SCT.LOCALS.OPTION_MISC103.name] = {index = 103, tooltipText = SCT.LOCALS.OPTION_MISC103.tooltipText}
SCT.OPTIONS.FrameMisc [SCT.LOCALS.OPTION_MISC104.name] = {index = 104, tooltipText = SCT.LOCALS.OPTION_MISC104.tooltipText}
SCT.OPTIONS.FrameMisc [SCT.LOCALS.OPTION_MISC105.name] = {index = 105, tooltipText = SCT.LOCALS.OPTION_MISC105.tooltipText}
SCT.OPTIONS.FrameMisc [SCT.LOCALS.OPTION_MISC106.name] = {index = 106, tooltipText = SCT.LOCALS.OPTION_MISC106.tooltipText}

----------------------
--Set animation Options
function SCTD:SetAnimationOptions(objItem)
	if (objItem:GetChecked()) then
		SCTOptionsFrame_Slider103:Hide();
		SCTOptionsFrame_Slider105:Show();
		UIDropDownMenu_EnableDropDown(SCTOptionsFrame_Selection103);
		UIDropDownMenu_EnableDropDown(SCTOptionsFrame_Selection104);
		BlizzardOptionsPanel_CheckButton_Enable(SCTOptionsFrame_CheckButton113, true, SCTOptionsFrame_CheckButton113:GetChecked());
		BlizzardOptionsPanel_Slider_Enable(SCTOptionsFrame_Slider106Slider);
		SCTOptionsFrame_Slider106EditBox:Show();
	else
		SCTOptionsFrame_Slider105:Hide();
		SCTOptionsFrame_Slider103:Show();
		UIDropDownMenu_DisableDropDown(SCTOptionsFrame_Selection103);
		UIDropDownMenu_DisableDropDown(SCTOptionsFrame_Selection104);
		BlizzardOptionsPanel_CheckButton_Disable(SCTOptionsFrame_CheckButton113);
		BlizzardOptionsPanel_Slider_Disable(SCTOptionsFrame_Slider106Slider);
		SCTOptionsFrame_Slider106EditBox:Hide();
	end
end

----------------------
--change frame tabs
function SCTD:OptionFrameTabClick(item)
	self:ToggleFrameTab(item:GetName(),self.OptionFrames[item:GetName()]);
	PlaySound(PlaySoundKitID and "igCharacterInfoTab" or 841);
end

----------------------
--change frame tabs
function SCTD:ToggleFrameTab(tab, frameName)
	local key, value
	for key, value in pairs(self.OptionFrames) do
		if ( key == tab and value == frameName ) then
			_G[value]:Show();
			_G[key]:LockHighlight();
		else
			_G[value]:Hide();
			_G[key]:UnlockHighlight();
		end
	end
end

function SCTD:MakeBlizzOptions()
  SCTDOptions_EventsFrame.name = "SCTD "..SCT.LOCALS.OPTION_MISC104.name
  SCTDOptions_EventsFrame.parent = "SCTD"
  SCTDOptions_EventsFrame.default = function() SCT:Reset() end
  InterfaceOptions_AddCategory(SCTDOptions_EventsFrame)

  SCTDOptions_DisplayFrame.name = "SCTD "..SCT.LOCALS.OPTION_MISC105.name
  SCTDOptions_DisplayFrame.parent = "SCTD"
  SCTDOptions_DisplayFrame.default = function() SCT:Reset() end
  InterfaceOptions_AddCategory(SCTDOptions_DisplayFrame)

  SCTDOptions_FrameFrame.name = "SCTD "..SCT.LOCALS.OPTION_MISC106.name
  SCTDOptions_FrameFrame.parent = "SCTD"
  SCTDOptions_FrameFrame.default = function() SCT:Reset() end
  InterfaceOptions_AddCategory(SCTDOptions_FrameFrame)
end