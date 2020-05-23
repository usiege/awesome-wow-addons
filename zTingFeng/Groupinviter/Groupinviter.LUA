function Groupinviter_OnLoad(frame)
  ChatFrame3:AddMessage("Groupinviter onload.")
  frame:RegisterEvent("CHAT_MSG_WHISPER");
end

function Groupinviter_OnEvent(frame, arg1, arg2, ...)
  DEFAULT_CHAT_FRAME:AddMessage("---------------------------")
  DEFAULT_CHAT_FRAME:AddMessage(arg1)
  DEFAULT_CHAT_FRAME:AddMessage(arg2)
  DEFAULT_CHAT_FRAME:AddMessage("---------------------------")

  if (string.find(arg1, "1") ~= nil) 
    or string.find(arg1, "2") ~= nil
    or string.find(arg1, "+") ~= nil
    or string.find(arg1, "组") ~= nil 
    or string.find(arg1, "inv") ~= nil then
    InviteUnit(arg2);
    SendChatMessage("欢迎乘坐本次飞机，正在施法，请稍等。", "WHISPER", nil , arg2);
  end
end