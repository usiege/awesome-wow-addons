-- hello azeroth

function HelloWorldLoad(frame)
	-- body
	frame:Hide()
	-- DEFAULT_CHAT_FRAME:AddMessage("HelloAzeroth is Loaded!");
	frame:RegisterEvent('CHAT_MSG_SAY')
end


function HelloWorldEvent(frame, event, arg1, arg2, ...)
	if(event == "CHAT_MSG_SAY") then
		DEFAULT_CHAT_FRAME:AddMessage(arg2.." said "..arg1);
		if arg1 == "hide" then
			frame:Hide()
		elseif arg1 == "show" then
			frame:Show()
		end
	end
end