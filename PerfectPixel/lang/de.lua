--German translations for the addon PerfectPixel
local stringsDe = {
    --[LAM settings]
    PP_LAM_ACTIVATE                             = "Aktivieren",
    --Other
    PP_LAM_OTHERS                               = "Anderes",
    PP_LAM_DONOTINTERRUPT                       = "Aktivitäten nicht unterbrechen",
    --Reticle
    PP_LAM_RETICLE                              = "Fadenkreutz",
    PP_LAM_RETICLE_HIDE_STEALTH                 = "Verstecke \"" .. GetString(SI_STEALTH_HIDDEN) .. "\"  Text",
    --Tabs
    --PP_LAM_TABS                                 = "Tabs",
    PP_LAM_TABS_HIDE_MENU_BAR_LABEL             = "Verstecke Menuzeilen Label",
    PP_LAM_TABS_HIDE_TOP_BAR_BG                 = "Verstecke Hintergrund der Hauptmenü Zeile",
    --Tooltips
    PP_LAM_TOOLTIPS                             = "Tooltips",
    --Compass
    PP_LAM_COMPASS                              = "Kompass",
    PP_LAM_COMPASS_COLOR                        = "Kompass Farbe",
    PP_LAM_COMPASS_EDGE_COLOR                   = "Kompass Rand Farbe",
    PP_LAM_COMPASS_QUEST_COLOR                  = "Quest Bereich Farbe",
    PP_LAM_COMPASS_QUEST_EDGE_COLOR             = "Quest Bereich Rand Farbe",
    PP_LAM_COMPASS_COMBAT_INDICATOR             = "Kampf Anzeige aktivieren",
    PP_LAM_COMPASS_COMBAT_INDICATOR_EDGE_COLOR  = "Kampf Anzeige Rand Farbe",
    --[LAM Scenes]
    --Inventory Scene
    PP_LAM_SCENE_INV                            = "Inventar",
    PP_LAM_SCENE_INV_NO_SPIN                    = "Charakter nicht umdrehen",
    PP_LAM_SCENE_INV_NO_SPIN_TT                 = "Deaktiviere diese Einstellung, wenn du Probleme im Vorschau Menü bemerkst.",
    --Journal Scene
    PP_LAM_SCENE_JOURNAL                        = "Questtagebuch",
    PP_LAM_SCENE_JOURNAL_QUEST_LARGE_LIST       = "Große QuestListe";
    PP_LAM_SCENE_JOURNAL_QUEST_BG               = "Questlisten Hintergrund",
    --World map
    PP_LAM_SCENE_WORLDMAP                       = "Weltkarte",
    PP_LAM_SCENE_WORLDMAP_LARGE                 = "Große Karte",
}

--Use the metatable to use EN strings for untranslated/missing stringIds
setmetatable(stringsDe, {__index = PP.stringsEn})

--Overwrite the EN strings with a new version
for stringId, stringValue in pairs(stringsDe) do
    ZO_CreateStringId(stringId, stringValue)
    SafeAddVersion(stringId, 1)
end