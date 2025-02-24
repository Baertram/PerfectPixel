local PP = PP --- @class PP
local removeFragmentsFromScene = PP.removeFragmentsFromScene

-- Constants
local NOTIFICATIONS_FRAGMENTS =
{
    FRAME_PLAYER_FRAGMENT,
    FRAME_TARGET_STANDARD_RIGHT_PANEL_FRAGMENT,
    RIGHT_BG_FRAGMENT,
    TITLE_FRAGMENT,
    NOTIFICATIONS_TITLE_FRAGMENT
}

local SCENE_CONFIG =
{
    {
        scene = NOTIFICATIONS_SCENE,
        gVar = ZO_Notifications
    }
}

local function setupNotificationsUI(tlc)
    -- Background setup
    PP:CreateBackground(tlc, nil, nil, nil, -10, -10, nil, nil, nil, 0, 10)

    -- Anchoring
    PP.Anchor(tlc, TOPRIGHT, GuiRoot, TOPRIGHT, 0, 120, true, BOTTOMRIGHT, GuiRoot, BOTTOMRIGHT, 0, -70)


    -- Scroll list configuration
    local list = tlc:GetNamedChild("List")
    local contents = list:GetNamedChild("Contents")
    -- Scrollbar setup
    local scrollBar = list:GetNamedChild("ScrollBar")
    PP.ScrollBar(scrollBar)
    PP.Anchor(scrollBar, nil, nil, nil, nil, nil, true, nil, nil, nil, 14, 0)
    ZO_Scroll_SetMaxFadeDistance(contents, PP.savedVars.ListStyle.list_fade_distance)
    ZO_ScrollList_Commit(list)
end

PP.notificationsScene = function ()
    for _, sceneInfo in ipairs(SCENE_CONFIG) do
        removeFragmentsFromScene(sceneInfo.scene, NOTIFICATIONS_FRAGMENTS)
        local tlc = sceneInfo.gVar.control or sceneInfo.gVar
        setupNotificationsUI(tlc)
    end
end
