--Everything From here on would need to be translated and put
--into if statements for each specific language.

--***********
--Chinese Traditional
--***********

if GetLocale() ~= "zhCN" then return end

--Warnings
SCTD.LOCALS.Version_Warning = "SCT版本错误，请更新你的SCT";
SCTD.LOCALS.Load_Error = "|cff00ff00载入 SCTD 设置错误，该插件可能停用了。|r错误：";

--"Melee" ranged skills
SCTD.LOCALS.AUTO_SHOT = "自动射击";
SCTD.LOCALS.SHOOT = "射击";

-- Cosmos button
SCTD.LOCALS.CB_NAME			= "SCT - Damage".." "..SCTD.Version;
SCTD.LOCALS.CB_SHORT_DESC	= "by Grayhoof";
SCTD.LOCALS.CB_LONG_DESC	= "将你的伤害显示在SCT中！";
SCTD.LOCALS.CB_ICON			= "Interface\\Icons\\Ability_Warrior_BattleShout"