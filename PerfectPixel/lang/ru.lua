--Russian translations for the addon PerfectPixel
local stringsRu = {
    --[LAM settings]
    PP_LAM_ACTIVATE                             = "Activate",
    --Other
    PP_LAM_OTHERS                               = "Others",
    PP_LAM_DONOTINTERRUPT                       = "Do not interrupt interactive activities",
    --Reticle
    PP_LAM_RETICLE                              = "Reticle",
    PP_LAM_RETICLE_HIDE_STEALTH                 = "Hide \"" .. GetString(SI_STEALTH_HIDDEN) .. "\" Text",
    --Tabs
    PP_LAM_TABS                                 = "Tabs",
    PP_LAM_TABS_HIDE_MENU_BAR_LABEL             = "Hide Menu Bar Label",
    PP_LAM_TABS_HIDE_TOP_BAR_BG                 = "Hide Top Bar Background",
    --Tooltips
    PP_LAM_TOOLTIPS                             = "Tooltips",
    --Compass
    PP_LAM_COMPASS                              = "Compass",
    PP_LAM_COMPASS_COLOR                        = "Compass color",
    PP_LAM_COMPASS_EDGE_COLOR                   = "Compass edge color",
    PP_LAM_COMPASS_QUEST_COLOR                  = "Quest area color",
    PP_LAM_COMPASS_QUEST_EDGE_COLOR             = "Quest area edge color",
    PP_LAM_COMPASS_COMBAT_INDICATOR             = "Combat indicator",
    PP_LAM_COMPASS_COMBAT_INDICATOR_EDGE_COLOR  = "Combat indicator edge color",
    --[LAM Scenes]
    --Inventory Scene
    PP_LAM_SCENE_INV                            = "Inventory Scene",
    PP_LAM_SCENE_INV_NO_SPIN                    = "No Spin",
    PP_LAM_SCENE_INV_NO_SPIN_TT                 = "Disable if you experience problems with the preview menu.",
    --Journal Scene
    PP_LAM_SCENE_JOURNAL                        = "Journal Scene",
    PP_LAM_SCENE_JOURNAL_QUEST_LARGE_LIST       = "Large quest list";
    PP_LAM_SCENE_JOURNAL_QUEST_BG               = "Quest list background",
    --World map
    PP_LAM_SCENE_WORLDMAP                       = "World Map",
    PP_LAM_SCENE_WORLDMAP_LARGE                 = "Large Map",
}

--Use the metatable to use EN strings for untranslated/missing stringIds
setmetatable(stringsRu, {__index = PP.stringsEn})

--Overwrite the EN strings with a new version
for stringId, stringValue in pairs(stringsRu) do
    ZO_CreateStringId(stringId, stringValue)
    SafeAddVersion(stringId, 1)
end