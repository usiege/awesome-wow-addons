# 听风的插件DIY-04-集成到设置中

[WelcomeHome](https://segmentfault.com/a/1190000019477458)

---

在魔兽世界主菜单里有一个界面设置，我们平时在用插件的时候会在里面发一些自定义的插件设置，可能你不是太明白我的意思，Ok！给你一张图就明白了：
![addon-04-03.jpg-89.3kB][1]

## Ace工具库
 
工具源址先放出了，如果你觉得本文内容不足以满足个人学习，那请跳级自行研究。

[ACE3](https://www.wowace.com/projects/ace3)

Ace3使用了一个叫做“嵌入式库”的概念，它允许模块开发者在其他模块加载了相同库的时候不需要再复制一份代码。在之后的插件里，我们会重复使用这个概念。

在此，本文所使用的ACE3库的所有代码将全部托管到本人github帐号下的`World-Of-Warcraft`库中[https://github.com/usiege/World-Of-Warcraft.git](https://github.com/usiege/World-Of-Warcraft.git)，读者可自行下载。

本文插件内容请到[https://github.com/usiege/Addons.git](https://github.com/usiege/Addons.git)获取，如有疑问请到公众号留言交流。

## 我们要开始了

仍旧我们先要编辑`.toc`文件，这次我们除了一些基本的插件信息，还加入了依赖库。

```
## Interface: 20300
## Version: 0.1
## Title: 04-集成到系统中
## Author: 听风
## Notes: 整合到ESC插件设置中的内容
## OptionalDeps: Ace3
## X-Embeds: Ace3

embeds.xml
core.lua
```

![addon-04-04.png-180.6kB][2]

这里我们新添加了两个字段：

- OptionalDeps
此项为可选的依赖项，也就是说我们的插件可能会用到这些库。**可选依赖**是当前插件为了实现某些附加功能而依赖的外部库或插件，但如果依赖的东西不存在，那么当前插件也可以正常工作，注意使用可选依赖的插件必须写明当依赖不存在的时候也可以工作。

- X-Embeds
这一项是一个说明项，可选标签，如注释掉不会影响插件正常运行。


## 引入Ace库

接下来我们引入从外部添加进来的Ace库，我们需要从`embeds.xml`处加载，从上节中的`.toc`处我们可以看到，它是先于后面的`core.lua`加载的。
本文的代码我们组织在了`core.lua`文件中，下节配合图片说明我们会详细说明。

我们在插件目录下新建`embeds.xml`文件，以此来加载所需要的库：
```
<Ui xmlns="http://www.blizzard.com/wow/ui/" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.blizzard.com/wow/ui/
..\FrameXML\UI.xsd">
    <Script file="Libs\LibStub\LibStub.lua"/>
    <Include file="Libs\CallbackHandler-1.0\CallbackHandler-1.0.xml"/>
    <Include file="Libs\AceAddon-3.0\AceAddon-3.0.xml"/>
    <Include file="Libs\AceEvent-3.0\AceEvent-3.0.xml"/>
    <Include file="Libs\AceDB-3.0\AceDB-3.0.xml"/>
    <Include file="Libs\AceConsole-3.0\AceConsole-3.0.xml"/>
    <Include file="Libs\AceGUI-3.0\AceGUI-3.0.xml"/>
    <Include file="Libs\AceConfig-3.0\AceConfig-3.0.xml"/>
</Ui>
```

我们会看到又是熟悉的`<Ui> </Ui>`对，
```
<Ui xmlns="http://www.blizzard.com/wow/ui/" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.blizzard.com/wow/ui/
..\FrameXML\UI.xsd">
    <!-- 在这个部分的代码会按顺序加载 -->
</Ui>
```

这里有一个关于`.xml`的注释，如上：
`<!-- 注释的内容 -->`

注释都知道是什么吧？我怕是又要拿出“程序员到餐厅点单子”的梗了:

> 餐厅中, 程序员A: “我吃鱼香肉丝盖饭, 你吃什么?”
程序员B: “宫保鸡丁盖饭.”
程序员A 在点菜单写上：
鱼香肉丝盖饭 1
宫保鸡丁盖饭 1
程序员B: “我还是要牛肉面吧!”
程序员A 更正点菜单:
鱼香肉丝盖饭 1
// 宫保鸡丁盖饭 1
牛肉面 1

继续上面说的，`Script标签`表示需要引入的lua文件，`Include标签`表示要引入的xml文件。需要注意的是LibStub必须先加载，因为其他库都依赖它。其他文件也需要注意使用顺序，原则就是被依赖的库需要先加载。

## 又要写代码了

外部库加载完之后，接下来我们就要利用这些外部库搞点事情了。我们在插件目录下新建`core.lua`文件，用以编写本文所有的事件代码。在`core.lua`之前引入`embeds.xml`文件，以保证在`core.lua`执行之前所有的库已被加载并可以使用。

所以我们的文件结构是：

```
├── 04_InterfaceOptions.toc
├── Libs
│   ├── AceAddon-3.0
│   ├── AceConfig-3.0
│   ├── AceConsole-3.0
│   ├── AceDB-3.0
│   ├── AceEvent-3.0
│   ├── AceGUI-3.0
│   ├── CallbackHandler-1.0
│   └── LibStub
├── README.md
├── core.lua
└── embeds.xml
```

`LibStub`有它独有的事件触发机制，我们来逐个说明：

```
WelcomeHome = LibStub("AceAddon-3.0"):NewAddon("WH", "AceConsole-3.0")
```
首先这一行构成了本节插件的最基本语句，它是由`LibStub`这个类加载`AceAddon-3.0`库文件，来初始化出新的插件的。

新加载的插件被我们命名为了`WH`，我们使用NewAddon方法创建一个AceAddon类的实例，因为我们会用到聊天窗口和斜杠命令，我们还混入了AceConsole类。

新产生的变量`WelcomeHome`是一个`lua`的`table`变量，它构成了一个类，该类的三个方法分别会在不同情况下调用。OnInitialize只会在UI加载的时候执行一次，后面两个分别在插件被启用和禁用的时候执行。

```
function WelcomeHome:OnInitialize()
    -- Called when the addon is loaded
    self.Print("这里是插件初始化 等待完成")
end
```
`OnInitialize`方法在插件加载时调用，由于该函数只会调用一次，所以我们一般会在这个方法内做一些插件初始化的工作。

```
function WelcomeHome:OnEnable()
    -- Called when the addon is enabled
    self:Print("04_InterfaceOptions 启用")
end
```
`OnEnable`方法在加载时，我们想要通过一句打印来知道插件的确是在运行状态，上代码，我们会输出一串提示文字。

注意`OnInitialize`是要先于`OnEnable`的。

![addon-04-05.png-221.3kB][3]

```
function WelcomeHome:OnDisable()
    -- Called when the addon is disabled
    -- 这个我们暂时还用不上
end
```

## 本文的重点来了

所以我们是如何在系统设置里面加上一项新的设置的呢？

毫无疑问是我们的代码增加了这一项，所以我们之前是这个亚子的：

![addon-04-06.png-787.1kB][4]

但是当我们在`OnInitialize`中添加了：

```
self.optionsFrame = LibStub("AceConfigDialog-3.0"):AddToBlizOptions("WH", "Welcome Home")
```
上面这一句，插件设置出现了：

![addon-04-07.png-844.3kB][5]

我们为新创建的叫做`WH`的插件添加了一个叫做`Welcome Home`的设置项，且它的名称显示在了设置项的上方，如上图。

## 总结

有了这个我们就了解到了插件设置只是更直观的使我们使用插件提供的功能，我们在自己DIY插件的时候可以把系统代码转化为可视化的内容，这样就可以使插件功能与代码分离，减少对修改代码的依赖。


[1]: http://static.zybuluo.com/usiege/aa2whndb3f7k16266gd3jkd7/addon-04-03.jpg
[2]: http://static.zybuluo.com/usiege/nlm5lp6ypbrl8wg3t2sdrevd/addon-04-04.png
[3]: http://static.zybuluo.com/usiege/8mm3f6h9u6c1l9ygk47zfzlb/addon-04-05.png
[4]: http://static.zybuluo.com/usiege/wxktibyhtklty51jmwnswf9e/addon-04-06.png
[5]: http://static.zybuluo.com/usiege/861vknhiazf687dnjn41sh62/addon-04-07.png