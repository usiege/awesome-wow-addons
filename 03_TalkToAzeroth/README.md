# 听风的插件DIY-03-喊话的正确姿势

标签（空格分隔）： wow

---

相信你在组队时候一定有过这样的经历：盯着世界大脚频道一行行刷屏的广告，好不容易眼尖看到有个人在那边喊“某某本来个DPS，4=1”，鼠标点那人头像，信息早就被刷到了上边，花好半天往上翻到信息，窃窃地给人家打了个1，人家一个字“满”回过来，心凉了半截。

我们从第一天进入艾泽拉斯世界，无时无刻不在用这个聊天频道在与它交流，也无时无刻不在被烦人的刷屏信息搞到崩溃。

所以今天我们就来教教大家如何更加优（粗）雅（暴）的在公屏喊话。

![image_1dq75ljhp1t6l1kg51ns0129k1c229.png-133.7kB][1]

## 基本设置

每个新建的魔兽角色进入游戏后，都会在屏幕的左下角有一个默认的聊天窗口。

在这个聊天窗口，玩家可以在不同频道向世界发送不同的信息，还有一些系统提示等信息。

玩家可以通过右键设置，通过勾选来设置想要看到的信息。

![image_1dq766297h5psre1kq4fe1igkm.png-235.1kB][2]

有时候一个窗口显示的频道信息太多会导致信息刷屏，我们会因此错过很多重要的信息。

所以我选择新建几个窗口来显示不同的频道信息；

![image_1dq769qc3esgba1i2hha016uj13.png-124.8kB][3]

![image_1dq76bcik1d7v1m00i1o1mfa1u6n1g.png-110.6kB][4]

这些窗口如果是用代码表示，它们有自己独有的名字；

如上面带有四个标签的窗口，从左到右他们分别叫：

```
ChatFrame1
ChatFrame2
ChatFrame3
ChatFrame4
```
没错按从左到右数字一直排，魔兽世界插件允许玩家最多有9个标签；

如果你想要某个窗口输入一条消息，只需要在你写的代码里写下一句：
```
ChatFrame4:AddMessage("这是我要说的话。。。")
```
![image_1dq76upipr511e591snd1a8g13h21t.png-109kB][5]

这句话到底怎么用，想要实现的话我们下面会讲。

关于频道设置时，有时我们会发现最常用的“大脚世界频道”信息没有了，

![image_1dq778v7c1ddb7dlsu112op849.png-83.6kB][6]

这可能是由于暴雪限制了频道进入的人数，我们只需要在下面的聊天栏输入：

```
/join 大脚世界频道
```

![image_1dq77bpre1qgp1gi0vik1evns72m.png-154.6kB][7]

熟悉的世界频道信息又回来了。

这里如果还没有信息可能是频道人数达到上限，暂时还加不进去，

或者如果提示你已经进入了频道但还是没有信息，在聊天栏输入

```
/reload
```
重载一下界面就看到了。

## 让我们用宏喊喊话

关于宏我们之前有文章介绍过，可以到我公众号“艾泽拉斯日常”里找宏相关的内容。

这里我们做一个喊话的宏。

打开制作宏界面，按`ESC`，点“宏命令设置”。

或者在聊天栏里打 `/m`

![image_1dq78b86fr6v1h7k1f9o6ld1u3413.png-168.1kB][8]

点击新建选择一个图标，在上面输入宏的名字

![image_1dq78e61f9mtjr3e9r1jpgv6b20.png-456.4kB][9]

确定之后我们就要在下面的代码区填写宏命令了；

关于宏有几个内容我们需要了解一下：

- 字符限制在256个；
- 可以有空格，但不可以有空格；
- 如果宏命令不符合Lua语法，宏会失效，不会有任何提示；

我们先来看下我们的喊话宏：

```
/script T,F=T or 0,F or CreateFrame("frame")if X then X=nil else X=function()local t=GetTime()if t-T>10 then SendChatMessage("大家好，我是听风轻咛。","channel",nil,1)T=t end end end F:SetScript("OnUpdate",X)
```

上面这个宏，我在频道1每隔10秒钟进行一次喊话，内容是“大家好，我是听风轻咛。”我们先来看一下效果。

![image_1dq78sdm6ltc1s5417831kfb1pkp2d.png-136.1kB][10]

至于这段宏怎么解释，别着急我们下面说。

## 宏有字数限制怎么办

有了上面的宏，我们就可以在世界公屏发送组队信息啦。

可是问题来了，我说的话不光是那么几个字的时候，发现宏的字符不够用了。

![1-1F524102524557.jpg-22.7kB][11]

没关系我们有办法。我们来做个新的插件。

仍旧按我们的命名方式，在`Addons`下建一个文件夹，

命名为`03_TalkToAzeroth`；

在文件夹下建立两个文件，一个是跟文件夹同名的`03_TalkToAzeroth.toc`文件，另一个是写代码的`TalkToAzeroth.lua`文件（这个是不用同名的）；

![image_1dq7atdh188p96g1ejq1j7q18lp36.png-17.6kB][12]

有很多细心的小可爱可能发现了，我们今天的插件没有`.xml`文件。

没错我们今天的插件不需要界面！！！

```
## Interface: 20300
## Title: 03-喊话的正确姿势
## Author: 听风 
## Notes: 向艾泽拉斯说出我们的心声。
## Description: 这是一个为了简化喊话的插件。

TalkToAzeroth.lua
```

我们先把插件信息写好，关掉游戏重启检查一下。

![image_1dq7dep3gppv3vv1dfp14ehhic3j.png-342.3kB][13]

接下来在`lua`里写我们的宏：

```
-- /script talk(1, 5, "内容")

function talk(channel, time_pad, msg)
    T,F=T or 0,F or CreateFrame("frame")
    if TALK then 
        TALK=nil
        ChatFrame4:AddMessage("喊话关闭")
    else 
        TALK=function()
            local t=GetTime()
            if t-T>time_pad then
                SendChatMessage(msg,"channel",nil,channel)
                T=t
            end 
        end
        ChatFrame4:AddMessage("喊话开启")
    end 
    F:SetScript("OnUpdate",TALK)
end
```
我们把上面的宏写成函数，这下为了美观，我们可以把代码排版了。

内容其实还是上面的宏内容，其实我们就仅仅是把`/script`用`function`表示。

既然说到函数，我们今天就讲一下`Lua`的函数。简单的讲，函数就是一段代码，以`function`开始，以`end`结束。

在它范围的代码是一个整块，若函数被执行，整个块的代码会被顺序执行。

如上函数是有名称的，也就好比你想让一条狗去接你丢出去的飞盘，你得给他一个命令。我们的命令就是`talk`。

为了你命令发的准确，你得告诉狗接哪个盘，用多长时间接，这里我们用`talk`括号里的参数来表示；

我们的函数参数`channel`, `time_pad`, `msg`分别表示在哪个频道发，每隔几秒发，发送的内容；

好了，接下来我们就需要把具体怎么实施给狗讲清楚，先干什么再干什么；

```
T,F=T or 0,F or CreateFrame("frame")
if TALK then 
    TALK=nil
    ChatFrame4:AddMessage("喊话关闭")
else 
    TALK=function()
        local t=GetTime()
        if t-T>time_pad then
            SendChatMessage(msg,"channel",nil,channel)
            T=t
        end 
    end
    ChatFrame4:AddMessage("喊话开启")
end 
F:SetScript("OnUpdate",TALK)
```
下面用文字来描述上面这段话：
```
T 是 T 或者 0
F 是 F 或者 创建一个新窗口（这个窗口可以不显示）
如果 我在喊话
    喊话 TALK 关闭
    在窗口4发送内容：喊话关闭
不是的话
    告诉你 TALK 怎么喊话 {
        如果 过了time_pad 时间
            在channel频道发送内容msg
            T 就是 当前时间
    }
    在窗口4发送内容：喊话开启

用新建的窗口F开启上面的喊话TALK(这里的"OnUpdate"表示不停的更新界面，就是重复不停做这件事)
```
这个时候我们还没有把命令发送出去，我们把发送命令写在宏里：

```
/script talk(4, 10, "这是我在向艾泽拉斯喊话。")
```
![image_1dq7fvfde1hk82651ma4f0f91o61.png-162.6kB][14]

这样我们就把想说的“这是我向艾泽拉斯在说话”，每隔10秒在频道4里发送。这里的4对应通用频道里的本地防务。

![image_1dq7fhie5roc8a4e51aed14i4d.png-66.9kB][15]

点击新建的宏开启喊话，公屏4频道开始有信息显示，再次点击喊话关闭。

![image_1dq7frh0h3ato4aenp11sc1n6e57.png-131.1kB][16]

完了最后这个刷屏被骂了，我太南了，自闭自闭。今天就到这里吧，晚安，艾泽拉斯。


欢迎关注微信公众号“艾泽拉斯日常（azeroth-daily）”。
![WechatIMG179.jpeg-139.8kB][17]


  [1]: http://static.zybuluo.com/usiege/3tnyounyp7hm30xrng3r6fue/image_1dq75ljhp1t6l1kg51ns0129k1c229.png
  [2]: http://static.zybuluo.com/usiege/m9pogkifr77ahxt2piiac36t/image_1dq766297h5psre1kq4fe1igkm.png
  [3]: http://static.zybuluo.com/usiege/bsjp5oydsp134p4jjy8yzl0w/image_1dq769qc3esgba1i2hha016uj13.png
  [4]: http://static.zybuluo.com/usiege/mq6yfl2nyj9ki62slkccgkfl/image_1dq76bcik1d7v1m00i1o1mfa1u6n1g.png
  [5]: http://static.zybuluo.com/usiege/eu1nkbkihhpvmrd8sb55xaz5/image_1dq76upipr511e591snd1a8g13h21t.png
  [6]: http://static.zybuluo.com/usiege/7w6jqgozfw91qyneowaahgxn/image_1dq778v7c1ddb7dlsu112op849.png
  [7]: http://static.zybuluo.com/usiege/8kjgdjnt0x06xoh61toat0i3/image_1dq77bpre1qgp1gi0vik1evns72m.png
  [8]: http://static.zybuluo.com/usiege/xazoaohxr6esyqh4irkasfid/image_1dq78b86fr6v1h7k1f9o6ld1u3413.png
  [9]: http://static.zybuluo.com/usiege/gn2pvkuqk3ndkp915dxwci4m/image_1dq78e61f9mtjr3e9r1jpgv6b20.png
  [10]: http://static.zybuluo.com/usiege/ut6g6t3m9pf00kdkuxziovnt/image_1dq78sdm6ltc1s5417831kfb1pkp2d.png
  [11]: http://static.zybuluo.com/usiege/qf5vd72x7ubjx6249yyv6f0g/1-1F524102524557.jpg
  [12]: http://static.zybuluo.com/usiege/um9fjpiun3i4p0i3206tdkhj/image_1dq7atdh188p96g1ejq1j7q18lp36.png
  [13]: http://static.zybuluo.com/usiege/rsrdhczih9md6e8clv3b0ufa/image_1dq7dep3gppv3vv1dfp14ehhic3j.png
  [14]: http://static.zybuluo.com/usiege/55lfrm5eb27sb9qddyzaxfa0/image_1dq7fvfde1hk82651ma4f0f91o61.png
  [15]: http://static.zybuluo.com/usiege/tjdj3of5x036uv2arqcjvov1/image_1dq7fhie5roc8a4e51aed14i4d.png
  [16]: http://static.zybuluo.com/usiege/hy1s01yyg6jxoczlz830bvzk/image_1dq7frh0h3ato4aenp11sc1n6e57.png
  [17]: http://static.zybuluo.com/usiege/0mlap4rlx4kenqzvcqb8cins/WechatIMG179.jpeg