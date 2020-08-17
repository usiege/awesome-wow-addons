--[[
  ****************************************************************
	Scrolling Combat Text - Damage

	Author: Grayhoof
	****************************************************************

	Official Site:
		http://grayhoof.wowinterface.com

	****************************************************************]]

--global name
SCTD = LibStub("AceAddon-3.0"):NewAddon("SCTD", "AceEvent-3.0", "AceConsole-3.0", "AceHook-3.0")
local SCTD = SCTD
local SCT = SCT
local db = SCT.db.profile

SCTD.title = "sctd"
SCTD.version = GetAddOnMetadata(SCTD.title, "Version")

--embedded libs
local media = LibStub("LibSharedMedia-3.0")

--Add new frame to SCT
SCT.FRAME3 = 3
SCT.ArrayAniData[SCT.FRAME3] = {}
SCT.ArrayAniCritData[SCT.FRAME3] = {}

local MSG_Y_OFFSET = 0
local menuloaded = false
local arrMsgData = {
		["MSGTEXT1"] = {size=1, xoffset=0, yoffset=0, align="CENTER", height=5, duration=1},
}

--Blizzard APi calls
local UnitName = UnitName
local PlaySound = PlaySound
local GetSpellInfo = GetSpellInfo

--LUA calls
local _G = _G
local pairs = pairs
local tonumber = tonumber
local string_format = string.format

--combat log locals
local CombatLog_Object_IsA = CombatLog_Object_IsA

local COMBATLOG_OBJECT_NONE = COMBATLOG_OBJECT_NONE
local COMBATLOG_FILTER_MINE = COMBATLOG_FILTER_MINE
local COMBATLOG_FILTER_MY_PET = COMBATLOG_FILTER_MY_PET

local COMBAT_EVENTS = {
  ["SWING_DAMAGE"] = "DAMAGE",
  ["RANGE_DAMAGE"] = "DAMAGE",
  ["SPELL_DAMAGE"] = "DAMAGE",
  ["SPELL_PERIODIC_DAMAGE"] = "DAMAGE",
  ["DAMAGE_SHIELD"] = "DAMAGE",
  ["DAMAGE_SPLIT"] = "DAMAGE",
  ["SWING_MISSED"] = "MISS",
  ["RANGE_MISSED"] = "MISS",
  ["SPELL_MISSED"] = "MISS",
  ["SPELL_PERIODIC_MISSED"] = "MISS",
  ["DAMAGE_SHIELD_MISSED"] = "MISS",
  ["SPELL_INTERRUPT"] = "INTERRUPT",
}

local SCHOOL_STRINGS = {
  [SCHOOL_MASK_PHYSICAL] = SPELL_SCHOOL0_CAP,
  [SCHOOL_MASK_HOLY] = SPELL_SCHOOL1_CAP,
  [SCHOOL_MASK_FIRE] = SPELL_SCHOOL2_CAP,
  [SCHOOL_MASK_NATURE] = SPELL_SCHOOL3_CAP,
  [SCHOOL_MASK_FROST] = SPELL_SCHOOL4_CAP,
  [SCHOOL_MASK_SHADOW] = SPELL_SCHOOL5_CAP,
  [SCHOOL_MASK_ARCANE] = SPELL_SCHOOL6_CAP,
}

local POWER_STRINGS = {
	[Enum.PowerType.Mana] = MANA,
	[Enum.PowerType.Rage] = RAGE,
	[Enum.PowerType.Focus] = FOCUS,
	[Enum.PowerType.Energy] = ENERGY,
	[Enum.PowerType.ComboPoints] = COMBO_POINTS,
	[Enum.PowerType.Runes] = RUNES,
	[Enum.PowerType.RunicPower] = RUNIC_POWER,
	[Enum.PowerType.SoulShards] = SOUL_SHARDS,
	[Enum.PowerType.LunarPower] = LUNAR_POWER,
	[Enum.PowerType.HolyPower] = HOLY_POWER,														  
	[Enum.PowerType.Maelstrom] = MAELSTROM_POWER,
	[Enum.PowerType.Chi] = CHI_POWER,
	[Enum.PowerType.Insanity] = INSANITY_POWER,							
	 
	 --[SPELL_POWER_OBSOLETE] = 14;
         --[SPELL_POWER_OBSOLETE2] = 15;							 
	[Enum.PowerType.ArcaneCharges] = ARCANE_CHARGES_POWER,
	[Enum.PowerType.Fury] = FURY,
	[Enum.PowerType.Pain] = PAIN,
}

local default_config = {
		["SCTD_VERSION"] = SCTD.version,
		["SCTD_ENABLED"] = 1,
		["SCTD_SHOWMELEE"] = 1,
		["SCTD_SHOWPERIODIC"] = 1,
		["SCTD_SHOWSPELL"] = 1,
		["SCTD_SHOWPET"] = 1,
		["SCTD_SHOWCOLORCRIT"] = false,
		["SCTD_SHOWDMGSHIELD"] = false,
		["SCTD_FLAGDMG"] = false,
		["SCTD_SHOWDMGTYPE"] = false,
		["SCTD_SHOWSPELLNAME"] = 1,
		["SCTD_SHOWRESIST"] = 1,
		["SCTD_SHOWTARGETS"] = false,
		["SCTD_DMGFONT"] = 1,
		["SCTD_TARGET"] = false,
		["SCTD_USESCT"] = 1,
		["SCTD_STICKYCRIT"] = 1,
		["SCTD_SPELLCOLOR"] = false,
		["SCTD_SHOWINTERRUPT"] = 1,
		["SCTD_NAMEPLATES"] = false,
		["SCTD_TRUNCATE"] = false,
		["SCTD_CUSTOMEVENTS"] = 1,
		["SCTD_DMGFILTER"] = 0,
	}

local default_config_colors = {
		["SCTD_SHOWMELEE"] = {r = 1.0, g = 1.0, b = 1.0},
		["SCTD_SHOWPERIODIC"] = {r = 1.0, g =1.0, b = 0.0},
		["SCTD_SHOWSPELL"] = {r = 1.0, g = 1.0, b = 0.0},
		["SCTD_SHOWPET"] = {r = 0.6, g = 0.6, b = 0.0},
		["SCTD_SHOWCOLORCRIT"] = {r = 0.2, g = 0.4, b = 0.6},
		["SCTD_SHOWINTERRUPT"] = {r = 0.5, g = 0.5, b = 0.7},
		["SCTD_SHOWDMGSHIELD"] = {r = 0.0, g = 0.5, b = 0.5},
}

local default_frame_config = {
		["FONT"] = "Friz Quadrata TT",
		["FONTSHADOW"] = 2,
		["ALPHA"] = 100,
		["ANITYPE"] = 1,
		["ANISIDETYPE"] = 1,
		["XOFFSET"] = 0,
		["YOFFSET"] = 210,
		["DIRECTION"] = false,
		["TEXTSIZE"] = 24,
		["FADE"] = 1.5,
		["GAPDIST"] = 40,
		["ALIGN"] = 2,
		["ICONSIDE"] = 2,
}

local arrShadowOutline = {
	[1] = "",
	[2] = "OUTLINE",
	[3] = "THICKOUTLINE"
}

----------------------
--Called on login
function SCTD:OnEnable()
	--check SCT version
	if (not SCT) or (tonumber(SCT.version) < 6.0) then
		StaticPopupDialogs["SCTD_VERSION"] = {
								  text = SCTD.LOCALS.Version_Warning,
								  button1 = TEXT(OKAY) ,
								  timeout = 0,
								  whileDead = 1,
								  hideOnEscape = 1,
								  showAlert = 1
								}
		StaticPopup_Show("SCTD_VERSION")
		if (SCTOptionsFrame_Misc103) then
			SCTOptionsFrame_Misc103:Hide()
		end
		self:OnDisable()
		return
	end
	self:RegisterSelfEvents()
end

----------------------
-- Disable all events, not using AceDB, but may as well name it right.
function SCTD:OnDisable()
	-- no more events to handle
	--parser:UnregisterAllEvents("sctd")
	self:UnregisterAllEvents()
end

----------------------
--Called when addon loaded
function SCTD:OnInitialize()

	self:RegisterChatCommand("sctd", function() self:ShowSCTDMenu() end)
	self:RegisterChatCommand("sctdmenu", function() self:ShowSCTDMenu() end)

	--register with other mods
	self:RegisterOtherMods()

	--Hook SCT show menu
	self:RawHook(SCT, "ShowMenu")

	--update old values
	self:UpdateValues()

	--setup msgs
	self:MsgInit()

	--setup damage flags
	self:SetDamageFlags()

	--setup Unit name plate tracking
	if (db["SCTD_NAMEPLATES"]) then
		self:EnableNameplate()
	end

end

----------------------
-- Show the Option Menu
function SCTD:ShowSCTDMenu()
	local loaded, message = LoadAddOn("sct_options")
	if (loaded) then
		--if options page exsists (not disabled)
		if (SCTDOptions) then
			--Hook SCT ShowExample
			if (not SCTD:IsHooked(SCT, "ShowExample")) then
				SCTD:RawHook(SCT, "ShowExample")
			end
			--Hook SCT ShowTest
			if (not SCTD:IsHooked(SCT, "ShowTest")) then
				SCTD:RawHook(SCT, "ShowTest")
			end
			if not menuloaded then
        SCTD:MakeBlizzOptions()
        menuloaded = true
      end
			--open sct window
			SCTD.hooks[SCT].ShowMenu()
			--open to SCTD menu
			InterfaceOptionsFrame_OpenToCategory("SCTD "..SCT.LOCALS.OPTION_MISC104.name)
			--mimic clicking the menu
			--SCTOptionsFrame_Misc103:Click()
			--update animation options
			--SCTD:UpdateAnimationOptions()
		else
			PlaySound(PlaySoundKitID and "TellMessage" or 3081)
			SCTD:Print(SCTD.LOCALS.Load_Error)
		end
	else
		PlaySound(PlaySoundKitID and "TellMessage" or 3081)
		SCTD:Print(SCT.LOCALS.Load_Error.." "..message)
	end
end

----------------------
--Reset everything to default for SCTD
function SCTD:ShowMenu()
	SCTD:UpdateValues()
	--open sct menu
	self.hooks[SCT].ShowMenu()
	--Hook SCT ShowExample
	if (not self:IsHooked(SCT, "ShowExample") and SCT.ShowExample) then
		self:RawHook(SCT, "ShowExample")
	end
	--Hook SCTD ShowTest
	if (not self:IsHooked(SCT, "ShowTest") and SCT.ShowTest) then
		self:RawHook(SCT, "ShowTest")
	end
end

----------------------
-- display ddl or chxbox based on type
function SCTD:UpdateAnimationOptions()
	--get scroll down checkbox
	local chkbox = _G["SCTOptionsFrame_CheckButton113"]
	--get anime type dropdown
	local ddl1 = _G["SCTOptionsFrame_Selection103"]
	--get animside type dropdown
	local ddl2 = _G["SCTOptionsFrame_Selection104"]
	--get gap distance silder
	local slide = _G["SCTOptionsFrame_Slider106"]
	--get subframe
	local subframe = _G["SCTDAnimationSubFrame"]
	--get item
	local id = UIDropDownMenu_GetSelectedID(ddl1)
	chkbox:ClearAllPoints()
	chkbox:SetPoint("TOPLEFT", "SCTOptionsFrame_Selection103", "BOTTOMLEFT", 15, 0)
	--reset all scales
	chkbox:SetScale(1)
	ddl2:SetScale(1)
	ddl1:SetScale(1)
	if (id == 1 or id == 6) then
		chkbox:Show()
		ddl2:Hide()
		slide:Hide()
		subframe:SetHeight(80)
	elseif (id == 7 or id == 8) then
		chkbox:ClearAllPoints()
		chkbox:SetPoint("TOPLEFT", "SCTOptionsFrame_Selection103", "BOTTOMLEFT", 15, -40)
		chkbox:Show()
		ddl2:Show()
		slide:Show()
		subframe:SetHeight(165)
	else
		chkbox:Hide()
		ddl2:Show()
		slide:Hide()
		subframe:SetHeight(90)
	end
end

---------------------
--Show SCT Example
function SCTD:ShowExample(frame, item)
	self.hooks[SCT].ShowExample(frame, item)
	self:MsgInit()

	--animated example for options that may need it
	local option = item.SCTVar
	if (option) and (string.find(option,"SCTD_SHOW")) then
		self:DisplayText(option, self.LOCALS.EXAMPLE)
	end

	--show example FRAME3
	--get object
	example = _G["SCTDMsgExample1"]
	--set text size
	SCT:SetFontSize(example,
									db[SCT.FRAMES_DATA_TABLE][SCT.FRAME3]["FONT"],
									db[SCT.FRAMES_DATA_TABLE][SCT.FRAME3]["TEXTSIZE"],
									db[SCT.FRAMES_DATA_TABLE][SCT.FRAME3]["FONTSHADOW"])
	--set the color
	example:SetTextColor(1, 1, 0)
	--set alpha
	example:SetAlpha(db[SCT.FRAMES_DATA_TABLE][SCT.FRAME3]["ALPHA"]/100)
	--Position
	example:SetPoint("CENTER", "UIParent", "CENTER",
									 db[SCT.FRAMES_DATA_TABLE][SCT.FRAME3]["XOFFSET"],
									 db[SCT.FRAMES_DATA_TABLE][SCT.FRAME3]["YOFFSET"])
	--Set the text to display
	example:SetText(self.LOCALS.EXAMPLE)

	--update animation options
	self:UpdateAnimationOptions()
end

---------------------
--Show SCTD Test
function SCTD:ShowTest()
	local color = {r=1,g=1,b=1}
	self.hooks[SCT].ShowTest()
	if (db["SCTD_USESCT"]) then
			SCT:DisplayText(self.LOCALS.EXAMPLE, color, nil, "damage", SCT.FRAME3, nil, nil, "Interface\\Icons\\INV_Misc_QuestionMark")
	else
		self:SetMsgFont(SCTD_MSGTEXT1)
		SCTD_MSGTEXT1:AddMessage(self.LOCALS.EXAMPLE, color.r, color.g, color.b, 1)
	end
end

----------------------
--Update old values for new versions
function SCTD:UpdateValues()
	local i, var
	db = SCT.db.profile
	--set defaults
	for i, _ in pairs(default_config) do
		if(db[i] == nil) then
			db[i] = default_config[i]
		end
	end
	--set colors
	for i,_ in pairs(default_config_colors) do
		var = db[SCT.COLORS_TABLE][i] or default_config_colors[i]
		db[SCT.COLORS_TABLE][i] = var
	end
	--set frame data
	if (not db[SCT.FRAMES_DATA_TABLE][SCT.FRAME3]) then
		db[SCT.FRAMES_DATA_TABLE][SCT.FRAME3] = {}
	end
	for i,_ in pairs(default_frame_config) do
		if (db[SCT.FRAMES_DATA_TABLE][SCT.FRAME3][i] == nil) then
			db[SCT.FRAMES_DATA_TABLE][SCT.FRAME3][i] = default_frame_config[i]
		end
	end
end

----------------------
-- Parses all combat events using combat log events
function SCTD:ParseCombat(larg1, timestamp, event, hideCaster, sourceGUID, sourceName, sourceFlags, sourceFlags2, destGUID, destName, destFlags, destFlags2, ...)

	local etype = COMBAT_EVENTS[event]
  if not etype then return end

  local toPlayer, fromPlayer, toPet, fromPet
  if (sourceName and not CombatLog_Object_IsA(sourceFlags, COMBATLOG_OBJECT_NONE) ) then
    fromPlayer = CombatLog_Object_IsA(sourceFlags, COMBATLOG_FILTER_MINE)
    fromPet = CombatLog_Object_IsA(sourceFlags, COMBATLOG_FILTER_MY_PET)
  end

  --if not from player or pet, then end
  if not fromPlayer and not fromPet then return end

  local healtot, healamt, parent
  local amount, overDamage, school, resisted, blocked, absorbed, critical, glancing, crushing
  local spellId, spellName, spellSchool, missType, powerType, extraAmount, environmentalType, extraSpellId, extraSpellName, extraSpellSchool
  local text, texture, message, inout, color

	------------damage----------------
  if etype == "DAMAGE" then
    if event == "SWING_DAMAGE" then
      amount, overDamage, school, resisted, blocked, absorbed, critical, glancing, crushing = select(1, ...)
    else
      spellId, spellName, spellSchool, amount, overDamage, school, resisted, blocked, absorbed, critical, glancing, crushing = select(1, ...)
      texture = select(3, GetSpellInfo(spellId))
    end
    text = tostring(SCT:ShortenValue(amount))

    if (amount < db["SCTD_DMGFILTER"]) then return end
    if (crushing and db["SHOWGLANCE"]) then text = SCT.LOCALS.Crushchar..text..SCT.LOCALS.Crushchar end
    if (glancing and db["SHOWGLANCE"]) then text = SCT.LOCALS.Glancechar..text..SCT.LOCALS.Glancechar end
    if (blocked) then text = string_format("%s (%d)", text, SCT:ShortenValue(blocked)) end
    if (absorbed) then text = string_format("%s (%d)", text, SCT:ShortenValue(absorbed)) end
    if (event == "SWING_DAMAGE" or event == "RANGE_DAMAGE") and school == SCHOOL_MASK_PHYSICAL  then
      if fromPlayer then
        self:DisplayText("SCTD_SHOWMELEE", text, critical, nil, nil, destName, nil, nil, destFlags, destGUID)
      elseif fromPet then
        self:DisplayText("SCTD_SHOWPET", text, critical, SCHOOL_STRINGS[school], resisted, destName, PET, nil, destFlags, destGUID)
      end
    else
      local etype
      if fromPet then
        etype = "SCTD_SHOWPET"
      elseif event == "SPELL_PERIODIC_DAMAGE" then
        etype = "SCTD_SHOWPERIODIC"
      elseif event == "DAMAGE_SHIELD" then
        etype = "SCTD_SHOWDMGSHIELD"
      else
        etype = "SCTD_SHOWSPELL"
      end
      if school == SCHOOL_MASK_PHYSICAL then school = 0 end
      self:DisplayText(etype, text, critical, SCHOOL_STRINGS[school], resisted, destName, spellName, texture, destFlags, destGUID)
    end

  ------------misses----------------
  elseif etype == "MISS" then
    local etype, miss
    if event == "SWING_MISSED" or event == "RANGE_MISSED" then
      missType = select(1, ...)
      etype = "SCTD_SHOWMELEE"
    else
      spellId, spellName, spellSchool, missType = select(1, ...)
      texture = select(3, GetSpellInfo(spellId))
      etype = "SCTD_SHOWSPELL"
    end
    if fromPet then etype = "SCTD_SHOWPET" end
    miss = _G[missType]
    if miss then
      self:DisplayText(etype, miss, nil, nil, nil, destName, spellName, texture, destFlags, destGUID)
    end
  ------------interrupts----------------
  elseif etype == "INTERRUPT" then
    spellId, spellName, spellSchool, extraSpellId, extraSpellName, extraSpellSchool = select(1, ...)
    texture = select(3, GetSpellInfo(extraSpellId))
    self:DisplayText("SCTD_SHOWINTERRUPT", SCT.LOCALS.Interrupted, nil, nil, nil, destName, extraSpellName, texture, destFlags, destGUID)
	end
end

----------------------
--Display for mainly combat events
--Mainly used for short messages
function SCTD:DisplayText(option, msg1, crit, damagetype, resisted, target, spell, icon, destFlags, destGUID)
	local rbgcolor, showcrit, showmsg, adat, parent
	--if option is on
	if (db[option]) then
		--if show only target
		if (db["SCTD_TARGET"]) then
			if (target ~= UnitName("target")) then
				return
			end
		end
		--get options
		rbgcolor = db[SCT.COLORS_TABLE][option]
		--if damage type
		if ((damagetype) and (db["SCTD_SHOWDMGTYPE"])) then
			msg1 = msg1.." "..damagetype
		end
		--if spell color
		if ((damagetype) and (db["SCTD_SPELLCOLOR"])) then
			rbgcolor = db[SCT.SPELL_COLORS_TABLE][damagetype] or rbgcolor
		end
		--if resisted
		if ((resisted) and (db["SCTD_SHOWRESIST"])) then
			msg1 = string_format("%s {%d}", msg1, resisted)
		end
		--if target label
		if ((target) and (db["SCTD_SHOWTARGETS"])) then
			msg1 = target..": "..msg1
		end
		--if spell
		if ((spell) and (db["SCTD_SHOWSPELLNAME"])) then
			msg1 = msg1.." "..SCTD:ShortenString(spell)..""
		end
		--if flag
		if (db["SCTD_FLAGDMG"]) then
			msg1 = self.LOCALS.SelfFlag..msg1..self.LOCALS.SelfFlag
		end
		--get parent nameplate, if any
		if (db["SCTD_NAMEPLATES"] and destFlags) then
			--parent = SCT:GetNameplate(SCT:CleanName(target, destFlags))
			parent = SCT:GetNameplate(destGUID)
		end
		--if crit
		if (crit) then
			if (db["SCTD_SHOWCOLORCRIT"]) then
				rbgcolor = db[SCT.COLORS_TABLE]["SCTD_SHOWCOLORCRIT"]
			end
			self:Display_Crit_Damage( msg1, rbgcolor, parent, icon )
		else
			self:Display_Damage( msg1, rbgcolor, parent, icon )
		end

	end
end


----------------------
--Displays a message at the top of the screen
function SCTD:Display_Damage(msg, color, parent, icon)
	if (db["SCTD_USESCT"]) then
			SCT:DisplayText(msg, color, nil, "damage", SCT.FRAME3, nil, parent, icon)
	else
		self:SetMsgFont(SCTD_MSGTEXT1)
		SCTD_MSGTEXT1:AddMessage(msg, color.r, color.g, color.b, 1)
	end
end

----------------------
--Displays a message at the top of the screen
function SCTD:Display_Crit_Damage(msg, color, parent, icon)
	if (db["SCTD_STICKYCRIT"]) then
		SCT:DisplayText(msg, color, 1, "damage", SCT.FRAME3, nil, parent, icon)
	elseif (db["SCTD_USESCT"]) then
		SCT:DisplayText("+"..msg.."+", color, nil, "damage", SCT.FRAME3, nil, parent, icon)
	else
		self:SetMsgFont(SCTD_MSGTEXT1)
		SCTD_MSGTEXT1:AddMessage("+"..msg.."+", color.r, color.g, color.b, 1)
	end
end

------------------------
--Setup msg arrays
function SCTD:MsgInit()
	for key, value in pairs(arrMsgData) do
		value.FObject = _G["SCTD_"..key]
		--reset size of allow 5 messages
		value.FObject:SetHeight(db[SCT.FRAMES_DATA_TABLE][SCT.FRAME3]["TEXTSIZE"] * 6)
		--Set Fade Duration
		value.FObject:SetFadeDuration(1)
		--set offset to center
		MSG_Y_OFFSET = value.FObject:GetHeight()/2
		value.FObject:SetPoint("CENTER", "UIParent", "CENTER",
													 db[SCT.FRAMES_DATA_TABLE][SCT.FRAME3]["XOFFSET"],
													 db[SCT.FRAMES_DATA_TABLE][SCT.FRAME3]["YOFFSET"] + MSG_Y_OFFSET)
		value.FObject:SetTimeVisible(db[SCT.FRAMES_DATA_TABLE][SCT.FRAME3]["FADE"] or 1.5)
		--set font
		self:SetMsgFont(value.FObject)
	end
end

------------------------
--Setup Damage Flags based on Options
function SCTD:SetDamageFlags()
	--set WoW Damage Flags
	if (db["SCTD_DMGFONT"]) then
		SetCVar("floatingCombatTextCombatDamage", 0)
	else
		SetCVar("floatingCombatTextCombatDamage", 1)
	end
end

----------------------
--Start Nameplate tracking
function SCTD:EnableNameplate()
	SetCVar("nameplateShowEnemies", 1)
	SCT:EnableNameplate()
end

----------------------
--Stop Nameplate tracking
function SCTD:DisableNameplate()
	SetCVar("nameplateShowEnemies", 0)
	SCT:DisableNameplate()
end

----------------------
--shorten string using SCT settings
function SCTD:ShortenString(strString)
	if (db["SCTD_TRUNCATE"]) then
		return SCT:ShortenString(strString)
	else
		return strString
	end
end

-------------------------
--Set the font of an object using msg vars
function SCTD:SetMsgFont(object)
	--set font
	object:SetFont(media:Fetch("font",db[SCT.FRAMES_DATA_TABLE][SCT.FRAME3]["FONT"]),
								 db[SCT.FRAMES_DATA_TABLE][SCT.FRAME3]["TEXTSIZE"],
								 arrShadowOutline[db[SCT.FRAMES_DATA_TABLE][SCT.FRAME3]["FONTSHADOW"]])
end

----------------------
--Register All Events
function SCTD:RegisterSelfEvents()
  self:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED",function ()
    
self:ParseCombat("COMBAT_LOG_EVENT_UNFILTERED", CombatLogGetCurrentEventInfo())
  end)
end

-------------------------
--Regsiter SCTD with other mods
function SCTD:RegisterOtherMods()
  local frame = CreateFrame("FRAME", nil)
  frame:SetScript("OnShow",function() SCTD:ShowSCTDMenu() end)
  frame.name = "SCTD"

  InterfaceOptions_AddCategory(frame);
end
