-- Author      : Kurapica
-- Create Date : 2012/07/12
-- Change Log  :
--               2013/06/08 Make sure the object will be hidden

-- Check Version
local version = 3
if not IGAS:NewAddon("IGAS.Widget.Unit.IFResurrect", version) then
	return
end

-- The resurrect check
_RESURRECT_CHECKTIME = 2
_Resurrect_CheckThread = _Resurrect_CheckThread or setmetatable({}, {
	__index = function (self, unit)
		rawset(self, unit, Threading.Thread())
		return rawget(self, unit)
	end,
})

_IFResurrectUnitList = _IFResurrectUnitList or UnitList(_Name)

function _IFResurrectUnitList:OnUnitListChanged()
	self:RegisterEvent("INCOMING_RESURRECT_CHANGED")

	self.OnUnitListChanged = nil
end

function checkUnitForResurrect(unit)
	if UnitHasIncomingResurrection(unit) then
		_IFResurrectUnitList:EachK(unit, "Visible", true)

		-- Some times the resurrect event don't come when the target select resurrect to the tomb
		local thread = _Resurrect_CheckThread[unit]

		if thread:IsDead() then
			thread.Thread = function()
				while UnitHasIncomingResurrection(unit) do
					Threading.Sleep(_RESURRECT_CHECKTIME)
				end

				_IFResurrectUnitList:EachK(unit, "Visible", false)
			end

			-- Start the watcher
			thread()
		end
	else
		_IFResurrectUnitList:EachK(unit, "Visible", false)
	end
end

function _IFResurrectUnitList:ParseEvent(event)
	self:Each(checkUnitForResurrect)
end

__Doc__[[IFResurrect is used to handle the unit resurrection state's updating]]
interface "IFResurrect"
	extend "IFUnitElement"

	------------------------------------------------------
	-- Method
	------------------------------------------------------
	function Refresh(self)
		self.Visible = self.Unit and UnitHasIncomingResurrection(self.Unit)
	end

	------------------------------------------------------
	-- Property
	------------------------------------------------------
	__Doc__[[used to receive the result that whether the resurrection indicator should be shown]]
	__Optional__() property "Visible" { Type = Boolean }

	------------------------------------------------------
	-- Event Handler
	------------------------------------------------------
	local function OnUnitChanged(self)
		_IFResurrectUnitList[self] = self.Unit
	end

	------------------------------------------------------
	-- Dispose
	------------------------------------------------------
	function Dispose(self)
		_IFResurrectUnitList[self] = nil
	end

	------------------------------------------------------
	-- Initializer
	------------------------------------------------------
	function IFResurrect(self)
		self.OnUnitChanged = self.OnUnitChanged + OnUnitChanged

		-- Default Texture
		if self:IsClass(Texture) then
			if not self.TexturePath and not self.Color then
				self.TexturePath = [[Interface\RaidFrame\Raid-Icon-Rez]]
			end
		end
	end
endinterface "IFResurrect"