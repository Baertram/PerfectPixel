local PP = PP ---@class PP

PP.worldMapScene = function()
--===============================================================================================--
	local SV_VER		= 0.1
	local DEF = {
		toggle			= true,
		large			= true,
	}
	local SV = ZO_SavedVars:NewAccountWide(PP.ADDON_NAME, SV_VER, "WorldMap", DEF, GetWorldName())
	---------------------------------------------
	table.insert(PP.optionsData,
	{	type				= "submenu",
		name				= GetString(PP_LAM_SCENE_WORLDMAP),
		controls = {
			{	type				= "checkbox",
				name				= GetString(PP_LAM_ACTIVATE),
				getFunc				= function() return SV.toggle end,
				setFunc				= function(value) SV.toggle = value end,
				default				= DEF.toggle,
				requiresReload		= true,
			},
			{	type				= "checkbox",
				name				= GetString(PP_LAM_SCENE_WORLDMAP_LARGE),
				getFunc				= function() return SV.large end,
				setFunc				= function(value) SV.large = value end,
				default				= DEF.large,
				disabled			= function() return not SV.toggle end,
				requiresReload		= true,
			},
		},
	})
--===============================================================================================--
	if not SV.toggle then return end

	WORLD_MAP_SCENE:RemoveFragment(WORLD_MAP_INFO_BG_FRAGMENT)
	WORLD_MAP_SCENE:RemoveFragment(MEDIUM_LEFT_PANEL_BG_FRAGMENT)
	PP:ForceRemoveFragment(WORLD_MAP_SCENE, MEDIUM_LEFT_PANEL_BG_FRAGMENT)

	PP:CreateBackground(ZO_WorldMap,							--[[#1]] nil, nil, nil, 0, 0,		--[[#2]] nil, nil, nil, 0, 0)
	PP:CreateBackground(ZO_WorldMapInfo,						--[[#1]] nil, nil, nil, -16, 51,	--[[#2]] nil, nil, nil, 0, 9)
	PP:CreateBackground(ZO_WorldMapZoneStoryTopLevel_Keyboard,	--[[#1]] nil, nil, nil, 0, -4,		--[[#2]] nil, nil, nil, 0, 48)

	PP:SetLockFn(ZO_WorldMap.PP_BG, 'SetHidden')

	WORLD_MAP_SCENE:RegisterCallback("StateChange", function(oldState, newState)
		if newState == SCENE_SHOWN then
			ZO_WorldMapMapFrame:SetHidden(true)
			PP:CallLockFn(ZO_WorldMap.PP_BG, 'SetHidden', false)
		elseif newState == SCENE_HIDDEN then
			PP:CallLockFn(ZO_WorldMap.PP_BG, 'SetHidden', true)
		end
	end)

	ZO_WorldMapZoomKeybindKeyLabel:SetFont(PP.f.u57 .. "|16")
	ZO_WorldMapZoomKeybindNameLabel:SetFont(PP.f.u67 .. "|18|outline")
	ZO_WorldMapZoomDivider:SetHidden(true)

	ZO_WorldMapInfoMenuBarLabel:SetHidden(true)
	ZO_WorldMapInfoMenuBarDivider:SetHidden(true)

	PP.Anchor(ZO_WorldMapInfo, --[[#1]] TOPRIGHT, nil, TOPRIGHT, 0, 60, --[[#2]] true, BOTTOMRIGHT, nil, BOTTOMRIGHT, 0, -70)
    -- if ZO_WorldMapFiltersPvEContainer == nil then
        -- ZO_WorldMapFiltersPvEContainer = CreateControl("ZO_WorldMapFiltersPvEContainer", ZO_WorldMapFiltersPvE, CT_CONTROL)
    -- end
	-- if ZO_WorldMapFiltersPvPContainer == nil then
        -- ZO_WorldMapFiltersPvPContainer = CreateControl("ZO_WorldMapFiltersPvPContainer", ZO_WorldMapFiltersPvP, CT_CONTROL)
    -- end
    local tab = { ZO_WorldMapQuestsPane, ZO_WorldMapKeyPane, ZO_WorldMapLocationsList, ZO_WorldMapHousesList }
	--LibMapPins will add the container (scrollable) to the MapFilters PVE and PVP
    if ZO_WorldMapFiltersPvEContainer ~= nil then
        table.insert(tab, ZO_WorldMapFiltersPvEContainer)
    end
	if ZO_WorldMapFiltersPvPContainer ~= nil then
        table.insert(tab, ZO_WorldMapFiltersPvPContainer)
    end
    for _, v in ipairs(tab) do
        PP.ScrollBar(v, --[[sb_c]] 180, 180, 180, 0.7, --[[bd_c]] 20, 20, 20, 0.7, false)
        ZO_Scroll_SetMaxFadeDistance(v, 10)
    end

	PP.Anchor(ZO_WorldMapQuests, --[[#1]] TOPLEFT, ZO_WorldMapInfo, TOPLEFT, 0, 60, --[[#2]] true, BOTTOMRIGHT, ZO_WorldMapInfo, BOTTOMRIGHT, 0, 0)
	PP.Anchor(ZO_WorldMapKey, --[[#1]] TOPLEFT, ZO_WorldMapInfo, TOPLEFT, -20, 60, --[[#2]] true, BOTTOMRIGHT, ZO_WorldMapInfo, BOTTOMRIGHT, 0, 0)
	PP.Anchor(ZO_WorldMapFilters, --[[#1]] TOPLEFT, ZO_WorldMapInfo, TOPLEFT, -20, 60, --[[#2]] true, BOTTOMRIGHT, ZO_WorldMapInfo, BOTTOMRIGHT, 0, 0)
	PP.Anchor(ZO_WorldMapLocations, --[[#1]] TOPLEFT, ZO_WorldMapInfo, TOPLEFT, -20, 60, --[[#2]] true, BOTTOMRIGHT, ZO_WorldMapInfo, BOTTOMRIGHT, 0, 0)
	ZO_ScrollList_Commit(ZO_WorldMapLocationsList)
	PP.Anchor(ZO_WorldMapHouses, --[[#1]] TOPLEFT, ZO_WorldMapInfo, TOPLEFT, -20, 60, --[[#2]] true, BOTTOMRIGHT, ZO_WorldMapInfo, BOTTOMRIGHT, 0, 0)
	ZO_ScrollList_Commit(ZO_WorldMapHousesList)

	PP.Anchor(ZO_WorldMapZoom, --[[#1]] BOTTOM, GuiRoot, BOTTOM, 0, -50)

--ZO_WorldMapZoneStoryTopLevel_Keyboard------------------------------------------------------------
	PP.ScrollBar(ZO_WorldMapZoneStoryTopLevel_KeyboardList,	--[[sb_c]] 180, 180, 180, 0.7, --[[bd_c]] 20, 20, 20, 0.7, true)
	ZO_Scroll_SetMaxFadeDistance(ZO_WorldMapZoneStoryTopLevel_KeyboardList, 10)

	PP.Anchor(ZO_WorldMapZoneStoryTopLevel_Keyboard,					--[[#1]] TOPLEFT, GuiRoot, TOPLEFT, 0, 200)
	PP.Anchor(ZO_WorldMapZoneStoryTopLevel_KeyboardList,				--[[#1]] TOPLEFT, ZO_WorldMapZoneStoryTopLevel_Keyboard, TOPLEFT, 8, 0,	--[[#2]] true, BOTTOMRIGHT, ZO_WorldMapZoneStoryTopLevel_Keyboard, BOTTOMRIGHT, 0, 0)
	PP.Anchor(ZO_WorldMapZoneStoryTopLevel_KeyboardZoneStoriesButton,	--[[#1]] TOP, ZO_WorldMapZoneStoryTopLevel_Keyboard, BOTTOM, 8, 10)
	PP.Anchor(ZO_WorldMapZoneStoryTopLevel_KeyboardTitle,				--[[#1]] BOTTOM, ZO_WorldMapZoneStoryTopLevel_Keyboard, TOP, 8, -2)
	PP.Font(ZO_WorldMapZoneStoryTopLevel_KeyboardTitle,					--[[Font]] PP.f.u67, 24, "outline", --[[Alpha]] 0.9, --[[Color]] nil, nil, nil, nil, --[[StyleColor]] 0, 0, 0, 0.8)
	ZO_WorldMapZoneStoryTopLevel_KeyboardTitleDivider:SetHidden(true)

	local dataType = ZO_ScrollList_GetDataTypeTable(ZO_WorldMapZoneStoryTopLevel_KeyboardList, 1) --SetupCompletionType(control, data)
	local existingSetupCallback = dataType.setupCallback
	dataType.setupCallback = function(control, data)
		existingSetupCallback(control, data)
		PP.Anchor(control.progressBar, --[[#1]] LEFT, control.icon, RIGHT, 0, 0,	--[[#2]] true, RIGHT, control, RIGHT, -6, 0)
		PP.Bar(control.progressBar, --[[height]] 14, --[[fontSize]] 14)
	end

	ZO_PostHook(ZO_WorldMapZoneStory_Keyboard, "RefreshInfo", function(self)
		local listData = ZO_ScrollList_GetDataList(self.list)
		if self:IsShowing() then
			self.control:SetDimensions(300, #listData*40)
		else
			self.control:SetDimensions(300, 500)
		end
		ZO_ScrollList_Commit(self.list)
	end)
--LargeMap----------------------------------------------------------------------------------------- WORLD_MAP_MANAGER
	if SV.large then

		local modes = {
			[MAP_MODE_LARGE_CUSTOM]		= true,
			[MAP_MODE_KEEP_TRAVEL]		= true,
			[MAP_MODE_FAST_TRAVEL]		= true,
			[MAP_MODE_AVA_RESPAWN]		= true,
			[MAP_MODE_AVA_KEEP_RECALL]	= true,
		}

		PP.Anchor(ZO_WorldMapZoom, --[[#1]] TOPLEFT, GuiRoot, TOPLEFT, 60, 100)

		local zoom = ZO_WorldMap_GetPanAndZoom()

		local function MapSize()
			if WORLD_MAP_SCENE:IsShowing() and modes[ZO_WorldMap_GetMode()] then
				PP.Anchor(ZO_WorldMap, --[[#1]] TOP, nil, TOP, 70, 80, --[[#2]] true, BOTTOM, nil, BOTTOM, 70, -70)
				local x = ZO_WorldMap:GetHeight()
				local currentZoom = zoom:GetCurrentNormalizedZoom()
				ZO_WorldMap:SetDimensions(x, x)
				ZO_WorldMapScroll:SetDimensions(x, x)
				zoom:SetCurrentNormalizedZoomInternal(currentZoom + 0.001)
				zoom:SetCurrentNormalizedZoomInternal(currentZoom)
			end
		end

		WORLD_MAP_SCENE:RegisterCallback("StateChange", function(oldState, newState)
			if newState == SCENE_SHOWING then
				MapSize()
			end
		end)

		ZO_WorldMap:RegisterForEvent(EVENT_SCREEN_RESIZED, function()
			MapSize()
		end)

		--▼--▼--▼--
		local orig_ZO_WorldMap_UpdateMap = ZO_WorldMap_UpdateMap
		function ZO_WorldMap_UpdateMap()
			orig_ZO_WorldMap_UpdateMap()
			MapSize()
		end

		local orig_ZO_WorldMap_RefreshMapFrameAnchor = ZO_WorldMap_RefreshMapFrameAnchor
		function ZO_WorldMap_RefreshMapFrameAnchor(...)
			if WORLD_MAP_SCENE:IsShowing() and modes[ZO_WorldMap_GetMode()] then
				return
			end
			return orig_ZO_WorldMap_RefreshMapFrameAnchor(...)
		end
		--▲--▲--▲--
	end
end