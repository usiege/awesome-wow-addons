# 宏命令

> 这里是游戏内命令的集合。

## COMMOND

- 查看当前游戏版本
`/run print((select(4, GetBuildInfo())))`

- 视角调到最大
~~`/run CombatTrackerFrame:SetPoint("TOP", Minimap, "BOTTOM", 0, -10)`~~

- 显示Lua错误
`/console scriptErrors 1`
to display LUA errors

- 启用污染日志
`/console taintLog 1`

- 跑尸不灰屏
`/console ffxDeath 0`

- 修改金钱显示(1G = 100Y)
`/script SILVER_PER_GOLD=100`

- 视距
`/console cameraDistanceMaxZoomFactor 4`

- 近战血飞溅效果
`/console violenceLevel 5`

