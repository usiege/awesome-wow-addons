--[[
  ****************************************************************
  Scrolling Combat Text

  Author: Grayhoof
  ****************************************************************

  Official Site:
    http://grayhoof.wowinterface.com

  ****************************************************************]]
SCT = LibStub("AceAddon-3.0"):NewAddon("SCT", "AceEvent-3.0", "AceTimer-3.0", "AceConsole-3.0", "AceHook-3.0")
local SCT = SCT
local db

SCT.title = "sct"
SCT.version = GetAddOnMetadata(SCT.title, "Version")

--embedded libs
local media = LibStub("LibSharedMedia-3.0")

--Table Constants
SCT.SPELL_COLORS_TABLE = "SPELLCOLORS"
SCT.COLORS_TABLE = "COLORS"
SCT.CRITS_TABLE = "CRITS"
SCT.FRAMES_TABLE = "FRAMES"
SCT.FRAMES_DATA_TABLE = "FRAMESDATA"
SCT.FRAME1 = 1
SCT.FRAME2 = 2
SCT.MSG = 10

-- local constants
local last_hp_percent = 0
local last_hp_target_percent = 0
local last_mana_percent = 0
local last_mana_full = 99999
local menuloaded = false

--Blizzard APi calls
local GetComboPoints = GetComboPoints
local UnitHealth = UnitHealth
local UnitHealthMax = UnitHealthMax
local UnitMana = UnitPower
local UnitManaMax = UnitPowerMax
local UnitName = UnitName
local UnitIsFriend = UnitIsFriend
local UnitIsDead = UnitIsDead
local UnitIsCorpse = UnitIsCorpse
local UnitIsFeignDeath = UnitIsFeignDeath
local UnitGUID = UnitGUID
local PlaySound = PlaySound
local PlaySoundFile = PlaySoundFile
local GetNumRaidMembers = GetNumRaidMembers
local GetNumPartyMembers = GetNumPartyMembers
local GetSpellInfo = GetSpellInfo

--LUA calls
local pairs = pairs
local tonumber = tonumber
local strsub = strsub
local strlen = strlen
local gsub = gsub
local string_match = string.match
local string_format = string.format
local string_find = string.find
local string_split = string.split
local function string_nil(val)
  if val then
    return val
  else
    return UNKNOWN
  end
end

local function shortenValue(value)
  if value >= 10000000 then
    value = string_format("%.1fm", value / 1000000)
  elseif value >= 1000000 then
    value = string_format("%.2fm",value / 1000000)
  elseif value >= 100000 then
    value = string_format("%.0fk",value / 1000)
  elseif value >= 10000 then
    value = string_format("%.1fk",value / 1000)
  end
  return value
end

--combat log locals
local CombatLog_Object_IsA = CombatLog_Object_IsA
local skillmsg = gsub(gsub(gsub(SKILL_RANK_UP, '%d%$', ''), '%%s', '(.+)'), '%%d', '(%%d+)')

local COMBATLOG_OBJECT_NONE = COMBATLOG_OBJECT_NONE
local COMBATLOG_FILTER_MINE = COMBATLOG_FILTER_MINE
local COMBATLOG_FILTER_MY_PET = COMBATLOG_FILTER_MY_PET
local COMBATLOG_FILTER_HOSTILE = bit.bor(
            COMBATLOG_FILTER_HOSTILE_PLAYERS,
            COMBATLOG_FILTER_HOSTILE_UNITS)
local COMBATLOG_FILTER_PLAYER = bit.bor(
            COMBATLOG_OBJECT_AFFILIATION_MASK,
            COMBATLOG_OBJECT_REACTION_MASK,
            COMBATLOG_OBJECT_TYPE_PLAYER,
            COMBATLOG_OBJECT_CONTROL_PLAYER)

local COMBAT_EVENTS = {
  ["SWING_DAMAGE"] = "DAMAGE",
  ["RANGE_DAMAGE"] = "DAMAGE",
  ["SPELL_DAMAGE"] = "DAMAGE",
  ["SPELL_PERIODIC_DAMAGE"] = "DAMAGE",
  ["ENVIRONMENTAL_DAMAGE"] = "DAMAGE",
  ["DAMAGE_SHIELD"] = "DAMAGE",
  ["DAMAGE_SPLIT"] = "DAMAGE",
  ["SPELL_HEAL"] = "HEAL",
  ["SPELL_PERIODIC_HEAL"] = "HEAL",
  ["SWING_MISSED"] = "MISS",
  ["RANGE_MISSED"] = "MISS",
  ["SPELL_MISSED"] = "MISS",
  ["SPELL_PERIODIC_MISSED"] = "MISS",
  ["DAMAGE_SHIELD_MISSED"] = "MISS",
  ["SPELL_DRAIN"] = "DRAIN",
  ["SPELL_LEECH"] = "DRAIN",
  ["SPELL_PERIODIC_DRAIN"] = "DRAIN",
  ["SPELL_PERIODIC_LEECH"] = "DRAIN",
  ["SPELL_ENERGIZE"] = "POWER",
  ["SPELL_PERIODIC_ENERGIZE"] = "POWER",
  ["SPELL_INTERRUPT"] = "INTERRUPT",
  ["PARTY_KILL"] = "DEATH",
  ["UNIT_DIED"] = "DEATH",
  ["UNIT_DESTROYED"] = "DEATH",
  ["SPELL_AURA_APPLIED"] = "BUFF",
  ["SPELL_PERIODIC_AURA_APPLIED"] = "BUFF",
  ["SPELL_AURA_APPLIED_DOSE"] = "BUFF",
  ["SPELL_PERIODIC_AURA_APPLIED_DOSE"] = "BUFF",
  ["SPELL_AURA_REMOVED"] = "FADE",
  ["SPELL_PERIODIC_AURA_REMOVED"] = "FADE",
  ["SPELL_AURA_REMOVED_DOSE"] = "FADE",
  ["SPELL_PERIODIC_AURA_REMOVED_DOSE"] = "FADE",
  ["ENCHANT_APPLIED"] = "ENCHANT_APPLIED",
  ["ENCHANT_REMOVED"] = "ENCHANT_REMOVED",
  ["SPELL_SUMMON"] = "SUMMON",
  ["SPELL_CREATE"] = "SUMMON",
  ["SPELL_DISPEL"] = "DISPEL",
  ["SPELL_STOLEN"] = "DISPEL",
  ["SPELL_CAST_START"] = "CAST",
  ["SPELL_CAST_SUCCESS"] = "CAST",
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

local SHADOW_STRINGS = {
  [1] = "",
  [2] = "OUTLINE",
  [3] = "THICKOUTLINE"
}

local RUNE_STRING = {text = COMBAT_TEXT_RUNE_DEATH, icon = "Interface\\PlayerFrame\\UI-PlayerFrame-Deathknight-SingleRune", color = {r=.75,g=0,b=0}}

----------------------
--Called on login
function SCT:OnEnable()
  self:RegisterSelfEvents()
end

----------------------
-- called on standby
function SCT:OnDisable()
  self:DisableAll()
end

----------------------
-- Disable all events
function SCT:DisableAll()
  -- no more events to handle
  self:UnregisterAllEvents()
end

----------------------
-- Show the Option Menu
function SCT:ShowMenu()
  local loaded, message = LoadAddOn("sct_options")
  if (loaded) then
    PlaySound(PlaySoundKitID and "igMainMenuOpen" or 850)
    if not menuloaded then
      SCT:MakeBlizzOptions()
      menuloaded = true
    else
      SCT:OptionsFrame_OnShow()
    end
    InterfaceOptionsFrame_OpenToCategory("SCT "..SCT.LOCALS.OPTION_MISC21.name)
    InterfaceOptionsFrame_OpenToCategory("SCT "..SCT.LOCALS.OPTION_MISC21.name)
  else
    PlaySound(PlaySoundKitID and "TellMessage" or 3081)
    SCT:Print(SCT.LOCALS.Load_Error.." "..message)
  end
end

----------------------
--Hide the Option Menu
function SCT:HideMenu()
  PlaySound(PlaySoundKitID and "igMainMenuClose" or 851)
  HideUIPanel(SCTOptions)
end

local slashHandler = function(option)
  local self = SCT
  if option == "menu" then
    self:ShowMenu()
  elseif option == "reset" then
    self:Reset()
  else
    self:Print(self.version)
    self:Print("/sct menu")
    self:Print("/sct reset")
    self:Print("/sctdisplay")
  end
end

----------------------
--Called when Addon loaded
function SCT:OnInitialize()

  self.db = LibStub("AceDB-3.0"):New("SCT_CONFIG", self:GetDefaultConfig())
  self.eventdb = LibStub("AceDB-3.0"):New("SCT_EVENT_CONFIG", nil, "Global")

  --local the profile table
  db = self.db.profile

  --set event defaults (not using a AceDB default table because how it handles nil values doesn't work well with custom events)
  if not self.eventdb.global.firstload or self.AlwaysLoadEvents then
    self.eventdb.global.firstload = true
    self.eventdb.global.events = {}
    for k,v in pairs(self.Events) do
      self.eventdb.global.events[k] = v
    end
  end
  self.EventConfig = self.eventdb.global.events

  self:RegisterChatCommand("sct", slashHandler)
  self:RegisterChatCommand("sctmenu", function() self:ShowMenu() end)
  self:RegisterChatCommand("sctdisplay", function(x) self:CmdDisplay(x) end)

  --Shared Media
  for key, value in pairs(SCT.LOCALS.FONTS) do
    media:Register("font", value.name, value.path)
  end

  --register with other mods
  self:RegisterOtherMods()

  --setup animations
  self:AniInit()

  --cache custome events
  self:CacheCustomEvents()

  --set healing flags
  self:SetHealingFlags()

  --setup Unit name plate tracking
  if (db["NAMEPLATES"]) then
    self:EnableNameplate()
  end
end

----------------------
--Hook Function to show event
function SCT:AddMessage(frame, text, r, g, b, id)
    self.hooks[frame].AddMessage(frame, text.." |cff00ff00["..tostring(event).."]|r", r, g, b, id)
end

----------------------
--Reset everything to default
function SCT:Reset()
  self.db:ResetProfile()
  self:AniInit()
  self:HideMenu()
  self:ShowMenu()
  self:ShowExample()
  self:Print(SCT.LOCALS.PROFILE_NEW..self.db:GetCurrentProfile())
end

----------------------
--Get a value from player config
function SCT:Get(option, table)
  if (table) then
    return db[table][option]
  else
    return db[option]
  end
end

----------------------
--Set a value in player config
function SCT:Set(option, value, table)
  if (table) then
    db[table][option] = value
  else
    db[option] = value
  end
end

----------------------
--Display for any partial blocks
function SCT:DisplayBlock(blocked)
  SCT:Display_Event("SHOWBLOCK", string_format("%s (%d)",BLOCK, blocked))
end

----------------------
--Display for any partial absorbs
function SCT:DisplayAbsorb(absorbed)
  SCT:Display_Event("SHOWABSORB", string_format("%s (%d)", ABSORB, absorbed))
end


----------------------
--Player Health
function SCT:UNIT_HEALTH(event, larg1)
  if (larg1 == "player") then
    local warnlevel = db["LOWHP"] / 100
    local HPPercent = UnitHealth("player") / UnitHealthMax("player")
    if (HPPercent < warnlevel) and (last_hp_percent >= warnlevel) and (not UnitIsFeignDeath("player")) then
      if (db["PLAYSOUND"] and db["SHOWLOWHP"]) then
        PlaySound(PlaySoundKitID and "bind2_Impact_Base" or 3961)
      end
      self:Display_Event("SHOWLOWHP", string_format("%s (%d)", SCT.LOCALS.LowHP, UnitHealth("player")))
    end
    last_hp_percent = HPPercent
    return
  end
end

----------------------
--Player Runes
function SCT:RUNE_POWER_UPDATE(event, rune)
  if db["SHOWRUNES"] then
    local usable = select(3,GetRuneCooldown(rune))
    local crit = db[self.CRITS_TABLE]["SHOWRUNES"]
    local showmsg = db[self.FRAMES_TABLE]["SHOWRUNES"] or 1
    if usable and (not UnitIsDead("player")) then
      if (showmsg == SCT.MSG) then
        self:DisplayMessage(RUNE_STRING.text, RUNE_STRING.color, RUNE_STRING.icon)
      else
        self:DisplayCustomEvent(RUNE_STRING.text, RUNE_STRING.color, crit, showmsg, nil, RUNE_STRING.icon)
      end
    end
  end
end

----------------------
--Player Mana
function SCT:UNIT_POWER(event, larg1)
  if (larg1 == "player") and (UnitPowerType("player") == 0)then
    local warnlevel = db["LOWMANA"] / 100
    local ManaPercent = UnitMana("player") / UnitManaMax("player")
    if (ManaPercent < warnlevel) and (last_mana_percent >= warnlevel) and (not UnitIsFeignDeath("player")) then
      if (db["PLAYSOUND"] and db["SHOWLOWMANA"]) then
        PlaySound(PlaySoundKitID and "ShaysBell" or 6555)
      end
      SCT:Display_Event("SHOWLOWMANA", string_format("%s (%d)", SCT.LOCALS.LowMana, UnitMana("player")))
    end
    last_mana_percent = ManaPercent
  end
  if (larg1 == "player") and (db["SHOWALLPOWER"]) then
    local ManaFull = UnitPower("player")
    if (ManaFull > last_mana_full) then
      self:Display_Event("SHOWPOWER", string_format("+%d %s", ManaFull-last_mana_full, string_nil(POWER_STRINGS[UnitPowerType("player")])))
    end
    last_mana_full = ManaFull
  end
end

----------------------
--Player target change
function SCT:PLAYER_TARGET_CHANGED(event)
  if (not UnitIsFriend("target", "player") and (UnitIsDead("target")~=true) and (UnitIsCorpse("target")~=true)) then
    last_hp_target_percent = UnitHealth("target")
  else
    last_hp_target_percent = 100
  end
end

----------------------
--Power Change
function SCT:UNIT_DISPLAYPOWER(event)
  last_mana_full = UnitPower("player")
end

----------------------
--Player Combat
function SCT:PLAYER_REGEN_DISABLED(event)
  self:Display_Event("SHOWCOMBAT", SCT.LOCALS.Combat)
end

----------------------
--Player NoCombat
function SCT:PLAYER_REGEN_ENABLED(event)
  self:Display_Event("SHOWCOMBAT", SCT.LOCALS.NoCombat)
end

----------------------
--Unit Combo Points
function SCT:UNIT_COMBO_POINTS(event, larg1)
  if (larg1 == "player") then
    local sct_CP = GetComboPoints('player')
    if (sct_CP ~= 0) then
      local sct_CP_Message = string_format("%d %s", sct_CP, SCT.LOCALS.ComboPoint)
      if (sct_CP == 5) then
        sct_CP_Message = sct_CP_Message.." "..SCT.LOCALS.FiveCPMessage
      end
      self:Display_Event("SHOWCOMBOPOINTS", sct_CP_Message)
    end
  end
end

----------------------
-- Skill Gains
function SCT:CHAT_MSG_SKILL(event, larg1)
  local skill, rank = string_match(larg1, skillmsg)
  if skill then
    self:Display_Event("SHOWSKILL", string_format("%s: %d", skill, rank))
  end
end

----------------------
-- Displays Parsed info based on type
function SCT:ParseCombat(larg1, timestamp, event, hideCaster, sourceGUID, sourceName, sourceFlags, sourceFlags2, destGUID, destName, destFlags, destFlags2, ...)
  local etype = COMBAT_EVENTS[event]
  if not etype then return end

  --custom search first
  if (db["CUSTOMEVENTS"]) and (self:CustomCombatEventSearch(etype, event, sourceName, sourceFlags, destName, destFlags, ...) == true) then
    return
  end

  --check for reflect damage
  if self.ReflectTarget and self.ReflectSkill and event == "SPELL_DAMAGE" and sourceName == destName and CombatLog_Object_IsA(destFlags, COMBATLOG_FILTER_HOSTILE) then
    self:ParseReflect(timestamp, event, sourceGUID, sourceName, sourceFlags, destGUID, destName, destFlags, ...)
    return
  end

  local toPlayer, fromPlayer, toPet, fromPet
  if (sourceName and not CombatLog_Object_IsA(sourceFlags, COMBATLOG_OBJECT_NONE) ) then
    fromPlayer = CombatLog_Object_IsA(sourceFlags, COMBATLOG_FILTER_MINE)
    fromPet = CombatLog_Object_IsA(sourceFlags, COMBATLOG_FILTER_MY_PET)
  end
  if (destName and not CombatLog_Object_IsA(destFlags, COMBATLOG_OBJECT_NONE) ) then
    toPlayer = CombatLog_Object_IsA(destFlags, COMBATLOG_FILTER_MINE)
    toPet = CombatLog_Object_IsA(destFlags, COMBATLOG_FILTER_MY_PET)
  end

  --if it was only a custom event, then end
  if not fromPlayer and not toPlayer and not fromPet and not toPet then return end

  local healtot, healamt, parent
  local amount, overDamage, school, resisted, blocked, absorbed, critical, glancing, crushing
  local spellId, spellName, spellSchool, missType, powerType, extraAmount, environmentalType, extraSpellId, extraSpellName, extraSpellSchool, auraType, overHeal
  local text, texture, message, inout, color

  ------------damage----------------
  if etype == "DAMAGE" then
    if event == "SWING_DAMAGE" then
      amount, overDamage, school, resisted, blocked, absorbed, critical, glancing, crushing = select(1, ...)
    elseif event == "ENVIRONMENTAL_DAMAGE" then
      environmentalType, amount, overDamage, school, resisted, blocked, absorbed, critical, glancing, crushing = select(1, ...)
    else
      spellId, spellName, spellSchool, amount, overDamage, school, resisted, blocked, absorbed, critical, glancing, crushing = select(1, ...)
      texture = select(3, GetSpellInfo(spellId))
    end
    text = tostring(self:ShortenValue(amount))

    if toPlayer then
      if (amount < db["DMGFILTER"]) then return end
      if (crushing and db["SHOWGLANCE"]) then text = self.LOCALS.Crushchar..text..self.LOCALS.Crushchar end
      if (glancing and db["SHOWGLANCE"]) then text = self.LOCALS.Glancechar..text..self.LOCALS.Glancechar end
      if (absorbed) then self:DisplayAbsorb(absorbed) end
      if (blocked) then self:DisplayBlock(blocked) end
      if event == "SWING_DAMAGE" or event == "RANGE_DAMAGE" then
        self:Display_Event("SHOWHIT", "-"..text, critical)
      else
        self:Display_Event("SHOWSPELL", "-"..text, critical, SCHOOL_STRINGS[school], resisted, nil, nil, nil, spellName, texture)
      end
    end
  ------------buff/debuff gain----------------
  elseif etype == "BUFF" then
    spellId, spellName, spellSchool, auraType, amount = select(1, ...)
    texture = select(3, GetSpellInfo(spellId))
    if toPlayer then
      if amount and amount > 1 then
        self:Display_Event("SHOW"..auraType, string_format("[%s %d]", self:ShortenString(spellName), amount), nil, nil, nil, nil, nil, nil, nil, texture)
      else
        self:Display_Event("SHOW"..auraType, ""..self:ShortenString(spellName).."", nil, nil, nil, nil, nil, nil, nil, texture)
      end
    end
  ------------buff/debuff lose----------------
  elseif etype == "FADE" then
    spellId, spellName, spellSchool, auraType, amount = select(1, ...)
    texture = select(3, GetSpellInfo(spellId))
    if toPlayer then
      if db["SHOWFADE"] then
        self:Display_Event("SHOWFADE", "-"..self:ShortenString(spellName).."", nil, nil, nil, nil, nil, nil, nil, texture)
      end
    end
  ------------heals----------------
  elseif etype == "HEAL" then
    spellId, spellName, spellSchool, amount, overHeal, absorbed, critical = select(1, ...)
    text = amount
    texture = select(3, GetSpellInfo(spellId))

    healtot = tostring(self:ShortenValue(amount))
    --heal filter
    if (amount < db["HEALFILTER"]) then return end

    if toPlayer then
      --self heals
      if toPlayer and fromPlayer then
        if (db["SHOWOVERHEAL"]) and overHeal > 0 then healtot = string_format("%d {%d}", amount-overHeal, overHeal) end
        self:Display_Event("SHOWHEAL", "+"..healtot, critical, nil, nil, self:ShortenString(spellName), nil, nil, nil, texture)
      --incoming heals
      else
        self:Display_Event("SHOWHEAL", "+"..healtot, critical, nil, nil, sourceName, nil, nil, spellName, texture)
      end
    --outgoing heals
    elseif fromPlayer then
      if event == "SPELL_PERIODIC_HEAL" and (not db["SHOWHOTS"]) then return end
      if (db["SHOWOVERHEAL"]) and overHeal > 0 then healtot = string_format("%s {%s}", tostring(self:ShortenValue(amount-overHeal)), tostring(self:ShortenValue(overHeal))) end
      local healtext = destName..": +"..healtot
      if (db["NAMEPLATES"]) then parent = self:GetNameplate(destGUID) end
      if parent then healtext = "+"..healtot end
      self:Display_Event("SHOWSELFHEAL", healtext, critical, nil, nil, nil, nil, parent, spellName, texture)
    end
  ------------misses----------------
  elseif etype == "MISS" then
    if event == "SWING_MISSED" or event == "RANGE_MISSED" then
      missType = select(1, ...)
    else
      spellId, spellName, spellSchool, missType = select(1, ...)
      texture = select(3, GetSpellInfo(spellId))
    end
    text = _G[missType]

    if toPlayer then
      if (missType == "REFLECT") then
        self:Display_Event("SHOWABSORB", text.." ("..spellName..")", nil, nil, nil, nil, text.." ("..spellName..")", nil, spellName, texture)
        self:SetReflect(sourceName, spellName)
      elseif (missType == "ABSORB" or missType == "DEFLECT" or missType == "IMMUNE" or missType == "EVADE") then
        self:Display_Event("SHOWABSORB", text, nil, nil, nil, nil, text, nil, spellName, texture)
      elseif missType then
        self:Display_Event("SHOW"..missType, text, nil, nil, nil, nil, text, nil, spellName, texture)
      end
    end
  ------------leech and drains----------------
  elseif etype == "DRAIN" then
    spellId, spellName, spellSchool, amount, powerType, extraAmount = select(1, ...)
    texture = select(3, GetSpellInfo(spellId))
    if toPlayer then
      self:Display_Event("SHOWPOWER", string_format("-%d %s", amount, string_nil(POWER_STRINGS[powerType])), nil, nil, nil, nil, nil, nil, spellName, texture)
    elseif fromPlayer and extraAmount and (not db["SHOWALLPOWER"]) then
      if (extraAmount < db["MANAFILTER"]) then return end
      self:Display_Event("SHOWPOWER", string_format("+%d %s", extraAmount, string_nil(POWER_STRINGS[powerType])), nil, nil, nil, nil, nil, nil, spellName, texture)
    elseif fromPlayer then
      return
      --for showing your drain damage
      --self:Display_Event("SHOWSPELL", string_format("%d %s", extraAmount, string_nil(POWER_STRINGS[powerType])), nil, nil, nil, nil, nil, nil, spellName, texture)
    end
  ------------power gains----------------
  elseif etype == "POWER" then
    spellId, spellName, spellSchool, amount, powerType = select(1, ...)
    texture = select(3, GetSpellInfo(spellId))
    if (amount < db["MANAFILTER"]) then return end
    if toPlayer and (not db["SHOWALLPOWER"]) then
      self:Display_Event("SHOWPOWER", string_format("+%d %s", amount, string_nil(POWER_STRINGS[powerType])), nil, nil, nil, nil, nil, nil, spellName, texture)
    end
  ------------interrupts----------------
  elseif etype == "INTERRUPT" then
    spellId, spellName, spellSchool, extraSpellId, extraSpellName, extraSpellSchool = select(1, ...)
    texture = select(3, GetSpellInfo(extraSpellId))
    if toPlayer then
      self:Display_Event("SHOWINTERRUPT", self.LOCALS.Interrupted, nil, nil, nil, nil, nil, nil, extraSpellName, texture)
    end
  ------------dispels----------------
  elseif etype == "DISPEL" then
    spellId, spellName, spellSchool, extraSpellId, extraSpellName, extraSpellSchool, auraType = select(1, ...)
    texture = select(3, GetSpellInfo(extraSpellId))
    if fromPlayer then
      self:Display_Event("SHOWDISPEL", self.LOCALS.Dispel, nil, nil, nil, nil, nil, nil, extraSpellName, texture)
    end
  ------------deaths----------------
  elseif etype == "DEATH" then
    if fromPlayer then
      self:Display_Event("SHOWKILLBLOW", self.LOCALS.KillingBlow)
    end
  ------------enchants----------------
  elseif etype == "ENCHANT_APPLIED" then
    spellName = select(1, ...)
    self:Display_Event("SHOWBUFF", "["..self:ShortenString(spellName).."]", nil, nil, nil, nil, nil, nil, nil, texture)
  elseif etype == "ENCHANT_REMOVED" then
    if db["SHOWFADE"] then
      spellName = select(1, ...)
      self:Display_Event("SHOWBUFF", "-["..self:ShortenString(spellName).."]", nil, nil, nil, nil, nil, nil, nil, texture)
    end
  -------------anything else-------------
  end
end

----------------------
--Handle Blizzard events
function SCT:COMBAT_TEXT_UPDATE(event, larg1)
local larg2, larg3 = GetCurrentCombatTextEventInfo()
  --Normal Events
  if (larg1=="SPELL_ACTIVE") then
    --check for redundant display info
    if not self:CheckSkill(larg2.."!")  then
      local texture = select(3, GetSpellInfo(larg2))
      self:Display_Event("SHOWEXECUTE", larg2.."!", nil, nil, nil, nil, nil, nil, nil, texture)
    end
  elseif (larg1=="FACTION") then
    local sign = "+"
    if (tonumber(larg3) < 0) then sign = "" end
    self:Display_Event("SHOWREP", string_format("%s%d %s (%s)", sign, larg3, REPUTATION, larg2))
  elseif (larg1=="HONOR_GAINED") then
    self:Display_Event("SHOWHONOR", string_format("+%d %s", larg2, HONOR))
  elseif (larg1=="EXTRA_ATTACKS") then
    if ( tonumber(larg2) > 1 ) then
      self:Display_Event("SHOWEXECUTE", string_format("%s (%d)", self.LOCALS.ExtraAttack, larg2))
    else
      self:Display_Event("SHOWEXECUTE", self.LOCALS.ExtraAttack)
    end
  end
end

-------------------------
--Set last reflection
function SCT:ParseReflect(timestamp, event, sourceGUID, sourceName, sourceFlags, destGUID, destName, destFlags, ...)
  local spellId, spellName, spellSchool, amount, school, resisted, blocked, absorbed, critical, glancing, crushing = select(1, ...)
  local texture = select(3, GetSpellInfo(spellId))
  --reflected events
  if (self.ReflectTarget == sourceName and sourceName == destName and self.ReflectSkill == spellName) then
    local parent
    if (db["NAMEPLATES"]) then parent = self:GetNameplate(destGUID) end
    if SCTD then
      SCTD:DisplayText("SCTD_SHOWSPELL", string_format("%s: %d", REFLECT, self:ShortenValue(amount)), critical, SCHOOL_STRINGS[school], resisted, destName, spellName, texture, destFlags)
    else
      self:Display_Event("SHOWABSORB", string_format("%s: %d (%s)", spellName, self:ShortenValue(amount), REFLECT), critical,nil,nil,nil,nil,parent,nil,texture)
    end
    self:ClearReflect()
  end
end

-------------------------
--Set last reflection
function SCT:SetReflect(target, skill)
  self.ReflectTarget = target
  self.ReflectSkill = skill
  --clear reflection after 3 seconds.
  self:ScheduleTimer(self.ClearReflect, 3, self)
end

-------------------------
--Clear last reflection
function SCT:ClearReflect()
  self.ReflectTarget = nil
  self.ReflectSkill = nil
end

-------------------------
--Clean server name from players names
function SCT:CleanName(name, destFlags)
  if (CombatLog_Object_IsA(destFlags, COMBATLOG_FILTER_PLAYER)) then
    local rname = select(1, string_split("-", name))
    return rname
  end
  return name
end

----------------------
--Display for mainly combat events
--Mainly used for short messages
function SCT:Display_Event(option, msg1, crit, damagetype, resisted, target, msg2, parent, skill, icon)
  local rbgcolor, showcrit, showmsg, event
  --if option is on
  if (db[option]) then
    --get options
    rbgcolor = db[self.COLORS_TABLE][option]
    showcrit = db[self.CRITS_TABLE][option]
    showmsg = db[self.FRAMES_TABLE][option] or 1
    --if skill name
    if ((skill) and (db["SKILLNAME"])) then
      msg1 = msg1.." ("..self:ShortenString(skill)..")"
    end
    --if damage type
    if ((damagetype) and (db["SPELLTYPE"])) then
      msg1 = msg1.." <"..damagetype..">"
    end
    --if spell color
    if ((damagetype) and (db["SPELLCOLOR"])) then
      rbgcolor = db[self.SPELL_COLORS_TABLE][damagetype] or rbgcolor
    end
    --if resisted
    if ((resisted) and (db["SHOWRESIST"])) then
      msg1 = string_format("%s (%d %s)", msg1, resisted, ERR_FEIGN_DEATH_RESISTED)
    end
    --if target label
    if ((target) and (db["SHOWTARGETS"])) then
      msg1 = msg1.." "..target..""
    end
    --If they want to tag all self events
    if (db["SHOWSELF"]) then
      msg1 = SCT.LOCALS.SelfFlag..msg1..SCT.LOCALS.SelfFlag
    end
    --if messages
    if (showmsg == SCT.MSG) then
      --if 2nd msg
      if (msg2) then msg1 = msg2 end
      --display message
      self:DisplayMessage( msg1, rbgcolor, icon )
    else
      event = "event"
      --set event type
      if (option == "SHOWHIT" or option == "SHOWSPELL" or option == "SHOWHEAL" or option == "SHOWSELFHEAL") then
        event = "damage"
      end
      --see if crit override
      if (showcrit) then crit = 1 end
      --display
      self:DisplayText(msg1, rbgcolor, crit, event, showmsg, nil, parent, icon)
    end
  end
end

----------------------
--Displays a message at the top of the screen
function SCT:DisplayMessage(msg, color, icon)
    self:SetMsgFont(SCT_MSG_FRAME)
    if icon and db["ICON"] then msg = "|T"..icon..":"..(db[self.FRAMES_DATA_TABLE][SCT.MSG]["MSGSIZE"]).."|t"..msg end
    SCT_MSG_FRAME:AddMessage(msg, color.r, color.g, color.b, 1)
end

----------------------
--Display text from a command line
function SCT:CmdDisplay(msg)
  local message = nil
  local colors = nil
  --If there are not parameters, display useage
  if strlen(msg) == 0 then
    self:Print(SCT.LOCALS.DISPLAY_USEAGE)
  --Get message anf colors if quotes used
  elseif strsub(msg,1,1) == "'" then
    local location = string_find(strsub(msg,2),"'")
    if location and (location>1) then
      message = strsub(msg,2,location)
      colors = strsub(msg,location+1)
    end
  --Get message anf colors if single word used
  else
    local idx = string_find(msg," ")
    if (idx) then
      message = strsub(msg,1,idx-1)
      colors = strsub(msg,idx+1)
    else
      message = msg
    end
  end
  --if they sent colors, grab them
  local firsti, lasti, red, green, blue = nil
  if (colors ~= nil) then
    firsti, lasti, red, green, blue = string_find (colors, "(%w+) (%w+) (%w+)")
  end
  local color = {r = 1.0, g = 1.0, b = 1.0}
  --if they sent 3 colors use them, else use default white
  if (red) and (green) and (blue) then
    color.r,color.g,color.b = (tonumber(red)/10),(tonumber(green)/10),(tonumber(blue)/10)
  end
  self:DisplayText(message, color, nil, "event", 1)
end

-------------------------
--Set the font of an object using msg vars
function SCT:SetMsgFont(object)
  --set font
  object:SetFont(media:Fetch("font", db[self.FRAMES_DATA_TABLE][SCT.MSG]["MSGFONT"]),
                 db[self.FRAMES_DATA_TABLE][SCT.MSG]["MSGSIZE"],
                 SHADOW_STRINGS[db[self.FRAMES_DATA_TABLE][SCT.MSG]["MSGFONTSHADOW"]])
end

-------------------------
--Set the font of the built in damage font
function SCT:SetDmgFont()
  if (SCT.db.profile["DMGFONT"]) then
    DAMAGE_TEXT_FONT = media:Fetch("font",SCT.db.profile[SCT.FRAMES_DATA_TABLE][SCT.FRAME1]["FONT"])
  end
end

-------------------------
--Set the font of an object
function SCT:SetFontSize(object, font, textsize, fontshadow)
  object:SetFont(media:Fetch("font",font), textsize, SHADOW_STRINGS[fontshadow])
end

-------------------------
--Regsiter SCT with other mods
function SCT:RegisterOtherMods()
  local frame = CreateFrame("FRAME", nil)
  frame:SetScript("OnShow",function() SCT:ShowMenu() end)
  frame.name = "SCT"

  InterfaceOptions_AddCategory(frame)
  InterfaceOptionsFrame:SetMovable(true)
end

-------------------------
--Get the default Config
function SCT:GetDefaultConfig()
  local default = {
    profile = {
      ["VERSION"] = SCT.version,
      ["ENABLED"] = true,
      ["SHOWHIT"] = 1,
      ["SHOWMISS"] = 1,
      ["SHOWDODGE"] = 1,
      ["SHOWPARRY"] = 1,
      ["SHOWBLOCK"] = 1,
      ["SHOWSPELL"] = 1,
      ["SHOWHEAL"] = 1,
      ["SHOWRESIST"] = 1,
      ["SHOWDEBUFF"] = 1,
      ["SHOWBUFF"] = 1,
      ["SHOWFADE"] = false,
      ["SHOWABSORB"] = 1,
      ["SHOWLOWHP"] = 1,
      ["SHOWLOWMANA"] = 1,
      ["SHOWPOWER"] = 1,
      ["SHOWCOMBAT"] = false,
      ["SHOWCOMBOPOINTS"] = false,
      ["SHOWHONOR"] = 1,
      ["SHOWEXECUTE"] = 1,
      ["SHOWREP"] = 1,
      ["SHOWSELFHEAL"] = 1,
      ["SHOWSKILL"] = 1,
      ["SHOWTARGETS"] = 1,
      ["SHOWSELF"] = false,
      ["SHOWGLANCE"] = 1,
      ["SHOWOVERHEAL"] = 1,
      ["SHOWHOTS"] = false,
      ["SHOWKILLBLOW"] = 1,
      ["SHOWINTERRUPT"] = 1,
      ["SHOWDISPEL"] = 1,
      ["SHOWRUNES"] = 1,
      ["STICKYCRIT"] = 1,
      ["FLASHCRIT"] = 1,
      ["SKILLNAME"] = false,
      ["SPELLTYPE"] = false,
      ["SPELLCOLOR"] = false,
      ["DMGFONT"] = false,
      ["SHOWALLPOWER"] = false,
      ["FPSMODE"] = false,
      ["ANIMATIONSPEED"] = 15,
      ["MOVEMENT"] = 2,
      ["LOWHP"] = 40,
      ["LOWMANA"] = 40,
      ["HEALFILTER"] = 0,
      ["MANAFILTER"] = 0,
      ["DMGFILTER"] = 0,
      ["PLAYSOUND"] = 1,
      ["CUSTOMEVENTS"] = 1,
      ["NAMEPLATES"] = false,
      ["TRUNCATETYPE"] = 1,
      ["TRUNCATESIZE"] = 30,
      ["WOWHEAL"] = 1,
      ["ICON"] = 1,
      ["SHORTAMOUNT"] = 1,
      [SCT.FRAMES_DATA_TABLE] = {
        [SCT.FRAME1] = {
          ["FONT"] = "Friz Quadrata TT",
          ["FONTSHADOW"] = 2,
          ["ALPHA"] = 100,
          ["ANITYPE"] = 1,
          ["ANISIDETYPE"] = 1,
          ["XOFFSET"] = 0,
          ["YOFFSET"] = 0,
          ["DIRECTION"] = false,
          ["TEXTSIZE"] = 24,
          ["GAPDIST"] = 40,
          ["ALIGN"] = 2,
          ["ICONSIDE"] = 2,
        },
        [SCT.FRAME2] = {
          ["FONT"] = "Friz Quadrata TT",
          ["FONTSHADOW"] = 2,
          ["ALPHA"] = 100,
          ["ANITYPE"] = 1,
          ["ANISIDETYPE"] = 1,
          ["XOFFSET"] = 0,
          ["YOFFSET"] = -150,
          ["DIRECTION"] = true,
          ["TEXTSIZE"] = 24,
          ["GAPDIST"] = 40,
          ["ALIGN"] = 2,
          ["ICONSIDE"] = 2,
        },
        [SCT.MSG] = {
          ["MSGFADE"] = 1.5,
          ["MSGFONT"] = "Friz Quadrata TT",
          ["MSGFONTSHADOW"] = 2,
          ["MSGSIZE"] = 24,
          ["MSGYOFFSET"] = -280,
          ["MSGXOFFSET"] = 0,
        }
      },
      [SCT.COLORS_TABLE] = {
        ["SHOWHIT"] =  {r = 1.0, g = 0.0, b = 0.0},
        ["SHOWMISS"] =  {r = 0.0, g = 0.0, b = 1.0},
        ["SHOWDODGE"] =  {r = 0.0, g = 0.0, b = 1.0},
        ["SHOWPARRY"] =  {r = 0.0, g = 0.0, b = 1.0},
        ["SHOWBLOCK"] =  {r = 0.0, g = 0.0, b = 1.0},
        ["SHOWSPELL"] =  {r = 0.5, g = 0.0, b = 0.5},
        ["SHOWHEAL"] =  {r = 0.0, g = 1.0, b = 0.0},
        ["SHOWRESIST"] =  {r = 0.5, g = 0.0, b = 0.5},
        ["SHOWDEBUFF"] =  {r = 0.0, g = 0.5, b = 0.5},
        ["SHOWABSORB"] =  {r = 1.0, g = 1.0, b = 0.0},
        ["SHOWLOWHP"] =  {r = 1.0, g = 0.5, b = 0.5},
        ["SHOWLOWMANA"] =  {r = 0.5, g = 0.5, b = 1.0},
        ["SHOWPOWER"] =  {r = 1.0, g = 1.0, b = 0.0},
        ["SHOWCOMBAT"] =  {r = 1.0, g = 1.0, b = 1.0},
        ["SHOWCOMBOPOINTS"] =  {r = 1.0, g = 0.5, b = 0.0},
        ["SHOWHONOR"] =  {r = 0.5, g = 0.5, b = 0.7},
        ["SHOWBUFF"] =  {r = 0.7, g = 0.7, b = 0.0},
        ["SHOWFADE"] =  {r = 0.7, g = 0.7, b = 0.0},
        ["SHOWEXECUTE"] =  {r = 0.7, g = 0.7, b = 0.7},
        ["SHOWREP"] =  {r = 0.5, g = 0.5, b = 1},
        ["SHOWSELFHEAL"] = {r = 0, g = 0.7, b = 0},
        ["SHOWSKILL"] = {r = 0, g = 0, b = 0.7},
        ["SHOWKILLBLOW"] = {r = 0.7, g = 0.1, b = 0.1},
        ["SHOWINTERRUPT"] = {r = 0.3, g = 0.3, b = 0.5},
        ["SHOWDISPEL"] = {r = 0.8, g = 0.8, b = 1},
        ["SHOWRUNES"] = {r = 0, g = 1, b = 1}, -- not used
      },
      [SCT.SPELL_COLORS_TABLE] = {
        [SPELL_SCHOOL0_CAP] = {r=1,g=0,b=0},
        [SPELL_SCHOOL1_CAP] = {r=1,g=1,b=0},
        [SPELL_SCHOOL2_CAP] = {r=1,g=.3,b=0},
        [SPELL_SCHOOL3_CAP] = {r=.5,g=1,b=.2},
        [SPELL_SCHOOL4_CAP] = {r=.4,g=.6,b=.9},
        [SPELL_SCHOOL5_CAP] = {r=.4,g=.4,b=.5},
        [SPELL_SCHOOL6_CAP] = {r=.8,g=.8,b=1},
      },
      [SCT.CRITS_TABLE] = {
        ["SHOWEXECUTE"] = 1,
        ["SHOWLOWHP"] = 1,
        ["SHOWLOWMANA"] = 1,
        ["SHOWKILLBLOW"] = 1,
        ["SHOWINTERRUPT"] = 1,
        ["SHOWRUNES"] = 1,
      },
      [SCT.FRAMES_TABLE] = {
        ["SHOWHIT"] = SCT.FRAME1,
        ["SHOWMISS"] = SCT.FRAME1,
        ["SHOWDODGE"] = SCT.FRAME1,
        ["SHOWPARRY"] = SCT.FRAME1,
        ["SHOWBLOCK"] = SCT.FRAME1,
        ["SHOWSPELL"] = SCT.FRAME1,
        ["SHOWHEAL"] = SCT.FRAME2,
        ["SHOWRESIST"] = SCT.FRAME1,
        ["SHOWDEBUFF"] = SCT.FRAME1,
        ["SHOWABSORB"] = SCT.FRAME1,
        ["SHOWLOWHP"] = SCT.FRAME1,
        ["SHOWLOWMANA"] = SCT.FRAME1,
        ["SHOWPOWER"] = SCT.FRAME2,
        ["SHOWCOMBAT"] = SCT.FRAME2,
        ["SHOWCOMBOPOINTS"] = SCT.FRAME1,
        ["SHOWHONOR"] = SCT.MSG,
        ["SHOWBUFF"] = SCT.MSG,
        ["SHOWFADE"] = SCT.FRAME1,
        ["SHOWEXECUTE"] = SCT.FRAME1,
        ["SHOWREP"] = SCT.MSG,
        ["SHOWSELFHEAL"] = SCT.FRAME2,
        ["SHOWSKILL"] = SCT.FRAME2,
        ["SHOWKILLBLOW"] = SCT.FRAME1,
        ["SHOWINTERRUPT"] = SCT.FRAME1,
        ["SHOWDISPEL"] = SCT.FRAME2,
        ["SHOWRUNES"] = SCT.FRAME1,
      }
    }
  }
  return default
end

-------------------------
--Regsiter SCT with all events
function SCT:RegisterSelfEvents()

  -- Register Main Events
  self:RegisterEvent("UNIT_HEALTH")
   self:RegisterEvent("UNIT_POWER_UPDATE", function ()
    
  end)
  self:RegisterEvent("UNIT_DISPLAYPOWER")
  self:RegisterEvent("RUNE_POWER_UPDATE");
  self:RegisterEvent("PLAYER_REGEN_ENABLED")
  self:RegisterEvent("PLAYER_REGEN_DISABLED")
 -- self:RegisterEvent("UNIT_COMBO_POINTS")
  self:RegisterEvent("COMBAT_TEXT_UPDATE")
  self:RegisterEvent("CHAT_MSG_SKILL")
  self:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED",function ()
    
self:ParseCombat("COMBAT_LOG_EVENT_UNFILTERED", CombatLogGetCurrentEventInfo())
  end)

  --Create event to load up correct font
  --when another mod loads. Incase they try to change
  --the font (super inspect, etc...)
  self:RegisterEvent("ADDON_LOADED", SCT.SetDmgFont)
end

------------------------------
---Shorten a spell/buff
function SCT:ShortenString(strString)
  if strlen(strString) > db["TRUNCATESIZE"] then
    if (db["TRUNCATETYPE"] == 1) then
      return strsub(strString, 1, db["TRUNCATESIZE"])..""
    else
      return gsub(gsub(gsub(strString," of ","O"),"%s",""), "(%u)%l*", "%1")
    end
  else
    return strString
  end
end

------------------------------
---Shorten an amount
function SCT:ShortenValue(value)
  if db["SHORTAMOUNT"] then
    value = shortenValue(value)
  end
  return value
end

------------------------
--Setup Healing Flags based on Options
function SCT:SetHealingFlags()
  --set WoW Healing Flags
  if (SCT.db.profile["WOWHEAL"]) then
    SetCVar("floatingCombatTextCombatHealing", 0)
  else
    SetCVar("floatingCombatTextCombatHealing", 1)
  end
end
