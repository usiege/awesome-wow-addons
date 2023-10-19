-- Author      : Kurapica
-- Create Date : 2012/07/12
-- Change Log  :

-- Check Version
local version = 1
if not IGAS:NewAddon("IGAS.Widget.Unit.IFGroupLoot", version) then
	return
end

_All = "all"
_IFGroupLootUnitList = _IFGroupLootUnitList or UnitList(_Name)

function _IFGroupLootUnitList:OnUnitListChanged()
	self:RegisterEvent("PARTY_LOOT_METHOD_CHANGED")
	self:RegisterEvent("GROUP_ROSTER_UPDATE")

	self.OnUnitListChanged = nil
end

function _IFGroupLootUnitList:ParseEvent(event)
	self:EachK(_All, "Refresh")
end

__Doc__[[IFGroupLoot is used to handle the root master indicator's updating]]
interface "IFGroupLoot"
	extend "IFUnitElement"

	------------------------------------------------------
	-- Method
	------------------------------------------------------
	function Refresh(self)
		local unit = self.Unit
		if unit and (UnitInParty(unit) or UnitInRaid(unit)) then
			local method, pid, rid = GetLootMethod()

			if(method == 'master') then
				local mlUnit
				if(pid) then
					if(pid == 0) then
						mlUnit = 'player'
					else
						mlUnit = 'party'..pid
					end
				elseif(rid) then
					mlUnit = 'raid'..rid
				end

				self.Visible = UnitIsUnit(self.Unit, mlUnit)
			else
				self.Visible = false
			end
		else
			self.Visible = false
		end
	end

	------------------------------------------------------
	-- Property
	------------------------------------------------------
	__Doc__[[used to receive the result that whether the root master indicator should be shown]]
	__Optional__() property "Visible" { Type = Boolean }

	------------------------------------------------------
	-- Dispose
	------------------------------------------------------
	function Dispose(self)
		_IFGroupLootUnitList[self] = nil
	end

	------------------------------------------------------
	-- Initializer
	------------------------------------------------------
	function IFGroupLoot(self)
		_IFGroupLootUnitList[self] = _All

		-- Default Texture
		if self:IsClass(Texture) then
			if not self.TexturePath and not self.Color then
				self.TexturePath = [[Interface\GroupFrame\UI-Group-MasterLooter]]
			end
		end
	end
endinterface "IFGroupLoot"