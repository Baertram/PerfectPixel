--German translations for the addon PerfectPixel
local stringsDe = {
	--[LAM settings]
	PP_LAM_ACTIVATE									= "Aktivieren",
	PP_LAM_COLOR									= "Farbe",
	PP_LAM_EDGE_COLOR								= "Rand Farbe",
	PP_LAM_LIST_BG									= "Listen Hintergrund",
	--Window & list style
	PP_LAM_WINDOW_STYLE 							= "Fenster Stil",
	PP_LAM_LIST_STYLE 								= "Listen Stil",
	PP_LAM_WINDOW_WIDTH								= "Fenster Breite",
	PP_LAM_WINDOW_STYLE_WIDER						= "Breitere Fenster - Sammlungen u.a.",
	PP_LAM_LIST_STYLE_BACKDROP 						= "Hintergrund",
	PP_LAM_LIST_STYLE_EDGE 							= "Kante",
	PP_LAM_LIST_STYLE_LIST 							= "Liste",
	PP_LAM_LIST_STYLE_INSETS 						= "Einschub",
	PP_LAM_LIST_STYLE_TILE_LAYING  					= "Kacheln verwenden",
	PP_LAM_LIST_STYLE_TILE_SIZE  					= "Kachel Größe",
	PP_LAM_LIST_STYLE_COLOR  						= "Farbe",
	PP_LAM_LIST_STYLE_HIGHLIGHT_COLOR				= "Hervorheben Farbe",
	PP_LAM_LIST_STYLE_THICKNESS						= "Dicke",
	PP_LAM_LIST_STYLE_FILE_WIDTH					= "Datei Breite",
	PP_LAM_LIST_STYLE_FILE_HEIGHT					= "Datei Höhe",
	PP_LAM_LIST_STYLE_STRETCH_TEXTURE_EDGE			= "Textur Ecken dehnen",
	PP_LAM_LIST_STYLE_FADE_DISTANCE					= "Ausblenden Distanz",
	PP_LAM_LIST_STYLE_UNIFORM_CONTROL_HEIGHT		= "Höhe der Zeile",
	--Other
	PP_LAM_OTHERS									= "Anderes",
	PP_LAM_DONOTINTERRUPT							= "Interaktive Aktionen nicht unterbrechen.",
	PP_LAM_BLUR_BG									= "Hintergrund Unschärfe",
	PP_LAM_FADE_SCENE_DURATION						= "Ausblenden Szenen Dauer (ms)",
	--Reticle
	PP_LAM_RETICLE									= "Fadenkreutz",
	PP_LAM_RETICLE_HIDE_STEALTH						= "Verstecke \"" .. GetString(SI_STEALTH_HIDDEN) .. "\" Text",
	--Tabs
	PP_LAM_TABS										= "Tabs",
	PP_LAM_TABS_HIDE_MENU_BAR_LABEL					= "Verstecke Menüleisten Label",
	PP_LAM_TABS_HIDE_TOP_BAR_BG						= "Verstecke Hintergrund der oberen Leiste",
	--Tooltips
	PP_LAM_TOOLTIPS									= "Tooltips",
	PP_LAM_COMPARATIVE_TOOLTIPS						= "Vergleichs Tooltips - Taste gedrückt halten",
	PP_LAM_COMPARATIVE_TOOLTIPS_TT					= "Vergleichs Tooltips werden nur dann angezeigt, wenn die gebundene Taste gedrückt gehalten wird. Weise eine Taste in den Steuerung Optionen zu!",	--NEW !!!
	PP_LAM_COMPARATIVE_TOOLTIPS_BIND				= "Vergleichs Tooltips",
	--Compass
	PP_LAM_COMPASS									= "Kompass",
	PP_LAM_COMPASS_QUEST							= "Quest Bereich",
	PP_LAM_COMPASS_COMBAT							= "Kampf Anzeige",
	--[LAM Scenes]
	--Inventory Scene
	PP_LAM_SCENE_INV								= "Inventar",
	PP_LAM_SCENE_INV_NO_SPIN						= "Kamera nicht rotieren.",
	PP_LAM_SCENE_INV_NO_SPIN_TT						= "Deaktiviere diese Einstellung, wenn du Probleme bei der Vorschau von Gegenständen bemerkst!",
	--SkillsScene
	PP_LAM_SCENE_SKILLS								= "Fertigkeiten",
	PP_LAM_SCENE_SKILLS_SKILLS_TREE_UNWRAPPED		= "Kompletter Fertigkeiten Baum",
	PP_LAM_SCENE_SKILLS_SKILLS_TREE_BG				= "Fertigkeiten Baum Hintergrund",
	--Journal Scene
	PP_LAM_SCENE_JOURNAL							= "Journal",
	PP_LAM_SCENE_JOURNAL_QUEST_LARGE_LIST			= "Große Quest Liste",
	--World map
	PP_LAM_SCENE_WORLDMAP							= "Werltkarte",
	PP_LAM_SCENE_WORLDMAP_LARGE						= "Große Karte",
	--GameMenuInGameScene
	PP_LAM_SCENE_GAME_MENU							= "Hauptmenü",
	PP_LAM_SCENE_GAME_MENU_ADDONS					= "AddOns",
	--Performance Meter
	PP_LAM_SCENE_PERFORMANCE_METER					= "Performance Anzeige",
	--CraftStations
	PP_LAM_CRAFT_STATIONS_PROVISIONER_SHOWTOOLTIP	= "Tooltip anzeigen",
	PP_LAM_TRANSPARENCY								= "Transparenz",
	--Keybindstrip
	PP_LAM_KEYBINDSTRIP								= "Tastenkombination Leiste",
	--Chat
	PP_LAM_SCENE_CHAT								= GetString(SI_CHAT_TAB_GENERAL),
	PP_LAM_CHAT_MINBAR								= "Chat min. Leiste stylen",
	--Companion SkillsScene
	PP_LAM_SCENE_COMPANION_SKILLS					= "Gefährten Fertigkeiten",
	--Alliance War Scene
	PP_LAM_SCENE_ALLIANCE_WAR						= "Allianz Krieg Szene",
	--Challenge Difficulty Scene
	PP_LAM_SCENE_CHALLENGE_DIFFICULTY				= "Herausforderungsschwierigkeit Szene",
	--Collections Scene
	PP_LAM_SCENE_COLLECTIONS						= "Sammlungen Szene",
	--Craft Stations Scene
	PP_LAM_SCENE_CRAFT_STATIONS					= "Handwerksstationen Szene",
	--Friends List Scene
	PP_LAM_SCENE_FRIENDS_LIST						= "Freundesliste Szene",
	--Group Menu Scene
	PP_LAM_SCENE_GROUP_MENU							= "Gruppenmenü Szene",
	--Guild Scene
	PP_LAM_SCENE_GUILD								= "Gilde Szene",
	--Help Scene
	PP_LAM_SCENE_HELP								= "Hilfe Szene",
	--Generic Selector Scene
	PP_LAM_SCENE_GENERIC_SELECTOR					= "Allgemeiner Auswahl Szene",
	--Lockpicking Scene
	PP_LAM_SCENE_LOCKPICKING						= "Schlosspicken Szene",
	--Mail Scene
	PP_LAM_SCENE_MAIL								= "Post Szene",
	--Notifications Scene
	PP_LAM_SCENE_NOTIFICATIONS						= "Benachrichtigungen Szene",
	--Stats Scene
	PP_LAM_SCENE_STATS								= "Statistiken Szene",
	--Tamriel Tomes Scene
	PP_LAM_SCENE_TAMRIEL_TOMES						= "Tamriel Folianten Szene",
	--Trading House Scene
	PP_LAM_SCENE_TRADING_HOUSE						= "Handelshaus Szene",
	--Restyle Station Scene
	PP_LAM_SCENE_RESTYLE_STATION					= "Umgestaltungsstation Szene",
	--Font in lists
	--PP_LAM_LIST_FONT								= "Listen Font",
}

---@class (partial) PP
local PP = PP
--Use the metatable to use EN strings for untranslated/missing stringIds
setmetatable(stringsDe, {__index = PP.stringsEn})

--Overwrite the EN strings with a new version
for stringId, stringValue in pairs(stringsDe) do
	SafeAddString(_G[stringId], stringValue, 1)  --Add a new version 1 for the global _G[stringId], overwriting it'S old version 1 from ZO_CreateStringId in en.lua
end