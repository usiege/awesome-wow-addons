---------------------------------------------------------------------------
--[[                         Event                            ]]--
---------------------------------------------------------------------------
local addon, ns = ...

--本地变量
local PDENV = CreateFrame("Frame")
local handlers = {} --触发事件后处理的函数表

--事件注册
function RegisterEvent(event, handler)
    handlers[event] = handlers[event] or {}
    table.insert(handlers[event], handler)
    PDENV:RegisterEvent(event)
end

--事件注销
function UnregisterEvent(event, handler)
    local hands = handlers[event]
    if not hands then return end
    for i = #hands, 1, -1 do
        if hands[i] == handler then
            table.remove(hands, i)
        end
    end
end

--事件触发
PDENV:SetScript("OnEvent", function(self,event,...)
    local eventHandlers = handlers[event]
    if not eventHandlers then return end
    for i, handler in pairs(eventHandlers) do
        handler(event, ...)
    end
end)

local PDENV = PDENV
ns.PDENV = PDENV