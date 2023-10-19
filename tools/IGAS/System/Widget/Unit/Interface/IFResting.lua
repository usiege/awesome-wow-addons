-- Author      : Kurapica
-- Create Date : 2012/07/12
-- Change Log  :

-- Check Version
local version = 1
if not IGAS:NewAddon("IGAS.Widget.Unit.IFResting", version) then
	return
end

_IFRestingUnitList = _IFRestingUnitList or UnitList(_Name)

function _IFRestingUnitList:OnUnitListChanged()
	self:RegisterEvent("PLAYER_UPDATE_RESTING")

	self.OnUnitListChanged = nil
end

function _IFRestingUnitList:ParseEvent(event)
	self:EachK("player", "Refresh")
end

__Doc__[[
	<desc>IFResting is used to handle the unit resting state's updating</desc>
	<optional name="Visible" type="property" valuetype="boolean"></optional>
]]
interface "IFResting"
	extend "IFUnitElement"

	------------------------------------------------------
	-- Method
	------------------------------------------------------
	function Refresh(self)
		self.Visible = self.Unit == "player" and IsResting()
	end

	------------------------------------------------------
	-- Property
	------------------------------------------------------
	__Doc__[[used to receive the result that whether the resting indicator should be shown]]
	__Optional__() property "Visible" { Type = Boolean }

	------------------------------------------------------
	-- Event Handler
	------------------------------------------------------
	local function OnUnitChanged(self)
		if self.Unit == "player" then
			_IFRestingUnitList[self] = self.Unit
		else
			_IFRestingUnitList[self] = nil
			self.Visible = false
		end
	end

	------------------------------------------------------
	-- Dispose
	------------------------------------------------------
	function Dispose(self)
		_IFRestingUnitList[self] = nil
	end

	------------------------------------------------------
	-- Initializer
	------------------------------------------------------
	function IFResting(self)
		self.OnUnitChanged = self.OnUnitChanged + OnUnitChanged

		-- Default Texture
		if self:IsClass(Texture) then
			if not self.TexturePath and not self.Color then
				self.TexturePath = [[Interface\CharacterFrame\UI-StateIcon]]
				self:SetTexCoord(0, .5, 0, .421875)
			end
		end
	end
endinterface "IFResting"