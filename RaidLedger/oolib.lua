local _, ADDONSELF = ...

DEBUG = false

-- global things
_G.OOPrint = OOPrint
_G.OOIsInTable = OOIsInTable
_G.DEBUG = DEBUG


-- utils func
function OOPrint( xxx )
	-- body
	print(xxx)
end

function OOIsInTable(value, tbl)
	for k,v in ipairs(tbl) do
	  if v == value then
	  	return true;
	  end
	end
	return false;
end


-- 查看某值是否为表tbl中的key值
function table.kIn(tbl, key)
    if tbl == nil then
        return false
    end
    for k, v in pairs(tbl) do
        if k == key then
            return true
        end
    end
    return false
end
 
-- 查看某值是否为表tbl中的value值
function table.vIn(tbl, value)
    if tbl == nil then
        return false
    end
 
    for k, v in pairs(tbl) do
        if v == value then
            return true
        end
    end
    return false
end

_G.table = table
-------


-- addon utils
local OORaid = {
	member_list = {}, 						-- OOMember list 
	username_list = {}, 					-- username list, use this name recognize member, username -> member one by one
	raid_id = "",							-- raid uuid

	record = nil,							-- record 
	randomkey_list = {},					-- 用于生成的randomkey记录，每个名字对应一个
	record_index = 0,						-- 新生成一条数据自增，当清空时清0
}

local OORecord = {
	g_raid_number_of_people  = 0,			-- number of member 
	g_raid_record = {},						-- record list
	g_member_list = {},						-- OOMember list
}

local OOMember = {
	index = nil,	--在团队中的索引 用于获取在团队中的信息
	is_commander = false, 
	username = "",
	class_id = "",
	random_key = ""
}


-- local OOAccount = {
-- 	payment = false,
-- 	beneficiary = "",
-- 	type = "",
-- 	costtype = "",
-- 	cost = 0,
-- 	Id = "",
-- 	costcache = 0,
-- 	detail = {
-- 		displayname = "",
-- 		count = 1,
-- 		type = "",
-- 		item = "",
-- 		item_id = "",
-- 	},
-- }


-- class init
function OORaid:new(o)
	-- body
	local o = o or {}
	setmetatable(o, self)
	self.__index = self

	self.raid_id = ""
	self.member_list = {}
	self.randomkey_list = {}
	self.record_index = 0

	return o
end


function OORecord:new(o)
	-- body
	local o = o or {}
	setmetatable(o, self)
	self.__index = self

	self.g_raid_number_of_people  = 0
	self.g_raid_record = {}
	self.g_member_list = {}

	return o
end



-- function for record


-- function for raid

function OORaid:MemberCount( ... )
	-- body
	local count = 0
	for k,v in pairs(self.member_list) do
		count = count + 1
	end

	return count
end

function OORaid:MemberNames( ... )
	-- body
	return self.username_list
end

function OORaid:RandomKeylist( ... )
	-- body
	local code_list = {}
	-- 如果没有直接返回 
	if self.randomkey_list == {} or self.randomkey_list == nil then 
		return code_list 
	end

	-- get current random key list
	for k,v in pairs(self.randomkey_list) do
		-- if v.random_key ~= "" then
		-- 	table.insert(code_list, v.random_key)
		-- end
		table.insert(code_list, v)
	end

	return code_list
end

-- 为团员分配随机码
function OORaid:AssignRandomKey( member )
	-- body
	local username = member.username

	if table.kIn(self.randomkey_list, username) then
		return self.randomkey_list[username]
	end 

	-- generate code 
	code = string.format("%04d", math.random(1, 10000))
	local code_list = self:RandomKeylist()
	repeat
		if not table.vIn(code_list, code) then
			member.random_key = code
			self.randomkey_list[username] = code
			--table.insert(code_list, code)
		end
	until not table.vIn(code_list, code)

	return code
end


local function user_class_id( filename )
	return tostring(CAREER_ID[filename])
end

-- 根据成员所在队伍中的索引更新成员信息
function OORaid:UpdateMember( member, index )
	-- body
	if member == nil then return end
	if index == nil then return end
	local username = member.username
	
	member.index = index 
	member.username = username
	rk = self:AssignRandomKey(member)
	member.random_key = rk

	local name, rank, subgroup, level, class, filename, zone, online, isDead, role, isML
	= GetRaidRosterInfo(index)
	if DEBUG then print(GetRaidRosterInfo(index)) end

	-- 各字段见oolib
	member.is_commander = (index == 1)
	member.user_lv = tostring(level)
	member.class_id = user_class_id(filename)

	self.member_list[username] = member
end

-- 添加团队成员
function OORaid:AddMember( ... )
	-- body
	local username, index = ...
	if OOIsInTable(username, self:MemberNames()) then return end

	local new_member = OOMember:new(username)
	self:UpdateMember(new_member, index)

	--print(new_member.username, index)
	--
	self.member_list[username] = new_member
	table.insert(self.username_list, username)
end

function OORaid:GetMember( username )
	-- body
	for k,v in pairs(self.member_list) do
		if k == username then
			return v
		end
	end
	return nil
end

function OORaid:RemoveMember( username )
	-- body
	if not OOIsInTable(username, self:MemberNames()) then return end

	-- remove username 
	-- local member = self:GetMember(username)
	local member = self:GetMember(username)
	member = nil

	for i,v in ipairs(self.username_list) do
		if v == username then
			-- print(string.format("remove member: %s", username))
			-- print(self.username_list)
			-- print(i)
			table.remove(self.username_list, i)
			-- remove member 
			self.member_list[username] = nil
			return
		end
	end

	
end

function OORaid:ClearAll( ... )
	-- body
	self:ClearMembers()
	self:ClearRaidID()
	self:ClearRecords()
end

function OORaid:ClearRecords( ... )
	-- body
	self.record_index = 0
end

function OORaid:ClearMembers()
	-- body
	for i,v in ipairs(self:MemberNames()) do
		self:RemoveMember(v)
	end

	for k,_ in pairs(self.randomkey_list) do
		self.randomkey_list[k] = nil
	end
end

function OORaid:AssignRaidID( ... )
	-- body
	if not RaidLedgerDatabase then 
		-- print("raid ledger db is nil")
		return 
	end

	if not table.kIn(RaidLedgerDatabase, 'raid_id') then
		RaidLedgerDatabase["raid_id"] = uuid()
		self.raid_id = RaidLedgerDatabase["raid_id"]
	else
		self.raid_id = RaidLedgerDatabase["raid_id"]
	end	
end

function OORaid:ClearRaidID( ... )
	-- body
	self.raid_id = ""
	RaidLedgerDatabase["raid_id"] = nil
end

-- record for Raid
function OORaid:GetRecord( ... )
	
	local result = ""

	local record = self.record or OORecord:new()
	--print("uuid ----> " .. record.g_raid_id)
	record.g_raid_id 				= record.g_raid_id -- why need this ?
	record.g_raid_number_of_people 	= #self:MemberNames() or 0
	record.g_member_list 			= self.member_list or {}
	
	local db_items = OO.db:GetCurrentLedger()["items"]
	if db_items == nil then return luajson.table2json(record) end

	local account_lsit = {}
	for k,v in pairs(db_items) do
		--print(v)
		local account = OOAccount:new()
		account.Id 				= k 					-- 
		account.beneficiary 	= v.beneficiary
		account.type 			= v.type
		account.costtype 		= v.costtype
		account.cost 			= v.cost or 0
		account.costcache		= v.costcache
		account.payment			= v.payment				-- account.cost > 0
		account.detail			= v.detail
		account_lsit[k] = account
	end

	record.g_raid_record = account_lsit
	-- to json result
	result = luajson.table2json(record)

	if DEBUG then print(result) end
	return result
end

-- member 
function OOMember:new( username )

	local o = {}
	setmetatable(o, self)
	self.__index = self

	self.username = username

	return o
end


-- oo game main event code
do
	local ooraid = OORaid:new()
	local record = OORecord:new()
	ooraid.record = record


	_G.OO = ooraid
end


-- dubug code 
if DEBUG then
	print(OO.raid_id)
	print("this should run only one time.")
	-- local raid = OORaid:new()
	-- raid:AddMember("ddd")
	-- raid:AddMember("123")
	-- raid:AddMember("222")
	-- raid:AddMember("123")
	-- raid:AddMember("222")
	-- --raid:RemoveMember("222")

	-- for i,v in ipairs(raid:RandomKeylist()) do
	-- 	print(i,v)
	-- end

	-- for i,v in ipairs(raid.username_list) do
	-- 	print(i,v)
	-- end

end

