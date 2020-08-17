--Everything From here on would need to be translated and put
--into if statements for each specific language.

--***********
--Chinese Traditional
--***********

if GetLocale() ~= "zhTW" then return end

--Warnings
SCTD.LOCALS.Version_Warning = "SCT 版本錯誤。必須更新 SCT 的版本，SCTD 才能正確運作。";
SCTD.LOCALS.Load_Error = "|cff00ff00載入 SCTD Options 時發生錯誤，設定插件可能被停用了。|r錯誤：";

--"Melee" ranged skills
SCTD.LOCALS.AUTO_SHOT = "自動射擊";
SCTD.LOCALS.SHOOT = "射擊";

-- Cosmos button
SCTD.LOCALS.CB_NAME			= "SCT - Damage".." "..SCTD.Version;
SCTD.LOCALS.CB_SHORT_DESC	= "程式設計：Grayhoof";
SCTD.LOCALS.CB_LONG_DESC	= "把你的傷害量顯示到 SCT 中！";
SCTD.LOCALS.CB_ICON			= "Interface\\Icons\\Ability_Warrior_BattleShout"