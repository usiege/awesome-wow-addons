local addon, ns = ...


--local CheckFriend = ns.CheckFriend

local AceGUI = LibStub("AceGUI-3.0")




local function SpellSwitch()
   ------------------------------------------------------
local Class = select(2, UnitClass("player"))
local Special = select(2, GetSpecializationInfo(GetSpecialization()))
local Spell_Key = ns.Spell_Key

	local fullwidth = 300
	local fullheight = 600
    local TreeListGroup = AceGUI:Create("SimpleGroup")
	local PandaGUI = AceGUI:Create("Frame")
	PandaGUI:EnableResize(true)
	PandaGUI:SetCallback("OnClose", function(widget) AceGUI:Release(widget) end)

	PandaGUI:SetTitle("|cffffe00a|r|c00FF68CC ★ Panda ★|r|cffffe00a|r")
	PandaGUI.titletext:SetJustifyH("CENTER")
	PandaGUI.titletext:SetJustifyV("MIDDLE")
	PandaGUI.titletext:SetFont(PandaGUI.titletext:GetFont(),20)
	PandaGUI:SetWidth(fullwidth)
	PandaGUI:SetHeight(fullheight)
	PandaGUI:SetLayout("Fill")
    PandaGUI:AddChild(TreeListGroup)
    
	
	------------------------------------------------------

	local This_A1 = true
    local This_A2 = true
    local This_A3 = true
    local This_A4 = true
    local This_A5 = true
    local This_A6 = true
    local This_A7 = true
    local This_A8 = true
    local This_A9 = true
    local This_A0 = true
	
    local This_C1 = true
    local This_C2 = true
	local This_C3 = true
    local This_C4 = true
    local This_C5 = true
    local This_C6 = true
    local This_C7 = true
    local This_C8 = true
    local This_C9 = true
    local This_C0 = true

	local This_S1 = true
    local This_S2 = true
	local This_S3 = true 
    local This_S4 = true
    local This_S5 = true
    local This_S6 = true
    local This_S7 = true
    local This_S8 = true
    local This_S9 = true
    local This_S0 = true
	
	
local function UpdateThis()
--A1
if Class=="DEMONHUNTER" then
	  if Special == "浩劫" then This_A1 = PandaDB.HJ_A1 end 
	  if Special == "复仇" then This_A1 = PandaDB.FC_A1 end
end  

if Class=="MONK" then
	  if Special == "酒仙" then This_A1 = PandaDB.JX_A1 end 
	  if Special == "踏风" then This_A1 = PandaDB.TAF_A1  end
	  if Special == "织雾" then This_A1 = PandaDB.ZW_A1 end 
end

if Class=="HUNTER" then	  
	  if Special == "野兽控制" then This_A1 = PandaDB.SW_A1 end 
	  if Special == "射击" then This_A1 = PandaDB.SJ_A1 end
	  if Special == "生存" then This_A1 = PandaDB.SC_A1 end 
end

if Class=="WARLOCK" then	  
	  if Special == "恶魔学识" then This_A1 = PandaDB.EMS_A1  end
	  if Special == "毁灭" then This_A1 = PandaDB.HMS_A1 end 
	  if Special == "痛苦" then This_A1 = PandaDB.TKS_A1 end 

end	  

if Class=="ROGUE" then
	  if Special == "奇袭" then This_A1 = PandaDB.QXZ_A1 end 
	  if Special == "敏锐" then This_A1 = PandaDB.MRZ_A1 end
	  if Special == "狂徒" then This_A1 = PandaDB.KTZ_A1 end 
end

if Class == "PALADIN" then	  
	  if Special == "防护" then This_A1 = PandaDB.FQ_A1 end 
	  if Special == "惩戒" then This_A1 = PandaDB.CJQ_A1 end
	  if Special == "神圣" then This_A1 = PandaDB.NQ_A1 end 
end	  
---
if Class == "DRUID" then	  
	  if Special == "平衡" then This_A1 = PandaDB.PHD_A1 end 
	  if Special == "野性" then This_A1 = PandaDB.MD_A1 end
	  if Special == "守护" then This_A1 = PandaDB.XD_A1 end 
	  if Special == "恢复" then This_A1 = PandaDB.ND_A1 end 
end	  

if Class == "DEATHKNIGHT" then	  
	  if Special == "鲜血" then This_A1 = PandaDB.DKT_A1 end 
	  if Special == "冰霜" then This_A1 = PandaDB.BDK_A1 end
	  if Special == "邪恶" then This_A1 = PandaDB.XDK_A1 end 
end	  

if Class == "MAGE" then	  
	  if Special == "火焰" then This_A1 = PandaDB.HF_A1 end 
	  if Special == "冰霜" then This_A1 = PandaDB.BF_A1 end
	  if Special == "奥术" then This_A1 = PandaDB.AF_A1 end 
end	  

if Class == "PRIEST" then	  
	  if Special == "戒律" then This_A1 = PandaDB.JLM_A1 end 
	  if Special == "暗影" then This_A1 = PandaDB.AM_A1 end
	  if Special == "神圣" then This_A1 = PandaDB.shenM_A1 end 
end	  

if Class == "SHAMAN" then	  
	  if Special == "元素" then This_A1 = PandaDB.YSSM_A1 end 
	  if Special == "增强" then This_A1 = PandaDB.ZQSM_A1 end
	  if Special == "恢复" then This_A1 = PandaDB.HFSM_A1 end 
end	  

if Class == "WARRIOR" then	  
	  if Special == "防护" then This_A1 = PandaDB.FZ_A1 end 
	  if Special == "武器" then This_A1 = PandaDB.WQZ_A1 end
	  if Special == "狂怒" then This_A1 = PandaDB.KBZ_A1 end 
end	  


--A2
if Class=="DEMONHUNTER" then
	  if Special == "浩劫" then This_A2 = PandaDB.HJ_A2 end 
	  if Special == "复仇" then This_A2 = PandaDB.FC_A2 end
end  

if Class=="MONK" then
	  if Special == "酒仙" then This_A2 = PandaDB.JX_A2 end 
	  if Special == "踏风" then This_A2 = PandaDB.TAF_A2  end
	  if Special == "织雾" then This_A2 = PandaDB.ZW_A2 end 
end

if Class=="HUNTER" then	  
	  if Special == "野兽控制" then This_A2 = PandaDB.SW_A2 end 
	  if Special == "射击" then This_A2 = PandaDB.SJ_A2 end
	  if Special == "生存" then This_A2 = PandaDB.SC_A2 end 
end

if Class=="WARLOCK" then	  
	  if Special == "恶魔学识" then This_A2 = PandaDB.EMS_A2  end
	  if Special == "毁灭" then This_A2 = PandaDB.HMS_A2 end 
	  if Special == "痛苦" then This_A2 = PandaDB.TKS_A2 end 

end	  

if Class=="ROGUE" then
	  if Special == "奇袭" then This_A2 = PandaDB.QXZ_A2 end 
	  if Special == "敏锐" then This_A2 = PandaDB.MRZ_A2 end
	  if Special == "狂徒" then This_A2 = PandaDB.KTZ_A2 end 
end

if Class == "PALADIN" then	  
	  if Special == "防护" then This_A2 = PandaDB.FQ_A2 end 
	  if Special == "惩戒" then This_A2 = PandaDB.CJQ_A2 end
	  if Special == "神圣" then This_A2 = PandaDB.NQ_A2 end 
end	  
---
if Class == "DRUID" then	  
	  if Special == "平衡" then This_A2 = PandaDB.PHD_A2 end 
	  if Special == "野性" then This_A2 = PandaDB.MD_A2 end
	  if Special == "守护" then This_A2 = PandaDB.XD_A2 end 
	  if Special == "恢复" then This_A2 = PandaDB.ND_A2 end 
end	  

if Class == "DEATHKNIGHT" then	  
	  if Special == "鲜血" then This_A2 = PandaDB.DKT_A2 end 
	  if Special == "冰霜" then This_A2 = PandaDB.BDK_A2 end
	  if Special == "邪恶" then This_A2 = PandaDB.XDK_A2 end 
end	  

if Class == "MAGE" then	  
	  if Special == "火焰" then This_A2 = PandaDB.HF_A2 end 
	  if Special == "冰霜" then This_A2 = PandaDB.BF_A2 end
	  if Special == "奥术" then This_A2 = PandaDB.AF_A2 end 
end	  

if Class == "PRIEST" then	  
	  if Special == "戒律" then This_A2 = PandaDB.JLM_A2 end 
	  if Special == "暗影" then This_A2 = PandaDB.AM_A2 end
	  if Special == "神圣" then This_A2 = PandaDB.shenM_A2 end 
end	  

if Class == "SHAMAN" then	  
	  if Special == "元素" then This_A2 = PandaDB.YSSM_A2 end 
	  if Special == "增强" then This_A2 = PandaDB.ZQSM_A2 end
	  if Special == "恢复" then This_A2 = PandaDB.HFSM_A2 end 
end	  

if Class == "WARRIOR" then	  
	  if Special == "防护" then This_A2 = PandaDB.FZ_A2 end 
	  if Special == "武器" then This_A2 = PandaDB.WQZ_A2 end
	  if Special == "狂怒" then This_A2 = PandaDB.KBZ_A2 end 
end	  

--A3
if Class=="DEMONHUNTER" then
	  if Special == "浩劫" then This_A3 = PandaDB.HJ_A3 end 
	  if Special == "复仇" then This_A3 = PandaDB.FC_A3 end
end  

if Class=="MONK" then
	  if Special == "酒仙" then This_A3 = PandaDB.JX_A3 end 
	  if Special == "踏风" then This_A3 = PandaDB.TAF_A3  end
	  if Special == "织雾" then This_A3 = PandaDB.ZW_A3 end 
end

if Class=="HUNTER" then	  
	  if Special == "野兽控制" then This_A3 = PandaDB.SW_A3 end 
	  if Special == "射击" then This_A3 = PandaDB.SJ_A3 end
	  if Special == "生存" then This_A3 = PandaDB.SC_A3 end 
end

if Class=="WARLOCK" then	  
	  if Special == "恶魔学识" then This_A3 = PandaDB.EMS_A3  end
	  if Special == "毁灭" then This_A3 = PandaDB.HMS_A3 end 
	  if Special == "痛苦" then This_A3 = PandaDB.TKS_A3 end 

end	  

if Class=="ROGUE" then
	  if Special == "奇袭" then This_A3 = PandaDB.QXZ_A3 end 
	  if Special == "敏锐" then This_A3 = PandaDB.MRZ_A3 end
	  if Special == "狂徒" then This_A3 = PandaDB.KTZ_A3 end 
end

if Class == "PALADIN" then	  
	  if Special == "防护" then This_A3 = PandaDB.FQ_A3 end 
	  if Special == "惩戒" then This_A3 = PandaDB.CJQ_A3 end
	  if Special == "神圣" then This_A3 = PandaDB.NQ_A3 end 
end	  
---
if Class == "DRUID" then	  
	  if Special == "平衡" then This_A3 = PandaDB.PHD_A3 end 
	  if Special == "野性" then This_A3 = PandaDB.MD_A3 end
	  if Special == "守护" then This_A3 = PandaDB.XD_A3 end 
	  if Special == "恢复" then This_A3 = PandaDB.ND_A3 end 
end	  

if Class == "DEATHKNIGHT" then	  
	  if Special == "鲜血" then This_A3 = PandaDB.DKT_A3 end 
	  if Special == "冰霜" then This_A3 = PandaDB.BDK_A3 end
	  if Special == "邪恶" then This_A3 = PandaDB.XDK_A3 end 
end	  

if Class == "MAGE" then	  
	  if Special == "火焰" then This_A3 = PandaDB.HF_A3 end 
	  if Special == "冰霜" then This_A3 = PandaDB.BF_A3 end
	  if Special == "奥术" then This_A3 = PandaDB.AF_A3 end 
end	  

if Class == "PRIEST" then	  
	  if Special == "戒律" then This_A3 = PandaDB.JLM_A3 end 
	  if Special == "暗影" then This_A3 = PandaDB.AM_A3 end
	  if Special == "神圣" then This_A3 = PandaDB.shenM_A3 end 
end	  

if Class == "SHAMAN" then	  
	  if Special == "元素" then This_A3 = PandaDB.YSSM_A3 end 
	  if Special == "增强" then This_A3 = PandaDB.ZQSM_A3 end
	  if Special == "恢复" then This_A3 = PandaDB.HFSM_A3 end 
end	  

if Class == "WARRIOR" then	  
	  if Special == "防护" then This_A3 = PandaDB.FZ_A3 end 
	  if Special == "武器" then This_A3 = PandaDB.WQZ_A3 end
	  if Special == "狂怒" then This_A3 = PandaDB.KBZ_A3 end 
end	  

--A4
if Class=="DEMONHUNTER" then
	  if Special == "浩劫" then This_A4 = PandaDB.HJ_A4 end 
	  if Special == "复仇" then This_A4 = PandaDB.FC_A4 end
end  

if Class=="MONK" then
	  if Special == "酒仙" then This_A4 = PandaDB.JX_A4 end 
	  if Special == "踏风" then This_A4 = PandaDB.TAF_A4  end
	  if Special == "织雾" then This_A4 = PandaDB.ZW_A4 end 
end

if Class=="HUNTER" then	  
	  if Special == "野兽控制" then This_A4 = PandaDB.SW_A4 end 
	  if Special == "射击" then This_A4 = PandaDB.SJ_A4 end
	  if Special == "生存" then This_A4 = PandaDB.SC_A4 end 
end

if Class=="WARLOCK" then	  
	  if Special == "恶魔学识" then This_A4 = PandaDB.EMS_A4  end
	  if Special == "毁灭" then This_A4 = PandaDB.HMS_A4 end 
	  if Special == "痛苦" then This_A4 = PandaDB.TKS_A4 end 

end	  

if Class=="ROGUE" then
	  if Special == "奇袭" then This_A4 = PandaDB.QXZ_A4 end 
	  if Special == "敏锐" then This_A4 = PandaDB.MRZ_A4 end
	  if Special == "狂徒" then This_A4 = PandaDB.KTZ_A4 end 
end

if Class == "PALADIN" then	  
	  if Special == "防护" then This_A4 = PandaDB.FQ_A4 end 
	  if Special == "惩戒" then This_A4 = PandaDB.CJQ_A4 end
	  if Special == "神圣" then This_A4 = PandaDB.NQ_A4 end 
end	  
---
if Class == "DRUID" then	  
	  if Special == "平衡" then This_A4 = PandaDB.PHD_A4 end 
	  if Special == "野性" then This_A4 = PandaDB.MD_A4 end
	  if Special == "守护" then This_A4 = PandaDB.XD_A4 end 
	  if Special == "恢复" then This_A4 = PandaDB.ND_A4 end 
end	  

if Class == "DEATHKNIGHT" then	  
	  if Special == "鲜血" then This_A4 = PandaDB.DKT_A4 end 
	  if Special == "冰霜" then This_A4 = PandaDB.BDK_A4 end
	  if Special == "邪恶" then This_A4 = PandaDB.XDK_A4 end 
end	  

if Class == "MAGE" then	  
	  if Special == "火焰" then This_A4 = PandaDB.HF_A4 end 
	  if Special == "冰霜" then This_A4 = PandaDB.BF_A4 end
	  if Special == "奥术" then This_A4 = PandaDB.AF_A4 end 
end	  

if Class == "PRIEST" then	  
	  if Special == "戒律" then This_A4 = PandaDB.JLM_A4 end 
	  if Special == "暗影" then This_A4 = PandaDB.AM_A4 end
	  if Special == "神圣" then This_A4 = PandaDB.shenM_A4 end 
end	  

if Class == "SHAMAN" then	  
	  if Special == "元素" then This_A4 = PandaDB.YSSM_A4 end 
	  if Special == "增强" then This_A4 = PandaDB.ZQSM_A4 end
	  if Special == "恢复" then This_A4 = PandaDB.HFSM_A4 end 
end	  

if Class == "WARRIOR" then	  
	  if Special == "防护" then This_A4 = PandaDB.FZ_A4 end 
	  if Special == "武器" then This_A4 = PandaDB.WQZ_A4 end
	  if Special == "狂怒" then This_A4 = PandaDB.KBZ_A4 end 
end	  

--A5
if Class=="DEMONHUNTER" then
	  if Special == "浩劫" then This_A5 = PandaDB.HJ_A5 end 
	  if Special == "复仇" then This_A5 = PandaDB.FC_A5 end
end  

if Class=="MONK" then
	  if Special == "酒仙" then This_A5 = PandaDB.JX_A5 end 
	  if Special == "踏风" then This_A5 = PandaDB.TAF_A5  end
	  if Special == "织雾" then This_A5 = PandaDB.ZW_A5 end 
end

if Class=="HUNTER" then	  
	  if Special == "野兽控制" then This_A5 = PandaDB.SW_A5 end 
	  if Special == "射击" then This_A5 = PandaDB.SJ_A5 end
	  if Special == "生存" then This_A5 = PandaDB.SC_A5 end 
end

if Class=="WARLOCK" then	  
	  if Special == "恶魔学识" then This_A5 = PandaDB.EMS_A5  end
	  if Special == "毁灭" then This_A5 = PandaDB.HMS_A5 end 
	  if Special == "痛苦" then This_A5 = PandaDB.TKS_A5 end 

end	  

if Class=="ROGUE" then
	  if Special == "奇袭" then This_A5 = PandaDB.QXZ_A5 end 
	  if Special == "敏锐" then This_A5 = PandaDB.MRZ_A5 end
	  if Special == "狂徒" then This_A5 = PandaDB.KTZ_A5 end 
end

if Class == "PALADIN" then	  
	  if Special == "防护" then This_A5 = PandaDB.FQ_A5 end 
	  if Special == "惩戒" then This_A5 = PandaDB.CJQ_A5 end
	  if Special == "神圣" then This_A5 = PandaDB.NQ_A5 end 
end	  
---
if Class == "DRUID" then	  
	  if Special == "平衡" then This_A5 = PandaDB.PHD_A5 end 
	  if Special == "野性" then This_A5 = PandaDB.MD_A5 end
	  if Special == "守护" then This_A5 = PandaDB.XD_A5 end 
	  if Special == "恢复" then This_A5 = PandaDB.ND_A5 end 
end	  

if Class == "DEATHKNIGHT" then	  
	  if Special == "鲜血" then This_A5 = PandaDB.DKT_A5 end 
	  if Special == "冰霜" then This_A5 = PandaDB.BDK_A5 end
	  if Special == "邪恶" then This_A5 = PandaDB.XDK_A5 end 
end	  

if Class == "MAGE" then	  
	  if Special == "火焰" then This_A5 = PandaDB.HF_A5 end 
	  if Special == "冰霜" then This_A5 = PandaDB.BF_A5 end
	  if Special == "奥术" then This_A5 = PandaDB.AF_A5 end 
end	  

if Class == "PRIEST" then	  
	  if Special == "戒律" then This_A5 = PandaDB.JLM_A5 end 
	  if Special == "暗影" then This_A5 = PandaDB.AM_A5 end
	  if Special == "神圣" then This_A5 = PandaDB.shenM_A5 end 
end	  

if Class == "SHAMAN" then	  
	  if Special == "元素" then This_A5 = PandaDB.YSSM_A5 end 
	  if Special == "增强" then This_A5 = PandaDB.ZQSM_A5 end
	  if Special == "恢复" then This_A5 = PandaDB.HFSM_A5 end 
end	  

if Class == "WARRIOR" then	  
	  if Special == "防护" then This_A5 = PandaDB.FZ_A5 end 
	  if Special == "武器" then This_A5 = PandaDB.WQZ_A5 end
	  if Special == "狂怒" then This_A5 = PandaDB.KBZ_A5 end 
end	  

--A6
if Class=="DEMONHUNTER" then
	  if Special == "浩劫" then This_A6 = PandaDB.HJ_A6 end 
	  if Special == "复仇" then This_A6 = PandaDB.FC_A6 end
end  

if Class=="MONK" then
	  if Special == "酒仙" then This_A6 = PandaDB.JX_A6 end 
	  if Special == "踏风" then This_A6 = PandaDB.TAF_A6  end
	  if Special == "织雾" then This_A6 = PandaDB.ZW_A6 end 
end

if Class=="HUNTER" then	  
	  if Special == "野兽控制" then This_A6 = PandaDB.SW_A6 end 
	  if Special == "射击" then This_A6 = PandaDB.SJ_A6 end
	  if Special == "生存" then This_A6 = PandaDB.SC_A6 end 
end

if Class=="WARLOCK" then	  
	  if Special == "恶魔学识" then This_A6 = PandaDB.EMS_A6  end
	  if Special == "毁灭" then This_A6 = PandaDB.HMS_A6 end 
	  if Special == "痛苦" then This_A6 = PandaDB.TKS_A6 end 

end	  

if Class=="ROGUE" then
	  if Special == "奇袭" then This_A6 = PandaDB.QXZ_A6 end 
	  if Special == "敏锐" then This_A6 = PandaDB.MRZ_A6 end
	  if Special == "狂徒" then This_A6 = PandaDB.KTZ_A6 end 
end

if Class == "PALADIN" then	  
	  if Special == "防护" then This_A6 = PandaDB.FQ_A6 end 
	  if Special == "惩戒" then This_A6 = PandaDB.CJQ_A6 end
	  if Special == "神圣" then This_A6 = PandaDB.NQ_A6 end 
end	  
---
if Class == "DRUID" then	  
	  if Special == "平衡" then This_A6 = PandaDB.PHD_A6 end 
	  if Special == "野性" then This_A6 = PandaDB.MD_A6 end
	  if Special == "守护" then This_A6 = PandaDB.XD_A6 end 
	  if Special == "恢复" then This_A6 = PandaDB.ND_A6 end 
end	  

if Class == "DEATHKNIGHT" then	  
	  if Special == "鲜血" then This_A6 = PandaDB.DKT_A6 end 
	  if Special == "冰霜" then This_A6 = PandaDB.BDK_A6 end
	  if Special == "邪恶" then This_A6 = PandaDB.XDK_A6 end 
end	  

if Class == "MAGE" then	  
	  if Special == "火焰" then This_A6 = PandaDB.HF_A6 end 
	  if Special == "冰霜" then This_A6 = PandaDB.BF_A6 end
	  if Special == "奥术" then This_A6 = PandaDB.AF_A6 end 
end	  

if Class == "PRIEST" then	  
	  if Special == "戒律" then This_A6 = PandaDB.JLM_A6 end 
	  if Special == "暗影" then This_A6 = PandaDB.AM_A6 end
	  if Special == "神圣" then This_A6 = PandaDB.shenM_A6 end 
end	  

if Class == "SHAMAN" then	  
	  if Special == "元素" then This_A6 = PandaDB.YSSM_A6 end 
	  if Special == "增强" then This_A6 = PandaDB.ZQSM_A6 end
	  if Special == "恢复" then This_A6 = PandaDB.HFSM_A6 end 
end	  

if Class == "WARRIOR" then	  
	  if Special == "防护" then This_A6 = PandaDB.FZ_A6 end 
	  if Special == "武器" then This_A6 = PandaDB.WQZ_A6 end
	  if Special == "狂怒" then This_A6 = PandaDB.KBZ_A6 end 
end	  

--A7
if Class=="DEMONHUNTER" then
	  if Special == "浩劫" then This_A7 = PandaDB.HJ_A7 end 
	  if Special == "复仇" then This_A7 = PandaDB.FC_A7 end
end  

if Class=="MONK" then
	  if Special == "酒仙" then This_A7 = PandaDB.JX_A7 end 
	  if Special == "踏风" then This_A7 = PandaDB.TAF_A7  end
	  if Special == "织雾" then This_A7 = PandaDB.ZW_A7 end 
end

if Class=="HUNTER" then	  
	  if Special == "野兽控制" then This_A7 = PandaDB.SW_A7 end 
	  if Special == "射击" then This_A7 = PandaDB.SJ_A7 end
	  if Special == "生存" then This_A7 = PandaDB.SC_A7 end 
end

if Class=="WARLOCK" then	  
	  if Special == "恶魔学识" then This_A7 = PandaDB.EMS_A7  end
	  if Special == "毁灭" then This_A7 = PandaDB.HMS_A7 end 
	  if Special == "痛苦" then This_A7 = PandaDB.TKS_A7 end 

end	  

if Class=="ROGUE" then
	  if Special == "奇袭" then This_A7 = PandaDB.QXZ_A7 end 
	  if Special == "敏锐" then This_A7 = PandaDB.MRZ_A7 end
	  if Special == "狂徒" then This_A7 = PandaDB.KTZ_A7 end 
end

if Class == "PALADIN" then	  
	  if Special == "防护" then This_A7 = PandaDB.FQ_A7 end 
	  if Special == "惩戒" then This_A7 = PandaDB.CJQ_A7 end
	  if Special == "神圣" then This_A7 = PandaDB.NQ_A7 end 
end	  
---
if Class == "DRUID" then	  
	  if Special == "平衡" then This_A7 = PandaDB.PHD_A7 end 
	  if Special == "野性" then This_A7 = PandaDB.MD_A7 end
	  if Special == "守护" then This_A7 = PandaDB.XD_A7 end 
	  if Special == "恢复" then This_A7 = PandaDB.ND_A7 end 
end	  

if Class == "DEATHKNIGHT" then	  
	  if Special == "鲜血" then This_A7 = PandaDB.DKT_A7 end 
	  if Special == "冰霜" then This_A7 = PandaDB.BDK_A7 end
	  if Special == "邪恶" then This_A7 = PandaDB.XDK_A7 end 
end	  

if Class == "MAGE" then	  
	  if Special == "火焰" then This_A7 = PandaDB.HF_A7 end 
	  if Special == "冰霜" then This_A7 = PandaDB.BF_A7 end
	  if Special == "奥术" then This_A7 = PandaDB.AF_A7 end 
end	  

if Class == "PRIEST" then	  
	  if Special == "戒律" then This_A7 = PandaDB.JLM_A7 end 
	  if Special == "暗影" then This_A7 = PandaDB.AM_A7 end
	  if Special == "神圣" then This_A7 = PandaDB.shenM_A7 end 
end	  

if Class == "SHAMAN" then	  
	  if Special == "元素" then This_A7 = PandaDB.YSSM_A7 end 
	  if Special == "增强" then This_A7 = PandaDB.ZQSM_A7 end
	  if Special == "恢复" then This_A7 = PandaDB.HFSM_A7 end 
end	  

if Class == "WARRIOR" then	  
	  if Special == "防护" then This_A7 = PandaDB.FZ_A7 end 
	  if Special == "武器" then This_A7 = PandaDB.WQZ_A7 end
	  if Special == "狂怒" then This_A7 = PandaDB.KBZ_A7 end 
end	  


--A8
if Class=="DEMONHUNTER" then
	  if Special == "浩劫" then This_A8 = PandaDB.HJ_A8 end 
	  if Special == "复仇" then This_A8 = PandaDB.FC_A8 end
end  

if Class=="MONK" then
	  if Special == "酒仙" then This_A8 = PandaDB.JX_A8 end 
	  if Special == "踏风" then This_A8 = PandaDB.TAF_A8  end
	  if Special == "织雾" then This_A8 = PandaDB.ZW_A8 end 
end

if Class=="HUNTER" then	  
	  if Special == "野兽控制" then This_A8 = PandaDB.SW_A8 end 
	  if Special == "射击" then This_A8 = PandaDB.SJ_A8 end
	  if Special == "生存" then This_A8 = PandaDB.SC_A8 end 
end

if Class=="WARLOCK" then	  
	  if Special == "恶魔学识" then This_A8 = PandaDB.EMS_A8  end
	  if Special == "毁灭" then This_A8 = PandaDB.HMS_A8 end 
	  if Special == "痛苦" then This_A8 = PandaDB.TKS_A8 end 

end	  

if Class=="ROGUE" then
	  if Special == "奇袭" then This_A8 = PandaDB.QXZ_A8 end 
	  if Special == "敏锐" then This_A8 = PandaDB.MRZ_A8 end
	  if Special == "狂徒" then This_A8 = PandaDB.KTZ_A8 end 
end

if Class == "PALADIN" then	  
	  if Special == "防护" then This_A8 = PandaDB.FQ_A8 end 
	  if Special == "惩戒" then This_A8 = PandaDB.CJQ_A8 end
	  if Special == "神圣" then This_A8 = PandaDB.NQ_A8 end 
end	  
---
if Class == "DRUID" then	  
	  if Special == "平衡" then This_A8 = PandaDB.PHD_A8 end 
	  if Special == "野性" then This_A8 = PandaDB.MD_A8 end
	  if Special == "守护" then This_A8 = PandaDB.XD_A8 end 
	  if Special == "恢复" then This_A8 = PandaDB.ND_A8 end 
end	  

if Class == "DEATHKNIGHT" then	  
	  if Special == "鲜血" then This_A8 = PandaDB.DKT_A8 end 
	  if Special == "冰霜" then This_A8 = PandaDB.BDK_A8 end
	  if Special == "邪恶" then This_A8 = PandaDB.XDK_A8 end 
end	  

if Class == "MAGE" then	  
	  if Special == "火焰" then This_A8 = PandaDB.HF_A8 end 
	  if Special == "冰霜" then This_A8 = PandaDB.BF_A8 end
	  if Special == "奥术" then This_A8 = PandaDB.AF_A8 end 
end	  

if Class == "PRIEST" then	  
	  if Special == "戒律" then This_A8 = PandaDB.JLM_A8 end 
	  if Special == "暗影" then This_A8 = PandaDB.AM_A8 end
	  if Special == "神圣" then This_A8 = PandaDB.shenM_A8 end 
end	  

if Class == "SHAMAN" then	  
	  if Special == "元素" then This_A8 = PandaDB.YSSM_A8 end 
	  if Special == "增强" then This_A8 = PandaDB.ZQSM_A8 end
	  if Special == "恢复" then This_A8 = PandaDB.HFSM_A8 end 
end	  

if Class == "WARRIOR" then	  
	  if Special == "防护" then This_A8 = PandaDB.FZ_A8 end 
	  if Special == "武器" then This_A8 = PandaDB.WQZ_A8 end
	  if Special == "狂怒" then This_A8 = PandaDB.KBZ_A8 end 
end	  


--A9
if Class=="DEMONHUNTER" then
	  if Special == "浩劫" then This_A9 = PandaDB.HJ_A9 end 
	  if Special == "复仇" then This_A9 = PandaDB.FC_A9 end
end  

if Class=="MONK" then
	  if Special == "酒仙" then This_A9 = PandaDB.JX_A9 end 
	  if Special == "踏风" then This_A9 = PandaDB.TAF_A9  end
	  if Special == "织雾" then This_A9 = PandaDB.ZW_A9 end 
end

if Class=="HUNTER" then	  
	  if Special == "野兽控制" then This_A9 = PandaDB.SW_A9 end 
	  if Special == "射击" then This_A9 = PandaDB.SJ_A9 end
	  if Special == "生存" then This_A9 = PandaDB.SC_A9 end 
end

if Class=="WARLOCK" then	  
	  if Special == "恶魔学识" then This_A9 = PandaDB.EMS_A9  end
	  if Special == "毁灭" then This_A9 = PandaDB.HMS_A9 end 
	  if Special == "痛苦" then This_A9 = PandaDB.TKS_A9 end 

end	  

if Class=="ROGUE" then
	  if Special == "奇袭" then This_A9 = PandaDB.QXZ_A9 end 
	  if Special == "敏锐" then This_A9 = PandaDB.MRZ_A9 end
	  if Special == "狂徒" then This_A9 = PandaDB.KTZ_A9 end 
end

if Class == "PALADIN" then	  
	  if Special == "防护" then This_A9 = PandaDB.FQ_A9 end 
	  if Special == "惩戒" then This_A9 = PandaDB.CJQ_A9 end
	  if Special == "神圣" then This_A9 = PandaDB.NQ_A9 end 
end	  
---
if Class == "DRUID" then	  
	  if Special == "平衡" then This_A9 = PandaDB.PHD_A9 end 
	  if Special == "野性" then This_A9 = PandaDB.MD_A9 end
	  if Special == "守护" then This_A9 = PandaDB.XD_A9 end 
	  if Special == "恢复" then This_A9 = PandaDB.ND_A9 end 
end	  

if Class == "DEATHKNIGHT" then	  
	  if Special == "鲜血" then This_A9 = PandaDB.DKT_A9 end 
	  if Special == "冰霜" then This_A9 = PandaDB.BDK_A9 end
	  if Special == "邪恶" then This_A9 = PandaDB.XDK_A9 end 
end	  

if Class == "MAGE" then	  
	  if Special == "火焰" then This_A9 = PandaDB.HF_A9 end 
	  if Special == "冰霜" then This_A9 = PandaDB.BF_A9 end
	  if Special == "奥术" then This_A9 = PandaDB.AF_A9 end 
end	  

if Class == "PRIEST" then	  
	  if Special == "戒律" then This_A9 = PandaDB.JLM_A9 end 
	  if Special == "暗影" then This_A9 = PandaDB.AM_A9 end
	  if Special == "神圣" then This_A9 = PandaDB.shenM_A9 end 
end	  

if Class == "SHAMAN" then	  
	  if Special == "元素" then This_A9 = PandaDB.YSSM_A9 end 
	  if Special == "增强" then This_A9 = PandaDB.ZQSM_A9 end
	  if Special == "恢复" then This_A9 = PandaDB.HFSM_A9 end 
end	  

if Class == "WARRIOR" then	  
	  if Special == "防护" then This_A9 = PandaDB.FZ_A9 end 
	  if Special == "武器" then This_A9 = PandaDB.WQZ_A9 end
	  if Special == "狂怒" then This_A9 = PandaDB.KBZ_A9 end 
end	  

--A0
if Class=="DEMONHUNTER" then
	  if Special == "浩劫" then This_A0 = PandaDB.HJ_A0 end 
	  if Special == "复仇" then This_A0 = PandaDB.FC_A0 end
end  

if Class=="MONK" then
	  if Special == "酒仙" then This_A0 = PandaDB.JX_A0 end 
	  if Special == "踏风" then This_A0 = PandaDB.TAF_A0  end
	  if Special == "织雾" then This_A0 = PandaDB.ZW_A0 end 
end

if Class=="HUNTER" then	  
	  if Special == "野兽控制" then This_A0 = PandaDB.SW_A0 end 
	  if Special == "射击" then This_A0 = PandaDB.SJ_A0 end
	  if Special == "生存" then This_A0 = PandaDB.SC_A0 end 
end

if Class=="WARLOCK" then	  
	  if Special == "恶魔学识" then This_A0 = PandaDB.EMS_A0  end
	  if Special == "毁灭" then This_A0 = PandaDB.HMS_A0 end 
	  if Special == "痛苦" then This_A0 = PandaDB.TKS_A0 end 

end	  

if Class=="ROGUE" then
	  if Special == "奇袭" then This_A0 = PandaDB.QXZ_A0 end 
	  if Special == "敏锐" then This_A0 = PandaDB.MRZ_A0 end
	  if Special == "狂徒" then This_A0 = PandaDB.KTZ_A0 end 
end

if Class == "PALADIN" then	  
	  if Special == "防护" then This_A0 = PandaDB.FQ_A0 end 
	  if Special == "惩戒" then This_A0 = PandaDB.CJQ_A0 end
	  if Special == "神圣" then This_A0 = PandaDB.NQ_A0 end 
end	  
---
if Class == "DRUID" then	  
	  if Special == "平衡" then This_A0 = PandaDB.PHD_A0 end 
	  if Special == "野性" then This_A0 = PandaDB.MD_A0 end
	  if Special == "守护" then This_A0 = PandaDB.XD_A0 end 
	  if Special == "恢复" then This_A0 = PandaDB.ND_A0 end 
end	  

if Class == "DEATHKNIGHT" then	  
	  if Special == "鲜血" then This_A0 = PandaDB.DKT_A0 end 
	  if Special == "冰霜" then This_A0 = PandaDB.BDK_A0 end
	  if Special == "邪恶" then This_A0 = PandaDB.XDK_A0 end 
end	  

if Class == "MAGE" then	  
	  if Special == "火焰" then This_A0 = PandaDB.HF_A0 end 
	  if Special == "冰霜" then This_A0 = PandaDB.BF_A0 end
	  if Special == "奥术" then This_A0 = PandaDB.AF_A0 end 
end	  

if Class == "PRIEST" then	  
	  if Special == "戒律" then This_A0 = PandaDB.JLM_A0 end 
	  if Special == "暗影" then This_A0 = PandaDB.AM_A0 end
	  if Special == "神圣" then This_A0 = PandaDB.shenM_A0 end 
end	  

if Class == "SHAMAN" then	  
	  if Special == "元素" then This_A0 = PandaDB.YSSM_A0 end 
	  if Special == "增强" then This_A0 = PandaDB.ZQSM_A0 end
	  if Special == "恢复" then This_A0 = PandaDB.HFSM_A0 end 
end	  

if Class == "WARRIOR" then	  
	  if Special == "防护" then This_A0 = PandaDB.FZ_A0 end 
	  if Special == "武器" then This_A0 = PandaDB.WQZ_A0 end
	  if Special == "狂怒" then This_A0 = PandaDB.KBZ_A0 end 
end	  


--C1
if Class=="DEMONHUNTER" then
	  if Special == "浩劫" then This_C1 = PandaDB.HJ_C1 end 
	  if Special == "复仇" then This_C1 = PandaDB.FC_C1 end
end  

if Class=="MONK" then
	  if Special == "酒仙" then This_C1 = PandaDB.JX_C1 end 
	  if Special == "踏风" then This_C1 = PandaDB.TAF_C1  end
	  if Special == "织雾" then This_C1 = PandaDB.ZW_C1 end 
end

if Class=="HUNTER" then	  
	  if Special == "野兽控制" then This_C1 = PandaDB.SW_C1 end 
	  if Special == "射击" then This_C1 = PandaDB.SJ_C1 end
	  if Special == "生存" then This_C1 = PandaDB.SC_C1 end 
end

if Class=="WARLOCK" then	  
	  if Special == "恶魔学识" then This_C1 = PandaDB.EMS_C1  end
	  if Special == "毁灭" then This_C1 = PandaDB.HMS_C1 end 
	  if Special == "痛苦" then This_C1 = PandaDB.TKS_C1 end 

end	  

if Class=="ROGUE" then
	  if Special == "奇袭" then This_C1 = PandaDB.QXZ_C1 end 
	  if Special == "敏锐" then This_C1 = PandaDB.MRZ_C1 end
	  if Special == "狂徒" then This_C1 = PandaDB.KTZ_C1 end 
end

if Class == "PALADIN" then	  
	  if Special == "防护" then This_C1 = PandaDB.FQ_C1 end 
	  if Special == "惩戒" then This_C1 = PandaDB.CJQ_C1 end
	  if Special == "神圣" then This_C1 = PandaDB.NQ_C1 end 
end	  
---
if Class == "DRUID" then	  
	  if Special == "平衡" then This_C1 = PandaDB.PHD_C1 end 
	  if Special == "野性" then This_C1 = PandaDB.MD_C1 end
	  if Special == "守护" then This_C1 = PandaDB.XD_C1 end 
	  if Special == "恢复" then This_C1 = PandaDB.ND_C1 end 
end	  

if Class == "DEATHKNIGHT" then	  
	  if Special == "鲜血" then This_C1 = PandaDB.DKT_C1 end 
	  if Special == "冰霜" then This_C1 = PandaDB.BDK_C1 end
	  if Special == "邪恶" then This_C1 = PandaDB.XDK_C1 end 
end	  

if Class == "MAGE" then	  
	  if Special == "火焰" then This_C1 = PandaDB.HF_C1 end 
	  if Special == "冰霜" then This_C1 = PandaDB.BF_C1 end
	  if Special == "奥术" then This_C1 = PandaDB.AF_C1 end 
end	  

if Class == "PRIEST" then	  
	  if Special == "戒律" then This_C1 = PandaDB.JLM_C1 end 
	  if Special == "暗影" then This_C1 = PandaDB.AM_C1 end
	  if Special == "神圣" then This_C1 = PandaDB.shenM_C1 end 
end	  

if Class == "SHAMAN" then	  
	  if Special == "元素" then This_C1 = PandaDB.YSSM_C1 end 
	  if Special == "增强" then This_C1 = PandaDB.ZQSM_C1 end
	  if Special == "恢复" then This_C1 = PandaDB.HFSM_C1 end 
end	  

if Class == "WARRIOR" then	  
	  if Special == "防护" then This_C1 = PandaDB.FZ_C1 end 
	  if Special == "武器" then This_C1 = PandaDB.WQZ_C1 end
	  if Special == "狂怒" then This_C1 = PandaDB.KBZ_C1 end 
end	  


--C2
if Class=="DEMONHUNTER" then
	  if Special == "浩劫" then This_C2 = PandaDB.HJ_C2 end 
	  if Special == "复仇" then This_C2 = PandaDB.FC_C2 end
end  

if Class=="MONK" then
	  if Special == "酒仙" then This_C2 = PandaDB.JX_C2 end 
	  if Special == "踏风" then This_C2 = PandaDB.TAF_C2  end
	  if Special == "织雾" then This_C2 = PandaDB.ZW_C2 end 
end

if Class=="HUNTER" then	  
	  if Special == "野兽控制" then This_C2 = PandaDB.SW_C2 end 
	  if Special == "射击" then This_C2 = PandaDB.SJ_C2 end
	  if Special == "生存" then This_C2 = PandaDB.SC_C2 end 
end

if Class=="WARLOCK" then	  
	  if Special == "恶魔学识" then This_C2 = PandaDB.EMS_C2  end
	  if Special == "毁灭" then This_C2 = PandaDB.HMS_C2 end 
	  if Special == "痛苦" then This_C2 = PandaDB.TKS_C2 end 

end	  

if Class=="ROGUE" then
	  if Special == "奇袭" then This_C2 = PandaDB.QXZ_C2 end 
	  if Special == "敏锐" then This_C2 = PandaDB.MRZ_C2 end
	  if Special == "狂徒" then This_C2 = PandaDB.KTZ_C2 end 
end

if Class == "PALADIN" then	  
	  if Special == "防护" then This_C2 = PandaDB.FQ_C2 end 
	  if Special == "惩戒" then This_C2 = PandaDB.CJQ_C2 end
	  if Special == "神圣" then This_C2 = PandaDB.NQ_C2 end 
end	  
---
if Class == "DRUID" then	  
	  if Special == "平衡" then This_C2 = PandaDB.PHD_C2 end 
	  if Special == "野性" then This_C2 = PandaDB.MD_C2 end
	  if Special == "守护" then This_C2 = PandaDB.XD_C2 end 
	  if Special == "恢复" then This_C2 = PandaDB.ND_C2 end 
end	  

if Class == "DEATHKNIGHT" then	  
	  if Special == "鲜血" then This_C2 = PandaDB.DKT_C2 end 
	  if Special == "冰霜" then This_C2 = PandaDB.BDK_C2 end
	  if Special == "邪恶" then This_C2 = PandaDB.XDK_C2 end 
end	  

if Class == "MAGE" then	  
	  if Special == "火焰" then This_C2 = PandaDB.HF_C2 end 
	  if Special == "冰霜" then This_C2 = PandaDB.BF_C2 end
	  if Special == "奥术" then This_C2 = PandaDB.AF_C2 end 
end	  

if Class == "PRIEST" then	  
	  if Special == "戒律" then This_C2 = PandaDB.JLM_C2 end 
	  if Special == "暗影" then This_C2 = PandaDB.AM_C2 end
	  if Special == "神圣" then This_C2 = PandaDB.shenM_C2 end 
end	  

if Class == "SHAMAN" then	  
	  if Special == "元素" then This_C2 = PandaDB.YSSM_C2 end 
	  if Special == "增强" then This_C2 = PandaDB.ZQSM_C2 end
	  if Special == "恢复" then This_C2 = PandaDB.HFSM_C2 end 
end	  

if Class == "WARRIOR" then	  
	  if Special == "防护" then This_C2 = PandaDB.FZ_C2 end 
	  if Special == "武器" then This_C2 = PandaDB.WQZ_C2 end
	  if Special == "狂怒" then This_C2 = PandaDB.KBZ_C2 end 
end	  



--C3

if Class=="DEMONHUNTER" then
	  if Special == "浩劫" then This_C3 = PandaDB.HJ_C3 end 
	  if Special == "复仇" then This_C3 = PandaDB.FC_C3 end
end  

if Class=="MONK" then
	  if Special == "酒仙" then This_C3 = PandaDB.JX_C3 end 
	  if Special == "踏风" then This_C3 = PandaDB.TAF_C3  end
	  if Special == "织雾" then This_C3 = PandaDB.ZW_C3 end 
end

if Class=="HUNTER" then	  
	  if Special == "野兽控制" then This_C3 = PandaDB.SW_C3 end 
	  if Special == "射击" then This_C3 = PandaDB.SJ_C3 end
	  if Special == "生存" then This_C3 = PandaDB.SC_C3 end 
end

if Class=="WARLOCK" then	  
	  if Special == "恶魔学识" then This_C3 = PandaDB.EMS_C3  end
	  if Special == "毁灭" then This_C3 = PandaDB.HMS_C3 end 
	  if Special == "痛苦" then This_C3 = PandaDB.TKS_C3 end 

end	  

if Class=="ROGUE" then
	  if Special == "奇袭" then This_C3 = PandaDB.QXZ_C3 end 
	  if Special == "敏锐" then This_C3 = PandaDB.MRZ_C3 end
	  if Special == "狂徒" then This_C3 = PandaDB.KTZ_C3 end 
end

if Class == "PALADIN" then	  
	  if Special == "防护" then This_C3 = PandaDB.FQ_C3 end 
	  if Special == "惩戒" then This_C3 = PandaDB.CJQ_C3 end
	  if Special == "神圣" then This_C3 = PandaDB.NQ_C3 end 
end	  
---
if Class == "DRUID" then	  
	  if Special == "平衡" then This_C3 = PandaDB.PHD_C3 end 
	  if Special == "野性" then This_C3 = PandaDB.MD_C3 end
	  if Special == "守护" then This_C3 = PandaDB.XD_C3 end 
	  if Special == "恢复" then This_C3 = PandaDB.ND_C3 end 
end	  

if Class == "DEATHKNIGHT" then	  
	  if Special == "鲜血" then This_C3 = PandaDB.DKT_C3 end 
	  if Special == "冰霜" then This_C3 = PandaDB.BDK_C3 end
	  if Special == "邪恶" then This_C3 = PandaDB.XDK_C3 end 
end	  

if Class == "MAGE" then	  
	  if Special == "火焰" then This_C3 = PandaDB.HF_C3 end 
	  if Special == "冰霜" then This_C3 = PandaDB.BF_C3 end
	  if Special == "奥术" then This_C3 = PandaDB.AF_C3 end 
end	  

if Class == "PRIEST" then	  
	  if Special == "戒律" then This_C3 = PandaDB.JLM_C3 end 
	  if Special == "暗影" then This_C3 = PandaDB.AM_C3 end
	  if Special == "神圣" then This_C3 = PandaDB.shenM_C3 end 
end	  

if Class == "SHAMAN" then	  
	  if Special == "元素" then This_C3 = PandaDB.YSSM_C3 end 
	  if Special == "增强" then This_C3 = PandaDB.ZQSM_C3 end
	  if Special == "恢复" then This_C3 = PandaDB.HFSM_C3 end 
end	  

if Class == "WARRIOR" then	  
	  if Special == "防护" then This_C3 = PandaDB.FZ_C3 end 
	  if Special == "武器" then This_C3 = PandaDB.WQZ_C3 end
	  if Special == "狂怒" then This_C3 = PandaDB.KBZ_C3 end 
end	  




--C4

if Class=="DEMONHUNTER" then
	  if Special == "浩劫" then This_C4 = PandaDB.HJ_C4 end 
	  if Special == "复仇" then This_C4 = PandaDB.FC_C4 end
end  

if Class=="MONK" then
	  if Special == "酒仙" then This_C4 = PandaDB.JX_C4 end 
	  if Special == "踏风" then This_C4 = PandaDB.TAF_C4  end
	  if Special == "织雾" then This_C4 = PandaDB.ZW_C4 end 
end

if Class=="HUNTER" then	  
	  if Special == "野兽控制" then This_C4 = PandaDB.SW_C4 end 
	  if Special == "射击" then This_C4 = PandaDB.SJ_C4 end
	  if Special == "生存" then This_C4 = PandaDB.SC_C4 end 
end

if Class=="WARLOCK" then	  
	  if Special == "恶魔学识" then This_C4 = PandaDB.EMS_C4  end
	  if Special == "毁灭" then This_C4 = PandaDB.HMS_C4 end 
	  if Special == "痛苦" then This_C4 = PandaDB.TKS_C4 end 

end	  

if Class=="ROGUE" then
	  if Special == "奇袭" then This_C4 = PandaDB.QXZ_C4 end 
	  if Special == "敏锐" then This_C4 = PandaDB.MRZ_C4 end
	  if Special == "狂徒" then This_C4 = PandaDB.KTZ_C4 end 
end

if Class == "PALADIN" then	  
	  if Special == "防护" then This_C4 = PandaDB.FQ_C4 end 
	  if Special == "惩戒" then This_C4 = PandaDB.CJQ_C4 end
	  if Special == "神圣" then This_C4 = PandaDB.NQ_C4 end 
end	  
---
if Class == "DRUID" then	  
	  if Special == "平衡" then This_C4 = PandaDB.PHD_C4 end 
	  if Special == "野性" then This_C4 = PandaDB.MD_C4 end
	  if Special == "守护" then This_C4 = PandaDB.XD_C4 end 
	  if Special == "恢复" then This_C4 = PandaDB.ND_C4 end 
end	  

if Class == "DEATHKNIGHT" then	  
	  if Special == "鲜血" then This_C4 = PandaDB.DKT_C4 end 
	  if Special == "冰霜" then This_C4 = PandaDB.BDK_C4 end
	  if Special == "邪恶" then This_C4 = PandaDB.XDK_C4 end 
end	  

if Class == "MAGE" then	  
	  if Special == "火焰" then This_C4 = PandaDB.HF_C4 end 
	  if Special == "冰霜" then This_C4 = PandaDB.BF_C4 end
	  if Special == "奥术" then This_C4 = PandaDB.AF_C4 end 
end	  

if Class == "PRIEST" then	  
	  if Special == "戒律" then This_C4 = PandaDB.JLM_C4 end 
	  if Special == "暗影" then This_C4 = PandaDB.AM_C4 end
	  if Special == "神圣" then This_C4 = PandaDB.shenM_C4 end 
end	  

if Class == "SHAMAN" then	  
	  if Special == "元素" then This_C4 = PandaDB.YSSM_C4 end 
	  if Special == "增强" then This_C4 = PandaDB.ZQSM_C4 end
	  if Special == "恢复" then This_C4 = PandaDB.HFSM_C4 end 
end	  

if Class == "WARRIOR" then	  
	  if Special == "防护" then This_C4 = PandaDB.FZ_C4 end 
	  if Special == "武器" then This_C4 = PandaDB.WQZ_C4 end
	  if Special == "狂怒" then This_C4 = PandaDB.KBZ_C4 end 
end	  


--C5
if Class=="DEMONHUNTER" then
	  if Special == "浩劫" then This_C5 = PandaDB.HJ_C5 end 
	  if Special == "复仇" then This_C5 = PandaDB.FC_C5 end
end  

if Class=="MONK" then
	  if Special == "酒仙" then This_C5 = PandaDB.JX_C5 end 
	  if Special == "踏风" then This_C5 = PandaDB.TAF_C5  end
	  if Special == "织雾" then This_C5 = PandaDB.ZW_C5 end 
end

if Class=="HUNTER" then	  
	  if Special == "野兽控制" then This_C5 = PandaDB.SW_C5 end 
	  if Special == "射击" then This_C5 = PandaDB.SJ_C5 end
	  if Special == "生存" then This_C5 = PandaDB.SC_C5 end 
end

if Class=="WARLOCK" then	  
	  if Special == "恶魔学识" then This_C5 = PandaDB.EMS_C5  end
	  if Special == "毁灭" then This_C5 = PandaDB.HMS_C5 end 
	  if Special == "痛苦" then This_C5 = PandaDB.TKS_C5 end 

end	  

if Class=="ROGUE" then
	  if Special == "奇袭" then This_C5 = PandaDB.QXZ_C5 end 
	  if Special == "敏锐" then This_C5 = PandaDB.MRZ_C5 end
	  if Special == "狂徒" then This_C5 = PandaDB.KTZ_C5 end 
end

if Class == "PALADIN" then	  
	  if Special == "防护" then This_C5 = PandaDB.FQ_C5 end 
	  if Special == "惩戒" then This_C5 = PandaDB.CJQ_C5 end
	  if Special == "神圣" then This_C5 = PandaDB.NQ_C5 end 
end	  
---
if Class == "DRUID" then	  
	  if Special == "平衡" then This_C5 = PandaDB.PHD_C5 end 
	  if Special == "野性" then This_C5 = PandaDB.MD_C5 end
	  if Special == "守护" then This_C5 = PandaDB.XD_C5 end 
	  if Special == "恢复" then This_C5 = PandaDB.ND_C5 end 
end	  

if Class == "DEATHKNIGHT" then	  
	  if Special == "鲜血" then This_C5 = PandaDB.DKT_C5 end 
	  if Special == "冰霜" then This_C5 = PandaDB.BDK_C5 end
	  if Special == "邪恶" then This_C5 = PandaDB.XDK_C5 end 
end	  

if Class == "MAGE" then	  
	  if Special == "火焰" then This_C5 = PandaDB.HF_C5 end 
	  if Special == "冰霜" then This_C5 = PandaDB.BF_C5 end
	  if Special == "奥术" then This_C5 = PandaDB.AF_C5 end 
end	  

if Class == "PRIEST" then	  
	  if Special == "戒律" then This_C5 = PandaDB.JLM_C5 end 
	  if Special == "暗影" then This_C5 = PandaDB.AM_C5 end
	  if Special == "神圣" then This_C5 = PandaDB.shenM_C5 end 
end	  

if Class == "SHAMAN" then	  
	  if Special == "元素" then This_C5 = PandaDB.YSSM_C5 end 
	  if Special == "增强" then This_C5 = PandaDB.ZQSM_C5 end
	  if Special == "恢复" then This_C5 = PandaDB.HFSM_C5 end 
end	  

if Class == "WARRIOR" then	  
	  if Special == "防护" then This_C5 = PandaDB.FZ_C5 end 
	  if Special == "武器" then This_C5 = PandaDB.WQZ_C5 end
	  if Special == "狂怒" then This_C5 = PandaDB.KBZ_C5 end 
end	  

--C6
if Class=="DEMONHUNTER" then
	  if Special == "浩劫" then This_C6 = PandaDB.HJ_C6 end 
	  if Special == "复仇" then This_C6 = PandaDB.FC_C6 end
end  

if Class=="MONK" then
	  if Special == "酒仙" then This_C6 = PandaDB.JX_C6 end 
	  if Special == "踏风" then This_C6 = PandaDB.TAF_C6  end
	  if Special == "织雾" then This_C6 = PandaDB.ZW_C6 end 
end

if Class=="HUNTER" then	  
	  if Special == "野兽控制" then This_C6 = PandaDB.SW_C6 end 
	  if Special == "射击" then This_C6 = PandaDB.SJ_C6 end
	  if Special == "生存" then This_C6 = PandaDB.SC_C6 end 
end

if Class=="WARLOCK" then	  
	  if Special == "恶魔学识" then This_C6 = PandaDB.EMS_C6  end
	  if Special == "毁灭" then This_C6 = PandaDB.HMS_C6 end 
	  if Special == "痛苦" then This_C6 = PandaDB.TKS_C6 end 

end	  

if Class=="ROGUE" then
	  if Special == "奇袭" then This_C6 = PandaDB.QXZ_C6 end 
	  if Special == "敏锐" then This_C6 = PandaDB.MRZ_C6 end
	  if Special == "狂徒" then This_C6 = PandaDB.KTZ_C6 end 
end

if Class == "PALADIN" then	  
	  if Special == "防护" then This_C6 = PandaDB.FQ_C6 end 
	  if Special == "惩戒" then This_C6 = PandaDB.CJQ_C6 end
	  if Special == "神圣" then This_C6 = PandaDB.NQ_C6 end 
end	  
---
if Class == "DRUID" then	  
	  if Special == "平衡" then This_C6 = PandaDB.PHD_C6 end 
	  if Special == "野性" then This_C6 = PandaDB.MD_C6 end
	  if Special == "守护" then This_C6 = PandaDB.XD_C6 end 
	  if Special == "恢复" then This_C6 = PandaDB.ND_C6 end 
end	  

if Class == "DEATHKNIGHT" then	  
	  if Special == "鲜血" then This_C6 = PandaDB.DKT_C6 end 
	  if Special == "冰霜" then This_C6 = PandaDB.BDK_C6 end
	  if Special == "邪恶" then This_C6 = PandaDB.XDK_C6 end 
end	  

if Class == "MAGE" then	  
	  if Special == "火焰" then This_C6 = PandaDB.HF_C6 end 
	  if Special == "冰霜" then This_C6 = PandaDB.BF_C6 end
	  if Special == "奥术" then This_C6 = PandaDB.AF_C6 end 
end	  

if Class == "PRIEST" then	  
	  if Special == "戒律" then This_C6 = PandaDB.JLM_C6 end 
	  if Special == "暗影" then This_C6 = PandaDB.AM_C6 end
	  if Special == "神圣" then This_C6 = PandaDB.shenM_C6 end 
end	  

if Class == "SHAMAN" then	  
	  if Special == "元素" then This_C6 = PandaDB.YSSM_C6 end 
	  if Special == "增强" then This_C6 = PandaDB.ZQSM_C6 end
	  if Special == "恢复" then This_C6 = PandaDB.HFSM_C6 end 
end	  

if Class == "WARRIOR" then	  
	  if Special == "防护" then This_C6 = PandaDB.FZ_C6 end 
	  if Special == "武器" then This_C6 = PandaDB.WQZ_C6 end
	  if Special == "狂怒" then This_C6 = PandaDB.KBZ_C6 end 
end	  



--C7
if Class=="DEMONHUNTER" then
	  if Special == "浩劫" then This_C7 = PandaDB.HJ_C7 end 
	  if Special == "复仇" then This_C7 = PandaDB.FC_C7 end
end  

if Class=="MONK" then
	  if Special == "酒仙" then This_C7 = PandaDB.JX_C7 end 
	  if Special == "踏风" then This_C7 = PandaDB.TAF_C7  end
	  if Special == "织雾" then This_C7 = PandaDB.ZW_C7 end 
end

if Class=="HUNTER" then	  
	  if Special == "野兽控制" then This_C7 = PandaDB.SW_C7 end 
	  if Special == "射击" then This_C7 = PandaDB.SJ_C7 end
	  if Special == "生存" then This_C7 = PandaDB.SC_C7 end 
end

if Class=="WARLOCK" then	  
	  if Special == "恶魔学识" then This_C7 = PandaDB.EMS_C7  end
	  if Special == "毁灭" then This_C7 = PandaDB.HMS_C7 end 
	  if Special == "痛苦" then This_C7 = PandaDB.TKS_C7 end 

end	  

if Class=="ROGUE" then
	  if Special == "奇袭" then This_C7 = PandaDB.QXZ_C7 end 
	  if Special == "敏锐" then This_C7 = PandaDB.MRZ_C7 end
	  if Special == "狂徒" then This_C7 = PandaDB.KTZ_C7 end 
end

if Class == "PALADIN" then	  
	  if Special == "防护" then This_C7 = PandaDB.FQ_C7 end 
	  if Special == "惩戒" then This_C7 = PandaDB.CJQ_C7 end
	  if Special == "神圣" then This_C7 = PandaDB.NQ_C7 end 
end	  
---
if Class == "DRUID" then	  
	  if Special == "平衡" then This_C7 = PandaDB.PHD_C7 end 
	  if Special == "野性" then This_C7 = PandaDB.MD_C7 end
	  if Special == "守护" then This_C7 = PandaDB.XD_C7 end 
	  if Special == "恢复" then This_C7 = PandaDB.ND_C7 end 
end	  

if Class == "DEATHKNIGHT" then	  
	  if Special == "鲜血" then This_C7 = PandaDB.DKT_C7 end 
	  if Special == "冰霜" then This_C7 = PandaDB.BDK_C7 end
	  if Special == "邪恶" then This_C7 = PandaDB.XDK_C7 end 
end	  

if Class == "MAGE" then	  
	  if Special == "火焰" then This_C7 = PandaDB.HF_C7 end 
	  if Special == "冰霜" then This_C7 = PandaDB.BF_C7 end
	  if Special == "奥术" then This_C7 = PandaDB.AF_C7 end 
end	  

if Class == "PRIEST" then	  
	  if Special == "戒律" then This_C7 = PandaDB.JLM_C7 end 
	  if Special == "暗影" then This_C7 = PandaDB.AM_C7 end
	  if Special == "神圣" then This_C7 = PandaDB.shenM_C7 end 
end	  

if Class == "SHAMAN" then	  
	  if Special == "元素" then This_C7 = PandaDB.YSSM_C7 end 
	  if Special == "增强" then This_C7 = PandaDB.ZQSM_C7 end
	  if Special == "恢复" then This_C7 = PandaDB.HFSM_C7 end 
end	  

if Class == "WARRIOR" then	  
	  if Special == "防护" then This_C7 = PandaDB.FZ_C7 end 
	  if Special == "武器" then This_C7 = PandaDB.WQZ_C7 end
	  if Special == "狂怒" then This_C7 = PandaDB.KBZ_C7 end 
end	  



--C8
if Class=="DEMONHUNTER" then
	  if Special == "浩劫" then This_C8 = PandaDB.HJ_C8 end 
	  if Special == "复仇" then This_C8 = PandaDB.FC_C8 end
end  

if Class=="MONK" then
	  if Special == "酒仙" then This_C8 = PandaDB.JX_C8 end 
	  if Special == "踏风" then This_C8 = PandaDB.TAF_C8  end
	  if Special == "织雾" then This_C8 = PandaDB.ZW_C8 end 
end

if Class=="HUNTER" then	  
	  if Special == "野兽控制" then This_C8 = PandaDB.SW_C8 end 
	  if Special == "射击" then This_C8 = PandaDB.SJ_C8 end
	  if Special == "生存" then This_C8 = PandaDB.SC_C8 end 
end

if Class=="WARLOCK" then	  
	  if Special == "恶魔学识" then This_C8 = PandaDB.EMS_C8  end
	  if Special == "毁灭" then This_C8 = PandaDB.HMS_C8 end 
	  if Special == "痛苦" then This_C8 = PandaDB.TKS_C8 end 

end	  

if Class=="ROGUE" then
	  if Special == "奇袭" then This_C8 = PandaDB.QXZ_C8 end 
	  if Special == "敏锐" then This_C8 = PandaDB.MRZ_C8 end
	  if Special == "狂徒" then This_C8 = PandaDB.KTZ_C8 end 
end

if Class == "PALADIN" then	  
	  if Special == "防护" then This_C8 = PandaDB.FQ_C8 end 
	  if Special == "惩戒" then This_C8 = PandaDB.CJQ_C8 end
	  if Special == "神圣" then This_C8 = PandaDB.NQ_C8 end 
end	  
---
if Class == "DRUID" then	  
	  if Special == "平衡" then This_C8 = PandaDB.PHD_C8 end 
	  if Special == "野性" then This_C8 = PandaDB.MD_C8 end
	  if Special == "守护" then This_C8 = PandaDB.XD_C8 end 
	  if Special == "恢复" then This_C8 = PandaDB.ND_C8 end 
end	  

if Class == "DEATHKNIGHT" then	  
	  if Special == "鲜血" then This_C8 = PandaDB.DKT_C8 end 
	  if Special == "冰霜" then This_C8 = PandaDB.BDK_C8 end
	  if Special == "邪恶" then This_C8 = PandaDB.XDK_C8 end 
end	  

if Class == "MAGE" then	  
	  if Special == "火焰" then This_C8 = PandaDB.HF_C8 end 
	  if Special == "冰霜" then This_C8 = PandaDB.BF_C8 end
	  if Special == "奥术" then This_C8 = PandaDB.AF_C8 end 
end	  

if Class == "PRIEST" then	  
	  if Special == "戒律" then This_C8 = PandaDB.JLM_C8 end 
	  if Special == "暗影" then This_C8 = PandaDB.AM_C8 end
	  if Special == "神圣" then This_C8 = PandaDB.shenM_C8 end 
end	  

if Class == "SHAMAN" then	  
	  if Special == "元素" then This_C8 = PandaDB.YSSM_C8 end 
	  if Special == "增强" then This_C8 = PandaDB.ZQSM_C8 end
	  if Special == "恢复" then This_C8 = PandaDB.HFSM_C8 end 
end	  

if Class == "WARRIOR" then	  
	  if Special == "防护" then This_C8 = PandaDB.FZ_C8 end 
	  if Special == "武器" then This_C8 = PandaDB.WQZ_C8 end
	  if Special == "狂怒" then This_C8 = PandaDB.KBZ_C8 end 
end

--C9
if Class=="DEMONHUNTER" then
	  if Special == "浩劫" then This_C9 = PandaDB.HJ_C9 end 
	  if Special == "复仇" then This_C9 = PandaDB.FC_C9 end
end  

if Class=="MONK" then
	  if Special == "酒仙" then This_C9 = PandaDB.JX_C9 end 
	  if Special == "踏风" then This_C9 = PandaDB.TAF_C9  end
	  if Special == "织雾" then This_C9 = PandaDB.ZW_C9 end 
end

if Class=="HUNTER" then	  
	  if Special == "野兽控制" then This_C9 = PandaDB.SW_C9 end 
	  if Special == "射击" then This_C9 = PandaDB.SJ_C9 end
	  if Special == "生存" then This_C9 = PandaDB.SC_C9 end 
end

if Class=="WARLOCK" then	  
	  if Special == "恶魔学识" then This_C9 = PandaDB.EMS_C9  end
	  if Special == "毁灭" then This_C9 = PandaDB.HMS_C9 end 
	  if Special == "痛苦" then This_C9 = PandaDB.TKS_C9 end 

end	  

if Class=="ROGUE" then
	  if Special == "奇袭" then This_C9 = PandaDB.QXZ_C9 end 
	  if Special == "敏锐" then This_C9 = PandaDB.MRZ_C9 end
	  if Special == "狂徒" then This_C9 = PandaDB.KTZ_C9 end 
end

if Class == "PALADIN" then	  
	  if Special == "防护" then This_C9 = PandaDB.FQ_C9 end 
	  if Special == "惩戒" then This_C9 = PandaDB.CJQ_C9 end
	  if Special == "神圣" then This_C9 = PandaDB.NQ_C9 end 
end	  
---
if Class == "DRUID" then	  
	  if Special == "平衡" then This_C9 = PandaDB.PHD_C9 end 
	  if Special == "野性" then This_C9 = PandaDB.MD_C9 end
	  if Special == "守护" then This_C9 = PandaDB.XD_C9 end 
	  if Special == "恢复" then This_C9 = PandaDB.ND_C9 end 
end	  

if Class == "DEATHKNIGHT" then	  
	  if Special == "鲜血" then This_C9 = PandaDB.DKT_C9 end 
	  if Special == "冰霜" then This_C9 = PandaDB.BDK_C9 end
	  if Special == "邪恶" then This_C9 = PandaDB.XDK_C9 end 
end	  

if Class == "MAGE" then	  
	  if Special == "火焰" then This_C9 = PandaDB.HF_C9 end 
	  if Special == "冰霜" then This_C9 = PandaDB.BF_C9 end
	  if Special == "奥术" then This_C9 = PandaDB.AF_C9 end 
end	  

if Class == "PRIEST" then	  
	  if Special == "戒律" then This_C9 = PandaDB.JLM_C9 end 
	  if Special == "暗影" then This_C9 = PandaDB.AM_C9 end
	  if Special == "神圣" then This_C9 = PandaDB.shenM_C9 end 
end	  

if Class == "SHAMAN" then	  
	  if Special == "元素" then This_C9 = PandaDB.YSSM_C9 end 
	  if Special == "增强" then This_C9 = PandaDB.ZQSM_C9 end
	  if Special == "恢复" then This_C9 = PandaDB.HFSM_C9 end 
end	  

if Class == "WARRIOR" then	  
	  if Special == "防护" then This_C9 = PandaDB.FZ_C9 end 
	  if Special == "武器" then This_C9 = PandaDB.WQZ_C9 end
	  if Special == "狂怒" then This_C9 = PandaDB.KBZ_C9 end 
end


--C0
if Class=="DEMONHUNTER" then
	  if Special == "浩劫" then This_C0 = PandaDB.HJ_C0 end 
	  if Special == "复仇" then This_C0 = PandaDB.FC_C0 end
end  

if Class=="MONK" then
	  if Special == "酒仙" then This_C0 = PandaDB.JX_C0 end 
	  if Special == "踏风" then This_C0 = PandaDB.TAF_C0  end
	  if Special == "织雾" then This_C0 = PandaDB.ZW_C0 end 
end

if Class=="HUNTER" then	  
	  if Special == "野兽控制" then This_C0 = PandaDB.SW_C0 end 
	  if Special == "射击" then This_C0 = PandaDB.SJ_C0 end
	  if Special == "生存" then This_C0 = PandaDB.SC_C0 end 
end

if Class=="WARLOCK" then	  
	  if Special == "恶魔学识" then This_C0 = PandaDB.EMS_C0  end
	  if Special == "毁灭" then This_C0 = PandaDB.HMS_C0 end 
	  if Special == "痛苦" then This_C0 = PandaDB.TKS_C0 end 

end	  

if Class=="ROGUE" then
	  if Special == "奇袭" then This_C0 = PandaDB.QXZ_C0 end 
	  if Special == "敏锐" then This_C0 = PandaDB.MRZ_C0 end
	  if Special == "狂徒" then This_C0 = PandaDB.KTZ_C0 end 
end

if Class == "PALADIN" then	  
	  if Special == "防护" then This_C0 = PandaDB.FQ_C0 end 
	  if Special == "惩戒" then This_C0 = PandaDB.CJQ_C0 end
	  if Special == "神圣" then This_C0 = PandaDB.NQ_C0 end 
end	  
---
if Class == "DRUID" then	  
	  if Special == "平衡" then This_C0 = PandaDB.PHD_C0 end 
	  if Special == "野性" then This_C0 = PandaDB.MD_C0 end
	  if Special == "守护" then This_C0 = PandaDB.XD_C0 end 
	  if Special == "恢复" then This_C0 = PandaDB.ND_C0 end 
end	  

if Class == "DEATHKNIGHT" then	  
	  if Special == "鲜血" then This_C0 = PandaDB.DKT_C0 end 
	  if Special == "冰霜" then This_C0 = PandaDB.BDK_C0 end
	  if Special == "邪恶" then This_C0 = PandaDB.XDK_C0 end 
end	  

if Class == "MAGE" then	  
	  if Special == "火焰" then This_C0 = PandaDB.HF_C0 end 
	  if Special == "冰霜" then This_C0 = PandaDB.BF_C0 end
	  if Special == "奥术" then This_C0 = PandaDB.AF_C0 end 
end	  

if Class == "PRIEST" then	  
	  if Special == "戒律" then This_C0 = PandaDB.JLM_C0 end 
	  if Special == "暗影" then This_C0 = PandaDB.AM_C0 end
	  if Special == "神圣" then This_C0 = PandaDB.shenM_C0 end 
end	  

if Class == "SHAMAN" then	  
	  if Special == "元素" then This_C0 = PandaDB.YSSM_C0 end 
	  if Special == "增强" then This_C0 = PandaDB.ZQSM_C0 end
	  if Special == "恢复" then This_C0 = PandaDB.HFSM_C0 end 
end	  

if Class == "WARRIOR" then	  
	  if Special == "防护" then This_C0 = PandaDB.FZ_C0 end 
	  if Special == "武器" then This_C0 = PandaDB.WQZ_C0 end
	  if Special == "狂怒" then This_C0 = PandaDB.KBZ_C0 end 
end

end	  	
	
	
	
UpdateThis()
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	

	
    --A1
	local SpellTickButton_A1 = AceGUI:Create("Button")
	SpellTickButton_A1:SetRelativeWidth(1)
	SpellTickButton_A1.text:SetFont(SpellTickButton_A1.text:GetFont(),15)
	SpellTickButton_A1.text:SetJustifyH("LEFT")

SpellTickButton_A1:SetCallback("OnClick", function()
	
if Class=="DEMONHUNTER" then
	  if Special == "浩劫" then PandaDB.HJ_A1 = not PandaDB.HJ_A1  This_A1 = PandaDB.HJ_A1 end 
	  if Special == "复仇" then PandaDB.FC_A1 = not PandaDB.FC_A1  This_A1 = PandaDB.FC_A1 end
end  

if Class=="MONK" then
	  if Special == "酒仙" then PandaDB.JX_A1 = not PandaDB.JX_A1  This_A1 = PandaDB.JX_A1 end 
	  if Special == "踏风" then PandaDB.TAF_A1 = not PandaDB.TAF_A1  This_A1 = PandaDB.TAF_A1  end
	  if Special == "织雾" then PandaDB.ZW_A1 = not PandaDB.ZW_A1  This_A1 = PandaDB.ZW_A1 end 
end

if Class=="HUNTER" then	  
	  if Special == "野兽控制" then PandaDB.SW_A1 = not PandaDB.SW_A1  This_A1 = PandaDB.SW_A1 end 
	  if Special == "射击" then PandaDB.SJ_A1 = not PandaDB.SJ_A1  This_A1 = PandaDB.SJ_A1 end
	  if Special == "生存" then PandaDB.SC_A1 = not PandaDB.SC_A1  This_A1 = PandaDB.SC_A1 end 
end

if Class=="WARLOCK" then	  
	  if Special == "恶魔学识" then PandaDB.EMS_A1 = not PandaDB.EMS_A1  This_A1 = PandaDB.EMS_A1  end
	  if Special == "毁灭" then PandaDB.HMS_A1 = not PandaDB.HMS_A1  This_A1 = PandaDB.HMS_A1 end 
	  if Special == "痛苦" then PandaDB.TKS_A1 = not PandaDB.TKS_A1  This_A1 = PandaDB.TKS_A1 end 

end	  

if Class=="ROGUE" then
	  if Special == "奇袭" then PandaDB.QXZ_A1 = not PandaDB.QXZ_A1  This_A1 = PandaDB.QXZ_A1 end 
	  if Special == "敏锐" then PandaDB.MRZ_A1 = not PandaDB.MRZ_A1  This_A1 = PandaDB.MRZ_A1 end
	  if Special == "狂徒" then PandaDB.KTZ_A1 = not PandaDB.KTZ_A1  This_A1 = PandaDB.KTZ_A1 end 
end

if Class == "PALADIN" then	  
	  if Special == "防护" then PandaDB.FQ_A1 = not PandaDB.FQ_A1  This_A1 = PandaDB.FQ_A1 end 
	  if Special == "惩戒" then PandaDB.CJQ_A1 = not PandaDB.CJQ_A1  This_A1 = PandaDB.CJQ_A1 end
	  if Special == "神圣" then PandaDB.NQ_A1 = not PandaDB.NQ_A1  This_A1 = PandaDB.NQ_A1 end 
end	  
---
if Class == "DRUID" then	  
	  if Special == "平衡" then PandaDB.PHD_A1 = not PandaDB.PHD_A1  This_A1 = PandaDB.PHD_A1 end 
	  if Special == "野性" then PandaDB.MD_A1 = not PandaDB.MD_A1  This_A1 = PandaDB.MD_A1 end
	  if Special == "守护" then PandaDB.XD_A1 = not PandaDB.XD_A1  This_A1 = PandaDB.XD_A1 end 
	  if Special == "恢复" then PandaDB.ND_A1 = not PandaDB.ND_A1  This_A1 = PandaDB.ND_A1 end 
end	  

if Class == "DEATHKNIGHT" then	  
	  if Special == "鲜血" then PandaDB.DKT_A1 = not PandaDB.DKT_A1  This_A1 = PandaDB.DKT_A1 end 
	  if Special == "冰霜" then PandaDB.BDK_A1 = not PandaDB.BDK_A1  This_A1 = PandaDB.BDK_A1 end
	  if Special == "邪恶" then PandaDB.XDK_A1 = not PandaDB.XDK_A1  This_A1 = PandaDB.XDK_A1 end 
end	  

if Class == "MAGE" then	  
	  if Special == "火焰" then PandaDB.HF_A1 = not PandaDB.HF_A1  This_A1 = PandaDB.HF_A1 end 
	  if Special == "冰霜" then PandaDB.BF_A1 = not PandaDB.BF_A1  This_A1 = PandaDB.BF_A1 end
	  if Special == "奥术" then PandaDB.AF_A1 = not PandaDB.AF_A1  This_A1 = PandaDB.AF_A1 end 
end	  

if Class == "PRIEST" then	  
	  if Special == "戒律" then PandaDB.JLM_A1 = not PandaDB.JLM_A1  This_A1 = PandaDB.JLM_A1 end 
	  if Special == "暗影" then PandaDB.AM_A1 = not PandaDB.AM_A1  This_A1 = PandaDB.AM_A1 end
	  if Special == "神圣" then PandaDB.shenM_A1 = not PandaDB.shenM_A1  This_A1 = PandaDB.shenM_A1 end 
end	  

if Class == "SHAMAN" then	  
	  if Special == "元素" then PandaDB.YSSM_A1 = not PandaDB.YSSM_A1  This_A1 = PandaDB.YSSM_A1 end 
	  if Special == "增强" then PandaDB.ZQSM_A1 = not PandaDB.ZQSM_A1  This_A1 = PandaDB.ZQSM_A1 end
	  if Special == "恢复" then PandaDB.HFSM_A1 = not PandaDB.HFSM_A1  This_A1 = PandaDB.HFSM_A1 end 
end	  

if Class == "WARRIOR" then	  
	  if Special == "防护" then PandaDB.FZ_A1 = not PandaDB.FZ_A1  This_A1 = PandaDB.FZ_A1 end 
	  if Special == "武器" then PandaDB.WQZ_A1 = not PandaDB.WQZ_A1  This_A1 = PandaDB.WQZ_A1 end
	  if Special == "狂怒" then PandaDB.KBZ_A1 = not PandaDB.KBZ_A1  This_A1 = PandaDB.KBZ_A1 end 
end	  

      if This_A1  then SpellTickButton_A1:SetText("|cffffe00a"..Spell_Key("A1").."")
	    elseif not This_A1 then SpellTickButton_A1:SetText("|c00CDCDCD"..Spell_Key("A1").."")
	  end

end)

TreeListGroup:AddChild(SpellTickButton_A1)
    
	--A2
	local SpellTickButton_A2 = AceGUI:Create("Button")
	SpellTickButton_A2:SetRelativeWidth(1)
	SpellTickButton_A2.text:SetFont(SpellTickButton_A2.text:GetFont(),15)
	SpellTickButton_A2.text:SetJustifyH("LEFT")
	
SpellTickButton_A2:SetCallback("OnClick", function() 

if Class=="DEMONHUNTER" then
	  if Special == "浩劫" then PandaDB.HJ_A2 = not PandaDB.HJ_A2  This_A2 = PandaDB.HJ_A2 end 
	  if Special == "复仇" then PandaDB.FC_A2 = not PandaDB.FC_A2  This_A2 = PandaDB.FC_A2 end
end  

if Class=="MONK" then
	  if Special == "酒仙" then PandaDB.JX_A2 = not PandaDB.JX_A2  This_A2 = PandaDB.JX_A2 end 
	  if Special == "踏风" then PandaDB.TAF_A2 = not PandaDB.TAF_A2  This_A2 = PandaDB.TAF_A2  end
	  if Special == "织雾" then PandaDB.ZW_A2 = not PandaDB.ZW_A2  This_A2 = PandaDB.ZW_A2 end 
end

if Class=="HUNTER" then	  
	  if Special == "野兽控制" then PandaDB.SW_A2 = not PandaDB.SW_A2  This_A2 = PandaDB.SW_A2 end 
	  if Special == "射击" then PandaDB.SJ_A2 = not PandaDB.SJ_A2  This_A2 = PandaDB.SJ_A2 end
	  if Special == "生存" then PandaDB.SC_A2 = not PandaDB.SC_A2  This_A2 = PandaDB.SC_A2 end 
end

if Class=="WARLOCK" then	  
	  if Special == "恶魔学识" then PandaDB.EMS_A2 = not PandaDB.EMS_A2  This_A2 = PandaDB.EMS_A2  end
	  if Special == "毁灭" then PandaDB.HMS_A2 = not PandaDB.HMS_A2  This_A2 = PandaDB.HMS_A2 end 
	  if Special == "痛苦" then PandaDB.TKS_A2 = not PandaDB.TKS_A2  This_A2 = PandaDB.TKS_A2 end 

end	  

if Class=="ROGUE" then
	  if Special == "奇袭" then PandaDB.QXZ_A2 = not PandaDB.QXZ_A2  This_A2 = PandaDB.QXZ_A2 end 
	  if Special == "敏锐" then PandaDB.MRZ_A2 = not PandaDB.MRZ_A2  This_A2 = PandaDB.MRZ_A2 end
	  if Special == "狂徒" then PandaDB.KTZ_A2 = not PandaDB.KTZ_A2  This_A2 = PandaDB.KTZ_A2 end 
end

if Class == "PALADIN" then	  
	  if Special == "防护" then PandaDB.FQ_A2 = not PandaDB.FQ_A2  This_A2 = PandaDB.FQ_A2 end 
	  if Special == "惩戒" then PandaDB.CJQ_A2 = not PandaDB.CJQ_A2  This_A2 = PandaDB.CJQ_A2 end
	  if Special == "神圣" then PandaDB.NQ_A2 = not PandaDB.NQ_A2  This_A2 = PandaDB.NQ_A2 end 
end	  
---
if Class == "DRUID" then	  
	  if Special == "平衡" then PandaDB.PHD_A2 = not PandaDB.PHD_A2  This_A2 = PandaDB.PHD_A2 end 
	  if Special == "野性" then PandaDB.MD_A2 = not PandaDB.MD_A2  This_A2 = PandaDB.MD_A2 end
	  if Special == "守护" then PandaDB.XD_A2 = not PandaDB.XD_A2  This_A2 = PandaDB.XD_A2 end 
	  if Special == "恢复" then PandaDB.ND_A2 = not PandaDB.ND_A2  This_A2 = PandaDB.ND_A2 end 
end	  

if Class == "DEATHKNIGHT" then	  
	  if Special == "鲜血" then PandaDB.DKT_A2 = not PandaDB.DKT_A2  This_A2 = PandaDB.DKT_A2 end 
	  if Special == "冰霜" then PandaDB.BDK_A2 = not PandaDB.BDK_A2  This_A2 = PandaDB.BDK_A2 end
	  if Special == "邪恶" then PandaDB.XDK_A2 = not PandaDB.XDK_A2  This_A2 = PandaDB.XDK_A2 end 
end	  

if Class == "MAGE" then	  
	  if Special == "火焰" then PandaDB.HF_A2 = not PandaDB.HF_A2  This_A2 = PandaDB.HF_A2 end 
	  if Special == "冰霜" then PandaDB.BF_A2 = not PandaDB.BF_A2  This_A2 = PandaDB.BF_A2 end
	  if Special == "奥术" then PandaDB.AF_A2 = not PandaDB.AF_A2  This_A2 = PandaDB.AF_A2 end 
end	  

if Class == "PRIEST" then	  
	  if Special == "戒律" then PandaDB.JLM_A2 = not PandaDB.JLM_A2  This_A2 = PandaDB.JLM_A2 end 
	  if Special == "暗影" then PandaDB.AM_A2 = not PandaDB.AM_A2  This_A2 = PandaDB.AM_A2 end
	  if Special == "神圣" then PandaDB.shenM_A2 = not PandaDB.shenM_A2  This_A2 = PandaDB.shenM_A2 end 
end	  

if Class == "SHAMAN" then	  
	  if Special == "元素" then PandaDB.YSSM_A2 = not PandaDB.YSSM_A2  This_A2 = PandaDB.YSSM_A2 end 
	  if Special == "增强" then PandaDB.ZQSM_A2 = not PandaDB.ZQSM_A2  This_A2 = PandaDB.ZQSM_A2 end
	  if Special == "恢复" then PandaDB.HFSM_A2 = not PandaDB.HFSM_A2  This_A2 = PandaDB.HFSM_A2 end 
end	  

if Class == "WARRIOR" then	  
	  if Special == "防护" then PandaDB.FZ_A2 = not PandaDB.FZ_A2  This_A2 = PandaDB.FZ_A2 end 
	  if Special == "武器" then PandaDB.WQZ_A2 = not PandaDB.WQZ_A2  This_A2 = PandaDB.WQZ_A2 end
	  if Special == "狂怒" then PandaDB.KBZ_A2 = not PandaDB.KBZ_A2  This_A2 = PandaDB.KBZ_A2 end 
end	  

      if This_A2 ~= false then SpellTickButton_A2:SetText("|cffffe00a"..Spell_Key("A2").."")
	    elseif This_A2 == false then SpellTickButton_A2:SetText("|c00CDCDCD"..Spell_Key("A2").."")
	  end	  

	  
end)
	TreeListGroup:AddChild(SpellTickButton_A2)

	--A3
	local SpellTickButton_A3 = AceGUI:Create("Button")
	SpellTickButton_A3:SetRelativeWidth(1)
	SpellTickButton_A3.text:SetFont(SpellTickButton_A3.text:GetFont(),15)
	SpellTickButton_A3.text:SetJustifyH("LEFT")
SpellTickButton_A3:SetCallback("OnClick", function()

if Class=="DEMONHUNTER" then
	  if Special == "浩劫" then PandaDB.HJ_A3 = not PandaDB.HJ_A3  This_A3 = PandaDB.HJ_A3 end 
	  if Special == "复仇" then PandaDB.FC_A3 = not PandaDB.FC_A3  This_A3 = PandaDB.FC_A3 end
end  

if Class=="MONK" then
	  if Special == "酒仙" then PandaDB.JX_A3 = not PandaDB.JX_A3  This_A3 = PandaDB.JX_A3 end 
	  if Special == "踏风" then PandaDB.TAF_A3 = not PandaDB.TAF_A3  This_A3 = PandaDB.TAF_A3  end
	  if Special == "织雾" then PandaDB.ZW_A3 = not PandaDB.ZW_A3  This_A3 = PandaDB.ZW_A3 end 
end

if Class=="HUNTER" then	  
	  if Special == "野兽控制" then PandaDB.SW_A3 = not PandaDB.SW_A3  This_A3 = PandaDB.SW_A3 end 
	  if Special == "射击" then PandaDB.SJ_A3 = not PandaDB.SJ_A3  This_A3 = PandaDB.SJ_A3 end
	  if Special == "生存" then PandaDB.SC_A3 = not PandaDB.SC_A3  This_A3 = PandaDB.SC_A3 end 
end

if Class=="WARLOCK" then	  
	  if Special == "恶魔学识" then PandaDB.EMS_A3 = not PandaDB.EMS_A3  This_A3 = PandaDB.EMS_A3  end
	  if Special == "毁灭" then PandaDB.HMS_A3 = not PandaDB.HMS_A3  This_A3 = PandaDB.HMS_A3 end 
	  if Special == "痛苦" then PandaDB.TKS_A3 = not PandaDB.TKS_A3  This_A3 = PandaDB.TKS_A3 end 

end	  

if Class=="ROGUE" then
	  if Special == "奇袭" then PandaDB.QXZ_A3 = not PandaDB.QXZ_A3  This_A3 = PandaDB.QXZ_A3 end 
	  if Special == "敏锐" then PandaDB.MRZ_A3 = not PandaDB.MRZ_A3  This_A3 = PandaDB.MRZ_A3 end
	  if Special == "狂徒" then PandaDB.KTZ_A3 = not PandaDB.KTZ_A3  This_A3 = PandaDB.KTZ_A3 end 
end

if Class == "PALADIN" then	  
	  if Special == "防护" then PandaDB.FQ_A3 = not PandaDB.FQ_A3  This_A3 = PandaDB.FQ_A3 end 
	  if Special == "惩戒" then PandaDB.CJQ_A3 = not PandaDB.CJQ_A3  This_A3 = PandaDB.CJQ_A3 end
	  if Special == "神圣" then PandaDB.NQ_A3 = not PandaDB.NQ_A3  This_A3 = PandaDB.NQ_A3 end 
end	  
---
if Class == "DRUID" then	  
	  if Special == "平衡" then PandaDB.PHD_A3 = not PandaDB.PHD_A3  This_A3 = PandaDB.PHD_A3 end 
	  if Special == "野性" then PandaDB.MD_A3 = not PandaDB.MD_A3  This_A3 = PandaDB.MD_A3 end
	  if Special == "守护" then PandaDB.XD_A3 = not PandaDB.XD_A3  This_A3 = PandaDB.XD_A3 end 
	  if Special == "恢复" then PandaDB.ND_A3 = not PandaDB.ND_A3  This_A3 = PandaDB.ND_A3 end 
end	  

if Class == "DEATHKNIGHT" then	  
	  if Special == "鲜血" then PandaDB.DKT_A3 = not PandaDB.DKT_A3  This_A3 = PandaDB.DKT_A3 end 
	  if Special == "冰霜" then PandaDB.BDK_A3 = not PandaDB.BDK_A3  This_A3 = PandaDB.BDK_A3 end
	  if Special == "邪恶" then PandaDB.XDK_A3 = not PandaDB.XDK_A3  This_A3 = PandaDB.XDK_A3 end 
end	  

if Class == "MAGE" then	  
	  if Special == "火焰" then PandaDB.HF_A3 = not PandaDB.HF_A3  This_A3 = PandaDB.HF_A3 end 
	  if Special == "冰霜" then PandaDB.BF_A3 = not PandaDB.BF_A3  This_A3 = PandaDB.BF_A3 end
	  if Special == "奥术" then PandaDB.AF_A3 = not PandaDB.AF_A3  This_A3 = PandaDB.AF_A3 end 
end	  

if Class == "PRIEST" then	  
	  if Special == "戒律" then PandaDB.JLM_A3 = not PandaDB.JLM_A3  This_A3 = PandaDB.JLM_A3 end 
	  if Special == "暗影" then PandaDB.AM_A3 = not PandaDB.AM_A3  This_A3 = PandaDB.AM_A3 end
	  if Special == "神圣" then PandaDB.shenM_A3 = not PandaDB.shenM_A3  This_A3 = PandaDB.shenM_A3 end 
end	  

if Class == "SHAMAN" then	  
	  if Special == "元素" then PandaDB.YSSM_A3 = not PandaDB.YSSM_A3  This_A3 = PandaDB.YSSM_A3 end 
	  if Special == "增强" then PandaDB.ZQSM_A3 = not PandaDB.ZQSM_A3  This_A3 = PandaDB.ZQSM_A3 end
	  if Special == "恢复" then PandaDB.HFSM_A3 = not PandaDB.HFSM_A3  This_A3 = PandaDB.HFSM_A3 end 
end	  

if Class == "WARRIOR" then	  
	  if Special == "防护" then PandaDB.FZ_A3 = not PandaDB.FZ_A3  This_A3 = PandaDB.FZ_A3 end 
	  if Special == "武器" then PandaDB.WQZ_A3 = not PandaDB.WQZ_A3  This_A3 = PandaDB.WQZ_A3 end
	  if Special == "狂怒" then PandaDB.KBZ_A3 = not PandaDB.KBZ_A3  This_A3 = PandaDB.KBZ_A3 end 
end	  

      if This_A3 ~= false then SpellTickButton_A3:SetText("|cffffe00a"..Spell_Key("A3").."")
	    elseif This_A3 == false then SpellTickButton_A3:SetText("|c00CDCDCD"..Spell_Key("A3").."")
	  end
	  
	
end)
	TreeListGroup:AddChild(SpellTickButton_A3)

	--A4
	local SpellTickButton_A4 = AceGUI:Create("Button")
	SpellTickButton_A4:SetRelativeWidth(1)
	SpellTickButton_A4.text:SetFont(SpellTickButton_A4.text:GetFont(),15)
	SpellTickButton_A4.text:SetJustifyH("LEFT")	
SpellTickButton_A4:SetCallback("OnClick", function() 

if Class=="DEMONHUNTER" then
	  if Special == "浩劫" then PandaDB.HJ_A4 = not PandaDB.HJ_A4  This_A4 = PandaDB.HJ_A4 end 
	  if Special == "复仇" then PandaDB.FC_A4 = not PandaDB.FC_A4  This_A4 = PandaDB.FC_A4 end
end  

if Class=="MONK" then
	  if Special == "酒仙" then PandaDB.JX_A4 = not PandaDB.JX_A4  This_A4 = PandaDB.JX_A4 end 
	  if Special == "踏风" then PandaDB.TAF_A4 = not PandaDB.TAF_A4  This_A4 = PandaDB.TAF_A4  end
	  if Special == "织雾" then PandaDB.ZW_A4 = not PandaDB.ZW_A4  This_A4 = PandaDB.ZW_A4 end 
end

if Class=="HUNTER" then	  
	  if Special == "野兽控制" then PandaDB.SW_A4 = not PandaDB.SW_A4  This_A4 = PandaDB.SW_A4 end 
	  if Special == "射击" then PandaDB.SJ_A4 = not PandaDB.SJ_A4  This_A4 = PandaDB.SJ_A4 end
	  if Special == "生存" then PandaDB.SC_A4 = not PandaDB.SC_A4  This_A4 = PandaDB.SC_A4 end 
end

if Class=="WARLOCK" then	  
	  if Special == "恶魔学识" then PandaDB.EMS_A4 = not PandaDB.EMS_A4  This_A4 = PandaDB.EMS_A4  end
	  if Special == "毁灭" then PandaDB.HMS_A4 = not PandaDB.HMS_A4  This_A4 = PandaDB.HMS_A4 end 
	  if Special == "痛苦" then PandaDB.TKS_A4 = not PandaDB.TKS_A4  This_A4 = PandaDB.TKS_A4 end 

end	  

if Class=="ROGUE" then
	  if Special == "奇袭" then PandaDB.QXZ_A4 = not PandaDB.QXZ_A4  This_A4 = PandaDB.QXZ_A4 end 
	  if Special == "敏锐" then PandaDB.MRZ_A4 = not PandaDB.MRZ_A4  This_A4 = PandaDB.MRZ_A4 end
	  if Special == "狂徒" then PandaDB.KTZ_A4 = not PandaDB.KTZ_A4  This_A4 = PandaDB.KTZ_A4 end 
end

if Class == "PALADIN" then	  
	  if Special == "防护" then PandaDB.FQ_A4 = not PandaDB.FQ_A4  This_A4 = PandaDB.FQ_A4 end 
	  if Special == "惩戒" then PandaDB.CJQ_A4 = not PandaDB.CJQ_A4  This_A4 = PandaDB.CJQ_A4 end
	  if Special == "神圣" then PandaDB.NQ_A4 = not PandaDB.NQ_A4  This_A4 = PandaDB.NQ_A4 end 
end	  
---
if Class == "DRUID" then	  
	  if Special == "平衡" then PandaDB.PHD_A4 = not PandaDB.PHD_A4  This_A4 = PandaDB.PHD_A4 end 
	  if Special == "野性" then PandaDB.MD_A4 = not PandaDB.MD_A4  This_A4 = PandaDB.MD_A4 end
	  if Special == "守护" then PandaDB.XD_A4 = not PandaDB.XD_A4  This_A4 = PandaDB.XD_A4 end 
	  if Special == "恢复" then PandaDB.ND_A4 = not PandaDB.ND_A4  This_A4 = PandaDB.ND_A4 end 
end	  

if Class == "DEATHKNIGHT" then	  
	  if Special == "鲜血" then PandaDB.DKT_A4 = not PandaDB.DKT_A4  This_A4 = PandaDB.DKT_A4 end 
	  if Special == "冰霜" then PandaDB.BDK_A4 = not PandaDB.BDK_A4  This_A4 = PandaDB.BDK_A4 end
	  if Special == "邪恶" then PandaDB.XDK_A4 = not PandaDB.XDK_A4  This_A4 = PandaDB.XDK_A4 end 
end	  

if Class == "MAGE" then	  
	  if Special == "火焰" then PandaDB.HF_A4 = not PandaDB.HF_A4  This_A4 = PandaDB.HF_A4 end 
	  if Special == "冰霜" then PandaDB.BF_A4 = not PandaDB.BF_A4  This_A4 = PandaDB.BF_A4 end
	  if Special == "奥术" then PandaDB.AF_A4 = not PandaDB.AF_A4  This_A4 = PandaDB.AF_A4 end 
end	  

if Class == "PRIEST" then	  
	  if Special == "戒律" then PandaDB.JLM_A4 = not PandaDB.JLM_A4  This_A4 = PandaDB.JLM_A4 end 
	  if Special == "暗影" then PandaDB.AM_A4 = not PandaDB.AM_A4  This_A4 = PandaDB.AM_A4 end
	  if Special == "神圣" then PandaDB.shenM_A4 = not PandaDB.shenM_A4  This_A4 = PandaDB.shenM_A4 end 
end	  

if Class == "SHAMAN" then	  
	  if Special == "元素" then PandaDB.YSSM_A4 = not PandaDB.YSSM_A4  This_A4 = PandaDB.YSSM_A4 end 
	  if Special == "增强" then PandaDB.ZQSM_A4 = not PandaDB.ZQSM_A4  This_A4 = PandaDB.ZQSM_A4 end
	  if Special == "恢复" then PandaDB.HFSM_A4 = not PandaDB.HFSM_A4  This_A4 = PandaDB.HFSM_A4 end 
end	  

if Class == "WARRIOR" then	  
	  if Special == "防护" then PandaDB.FZ_A4 = not PandaDB.FZ_A4  This_A4 = PandaDB.FZ_A4 end 
	  if Special == "武器" then PandaDB.WQZ_A4 = not PandaDB.WQZ_A4  This_A4 = PandaDB.WQZ_A4 end
	  if Special == "狂怒" then PandaDB.KBZ_A4 = not PandaDB.KBZ_A4  This_A4 = PandaDB.KBZ_A4 end 
end	  

      if This_A4 ~= false then SpellTickButton_A4:SetText("|cffffe00a"..Spell_Key("A4").."")
	    elseif This_A4 == false then SpellTickButton_A4:SetText("|c00CDCDCD"..Spell_Key("A4").."")
	  end
	  
	  
end)
	TreeListGroup:AddChild(SpellTickButton_A4)

	--A5
	local SpellTickButton_A5 = AceGUI:Create("Button")
	SpellTickButton_A5:SetRelativeWidth(1)
	SpellTickButton_A5.text:SetFont(SpellTickButton_A5.text:GetFont(),15)
	SpellTickButton_A5.text:SetJustifyH("LEFT")	
SpellTickButton_A5:SetCallback("OnClick", function() 
	  
if Class=="DEMONHUNTER" then
	  if Special == "浩劫" then PandaDB.HJ_A5 = not PandaDB.HJ_A5  This_A5 = PandaDB.HJ_A5 end 
	  if Special == "复仇" then PandaDB.FC_A5 = not PandaDB.FC_A5  This_A5 = PandaDB.FC_A5 end
end  

if Class=="MONK" then
	  if Special == "酒仙" then PandaDB.JX_A5 = not PandaDB.JX_A5  This_A5 = PandaDB.JX_A5 end 
	  if Special == "踏风" then PandaDB.TAF_A5 = not PandaDB.TAF_A5  This_A5 = PandaDB.TAF_A5  end
	  if Special == "织雾" then PandaDB.ZW_A5 = not PandaDB.ZW_A5  This_A5 = PandaDB.ZW_A5 end 
end

if Class=="HUNTER" then	  
	  if Special == "野兽控制" then PandaDB.SW_A5 = not PandaDB.SW_A5  This_A5 = PandaDB.SW_A5 end 
	  if Special == "射击" then PandaDB.SJ_A5 = not PandaDB.SJ_A5  This_A5 = PandaDB.SJ_A5 end
	  if Special == "生存" then PandaDB.SC_A5 = not PandaDB.SC_A5  This_A5 = PandaDB.SC_A5 end 
end

if Class=="WARLOCK" then	  
	  if Special == "恶魔学识" then PandaDB.EMS_A5 = not PandaDB.EMS_A5  This_A5 = PandaDB.EMS_A5  end
	  if Special == "毁灭" then PandaDB.HMS_A5 = not PandaDB.HMS_A5  This_A5 = PandaDB.HMS_A5 end 
	  if Special == "痛苦" then PandaDB.TKS_A5 = not PandaDB.TKS_A5  This_A5 = PandaDB.TKS_A5 end 

end	  

if Class=="ROGUE" then
	  if Special == "奇袭" then PandaDB.QXZ_A5 = not PandaDB.QXZ_A5  This_A5 = PandaDB.QXZ_A5 end 
	  if Special == "敏锐" then PandaDB.MRZ_A5 = not PandaDB.MRZ_A5  This_A5 = PandaDB.MRZ_A5 end
	  if Special == "狂徒" then PandaDB.KTZ_A5 = not PandaDB.KTZ_A5  This_A5 = PandaDB.KTZ_A5 end 
end

if Class == "PALADIN" then	  
	  if Special == "防护" then PandaDB.FQ_A5 = not PandaDB.FQ_A5  This_A5 = PandaDB.FQ_A5 end 
	  if Special == "惩戒" then PandaDB.CJQ_A5 = not PandaDB.CJQ_A5  This_A5 = PandaDB.CJQ_A5 end
	  if Special == "神圣" then PandaDB.NQ_A5 = not PandaDB.NQ_A5  This_A5 = PandaDB.NQ_A5 end 
end	  
---
if Class == "DRUID" then	  
	  if Special == "平衡" then PandaDB.PHD_A5 = not PandaDB.PHD_A5  This_A5 = PandaDB.PHD_A5 end 
	  if Special == "野性" then PandaDB.MD_A5 = not PandaDB.MD_A5  This_A5 = PandaDB.MD_A5 end
	  if Special == "守护" then PandaDB.XD_A5 = not PandaDB.XD_A5  This_A5 = PandaDB.XD_A5 end 
	  if Special == "恢复" then PandaDB.ND_A5 = not PandaDB.ND_A5  This_A5 = PandaDB.ND_A5 end 
end	  

if Class == "DEATHKNIGHT" then	  
	  if Special == "鲜血" then PandaDB.DKT_A5 = not PandaDB.DKT_A5  This_A5 = PandaDB.DKT_A5 end 
	  if Special == "冰霜" then PandaDB.BDK_A5 = not PandaDB.BDK_A5  This_A5 = PandaDB.BDK_A5 end
	  if Special == "邪恶" then PandaDB.XDK_A5 = not PandaDB.XDK_A5  This_A5 = PandaDB.XDK_A5 end 
end	  

if Class == "MAGE" then	  
	  if Special == "火焰" then PandaDB.HF_A5 = not PandaDB.HF_A5  This_A5 = PandaDB.HF_A5 end 
	  if Special == "冰霜" then PandaDB.BF_A5 = not PandaDB.BF_A5  This_A5 = PandaDB.BF_A5 end
	  if Special == "奥术" then PandaDB.AF_A5 = not PandaDB.AF_A5  This_A5 = PandaDB.AF_A5 end 
end	  

if Class == "PRIEST" then	  
	  if Special == "戒律" then PandaDB.JLM_A5 = not PandaDB.JLM_A5  This_A5 = PandaDB.JLM_A5 end 
	  if Special == "暗影" then PandaDB.AM_A5 = not PandaDB.AM_A5  This_A5 = PandaDB.AM_A5 end
	  if Special == "神圣" then PandaDB.shenM_A5 = not PandaDB.shenM_A5  This_A5 = PandaDB.shenM_A5 end 
end	  

if Class == "SHAMAN" then	  
	  if Special == "元素" then PandaDB.YSSM_A5 = not PandaDB.YSSM_A5  This_A5 = PandaDB.YSSM_A5 end 
	  if Special == "增强" then PandaDB.ZQSM_A5 = not PandaDB.ZQSM_A5  This_A5 = PandaDB.ZQSM_A5 end
	  if Special == "恢复" then PandaDB.HFSM_A5 = not PandaDB.HFSM_A5  This_A5 = PandaDB.HFSM_A5 end 
end	  

if Class == "WARRIOR" then	  
	  if Special == "防护" then PandaDB.FZ_A5 = not PandaDB.FZ_A5  This_A5 = PandaDB.FZ_A5 end 
	  if Special == "武器" then PandaDB.WQZ_A5 = not PandaDB.WQZ_A5  This_A5 = PandaDB.WQZ_A5 end
	  if Special == "狂怒" then PandaDB.KBZ_A5 = not PandaDB.KBZ_A5  This_A5 = PandaDB.KBZ_A5 end 
end	  

      if This_A5 ~= false then SpellTickButton_A5:SetText("|cffffe00a"..Spell_Key("A5").."")
	    elseif This_A5 == false then SpellTickButton_A5:SetText("|c00CDCDCD"..Spell_Key("A5").."")
	  end	  
	  
end)
	TreeListGroup:AddChild(SpellTickButton_A5)

	--A6
	local SpellTickButton_A6 = AceGUI:Create("Button")
	SpellTickButton_A6:SetRelativeWidth(1)
	SpellTickButton_A6.text:SetFont(SpellTickButton_A6.text:GetFont(),15)
	SpellTickButton_A6.text:SetJustifyH("LEFT")	
SpellTickButton_A6:SetCallback("OnClick", function() 
	  
if Class=="DEMONHUNTER" then
	  if Special == "浩劫" then PandaDB.HJ_A6 = not PandaDB.HJ_A6  This_A6 = PandaDB.HJ_A6 end 
	  if Special == "复仇" then PandaDB.FC_A6 = not PandaDB.FC_A6  This_A6 = PandaDB.FC_A6 end
end  

if Class=="MONK" then
	  if Special == "酒仙" then PandaDB.JX_A6 = not PandaDB.JX_A6  This_A6 = PandaDB.JX_A6 end 
	  if Special == "踏风" then PandaDB.TAF_A6 = not PandaDB.TAF_A6  This_A6 = PandaDB.TAF_A6  end
	  if Special == "织雾" then PandaDB.ZW_A6 = not PandaDB.ZW_A6  This_A6 = PandaDB.ZW_A6 end 
end

if Class=="HUNTER" then	  
	  if Special == "野兽控制" then PandaDB.SW_A6 = not PandaDB.SW_A6  This_A6 = PandaDB.SW_A6 end 
	  if Special == "射击" then PandaDB.SJ_A6 = not PandaDB.SJ_A6  This_A6 = PandaDB.SJ_A6 end
	  if Special == "生存" then PandaDB.SC_A6 = not PandaDB.SC_A6  This_A6 = PandaDB.SC_A6 end 
end

if Class=="WARLOCK" then	  
	  if Special == "恶魔学识" then PandaDB.EMS_A6 = not PandaDB.EMS_A6  This_A6 = PandaDB.EMS_A6  end
	  if Special == "毁灭" then PandaDB.HMS_A6 = not PandaDB.HMS_A6  This_A6 = PandaDB.HMS_A6 end 
	  if Special == "痛苦" then PandaDB.TKS_A6 = not PandaDB.TKS_A6  This_A6 = PandaDB.TKS_A6 end 

end	  

if Class=="ROGUE" then
	  if Special == "奇袭" then PandaDB.QXZ_A6 = not PandaDB.QXZ_A6  This_A6 = PandaDB.QXZ_A6 end 
	  if Special == "敏锐" then PandaDB.MRZ_A6 = not PandaDB.MRZ_A6  This_A6 = PandaDB.MRZ_A6 end
	  if Special == "狂徒" then PandaDB.KTZ_A6 = not PandaDB.KTZ_A6  This_A6 = PandaDB.KTZ_A6 end 
end

if Class == "PALADIN" then	  
	  if Special == "防护" then PandaDB.FQ_A6 = not PandaDB.FQ_A6  This_A6 = PandaDB.FQ_A6 end 
	  if Special == "惩戒" then PandaDB.CJQ_A6 = not PandaDB.CJQ_A6  This_A6 = PandaDB.CJQ_A6 end
	  if Special == "神圣" then PandaDB.NQ_A6 = not PandaDB.NQ_A6  This_A6 = PandaDB.NQ_A6 end 
end	  
---
if Class == "DRUID" then	  
	  if Special == "平衡" then PandaDB.PHD_A6 = not PandaDB.PHD_A6  This_A6 = PandaDB.PHD_A6 end 
	  if Special == "野性" then PandaDB.MD_A6 = not PandaDB.MD_A6  This_A6 = PandaDB.MD_A6 end
	  if Special == "守护" then PandaDB.XD_A6 = not PandaDB.XD_A6  This_A6 = PandaDB.XD_A6 end 
	  if Special == "恢复" then PandaDB.ND_A6 = not PandaDB.ND_A6  This_A6 = PandaDB.ND_A6 end 
end	  

if Class == "DEATHKNIGHT" then	  
	  if Special == "鲜血" then PandaDB.DKT_A6 = not PandaDB.DKT_A6  This_A6 = PandaDB.DKT_A6 end 
	  if Special == "冰霜" then PandaDB.BDK_A6 = not PandaDB.BDK_A6  This_A6 = PandaDB.BDK_A6 end
	  if Special == "邪恶" then PandaDB.XDK_A6 = not PandaDB.XDK_A6  This_A6 = PandaDB.XDK_A6 end 
end	  

if Class == "MAGE" then	  
	  if Special == "火焰" then PandaDB.HF_A6 = not PandaDB.HF_A6  This_A6 = PandaDB.HF_A6 end 
	  if Special == "冰霜" then PandaDB.BF_A6 = not PandaDB.BF_A6  This_A6 = PandaDB.BF_A6 end
	  if Special == "奥术" then PandaDB.AF_A6 = not PandaDB.AF_A6  This_A6 = PandaDB.AF_A6 end 
end	  

if Class == "PRIEST" then	  
	  if Special == "戒律" then PandaDB.JLM_A6 = not PandaDB.JLM_A6  This_A6 = PandaDB.JLM_A6 end 
	  if Special == "暗影" then PandaDB.AM_A6 = not PandaDB.AM_A6  This_A6 = PandaDB.AM_A6 end
	  if Special == "神圣" then PandaDB.shenM_A6 = not PandaDB.shenM_A6  This_A6 = PandaDB.shenM_A6 end 
end	  

if Class == "SHAMAN" then	  
	  if Special == "元素" then PandaDB.YSSM_A6 = not PandaDB.YSSM_A6  This_A6 = PandaDB.YSSM_A6 end 
	  if Special == "增强" then PandaDB.ZQSM_A6 = not PandaDB.ZQSM_A6  This_A6 = PandaDB.ZQSM_A6 end
	  if Special == "恢复" then PandaDB.HFSM_A6 = not PandaDB.HFSM_A6  This_A6 = PandaDB.HFSM_A6 end 
end	  

if Class == "WARRIOR" then	  
	  if Special == "防护" then PandaDB.FZ_A6 = not PandaDB.FZ_A6  This_A6 = PandaDB.FZ_A6 end 
	  if Special == "武器" then PandaDB.WQZ_A6 = not PandaDB.WQZ_A6  This_A6 = PandaDB.WQZ_A6 end
	  if Special == "狂怒" then PandaDB.KBZ_A6 = not PandaDB.KBZ_A6  This_A6 = PandaDB.KBZ_A6 end 
end	  

      if This_A6 ~= false then SpellTickButton_A6:SetText("|cffffe00a"..Spell_Key("A6").."")
	    elseif This_A6 == false then SpellTickButton_A6:SetText("|c00CDCDCD"..Spell_Key("A6").."")
	  end	  
	  
end)
	TreeListGroup:AddChild(SpellTickButton_A6)

	--A7
	local SpellTickButton_A7 = AceGUI:Create("Button")
	SpellTickButton_A7:SetRelativeWidth(1)
	SpellTickButton_A7.text:SetFont(SpellTickButton_A7.text:GetFont(),15)
	SpellTickButton_A7.text:SetJustifyH("LEFT")		
SpellTickButton_A7:SetCallback("OnClick", function() 
	 
if Class=="DEMONHUNTER" then
	  if Special == "浩劫" then PandaDB.HJ_A7 = not PandaDB.HJ_A7  This_A7 = PandaDB.HJ_A7 end 
	  if Special == "复仇" then PandaDB.FC_A7 = not PandaDB.FC_A7  This_A7 = PandaDB.FC_A7 end
end  

if Class=="MONK" then
	  if Special == "酒仙" then PandaDB.JX_A7 = not PandaDB.JX_A7  This_A7 = PandaDB.JX_A7 end 
	  if Special == "踏风" then PandaDB.TAF_A7 = not PandaDB.TAF_A7  This_A7 = PandaDB.TAF_A7  end
	  if Special == "织雾" then PandaDB.ZW_A7 = not PandaDB.ZW_A7  This_A7 = PandaDB.ZW_A7 end 
end

if Class=="HUNTER" then	  
	  if Special == "野兽控制" then PandaDB.SW_A7 = not PandaDB.SW_A7  This_A7 = PandaDB.SW_A7 end 
	  if Special == "射击" then PandaDB.SJ_A7 = not PandaDB.SJ_A7  This_A7 = PandaDB.SJ_A7 end
	  if Special == "生存" then PandaDB.SC_A7 = not PandaDB.SC_A7  This_A7 = PandaDB.SC_A7 end 
end

if Class=="WARLOCK" then	  
	  if Special == "恶魔学识" then PandaDB.EMS_A7 = not PandaDB.EMS_A7  This_A7 = PandaDB.EMS_A7  end
	  if Special == "毁灭" then PandaDB.HMS_A7 = not PandaDB.HMS_A7  This_A7 = PandaDB.HMS_A7 end 
	  if Special == "痛苦" then PandaDB.TKS_A7 = not PandaDB.TKS_A7  This_A7 = PandaDB.TKS_A7 end 

end	  

if Class=="ROGUE" then
	  if Special == "奇袭" then PandaDB.QXZ_A7 = not PandaDB.QXZ_A7  This_A7 = PandaDB.QXZ_A7 end 
	  if Special == "敏锐" then PandaDB.MRZ_A7 = not PandaDB.MRZ_A7  This_A7 = PandaDB.MRZ_A7 end
	  if Special == "狂徒" then PandaDB.KTZ_A7 = not PandaDB.KTZ_A7  This_A7 = PandaDB.KTZ_A7 end 
end

if Class == "PALADIN" then	  
	  if Special == "防护" then PandaDB.FQ_A7 = not PandaDB.FQ_A7  This_A7 = PandaDB.FQ_A7 end 
	  if Special == "惩戒" then PandaDB.CJQ_A7 = not PandaDB.CJQ_A7  This_A7 = PandaDB.CJQ_A7 end
	  if Special == "神圣" then PandaDB.NQ_A7 = not PandaDB.NQ_A7  This_A7 = PandaDB.NQ_A7 end 
end	  
---
if Class == "DRUID" then	  
	  if Special == "平衡" then PandaDB.PHD_A7 = not PandaDB.PHD_A7  This_A7 = PandaDB.PHD_A7 end 
	  if Special == "野性" then PandaDB.MD_A7 = not PandaDB.MD_A7  This_A7 = PandaDB.MD_A7 end
	  if Special == "守护" then PandaDB.XD_A7 = not PandaDB.XD_A7  This_A7 = PandaDB.XD_A7 end 
	  if Special == "恢复" then PandaDB.ND_A7 = not PandaDB.ND_A7  This_A7 = PandaDB.ND_A7 end 
end	  

if Class == "DEATHKNIGHT" then	  
	  if Special == "鲜血" then PandaDB.DKT_A7 = not PandaDB.DKT_A7  This_A7 = PandaDB.DKT_A7 end 
	  if Special == "冰霜" then PandaDB.BDK_A7 = not PandaDB.BDK_A7  This_A7 = PandaDB.BDK_A7 end
	  if Special == "邪恶" then PandaDB.XDK_A7 = not PandaDB.XDK_A7  This_A7 = PandaDB.XDK_A7 end 
end	  

if Class == "MAGE" then	  
	  if Special == "火焰" then PandaDB.HF_A7 = not PandaDB.HF_A7  This_A7 = PandaDB.HF_A7 end 
	  if Special == "冰霜" then PandaDB.BF_A7 = not PandaDB.BF_A7  This_A7 = PandaDB.BF_A7 end
	  if Special == "奥术" then PandaDB.AF_A7 = not PandaDB.AF_A7  This_A7 = PandaDB.AF_A7 end 
end	  

if Class == "PRIEST" then	  
	  if Special == "戒律" then PandaDB.JLM_A7 = not PandaDB.JLM_A7  This_A7 = PandaDB.JLM_A7 end 
	  if Special == "暗影" then PandaDB.AM_A7 = not PandaDB.AM_A7  This_A7 = PandaDB.AM_A7 end
	  if Special == "神圣" then PandaDB.shenM_A7 = not PandaDB.shenM_A7  This_A7 = PandaDB.shenM_A7 end 
end	  

if Class == "SHAMAN" then	  
	  if Special == "元素" then PandaDB.YSSM_A7 = not PandaDB.YSSM_A7  This_A7 = PandaDB.YSSM_A7 end 
	  if Special == "增强" then PandaDB.ZQSM_A7 = not PandaDB.ZQSM_A7  This_A7 = PandaDB.ZQSM_A7 end
	  if Special == "恢复" then PandaDB.HFSM_A7 = not PandaDB.HFSM_A7  This_A7 = PandaDB.HFSM_A7 end 
end	  

if Class == "WARRIOR" then	  
	  if Special == "防护" then PandaDB.FZ_A7 = not PandaDB.FZ_A7  This_A7 = PandaDB.FZ_A7 end 
	  if Special == "武器" then PandaDB.WQZ_A7 = not PandaDB.WQZ_A7  This_A7 = PandaDB.WQZ_A7 end
	  if Special == "狂怒" then PandaDB.KBZ_A7 = not PandaDB.KBZ_A7  This_A7 = PandaDB.KBZ_A7 end 
end	  

      if This_A7 ~= false then SpellTickButton_A7:SetText("|cffffe00a"..Spell_Key("A7").."")
	    elseif This_A7 == false then SpellTickButton_A7:SetText("|c00CDCDCD"..Spell_Key("A7").."")
	  end	 
	  
end)
	TreeListGroup:AddChild(SpellTickButton_A7)

	--A8
    local SpellTickButton_A8 = AceGUI:Create("Button")
	SpellTickButton_A8:SetRelativeWidth(1)
	SpellTickButton_A8.text:SetFont(SpellTickButton_A8.text:GetFont(),15)
	SpellTickButton_A8.text:SetJustifyH("LEFT")			
SpellTickButton_A8:SetCallback("OnClick", function() 
	  
if Class=="DEMONHUNTER" then
	  if Special == "浩劫" then PandaDB.HJ_A8 = not PandaDB.HJ_A8  This_A8 = PandaDB.HJ_A8 end 
	  if Special == "复仇" then PandaDB.FC_A8 = not PandaDB.FC_A8  This_A8 = PandaDB.FC_A8 end
end  

if Class=="MONK" then
	  if Special == "酒仙" then PandaDB.JX_A8 = not PandaDB.JX_A8  This_A8 = PandaDB.JX_A8 end 
	  if Special == "踏风" then PandaDB.TAF_A8 = not PandaDB.TAF_A8  This_A8 = PandaDB.TAF_A8  end
	  if Special == "织雾" then PandaDB.ZW_A8 = not PandaDB.ZW_A8  This_A8 = PandaDB.ZW_A8 end 
end

if Class=="HUNTER" then	  
	  if Special == "野兽控制" then PandaDB.SW_A8 = not PandaDB.SW_A8  This_A8 = PandaDB.SW_A8 end 
	  if Special == "射击" then PandaDB.SJ_A8 = not PandaDB.SJ_A8  This_A8 = PandaDB.SJ_A8 end
	  if Special == "生存" then PandaDB.SC_A8 = not PandaDB.SC_A8  This_A8 = PandaDB.SC_A8 end 
end

if Class=="WARLOCK" then	  
	  if Special == "恶魔学识" then PandaDB.EMS_A8 = not PandaDB.EMS_A8  This_A8 = PandaDB.EMS_A8  end
	  if Special == "毁灭" then PandaDB.HMS_A8 = not PandaDB.HMS_A8  This_A8 = PandaDB.HMS_A8 end 
	  if Special == "痛苦" then PandaDB.TKS_A8 = not PandaDB.TKS_A8  This_A8 = PandaDB.TKS_A8 end 

end	  

if Class=="ROGUE" then
	  if Special == "奇袭" then PandaDB.QXZ_A8 = not PandaDB.QXZ_A8  This_A8 = PandaDB.QXZ_A8 end 
	  if Special == "敏锐" then PandaDB.MRZ_A8 = not PandaDB.MRZ_A8  This_A8 = PandaDB.MRZ_A8 end
	  if Special == "狂徒" then PandaDB.KTZ_A8 = not PandaDB.KTZ_A8  This_A8 = PandaDB.KTZ_A8 end 
end

if Class == "PALADIN" then	  
	  if Special == "防护" then PandaDB.FQ_A8 = not PandaDB.FQ_A8  This_A8 = PandaDB.FQ_A8 end 
	  if Special == "惩戒" then PandaDB.CJQ_A8 = not PandaDB.CJQ_A8  This_A8 = PandaDB.CJQ_A8 end
	  if Special == "神圣" then PandaDB.NQ_A8 = not PandaDB.NQ_A8  This_A8 = PandaDB.NQ_A8 end 
end	  
---
if Class == "DRUID" then	  
	  if Special == "平衡" then PandaDB.PHD_A8 = not PandaDB.PHD_A8  This_A8 = PandaDB.PHD_A8 end 
	  if Special == "野性" then PandaDB.MD_A8 = not PandaDB.MD_A8  This_A8 = PandaDB.MD_A8 end
	  if Special == "守护" then PandaDB.XD_A8 = not PandaDB.XD_A8  This_A8 = PandaDB.XD_A8 end 
	  if Special == "恢复" then PandaDB.ND_A8 = not PandaDB.ND_A8  This_A8 = PandaDB.ND_A8 end 
end	  

if Class == "DEATHKNIGHT" then	  
	  if Special == "鲜血" then PandaDB.DKT_A8 = not PandaDB.DKT_A8  This_A8 = PandaDB.DKT_A8 end 
	  if Special == "冰霜" then PandaDB.BDK_A8 = not PandaDB.BDK_A8  This_A8 = PandaDB.BDK_A8 end
	  if Special == "邪恶" then PandaDB.XDK_A8 = not PandaDB.XDK_A8  This_A8 = PandaDB.XDK_A8 end 
end	  

if Class == "MAGE" then	  
	  if Special == "火焰" then PandaDB.HF_A8 = not PandaDB.HF_A8  This_A8 = PandaDB.HF_A8 end 
	  if Special == "冰霜" then PandaDB.BF_A8 = not PandaDB.BF_A8  This_A8 = PandaDB.BF_A8 end
	  if Special == "奥术" then PandaDB.AF_A8 = not PandaDB.AF_A8  This_A8 = PandaDB.AF_A8 end 
end	  

if Class == "PRIEST" then	  
	  if Special == "戒律" then PandaDB.JLM_A8 = not PandaDB.JLM_A8  This_A8 = PandaDB.JLM_A8 end 
	  if Special == "暗影" then PandaDB.AM_A8 = not PandaDB.AM_A8  This_A8 = PandaDB.AM_A8 end
	  if Special == "神圣" then PandaDB.shenM_A8 = not PandaDB.shenM_A8  This_A8 = PandaDB.shenM_A8 end 
end	  

if Class == "SHAMAN" then	  
	  if Special == "元素" then PandaDB.YSSM_A8 = not PandaDB.YSSM_A8  This_A8 = PandaDB.YSSM_A8 end 
	  if Special == "增强" then PandaDB.ZQSM_A8 = not PandaDB.ZQSM_A8  This_A8 = PandaDB.ZQSM_A8 end
	  if Special == "恢复" then PandaDB.HFSM_A8 = not PandaDB.HFSM_A8  This_A8 = PandaDB.HFSM_A8 end 
end	  

if Class == "WARRIOR" then	  
	  if Special == "防护" then PandaDB.FZ_A8 = not PandaDB.FZ_A8  This_A8 = PandaDB.FZ_A8 end 
	  if Special == "武器" then PandaDB.WQZ_A8 = not PandaDB.WQZ_A8  This_A8 = PandaDB.WQZ_A8 end
	  if Special == "狂怒" then PandaDB.KBZ_A8 = not PandaDB.KBZ_A8  This_A8 = PandaDB.KBZ_A8 end 
end	  

      if This_A8 ~= false then SpellTickButton_A8:SetText("|cffffe00a"..Spell_Key("A8").."")
	    elseif This_A8 == false then SpellTickButton_A8:SetText("|c00CDCDCD"..Spell_Key("A8").."")
	  end	  
	  
end)
	TreeListGroup:AddChild(SpellTickButton_A8)

	--A9
	local SpellTickButton_A9 = AceGUI:Create("Button")
	SpellTickButton_A9:SetRelativeWidth(1)
	SpellTickButton_A9.text:SetFont(SpellTickButton_A9.text:GetFont(),15)
	SpellTickButton_A9.text:SetJustifyH("LEFT")		
SpellTickButton_A9:SetCallback("OnClick", function() 
	  
if Class=="DEMONHUNTER" then
	  if Special == "浩劫" then PandaDB.HJ_A9 = not PandaDB.HJ_A9  This_A9 = PandaDB.HJ_A9 end 
	  if Special == "复仇" then PandaDB.FC_A9 = not PandaDB.FC_A9  This_A9 = PandaDB.FC_A9 end
end  

if Class=="MONK" then
	  if Special == "酒仙" then PandaDB.JX_A9 = not PandaDB.JX_A9  This_A9 = PandaDB.JX_A9 end 
	  if Special == "踏风" then PandaDB.TAF_A9 = not PandaDB.TAF_A9  This_A9 = PandaDB.TAF_A9  end
	  if Special == "织雾" then PandaDB.ZW_A9 = not PandaDB.ZW_A9  This_A9 = PandaDB.ZW_A9 end 
end

if Class=="HUNTER" then	  
	  if Special == "野兽控制" then PandaDB.SW_A9 = not PandaDB.SW_A9  This_A9 = PandaDB.SW_A9 end 
	  if Special == "射击" then PandaDB.SJ_A9 = not PandaDB.SJ_A9  This_A9 = PandaDB.SJ_A9 end
	  if Special == "生存" then PandaDB.SC_A9 = not PandaDB.SC_A9  This_A9 = PandaDB.SC_A9 end 
end

if Class=="WARLOCK" then	  
	  if Special == "恶魔学识" then PandaDB.EMS_A9 = not PandaDB.EMS_A9  This_A9 = PandaDB.EMS_A9  end
	  if Special == "毁灭" then PandaDB.HMS_A9 = not PandaDB.HMS_A9  This_A9 = PandaDB.HMS_A9 end 
	  if Special == "痛苦" then PandaDB.TKS_A9 = not PandaDB.TKS_A9  This_A9 = PandaDB.TKS_A9 end 

end	  

if Class=="ROGUE" then
	  if Special == "奇袭" then PandaDB.QXZ_A9 = not PandaDB.QXZ_A9  This_A9 = PandaDB.QXZ_A9 end 
	  if Special == "敏锐" then PandaDB.MRZ_A9 = not PandaDB.MRZ_A9  This_A9 = PandaDB.MRZ_A9 end
	  if Special == "狂徒" then PandaDB.KTZ_A9 = not PandaDB.KTZ_A9  This_A9 = PandaDB.KTZ_A9 end 
end

if Class == "PALADIN" then	  
	  if Special == "防护" then PandaDB.FQ_A9 = not PandaDB.FQ_A9  This_A9 = PandaDB.FQ_A9 end 
	  if Special == "惩戒" then PandaDB.CJQ_A9 = not PandaDB.CJQ_A9  This_A9 = PandaDB.CJQ_A9 end
	  if Special == "神圣" then PandaDB.NQ_A9 = not PandaDB.NQ_A9  This_A9 = PandaDB.NQ_A9 end 
end	  
---
if Class == "DRUID" then	  
	  if Special == "平衡" then PandaDB.PHD_A9 = not PandaDB.PHD_A9  This_A9 = PandaDB.PHD_A9 end 
	  if Special == "野性" then PandaDB.MD_A9 = not PandaDB.MD_A9  This_A9 = PandaDB.MD_A9 end
	  if Special == "守护" then PandaDB.XD_A9 = not PandaDB.XD_A9  This_A9 = PandaDB.XD_A9 end 
	  if Special == "恢复" then PandaDB.ND_A9 = not PandaDB.ND_A9  This_A9 = PandaDB.ND_A9 end 
end	  

if Class == "DEATHKNIGHT" then	  
	  if Special == "鲜血" then PandaDB.DKT_A9 = not PandaDB.DKT_A9  This_A9 = PandaDB.DKT_A9 end 
	  if Special == "冰霜" then PandaDB.BDK_A9 = not PandaDB.BDK_A9  This_A9 = PandaDB.BDK_A9 end
	  if Special == "邪恶" then PandaDB.XDK_A9 = not PandaDB.XDK_A9  This_A9 = PandaDB.XDK_A9 end 
end	  

if Class == "MAGE" then	  
	  if Special == "火焰" then PandaDB.HF_A9 = not PandaDB.HF_A9  This_A9 = PandaDB.HF_A9 end 
	  if Special == "冰霜" then PandaDB.BF_A9 = not PandaDB.BF_A9  This_A9 = PandaDB.BF_A9 end
	  if Special == "奥术" then PandaDB.AF_A9 = not PandaDB.AF_A9  This_A9 = PandaDB.AF_A9 end 
end	  

if Class == "PRIEST" then	  
	  if Special == "戒律" then PandaDB.JLM_A9 = not PandaDB.JLM_A9  This_A9 = PandaDB.JLM_A9 end 
	  if Special == "暗影" then PandaDB.AM_A9 = not PandaDB.AM_A9  This_A9 = PandaDB.AM_A9 end
	  if Special == "神圣" then PandaDB.shenM_A9 = not PandaDB.shenM_A9  This_A9 = PandaDB.shenM_A9 end 
end	  

if Class == "SHAMAN" then	  
	  if Special == "元素" then PandaDB.YSSM_A9 = not PandaDB.YSSM_A9  This_A9 = PandaDB.YSSM_A9 end 
	  if Special == "增强" then PandaDB.ZQSM_A9 = not PandaDB.ZQSM_A9  This_A9 = PandaDB.ZQSM_A9 end
	  if Special == "恢复" then PandaDB.HFSM_A9 = not PandaDB.HFSM_A9  This_A9 = PandaDB.HFSM_A9 end 
end	  

if Class == "WARRIOR" then	  
	  if Special == "防护" then PandaDB.FZ_A9 = not PandaDB.FZ_A9  This_A9 = PandaDB.FZ_A9 end 
	  if Special == "武器" then PandaDB.WQZ_A9 = not PandaDB.WQZ_A9  This_A9 = PandaDB.WQZ_A9 end
	  if Special == "狂怒" then PandaDB.KBZ_A9 = not PandaDB.KBZ_A9  This_A9 = PandaDB.KBZ_A9 end 
end	  

      if This_A9 ~= false then SpellTickButton_A9:SetText("|cffffe00a"..Spell_Key("A9").."")
	    elseif This_A9 == false then SpellTickButton_A9:SetText("|c00CDCDCD"..Spell_Key("A9").."")
	  end	  
	  
end)
	TreeListGroup:AddChild(SpellTickButton_A9)

	--A0
	local SpellTickButton_A0 = AceGUI:Create("Button")
	SpellTickButton_A0:SetRelativeWidth(1)
	SpellTickButton_A0.text:SetFont(SpellTickButton_A0.text:GetFont(),15)
	SpellTickButton_A0.text:SetJustifyH("LEFT")		
SpellTickButton_A0:SetCallback("OnClick", function() 

if Class=="DEMONHUNTER" then
	  if Special == "浩劫" then PandaDB.HJ_A0 = not PandaDB.HJ_A0  This_A0 = PandaDB.HJ_A0 end 
	  if Special == "复仇" then PandaDB.FC_A0 = not PandaDB.FC_A0  This_A0 = PandaDB.FC_A0 end
end  

if Class=="MONK" then
	  if Special == "酒仙" then PandaDB.JX_A0 = not PandaDB.JX_A0  This_A0 = PandaDB.JX_A0 end 
	  if Special == "踏风" then PandaDB.TAF_A0 = not PandaDB.TAF_A0  This_A0 = PandaDB.TAF_A0  end
	  if Special == "织雾" then PandaDB.ZW_A0 = not PandaDB.ZW_A0  This_A0 = PandaDB.ZW_A0 end 
end

if Class=="HUNTER" then	  
	  if Special == "野兽控制" then PandaDB.SW_A0 = not PandaDB.SW_A0  This_A0 = PandaDB.SW_A0 end 
	  if Special == "射击" then PandaDB.SJ_A0 = not PandaDB.SJ_A0  This_A0 = PandaDB.SJ_A0 end
	  if Special == "生存" then PandaDB.SC_A0 = not PandaDB.SC_A0  This_A0 = PandaDB.SC_A0 end 
end

if Class=="WARLOCK" then	  
	  if Special == "恶魔学识" then PandaDB.EMS_A0 = not PandaDB.EMS_A0  This_A0 = PandaDB.EMS_A0  end
	  if Special == "毁灭" then PandaDB.HMS_A0 = not PandaDB.HMS_A0  This_A0 = PandaDB.HMS_A0 end 
	  if Special == "痛苦" then PandaDB.TKS_A0 = not PandaDB.TKS_A0  This_A0 = PandaDB.TKS_A0 end 

end	  

if Class=="ROGUE" then
	  if Special == "奇袭" then PandaDB.QXZ_A0 = not PandaDB.QXZ_A0  This_A0 = PandaDB.QXZ_A0 end 
	  if Special == "敏锐" then PandaDB.MRZ_A0 = not PandaDB.MRZ_A0  This_A0 = PandaDB.MRZ_A0 end
	  if Special == "狂徒" then PandaDB.KTZ_A0 = not PandaDB.KTZ_A0  This_A0 = PandaDB.KTZ_A0 end 
end

if Class == "PALADIN" then	  
	  if Special == "防护" then PandaDB.FQ_A0 = not PandaDB.FQ_A0  This_A0 = PandaDB.FQ_A0 end 
	  if Special == "惩戒" then PandaDB.CJQ_A0 = not PandaDB.CJQ_A0  This_A0 = PandaDB.CJQ_A0 end
	  if Special == "神圣" then PandaDB.NQ_A0 = not PandaDB.NQ_A0  This_A0 = PandaDB.NQ_A0 end 
end	  
---
if Class == "DRUID" then	  
	  if Special == "平衡" then PandaDB.PHD_A0 = not PandaDB.PHD_A0  This_A0 = PandaDB.PHD_A0 end 
	  if Special == "野性" then PandaDB.MD_A0 = not PandaDB.MD_A0  This_A0 = PandaDB.MD_A0 end
	  if Special == "守护" then PandaDB.XD_A0 = not PandaDB.XD_A0  This_A0 = PandaDB.XD_A0 end 
	  if Special == "恢复" then PandaDB.ND_A0 = not PandaDB.ND_A0  This_A0 = PandaDB.ND_A0 end 
end	  

if Class == "DEATHKNIGHT" then	  
	  if Special == "鲜血" then PandaDB.DKT_A0 = not PandaDB.DKT_A0  This_A0 = PandaDB.DKT_A0 end 
	  if Special == "冰霜" then PandaDB.BDK_A0 = not PandaDB.BDK_A0  This_A0 = PandaDB.BDK_A0 end
	  if Special == "邪恶" then PandaDB.XDK_A0 = not PandaDB.XDK_A0  This_A0 = PandaDB.XDK_A0 end 
end	  

if Class == "MAGE" then	  
	  if Special == "火焰" then PandaDB.HF_A0 = not PandaDB.HF_A0  This_A0 = PandaDB.HF_A0 end 
	  if Special == "冰霜" then PandaDB.BF_A0 = not PandaDB.BF_A0  This_A0 = PandaDB.BF_A0 end
	  if Special == "奥术" then PandaDB.AF_A0 = not PandaDB.AF_A0  This_A0 = PandaDB.AF_A0 end 
end	  

if Class == "PRIEST" then	  
	  if Special == "戒律" then PandaDB.JLM_A0 = not PandaDB.JLM_A0  This_A0 = PandaDB.JLM_A0 end 
	  if Special == "暗影" then PandaDB.AM_A0 = not PandaDB.AM_A0  This_A0 = PandaDB.AM_A0 end
	  if Special == "神圣" then PandaDB.shenM_A0 = not PandaDB.shenM_A0  This_A0 = PandaDB.shenM_A0 end 
end	  

if Class == "SHAMAN" then	  
	  if Special == "元素" then PandaDB.YSSM_A0 = not PandaDB.YSSM_A0  This_A0 = PandaDB.YSSM_A0 end 
	  if Special == "增强" then PandaDB.ZQSM_A0 = not PandaDB.ZQSM_A0  This_A0 = PandaDB.ZQSM_A0 end
	  if Special == "恢复" then PandaDB.HFSM_A0 = not PandaDB.HFSM_A0  This_A0 = PandaDB.HFSM_A0 end 
end	  

if Class == "WARRIOR" then	  
	  if Special == "防护" then PandaDB.FZ_A0 = not PandaDB.FZ_A0  This_A0 = PandaDB.FZ_A0 end 
	  if Special == "武器" then PandaDB.WQZ_A0 = not PandaDB.WQZ_A0  This_A0 = PandaDB.WQZ_A0 end
	  if Special == "狂怒" then PandaDB.KBZ_A0 = not PandaDB.KBZ_A0  This_A0 = PandaDB.KBZ_A0 end 
end	  

      if This_A0 ~= false then SpellTickButton_A0:SetText("|cffffe00a"..Spell_Key("A0").."")
	    elseif This_A0 == false then SpellTickButton_A0:SetText("|c00CDCDCD"..Spell_Key("A0").."")
	  end	  
	  
	  
end)
	TreeListGroup:AddChild(SpellTickButton_A0)

	--C1
	local SpellTickButton_C1 = AceGUI:Create("Button")
	SpellTickButton_C1:SetRelativeWidth(1)
	SpellTickButton_C1.text:SetFont(SpellTickButton_C1.text:GetFont(),15)
	SpellTickButton_C1.text:SetJustifyH("LEFT")		
SpellTickButton_C1:SetCallback("OnClick", function() 
	  
if Class=="DEMONHUNTER" then
	  if Special == "浩劫" then PandaDB.HJ_C1 = not PandaDB.HJ_C1  This_C1 = PandaDB.HJ_C1 end 
	  if Special == "复仇" then PandaDB.FC_C1 = not PandaDB.FC_C1  This_C1 = PandaDB.FC_C1 end
end  

if Class=="MONK" then
	  if Special == "酒仙" then PandaDB.JX_C1 = not PandaDB.JX_C1  This_C1 = PandaDB.JX_C1 end 
	  if Special == "踏风" then PandaDB.TAF_C1 = not PandaDB.TAF_C1  This_C1 = PandaDB.TAF_C1  end
	  if Special == "织雾" then PandaDB.ZW_C1 = not PandaDB.ZW_C1  This_C1 = PandaDB.ZW_C1 end 
end

if Class=="HUNTER" then	  
	  if Special == "野兽控制" then PandaDB.SW_C1 = not PandaDB.SW_C1  This_C1 = PandaDB.SW_C1 end 
	  if Special == "射击" then PandaDB.SJ_C1 = not PandaDB.SJ_C1  This_C1 = PandaDB.SJ_C1 end
	  if Special == "生存" then PandaDB.SC_C1 = not PandaDB.SC_C1  This_C1 = PandaDB.SC_C1 end 
end

if Class=="WARLOCK" then	  
	  if Special == "恶魔学识" then PandaDB.EMS_C1 = not PandaDB.EMS_C1  This_C1 = PandaDB.EMS_C1  end
	  if Special == "毁灭" then PandaDB.HMS_C1 = not PandaDB.HMS_C1  This_C1 = PandaDB.HMS_C1 end 
	  if Special == "痛苦" then PandaDB.TKS_C1 = not PandaDB.TKS_C1  This_C1 = PandaDB.TKS_C1 end 

end	  

if Class=="ROGUE" then
	  if Special == "奇袭" then PandaDB.QXZ_C1 = not PandaDB.QXZ_C1  This_C1 = PandaDB.QXZ_C1 end 
	  if Special == "敏锐" then PandaDB.MRZ_C1 = not PandaDB.MRZ_C1  This_C1 = PandaDB.MRZ_C1 end
	  if Special == "狂徒" then PandaDB.KTZ_C1 = not PandaDB.KTZ_C1  This_C1 = PandaDB.KTZ_C1 end 
end

if Class == "PALADIN" then	  
	  if Special == "防护" then PandaDB.FQ_C1 = not PandaDB.FQ_C1  This_C1 = PandaDB.FQ_C1 end 
	  if Special == "惩戒" then PandaDB.CJQ_C1 = not PandaDB.CJQ_C1  This_C1 = PandaDB.CJQ_C1 end
	  if Special == "神圣" then PandaDB.NQ_C1 = not PandaDB.NQ_C1  This_C1 = PandaDB.NQ_C1 end 
end	  
---
if Class == "DRUID" then	  
	  if Special == "平衡" then PandaDB.PHD_C1 = not PandaDB.PHD_C1  This_C1 = PandaDB.PHD_C1 end 
	  if Special == "野性" then PandaDB.MD_C1 = not PandaDB.MD_C1  This_C1 = PandaDB.MD_C1 end
	  if Special == "守护" then PandaDB.XD_C1 = not PandaDB.XD_C1  This_C1 = PandaDB.XD_C1 end 
	  if Special == "恢复" then PandaDB.ND_C1 = not PandaDB.ND_C1  This_C1 = PandaDB.ND_C1 end 
end	  

if Class == "DEATHKNIGHT" then	  
	  if Special == "鲜血" then PandaDB.DKT_C1 = not PandaDB.DKT_C1  This_C1 = PandaDB.DKT_C1 end 
	  if Special == "冰霜" then PandaDB.BDK_C1 = not PandaDB.BDK_C1  This_C1 = PandaDB.BDK_C1 end
	  if Special == "邪恶" then PandaDB.XDK_C1 = not PandaDB.XDK_C1  This_C1 = PandaDB.XDK_C1 end 
end	  

if Class == "MAGE" then	  
	  if Special == "火焰" then PandaDB.HF_C1 = not PandaDB.HF_C1  This_C1 = PandaDB.HF_C1 end 
	  if Special == "冰霜" then PandaDB.BF_C1 = not PandaDB.BF_C1  This_C1 = PandaDB.BF_C1 end
	  if Special == "奥术" then PandaDB.AF_C1 = not PandaDB.AF_C1  This_C1 = PandaDB.AF_C1 end 
end	  

if Class == "PRIEST" then	  
	  if Special == "戒律" then PandaDB.JLM_C1 = not PandaDB.JLM_C1  This_C1 = PandaDB.JLM_C1 end 
	  if Special == "暗影" then PandaDB.AM_C1 = not PandaDB.AM_C1  This_C1 = PandaDB.AM_C1 end
	  if Special == "神圣" then PandaDB.shenM_C1 = not PandaDB.shenM_C1  This_C1 = PandaDB.shenM_C1 end 
end	  

if Class == "SHAMAN" then	  
	  if Special == "元素" then PandaDB.YSSM_C1 = not PandaDB.YSSM_C1  This_C1 = PandaDB.YSSM_C1 end 
	  if Special == "增强" then PandaDB.ZQSM_C1 = not PandaDB.ZQSM_C1  This_C1 = PandaDB.ZQSM_C1 end
	  if Special == "恢复" then PandaDB.HFSM_C1 = not PandaDB.HFSM_C1  This_C1 = PandaDB.HFSM_C1 end 
end	  

if Class == "WARRIOR" then	  
	  if Special == "防护" then PandaDB.FZ_C1 = not PandaDB.FZ_C1  This_C1 = PandaDB.FZ_C1 end 
	  if Special == "武器" then PandaDB.WQZ_C1 = not PandaDB.WQZ_C1  This_C1 = PandaDB.WQZ_C1 end
	  if Special == "狂怒" then PandaDB.KBZ_C1 = not PandaDB.KBZ_C1  This_C1 = PandaDB.KBZ_C1 end 
end	  

      if This_C1 ~= false then SpellTickButton_C1:SetText("|cffffe00a"..Spell_Key("C1").."")
	    elseif This_C1 == false then SpellTickButton_C1:SetText("|c00CDCDCD"..Spell_Key("C1").."")
	  end	  
	  
end)
	TreeListGroup:AddChild(SpellTickButton_C1)

	--C2
	local SpellTickButton_C2 = AceGUI:Create("Button")
	SpellTickButton_C2:SetRelativeWidth(1)
	SpellTickButton_C2.text:SetFont(SpellTickButton_C2.text:GetFont(),15)
	SpellTickButton_C2.text:SetJustifyH("LEFT")	
SpellTickButton_C2:SetCallback("OnClick", function() 
	  
if Class=="DEMONHUNTER" then
	  if Special == "浩劫" then PandaDB.HJ_C2 = not PandaDB.HJ_C2  This_C2 = PandaDB.HJ_C2 end 
	  if Special == "复仇" then PandaDB.FC_C2 = not PandaDB.FC_C2  This_C2 = PandaDB.FC_C2 end
end  

if Class=="MONK" then
	  if Special == "酒仙" then PandaDB.JX_C2 = not PandaDB.JX_C2  This_C2 = PandaDB.JX_C2 end 
	  if Special == "踏风" then PandaDB.TAF_C2 = not PandaDB.TAF_C2  This_C2 = PandaDB.TAF_C2  end
	  if Special == "织雾" then PandaDB.ZW_C2 = not PandaDB.ZW_C2  This_C2 = PandaDB.ZW_C2 end 
end

if Class=="HUNTER" then	  
	  if Special == "野兽控制" then PandaDB.SW_C2 = not PandaDB.SW_C2  This_C2 = PandaDB.SW_C2 end 
	  if Special == "射击" then PandaDB.SJ_C2 = not PandaDB.SJ_C2  This_C2 = PandaDB.SJ_C2 end
	  if Special == "生存" then PandaDB.SC_C2 = not PandaDB.SC_C2  This_C2 = PandaDB.SC_C2 end 
end

if Class=="WARLOCK" then	  
	  if Special == "恶魔学识" then PandaDB.EMS_C2 = not PandaDB.EMS_C2  This_C2 = PandaDB.EMS_C2  end
	  if Special == "毁灭" then PandaDB.HMS_C2 = not PandaDB.HMS_C2  This_C2 = PandaDB.HMS_C2 end 
	  if Special == "痛苦" then PandaDB.TKS_C2 = not PandaDB.TKS_C2  This_C2 = PandaDB.TKS_C2 end 

end	  

if Class=="ROGUE" then
	  if Special == "奇袭" then PandaDB.QXZ_C2 = not PandaDB.QXZ_C2  This_C2 = PandaDB.QXZ_C2 end 
	  if Special == "敏锐" then PandaDB.MRZ_C2 = not PandaDB.MRZ_C2  This_C2 = PandaDB.MRZ_C2 end
	  if Special == "狂徒" then PandaDB.KTZ_C2 = not PandaDB.KTZ_C2  This_C2 = PandaDB.KTZ_C2 end 
end

if Class == "PALADIN" then	  
	  if Special == "防护" then PandaDB.FQ_C2 = not PandaDB.FQ_C2  This_C2 = PandaDB.FQ_C2 end 
	  if Special == "惩戒" then PandaDB.CJQ_C2 = not PandaDB.CJQ_C2  This_C2 = PandaDB.CJQ_C2 end
	  if Special == "神圣" then PandaDB.NQ_C2 = not PandaDB.NQ_C2  This_C2 = PandaDB.NQ_C2 end 
end	  
---
if Class == "DRUID" then	  
	  if Special == "平衡" then PandaDB.PHD_C2 = not PandaDB.PHD_C2  This_C2 = PandaDB.PHD_C2 end 
	  if Special == "野性" then PandaDB.MD_C2 = not PandaDB.MD_C2  This_C2 = PandaDB.MD_C2 end
	  if Special == "守护" then PandaDB.XD_C2 = not PandaDB.XD_C2  This_C2 = PandaDB.XD_C2 end 
	  if Special == "恢复" then PandaDB.ND_C2 = not PandaDB.ND_C2  This_C2 = PandaDB.ND_C2 end 
end	  

if Class == "DEATHKNIGHT" then	  
	  if Special == "鲜血" then PandaDB.DKT_C2 = not PandaDB.DKT_C2  This_C2 = PandaDB.DKT_C2 end 
	  if Special == "冰霜" then PandaDB.BDK_C2 = not PandaDB.BDK_C2  This_C2 = PandaDB.BDK_C2 end
	  if Special == "邪恶" then PandaDB.XDK_C2 = not PandaDB.XDK_C2  This_C2 = PandaDB.XDK_C2 end 
end	  

if Class == "MAGE" then	  
	  if Special == "火焰" then PandaDB.HF_C2 = not PandaDB.HF_C2  This_C2 = PandaDB.HF_C2 end 
	  if Special == "冰霜" then PandaDB.BF_C2 = not PandaDB.BF_C2  This_C2 = PandaDB.BF_C2 end
	  if Special == "奥术" then PandaDB.AF_C2 = not PandaDB.AF_C2  This_C2 = PandaDB.AF_C2 end 
end	  

if Class == "PRIEST" then	  
	  if Special == "戒律" then PandaDB.JLM_C2 = not PandaDB.JLM_C2  This_C2 = PandaDB.JLM_C2 end 
	  if Special == "暗影" then PandaDB.AM_C2 = not PandaDB.AM_C2  This_C2 = PandaDB.AM_C2 end
	  if Special == "神圣" then PandaDB.shenM_C2 = not PandaDB.shenM_C2  This_C2 = PandaDB.shenM_C2 end 
end	  

if Class == "SHAMAN" then	  
	  if Special == "元素" then PandaDB.YSSM_C2 = not PandaDB.YSSM_C2  This_C2 = PandaDB.YSSM_C2 end 
	  if Special == "增强" then PandaDB.ZQSM_C2 = not PandaDB.ZQSM_C2  This_C2 = PandaDB.ZQSM_C2 end
	  if Special == "恢复" then PandaDB.HFSM_C2 = not PandaDB.HFSM_C2  This_C2 = PandaDB.HFSM_C2 end 
end	  

if Class == "WARRIOR" then	  
	  if Special == "防护" then PandaDB.FZ_C2 = not PandaDB.FZ_C2  This_C2 = PandaDB.FZ_C2 end 
	  if Special == "武器" then PandaDB.WQZ_C2 = not PandaDB.WQZ_C2  This_C2 = PandaDB.WQZ_C2 end
	  if Special == "狂怒" then PandaDB.KBZ_C2 = not PandaDB.KBZ_C2  This_C2 = PandaDB.KBZ_C2 end 
end	  

      if This_C2 ~= false then SpellTickButton_C2:SetText("|cffffe00a"..Spell_Key("C2").."")
	    elseif This_C2 == false then SpellTickButton_C2:SetText("|c00CDCDCD"..Spell_Key("C2").."")
	  end	  
	  
end)
	TreeListGroup:AddChild(SpellTickButton_C2)

	--C3
	local SpellTickButton_C3 = AceGUI:Create("Button")
	SpellTickButton_C3:SetRelativeWidth(1)
	SpellTickButton_C3.text:SetFont(SpellTickButton_C3.text:GetFont(),15)
	SpellTickButton_C3.text:SetJustifyH("LEFT")		
SpellTickButton_C3:SetCallback("OnClick", function() 
		
if Class=="DEMONHUNTER" then
	  if Special == "浩劫" then PandaDB.HJ_C3 = not PandaDB.HJ_C3  This_C3 = PandaDB.HJ_C3 end 
	  if Special == "复仇" then PandaDB.FC_C3 = not PandaDB.FC_C3  This_C3 = PandaDB.FC_C3 end
end  

if Class=="MONK" then
	  if Special == "酒仙" then PandaDB.JX_C3 = not PandaDB.JX_C3  This_C3 = PandaDB.JX_C3 end 
	  if Special == "踏风" then PandaDB.TAF_C3 = not PandaDB.TAF_C3  This_C3 = PandaDB.TAF_C3  end
	  if Special == "织雾" then PandaDB.ZW_C3 = not PandaDB.ZW_C3  This_C3 = PandaDB.ZW_C3 end 
end

if Class=="HUNTER" then	  
	  if Special == "野兽控制" then PandaDB.SW_C3 = not PandaDB.SW_C3  This_C3 = PandaDB.SW_C3 end 
	  if Special == "射击" then PandaDB.SJ_C3 = not PandaDB.SJ_C3  This_C3 = PandaDB.SJ_C3 end
	  if Special == "生存" then PandaDB.SC_C3 = not PandaDB.SC_C3  This_C3 = PandaDB.SC_C3 end 
end

if Class=="WARLOCK" then	  
	  if Special == "恶魔学识" then PandaDB.EMS_C3 = not PandaDB.EMS_C3  This_C3 = PandaDB.EMS_C3  end
	  if Special == "毁灭" then PandaDB.HMS_C3 = not PandaDB.HMS_C3  This_C3 = PandaDB.HMS_C3 end 
	  if Special == "痛苦" then PandaDB.TKS_C3 = not PandaDB.TKS_C3  This_C3 = PandaDB.TKS_C3 end 

end	  

if Class=="ROGUE" then
	  if Special == "奇袭" then PandaDB.QXZ_C3 = not PandaDB.QXZ_C3  This_C3 = PandaDB.QXZ_C3 end 
	  if Special == "敏锐" then PandaDB.MRZ_C3 = not PandaDB.MRZ_C3  This_C3 = PandaDB.MRZ_C3 end
	  if Special == "狂徒" then PandaDB.KTZ_C3 = not PandaDB.KTZ_C3  This_C3 = PandaDB.KTZ_C3 end 
end

if Class == "PALADIN" then	  
	  if Special == "防护" then PandaDB.FQ_C3 = not PandaDB.FQ_C3  This_C3 = PandaDB.FQ_C3 end 
	  if Special == "惩戒" then PandaDB.CJQ_C3 = not PandaDB.CJQ_C3  This_C3 = PandaDB.CJQ_C3 end
	  if Special == "神圣" then PandaDB.NQ_C3 = not PandaDB.NQ_C3  This_C3 = PandaDB.NQ_C3 end 
end	  
---
if Class == "DRUID" then	  
	  if Special == "平衡" then PandaDB.PHD_C3 = not PandaDB.PHD_C3  This_C3 = PandaDB.PHD_C3 end 
	  if Special == "野性" then PandaDB.MD_C3 = not PandaDB.MD_C3  This_C3 = PandaDB.MD_C3 end
	  if Special == "守护" then PandaDB.XD_C3 = not PandaDB.XD_C3  This_C3 = PandaDB.XD_C3 end 
	  if Special == "恢复" then PandaDB.ND_C3 = not PandaDB.ND_C3  This_C3 = PandaDB.ND_C3 end 
end	  

if Class == "DEATHKNIGHT" then	  
	  if Special == "鲜血" then PandaDB.DKT_C3 = not PandaDB.DKT_C3  This_C3 = PandaDB.DKT_C3 end 
	  if Special == "冰霜" then PandaDB.BDK_C3 = not PandaDB.BDK_C3  This_C3 = PandaDB.BDK_C3 end
	  if Special == "邪恶" then PandaDB.XDK_C3 = not PandaDB.XDK_C3  This_C3 = PandaDB.XDK_C3 end 
end	  

if Class == "MAGE" then	  
	  if Special == "火焰" then PandaDB.HF_C3 = not PandaDB.HF_C3  This_C3 = PandaDB.HF_C3 end 
	  if Special == "冰霜" then PandaDB.BF_C3 = not PandaDB.BF_C3  This_C3 = PandaDB.BF_C3 end
	  if Special == "奥术" then PandaDB.AF_C3 = not PandaDB.AF_C3  This_C3 = PandaDB.AF_C3 end 
end	  

if Class == "PRIEST" then	  
	  if Special == "戒律" then PandaDB.JLM_C3 = not PandaDB.JLM_C3  This_C3 = PandaDB.JLM_C3 end 
	  if Special == "暗影" then PandaDB.AM_C3 = not PandaDB.AM_C3  This_C3 = PandaDB.AM_C3 end
	  if Special == "神圣" then PandaDB.shenM_C3 = not PandaDB.shenM_C3  This_C3 = PandaDB.shenM_C3 end 
end	  

if Class == "SHAMAN" then	  
	  if Special == "元素" then PandaDB.YSSM_C3 = not PandaDB.YSSM_C3  This_C3 = PandaDB.YSSM_C3 end 
	  if Special == "增强" then PandaDB.ZQSM_C3 = not PandaDB.ZQSM_C3  This_C3 = PandaDB.ZQSM_C3 end
	  if Special == "恢复" then PandaDB.HFSM_C3 = not PandaDB.HFSM_C3  This_C3 = PandaDB.HFSM_C3 end 
end	  

if Class == "WARRIOR" then	  
	  if Special == "防护" then PandaDB.FZ_C3 = not PandaDB.FZ_C3  This_C3 = PandaDB.FZ_C3 end 
	  if Special == "武器" then PandaDB.WQZ_C3 = not PandaDB.WQZ_C3  This_C3 = PandaDB.WQZ_C3 end
	  if Special == "狂怒" then PandaDB.KBZ_C3 = not PandaDB.KBZ_C3  This_C3 = PandaDB.KBZ_C3 end 
end	  

      if This_C3 ~= false then SpellTickButton_C3:SetText("|cffffe00a"..Spell_Key("C3").."")
	    elseif This_C3 == false then SpellTickButton_C3:SetText("|c00CDCDCD"..Spell_Key("C3").."")
	  end	  
	  
	  
end)
	TreeListGroup:AddChild(SpellTickButton_C3)
	
	--C4
	local SpellTickButton_C4 = AceGUI:Create("Button")
	SpellTickButton_C4:SetRelativeWidth(1)
	SpellTickButton_C4.text:SetFont(SpellTickButton_C4.text:GetFont(),15)
	SpellTickButton_C4.text:SetJustifyH("LEFT")		
SpellTickButton_C4:SetCallback("OnClick", function() 
	  
if Class=="DEMONHUNTER" then
	  if Special == "浩劫" then PandaDB.HJ_C4 = not PandaDB.HJ_C4  This_C4 = PandaDB.HJ_C4 end 
	  if Special == "复仇" then PandaDB.FC_C4 = not PandaDB.FC_C4  This_C4 = PandaDB.FC_C4 end
end  

if Class=="MONK" then
	  if Special == "酒仙" then PandaDB.JX_C4 = not PandaDB.JX_C4  This_C4 = PandaDB.JX_C4 end 
	  if Special == "踏风" then PandaDB.TAF_C4 = not PandaDB.TAF_C4  This_C4 = PandaDB.TAF_C4  end
	  if Special == "织雾" then PandaDB.ZW_C4 = not PandaDB.ZW_C4  This_C4 = PandaDB.ZW_C4 end 
end

if Class=="HUNTER" then	  
	  if Special == "野兽控制" then PandaDB.SW_C4 = not PandaDB.SW_C4  This_C4 = PandaDB.SW_C4 end 
	  if Special == "射击" then PandaDB.SJ_C4 = not PandaDB.SJ_C4  This_C4 = PandaDB.SJ_C4 end
	  if Special == "生存" then PandaDB.SC_C4 = not PandaDB.SC_C4  This_C4 = PandaDB.SC_C4 end 
end

if Class=="WARLOCK" then	  
	  if Special == "恶魔学识" then PandaDB.EMS_C4 = not PandaDB.EMS_C4  This_C4 = PandaDB.EMS_C4  end
	  if Special == "毁灭" then PandaDB.HMS_C4 = not PandaDB.HMS_C4  This_C4 = PandaDB.HMS_C4 end 
	  if Special == "痛苦" then PandaDB.TKS_C4 = not PandaDB.TKS_C4  This_C4 = PandaDB.TKS_C4 end 

end	  

if Class=="ROGUE" then
	  if Special == "奇袭" then PandaDB.QXZ_C4 = not PandaDB.QXZ_C4  This_C4 = PandaDB.QXZ_C4 end 
	  if Special == "敏锐" then PandaDB.MRZ_C4 = not PandaDB.MRZ_C4  This_C4 = PandaDB.MRZ_C4 end
	  if Special == "狂徒" then PandaDB.KTZ_C4 = not PandaDB.KTZ_C4  This_C4 = PandaDB.KTZ_C4 end 
end

if Class == "PALADIN" then	  
	  if Special == "防护" then PandaDB.FQ_C4 = not PandaDB.FQ_C4  This_C4 = PandaDB.FQ_C4 end 
	  if Special == "惩戒" then PandaDB.CJQ_C4 = not PandaDB.CJQ_C4  This_C4 = PandaDB.CJQ_C4 end
	  if Special == "神圣" then PandaDB.NQ_C4 = not PandaDB.NQ_C4  This_C4 = PandaDB.NQ_C4 end 
end	  
---
if Class == "DRUID" then	  
	  if Special == "平衡" then PandaDB.PHD_C4 = not PandaDB.PHD_C4  This_C4 = PandaDB.PHD_C4 end 
	  if Special == "野性" then PandaDB.MD_C4 = not PandaDB.MD_C4  This_C4 = PandaDB.MD_C4 end
	  if Special == "守护" then PandaDB.XD_C4 = not PandaDB.XD_C4  This_C4 = PandaDB.XD_C4 end 
	  if Special == "恢复" then PandaDB.ND_C4 = not PandaDB.ND_C4  This_C4 = PandaDB.ND_C4 end 
end	  

if Class == "DEATHKNIGHT" then	  
	  if Special == "鲜血" then PandaDB.DKT_C4 = not PandaDB.DKT_C4  This_C4 = PandaDB.DKT_C4 end 
	  if Special == "冰霜" then PandaDB.BDK_C4 = not PandaDB.BDK_C4  This_C4 = PandaDB.BDK_C4 end
	  if Special == "邪恶" then PandaDB.XDK_C4 = not PandaDB.XDK_C4  This_C4 = PandaDB.XDK_C4 end 
end	  

if Class == "MAGE" then	  
	  if Special == "火焰" then PandaDB.HF_C4 = not PandaDB.HF_C4  This_C4 = PandaDB.HF_C4 end 
	  if Special == "冰霜" then PandaDB.BF_C4 = not PandaDB.BF_C4  This_C4 = PandaDB.BF_C4 end
	  if Special == "奥术" then PandaDB.AF_C4 = not PandaDB.AF_C4  This_C4 = PandaDB.AF_C4 end 
end	  

if Class == "PRIEST" then	  
	  if Special == "戒律" then PandaDB.JLM_C4 = not PandaDB.JLM_C4  This_C4 = PandaDB.JLM_C4 end 
	  if Special == "暗影" then PandaDB.AM_C4 = not PandaDB.AM_C4  This_C4 = PandaDB.AM_C4 end
	  if Special == "神圣" then PandaDB.shenM_C4 = not PandaDB.shenM_C4  This_C4 = PandaDB.shenM_C4 end 
end	  

if Class == "SHAMAN" then	  
	  if Special == "元素" then PandaDB.YSSM_C4 = not PandaDB.YSSM_C4  This_C4 = PandaDB.YSSM_C4 end 
	  if Special == "增强" then PandaDB.ZQSM_C4 = not PandaDB.ZQSM_C4  This_C4 = PandaDB.ZQSM_C4 end
	  if Special == "恢复" then PandaDB.HFSM_C4 = not PandaDB.HFSM_C4  This_C4 = PandaDB.HFSM_C4 end 
end	  

if Class == "WARRIOR" then	  
	  if Special == "防护" then PandaDB.FZ_C4 = not PandaDB.FZ_C4  This_C4 = PandaDB.FZ_C4 end 
	  if Special == "武器" then PandaDB.WQZ_C4 = not PandaDB.WQZ_C4  This_C4 = PandaDB.WQZ_C4 end
	  if Special == "狂怒" then PandaDB.KBZ_C4 = not PandaDB.KBZ_C4  This_C4 = PandaDB.KBZ_C4 end 
end	  

      if This_C4 ~= false then SpellTickButton_C4:SetText("|cffffe00a"..Spell_Key("C4").."")
	    elseif This_C4 == false then SpellTickButton_C4:SetText("|c00CDCDCD"..Spell_Key("C4").."")
	  end	  
	   
end)
	TreeListGroup:AddChild(SpellTickButton_C4)

	--C5
    local SpellTickButton_C5 = AceGUI:Create("Button")
	SpellTickButton_C5:SetRelativeWidth(1)
	SpellTickButton_C5.text:SetFont(SpellTickButton_C5.text:GetFont(),15)
	SpellTickButton_C5.text:SetJustifyH("LEFT")			
SpellTickButton_C5:SetCallback("OnClick", function() 
	 
if Class=="DEMONHUNTER" then
	  if Special == "浩劫" then PandaDB.HJ_C5 = not PandaDB.HJ_C5  This_C5 = PandaDB.HJ_C5 end 
	  if Special == "复仇" then PandaDB.FC_C5 = not PandaDB.FC_C5  This_C5 = PandaDB.FC_C5 end
end  

if Class=="MONK" then
	  if Special == "酒仙" then PandaDB.JX_C5 = not PandaDB.JX_C5  This_C5 = PandaDB.JX_C5 end 
	  if Special == "踏风" then PandaDB.TAF_C5 = not PandaDB.TAF_C5  This_C5 = PandaDB.TAF_C5  end
	  if Special == "织雾" then PandaDB.ZW_C5 = not PandaDB.ZW_C5  This_C5 = PandaDB.ZW_C5 end 
end

if Class=="HUNTER" then	  
	  if Special == "野兽控制" then PandaDB.SW_C5 = not PandaDB.SW_C5  This_C5 = PandaDB.SW_C5 end 
	  if Special == "射击" then PandaDB.SJ_C5 = not PandaDB.SJ_C5  This_C5 = PandaDB.SJ_C5 end
	  if Special == "生存" then PandaDB.SC_C5 = not PandaDB.SC_C5  This_C5 = PandaDB.SC_C5 end 
end

if Class=="WARLOCK" then	  
	  if Special == "恶魔学识" then PandaDB.EMS_C5 = not PandaDB.EMS_C5  This_C5 = PandaDB.EMS_C5  end
	  if Special == "毁灭" then PandaDB.HMS_C5 = not PandaDB.HMS_C5  This_C5 = PandaDB.HMS_C5 end 
	  if Special == "痛苦" then PandaDB.TKS_C5 = not PandaDB.TKS_C5  This_C5 = PandaDB.TKS_C5 end 

end	  

if Class=="ROGUE" then
	  if Special == "奇袭" then PandaDB.QXZ_C5 = not PandaDB.QXZ_C5  This_C5 = PandaDB.QXZ_C5 end 
	  if Special == "敏锐" then PandaDB.MRZ_C5 = not PandaDB.MRZ_C5  This_C5 = PandaDB.MRZ_C5 end
	  if Special == "狂徒" then PandaDB.KTZ_C5 = not PandaDB.KTZ_C5  This_C5 = PandaDB.KTZ_C5 end 
end

if Class == "PALADIN" then	  
	  if Special == "防护" then PandaDB.FQ_C5 = not PandaDB.FQ_C5  This_C5 = PandaDB.FQ_C5 end 
	  if Special == "惩戒" then PandaDB.CJQ_C5 = not PandaDB.CJQ_C5  This_C5 = PandaDB.CJQ_C5 end
	  if Special == "神圣" then PandaDB.NQ_C5 = not PandaDB.NQ_C5  This_C5 = PandaDB.NQ_C5 end 
end	  
---
if Class == "DRUID" then	  
	  if Special == "平衡" then PandaDB.PHD_C5 = not PandaDB.PHD_C5  This_C5 = PandaDB.PHD_C5 end 
	  if Special == "野性" then PandaDB.MD_C5 = not PandaDB.MD_C5  This_C5 = PandaDB.MD_C5 end
	  if Special == "守护" then PandaDB.XD_C5 = not PandaDB.XD_C5  This_C5 = PandaDB.XD_C5 end 
	  if Special == "恢复" then PandaDB.ND_C5 = not PandaDB.ND_C5  This_C5 = PandaDB.ND_C5 end 
end	  

if Class == "DEATHKNIGHT" then	  
	  if Special == "鲜血" then PandaDB.DKT_C5 = not PandaDB.DKT_C5  This_C5 = PandaDB.DKT_C5 end 
	  if Special == "冰霜" then PandaDB.BDK_C5 = not PandaDB.BDK_C5  This_C5 = PandaDB.BDK_C5 end
	  if Special == "邪恶" then PandaDB.XDK_C5 = not PandaDB.XDK_C5  This_C5 = PandaDB.XDK_C5 end 
end	  

if Class == "MAGE" then	  
	  if Special == "火焰" then PandaDB.HF_C5 = not PandaDB.HF_C5  This_C5 = PandaDB.HF_C5 end 
	  if Special == "冰霜" then PandaDB.BF_C5 = not PandaDB.BF_C5  This_C5 = PandaDB.BF_C5 end
	  if Special == "奥术" then PandaDB.AF_C5 = not PandaDB.AF_C5  This_C5 = PandaDB.AF_C5 end 
end	  

if Class == "PRIEST" then	  
	  if Special == "戒律" then PandaDB.JLM_C5 = not PandaDB.JLM_C5  This_C5 = PandaDB.JLM_C5 end 
	  if Special == "暗影" then PandaDB.AM_C5 = not PandaDB.AM_C5  This_C5 = PandaDB.AM_C5 end
	  if Special == "神圣" then PandaDB.shenM_C5 = not PandaDB.shenM_C5  This_C5 = PandaDB.shenM_C5 end 
end	  

if Class == "SHAMAN" then	  
	  if Special == "元素" then PandaDB.YSSM_C5 = not PandaDB.YSSM_C5  This_C5 = PandaDB.YSSM_C5 end 
	  if Special == "增强" then PandaDB.ZQSM_C5 = not PandaDB.ZQSM_C5  This_C5 = PandaDB.ZQSM_C5 end
	  if Special == "恢复" then PandaDB.HFSM_C5 = not PandaDB.HFSM_C5  This_C5 = PandaDB.HFSM_C5 end 
end	  

if Class == "WARRIOR" then	  
	  if Special == "防护" then PandaDB.FZ_C5 = not PandaDB.FZ_C5  This_C5 = PandaDB.FZ_C5 end 
	  if Special == "武器" then PandaDB.WQZ_C5 = not PandaDB.WQZ_C5  This_C5 = PandaDB.WQZ_C5 end
	  if Special == "狂怒" then PandaDB.KBZ_C5 = not PandaDB.KBZ_C5  This_C5 = PandaDB.KBZ_C5 end 
end	  

      if This_C5 ~= false then SpellTickButton_C5:SetText("|cffffe00a"..Spell_Key("C5").."")
	    elseif This_C5 == false then SpellTickButton_C5:SetText("|c00CDCDCD"..Spell_Key("C5").."")
	  end	 
	  
end)
	TreeListGroup:AddChild(SpellTickButton_C5)

	--C6
	local SpellTickButton_C6 = AceGUI:Create("Button")
	SpellTickButton_C6:SetRelativeWidth(1)
	SpellTickButton_C6.text:SetFont(SpellTickButton_C6.text:GetFont(),15)
	SpellTickButton_C6.text:SetJustifyH("LEFT")		
SpellTickButton_C6:SetCallback("OnClick", function() 
	  
if Class=="DEMONHUNTER" then
	  if Special == "浩劫" then PandaDB.HJ_C6 = not PandaDB.HJ_C6  This_C6 = PandaDB.HJ_C6 end 
	  if Special == "复仇" then PandaDB.FC_C6 = not PandaDB.FC_C6  This_C6 = PandaDB.FC_C6 end
end  

if Class=="MONK" then
	  if Special == "酒仙" then PandaDB.JX_C6 = not PandaDB.JX_C6  This_C6 = PandaDB.JX_C6 end 
	  if Special == "踏风" then PandaDB.TAF_C6 = not PandaDB.TAF_C6  This_C6 = PandaDB.TAF_C6  end
	  if Special == "织雾" then PandaDB.ZW_C6 = not PandaDB.ZW_C6  This_C6 = PandaDB.ZW_C6 end 
end

if Class=="HUNTER" then	  
	  if Special == "野兽控制" then PandaDB.SW_C6 = not PandaDB.SW_C6  This_C6 = PandaDB.SW_C6 end 
	  if Special == "射击" then PandaDB.SJ_C6 = not PandaDB.SJ_C6  This_C6 = PandaDB.SJ_C6 end
	  if Special == "生存" then PandaDB.SC_C6 = not PandaDB.SC_C6  This_C6 = PandaDB.SC_C6 end 
end

if Class=="WARLOCK" then	  
	  if Special == "恶魔学识" then PandaDB.EMS_C6 = not PandaDB.EMS_C6  This_C6 = PandaDB.EMS_C6  end
	  if Special == "毁灭" then PandaDB.HMS_C6 = not PandaDB.HMS_C6  This_C6 = PandaDB.HMS_C6 end 
	  if Special == "痛苦" then PandaDB.TKS_C6 = not PandaDB.TKS_C6  This_C6 = PandaDB.TKS_C6 end 

end	  

if Class=="ROGUE" then
	  if Special == "奇袭" then PandaDB.QXZ_C6 = not PandaDB.QXZ_C6  This_C6 = PandaDB.QXZ_C6 end 
	  if Special == "敏锐" then PandaDB.MRZ_C6 = not PandaDB.MRZ_C6  This_C6 = PandaDB.MRZ_C6 end
	  if Special == "狂徒" then PandaDB.KTZ_C6 = not PandaDB.KTZ_C6  This_C6 = PandaDB.KTZ_C6 end 
end

if Class == "PALADIN" then	  
	  if Special == "防护" then PandaDB.FQ_C6 = not PandaDB.FQ_C6  This_C6 = PandaDB.FQ_C6 end 
	  if Special == "惩戒" then PandaDB.CJQ_C6 = not PandaDB.CJQ_C6  This_C6 = PandaDB.CJQ_C6 end
	  if Special == "神圣" then PandaDB.NQ_C6 = not PandaDB.NQ_C6  This_C6 = PandaDB.NQ_C6 end 
end	  
---
if Class == "DRUID" then	  
	  if Special == "平衡" then PandaDB.PHD_C6 = not PandaDB.PHD_C6  This_C6 = PandaDB.PHD_C6 end 
	  if Special == "野性" then PandaDB.MD_C6 = not PandaDB.MD_C6  This_C6 = PandaDB.MD_C6 end
	  if Special == "守护" then PandaDB.XD_C6 = not PandaDB.XD_C6  This_C6 = PandaDB.XD_C6 end 
	  if Special == "恢复" then PandaDB.ND_C6 = not PandaDB.ND_C6  This_C6 = PandaDB.ND_C6 end 
end	  

if Class == "DEATHKNIGHT" then	  
	  if Special == "鲜血" then PandaDB.DKT_C6 = not PandaDB.DKT_C6  This_C6 = PandaDB.DKT_C6 end 
	  if Special == "冰霜" then PandaDB.BDK_C6 = not PandaDB.BDK_C6  This_C6 = PandaDB.BDK_C6 end
	  if Special == "邪恶" then PandaDB.XDK_C6 = not PandaDB.XDK_C6  This_C6 = PandaDB.XDK_C6 end 
end	  

if Class == "MAGE" then	  
	  if Special == "火焰" then PandaDB.HF_C6 = not PandaDB.HF_C6  This_C6 = PandaDB.HF_C6 end 
	  if Special == "冰霜" then PandaDB.BF_C6 = not PandaDB.BF_C6  This_C6 = PandaDB.BF_C6 end
	  if Special == "奥术" then PandaDB.AF_C6 = not PandaDB.AF_C6  This_C6 = PandaDB.AF_C6 end 
end	  

if Class == "PRIEST" then	  
	  if Special == "戒律" then PandaDB.JLM_C6 = not PandaDB.JLM_C6  This_C6 = PandaDB.JLM_C6 end 
	  if Special == "暗影" then PandaDB.AM_C6 = not PandaDB.AM_C6  This_C6 = PandaDB.AM_C6 end
	  if Special == "神圣" then PandaDB.shenM_C6 = not PandaDB.shenM_C6  This_C6 = PandaDB.shenM_C6 end 
end	  

if Class == "SHAMAN" then	  
	  if Special == "元素" then PandaDB.YSSM_C6 = not PandaDB.YSSM_C6  This_C6 = PandaDB.YSSM_C6 end 
	  if Special == "增强" then PandaDB.ZQSM_C6 = not PandaDB.ZQSM_C6  This_C6 = PandaDB.ZQSM_C6 end
	  if Special == "恢复" then PandaDB.HFSM_C6 = not PandaDB.HFSM_C6  This_C6 = PandaDB.HFSM_C6 end 
end	  

if Class == "WARRIOR" then	  
	  if Special == "防护" then PandaDB.FZ_C6 = not PandaDB.FZ_C6  This_C6 = PandaDB.FZ_C6 end 
	  if Special == "武器" then PandaDB.WQZ_C6 = not PandaDB.WQZ_C6  This_C6 = PandaDB.WQZ_C6 end
	  if Special == "狂怒" then PandaDB.KBZ_C6 = not PandaDB.KBZ_C6  This_C6 = PandaDB.KBZ_C6 end 
end	  

      if This_C6 ~= false then SpellTickButton_C6:SetText("|cffffe00a"..Spell_Key("C6").."")
	    elseif This_C6 == false then SpellTickButton_C6:SetText("|c00CDCDCD"..Spell_Key("C6").."")
	  end	  
	  
end)
	TreeListGroup:AddChild(SpellTickButton_C6)

	--C7
	local SpellTickButton_C7 = AceGUI:Create("Button")
	SpellTickButton_C7:SetRelativeWidth(1)
	SpellTickButton_C7.text:SetFont(SpellTickButton_C7.text:GetFont(),15)
	SpellTickButton_C7.text:SetJustifyH("LEFT")		
SpellTickButton_C7:SetCallback("OnClick", function() 
	  
if Class=="DEMONHUNTER" then
	  if Special == "浩劫" then PandaDB.HJ_C7 = not PandaDB.HJ_C7  This_C7 = PandaDB.HJ_C7 end 
	  if Special == "复仇" then PandaDB.FC_C7 = not PandaDB.FC_C7  This_C7 = PandaDB.FC_C7 end
end  

if Class=="MONK" then
	  if Special == "酒仙" then PandaDB.JX_C7 = not PandaDB.JX_C7  This_C7 = PandaDB.JX_C7 end 
	  if Special == "踏风" then PandaDB.TAF_C7 = not PandaDB.TAF_C7  This_C7 = PandaDB.TAF_C7  end
	  if Special == "织雾" then PandaDB.ZW_C7 = not PandaDB.ZW_C7  This_C7 = PandaDB.ZW_C7 end 
end

if Class=="HUNTER" then	  
	  if Special == "野兽控制" then PandaDB.SW_C7 = not PandaDB.SW_C7  This_C7 = PandaDB.SW_C7 end 
	  if Special == "射击" then PandaDB.SJ_C7 = not PandaDB.SJ_C7  This_C7 = PandaDB.SJ_C7 end
	  if Special == "生存" then PandaDB.SC_C7 = not PandaDB.SC_C7  This_C7 = PandaDB.SC_C7 end 
end

if Class=="WARLOCK" then	  
	  if Special == "恶魔学识" then PandaDB.EMS_C7 = not PandaDB.EMS_C7  This_C7 = PandaDB.EMS_C7  end
	  if Special == "毁灭" then PandaDB.HMS_C7 = not PandaDB.HMS_C7  This_C7 = PandaDB.HMS_C7 end 
	  if Special == "痛苦" then PandaDB.TKS_C7 = not PandaDB.TKS_C7  This_C7 = PandaDB.TKS_C7 end 

end	  

if Class=="ROGUE" then
	  if Special == "奇袭" then PandaDB.QXZ_C7 = not PandaDB.QXZ_C7  This_C7 = PandaDB.QXZ_C7 end 
	  if Special == "敏锐" then PandaDB.MRZ_C7 = not PandaDB.MRZ_C7  This_C7 = PandaDB.MRZ_C7 end
	  if Special == "狂徒" then PandaDB.KTZ_C7 = not PandaDB.KTZ_C7  This_C7 = PandaDB.KTZ_C7 end 
end

if Class == "PALADIN" then	  
	  if Special == "防护" then PandaDB.FQ_C7 = not PandaDB.FQ_C7  This_C7 = PandaDB.FQ_C7 end 
	  if Special == "惩戒" then PandaDB.CJQ_C7 = not PandaDB.CJQ_C7  This_C7 = PandaDB.CJQ_C7 end
	  if Special == "神圣" then PandaDB.NQ_C7 = not PandaDB.NQ_C7  This_C7 = PandaDB.NQ_C7 end 
end	  
---
if Class == "DRUID" then	  
	  if Special == "平衡" then PandaDB.PHD_C7 = not PandaDB.PHD_C7  This_C7 = PandaDB.PHD_C7 end 
	  if Special == "野性" then PandaDB.MD_C7 = not PandaDB.MD_C7  This_C7 = PandaDB.MD_C7 end
	  if Special == "守护" then PandaDB.XD_C7 = not PandaDB.XD_C7  This_C7 = PandaDB.XD_C7 end 
	  if Special == "恢复" then PandaDB.ND_C7 = not PandaDB.ND_C7  This_C7 = PandaDB.ND_C7 end 
end	  

if Class == "DEATHKNIGHT" then	  
	  if Special == "鲜血" then PandaDB.DKT_C7 = not PandaDB.DKT_C7  This_C7 = PandaDB.DKT_C7 end 
	  if Special == "冰霜" then PandaDB.BDK_C7 = not PandaDB.BDK_C7  This_C7 = PandaDB.BDK_C7 end
	  if Special == "邪恶" then PandaDB.XDK_C7 = not PandaDB.XDK_C7  This_C7 = PandaDB.XDK_C7 end 
end	  

if Class == "MAGE" then	  
	  if Special == "火焰" then PandaDB.HF_C7 = not PandaDB.HF_C7  This_C7 = PandaDB.HF_C7 end 
	  if Special == "冰霜" then PandaDB.BF_C7 = not PandaDB.BF_C7  This_C7 = PandaDB.BF_C7 end
	  if Special == "奥术" then PandaDB.AF_C7 = not PandaDB.AF_C7  This_C7 = PandaDB.AF_C7 end 
end	  

if Class == "PRIEST" then	  
	  if Special == "戒律" then PandaDB.JLM_C7 = not PandaDB.JLM_C7  This_C7 = PandaDB.JLM_C7 end 
	  if Special == "暗影" then PandaDB.AM_C7 = not PandaDB.AM_C7  This_C7 = PandaDB.AM_C7 end
	  if Special == "神圣" then PandaDB.shenM_C7 = not PandaDB.shenM_C7  This_C7 = PandaDB.shenM_C7 end 
end	  

if Class == "SHAMAN" then	  
	  if Special == "元素" then PandaDB.YSSM_C7 = not PandaDB.YSSM_C7  This_C7 = PandaDB.YSSM_C7 end 
	  if Special == "增强" then PandaDB.ZQSM_C7 = not PandaDB.ZQSM_C7  This_C7 = PandaDB.ZQSM_C7 end
	  if Special == "恢复" then PandaDB.HFSM_C7 = not PandaDB.HFSM_C7  This_C7 = PandaDB.HFSM_C7 end 
end	  

if Class == "WARRIOR" then	  
	  if Special == "防护" then PandaDB.FZ_C7 = not PandaDB.FZ_C7  This_C7 = PandaDB.FZ_C7 end 
	  if Special == "武器" then PandaDB.WQZ_C7 = not PandaDB.WQZ_C7  This_C7 = PandaDB.WQZ_C7 end
	  if Special == "狂怒" then PandaDB.KBZ_C7 = not PandaDB.KBZ_C7  This_C7 = PandaDB.KBZ_C7 end 
end	  

      if This_C7 ~= false then SpellTickButton_C7:SetText("|cffffe00a"..Spell_Key("C7").."")
	    elseif This_C7 == false then SpellTickButton_C7:SetText("|c00CDCDCD"..Spell_Key("C7").."")
	  end	  
	  
end)
	TreeListGroup:AddChild(SpellTickButton_C7)

	--C8
	local SpellTickButton_C8 = AceGUI:Create("Button")
	SpellTickButton_C8:SetRelativeWidth(1)
	SpellTickButton_C8.text:SetFont(SpellTickButton_C8.text:GetFont(),15)
	SpellTickButton_C8.text:SetJustifyH("LEFT")		
SpellTickButton_C8:SetCallback("OnClick", function() 
	  
if Class=="DEMONHUNTER" then
	  if Special == "浩劫" then PandaDB.HJ_C8 = not PandaDB.HJ_C8  This_C8 = PandaDB.HJ_C8 end 
	  if Special == "复仇" then PandaDB.FC_C8 = not PandaDB.FC_C8  This_C8 = PandaDB.FC_C8 end
end  

if Class=="MONK" then
	  if Special == "酒仙" then PandaDB.JX_C8 = not PandaDB.JX_C8  This_C8 = PandaDB.JX_C8 end 
	  if Special == "踏风" then PandaDB.TAF_C8 = not PandaDB.TAF_C8  This_C8 = PandaDB.TAF_C8  end
	  if Special == "织雾" then PandaDB.ZW_C8 = not PandaDB.ZW_C8  This_C8 = PandaDB.ZW_C8 end 
end

if Class=="HUNTER" then	  
	  if Special == "野兽控制" then PandaDB.SW_C8 = not PandaDB.SW_C8  This_C8 = PandaDB.SW_C8 end 
	  if Special == "射击" then PandaDB.SJ_C8 = not PandaDB.SJ_C8  This_C8 = PandaDB.SJ_C8 end
	  if Special == "生存" then PandaDB.SC_C8 = not PandaDB.SC_C8  This_C8 = PandaDB.SC_C8 end 
end

if Class=="WARLOCK" then	  
	  if Special == "恶魔学识" then PandaDB.EMS_C8 = not PandaDB.EMS_C8  This_C8 = PandaDB.EMS_C8  end
	  if Special == "毁灭" then PandaDB.HMS_C8 = not PandaDB.HMS_C8  This_C8 = PandaDB.HMS_C8 end 
	  if Special == "痛苦" then PandaDB.TKS_C8 = not PandaDB.TKS_C8  This_C8 = PandaDB.TKS_C8 end 

end	  

if Class=="ROGUE" then
	  if Special == "奇袭" then PandaDB.QXZ_C8 = not PandaDB.QXZ_C8  This_C8 = PandaDB.QXZ_C8 end 
	  if Special == "敏锐" then PandaDB.MRZ_C8 = not PandaDB.MRZ_C8  This_C8 = PandaDB.MRZ_C8 end
	  if Special == "狂徒" then PandaDB.KTZ_C8 = not PandaDB.KTZ_C8  This_C8 = PandaDB.KTZ_C8 end 
end

if Class == "PALADIN" then	  
	  if Special == "防护" then PandaDB.FQ_C8 = not PandaDB.FQ_C8  This_C8 = PandaDB.FQ_C8 end 
	  if Special == "惩戒" then PandaDB.CJQ_C8 = not PandaDB.CJQ_C8  This_C8 = PandaDB.CJQ_C8 end
	  if Special == "神圣" then PandaDB.NQ_C8 = not PandaDB.NQ_C8  This_C8 = PandaDB.NQ_C8 end 
end	  
---
if Class == "DRUID" then	  
	  if Special == "平衡" then PandaDB.PHD_C8 = not PandaDB.PHD_C8  This_C8 = PandaDB.PHD_C8 end 
	  if Special == "野性" then PandaDB.MD_C8 = not PandaDB.MD_C8  This_C8 = PandaDB.MD_C8 end
	  if Special == "守护" then PandaDB.XD_C8 = not PandaDB.XD_C8  This_C8 = PandaDB.XD_C8 end 
	  if Special == "恢复" then PandaDB.ND_C8 = not PandaDB.ND_C8  This_C8 = PandaDB.ND_C8 end 
end	  

if Class == "DEATHKNIGHT" then	  
	  if Special == "鲜血" then PandaDB.DKT_C8 = not PandaDB.DKT_C8  This_C8 = PandaDB.DKT_C8 end 
	  if Special == "冰霜" then PandaDB.BDK_C8 = not PandaDB.BDK_C8  This_C8 = PandaDB.BDK_C8 end
	  if Special == "邪恶" then PandaDB.XDK_C8 = not PandaDB.XDK_C8  This_C8 = PandaDB.XDK_C8 end 
end	  

if Class == "MAGE" then	  
	  if Special == "火焰" then PandaDB.HF_C8 = not PandaDB.HF_C8  This_C8 = PandaDB.HF_C8 end 
	  if Special == "冰霜" then PandaDB.BF_C8 = not PandaDB.BF_C8  This_C8 = PandaDB.BF_C8 end
	  if Special == "奥术" then PandaDB.AF_C8 = not PandaDB.AF_C8  This_C8 = PandaDB.AF_C8 end 
end	  

if Class == "PRIEST" then	  
	  if Special == "戒律" then PandaDB.JLM_C8 = not PandaDB.JLM_C8  This_C8 = PandaDB.JLM_C8 end 
	  if Special == "暗影" then PandaDB.AM_C8 = not PandaDB.AM_C8  This_C8 = PandaDB.AM_C8 end
	  if Special == "神圣" then PandaDB.shenM_C8 = not PandaDB.shenM_C8  This_C8 = PandaDB.shenM_C8 end 
end	  

if Class == "SHAMAN" then	  
	  if Special == "元素" then PandaDB.YSSM_C8 = not PandaDB.YSSM_C8  This_C8 = PandaDB.YSSM_C8 end 
	  if Special == "增强" then PandaDB.ZQSM_C8 = not PandaDB.ZQSM_C8  This_C8 = PandaDB.ZQSM_C8 end
	  if Special == "恢复" then PandaDB.HFSM_C8 = not PandaDB.HFSM_C8  This_C8 = PandaDB.HFSM_C8 end 
end	  

if Class == "WARRIOR" then	  
	  if Special == "防护" then PandaDB.FZ_C8 = not PandaDB.FZ_C8  This_C8 = PandaDB.FZ_C8 end 
	  if Special == "武器" then PandaDB.WQZ_C8 = not PandaDB.WQZ_C8  This_C8 = PandaDB.WQZ_C8 end
	  if Special == "狂怒" then PandaDB.KBZ_C8 = not PandaDB.KBZ_C8  This_C8 = PandaDB.KBZ_C8 end 
end	  

      if This_C8 ~= false then SpellTickButton_C8:SetText("|cffffe00a"..Spell_Key("C8").."")
	    elseif This_C8 == false then SpellTickButton_C8:SetText("|c00CDCDCD"..Spell_Key("C8").."")
	  end	  
	   
end)
	TreeListGroup:AddChild(SpellTickButton_C8)

	--C9
	local SpellTickButton_C9 = AceGUI:Create("Button")
	SpellTickButton_C9:SetRelativeWidth(1)
	SpellTickButton_C9.text:SetFont(SpellTickButton_C9.text:GetFont(),15)
	SpellTickButton_C9.text:SetJustifyH("LEFT")		
SpellTickButton_C9:SetCallback("OnClick", function() 
	  
if Class=="DEMONHUNTER" then
	  if Special == "浩劫" then PandaDB.HJ_C9 = not PandaDB.HJ_C9  This_C9 = PandaDB.HJ_C9 end 
	  if Special == "复仇" then PandaDB.FC_C9 = not PandaDB.FC_C9  This_C9 = PandaDB.FC_C9 end
end  

if Class=="MONK" then
	  if Special == "酒仙" then PandaDB.JX_C9 = not PandaDB.JX_C9  This_C9 = PandaDB.JX_C9 end 
	  if Special == "踏风" then PandaDB.TAF_C9 = not PandaDB.TAF_C9  This_C9 = PandaDB.TAF_C9  end
	  if Special == "织雾" then PandaDB.ZW_C9 = not PandaDB.ZW_C9  This_C9 = PandaDB.ZW_C9 end 
end

if Class=="HUNTER" then	  
	  if Special == "野兽控制" then PandaDB.SW_C9 = not PandaDB.SW_C9  This_C9 = PandaDB.SW_C9 end 
	  if Special == "射击" then PandaDB.SJ_C9 = not PandaDB.SJ_C9  This_C9 = PandaDB.SJ_C9 end
	  if Special == "生存" then PandaDB.SC_C9 = not PandaDB.SC_C9  This_C9 = PandaDB.SC_C9 end 
end

if Class=="WARLOCK" then	  
	  if Special == "恶魔学识" then PandaDB.EMS_C9 = not PandaDB.EMS_C9  This_C9 = PandaDB.EMS_C9  end
	  if Special == "毁灭" then PandaDB.HMS_C9 = not PandaDB.HMS_C9  This_C9 = PandaDB.HMS_C9 end 
	  if Special == "痛苦" then PandaDB.TKS_C9 = not PandaDB.TKS_C9  This_C9 = PandaDB.TKS_C9 end 

end	  

if Class=="ROGUE" then
	  if Special == "奇袭" then PandaDB.QXZ_C9 = not PandaDB.QXZ_C9  This_C9 = PandaDB.QXZ_C9 end 
	  if Special == "敏锐" then PandaDB.MRZ_C9 = not PandaDB.MRZ_C9  This_C9 = PandaDB.MRZ_C9 end
	  if Special == "狂徒" then PandaDB.KTZ_C9 = not PandaDB.KTZ_C9  This_C9 = PandaDB.KTZ_C9 end 
end

if Class == "PALADIN" then	  
	  if Special == "防护" then PandaDB.FQ_C9 = not PandaDB.FQ_C9  This_C9 = PandaDB.FQ_C9 end 
	  if Special == "惩戒" then PandaDB.CJQ_C9 = not PandaDB.CJQ_C9  This_C9 = PandaDB.CJQ_C9 end
	  if Special == "神圣" then PandaDB.NQ_C9 = not PandaDB.NQ_C9  This_C9 = PandaDB.NQ_C9 end 
end	  
---
if Class == "DRUID" then	  
	  if Special == "平衡" then PandaDB.PHD_C9 = not PandaDB.PHD_C9  This_C9 = PandaDB.PHD_C9 end 
	  if Special == "野性" then PandaDB.MD_C9 = not PandaDB.MD_C9  This_C9 = PandaDB.MD_C9 end
	  if Special == "守护" then PandaDB.XD_C9 = not PandaDB.XD_C9  This_C9 = PandaDB.XD_C9 end 
	  if Special == "恢复" then PandaDB.ND_C9 = not PandaDB.ND_C9  This_C9 = PandaDB.ND_C9 end 
end	  

if Class == "DEATHKNIGHT" then	  
	  if Special == "鲜血" then PandaDB.DKT_C9 = not PandaDB.DKT_C9  This_C9 = PandaDB.DKT_C9 end 
	  if Special == "冰霜" then PandaDB.BDK_C9 = not PandaDB.BDK_C9  This_C9 = PandaDB.BDK_C9 end
	  if Special == "邪恶" then PandaDB.XDK_C9 = not PandaDB.XDK_C9  This_C9 = PandaDB.XDK_C9 end 
end	  

if Class == "MAGE" then	  
	  if Special == "火焰" then PandaDB.HF_C9 = not PandaDB.HF_C9  This_C9 = PandaDB.HF_C9 end 
	  if Special == "冰霜" then PandaDB.BF_C9 = not PandaDB.BF_C9  This_C9 = PandaDB.BF_C9 end
	  if Special == "奥术" then PandaDB.AF_C9 = not PandaDB.AF_C9  This_C9 = PandaDB.AF_C9 end 
end	  

if Class == "PRIEST" then	  
	  if Special == "戒律" then PandaDB.JLM_C9 = not PandaDB.JLM_C9  This_C9 = PandaDB.JLM_C9 end 
	  if Special == "暗影" then PandaDB.AM_C9 = not PandaDB.AM_C9  This_C9 = PandaDB.AM_C9 end
	  if Special == "神圣" then PandaDB.shenM_C9 = not PandaDB.shenM_C9  This_C9 = PandaDB.shenM_C9 end 
end	  

if Class == "SHAMAN" then	  
	  if Special == "元素" then PandaDB.YSSM_C9 = not PandaDB.YSSM_C9  This_C9 = PandaDB.YSSM_C9 end 
	  if Special == "增强" then PandaDB.ZQSM_C9 = not PandaDB.ZQSM_C9  This_C9 = PandaDB.ZQSM_C9 end
	  if Special == "恢复" then PandaDB.HFSM_C9 = not PandaDB.HFSM_C9  This_C9 = PandaDB.HFSM_C9 end 
end	  

if Class == "WARRIOR" then	  
	  if Special == "防护" then PandaDB.FZ_C9 = not PandaDB.FZ_C9  This_C9 = PandaDB.FZ_C9 end 
	  if Special == "武器" then PandaDB.WQZ_C9 = not PandaDB.WQZ_C9  This_C9 = PandaDB.WQZ_C9 end
	  if Special == "狂怒" then PandaDB.KBZ_C9 = not PandaDB.KBZ_C9  This_C9 = PandaDB.KBZ_C9 end 
end	  

      if This_C9 ~= false then SpellTickButton_C9:SetText("|cffffe00a"..Spell_Key("C9").."")
	    elseif This_C9 == false then SpellTickButton_C9:SetText("|c00CDCDCD"..Spell_Key("C9").."")
	  end	  
	   
end)
	TreeListGroup:AddChild(SpellTickButton_C9)

	
	--C0
	local SpellTickButton_C0 = AceGUI:Create("Button")
	SpellTickButton_C0:SetRelativeWidth(1)
	SpellTickButton_C0.text:SetFont(SpellTickButton_C0.text:GetFont(),15)
	SpellTickButton_C0.text:SetJustifyH("LEFT")		
SpellTickButton_C0:SetCallback("OnClick", function() 
	  
if Class=="DEMONHUNTER" then
	  if Special == "浩劫" then PandaDB.HJ_C0 = not PandaDB.HJ_C0  This_C0 = PandaDB.HJ_C0 end 
	  if Special == "复仇" then PandaDB.FC_C0 = not PandaDB.FC_C0  This_C0 = PandaDB.FC_C0 end
end  

if Class=="MONK" then
	  if Special == "酒仙" then PandaDB.JX_C0 = not PandaDB.JX_C0  This_C0 = PandaDB.JX_C0 end 
	  if Special == "踏风" then PandaDB.TAF_C0 = not PandaDB.TAF_C0  This_C0 = PandaDB.TAF_C0  end
	  if Special == "织雾" then PandaDB.ZW_C0 = not PandaDB.ZW_C0  This_C0 = PandaDB.ZW_C0 end 
end

if Class=="HUNTER" then	  
	  if Special == "野兽控制" then PandaDB.SW_C0 = not PandaDB.SW_C0  This_C0 = PandaDB.SW_C0 end 
	  if Special == "射击" then PandaDB.SJ_C0 = not PandaDB.SJ_C0  This_C0 = PandaDB.SJ_C0 end
	  if Special == "生存" then PandaDB.SC_C0 = not PandaDB.SC_C0  This_C0 = PandaDB.SC_C0 end 
end

if Class=="WARLOCK" then	  
	  if Special == "恶魔学识" then PandaDB.EMS_C0 = not PandaDB.EMS_C0  This_C0 = PandaDB.EMS_C0  end
	  if Special == "毁灭" then PandaDB.HMS_C0 = not PandaDB.HMS_C0  This_C0 = PandaDB.HMS_C0 end 
	  if Special == "痛苦" then PandaDB.TKS_C0 = not PandaDB.TKS_C0  This_C0 = PandaDB.TKS_C0 end 

end	  

if Class=="ROGUE" then
	  if Special == "奇袭" then PandaDB.QXZ_C0 = not PandaDB.QXZ_C0  This_C0 = PandaDB.QXZ_C0 end 
	  if Special == "敏锐" then PandaDB.MRZ_C0 = not PandaDB.MRZ_C0  This_C0 = PandaDB.MRZ_C0 end
	  if Special == "狂徒" then PandaDB.KTZ_C0 = not PandaDB.KTZ_C0  This_C0 = PandaDB.KTZ_C0 end 
end

if Class == "PALADIN" then	  
	  if Special == "防护" then PandaDB.FQ_C0 = not PandaDB.FQ_C0  This_C0 = PandaDB.FQ_C0 end 
	  if Special == "惩戒" then PandaDB.CJQ_C0 = not PandaDB.CJQ_C0  This_C0 = PandaDB.CJQ_C0 end
	  if Special == "神圣" then PandaDB.NQ_C0 = not PandaDB.NQ_C0  This_C0 = PandaDB.NQ_C0 end 
end	  
---
if Class == "DRUID" then	  
	  if Special == "平衡" then PandaDB.PHD_C0 = not PandaDB.PHD_C0  This_C0 = PandaDB.PHD_C0 end 
	  if Special == "野性" then PandaDB.MD_C0 = not PandaDB.MD_C0  This_C0 = PandaDB.MD_C0 end
	  if Special == "守护" then PandaDB.XD_C0 = not PandaDB.XD_C0  This_C0 = PandaDB.XD_C0 end 
	  if Special == "恢复" then PandaDB.ND_C0 = not PandaDB.ND_C0  This_C0 = PandaDB.ND_C0 end 
end	  

if Class == "DEATHKNIGHT" then	  
	  if Special == "鲜血" then PandaDB.DKT_C0 = not PandaDB.DKT_C0  This_C0 = PandaDB.DKT_C0 end 
	  if Special == "冰霜" then PandaDB.BDK_C0 = not PandaDB.BDK_C0  This_C0 = PandaDB.BDK_C0 end
	  if Special == "邪恶" then PandaDB.XDK_C0 = not PandaDB.XDK_C0  This_C0 = PandaDB.XDK_C0 end 
end	  

if Class == "MAGE" then	  
	  if Special == "火焰" then PandaDB.HF_C0 = not PandaDB.HF_C0  This_C0 = PandaDB.HF_C0 end 
	  if Special == "冰霜" then PandaDB.BF_C0 = not PandaDB.BF_C0  This_C0 = PandaDB.BF_C0 end
	  if Special == "奥术" then PandaDB.AF_C0 = not PandaDB.AF_C0  This_C0 = PandaDB.AF_C0 end 
end	  

if Class == "PRIEST" then	  
	  if Special == "戒律" then PandaDB.JLM_C0 = not PandaDB.JLM_C0  This_C0 = PandaDB.JLM_C0 end 
	  if Special == "暗影" then PandaDB.AM_C0 = not PandaDB.AM_C0  This_C0 = PandaDB.AM_C0 end
	  if Special == "神圣" then PandaDB.shenM_C0 = not PandaDB.shenM_C0  This_C0 = PandaDB.shenM_C0 end 
end	  

if Class == "SHAMAN" then	  
	  if Special == "元素" then PandaDB.YSSM_C0 = not PandaDB.YSSM_C0  This_C0 = PandaDB.YSSM_C0 end 
	  if Special == "增强" then PandaDB.ZQSM_C0 = not PandaDB.ZQSM_C0  This_C0 = PandaDB.ZQSM_C0 end
	  if Special == "恢复" then PandaDB.HFSM_C0 = not PandaDB.HFSM_C0  This_C0 = PandaDB.HFSM_C0 end 
end	  

if Class == "WARRIOR" then	  
	  if Special == "防护" then PandaDB.FZ_C0 = not PandaDB.FZ_C0  This_C0 = PandaDB.FZ_C0 end 
	  if Special == "武器" then PandaDB.WQZ_C0 = not PandaDB.WQZ_C0  This_C0 = PandaDB.WQZ_C0 end
	  if Special == "狂怒" then PandaDB.KBZ_C0 = not PandaDB.KBZ_C0  This_C0 = PandaDB.KBZ_C0 end 
end	  

      if This_C0 ~= false then SpellTickButton_C0:SetText("|cffffe00a"..Spell_Key("C0").."")
	    elseif This_C0 == false then SpellTickButton_C0:SetText("|c00CDCDCD"..Spell_Key("C0").."")
	  end	  
	   
end)
	TreeListGroup:AddChild(SpellTickButton_C0)
------------------------	
	
	


local function UpdateAllSpellSwitch()



      if This_A1 then SpellTickButton_A1:SetText("|cffffe00a"..Spell_Key("A1").."")
	    elseif not This_A1 then SpellTickButton_A1:SetText("|c00CDCDCD"..Spell_Key("A1").."")
	  end
	  


      if This_A2 ~= false then SpellTickButton_A2:SetText("|cffffe00a"..Spell_Key("A2").."")
	    elseif This_A2 == false then SpellTickButton_A2:SetText("|c00CDCDCD"..Spell_Key("A2").."")
	  end	  



      if This_A3 ~= false then SpellTickButton_A3:SetText("|cffffe00a"..Spell_Key("A3").."")
	    elseif This_A3 == false then SpellTickButton_A3:SetText("|c00CDCDCD"..Spell_Key("A3").."")
	  end


      if This_A4 ~= false then SpellTickButton_A4:SetText("|cffffe00a"..Spell_Key("A4").."")
	    elseif This_A4 == false then SpellTickButton_A4:SetText("|c00CDCDCD"..Spell_Key("A4").."")
	  end
	  



      if This_A5 ~= false then SpellTickButton_A5:SetText("|cffffe00a"..Spell_Key("A5").."")
	    elseif This_A5 == false then SpellTickButton_A5:SetText("|c00CDCDCD"..Spell_Key("A5").."")
	  end	  



      if This_A6 ~= false then SpellTickButton_A6:SetText("|cffffe00a"..Spell_Key("A6").."")
	    elseif This_A6 == false then SpellTickButton_A6:SetText("|c00CDCDCD"..Spell_Key("A6").."")
	  end	  



      if This_A7 ~= false then SpellTickButton_A7:SetText("|cffffe00a"..Spell_Key("A7").."")
	    elseif This_A7 == false then SpellTickButton_A7:SetText("|c00CDCDCD"..Spell_Key("A7").."")
	  end	 



      if This_A8 ~= false then SpellTickButton_A8:SetText("|cffffe00a"..Spell_Key("A8").."")
	    elseif This_A8 == false then SpellTickButton_A8:SetText("|c00CDCDCD"..Spell_Key("A8").."")
	  end	  


      if This_A9 ~= false then SpellTickButton_A9:SetText("|cffffe00a"..Spell_Key("A9").."")
	    elseif This_A9 == false then SpellTickButton_A9:SetText("|c00CDCDCD"..Spell_Key("A9").."")
	  end	  



      if This_A0 ~= false then SpellTickButton_A0:SetText("|cffffe00a"..Spell_Key("A0").."")
	    elseif This_A0 == false then SpellTickButton_A0:SetText("|c00CDCDCD"..Spell_Key("A0").."")
	  end	  




      if This_C1 ~= false then SpellTickButton_C1:SetText("|cffffe00a"..Spell_Key("C1").."")
	    elseif This_C1 == false then SpellTickButton_C1:SetText("|c00CDCDCD"..Spell_Key("C1").."")
	  end	  



      if This_C2 ~= false then SpellTickButton_C2:SetText("|cffffe00a"..Spell_Key("C2").."")
	    elseif This_C2 == false then SpellTickButton_C2:SetText("|c00CDCDCD"..Spell_Key("C2").."")
	  end	  



      if This_C3 ~= false then SpellTickButton_C3:SetText("|cffffe00a"..Spell_Key("C3").."")
	    elseif This_C3 == false then SpellTickButton_C3:SetText("|c00CDCDCD"..Spell_Key("C3").."")
	  end	  



      if This_C4 ~= false then SpellTickButton_C4:SetText("|cffffe00a"..Spell_Key("C4").."")
	    elseif This_C4 == false then SpellTickButton_C4:SetText("|c00CDCDCD"..Spell_Key("C4").."")
	  end	  

      if This_C5 ~= false then SpellTickButton_C5:SetText("|cffffe00a"..Spell_Key("C5").."")
	    elseif This_C5 == false then SpellTickButton_C5:SetText("|c00CDCDCD"..Spell_Key("C5").."")
	  end	 




      if This_C6 ~= false then SpellTickButton_C6:SetText("|cffffe00a"..Spell_Key("C6").."")
	    elseif This_C6 == false then SpellTickButton_C6:SetText("|c00CDCDCD"..Spell_Key("C6").."")
	  end	  


      if This_C7 ~= false then SpellTickButton_C7:SetText("|cffffe00a"..Spell_Key("C7").."")
	    elseif This_C7 == false then SpellTickButton_C7:SetText("|c00CDCDCD"..Spell_Key("C7").."")
	  end	  


      if This_C8 ~= false then SpellTickButton_C8:SetText("|cffffe00a"..Spell_Key("C8").."")
	    elseif This_C8 == false then SpellTickButton_C8:SetText("|c00CDCDCD"..Spell_Key("C8").."")
	  end	  

  
      if This_C9 ~= false then SpellTickButton_C9:SetText("|cffffe00a"..Spell_Key("C9").."")
	    elseif This_C9 == false then SpellTickButton_C9:SetText("|c00CDCDCD"..Spell_Key("C9").."")
	  end	  

	  if This_C0 ~= false then SpellTickButton_C0:SetText("|cffffe00a"..Spell_Key("C0").."")
	    elseif This_C0 == false then SpellTickButton_C0:SetText("|c00CDCDCD"..Spell_Key("C0").."")
	  end	  
	  

end


UpdateAllSpellSwitch()	
end	

local function CheckMyMacrosUI()

	local fullwidth = 600
	local fullheight = 200
    local TreeListGroup = AceGUI:Create("SimpleGroup")
	local PandaGUI = AceGUI:Create("Frame")
	PandaGUI:EnableResize(true)
	PandaGUI:SetCallback("OnClose", function(widget) AceGUI:Release(widget) end)
	PandaGUI:SetTitle("|cffffe00a|r|c00FF68CC ★ Panda ★|r|cffffe00a|r")
	PandaGUI.titletext:SetJustifyH("CENTER")
	PandaGUI.titletext:SetJustifyV("MIDDLE")
	PandaGUI.titletext:SetFont(PandaGUI.titletext:GetFont(),20)
	PandaGUI:SetWidth(fullwidth)
	PandaGUI:SetHeight(fullheight)
	PandaGUI:SetLayout("Fill")
    PandaGUI:AddChild(TreeListGroup)
    
    ---文字
    local SetTextButton = AceGUI:Create("Heading")
    --SetTextButton:SetText("|cffffe00a★ ★ ★ ★ ★ ★ ★ ★ ★ ★ ★ ")
    SetTextButton:SetRelativeWidth(1)
	TreeListGroup:AddChild(SetTextButton)
	
	local SetTextButton = AceGUI:Create("Label")
	SetTextButton:SetFont(SetTextButton.label:GetFont(),15)
	SetTextButton:SetText("|cffffe00a通用宏已满 ESC-宏命令设置-通用宏 删除3个通用宏后 重载界面 或 初始化")
	SetTextButton:SetRelativeWidth(1)
	TreeListGroup:AddChild(SetTextButton)

end

local function OpenPandaGUI()


	local fullwidth = 600
	local fullheight = 600
    local TreeListGroup = AceGUI:Create("SimpleGroup")
	local PandaGUI = AceGUI:Create("Frame")
	PandaGUI:EnableResize(true)
	PandaGUI:SetCallback("OnClose", function(widget) AceGUI:Release(widget) end)
	PandaGUI:SetTitle("|cffffe00a|r|c00FF68CC ★ Panda ★|r|cffffe00a|r")
	PandaGUI.titletext:SetJustifyH("CENTER")
	PandaGUI.titletext:SetJustifyV("MIDDLE")
	PandaGUI.titletext:SetFont(PandaGUI.titletext:GetFont(),20)
	PandaGUI:SetWidth(fullwidth)
	PandaGUI:SetHeight(fullheight)
	PandaGUI:SetLayout("Fill")
    PandaGUI:AddChild(TreeListGroup)
    
    ---文字
    local SetTextButton = AceGUI:Create("Heading")
    --SetTextButton:SetText("|cffffe00a★ ★ ★ ★ ★ ★ ★ ★ ★ ★ ★ ")
    SetTextButton:SetRelativeWidth(1)
	TreeListGroup:AddChild(SetTextButton)
	
	local SetTextButton = AceGUI:Create("Label")
	SetTextButton:SetFont(SetTextButton.label:GetFont(),15)
	SetTextButton:SetText("|cffffe00a ① 鼠 标 左 键 拖 动 中 央 图 标 调 整 位 置")
	SetTextButton:SetRelativeWidth(1)
	TreeListGroup:AddChild(SetTextButton)
	
	local SetTextButton = AceGUI:Create("Label")
	SetTextButton:SetFont(SetTextButton.label:GetFont(),15)
	SetTextButton:SetText("|cffffe00a ② /PD 弹 出 设 置 界 面")
	SetTextButton:SetRelativeWidth(1)
	TreeListGroup:AddChild(SetTextButton)
	
	local SetTextButton = AceGUI:Create("Label")
	SetTextButton:SetFont(SetTextButton.label:GetFont(),15)
	SetTextButton:SetText("|cffffe00a ③ /PD SCALE x 调 整 大 小 (x 是 0.6~2 之 间 的 数 字)")
	SetTextButton:SetRelativeWidth(1)
	TreeListGroup:AddChild(SetTextButton)
	
	local SetTextButton = AceGUI:Create("Label")
	SetTextButton:SetFont(SetTextButton.label:GetFont(),15)
	SetTextButton:SetText("|cffffe00a ④ /PD SHOW 显 示 / 隐 藏 插 件")
	SetTextButton:SetRelativeWidth(1)
	TreeListGroup:AddChild(SetTextButton)
    
	local SetTextButton = AceGUI:Create("Label")
	SetTextButton:SetFont(SetTextButton.label:GetFont(),15)
	SetTextButton:SetText("|cffffe00a ⑤ /PD CCD 或 点 击 左 红 心 图 标 控 制【大招】开 关 ( 默 认 开 )")
	SetTextButton:SetRelativeWidth(1)
	TreeListGroup:AddChild(SetTextButton)

	local SetTextButton = AceGUI:Create("Label")
	SetTextButton:SetFont(SetTextButton.label:GetFont(),15)
	SetTextButton:SetText("|cffffe00a ⑥ /PD AOE 或 点 击 右 红 心 图 标 控 制【AOE】 开 关 ( 默 认 开 )")
	SetTextButton:SetRelativeWidth(1)
	TreeListGroup:AddChild(SetTextButton)
	
	
	local SetTextButton = AceGUI:Create("Label")
	SetTextButton:SetFont(SetTextButton.label:GetFont(),15)
	SetTextButton:SetText("|cffffe00a ⑦ /PD AUTO 或 按 【PD_暂停】 宏 控 制 【输出】 开 关( 默 认 开 )")
	SetTextButton:SetRelativeWidth(1)
	TreeListGroup:AddChild(SetTextButton)
	
    local SetTextButton = AceGUI:Create("Label")
	SetTextButton:SetFont(SetTextButton.label:GetFont(),15)
	SetTextButton:SetText("|cffffe00a ⑧ 请看【通用宏】列表 ! 将 【开关宏】 拖 到 动 作 条， 按 宏 达 到 效 果")
	SetTextButton:SetRelativeWidth(1)
	TreeListGroup:AddChild(SetTextButton)

    local SetTextButton = AceGUI:Create("Label")
	SetTextButton:SetFont(SetTextButton.label:GetFont(),15)
	SetTextButton:SetText("|cffffe00a ⑨ 右 键 点 击 右 红 心 可 打 开 技 能 开 关 界 面")
	SetTextButton:SetRelativeWidth(1)
	TreeListGroup:AddChild(SetTextButton)

    local SetTextButton = AceGUI:Create("Label")
	SetTextButton:SetFont(SetTextButton.label:GetFont(),15)
	SetTextButton:SetText("|cffffe00a ⑩ 插件占用数字小键盘Numpad0-9 及 CTRL 或 ALT + Numpad0-9 ")
	SetTextButton:SetRelativeWidth(1)
	TreeListGroup:AddChild(SetTextButton)
	
	local SetTextButton = AceGUI:Create("Heading")
    --SetTextButton:SetText("|cffffe00a★ ★ ★ ★ ★ ★ ★ ★ ★ ★ ★ ")
    SetTextButton:SetRelativeWidth(1)
	TreeListGroup:AddChild(SetTextButton)	
	
    local SetTextButton = AceGUI:Create("Label")
	SetTextButton:SetFont(SetTextButton.label:GetFont(),15)
	SetTextButton:SetText("|cffffe00a 打开敌对姓名板 加快 AOE 识别速度 ")
	SetTextButton:SetRelativeWidth(1)
	TreeListGroup:AddChild(SetTextButton)
	
	local SetTextButton = AceGUI:Create("Heading")
    SetTextButton:SetText("|cffffe00a【QQ群：155461246 QQ：398371778】")
    SetTextButton:SetRelativeWidth(1)
	TreeListGroup:AddChild(SetTextButton)
	
    local SetTextButton = AceGUI:Create("Heading")
    --SetTextButton:SetText("|cffffe00a★ ★ ★ ★ ★ ★ ★ ★ ★ ★ ★ ")
    SetTextButton:SetRelativeWidth(1)
	TreeListGroup:AddChild(SetTextButton)	
	
    ------------------------------------------------------
	
	local SetTextButton = AceGUI:Create("Label")
	SetTextButton:SetFont(SetTextButton.label:GetFont(),15)
	SetTextButton:SetText("|cffffe00a小提示 ：【一键智能输出功能】请联系QQ：398371778 只需按一个键 自动打哦！★福利★：每推荐一个亲朋好友开通 【一键智能输出功能】备注推荐人QQ号码 便可以领取 10% 的红包 ")
	SetTextButton:SetRelativeWidth(1)
	TreeListGroup:AddChild(SetTextButton)
 
	------------------------------------------------------	
		------------------------------------------------------
    local SetTextButton = AceGUI:Create("Heading")
    --SetTextButton:SetText("|cffffe00a★ ★ ★ ★ ★ ★ ★ ★ ★ ★ ★ ")
    SetTextButton:SetRelativeWidth(1)
	TreeListGroup:AddChild(SetTextButton)
	
    local SetTextButton = AceGUI:Create("Heading")
    SetTextButton:SetText("|cffffe00a★ ★ 更新日志：")
    SetTextButton:SetRelativeWidth(1)
	TreeListGroup:AddChild(SetTextButton)
	
	
   local SetTextButton = AceGUI:Create("Heading")
    --SetTextButton:SetText("|cffffe00a★ ★ ★ ★ ★ ★ ★ ★ ★ ★ ★ ")
    SetTextButton:SetRelativeWidth(1)
	TreeListGroup:AddChild(SetTextButton)	
	local SetTextButton = AceGUI:Create("Label")
	SetTextButton:SetFont(SetTextButton.label:GetFont(),15)
	SetTextButton:SetText("|cffffe00a★2020-5-21 ：加入平衡德") 
	SetTextButton:SetRelativeWidth(1)
	TreeListGroup:AddChild(SetTextButton)
	



	
		-------------
    local SetTextButton = AceGUI:Create("Heading")
    --SetTextButton:SetText("|cffffe00a★ ★ ★ ★ ")
    SetTextButton:SetRelativeWidth(1)
	TreeListGroup:AddChild(SetTextButton)
--[[
	
	local SetTextButton = AceGUI:Create("Button")
    SetTextButton:SetRelativeWidth(1)
	SetTextButton.text:SetFont(SetTextButton.text:GetFont(),15)
	SetTextButton.text:SetJustifyH("LEFT")
	if CheckFriend() == false then
	SetTextButton:SetText("|cffffe00a★请点击这个按钮 → 在线激活★") 
    SetTextButton:SetCallback("OnClick", function() 
    BNSendFriendInvite("旧城往事绕#5300")
    end)
	elseif CheckFriend() == true then
	SetTextButton:SetText("|cffffe00a★此战网账号 已激活一键输出功能★") 
    end
    TreeListGroup:AddChild(SetTextButton)
--]]
	
	--------------------------------------------

	--------------------------------------

	---------------
	---------------
    local SetTextButton = AceGUI:Create("Heading")
    --SetTextButton:SetText("|cffffe00a★ ★ ★ ★ ★ ★ ★ ★ ★ ★ ★ ")
    SetTextButton:SetRelativeWidth(1)
	TreeListGroup:AddChild(SetTextButton)
	

	local SetTextButton = AceGUI:Create("Button")
    SetTextButton:SetRelativeWidth(1)
	SetTextButton.text:SetFont(SetTextButton.text:GetFont(),15)
	SetTextButton.text:SetJustifyH("LEFT")
	SetTextButton:SetText("|cffffe00a★第一次安装 或 删除【WTF】后 点击  →  【初始化】") 
    SetTextButton:SetCallback("OnClick", function() 
        ReloadUI()
    end)
    TreeListGroup:AddChild(SetTextButton)

	local SetTextButton = AceGUI:Create("Heading")
    --SetTextButton:SetText("|cffffe00a★ ★ ★ ★ ★ ★ ★ ★ ★ ★ ★ ")
    SetTextButton:SetRelativeWidth(1)
	TreeListGroup:AddChild(SetTextButton)
	
    local SetTextButton = AceGUI:Create("Heading")
    --SetTextButton:SetText("|cffffe00a★ ★ ★ ★ ★ ★ ★ ★ ★ ★ ★ ")
    SetTextButton:SetRelativeWidth(1)
	TreeListGroup:AddChild(SetTextButton)
	
	local SetTextButton = AceGUI:Create("Button")
    SetTextButton:SetRelativeWidth(1)
	SetTextButton.text:SetFont(SetTextButton.text:GetFont(),15)
	SetTextButton.text:SetJustifyH("LEFT")
	SetTextButton:SetText("|cffffe00a★不能正常输出 点击  →  【初始化】") 
    SetTextButton:SetCallback("OnClick", function() 
        ReloadUI()
    end)
    TreeListGroup:AddChild(SetTextButton)

	
local Spell_Key = ns.Spell_Key
local MacroSwith1 = GetMacroInfo("PD_大招开关")
local MacroSwith2 = GetMacroInfo("PD_单体开关")
local MacroSwith3 = GetMacroInfo("PD_暂停")
--local MacroSwith4 = GetMacroInfo(Spell_Key("C3"))
--local MacroSwith5 = GetMacroInfo(Spell_Key("C8"))

local Common,Role = GetNumMacros()

--检测宏
if Common >= 120 then 
if MacroSwith1 == nil or MacroSwith2 == nil or MacroSwith3 == nil then 
CheckMyMacrosUI()
end
end 
	
end



local OpenPandaGUI = OpenPandaGUI
ns.OpenPandaGUI = OpenPandaGUI
local SpellSwitch = SpellSwitch
ns.SpellSwitch = SpellSwitch
local CheckMyMacrosUI = CheckMyMacrosUI
ns.CheckMyMacrosUI = CheckMyMacrosUI