---------------------------------------------------------------------------
--[[《《《《《《《《《《《    法术系统   》》》》》》》》》》》]]--
---------------------------------------------------------------------------
local addon, ns = ...

local function GetSpellID(name)--得到技能的ID
local _,_,_,_,_,_,id = GetSpellInfo(name)
return id
end

--判断是否学习、能量检测 (技能中文名) name填中文名
local function useable(name)
    local usable = IsUsableSpell(name)
	local spellname,_,icon,_,_,_,SpellID = GetSpellInfo(name)
	if usable and spellname == name then  
    return true else
        return false
    end
end

--技能冷却时间  spellid填法术ID     
local function SpellCooldown(spellid)         
    local s,d,e=GetSpellCooldown("193455");
    local s1,d1,e1 = GetSpellCooldown(spellid)
    local gcd=0
    local cd = 0
    if d1 == nil then return end	
    if d1 >0 then
        gcd=s+d-GetTime()
        cd=s1+d1-GetTime()
    end 
    if gcd >=  cd then
        return 0
    else
        return cd
    end    
end

--判断是否学习、能量检测、冷却检测 name填中文名 id填法术ID
local function Isuseable(name,id)
 
    local s,d,e=GetSpellCooldown("193455");
    local s1,d1,e1 = GetSpellCooldown(id)
    local gcd=0
    local cd = 0
	local spellcd
	if d1 == nil then return false end
	
    if d1 >0 then
        gcd=s+d-GetTime()
        cd=s1+d1-GetTime()
    end 
    if gcd >=  cd then
        spellcd = 0
    else
        spellcd = cd
    end    

local value
local A = useable(name)
local B = spellcd

 if A == true and B<=0.5 then
 value = true 
 else value = false
 end
 return value
end



 
--GCD最大值 
local function GCD_MAX()                 
    local H = GetHaste()
    return 1.5/(1+H/100)
end

--GCD剩余值
local function GCD_REMAINS()                   
    local s,d,e=GetSpellCooldown("85256");
    local gcd=0;
    if d >0
    then
        gcd=s+d-GetTime()
    end    
    return gcd
end




--技能充能层数 spellid填法术ID 
local function SpellCharges(spellid)
    local charges = GetSpellCharges(spellid)
	return charges
end
--技能次数  spellid填法术ID
local function SpellConut(spellid)
    local Conut = GetSpellCount(spellid)
	return Conut
end
--技能充能层数（带小数） ID填法术ID
local function SpellallCharges(ID)        
    local currentCharges, maxCharges, cooldownStart, cooldownDuration = GetSpellCharges(ID)
    local Charges =  maxCharges
    if maxCharges > currentCharges
    then
        Charges = currentCharges + 1 -((cooldownStart + cooldownDuration - GetTime())/cooldownDuration)
    else Charges = maxCharges
    end
    return Charges
end

--技能充能至满层还需的时间   ID填法术ID 
local function SpellFullCharges(ID)                                
    local gsc, gsmc,gsst, gsd = GetSpellCharges(ID);
    local allcooldown = 0;
    if gsmc > gsc
    then
        allcooldown = (gsmc - gsc - 1) * gsd + (gsst+gsd-GetTime())
    end
    return allcooldown
end

--法术施法所需时间 spellname填法术ID
local function cast_time(spellname)
    local casttime = ({ GetSpellInfo(spellname)})[4]/1000
	return casttime
end

--法术施法剩余时间 unit填单位 spellname填法术ID
local function casting_time(unit,spellname) 
    local spell,_,_,_,endTime = UnitCastingInfo(unit)
    local finishtime = 0
    if (spell and spellname == nil) or (spell and spell == spellname) then
        finishtime = endTime/1000 - GetTime()
    end
    return finishtime
end

--法术引导剩余时间 unit填单位 spellname填法术ID
local function channel_time(unit,spellname) 
    local spell,_,_,_,endTime = UnitChannelInfo(unit)
    local finishtime = 0
    if (spell and spellname == nil) or (spell and spell == spellname) then
        finishtime = endTime/1000 - GetTime()
    end
    return finishtime
end
--施法引导剩余时间 unit填单位
local function Useingtime(unit)
local T1 = math.ceil(casting_time(unit)) 
local T2 = math.ceil(channel_time(unit)) 
local slot = ""
if T1 == 0 then
slot = T2
elseif T2 ==0 then
slot = T1
end
if slot == 0 then slot = "" end

return slot
end

--单位正在引导的技能 unit填单位 
local function Channeling_spell(unit)
    local Spell = 0
    local  _,_,_,_,_,_,_,SpellID  = UnitChannelInfo(unit)
    if SpellID ~= nil then 
       Spell = SpellID
    else 
	   Spell = 0
	end
return Spell
end

--单位正在施法的技能 unit填单位 
local function Casting_spell(unit)
    local Spell = 0
    local  _,_,_,_,_,_,_,_,SpellID  = UnitCastingInfo(unit)
	if SpellID ~= nil then 
       Spell = SpellID
    else 
	   Spell = 0
	end
return Spell
end


--单位正在施法或引导的技能 unit填单位 
local function Useing_spell(unit)
    local Spell = 0
    local  _,_,_,_,_,_,_,SpellID1  = UnitChannelInfo(unit)
    local  _,_,_,_,_,_,_,_,SpellID2  = UnitCastingInfo(unit)
	if SpellID1 ~= nil then
	   Spell = SpellID1
	elseif SpellID2  ~= nil then
	   Spell = SpellID2
	elseif SpellID1 ~= nil and SpellID2  ~= nil then
       Spell = 0
    end
	return Spell
end



---------------------------------------------------------------------------
--[[                   施法成功的一系列                        ]]--
---------------------------------------------------------------------------
local G_cast_time = G_cast_time or GetTime()
local lastability = 0
local G_spell_time = {}
local spellcasttable = {}
local lastspelltable = {}
local spellList = {
    --踏风僧
    [100780] = true,
    [100784] = true,
    [107428] = true,
    [113656] = true,
    [115098] = true,
    [117952] = true,
    [101546] = true,
	[101545] = true,
    [261947] = true,
    [152175] = true,
    [115080] = true,
    [123986] = true,
    [116847] = true,
    [287771] = true,
    --恶魔术
    [196277] = true,
    [105174] = true,
    [104316] = true,
    [265187] = true,
    [234153] = true,
    [264178] = true,
    [267171] = true,
    [686] = true,
    [264057] = true,
    [267211] = true,
    [264130] = true,
    [265412] = true,
    [264119] = true,
    [111898] = true,

}

local OutList = {
   
    [148187] = true,--碧玉疾风
	[107270] = true,--神鹤引项踢
	[227255] = true,--灵魂碎片
	[228478] = true,--裂魂劈裂
	[213241] = true,--邪能之刃
	[213243] = true,--邪能之刃
	[199547] = true,--混乱打击
	[222031] = true,--混乱打击
	[201428] = true,--毁灭
	[227518] = true,--毁灭

}	


--事件更新
RegisterEvent("UNIT_SPELLCAST_SUCCEEDED", function(arg1,arg2,arg3,arg4)
local spellList = spellList
local OutList = OutList
if arg2 == "player" then 

 local LastSpell = arg4
    if G_spell_time[LastSpell] ~= nil then 
			G_spell_time[LastSpell] = GetTime()
    end	
	
     if LastSpell ~= 0 then
	    lastability = LastSpell
        G_cast_time = GetTime()
 
    end		
--在列表中的技能才计算		
if spellList[arg4] then


 		table.insert(spellcasttable,1,arg4)
		if #spellcasttable > 5 then 
			table.remove(spellcasttable,6)
		end
end

--除列表内所有技能都计算
if not OutList[arg4] then
  		table.insert(lastspelltable,1,arg4)
		if #lastspelltable > 5 then 
			table.remove(lastspelltable,6)
		end
end

end
end)

--施法 t 秒内
local function cast_In(t,ID)--填入ID 则指定法术ID施法t内 不填ID则指定任意法术ID施法t内

    local out = false
	local spell = lastability
   
   if not ID then
	    if GetTime() - G_cast_time  <=t then
               out = true
        end
	
    end
	
	if ID then
        if spell == ID and GetTime() - G_cast_time  <=t then
               out = true
        end
    end

 return out
end

--施法 t 秒后
local function cast_later(t,ID)--填入ID 则指定法术ID施法t后 不填ID则指定任意法术ID施法t后

    local out = false
	local spell = lastability
	  
	if not ID then
	    if GetTime() - G_cast_time  >t then
               out = true
        end
	
    end
	
	if ID then
        if spell == ID and GetTime() - G_cast_time  >t then
               out = true
        end
    end
	
    return out
end

local function Prev_Spell(n)--前n个列表中的技能。
    local Spell = spellcasttable[n]
    if Spell ~= nil then 
        return Spell else return 0
    end
end

local function Last_Spell(n)--前n个技能。
    local Spell = lastspelltable[n]
    if Spell ~= nil then 
        return Spell else return 0
    end
end

local function Spell_Later(ID,T1,T2) --施法T1以后，T2以内(法术编号，时间1 时间2) 填入T2则指定T1-T2时间段内 不填T2则指定T1以后的时间
	local soult = false
	G_spell_time[ID] = G_spell_time[ID] or 0
if G_spell_time[ID] > 0 then

	if not T2 then
	    if GetTime() - G_spell_time[ID] > T1 then
	             soult = true 
	        else soult = false
	    end
    end
	
    if T2 then

		if GetTime() - G_spell_time[ID] > T1 and GetTime() - G_spell_time[ID] < T2  then
			soult = true 
		elseif GetTime() - G_spell_time[ID] >= T2 then
			G_spell_time[ID]=0
		end
	end
end	
	return soult
end


---插件内接口


local GetSpellID = GetSpellID
ns.GetSpellID = GetSpellID

local useable = useable 
ns.useable = useable

local Isuseable = Isuseable
ns.Isuseable = Isuseable

local GCD_MAX = GCD_MAX
ns.GCD_MAX = GCD_MAX

local GCD_REMAINS = GCD_REMAINS
ns.GCD_REMAINS = GCD_REMAINS

local SpellCooldown = SpellCooldown
ns.SpellCooldown = SpellCooldown

local SpellCharges = SpellCharges
ns.SpellCharges = SpellCharges

local SpellallCharges = SpellallCharges
ns.SpellallCharges = SpellallCharges

local SpellFullCharges = SpellFullCharges
ns.SpellFullCharges = SpellFullCharges

local SpellConut = SpellConut
ns.SpellConut = SpellConut

local cast_time = cast_time
ns.cast_time = cast_time

local casting_time = casting_time
ns.casting_time = casting_time

local channel_time = channel_time
ns.channel_time = channel_time

local Useing_spell = Useing_spell
ns.Useing_spell = Useing_spell

local Useingtime = Useingtime
ns.Useingtime = Useingtime

local cast_In = cast_In
ns.cast_In = cast_In

local cast_later = cast_later
ns.cast_later = cast_later

local Prev_Spell = Prev_Spell
ns.Prev_Spell = Prev_Spell

local Last_Spell = Last_Spell
ns.Last_Spell = Last_Spell

local Spell_Later = Spell_Later
ns.Spell_Later = Spell_Later
