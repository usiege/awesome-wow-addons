-- /script talk(1, 5, "内容")
-- ChatFrame1:AddMessage("talk")
function talk(channel, time_pad, msg)
    T,F=T or 0,F or CreateFrame("frame")
    if TALK then 
        TALK=nil
        ChatFrame3:AddMessage("喊话关闭")
        --SendChatMessage("talk off","channel",nil,channel)
    else 
        TALK=function()
            local t=GetTime()
            if t-T>time_pad then
                SendChatMessage(msg,"channel",nil,channel)
                T=t
            end 
        end
        ChatFrame3:AddMessage("喊话开启")
        --SendChatMessage("talk on","channel",nil,channel) 
    end 
    F:SetScript("OnUpdate",TALK)
end
