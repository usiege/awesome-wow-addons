--OOPrint("OOData")


local OOLeaderInfo = {} -- 队长信息
local OOTeamInfo = {}	-- 团队信息
local OOTeamMemberInfo = {}	-- 团队成员信息
local OOGRaidRecord = {}	-- 金团帐本


local OODataDic = {
	Id = "", 		-- 自增id
	UName = "", 	-- 角色名
	ULv = "",		-- 角色等级
	CId = "",		-- 职业ID
	CNameZH = "",	-- 职业中文
	CampENS = "",	-- 阵营 英文 缩写
	CampEN = "",	-- 阵营 英文
	SerID = "",		-- 服务器ID
	SerNameZH = "",	-- 服务器 中文名
	RKey = "",		-- 随机字符串
	IId = "",		-- 物品ID
	GPrice = "",	-- 金币价格
	GPaid = ""		-- 金团是否已支付 (0, 1)
}



function OODataDic:new( o )
	o = o or {}
	setmetatable(o, self)
	self.__index = self
	return o
end
