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
-- /script 
function talk(msg, channel, time_pad)
    T,F=T or 0,F or CreateFrame("frame")
    if X then 
        X=nil
        ChatFrame3:AddMessage("talk off")
        --SendChatMessage("talk off","channel",nil,channel)
    else 
        X=function()
            local t=GetTime()
            if t-T>time_pad then
                SendChatMessage(msg,"channel",nil,channel)
                T=t
            end 
        end
        ChatFrame3:AddMessage("talk on")
        --SendChatMessage("talk on","channel",nil,channel) 
    end 
    F:SetScript("OnUpdate",X)
end
