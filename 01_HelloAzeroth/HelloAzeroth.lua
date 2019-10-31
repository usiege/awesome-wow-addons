-- hello azeroth

function HelloWorldCommand(cmd) 
  myFrame = getglobal("HelloWorldTestFrame"); 
  if(not myFrame:IsShown()) then 
    myFrame:Show(); 
  else 
    myFrame:Hide(); 
  end 
end 

function HelloWorldLoad() 
    myFrame = getglobal("HelloWorldTestFrame"); 
    
    myFrame:Hide()
    DEFAULT_CHAT_FRAME:AddMessage("HelloAzeroth is Loaded!");

    myFrame:RegisterEvent("CHAT_MSG_SAY");
end 

function HelloWorldFrameUpdate() 
  textFPS = getglobal("HelloWorldTestFrameTextFPS"); 
  textDelay = getglobal("HelloWorldTestFrameTextDelay"); 
  textMoney = getglobal("HelloWorldTestFrameTextMoney"); 
  down, up, lag = GetNetStats(); 

  textFPS:SetText("FPS   "..floor(GetFramerate())); 
  textDelay:SetText("Delay   "..lag.." ms"); 
  textMoney:SetText("Money   "..floor(GetMoney()/10000).." G"); 
end

function HelloWorldEvent() 
  if(event == "CHAT_MSG_SAY") then 
    DEFAULT_CHAT_FRAME:AddMessage(arg2.." said "..arg1); 
  end 
end

_G.SLASH_HELLOWORLD1 = "/helloazeroth"; 
_G.SLASH_HELLOWORLD2 = "/ha"; 
_G.SlashCmdList["HELLOWORLD"] = HelloWorldCommand;