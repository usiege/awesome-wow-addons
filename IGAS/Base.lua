-- Author		:	Kurapica
-- Create Date	:	2011/01/21
-- ChangeLog    :
--                  2013/08/05 Remove the version check, seal the metatable for IGAS

IGAS = setmetatable({}, {
	-- __call
	-- get the addons that stored in the IGAS's addon system
	-- like IGAS("IGAS") return the addon object of the igas
	__call = function(self, name)
		if rawget(self, "GetAddon") and name and type(name) == "string" and name ~= "" then
			return self:GetAddon(name)
		end
	end,

	-- __index
	-- 1. get the wrapper of existed ui elements, like IGAS.UIParent to get the wrapper of UIParent
	-- 2. get the namespace of the class system, like IGAS.System.Widget.Form return the Form class
	__index = function(self, key)
		-- Return the namespace of the given name
		if rawget(self, "GetNameSpace") and type(key) == "string" then
			local ns = self:GetNameSpace(key)

			if ns then
				rawset(self, key, ns)
				return ns
			end
		end

		-- Return the wrapper object of the given ui element's global name
		if rawget(self, "GetWrapper") and _G[key] and _G[key][0] then
			local frame = _G[key]

			if type(frame) == "table" and type(frame[0]) == "userdata" then
				rawset(self, key, self:GetWrapper(frame))
				return rawget(self, key)
			end
		end
	end,

	-- seal the metatable
	__metatable = true,
})
