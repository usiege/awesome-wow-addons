# API收集及示例说明


- `SendChatMessage`
```
SendChatMessage("talk ...", "channel", nil, 1)
```
在频道1发送文字 'talk ...'

- `ChatFrame{数字}:AddMessage`
```
ChatFrame3:AddMessage("talk off")
```
在聊天标签窗口｛数字｝内输出文字 'talk off'


- `DEFAULT_CHAT_FRAME`
当前选定的聊天标签窗口，默认为第一个标签


