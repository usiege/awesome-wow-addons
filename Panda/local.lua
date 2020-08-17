local addon, ns = ...

ns[1] = {}
ns[2] = {}


local L = ns[1]
local G = ns[2]

G.Locale = GetLocale()


L["吸收"] = "Absorb"
L["醉拳"] = "Stagger"
L["千"] = "K"
L["必须是0.6~2之间的数字"] = "must be a number between 0.6~2"
L["-调整大小(x是0.6~2之间的数字)"] = "-change scale( x must be a number between 0.6~2)"
L["-显示/隐藏插件"] = "-show/hide addon"

if G.Locale == "zhCN" then
	L["吸收"] = "吸收"
	L["醉拳"] = "醉拳"
	L["千"] = "千"
	L["必须是0.6~2之间的数字"] = "必须是0.6~2之间的数字"
	L["-调整大小(x是0.6~2之间的数字)"] = "-调整大小(x是0.6~2之间的数字)"
	L["-显示/隐藏插件"] = "-显示/隐藏插件"
end