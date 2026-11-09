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
	--Alliance War Scene
	PP_LAM_SCENE_ALLIANCE_WAR						= "Сцена Войны Альянсов",
	--Challenge Difficulty Scene
	PP_LAM_SCENE_CHALLENGE_DIFFICULTY				= "Сцена Сложности Испытаний",
	--Collections Scene
	PP_LAM_SCENE_COLLECTIONS						= "Сцена Коллекций",
	--Craft Stations Scene
	PP_LAM_SCENE_CRAFT_STATIONS					= "Сцена Ремесленных Станций",
	--Friends List Scene
	PP_LAM_SCENE_FRIENDS_LIST						= "Сцена Списка Друзей",
	--Group Menu Scene
	PP_LAM_SCENE_GROUP_MENU							= "Сцена Меню Группы",
	--Guild Scene
	PP_LAM_SCENE_GUILD								= "Сцена Гильдии",
	--Help Scene
	PP_LAM_SCENE_HELP								= "Сцена Помощи",
	--Generic Selector Scene
	PP_LAM_SCENE_GENERIC_SELECTOR					= "Сцена Общего Выбора",
	--Lockpicking Scene
	PP_LAM_SCENE_LOCKPICKING						= "Сцена Взлома Замков",
	--Mail Scene
	PP_LAM_SCENE_MAIL								= "Сцена Почты",
	--Notifications Scene
	PP_LAM_SCENE_NOTIFICATIONS						= "Сцена Уведомлений",
	--Stats Scene
	PP_LAM_SCENE_STATS								= "Сцена Статистики",
	--Tamriel Tomes Scene
	PP_LAM_SCENE_TAMRIEL_TOMES						= "Сцена Фолиантов Тамриэля",
	--Trading House Scene
	PP_LAM_SCENE_TRADING_HOUSE						= "Сцена Торгового Дома",
	--Restyle Station Scene
	PP_LAM_SCENE_RESTYLE_STATION					= "Сцена Станции Перестройки",
	--Chat
	PP_LAM_SCENE_CHAT								= GetString(SI_CHAT_TAB_GENERAL),
}

---@class (partial) PP
local PP = PP
--Use the metatable to use EN strings for untranslated/missing stringIds
setmetatable(stringsRu, {__index = PP.stringsEn})

--Overwrite the EN strings with a new version
for stringId, stringValue in pairs(stringsRu) do
	SafeAddString(_G[stringId], stringValue, 1)  --Add a new version 1 for the global _G[stringId], overwriting it'S old version 1 from ZO_CreateStringId in en.lua
end