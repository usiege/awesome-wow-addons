--***************************************
-- Chinese Translation by 索拉丁 Valbyrie
--***************************************

if GetLocale() ~= "zhCN" then return end

local media = LibStub("LibSharedMedia-3.0")

--Event and Damage option values
SCT.LOCALS.OPTION_EVENT101 = {name = "近战伤害", tooltipText = "显示你造成的近战伤害.如果技能颜色被激活,将使用该颜色设置"};
SCT.LOCALS.OPTION_EVENT102 = {name = "周期性伤害", tooltipText = "显示你造成的周期性伤害.如果技能颜色被激活,将使用该颜色设置"};
SCT.LOCALS.OPTION_EVENT103 = {name = "法术/技能 伤害", tooltipText = "显示你造成的法术/技能伤害.如果技能颜色被激活,将使用该颜色设置"};
SCT.LOCALS.OPTION_EVENT104 = {name = "宠物伤害", tooltipText = "显示你的宠物造成的伤害.如果技能颜色被激活,将使用该颜色设置"};
SCT.LOCALS.OPTION_EVENT105 = {name = "彩色显示致命一击", tooltipText = "以指定颜色显示致命伤害.如果技能颜色被激活,将使用该颜色设置"};
SCT.LOCALS.OPTION_EVENT106 = {name = "中断", tooltipText = "显示施法中打断信息."};
SCT.LOCALS.OPTION_EVENT107 = {name = "伤害过滤", tooltipText = "伤害过滤.如果技能颜色被激活,将使用该颜色设置"};

--Check Button option values
SCT.LOCALS.OPTION_CHECK101 = { name = "启用SCTD", tooltipText = "启用或者禁用 SCT - Damage"};
SCT.LOCALS.OPTION_CHECK102 = { name = "标记伤害信息", tooltipText = "在伤害信息两侧添加“*”标记"};
SCT.LOCALS.OPTION_CHECK103 = { name = "法术类型", tooltipText = "显示法术伤害类型"};
SCT.LOCALS.OPTION_CHECK104 = { name = "法术名称", tooltipText = "显示造成伤害的法术/技能名称"};
SCT.LOCALS.OPTION_CHECK105 = { name = "抵抗", tooltipText = "显示你被敌人抵抗的伤害"};
SCT.LOCALS.OPTION_CHECK106 = { name = "目标名字", tooltipText = "显示目标的名字"};
SCT.LOCALS.OPTION_CHECK107 = { name = "关闭WOW伤害提示", tooltipText = "关闭WoW自带的伤害显示.\n\n注意:此设置与游戏选项“界面->高级”中的设定有一样的功能。但wow自带的设定更为详细."};
SCT.LOCALS.OPTION_CHECK108 = { name = "限制目标", tooltipText = "只显示你对当前目标造成的伤害.除非多个目标名字相同,否则AE效果不会显示出来."};
SCT.LOCALS.OPTION_CHECK109 = { name = "显示姓名面板", tooltipText = "在怪物姓名面板关闭或显示你的伤害.敌人的姓名面板功能必须显示,但是他并不是100%工作的,如果它没有反应,将使用默认配置.关闭它的话必须重新载入插件.\n\n"};
SCT.LOCALS.OPTION_CHECK110 = { name = "使用SCT动画", tooltipText = "使用SCT动画效果显示,而非静态信息方式显示."};
SCT.LOCALS.OPTION_CHECK111 = { name = "加重致命效果", tooltipText = "以[粗体]显示你造成的致命一击或极效治疗. 关闭后, 将以:致命 +1236+ 显示 "};
SCT.LOCALS.OPTION_CHECK112 = { name = "法术颜色", tooltipText = "以不同的颜色显示不同类型的法术伤害 (颜色不可更改)"};
SCT.LOCALS.OPTION_CHECK113 = { name = "伤害文字向下滚动", tooltipText = "伤害信息向下滚动"};
SCT.LOCALS.OPTION_CHECK114 = { name = "简写法术名称", tooltipText = "启用或者关闭简写法术/技能名称显示 (使用 SCT 设定)"};
SCT.LOCALS.OPTION_CHECK115 = { name = "使用SCTD定制事件", tooltipText = "启用或禁用SCTD定制事件"};

--Slider options values
SCT.LOCALS.OPTION_SLIDER101 = { name="中心横坐标", minText="-600", maxText="600", tooltipText = "调整文字的水平位置"};
SCT.LOCALS.OPTION_SLIDER102 = { name="中心纵坐标", minText="-400", maxText="400", tooltipText = "调整文字的垂直位置"};
SCT.LOCALS.OPTION_SLIDER103 = { name="淡出速度", minText="快", maxText="慢", tooltipText = "调整静态信息淡出的速度"};
SCT.LOCALS.OPTION_SLIDER104 = { name="字体大小", minText="小", maxText="大", tooltipText = "调整文字大小"};
SCT.LOCALS.OPTION_SLIDER105 = { name="透明度", minText="0%", maxText="100%", tooltipText = "调整文字透明度"};
SCT.LOCALS.OPTION_SLIDER106 = { name="弧形间距", minText="0", maxText="200", tooltipText = "调整弧形动画动画效果和水平中央点的距离.对于想要信息尽量靠中显示但又想要调整和水平中间点距离时候使用"};
SCT.LOCALS.OPTION_SLIDER107 = { name="输出伤害过滤", minText="0", maxText="500", tooltipText = "过滤显示SCTD的输出伤害,设置忽略小数值的伤害和dot"};

--Misc option values
SCT.LOCALS.OPTION_MISC101 = {name="SCTD 设定 "..SCTD.Version};
SCT.LOCALS.OPTION_MISC102 = {name="关闭", tooltipText = "保存所有目前的设定,并关闭设定窗口"};
SCT.LOCALS.OPTION_MISC103 = {name="SCTD", tooltipText = "打开SCTD设置窗口"};
SCT.LOCALS.OPTION_MISC104 = {name="伤害事件", tooltipText = ""};
SCT.LOCALS.OPTION_MISC105 = {name="显示设定", tooltipText = ""};
SCT.LOCALS.OPTION_MISC106 = {name="框架设定", tooltipText = ""};

--Animation Types
SCT.LOCALS.OPTION_SELECTION101 = { name="伤害字体", tooltipText = "选择你使用的字体", table = media:List("font")};
SCT.LOCALS.OPTION_SELECTION102 = { name="伤害描边类型", tooltipText = "选择文字描边类型", table = {[1] = "无",[2] = "细",[3] = "粗"}};
SCT.LOCALS.OPTION_SELECTION103 = { name="伤害动画类型", tooltipText = "选择动画类型.", table = {[1] = "垂直 (默认)",[2] = "彩虹",[3] = "水平",[4] = "斜下",[5] = "斜上",[6] = "洒落",[7] = "弧形曲线",[8] = "弧形斜向"}};
SCT.LOCALS.OPTION_SELECTION104 = { name="伤害弹出方向", tooltipText = "选择伤害的弹出方向", table = {[1] = "交替",[2] = "伤害向左",[3] = "伤害向右", [4] = "全部向左", [5] = "全部向右"}};
SCT.LOCALS.OPTION_SELECTION105 = { name="文字对齐", tooltipText = "设定文字对齐方式.在使用弧形动画或者垂直显示时最有效.「弧形方式对齐」将使得左侧文字为靠右对齐／右侧文字为靠左对齐。", table = {[1] = "左",[2] = "居中",[3] = "右", [4] = "弧形方式对齐"}};
SCT.LOCALS.OPTION_SELECTION106 = { name="图标位置", tooltipText = "设置你的图标在技能名称的位置.",  table = {[1] = "左", [2] = "右", [3] = "内部", [4] = "外部",}};
