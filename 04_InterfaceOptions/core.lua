WelcomeHome = LibStub("AceAddon-3.0"):NewAddon("WH", "AceConsole-3.0")

local options = {
    name = "这里是插件显示",
    handler = WelcomeHome,
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
    LibStub("AceConfig-3.0"):RegisterOptionsTable("WH", options, {"wh"})

    self.optionsFrame = LibStub("AceConfigDialog-3.0"):AddToBlizOptions("WH", "WelcomeHome")
    self.RegisterChatCommand("wh", "ChatCommand")
    WelcomeHome.message = "Welcome home!"
end

function WelcomeHome:ChatCommand(input)
    if not input or input:trim() == "" then
        InterfaceOptionsFrame_OpenToCategory(self.optionsFrame)
        UIErrorsFrame:AddMessage(self.message, 1.0, 1.0, 1.0, 5.0)
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
