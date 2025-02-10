local PP = PP --- @class PP

PP.worldMapScene = function ()
    -- ===============================================================================================--
    -- Saved Variables setup
    local SV_VER = 0.1
    local DEF =
    {
        toggle = true,
        large = true,
    }
    local SV = ZO_SavedVars:NewAccountWide(PP.ADDON_NAME, SV_VER, "WorldMap", DEF, GetWorldName())

    -- LAM Menu Options
    local function CreateOptions()
        table.insert(PP.optionsData,
            {
                type = "submenu",
                name = GetString(PP_LAM_SCENE_WORLDMAP),
                controls =
                {
                    {
                        type = "checkbox",
                        name = GetString(PP_LAM_ACTIVATE),
                        getFunc = function () return SV.toggle end,
                        setFunc = function (value) SV.toggle = value end,
                        default = DEF.toggle,
                        requiresReload = true,
                    },
                    {
                        type = "checkbox",
                        name = GetString(PP_LAM_SCENE_WORLDMAP_LARGE),
                        getFunc = function () return SV.large end,
                        setFunc = function (value) SV.large = value end,
                        default = DEF.large,
                        disabled = function () return not SV.toggle end,
                        requiresReload = true,
                    },
                },
            })
    end

    -- Early exit if disabled
    if not SV.toggle then
        CreateOptions()
        return
    end

    -- Remove default UI fragments
    local function RemoveDefaultFragments()
        WORLD_MAP_SCENE:RemoveFragment(WORLD_MAP_INFO_BG_FRAGMENT)
        WORLD_MAP_SCENE:RemoveFragment(MEDIUM_LEFT_PANEL_BG_FRAGMENT)
        PP:ForceRemoveFragment(WORLD_MAP_SCENE, MEDIUM_LEFT_PANEL_BG_FRAGMENT)
    end

    -- Create custom backgrounds
    local function CreateBackgrounds()
        PP:CreateBackground(ZO_WorldMap, --[[#1]] nil, nil, nil, 0, 0, --[[#2]] nil, nil, nil, 0, 0)
        PP:CreateBackground(ZO_WorldMapInfo, --[[#1]] nil, nil, nil, -16, 51, --[[#2]] nil, nil, nil, 0, 9)
        PP:CreateBackground(ZO_WorldMapZoneStoryTopLevel_Keyboard, --[[#1]] nil, nil, nil, 0, -4, --[[#2]] nil, nil, nil, 0, 48)
    end

    -- Setup background visibility handling
    local function SetupBackgroundVisibility()
        PP:SetLockFn(ZO_WorldMap.PP_BG, "SetHidden")

        WORLD_MAP_SCENE:RegisterCallback("StateChange", function (oldState, newState)
            if newState == SCENE_SHOWN then
                ZO_WorldMapMapFrame:SetHidden(true)
                PP:CallLockFn(ZO_WorldMap.PP_BG, "SetHidden", false)
            elseif newState == SCENE_HIDDEN then
                PP:CallLockFn(ZO_WorldMap.PP_BG, "SetHidden", true)
            end
        end)
    end

    -- Style UI elements
    local function StyleUIElements()
        -- Zoom controls
        ZO_WorldMapZoomKeybindKeyLabel:SetFont(PP.f.u57 .. "|16")
        ZO_WorldMapZoomKeybindNameLabel:SetFont(PP.f.u67 .. "|18|outline")
        ZO_WorldMapZoomDivider:SetHidden(true)

        -- Menu bar
        ZO_WorldMapInfoMenuBarLabel:SetHidden(true)
        ZO_WorldMapInfoMenuBarDivider:SetHidden(true)

        -- Keep info and upgrade bar (visible by clicking on a keep/resource in Cyrodiil.)
        if ZO_WorldMapKeepInfo then
            PP:CreateBackground(ZO_WorldMapKeepInfo, --[[#1]] nil, nil, nil, -16, 51, --[[#2]] nil, nil, nil, 0, 9)
            if ZO_WorldMapKeepInfoMenuBarDivider then
                ZO_WorldMapKeepInfoMenuBarDivider:SetHidden(true)
            end
        end

        if ZO_WorldMapKeepUpgradeBar then
            PP.Bar(ZO_WorldMapKeepUpgradeBar, --[[height]] 10, --[[fontSize]] 15)
        end
    end

    -- Setup anchors
    local function SetupAnchors()
        PP.Anchor(ZO_WorldMapInfo, --[[#1]] TOPRIGHT, nil, TOPRIGHT, 0, 60, --[[#2]] true, BOTTOMRIGHT, nil, BOTTOMRIGHT, 0, -70)
    end

    -- Setup scrollbars
    local function SetupScrollbars()
        local scrollableControls =
        {
            ZO_WorldMapQuestsPane,
            ZO_WorldMapKeyPane,
            ZO_WorldMapLocationsList,
            ZO_WorldMapHousesList,
        }

        -- Add LibMapPins containers if they exist
        if ZO_WorldMapFiltersPvEContainer then
            table.insert(scrollableControls, ZO_WorldMapFiltersPvEContainer)
        end
        if ZO_WorldMapFiltersPvPContainer then
            table.insert(scrollableControls, ZO_WorldMapFiltersPvPContainer)
        end

        for _, control in ipairs(scrollableControls) do
            PP.ScrollBar(control, --[[sb_c]] 180, 180, 180, 0.7, --[[bd_c]] 20, 20, 20, 0.7, false)
            ZO_Scroll_SetMaxFadeDistance(control, 10)
        end
    end

    -- Setup content panes
    local function SetupContentPanes()
        local panes =
        {
            { control = ZO_WorldMapQuests,    x = 0 },
            { control = ZO_WorldMapKey,       x = -20 },
            { control = ZO_WorldMapFilters,   x = -20 },
            { control = ZO_WorldMapLocations, x = -20 },
            { control = ZO_WorldMapHouses,    x = -20 },
        }

        for _, pane in ipairs(panes) do
            PP.Anchor(pane.control, --[[#1]] TOPLEFT, ZO_WorldMapInfo, TOPLEFT, pane.x, 60, --[[#2]] true, BOTTOMRIGHT, ZO_WorldMapInfo, BOTTOMRIGHT, 0, 0)
        end

        -- Commit scroll lists
        ZO_ScrollList_Commit(ZO_WorldMapLocationsList)
        ZO_ScrollList_Commit(ZO_WorldMapHousesList)
    end

    -- Setup zoom controls
    local function SetupZoomControls()
        PP.Anchor(ZO_WorldMapZoom, --[[#1]] BOTTOM, GuiRoot, BOTTOM, 0, -50)
    end

    -- Setup zone story UI
    local function SetupZoneStoryUI()
        -- Style scrollbar
        PP.ScrollBar(ZO_WorldMapZoneStoryTopLevel_KeyboardList, --[[sb_c]] 180, 180, 180, 0.7, --[[bd_c]] 20, 20, 20, 0.7, true)
        ZO_Scroll_SetMaxFadeDistance(ZO_WorldMapZoneStoryTopLevel_KeyboardList, 10)

        -- Setup anchors
        PP.Anchor(ZO_WorldMapZoneStoryTopLevel_Keyboard, --[[#1]] TOPLEFT, GuiRoot, TOPLEFT, 0, 200)
        PP.Anchor(ZO_WorldMapZoneStoryTopLevel_KeyboardList, --[[#1]] TOPLEFT, ZO_WorldMapZoneStoryTopLevel_Keyboard, TOPLEFT, 8, 0, --[[#2]] true, BOTTOMRIGHT, ZO_WorldMapZoneStoryTopLevel_Keyboard, BOTTOMRIGHT, 0, 0)
        PP.Anchor(ZO_WorldMapZoneStoryTopLevel_KeyboardZoneStoriesButton, --[[#1]] TOP, ZO_WorldMapZoneStoryTopLevel_Keyboard, BOTTOM, 8, 10)
        PP.Anchor(ZO_WorldMapZoneStoryTopLevel_KeyboardTitle, --[[#1]] BOTTOM, ZO_WorldMapZoneStoryTopLevel_Keyboard, TOP, 8, -2)

        -- Style title
        PP.Font(ZO_WorldMapZoneStoryTopLevel_KeyboardTitle, --[[Font]] PP.f.u67, 24, "outline", --[[Alpha]] 0.9, --[[Color]] nil, nil, nil, nil, --[[StyleColor]] 0, 0, 0, 0.8)
        ZO_WorldMapZoneStoryTopLevel_KeyboardTitleDivider:SetHidden(true)

        -- Hook completion type setup
        local dataType = ZO_ScrollList_GetDataTypeTable(ZO_WorldMapZoneStoryTopLevel_KeyboardList, 1)
        local existingSetupCallback = dataType.setupCallback
        dataType.setupCallback = function (control, data)
            existingSetupCallback(control, data)
            PP.Anchor(control.progressBar, --[[#1]] LEFT, control.icon, RIGHT, 0, 0, --[[#2]] true, RIGHT, control, RIGHT, -6, 0)
            PP.Bar(control.progressBar, --[[height]] 14, --[[fontSize]] 14)
        end

        -- Hook refresh info
        ZO_PostHook(ZO_WorldMapZoneStory_Keyboard, "RefreshInfo", function (self)
            local listData = ZO_ScrollList_GetDataList(self.list)
            if self:IsShowing() then
                self.control:SetDimensions(300, #listData * 40)
            else
                self.control:SetDimensions(300, 500)
            end
            ZO_ScrollList_Commit(self.list)
        end)
    end

    -- Setup large map mode
    local function SetupLargeMap()
        if not SV.large then return end

        local modes =
        {
            [MAP_MODE_LARGE_CUSTOM] = true,
            [MAP_MODE_KEEP_TRAVEL] = true,
            [MAP_MODE_FAST_TRAVEL] = true,
            [MAP_MODE_AVA_RESPAWN] = true,
            [MAP_MODE_AVA_KEEP_RECALL] = true,
        }

        PP.Anchor(ZO_WorldMapZoom, --[[#1]] TOPLEFT, GuiRoot, TOPLEFT, 60, 100)

        local zoom = ZO_WorldMap_GetPanAndZoom()

        local function MapSize()
            if WORLD_MAP_SCENE:IsShowing() and modes[WORLD_MAP_MANAGER:GetMode()] then
                PP.Anchor(ZO_WorldMap, --[[#1]] TOP, nil, TOP, 70, 80, --[[#2]] true, BOTTOM, nil, BOTTOM, 70, -70)
                local x = ZO_WorldMap:GetHeight()
                local currentZoom = zoom:GetCurrentNormalizedZoom()
                ZO_WorldMap:SetDimensions(x, x)
                ZO_WorldMapScroll:SetDimensions(x, x)
                zoom:SetCurrentNormalizedZoomInternal(currentZoom + 0.001)
                zoom:SetCurrentNormalizedZoomInternal(currentZoom)
            end
        end

        WORLD_MAP_SCENE:RegisterCallback("StateChange", function (oldState, newState)
            if newState == SCENE_SHOWING then
                MapSize()
            end
        end)

        ZO_WorldMap:RegisterForEvent(EVENT_SCREEN_RESIZED, function ()
            MapSize()
        end)

        -- Hook map update functions
        local orig_ZO_WorldMap_UpdateMap = ZO_WorldMap_UpdateMap
        function ZO_WorldMap_UpdateMap()
            orig_ZO_WorldMap_UpdateMap()
            MapSize()
        end

        local orig_ZO_WorldMap_RefreshMapFrameAnchor = ZO_WorldMap_RefreshMapFrameAnchor
        function ZO_WorldMap_RefreshMapFrameAnchor(...)
            if WORLD_MAP_SCENE:IsShowing() and modes[WORLD_MAP_MANAGER:GetMode()] then
                return
            end
            return orig_ZO_WorldMap_RefreshMapFrameAnchor(...)
        end
    end

    -- Initialize everything
    CreateOptions()
    RemoveDefaultFragments()
    CreateBackgrounds()
    SetupBackgroundVisibility()
    StyleUIElements()
    SetupAnchors()
    SetupScrollbars()
    SetupContentPanes()
    SetupZoomControls()
    SetupZoneStoryUI()
    SetupLargeMap()
end
