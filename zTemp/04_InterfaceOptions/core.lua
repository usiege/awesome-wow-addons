WelcomeHome = LibStub("AceAddon-3.0"):NewAddon("WelcomeHome", "AceConsole-3.0")

local options = {
    name = "WelcomeHome",
    hadler = WelcomeHome,
    type = 'group',
    args = {
        msg = {
            type = 'input',
            name = 'Message',
            desc = '---',
            usage = "--",
            get = "GetMessage",
            set = "SetMessage",
        },
    },
}

function WelcomeHome:OnInitialize()
    -- Called when the addon is loaded

    -- Interface Frame
    LibStub("AceConfig-3.0"):RegisterOptionsTable("WelcomeHome", options)

    self.optionsFrame = LibStub("AceConfigDialog-3.0"):
    AddToBlizOptions("WelcomeHome", "WelcomeHome")
    self.RegisterChatCommand("wh", "ChatCommand")
    WelcomeHome.message = "Welcome home!"
end

function WelcomeHome:ChatCommand(input)
    if not input or input:trim() == "" then
        InterfaceOptionsFrame_OpenToCategory(self.optionsFrame)
    else
        LibStub("AceConfigCmd-3.0"):HandleCommand("wh", "WelcomeHome", input)
    end
end


function WelcomeHome:OnEnable()
    -- Called when the addon is enabled
    self:Print("04_InterfaceOptions")

end

function WelcomeHome:OnDisable()
    -- Called when the addon is disabled
end


function WelcomeHome:GetMessage(info)
    return self.message
end

function WelcomeHome:SetMessage(info, newValue)
    self.message = newValue
end
