local PP = PP ---@class PP

---Styles the pointer box for attribute points allocation.
local function StylePointerBox(pointerBox)
    if not pointerBox then return end

    -- Find the active pointer box object from the global pointer box manager.
    local activePointerBoxes = POINTER_BOXES:GetActiveObjects()
    local pointerBoxObject
    for _, boxObject in pairs(activePointerBoxes) do
        if boxObject.control == pointerBox then
            pointerBoxObject = boxObject
            break
        end
    end

    if pointerBoxObject then
        -- Position the pointer box relative to the Magicka attribute bar.
        local attributesRow = ZO_StatsPanelPaneScrollChildAttributesRow1
        if attributesRow then
            pointerBoxObject:SetAnchor(RIGHT, attributesRow:GetNamedChild("Magicka"), LEFT, -10, 0)
            pointerBoxObject:SetPadding(20)
        end
    end
end

---Main function to initialize and style the stats scene.
PP.statsScene = function()
    -----------------
    -- SCENE SETUP --
    -----------------
    -- Remove default background.
    PP:ForceRemoveFragment(STATS_SCENE, STATS_BG_FRAGMENT)

    -- Create custom background.
    PP:CreateBackground(ZO_StatsPanel, --[[#1]] nil, ZO_AdvancedStatsPanel, nil, -15, -10, --[[#2]] nil, nil, nil, 0, 10)
    local bg = ZO_StatsPanel.PP_BG

    -- Initialize pointer box styling with deferred loading support.
    PP.onDeferredInitCheck(ZO_PointerBox_KeyboardControl1, StylePointerBox)

    -- Register scene state change callback.
    STATS_SCENE:RegisterCallback("StateChange", function(oldState, newState)
        if newState == SCENE_HIDDEN then
            bg:SetHidden(true)
        elseif newState == SCENE_SHOWING then
            PP:StyleAttributeBars()
        end
    end)

    ----------------------
    -- LAYOUT ANCHORING --
    ----------------------
    -- Main stats panel.
    PP.Anchor(ZO_StatsPanel,
        --[[#1]] TOPRIGHT, GuiRoot, TOPRIGHT, 0, 120,
        --[[#2]] true, BOTTOMRIGHT, GuiRoot, BOTTOMRIGHT, 0, -70
    )

    -- Stats panel pane.
    PP.Anchor(ZO_StatsPanelPane,
        --[[#1]] TOPLEFT, ZO_StatsPanelTitleSection, BOTTOMLEFT, 0, 0,
        --[[#2]] true, BOTTOMRIGHT, ZO_StatsPanel, BOTTOMRIGHT, 0, -3
    )

    -- Configure scrollbar.
    PP.ScrollBar(ZO_StatsPanelPane,
        --[[sb_c]] 180, 180, 180, 0.7,
        --[[bd_c]] 20, 20, 20, 0.7,
        true
    )

    -- Set fade distance.
    ZO_Scroll_SetMaxFadeDistance(ZO_StatsPanelPane, PP.savedVars.ListStyle.list_fade_distance)

    ------------------------
    -- ADVANCED STATS UI  --
    ------------------------
    -- Remove right background fragment.
    for i = 1, #ADVANCED_STATS_FRAGMENT_GROUP do
        if ADVANCED_STATS_FRAGMENT_GROUP[i] == RIGHT_BG_FRAGMENT then
            ADVANCED_STATS_FRAGMENT_GROUP[i] = nil
        end
    end

    local asPanel = ZO_AdvancedStatsPanel
    local asClose = ZO_AdvancedStatsPanelClose
    local asList = ZO_AdvancedStatsPanelAdvancedStatList

    -- Configure advanced stats panel width behavior.
    asPanel:SetWidth(0)
    ZO_PreHookHandler(asPanel, 'OnEffectivelyShown', function(self)
        self:SetWidth(320)
    end)
    ZO_PreHookHandler(asPanel, 'OnEffectivelyHidden', function(self)
        self:SetWidth(0)
    end)

    -- Anchor advanced stats panel.
    PP.Anchor(asPanel,
        --[[#1]] TOPRIGHT, ZO_StatsPanel, TOPLEFT, 0, 0,
        --[[#2]] true, BOTTOMRIGHT, ZO_StatsPanel, BOTTOMLEFT, 0, 0
    )

    -- Style close button fonts.
    PP.Font(asClose.keyLabel,
        --[[Font]] PP.f.u57, 16, "outline",
        --[[Alpha]] nil,
        --[[Color]] nil, nil, nil, nil,
        --[[StyleColor]] 0, 0, 0, 0.5
    )
    PP.Font(asClose.nameLabel,
        --[[Font]] PP.f.u67, 18, "outline",
        --[[Alpha]] nil,
        --[[Color]] nil, nil, nil, nil,
        --[[StyleColor]] 0, 0, 0, 0.5
    )

    -- Configure advanced stats list.
    PP.Anchor(asList, --[[#1]] nil, nil, nil, nil, nil, --[[#2]] true, nil, nil, nil, -20, nil)
    PP.ScrollBar(asList,
        --[[sb_c]] 180, 180, 180, 0.7,
        --[[bd_c]] 20, 20, 20, 0.7,
        true
    )
    ZO_Scroll_SetMaxFadeDistance(asList, PP.savedVars.ListStyle.list_fade_distance)
    ZO_ScrollList_Commit(asList)

    --------------------------
    -- LEVEL UP UI STYLING --
    --------------------------
    -- Style claim rewards screen.
    PP:CreateBackground(ZO_ClaimLevelUpRewardsScreen_Keyboard,
        --[[#1]] nil, nil, nil, -1, 0,
        --[[#2]] nil, nil, nil, -10, 10
    )
    PP.Anchor(ZO_ClaimLevelUpRewardsScreen_Keyboard,
        --[[#1]] TOPLEFT, nil, TOPLEFT, 0, 90,
        --[[#2]] true, BOTTOMLEFT, nil, BOTTOMLEFT, 0, -250
    )
    PP.Anchor(ZO_ClaimLevelUpRewardsScreen_KeyboardList,
        --[[#1]] TOPLEFT, ZO_ClaimLevelUpRewardsScreen_KeyboardTitleDivider, BOTTOMLEFT, 16, 0,
        --[[#2]] true, BOTTOM, ZO_ClaimLevelUpRewardsScreen_KeyboardClaimButton, CENTER, 0, -40
    )

    ZO_ClaimLevelUpRewardsScreen_KeyboardBG:SetHidden(true)
    ZO_ClaimLevelUpRewardsScreen_KeyboardTitleDivider:SetHidden(true)
    ZO_Scroll_SetMaxFadeDistance(ZO_ClaimLevelUpRewardsScreen_KeyboardList, PP.savedVars.ListStyle.list_fade_distance)

    PP.ScrollBar(ZO_ClaimLevelUpRewardsScreen_KeyboardList,
        --[[sb_c]] 180, 180, 180, 0.7,
        --[[bd_c]] 20, 20, 20, 0.7,
        true
    )

    -- Style upcoming rewards screen.
    PP:CreateBackground(ZO_UpcomingLevelUpRewards_Keyboard,
        --[[#1]] nil, nil, nil, -1, 0,
        --[[#2]] nil, nil, nil, -10, 10
    )
    PP.Anchor(ZO_UpcomingLevelUpRewards_Keyboard,
        --[[#1]] TOPLEFT, nil, TOPLEFT, 0, 90,
        --[[#2]] true, BOTTOMLEFT, nil, BOTTOMLEFT, 0, -250
    )
    PP.Anchor(ZO_UpcomingLevelUpRewards_KeyboardScrollContainer,
        --[[#1]] TOPLEFT, ZO_UpcomingLevelUpRewards_KeyboardTitleDivider, BOTTOMLEFT, 16, 0,
        --[[#2]] true, BOTTOMLEFT, ZO_UpcomingLevelUpRewards_Keyboard, BOTTOMLEFT, 16, 0
    )

    ZO_UpcomingLevelUpRewards_KeyboardBG:SetHidden(true)
    ZO_UpcomingLevelUpRewards_KeyboardTitleDivider:SetHidden(true)
    ZO_Scroll_SetMaxFadeDistance(ZO_UpcomingLevelUpRewards_KeyboardScrollContainer, PP.savedVars.ListStyle.list_fade_distance)

    PP.ScrollBar(ZO_UpcomingLevelUpRewards_KeyboardScrollContainer,
        --[[sb_c]] 180, 180, 180, 0.7,
        --[[bd_c]] 20, 20, 20, 0.7,
        true
    )
end

---Styles the attribute bars. (Health, Magicka, Stamina)
function PP:StyleAttributeBars()
    if not STATS or not STATS.attributeControls then return end

    local attributesRow = ZO_StatsPanelPaneScrollChildAttributesRow1
    if not attributesRow then return end

    -- Color schemes for each attribute type.
    local barColors = {
        ["Magicka"] = {
            bar = ZO_ColorDef:New(0.2, 0.4, 0.8, 0.95),    -- Brighter blue, more solid
            edge = ZO_ColorDef:New(0.1, 0.3, 0.6, 0.7),    -- Darker blue edge
            center = ZO_ColorDef:New(0, 0.1, 0.2, 0.4)     -- Very dark blue background
        },
        ["Health"] = {
            bar = ZO_ColorDef:New(0.8, 0.2, 0.2, 0.95),    -- Brighter red, more solid
            edge = ZO_ColorDef:New(0.6, 0.1, 0.1, 0.7),    -- Darker red edge
            center = ZO_ColorDef:New(0.1, 0, 0, 0.4)       -- Very dark red background
        },
        ["Stamina"] = {
            bar = ZO_ColorDef:New(0.3, 0.8, 0.3, 0.95),    -- Brighter green, more solid
            edge = ZO_ColorDef:New(0.2, 0.6, 0.2, 0.7),    -- Darker green edge
            center = ZO_ColorDef:New(0, 0.2, 0, 0.4)       -- Very dark green background
        }
    }

    -- Apply styling to each attribute bar.
    for attrType, colors in pairs(barColors) do
        local attrControl = attributesRow:GetNamedChild(attrType)
        if attrControl then
            local bar = attrControl:GetNamedChild("Bar")
            if bar then
                -- Configure bar appearance.
                bar:SetHeight(14)
                bar:SetTexture(nil)

                -- Create or update backdrop.
                local barBG = bar:GetNamedChild("Backdrop")
                if not barBG then
                    barBG = WINDOW_MANAGER:CreateControl("$(parent)Backdrop", bar, CT_BACKDROP)
                    PP.Anchor(barBG,
                        --[[#1]] TOPLEFT, bar, TOPLEFT, -2, -2,
                        --[[#2]] true, BOTTOMRIGHT, bar, BOTTOMRIGHT, 2, 2
                    )
                end

                -- Apply backdrop styling.
                barBG:SetCenterTexture(nil, 8, 0)
                barBG:SetEdgeTexture("", 1, 1, 1, 0)
                barBG:SetCenterColor(colors.center:UnpackRGBA())
                barBG:SetEdgeColor(colors.edge:UnpackRGBA())
                bar:SetColor(colors.bar:UnpackRGBA())
                barBG:SetInsets(-1, -1, 1, 1)

                -- Add gloss effect?
                local gloss = bar:GetNamedChild("Gloss")
                if not gloss then
                    gloss = WINDOW_MANAGER:CreateControl("$(parent)Gloss", bar, CT_TEXTURE)
                    gloss:SetHeight(14)
                    gloss:SetTexture(nil)
                    gloss:SetAnchorFill(bar)
                    gloss:SetBlendMode(TEX_BLEND_MODE_ADD)
                    gloss:SetAlpha(0.1)
                end
            end
        end
    end
end