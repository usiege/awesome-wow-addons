--***************************************
-- zhTW Chinese Traditional
-- 2007/05/24 艾娜羅沙@奧妮克希亞
-- 如拿本文修改，請保留本翻譯作者名，謝謝
-- 2008/4/20修訂 天明@眾星之子
--***************************************

if GetLocale() ~= "zhTW" then return end

local media = LibStub("LibSharedMedia-3.0")

--Event and Damage option values
SCT.LOCALS.OPTION_EVENT101 = {name = "近戰傷害", tooltipText = "顯示你造成的近戰傷害"};
SCT.LOCALS.OPTION_EVENT102 = {name = "週期性傷害", tooltipText = "顯示你造成的週期性傷害"};
SCT.LOCALS.OPTION_EVENT103 = {name = "法術/技能傷害", tooltipText = "顯示你造成的法術/技能傷害"};
SCT.LOCALS.OPTION_EVENT104 = {name = "寵物傷害", tooltipText = "顯示你的寵物造成的傷害"};
SCT.LOCALS.OPTION_EVENT105 = {name = "彩色致命一擊", tooltipText = "以指定的色彩，顯示致命一擊傷害"}; 
SCT.LOCALS.OPTION_EVENT106 = {name = "中斷", tooltipText = "顯示你造成的施法中斷。"};
SCT.LOCALS.OPTION_EVENT107 = {name = "護盾傷害", tooltipText = "啟用或是停用護盾傷害的顯示. 顏色會依據法術的級別."};

--Check Button option values
SCT.LOCALS.OPTION_CHECK101 = { name = "啟用SCTD", tooltipText = "啟用或是停用SCT - Damage"};
SCT.LOCALS.OPTION_CHECK102 = { name = "標記傷害訊息", tooltipText = "在傷害訊息兩側添加'*'標記"};
SCT.LOCALS.OPTION_CHECK103 = { name = "法術類型", tooltipText = "顯示法術傷害的類型"};
SCT.LOCALS.OPTION_CHECK104 = { name = "法術名稱", tooltipText = "顯示造成傷害的法術/技能的名稱"};
SCT.LOCALS.OPTION_CHECK105 = { name = "抵抗", tooltipText = "顯示你被敵人抵抗了的傷害"};
SCT.LOCALS.OPTION_CHECK106 = { name = "目標名字", tooltipText = "顯示目標的名字"};
SCT.LOCALS.OPTION_CHECK107 = { name = "關閉WoW傷害顯示", tooltipText = "關閉WoW內建的傷害顯示。\n\n注意：此設置與遊戲選單“介面->進階”中的相關設定有一樣的功能。但WOW本身介面的設定更為詳盡。"};
SCT.LOCALS.OPTION_CHECK108 = { name = "僅限目標", tooltipText = "只顯示你對目前目標造成的傷害。除非多個目標的名字都一樣，否則AE效果不會顯示出來。"};
SCT.LOCALS.OPTION_CHECK109 = { name = "在名牌上顯示", tooltipText = "啟用或是停用在敵人名牌上顯示你的傷害.\n\n敵人名牌功能需要開啟, 你必需看見敵人的名牌, 而這不會100%運行的 (如AOE一堆同名的怪物). 如沒法運行的話, 傷害會在預設的位置上顯示.\n\n關閉這功能需要重載UI才能生效.\n\n"};
SCT.LOCALS.OPTION_CHECK110 = { name = "使用SCT動畫", tooltipText = "使用SCT動畫效果顯示，而非以靜態訊息方式顯示"};
SCT.LOCALS.OPTION_CHECK111 = { name = "加重致命效果", tooltipText = "以「厚字體」顯示你造成的致命一擊或極效治療。關閉後，將以如+1236+的格式顯示"};
SCT.LOCALS.OPTION_CHECK112 = { name = "法術顏色", tooltipText = "以不同的顏色顯示不同類型的法術傷害（顏色不可更改）"};
SCT.LOCALS.OPTION_CHECK113 = { name = "傷害文字向下捲動", tooltipText = "傷害訊息向下捲動"};
SCT.LOCALS.OPTION_CHECK114 = { name = "簡寫式法術名", tooltipText = "啟動或是關閉簡寫式法術／技能名顯示（使用SCT的設定)"};
SCT.LOCALS.OPTION_CHECK115 = { name = "啟用SCTD自訂事件", tooltipText = "啟用或是停用SCTD自訂事件"};

--Slider options values
SCT.LOCALS.OPTION_SLIDER101 = { name="中心X坐標", minText="-600", maxText="600", tooltipText = "調整文字的水平位置"};
SCT.LOCALS.OPTION_SLIDER102 = { name="中心Y坐標", minText="-400", maxText="400", tooltipText = "調整文字的午直位置"};
SCT.LOCALS.OPTION_SLIDER103 = { name="淡出速度", minText="快", maxText="慢", tooltipText = "調整靜態訊息淡出的速度"};
SCT.LOCALS.OPTION_SLIDER104 = { name="字體大小", minText="小", maxText="大", tooltipText = "調整文字大小"};
SCT.LOCALS.OPTION_SLIDER105 = { name="透明度", minText="0%", maxText="100%", tooltipText = "調整文字透明度"};
SCT.LOCALS.OPTION_SLIDER106 = { name="HUD離中間距", minText="0", maxText="200", tooltipText = "控制HUD動畫效果和水平中央點的距離。對於想要訊息儘量靠中間顯示，但是想要調整和水平中間點離時使用。"};
SCT.LOCALS.OPTION_SLIDER107 = { name="傷害輸出過濾", minText="0", maxText="500", tooltipText = "設定SCTD傷害輸出顯示的門檻值. 可過濾掉少量的傷害,扣血效果...等等."};

--Misc option values
SCT.LOCALS.OPTION_MISC101 = {name="SCTD設定"..SCTD.Version};
--SCT.LOCALS.OPTION_MISC102 = {name="關閉", tooltipText = "儲存所有目前的設定，並關閉設定選單"};
SCT.LOCALS.OPTION_MISC103 = {name="SCTD", tooltipText = "打開SCT - Damage設定選單"};
SCT.LOCALS.OPTION_MISC104 = {name="傷害事件", tooltipText = ""};
SCT.LOCALS.OPTION_MISC105 = {name="顯示設定", tooltipText = ""};
SCT.LOCALS.OPTION_MISC106 = {name="框架設定", tooltipText = ""};

--Animation Types
SCT.LOCALS.OPTION_SELECTION101 = { name="傷害字體", tooltipText = "選擇文字字體", table = media:List("font")};
SCT.LOCALS.OPTION_SELECTION102 = { name="傷害字體輪廓", tooltipText = "選擇文字輪廓類型", table = {[1] = "無",[2] = "細",[3] = "粗"}};
SCT.LOCALS.OPTION_SELECTION103 = { name="傷害動畫類型", tooltipText = "選擇動畫類型", table = {[1] = "垂直(預設)",[2] = "彩虹",[3] = "水平",[4] = "斜下",[5] = "斜上",[6] = "灑落", [7] = "HUD曲線", [8] = "HUD斜向"}};
SCT.LOCALS.OPTION_SELECTION104 = { name="傷害顯示方向", tooltipText = "選擇顯示方向為左或是右", table = {[1] = "交替",[2] = "傷害向左",[3] = "傷害向右", [4] = "全部向左", [5] = "全部向右"}};
SCT.LOCALS.OPTION_SELECTION105 = { name="文字對齊", tooltipText = "設定文字如何對齊。在使用HUD動畫或是垂直顯示時最有用。「HUD方式對齊」將使得左側文字為靠右對齊／右側文字為靠左對齊。", table = {[1] = "左",[2] = "置中",[3] = "右", [4] = "HUD方式對齊"}};
SCT.LOCALS.OPTION_SELECTION106 = { name="圖示對齊", tooltipText = "選擇圖示的方向.",  table = {[1] = "左", [2] = "右", [3] = "向內", [4] = "向外",}};
