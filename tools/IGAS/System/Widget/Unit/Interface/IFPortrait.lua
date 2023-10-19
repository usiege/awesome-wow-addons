-- Author      : Kurapica
-- Create Date : 2012/06/25
-- Change Log  :

-- Check Version
local version = 3
if not IGAS:NewAddon("IGAS.Widget.Unit.IFPortrait", version) then
	return
end

_IFPortraitUnitList = _IFPortraitUnitList or UnitList(_Name)

function _IFPortraitUnitList:OnUnitListChanged()
	self:RegisterEvent("UNIT_PORTRAIT_UPDATE")
	self:RegisterEvent("UNIT_MODEL_CHANGED")
	self:RegisterEvent("UNIT_CONNECTION")
	self:RegisterEvent("PARTY_MEMBER_ENABLE")

	self.OnUnitListChanged = nil
end

function _IFPortraitUnitList:ParseEvent(event, unit)
	if type(unit) == "number" then
		unit = "party"..unit
	end

	self:EachK(unit, "Refresh", event == "UNIT_MODEL_CHANGED")
end

__Doc__[[IFPortrait is used to handle the unit's portrait updating]]
interface "IFPortrait"
	extend "IFUnitElement"

	------------------------------------------------------
	-- Event
	------------------------------------------------------

	------------------------------------------------------
	-- Method
	------------------------------------------------------
	__Doc__[[The default refresh method, overridable]]
	function Refresh(self, force)
		if self:IsClass(PlayerModel) then
			local unit = self.Unit
			local guid = unit and UnitGUID(unit) or nil
			if not unit or not UnitExists(unit) or not UnitIsConnected(unit) or not UnitIsVisible(unit) then
				self.Guid = nil
				self:SetCamDistanceScale(0.25)
				self:SetPortraitZoom(0)
				self:SetPosition(0,0,0.5)
				self:ClearModel()
				self:SetModel([[interface\\buttons\\talktomequestionmark.m2]])
			elseif force or guid ~= self.Guid then
				self.Guid = guid
				self:SetCamDistanceScale(1)
				self:SetPortraitZoom(1)
				self:SetPosition(0,0,0)
				self:ClearModel()
				self:SetUnit(self.Unit)
			end
		elseif self:IsClass(Texture) then
			self.PortraitUnit = self.Unit
		end
	end

	------------------------------------------------------
	-- Property
	------------------------------------------------------

	------------------------------------------------------
	-- Event Handler
	------------------------------------------------------
	local function OnUnitChanged(self)
		_IFPortraitUnitList[self] = self.Unit
	end

	------------------------------------------------------
	-- Dispose
	------------------------------------------------------
	function Dispose(self)
		_IFPortraitUnitList[self] = nil
	end

	------------------------------------------------------
	-- Constructor
	------------------------------------------------------
	function IFPortrait(self)
		self.OnUnitChanged = self.OnUnitChanged + OnUnitChanged
	end
endinterface "IFPortrait"