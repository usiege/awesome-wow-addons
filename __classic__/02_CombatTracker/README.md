# 听风的插件DIY-02-正在战斗中

标签（空格分隔）： wow

---

上篇我们跟插件打了个招呼，本篇我们要介绍一个简单的战斗统计插件，这个插件的主要功能是在玩家战斗开始发生时提示玩家正在处于战斗，并在战斗结束时显示战斗过程中的一些信息。


## 文件结构

我们来复习一下文件结构。在wow游戏目录`Interface/Addons`下创建新的文件夹。注意目录我们只能用英文和数字或者一部分符号（英文和数字的组合是一个好的习惯），为了配合我的教程，我的命名方式继续以“数字 + _ + 英文”的形式——"02_CombatTracker"。想要在魔兽世界游戏中能显示插件，我们需要有一个与文件夹同名的toc文件`02_CombatTracker.toc`。至止，新的插件已经可以在游戏中进行勾选了。

![WX20191115-092338.png-196.5kB][1]

接下来我们要在`TOC`文件中添加必要的信息，注意下面的代码，`##`后面的内容是游戏的一些必要信息，包括将来要在游戏插件界面显示的内容，`#`表示注释可以忽略。
```
## Interface: 20300
## Title: 02-CombatTracker
## Title-zhCN: 正在战斗中
## Author: 听风 
## Notes: 听风DIY的第一个战斗插件，这里是对插件的说明。
## Description: 这是听风DIY教程系列的第二个插件，这是一个战斗插件。

CombatTracker.lua
CombatTracker.xml
```
- Title | Title-zhCN
这里要说明的是其中的`Title`部分以及`Title-zhCN`，暴雪为插件本地化提供多个说明字段，如对语言字段进行多个说明，插件将会根据游戏设置的语言自动进行选择，例如我这里游戏选择的是简体中文，而我又对插件的中文名字进行了声明，那么在游戏插件界面显示的名字应该为“听风的第一个战斗插件”。

- Interface
这个数字对应游戏的版本号，

- Author
插件作者

- Notes | Notes-zhCN
这个说明会显示在游戏中，当鼠标键移动到插件名称上显示的内容，该语言显示规则与`Title`是一样的。

- 加载文件
在`toc`文件的最后我们要把该插件所需要加载的所有代码文件相对路径填写完整，我们的相对路径是指我们自己DIY插件的文件夹下的所有文件路径，比如我这里`01_CombatTracker`目录下有两个文件，`CombatTracker.lua`，`CombatTracker.xml`（注意`.lua`要先于`.xml`）

## 界面

![WX20191115-092526.png-768.9kB][2]

```xml
<Ui xmlns="http://www.blizzard.com/wow/ui"
xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
xsi:schemaLocation="http://www.blizzard.com/wow/ui..\FrameXML\UI.xsd">

    <Button name="CombatTrackerFrame" parent="UIParent" enableMouse="true"
    movable="true" frameStrata="LOW">
        <Size x="175" y="40"/>
        <Anchors>
            <Anchor point="TOP" relativePoint="BOTTOM" relativeTo="Minimap">
                <Offset x="0" y="0"/>
            </Anchor>
        </Anchors>
        <Backdrop bgFile="Interface\DialogFrame\UI-DialogBox-Background"
        edgeFile="Interface\DialogFrame\UI-DialogBox-Border" tile="true">
            <BackgroundInsets>
                <AbsInset left="11" right="12" top="12" bottom="11"/>
            </BackgroundInsets>
            <TileSize>
                <AbsValue val="32"/>
            </TileSize>
            <EdgeSize>
                <AbsValue val="32"/>
            </EdgeSize>
        </Backdrop>
        <Layers>
            <Layer level="OVERLAY">
                <FontString name="$parentText" inherits="GameFontNormalSmall"
                justfyH="CENTER" setAllPoints="true" text="CombatTracker"/>
            </Layer>
        </Layers>

        <Scripts>
            <OnLoad>
                CombatTracker_OnLoad(self)
            </OnLoad>
            <OnEvent>
                CombatTracker_OnEvent(self, event, ...)
            </OnEvent>
            <OnClick>
                CombatTracker_ReportDPS()
            </OnClick>
            <OnDragStart>
                self:StartMoving()
            </OnDragStart>
            <OnDragStop>
                self:StopMovingOrSizing()
            </OnDragStop>
        </Scripts>
     </Button>
</Ui>
```

仍旧我们来对界面进行拆解：

```xml
<Ui xmlns="http://www.blizzard.com/wow/ui"
xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
xsi:schemaLocation="http://www.blizzard.com/wow/ui..\FrameXML\UI.xsd">
</Ui>
```
以`<Ui />`标签对包裹用来加载插件界面，标签内容是固定写法。

```xml
<Button name="CombatTrackerFrame" parent="UIParent" enableMouse="true"
    movable="true" frameStrata="LOW">
        <Size x="175" y="40"/>
</Button>
```
接下来是`<Button />`，上一篇我们用的是`<Frame />`，都是用来展示用的，区别是`<Button />`有专门的点击功能，“专门”的意思就是它设计来本身就是为了点击事件，就像我们在手机App里遇到的按钮一样；`<Frame />`本身也是可以有点击等各种事件的，只不过我们平时不这么用。其实两者并没有什么大的差别。

关于`<Button />`和`<Frame />`等关于`xml`界面布局的相关内容，我们将在后面单做为一节来讲解，此处我们着重讲解战斗的事件部分。这里简单说明下：

- `<Size />`标签定义了控件大小；
- `<Anchor />`定义的是控件初始化时在屏幕上的位置；
- `<Backdrop />`背景及显示的颜色，图片，透明度，边框等；
- `<Layers />`中定义了字体；
- `<Script />`中定义了所有事件；


同上篇一样，我们加载一个简单的界面，这个界面也只是显示一行文字。不同的是，本篇我们的文字不再是固定的一行文字，我们要在战斗发生时让显示的文字发生变化。


## 由上篇中的事件引出

我们先来复习一下上篇中的“说话事件”。

![WX20191115-092819.png-1074.9kB][3]

我们在`<OnLoad />`标签(即插件加载时)

```xml
<OnLoad>
    HelloWorldLoad(self)
</OnLoad>
```

运行了`HelloWorldLoad`函数：

在上节我有一点忘记说明了，在游戏代码编写过程中，在`.lua`文件里有看到行首以`--`两个减号开头的表示代码的注释，意思在该行之后可以书写一些文字用来解释，这些行是可以完全无视的，如果你不需要他们，可以删去。我在这里写的注释是对插件作说明用。

我们在`.xml`文件中可以看到，当插件加载时运行了函数`HelloWorldLoad`并传入了参数`self`，这里强调一下`self`就是这个控件本身，是包裹该标签的上级标签所表示的控件，即上篇中的`<HelloWorldFrame />`；

```lua
function HelloWorldLoad(frame)
    -- 这里的 frame 对应上面的 self
    -- 下面一行代码将插件的界面隐藏
    frame:Hide()
    
    -- 'DEFAULT_CHAT_FRAME'这个变量表示当前游戏中正在激活的聊天标签页，
    -- 例如：“综合”，“战斗记录”
    -- 或者新建的自定义标签页
    -- 下面一行表示在激活的聊天标签页输出一行文字
    DEFAULT_CHAT_FRAME:AddMessage("HelloAzeroth is Loaded!");
    
    -- 这里是我们的重点
    -- 这一行就表示我们要在游戏中响应的事件
    -- 上一节我们的事件是“当周围玩家在进行说话时”
    frame:RegisterEvent('CHAT_MSG_SAY')
end
```


## 事件处理

```
local tingfeng = ...;

-- Set up some local variables to track time and damage
local start_time = 0 -- 战斗开始时间
local end_time = 0 -- 战斗结束时间
local total_time = 0 -- 战斗总时间
local total_damage = 0 -- 受到的总伤害
local average_dps = 0 -- 平均承受伤害

function CombatTracker_OnLoad(frame)
    -- event 
    frame:RegisterEvent("UNIT_COMBAT")
    frame:RegisterEvent("PLAYER_REGEN_ENABLED")
    frame:RegisterEvent("PLAYER_REGEN_DISABLED")
    
    -- mouse
    frame:RegisterForClicks("RightButtonUp")
    frame:RegisterForDrag("LeftButton")
end

-- 对应上面注册的所有事件
function CombatTracker_OnEvent(frame, event, ...)
    -- 玩家退出战斗的事件
    if event == "PLAYER_REGEN_ENABLED" then
        -- this event is called when the player exits combat
        end_time = GetTime()
        -- 计算总时间
        total_time = end_time - start_time
        CombatTracker_UpdateText()
    -- 玩家战斗退出时触发
    elseif event == "PLAYER_REGEN_DISABLED" then
        -- this event is called when we enter combat 
        -- reset the damage total and start the timer
        CombatTrackerText:SetText("战斗中...")
        total_damage = 0
        start_time = GetTime()

    -- 这个事件在战斗过程中会多次调用
    elseif event == "UNIT_COMBAT" then
        if not InCombatLockdown() then
            -- we are not in combat, so ignore the event
        else
            local unit, action, modifier, damage, damagetype = ...
            if unit == "player" and action ~= "HEAL" then
                total_damage = total_damage + damage
                end_time = GetTime()
                total_time = end_time - start_time
                average_dps = total_damage / total_time
                
                CombatTracker_UpdateText()
            end
        end
    end 
end

-- 这个函数更新我们界面上控件的显示
function CombatTracker_UpdateText()
    local status = string.format("%d 秒 | %d 伤害 | %.2f DPS", total_time, total_damage, average_dps)
    CombatTrackerText:SetText(status)
end

-- 报告战斗每秒受到的伤害
function CombatTracker_ReportDPS()
    local msgformat = "%d 时间内共计伤害 %d . 平均每秒受到伤害为 %.2f"
    local msg = string.format(msgformat, total_time, total_damage, average_dps)
    ChatFrame3:AddMessage(msg)
end

```

我们对应战斗中的事件来给出直观感受；

先是界面加载时我们要注册一系列的事件，在`CombatTracker_OnLoad`中，

```
-- 事件1
frame:RegisterEvent("UNIT_COMBAT")
-- 事件2
frame:RegisterEvent("PLAYER_REGEN_ENABLED")
-- 事件3
frame:RegisterEvent("PLAYER_REGEN_DISABLED")
-- 事件4
frame:RegisterForClicks("RightButtonUp")
-- 事件5
frame:RegisterForDrag("LeftButton")
```

首先我们将框体移动到屏幕中间（对应事件5，后面会讲到），用来查看效果，战斗开始前，如图中显示：

![WX20191115-093346.png-680kB][4]

使用技能打怪进入战斗，对应事件3，此时界面开始发生变化，

![WX20191115-095632.png-559kB][5]

相应的代码为：

```
elseif event == "PLAYER_REGEN_DISABLED" then
        CombatTrackerText:SetText("战斗中...")
        total_damage = 0
        start_time = GetTime()
```

`CombatTrackerText`对应`xml`文件中的`$parentText`，之前我们说到`$parent`是可以做替换的，替换内容为父控件的名称，即`CombatTracker`。这里`CombatTrackerText`就是显示的字体控件，被包含在了我们的插件父框体中。我们在刚开始发生战斗时保存了开始时间，并把总伤害值设置为0，还修改了显示的文字；

在战斗过程中，怪物会对我造成伤害，此时对应事件1，代码：

```
elseif event == "UNIT_COMBAT" then
        if not InCombatLockdown() then
            -- we are not in combat, so ignore the event
        else
            local unit, action, modifier, damage, damagetype = ...
            if unit == "player" and action ~= "HEAL" then            
                -- 总伤害计算
                total_damage = total_damage + damage
                -- 每次受到伤害时的时间
                end_time = GetTime()
                -- 总时间计算
                total_time = end_time - start_time
                -- 平均承受伤害计算
                average_dps = total_damage / total_time
                
                -- 更新界面
                CombatTracker_UpdateText()
            end
        end
    end 
```

同时界面开始更新：

![WX20191115-100326.png-449.4kB][6]

这段代码表示当人物为玩家，且事件为受到的伤害时，我们记录每次受到的伤害，把它们加起来并计算每秒受到的伤害，之后更新界面。

这里我们的变量`unit, action, modifier, damage, damagetype`是与事件相关联的，每种事件的参数不同，如有需要请查看魔兽世界API，官方会有详细说明。这里不多做讲解。

怪物被打死，战斗事件结束，对应事件2，给出报告结果：

![WX20191115-101159.png-395.1kB][7]

对应代码如下：

```
if event == "PLAYER_REGEN_ENABLED" then
    end_time = GetTime()
    -- 计算总时间
    total_time = end_time - start_time
    CombatTracker_UpdateText()
```

战斗结束，计算总时间，并更新界面；

以上给出了所有事件的发生情况及插件对应的处理，总结起来就是事件1，2，3：

```
UNIT_COMBAT
```
事件1，战斗过程中事件；

```
PLAYER_REGEN_ENABLED
```
事件2，退出战斗事件；

```
PLAYER_REGEN_DISABLED
```
事件3，进入战斗事件；

最后还有两个事件，分别是“鼠标左键拖动”（事件4）和“鼠标右键点击”（事件5）；

在`xml`文件中：

```
<OnClick>
    CombatTracker_ReportDPS()
</OnClick>
<OnDragStart>
    self:StartMoving()
</OnDragStart>
<OnDragStop>
    self:StopMovingOrSizing()
</OnDragStop>
```
其中的`<OnClick />`标签对应`frame:RegisterForClicks("RightButtonUp")`，
`<OnDragStart />`和`<OnDargStop>`标签对应`frame:RegisterForDrag("LeftButton")`，

```
self:StartMoving()
self:StopMovingOrSizing()
```
上面这两句是系统API，表示拖拽移动。

最后就是事件4，右键点击我们写了一个自己的函数报告战斗结果`CombatTracker_ReportDPS`：

```
-- 报告战斗每秒受到的伤害
function CombatTracker_ReportDPS()
    local msgformat = "%d 时间内共计伤害 %d . 平均每秒受到伤害为 %.2f"
    local msg = string.format(msgformat, total_time, total_damage, average_dps)
    -- 在聊天标签窗口3中输出
    ChatFrame3:AddMessage(msg)
end
```

![WX20191115-103146.png-1371.8kB][8]

好了，今天的战斗插件统计插件我们就讲解完成了。感兴趣的点点关注哦。
微信公众号“艾泽拉斯日常（azeroth-daily）”。


  [1]: http://static.zybuluo.com/usiege/wgxyp1im8a2h0qpo6ya90fko/WX20191115-092338.png
  [2]: http://static.zybuluo.com/usiege/q4mdp8ji8ljyqkxwxnbv7ytc/WX20191115-092526.png
  [3]: http://static.zybuluo.com/usiege/9l4t49ijb9rwjyn7cub3yv70/WX20191115-092819.png
  [4]: http://static.zybuluo.com/usiege/ai12pg7122fvtutn4knwyt78/WX20191115-093346.png
  [5]: http://static.zybuluo.com/usiege/cdssm53cd7sor37dibv7jp2i/WX20191115-095632.png
  [6]: http://static.zybuluo.com/usiege/39dxe98go0z3gqtlvr18694k/WX20191115-100326.png
  [7]: http://static.zybuluo.com/usiege/iu4iii6lk5okftz7mzrey4fs/WX20191115-101159.png
  [8]: http://static.zybuluo.com/usiege/o1a497tuz32r2w5idp0izmo4/WX20191115-103146.png