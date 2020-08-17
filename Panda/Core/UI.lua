local addon, ns = ...
local L = ns[1]
local G = ns[2]


--local Aura_count = ns.Aura_count
--local active_enemies = ns.active_enemies 
--local ShowHealth = ns.ShowHealth
--local ShowPower = ns.ShowPower
--local TTD_SHOW = ns.TTD_SHOW 
--local Useingtime = ns.Useingtime 


local Iconsize = 50 -- 图标大小
local font = GameFontHighlight:GetFont()
local texture = ""
local alpha = 0.6 --缩放大小
local textmode = 2 --单位模式，1 = k，m，g，2 = 千,万,百万
--单位模式转换
local function FormatNumber(x)
	local y
	if textmode == 1 then 
		if x>1e9 then y = format("%.1f",x/1e9).."g"
		elseif x>1e6 then y = format("%.1f",x/1e6) .."m" 
		elseif x>1e3 then y = format("%.1f",x/1e3) .."k"  
		else y = x  end 
	end 
	if textmode ==2 then 
		if x>1e6 then y = format("%.1f",x/1e6).."百万"  
		elseif x>1e4 then y = format("%.1f",x/1e4) .."万"
        elseif x>1e3 then y = format("%.1f",x/1e3) .."千"	 	
		else y = x	end 
	end 	
	return y
end 

local ColorTable = {
["武僧"] = "|cff00FF96",
["恶魔猎手"] = "|cffA330C9",
["死亡骑士"] = "|cffC41F3B",
["德鲁伊"] = "|cffFF7D0A",
["猎人"] = "|cffABD473",
["法师"] = "|cff69CCF0",
["圣骑士"] = "|cffF58CBA",
["牧师"] = "|cffFFFFFF",
["潜行者"] = "|cffFFF569",
["萨满祭司"] = "|cff0070DE",
["术士"] = "|cff9482C9",
["战士"] = "|cffC79C6E",
} 

local function ClassColor(unit)
local color = "|cffffe00a"

for k, v in pairs(ColorTable) do
local Class = select(1, UnitClass(unit))
    if Class == k then 
        color = v
    end
end
 return color
end


---------------------------------------------------------------------------
--[[                      材质路径                                    ]]--
---------------------------------------------------------------------------
--color
 sk_0 = "Interface\\AddOns\\Panda\\media\\RenaitreFadeBorder"                     
 A_1 = "Interface\\AddOns\\Panda\\media\\A1"  --A1 00B100      
 A_2 = "Interface\\AddOns\\Panda\\media\\A2"  --A2 00B200         
 A_3 = "Interface\\AddOns\\Panda\\media\\A3"  --A3 00B300         
 A_4 = "Interface\\AddOns\\Panda\\media\\A4"  --A4 00B400       
 A_5 = "Interface\\AddOns\\Panda\\media\\A5"  --A5 00B500        
 A_6 = "Interface\\AddOns\\Panda\\media\\A6"  --A6 00B600      
 A_7 = "Interface\\AddOns\\Panda\\media\\A7"  --A7 00B700        
 A_8 = "Interface\\AddOns\\Panda\\media\\A8"  --A8 00B800       
 A_9 = "Interface\\AddOns\\Panda\\media\\A9"  --A9 00B900      
 A_0 = "Interface\\AddOns\\Panda\\media\\A0" --A0 00C100  
 
 C_1 = "Interface\\AddOns\\Panda\\media\\C1" --C1 00C200            
 C_2 = "Interface\\AddOns\\Panda\\media\\C2" --C2 00C300                                              
 C_3 = "Interface\\AddOns\\Panda\\media\\C3" --C3 00C400
 C_4 = "Interface\\AddOns\\Panda\\media\\C4" --C4 00A200                                                                                                                        
 C_5 = "Interface\\AddOns\\Panda\\media\\C5" --C5 00A300                                                                                                                                                        
 C_6 = "Interface\\AddOns\\Panda\\media\\C6" --C6 00A400                                                                                                                                       
 C_7 = "Interface\\AddOns\\Panda\\media\\C7" --C7 00A500                                                                                                                
 C_8 = "Interface\\AddOns\\Panda\\media\\C8" --C8 00A600     
 C_9 = "Interface\\AddOns\\Panda\\media\\C9" --C9 00D200
 C_0 = "Interface\\AddOns\\Panda\\media\\C0" --C0 00D100
 
 S_1 = "Interface\\AddOns\\Panda\\media\\S1" --S1 00A900
 S_2 = "Interface\\AddOns\\Panda\\media\\S2" --S2 00A800
 S_3 = "Interface\\AddOns\\Panda\\media\\S3" --S3 00A700
 S_4 = "Interface\\AddOns\\Panda\\media\\S4" --S4 00E300
 S_5 = "Interface\\AddOns\\Panda\\media\\S5" --S5 00E500
 S_6 = "Interface\\AddOns\\Panda\\media\\S6" --S6 00E800
 S_7 = "Interface\\AddOns\\Panda\\media\\S7" --S7 00E900
 S_8 = "Interface\\AddOns\\Panda\\media\\S8" --S8 00C500
 S_9 = "Interface\\AddOns\\Panda\\media\\S9" --S9 00E400
 S_0 = "Interface\\AddOns\\Panda\\media\\S0" --S0 00E600



---------------------------------------------------------------------------
--[[                      主UI                                        ]]--
---------------------------------------------------------------------------

PDUI = CreateFrame("Frame", "PDUI", UIParent)
PDUI:SetPoint("CENTER", UIParent, "CENTER", 0, -220)
PDUI:SetSize(Iconsize,Iconsize)
PDUI:RegisterForDrag("LeftButton")
PDUI:SetScript("OnDragStart", function(self) self:StartMoving() end)
PDUI:SetScript("OnDragStop", function(self) self:StopMovingOrSizing() end)
PDUI:SetClampedToScreen(true)
PDUI:SetMovable(true)
PDUI:SetUserPlaced(true)
PDUI:EnableMouse(true)

--[[
PDUIWORDS = CreateFrame("Frame", "PDUIWORDS", PDUI)
PDUIWORDS:SetPoint("CENTER", PDUI, "CENTER", 0, 0)
PDUIWORDS:SetSize(Iconsize,Iconsize)
PDUIWORDS:Hide()
--]]
---------------------------------------------------------------------------
--[[                       图标背景                                     ]]--
---------------------------------------------------------------------------
local function CreateBorder(parent, r, g, b, a, size, br, bg, bb)
local sd = CreateFrame("Frame", nil, parent)
sd:SetFrameLevel(parent:GetFrameLevel()-1)
sd:SetBackdrop({
bgFile = "Interface\\Buttons\\WHITE8x8",
edgeFile = "Interface\\Buttons\\WHITE8x8",
edgeSize = size,
insets = {
left = size,
right = size,
top = size,
bottom = size,
}
})
sd:SetPoint("TOPLEFT", parent, -size, size)
sd:SetPoint("BOTTOMRIGHT", parent, size, -size)
sd:SetBackdropColor(r, g, b, a)
sd:SetBackdropBorderColor(br, bg, bb)
end

---------------------------------------------------------------------------
--[[                       创建框体                                    ]]--
---------------------------------------------------------------------------
local function CreateButton(level, size, tex, r, g, b, ...)
local button = CreateFrame("Frame", nil, PDUI)
button:SetFrameLevel(level)
button:SetSize(size, size)
button:SetPoint(...)

button.texture = button:CreateTexture(nil, "BORDER")
button.texture:SetAllPoints()
button.texture:SetTexture(tex)
button.texture:SetTexCoord(0.1,0.9,0.1,0.9)

button.count = button:CreateFontString(nil, "OVERLAY")
button.count:SetFont(font, 15, "OUTLINE")
button.count:SetPoint("BOTTOMRIGHT", -3, -3)
button.count:SetTextColor(0, 1, 1)
button.cooldown = CreateFrame("Cooldown", nil, button,"CooldownFrameTemplate")
button.cooldown:SetAllPoints(button)
button.cooldown:SetFrameLevel(level)

button.cooldown.text = button.cooldown:CreateFontString(nil, "OVERLAY")
button.cooldown.text:SetFont(font, 20, "OUTLINE")
button.cooldown.text:SetPoint("CENTER")
button.cooldown.text:SetTextColor(r, g, b)

CreateBorder(button, 0, 0, 0, 0, 3, 0, 0, 0)
return button
end

local function CreatePopupIcon(size, tex, r, g, b, ...)
local icon = CreateFrame("Frame", nil, PDUI)
icon:SetSize(size, size)
icon:SetPoint(...)
icon:SetAlpha(alpha)

icon.texture = icon:CreateTexture(nil, "BORDER")
icon.texture:SetAllPoints()
icon.texture:SetTexture(tex)
icon.texture:SetTexCoord(0.1,0.9,0.1,0.9)
icon.count = icon:CreateFontString(nil, "OVERLAY")
icon.count:SetFont(font, 20, "OUTLINE")
icon.count:SetPoint("BOTTOMRIGHT")
icon.count:SetTextColor(0, 1, 1)

icon.cooldown = CreateFrame("Cooldown", nil, icon, "CooldownFrameTemplate")
icon.cooldown:SetAllPoints(icon)

icon.cooldown.text = icon.cooldown:CreateFontString(nil, "OVERLAY")
icon.cooldown.text:SetFont(font, 20, "OUTLINE")
icon.cooldown.text:SetPoint("CENTER")
icon.cooldown.text:SetTextColor(r, g, b)

CreateBorder(icon, 0, 0, 0, 0, 3, 0, 0, 0)
return icon
end

local createStatusbar = function(parent, name, tex, layer, height, width, r, g, b, alpha)
local bar = CreateFrame("StatusBar", name)
bar:SetParent(parent)
if height then
bar:SetHeight(height)
end
if width then
bar:SetWidth(width)
end
bar:SetStatusBarTexture(tex, layer)
bar:SetStatusBarColor(r, g, b, alpha)
return bar
end

local PDAutoSwitch = true

local function ShowColor(self, spell_id, path, event) --显示色块图标(填入path则返回材质地址，不填则返回spell_id对应图标)
local start, duration = GetSpellCooldown(spell_id)
local icon =  GetSpellTexture(spell_id)

self.texture:SetTexture(path or icon)
self.cooldown:SetCooldown(start, duration)

local Useing_spell = ns.Useing_spell
local casting_time = ns.casting_time 
local channel_time = ns.channel_time
local GCD_REMAINS = ns.GCD_REMAINS

---and not IsControlKeyDown() and not IsAltKeyDown() and not IsShiftKeyDown()
if PDAutoSwitch  and ( GCD_REMAINS()<0.2 and casting_time("player")==0 and channel_time("player")==0 and Useing_spell("player")~= 295258 or Useing_spell("player")== 115175 ) then
self:Show()
else
self:Hide()
end

end

local function ShowSpell(self, spell_id, path) --显示法术冷却图标(填入path则返回材质地址，不填则返回spell_id对应图标)
local start, duration = GetSpellCooldown(spell_id)
local icon =  GetSpellTexture(spell_id)
self.texture:SetTexture(path or icon)
self.cooldown:SetCooldown(start, duration)
self:Show()
end


--层级：BACKGROUND LOW MEDIUM HIGH DIALOG FULLSCREEN FULLSCREEN_DIALOG TOOLTIP
---------------------------------------------------------------------------
--[[                            Mainbutton 主图标                     ]]--
---------------------------------------------------------------------------
PDUI.mainbutton = CreateFrame("Frame", "PD_mainbutton", PDUI)
PDUI.mainbutton:SetPoint("TOPLEFT", UIParent, "TOPLEFT", -1,1)
PDUI.mainbutton:SetFrameStrata("TOOLTIP")
PDUI.mainbutton:SetSize(Iconsize/25,Iconsize/25)
PDUI.mainbutton.icon = CreateFrame("Frame", nil, PDUI.mainbutton)
PDUI.mainbutton.icon:SetAllPoints(PDUI.mainbutton)
PDUI.mainbutton.icon.texture = PDUI.mainbutton.icon:CreateTexture(nil, "BORDER")
PDUI.mainbutton.icon.texture:SetTexCoord(0.1,0.9,0.1,0.9)
PDUI.mainbutton.icon.texture:SetAllPoints()
CreateBorder(PDUI.mainbutton.icon, 0, 0, 0, 1, 3, 0, 0, 0)
PDUI.mainbutton.icon.cooldown = CreateFrame("Cooldown", nil, PDUI.mainbutton.icon,"CooldownFrameTemplate")
PDUI.mainbutton.icon.cooldown:SetAllPoints(PDUI.mainbutton.icon)
--PDUI.mainbutton.icon.cooldown.noshowcd = true


---------------------------------------------------------------------------
--[[                            debutton  技能提示图标                 ]]--
---------------------------------------------------------------------------
PDUI.debutton = CreateFrame("Frame", "PDUI_debutton", PDUI)
PDUI.debutton:SetPoint("CENTER", PDUI, "CENTER", 0,  0)
PDUI.debutton:SetFrameStrata("MEDIUM")
PDUI.debutton:SetSize(Iconsize,Iconsize)
PDUI.debutton.icon = CreateFrame("Frame", nil, PDUI.debutton)
PDUI.debutton.icon:SetAllPoints(PDUI.debutton)
PDUI.debutton.icon.texture = PDUI.debutton.icon:CreateTexture(nil, "BORDER")
PDUI.debutton.icon.texture:SetTexCoord(0.1,0.9,0.1,0.9)
PDUI.debutton.icon.texture:SetAllPoints()
CreateBorder(PDUI.debutton.icon, 0, 0, 0, 1, 3, 0, 0, 0)
PDUI.debutton.icon.cooldown = CreateFrame("Cooldown", nil, PDUI.debutton.icon,"CooldownFrameTemplate")
PDUI.debutton.icon.cooldown:SetAllPoints(PDUI.debutton.icon)
--PDUI.debutton.icon.cooldown.noshowcd = true

--[[
--显示目标信息
PDUIWORDS.st = PDUIWORDS:CreateFontString(nil, "OVERLAY")
PDUIWORDS.st:SetPoint("CENTER", PDUIWORDS, "CENTER", 0, -40)
PDUIWORDS.st:SetFont(font, 15, "OUTLINE")
--PDUI.debutton.st.text:SetJustifyH("MIDDLE")

--玩家菜单
PDUIWORDS.playerhealth = CreateFrame("Button","name",PDUIWORDS,"SecureUnitButtonTemplate")
PDUIWORDS.playerhealth:SetAttribute("unit","player")
PDUIWORDS.playerhealth:EnableMouse(true)
PDUIWORDS.playerhealth:SetSize(Iconsize*4/5,Iconsize*4/5)
PDUIWORDS.playerhealth:SetPoint("CENTER", PDUIWORDS, "CENTER", -(Iconsize*2+Iconsize*1/5), 0)
PDUIWORDS.playerhealth:RegisterForClicks("LeftButtonUp","RightButtonUp")
PDUIWORDS.playerhealth:SetAttribute("type1","target")
PDUIWORDS.playerhealth:SetAttribute("type2","togglemenu")
--玩家血量
PDUIWORDS.palyer = PDUIWORDS:CreateFontString(nil, "OVERLAY")
PDUIWORDS.palyer:SetPoint("CENTER", PDUIWORDS, "CENTER", -(Iconsize*2+Iconsize*1/5), 0)
PDUIWORDS.palyer:SetFont(font, 20, "OUTLINE")
--资源
PDUIWORDS.power = PDUIWORDS:CreateFontString(nil, "OVERLAY")
PDUIWORDS.power:SetPoint("CENTER", PDUIWORDS, "CENTER", 0, 40)
PDUIWORDS.power:SetFont(font, 15, "OUTLINE")
--目标菜单
PDUIWORDS.targethealth = CreateFrame("Button","name",PDUIWORDS,"SecureUnitButtonTemplate")
PDUIWORDS.targethealth:SetAttribute("unit","target")
PDUIWORDS.targethealth:EnableMouse(true)
PDUIWORDS.targethealth:SetSize(Iconsize*4/5,Iconsize*4/5)
PDUIWORDS.targethealth:SetPoint("CENTER", PDUIWORDS, "CENTER", Iconsize*2+Iconsize*1/5, 0)
PDUIWORDS.targethealth:RegisterForClicks("LeftButtonUp","RightButtonUp")
PDUIWORDS.targethealth:SetAttribute("type1","target")
PDUIWORDS.targethealth:SetAttribute("type2","togglemenu")
--目标血量
PDUIWORDS.target = PDUIWORDS:CreateFontString(nil, "OVERLAY")
PDUIWORDS.target:SetPoint("CENTER", PDUIWORDS, "CENTER", Iconsize*2+Iconsize*1/5, 0)
PDUIWORDS.target:SetFont(font, 20, "OUTLINE")


local function Update_Words()
local PDUIWORDS = PDUIWORDS

PDUIWORDS.st:SetText("|cffffe00a "..Useingtime("player").." 目标 : " ..active_enemies().."|cffffe00a  死亡 : " ..TTD_SHOW().."|cffffe00a 秒 ")
PDUIWORDS.palyer:SetText(ClassColor("player") ..ShowHealth("player")..ClassColor("player"))
PDUIWORDS.target:SetText(ClassColor("target") ..ShowHealth("target")..ClassColor("target"))

if Aura_count("player","轻度醉拳","PLAYER|HARMFUL")>0 then
PDUIWORDS.power:SetText("|cff00CD00" ..FormatNumber(ShowPower()).."|cff00CD00")
elseif Aura_count("player","中度醉拳","PLAYER|HARMFUL")>0 then
PDUIWORDS.power:SetText("|cffffe00a" ..FormatNumber(ShowPower()).."|cffffe00a")
elseif Aura_count("player","重度醉拳","PLAYER|HARMFUL")>0 then
PDUIWORDS.power:SetText("|cffFF0000" ..FormatNumber(ShowPower()).."|cffFF0000")
else
PDUIWORDS.power:SetText(ClassColor("player") ..FormatNumber(ShowPower())..ClassColor("player"))
end
end
--]]



-------


-------
---------------------------------------------------------------------------
--[[                            Switchbutton  大招开关图标               ]]--
---------------------------------------------------------------------------

PDUI.Switchbutton = CreateFrame("Frame", "PDUI_Switchbutton", PDUI)
PDUI.Switchbutton:SetPoint("CENTER", PDUI.debutton, "CENTER", (Iconsize+Iconsize*1/5),  0)
PDUI.Switchbutton:SetFrameStrata("MEDIUM")
PDUI.Switchbutton:SetSize(Iconsize*4/5,Iconsize*4/5)
PDUI.Switchbutton.icon = CreateFrame("Frame", nil, PDUI.Switchbutton)
PDUI.Switchbutton.icon:SetAllPoints(PDUI.Switchbutton)
PDUI.Switchbutton.icon.texture = PDUI.Switchbutton.icon:CreateTexture(nil, "BORDER")
PDUI.Switchbutton.icon.texture:SetTexCoord(0.1,0.9,0.1,0.9)
PDUI.Switchbutton.icon.texture:SetAllPoints()
CreateBorder(PDUI.Switchbutton.icon, 0, 0, 0, 1, 3, 0, 0, 0)
PDUI.Switchbutton.icon.cooldown = CreateFrame("Cooldown", nil, PDUI.Switchbutton.icon,"CooldownFrameTemplate")
PDUI.Switchbutton.icon.cooldown:SetAllPoints(PDUI.Switchbutton.icon)

--Switchbutton点击
PDUI.sbutton = CreateFrame("Button", "PDUI_Switchbutton_Click", PDUI, "SecureActionButtonTemplate") 
PDUI.sbutton:SetPoint("CENTER", PDUI.debutton, "CENTER",  (Iconsize+Iconsize*1/5),  0)-- 位置 
PDUI.sbutton:SetSize(Iconsize*4/5,Iconsize*4/5)
-- 使按鈕可點擊 
PDUI.sbutton:RegisterForClicks("LeftButtonDown","RightButtonDown") 
PDUI.sbutton:SetAttribute("type1", "macro") 
PDUI.sbutton:SetAttribute("macrotext1", "/PD CCD") 
PDUI.sbutton:SetAttribute("type2","macro")
PDUI.sbutton:SetAttribute("macrotext2", "/PD KEY")



---------------------------------------------------------------------------
--[[                            AOEbutton   AOE <-> ST开关图标           ]]--
---------------------------------------------------------------------------

PDUI.AOEbutton = CreateFrame("Frame", "PDUI_AOEbutton", PDUI)
PDUI.AOEbutton:SetPoint("CENTER", PDUI.debutton, "CENTER", -(Iconsize+Iconsize*1/5),  0)
PDUI.AOEbutton:SetFrameStrata("MEDIUM")
PDUI.AOEbutton:SetSize(Iconsize*4/5,Iconsize*4/5)
PDUI.AOEbutton.icon = CreateFrame("Frame", nil, PDUI.AOEbutton)
PDUI.AOEbutton.icon:SetAllPoints(PDUI.AOEbutton)
PDUI.AOEbutton.icon.texture = PDUI.AOEbutton.icon:CreateTexture(nil, "BORDER")
PDUI.AOEbutton.icon.texture:SetTexCoord(0.1,0.9,0.1,0.9)
PDUI.AOEbutton.icon.texture:SetAllPoints()
CreateBorder(PDUI.AOEbutton.icon, 0, 0, 0, 1, 3, 0, 0, 0)
PDUI.AOEbutton.icon.cooldown = CreateFrame("Cooldown", nil, PDUI.AOEbutton.icon,"CooldownFrameTemplate")
PDUI.AOEbutton.icon.cooldown:SetAllPoints(PDUI.AOEbutton.icon)
--AOEbutton点击
PDUI.abutton = CreateFrame("Button", "PDUI_AOEbutton_Click", PDUI, "SecureActionButtonTemplate") 
PDUI.abutton:SetPoint("CENTER", PDUI.debutton, "CENTER", -(Iconsize+Iconsize*1/5),  0)-- 位置 
PDUI.abutton:SetSize(Iconsize*4/5,Iconsize*4/5)
-- 使按鈕可點擊 
PDUI.abutton:RegisterForClicks("AnyDown") 
PDUI.abutton:SetAttribute("type", "macro") 
PDUI.abutton:SetAttribute("macrotext", "/PD AOE") 







---------------------------------------------------------------------------
--[[                   开关                                 ]]--
---------------------------------------------------------------------------



---------------------------------------------------------------------------
--[[                       更新开关按钮                      ]]--
---------------------------------------------------------------------------

local function UpdateAllSwitchbutton() --更新大招开关按钮
local Switchbutton = PDUI.Switchbutton
local AOEbutton = PDUI.AOEbutton
local SpellswitchButton = PDUI.SpellswitchButton

if PandaDB.CcdSwitch ~= false then ShowSpell(Switchbutton.icon,296952) 
elseif PandaDB.CcdSwitch == false then ShowSpell(Switchbutton.icon,243762)
end

if PandaDB.AoeSwitch ~= false then ShowSpell(AOEbutton.icon,296952) 
elseif PandaDB.AoeSwitch == false then ShowSpell(AOEbutton.icon,243762)
end


end


---------------------------------------------------------------------
--[[                                                       ]]--
---------------------------------------------------------------------------


function pairsByKeys(t) --迭代器函数
    local a = {}
    for n in pairs(t) do table.insert(a, n) end
    table.sort(a)
    local i = 0                 -- iterator variable
    local iter = function()    -- iterator function
       i = i + 1
       if a[i] == nil then return nil
       else return a[i], t[a[i]]
       end
    end
    return iter
end

function UpdateAnchors(table, frame, point, parent, direction, space)
	local index = 1
	for k, v in pairsByKeys(table) do
		if not v then return end
		if direction == "UP" then
			_G[frame..k]:SetPoint(point, parent, point, 0, (index-1)*space)
		elseif direction == "RIGHT" then
			_G[frame..k]:SetPoint(point, parent, point, (index-1)*space, 0)
		end
		index = index + 1
	end
end



---------------------------------------------------------------------------
--[[                               命令提示                            ]]--
---------------------------------------------------------------------------

local function slashCmdFunction(msg)
	msg = string.lower(msg)
	local args = {}
	for word in string.gmatch(msg, "[^%s]+") do
		table.insert(args, word)
	end
	--显示/隐藏文字信息
	if (args[1] == "show") then
		if PDUI:IsShown() then
			PDUI:Hide()
		else
			PDUI:Show()
		end


		
	--修改大小
	elseif (args[1] == "scale") then
		local scale = tonumber(args[2])
		if (scale and scale >= 0.6 and scale <= 2) then
			PandaDB.scale = scale
			PDUI:SetScale(PandaDB.scale)
		else
		    print("|cffffe00a★Panda★:  "..L["必须是0.6~2之间的数字"])
		    
	    end
    
	--开关功能

	
	elseif (args[1] == "aoe") then 
		 if PandaDB.AoeSwitch == nil then
	    PandaDB.AoeSwitch = false
		else
	   PandaDB.AoeSwitch = not PandaDB.AoeSwitch
UpdateAllSwitchbutton()	   
	 end  
	 
	   if not PandaDB.AoeSwitch then  
	   print("|cffffe00a★Panda★:【|r|c00FF68CC 当前模式:强制单体 |r|cffffe00a】|r ")  
	   elseif PandaDB.AoeSwitch then  
	   print("|cffffe00a★Panda★:【|r|c00FF68CC 当前模式:智能AOE |r|cffffe00a】|r ") 
	   end
	   
	elseif (args[1] == "ccd") then 
	
	 if PandaDB.CcdSwitch == nil then
	    PandaDB.CcdSwitch = false
		else
	   PandaDB.CcdSwitch = not PandaDB.CcdSwitch
UpdateAllSwitchbutton()	   
	 end  
	 
	   if PandaDB.CcdSwitch then  
	   print("|cffffe00a★Panda★:【|r|c00FF68CC 当前模式:开启大招 |r|cffffe00a】|r ")  
	   elseif not PandaDB.CcdSwitch then  
	   print("|cffffe00a★Panda★:【|r|c00FF68CC 当前模式:关闭大招 |r|cffffe00a】|r ") 
	   end	
	   
	elseif (args[1] == "asg") then 
	   PandaDB.AsgSwitch = not PandaDB.AsgSwitch
	   if PandaDB.AsgSwitch then  
	   print("|cffffe00a★Panda★:【|r|c00FF68CC 当前模式:开启抢怪捡包 |r|cffffe00a】|r ")  
	   elseif not PandaDB.AsgSwitch then  
	   print("|cffffe00a★Panda★:【|r|c00FF68CC 当前模式:关闭抢怪捡包 |r|cffffe00a】|r ") 
	   end
	   
	elseif (args[1] == "auto") then 
	
	   PDAutoSwitch = not PDAutoSwitch
	   if PDAutoSwitch then  
	   print("|cffffe00a★Panda★:【|r|c00FF68CC 当前模式:开启输出 |r|cffffe00a】|r ")  
	   elseif not PDAutoSwitch then  
	   print("|cffffe00a★Panda★:【|r|c00FF68CC 当前模式:关闭输出 |r|cffffe00a】|r ") 
	   end
	   
	   
    elseif (args[1] == "key") then 	
	local SpellSwitch = ns.SpellSwitch 
        SpellSwitch()
	   

	   

	
	else
	

	local OpenPandaGUI = ns.OpenPandaGUI
	    OpenPandaGUI()

    end
end



SlashCmdList["PD"] = slashCmdFunction
SLASH_PD1 = "/PD"
SLASH_PD2 = "/Panda"










local UpdateAllSwitchbutton = UpdateAllSwitchbutton
ns.UpdateAllSwitchbutton = UpdateAllSwitchbutton


--local Update_Words = Update_Words
--ns.Update_Words = Update_Words


local ShowColor = ShowColor
ns.ShowColor = ShowColor

local ShowSpell = ShowSpell
ns.ShowSpell = ShowSpell




