# [听风的插件DIY-01-你好艾泽拉斯](https://www.zybuluo.com/usiege/note/1625793)

标签（空格分隔）： wow

---

之前我们介绍了wow插件的构成和使用，从这篇开始我们将要学习自己DIY插件，我们从一个简单的例子开始学习。你一定有很多顾虑，如果你想问在学习之前我们需不需要有一些编程方面的基础，答案是：不需要。只要你是游戏玩家，你要你玩过游戏，这些看起来so easy! 魔兽世界都肝这么多年了，你还觉得有什么事比肝魔兽更难的吗?跟着我的教程，一起创造属于我们自己的“艾泽拉斯”。

当然你如果并不清楚插件是什么以及如何运作，你只需要看下我之前的文章，简单的了解之后，我们就可以切入正题了。



## 我们需要的工具

- 魔兽世界客户端
- 可以编写代码的文本工具
文本工具有很多，如果你不想费事去找，那么用系统自带的记事本工具也完全可以，我这里推荐几个比较好用的软件，可以去自行百度。
    - `Sublime text 3`
    - `Atom`
    如果你会用`Markdown`还可以:
    - `作业部落`
    - `Evernote`
    ![1029-0.png-51.6kB][1]

## 插件的组织方式

关于这个内容我们在先前的文章中也有提到过，如下：

我们所要编写的所有插件都会保存在wow游戏客户端`Interface/AddOns`目录下，如图：

![1029-1.png-2.2kB][2]

接下来我们需要开始在`AddOns`下创建我们第一个插件目录`01_HelloAzeroth`，

```
├─README.md
├─01_HelloAzeroth
│  ├─01_HelloAzeroth.toc
│  ├─HelloAzeroth.lua
│  ├─HelloAzeroth.xml
│  └─README.md
└─...
```
如上结构，我们在Addons下创建文件夹`01_HelloAzeroth`，在文件夹下用前面提到的文本工具创建同名的`01_HelloAzeroth.toc`TOC格式文件，注意这里的`.toc`格式文件必须与文件夹名称相同，且后缀必须是`.toc`，否则魔兽客户端内不会对插件进行识别。

进行完这一步我们在`.toc`文件里填写如下内容：
```
# 这是听风编写的第一个插件
# 注意我前面是一个“#”开头的，这个表示注释，可以无视
# 下面的两个“##”开头的，是插件相关，在下面会做具体讲解

## Interface: 20400 
## Title: 01-你好艾泽拉斯 
## Notes: I am just trying to say hello to my azeroth world.
## Notes-zhCN: 我只是在向我的艾泽拉斯世界问好。
## Author: 听风
## DefaultState: Enabled
## Version: 1.0.0 

HelloAzeroth.lua 
HelloAzeroth.xml
```
先不着急解释，编写完TOC文件，我们打开游戏客户端查看，我们编写的插件已经出现在游戏里了。

![QQ20191030-093221.png-300.3kB][3]

## TOC文件的解释

在`01_HelloAzeroth.toc`文件的开头用一个“#”写的内容表示注释，是方便我们自己作记录用的，它们不会对插件产生任何影响。我们完全可以写一些文字来让我们清楚自己编写插件的思路等等。

下面的第二部分用两个“#”开头的内容是插件相关信息，我们先前也有过解释，这里我们只解释本插件中提到的。

TODO:链接

适用的魔兽版本号
```
## Interface: 20400
```
插件名称，对应游戏内显示
```
## Title: 01-你好艾泽拉斯
```
游戏内鼠标移到插件上所显示的内容，以下不同语言对应游戏当前显示语言
```
## Notes: I am just trying to say hello to my azeroth world.
## Notes-zhCN: 我只是在向我的艾泽拉斯世界问好。
```
插件作者
```
## Author: 听风
```
DefaultState: 默认状态 disabled 不可用 Enabled 可用
```
## DefaultState: Enabled
```
插件的版本，这个版本与游戏版本号无关
```
## Version: 1.0.0 
```

最后第三部分是游戏加载时所要加载的文件，这些文件内会有插件的界面以及事件脚本文件代码，接下来我们要开始正式编写插件了。
```
HelloAzeroth.lua 
HelloAzeroth.xml
```
这里所列出的文件应该与`.toc`文件处于同一路径下，当然如果文件位于`01_HelloAzeroth`目录下的子目录`Hello`，则应该写成相对路径，比如这样：
```
Hello/HelloAzeroth.lua
Hello/HelloAzeroth.xml
```

## HelloAzeroth

我们的插件需要一个界面，同时需要处理一些游戏中的事件，在我们自己的插件目录下创建两个文件，`HelloAzeroth.lua`和`HelloAzeroth.xml`，前者用来处理事件，后者用来描述界面。

### 做一个简单的界面

先来说界面，我们用`.xml`描述插件的界面，在本篇中我们简单的加载了一个框，在上面我们显示一些游戏内的信息。

我们完全可以用`.xml`来完成界面编辑，下面我们将编辑界面，完整的代码在这里，[https://github.com/usiege/Addons/blob/master/01_HelloAzeroth/HelloAzeroth.xml][4] 别急，我们将逐行进行解释。

这个界面的代码所展示的内容如图：

![WX20191104-192614.png-354.8kB][5]

不懂XML语言也完全没有关系，我们只要知道所有的标签都是成对出现的就可以了，如果对上面的内容进行简化，则上面的代码的结构将会是下面这个样子。

```
<Ui xmlns="http://www.blizzard.com/wow/ui"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xsi:schemaLocation="http://www.blizzard.com/wow/ui..\FrameXML\UI.xsd">
    <Frame name="HelloWorldTestFrame" parent="UIParent" enableMouse="true"
    movable="true" frameStrata="LOW">
        <Size x="300" y="150" />
        <TitleRegion setAllPoints="true" /> 
        <Anchors> 
            <Anchor point="CENTER" /> 
        <Anchors> 
        <Backdrop bgFile="Interface\DialogFrame\UI-DialogBox-Background" edgeFile="Interface\DialogFrame\UI-DialogBox-Border"> 
        <Backdrop> 
        <Layers> 
        <Layers> 
        <Scripts>
        </Scripts>
    </Frame> 
</Ui>
```

- `<Ui />`
wow插件以`<Ui> </Ui>`包裹，下面的格式是固定的，在这个标签对里的内容将会对界面进行设置：
```
<Ui xmlns="http://www.blizzard.com/wow/ui"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xsi:schemaLocation="http://www.blizzard.com/wow/ui..\FrameXML\UI.xsd">
</Ui>
```

> 这里要说明一下xml标签的两种形式，一种是简化的如`<Ui xmlns="http://www.blizzard.com/wow/ui" />`，另外一种是成对的如`<Ui xmlns="http://www.blizzard.com/wow/ui"> </Ui>`，两种形式表示的内容完全一样。我这里文章为简化说明内容全部用第一种形式。

- `<Frame />`
`Frame`标签表示的是插件中的界面元素，标签中的属性分别表示：
    - `name`: Frame对象的名称；（这里对象的意思是编程语言中的概念，如果你不是很懂，就把它看做是一个具体的界面元素就可以了）
    - `parent`: 这个涉及到编程语言继承的概念，这里的写法是固定的，`UIParent`是魔兽世界界面的API，一般情况下我们这里都用`UIParent`；（与上一个`name`属性不同的是，`name`我们可以自己指定名称，这里我们只能用`UIParent`或者我们已知的，初学者一般知道这个地方是不可以随意替换的就可以了）
    - `enableMouse`: 表示我们的界面元素是否可以用鼠标操作；
    - `movable`: 表示我们的界面元素是否可以移动；
    - `frameStrata`: 表示我们界面元素所在的层级，简单理解就是我们的界面元素有上下之分，上面的会覆盖下面的界面，这个`LOW`,`HIGH`之分就能告诉我们哪个界面要在上面显示，关于这个属性以后我们遇到界面覆盖的时候会很好理解。

- `<Size />`
这个标签修饰了界面元素的大小；

- `<TitleRegion />`
    - `setAllPoints`: 当`Frame`的`movable`为`true`时，这个属性表示是否界面上的所有点都可以使界面移动，即点击界面上的任何点移动界面都是有效的；

- `<Anchor />`
锚点是一个游戏设计的概念，具体可自行百度下，这里不做具体解释，因为我们现在还涉及不到这个；

- `<Layer />`
我们在`Frame`里显示了几项内容，都是通过这个标签排列的：
    - `<FontString />`
    ```
    <FontString name="$parentTextTitle" inherits="GameFontNormal" text="Hello Azeroth!">
    ```
    上面的`name`里`$parent`表示的是`<Layer />`父标签的名称，即`<Frame />`的名称`HelloWorldTestFrame`，所以这里`name`其实就是`HelloWorldTestFrameTextTitle`；`inherits`表示字体继承自的对象；`text`表示所要显示的内容；

### 插件的一些事件

以上所有的界面显示已经全部解释完，在上面的界面代码里，最后还有一个`<Script />`标签，这个标签就是用来描述脚本的一些事件的，我们接着进行剖析；

- 先要说一个很重要的内容
    我们在前面说到的`.toc`文件中有一段插件加载文件的代码：
    ```
    HelloAzeroth.lua 
    HelloAzeroth.xml
    ```
    这里要注意的是，这两行代码是有顺序的，也就是说游戏在加载插件时会按顺序对文件进行加载，由于我们的界面`.xml`文件会用到`.lua`中的内容，所以`.lua`文件要先于`.xml`文件，否则进入游戏会出现插件加载错误的问题，我们看一下`<Script />`标签里的内容就理解了；

- `<Script />`
    ```
    <Scripts> 
        <OnLoad> 
            HelloWorldLoad(); 
        </OnLoad>
        <OnEvent> 
            HelloWorldEvent(); 
        </OnEvent>
    <Scripts>
    ```
    这段代码里对应了插件在游戏中的三个事件：
    - `<OnLoad />`：插件在加载时；ww
    - `<OnEvent />`: 插件在一些交互事件发生时，比如鼠标点击等；
    而这些标签下的代码来源于`.lua`文件中，所以前面我们说到`.lua`一定要先于`.xml`；
    
### 事件是如何发生的

终于来到我们本篇中最难理解的部分，这可能需要你有一定的编程基础，但是如果不懂那么也可以从英语单词中猜到一些内容，当然如果你对编程稍微有些兴趣可以简单学习一下 **Lua** 这个语言。但即使你不想学任何一门编程语言，看了我这一篇你也能写出一个插件，相信我，这很简单。

下面这个链接是我们所有的代码，很简短，同样我们逐行进行解剖，[https://github.com/usiege/Addons/blob/master/01_HelloAzeroth/HelloAzeroth.lua][6]

- HelloWorldLoad()
```
function HelloWorldLoad(frame)
    -- 还记得.xml文件里Frame标签里的界面元素吗
    -- 这里我们获取我们的界面元素，并把它设置成了隐藏
    frame:Hide()
    
    -- 正面这行我们在默认的聊天窗口打印一行文字，当你进入游戏后
    -- 在聊天窗口会看到一串文字显示，说明我们的插件加载成功
    -- 本段我们会给出展示
    DEFAULT_CHAT_FRAME:AddMessage("HelloAzeroth is Loaded!");
    
    -- 下面这句我们为界面元素注册了一个CHAT_MSG_SAY事件
    -- 这个事件是当你周围有人说话时发生的
    -- 这个事件对应<OnEvent />标签下的内容，也就是HelloWorldEvent函数
    frame:RegisterEvent("CHAT_MSG_SAY");
end
```
当界面加载时我们运行上面这个函数（函数的概念自己去百度一下吧，不懂的话就无视，我们只要知道插件在做事情就可以了）;

- HelloWorldEvent()
```
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
```
上面`RegisterEvent`注册的函数会通过在`<OnEvent />`标签里的函数运行,也就上所有注册的事件都会运行上面这段代码,代码中的三个参数:`enent`是一个字符串类型,对应注册的事件,这些事件是wow定义好了的,主要对应游戏里的一些事件,像我们这里是对应一个聊天的事件,任何你角色周围的人说话都会触发这个事件,也就是会运行上面这段代码;`arg1`是说话的内容,`arg2`是说话人的角色名;

我们进入游戏界面默认是不显示我们自己写的欢迎界面的，所以我们就在我们事件里加入了一段代码，当我们说话是`show`的时候显示，
![WX20191104-193037.png-928kB][7]

当说话是`hide`的时候隐藏；
![WX20191104-193049.png-931.4kB][8]

好了,我们的欢迎插件就做好了,保存代码文件,在游戏里使用`/reload`命令看一下效果吧!!!

有感兴趣的可以下载我的代码，全部代码在这里[https://github.com/usiege/Addons/tree/master/01_HelloAzeroth](https://github.com/usiege/Addons/tree/master/01_HelloAzeroth)


  [1]: http://static.zybuluo.com/usiege/pq0ke6698j3b76rcjvprii03/1029-0.png
  [2]: http://static.zybuluo.com/usiege/aqfywjcqis1wmhiqruauuv1q/1029-1.png
  [3]: http://static.zybuluo.com/usiege/om3xbig8q7tb0d8wen4rdlod/QQ20191030-093221.png
  [4]: https://github.com/usiege/Addons/blob/master/01_HelloAzeroth/HelloAzeroth.xml
  [5]: http://static.zybuluo.com/usiege/wmgvn9fgv1ntx1ksr4fpnqq8/WX20191104-192614.png
  [6]: https://github.com/usiege/Addons/blob/master/01_HelloAzeroth/HelloAzeroth.lua
  [7]: http://static.zybuluo.com/usiege/lj9ko3w4dyofin2gve3lkqk5/WX20191104-193037.png
  [8]: http://static.zybuluo.com/usiege/hodppuoriudft2ftcpnnwsu4/WX20191104-193049.png


