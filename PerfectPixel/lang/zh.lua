--Chinese (Simplified) translations for the addon PerfectPixel
local stringsZh = {
	--[LAM settings]
	PP_LAM_ACTIVATE									= "激活",
	PP_LAM_COLOR									= "颜色",
	PP_LAM_EDGE_COLOR								= "边缘颜色",
	PP_LAM_LIST_BG									= "列表背景",
	--Window & list style
	PP_LAM_WINDOW_STYLE 							= "窗口样式",
	PP_LAM_LIST_STYLE 								= "列表样式",
	PP_LAM_LIST_STYLE_BACKDROP 						= "背景",
	PP_LAM_LIST_STYLE_EDGE 							= "边缘",
	PP_LAM_LIST_STYLE_LIST 							= "列表",
	PP_LAM_LIST_STYLE_INSETS 						= "内边距",
	PP_LAM_LIST_STYLE_TILE_LAYING  					= "平铺",
	PP_LAM_LIST_STYLE_TILE_SIZE  					= "平铺大小",
	PP_LAM_LIST_STYLE_COLOR  						= "颜色",
	PP_LAM_LIST_STYLE_HIGHLIGHT_COLOR				= "高亮颜色",
	PP_LAM_LIST_STYLE_SELECTED_COLOR				= "选中颜色",
	PP_LAM_LIST_STYLE_THICKNESS						= "厚度",
	PP_LAM_LIST_STYLE_FILE_WIDTH					= "文件宽度",
	PP_LAM_LIST_STYLE_FILE_HEIGHT					= "文件高度",
	PP_LAM_LIST_STYLE_STRETCH_TEXTURE_EDGE			= "拉伸纹理边缘",
	PP_LAM_LIST_STYLE_FADE_DISTANCE					= "淡出距离",
	PP_LAM_LIST_STYLE_UNIFORM_CONTROL_HEIGHT		= "行高度",
	PP_LAM_LIST_STYLE_CONTROL_HEIGHT				= "控件高度",
	--Other
	PP_LAM_OTHERS									= "其他",
	PP_LAM_DONOTINTERRUPT							= "不中断交互动作。",
	PP_LAM_BLUR_BG									= "背景模糊",
	PP_LAM_FADE_SCENE_DURATION						= "场景淡出时间 (毫秒)",
	--Reticle
	PP_LAM_RETICLE									= "准星",
	PP_LAM_RETICLE_HIDE_STEALTH						= "隐藏\"" .. GetString(SI_STEALTH_HIDDEN) .. "\"文字",
	--Tabs
	PP_LAM_TABS										= "标签页",
	PP_LAM_TABS_HIDE_MENU_BAR_LABEL					= "隐藏菜单栏标签",
	PP_LAM_TABS_HIDE_TOP_BAR_BG						= "隐藏顶部栏背景",
	--Tooltips
	PP_LAM_TOOLTIPS									= "提示框",
	PP_LAM_COMPARATIVE_TOOLTIPS						= "比较提示框 - 按住显示",
	PP_LAM_COMPARATIVE_TOOLTIPS_TT					= "比较提示框仅在按住绑定的按键时显示。请在控制设置中绑定按键！",
	PP_LAM_COMPARATIVE_TOOLTIPS_BIND				= "比较提示框",
	--Compass
	PP_LAM_COMPASS									= "罗盘",
	PP_LAM_COMPASS_QUEST							= "任务区域",
	PP_LAM_COMPASS_COMBAT							= "战斗指示器",
	--[LAM Scenes]
	--Inventory Scene
	PP_LAM_SCENE_INV								= "背包界面",
	PP_LAM_SCENE_INV_NO_SPIN						= "不旋转摄像机。",
	PP_LAM_SCENE_INV_NO_SPIN_TT						= "如果预览功能出现问题，请禁用此选项。",
	--SkillsScene
	PP_LAM_SCENE_SKILLS								= "技能界面",
	PP_LAM_SCENE_SKILLS_SKILLS_TREE_UNWRAPPED		= "展开技能树",
	PP_LAM_SCENE_SKILLS_SKILLS_TREE_BG				= "技能树背景",
	--Journal Scene
	PP_LAM_SCENE_JOURNAL							= "日志界面",
	PP_LAM_SCENE_JOURNAL_QUEST_LARGE_LIST			= "大型任务列表",
	--World map
	PP_LAM_SCENE_WORLDMAP							= "世界地图",
	PP_LAM_SCENE_WORLDMAP_LARGE						= "大型地图",
	--GameMenuInGameScene
	PP_LAM_SCENE_GAME_MENU							= "主菜单界面",
	PP_LAM_SCENE_GAME_MENU_ADDONS					= "插件",
	--Performance Meter
	PP_LAM_SCENE_PERFORMANCE_METER					= "性能指示器",
	--CraftStations
	PP_LAM_CRAFT_STATIONS_PROVISIONER_SHOWTOOLTIP	= "显示提示框",
	PP_LAM_TRANSPARENCY								= "透明度",
	--Keybindstrip
	PP_LAM_KEYBINDSTRIP								= "快捷键栏",
	--Chat
	PP_LAM_SCENE_CHAT								= GetString(SI_CHAT_TAB_GENERAL),
	PP_LAM_CHAT_MINBAR								= "聊天栏样式",
	--Companion SkillsScene
	PP_LAM_SCENE_COMPANION_SKILLS					= "同伴技能界面",
	--Font in lists
	--PP_LAM_LIST_FONT								= "列表字体",
}

---@class PP
local PP = PP
--Use the metatable to use EN strings for untranslated/missing stringIds
setmetatable(stringsZh, {__index = PP.stringsEn})

--Overwrite the EN strings with a new version
for stringId, stringValue in pairs(stringsZh) do
	SafeAddString(_G[stringId], stringValue, 1)  --Add a new version 1 for the global _G[stringId], overwriting it'S old version 1 from ZO_CreateStringId in en.lua
end