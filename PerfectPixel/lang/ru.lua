--Russian translations for the addon PerfectPixel
local stringsRu = {
	--[LAM settings]
	PP_LAM_ACTIVATE									= "Включить",
	PP_LAM_COLOR									= "Цвет",
	PP_LAM_EDGE_COLOR								= "Цвет каймы",
	PP_LAM_LIST_BG									= "Фон списка",
	--Other
	PP_LAM_OTHERS									= "Разное",
	PP_LAM_DONOTINTERRUPT							= "Не прерывайть интерактивные действия.",
	--Reticle
	PP_LAM_RETICLE									= "Перекрестье",
	PP_LAM_RETICLE_HIDE_STEALTH						= "Скрыть текст \"" .. GetString(SI_STEALTH_HIDDEN) .. "\"",
	--Tabs
	PP_LAM_TABS										= "Вкладки",
	PP_LAM_TABS_HIDE_MENU_BAR_LABEL					= "Скрыть текст больших вкладок",
	PP_LAM_TABS_HIDE_TOP_BAR_BG						= "Скрыть фон верхних вкладок",
	--Tooltips
	PP_LAM_TOOLTIPS									= "Всплывающие подсказки",
	PP_LAM_COMPARATIVE_TOOLTIPS						= "Подсказки сравнения - при нажатой кнопке",
	PP_LAM_COMPARATIVE_TOOLTIPS_TT					= "Сравнительные подсказки будут отображаться только тогда, когда вы удерживаете назначенную кнопку. Назначьте кнопку в меню управления!",
	PP_LAM_COMPARATIVE_TOOLTIPS_BIND				= "Подсказки сравнения",
	--Compass
	PP_LAM_COMPASS									= "Компас",
	PP_LAM_COMPASS_QUEST							= "Область заданий",
	PP_LAM_COMPASS_COMBAT							= "Индикатор боя",
	--[LAM Scenes]
	--Inventory Scene
	PP_LAM_SCENE_INV								= "Сцена Инвентаря",
	PP_LAM_SCENE_INV_NO_SPIN						= "Не вращать камеру",
	PP_LAM_SCENE_INV_NO_SPIN_TT						= "Отключите если испытываете проблемы с функциями предварительного просмотра.",
	--SkillsScene
	PP_LAM_SCENE_SKILLS								= "Сцена Навыков",
	PP_LAM_SCENE_SKILLS_SKILLS_TREE_UNWRAPPED		= "Развернутое дерево навыков",
	PP_LAM_SCENE_SKILLS_SKILLS_TREE_BG				= "Фон дерева навыков",
	--Journal Scene
	PP_LAM_SCENE_JOURNAL							= "Сцена Журнала",
	PP_LAM_SCENE_JOURNAL_QUEST_LARGE_LIST			= "Большой список заданий",
	--World map
	PP_LAM_SCENE_WORLDMAP							= "Сцена Карты Мира",
	PP_LAM_SCENE_WORLDMAP_LARGE						= "Большая карта",
	--GameMenuInGameScene
	PP_LAM_SCENE_GAME_MENU							= "Сцена Главного Меню",
	PP_LAM_SCENE_GAME_MENU_ADDONS					= "Модификации",
	--Performance Meter
	PP_LAM_SCENE_PERFORMANCE_METER					= "Измеритель производительности",
	--CraftStations
	PP_LAM_CRAFT_STATIONS_PROVISIONER_SHOWTOOLTIP	= "Показать подсказку",
	--Chat
	PP_LAM_SCENE_CHAT								= GetString(SI_CHAT_TAB_GENERAL),
}

--Use the metatable to use EN strings for untranslated/missing stringIds
setmetatable(stringsRu, {__index = PP.stringsEn})

--Overwrite the EN strings with a new version
for stringId, stringValue in pairs(stringsRu) do
    ZO_CreateStringId(stringId, stringValue)
    SafeAddVersion(stringId, 1)
end