local tingfeng = ...;

-- 

function fish()
    T,F=T or 0, F or CreateFrame("frame")
    if X then 
        X=nil 
    else 
        X=function()
            local t=UnitXP("player") 
            AcceptGroup() 
            StaticPopup1Button1:Click() 
            if UnitIsGroupLeader("player") then 
                LeaveParty() 
                T=t 
            end 
        end 
    end 
    F:SetScript ("OnUpdate",X)
end


-- 
-- /script talk(1, 5, "内容")
function talk(channel, time_pad, msg)
    T,F=T or 0,F or CreateFrame("frame")
    if TALK then 
        TALK=nil
        ChatFrame3:AddMessage("talk off")
        --SendChatMessage("talk off","channel",nil,channel)
    else 
        TALK=function()
            local t=GetTime()
            if t-T>time_pad then
                SendChatMessage(msg,"channel",nil,channel)
                T=t
            end 
        end
        ChatFrame3:AddMessage("talk on")
        --SendChatMessage("talk on","channel",nil,channel) 
    end 
    F:SetScript("OnUpdate",TALK)
end
