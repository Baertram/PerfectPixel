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
	{
		type				= "header",
		name				= GetString(PP_LAM_SCENE_WORLDMAP),
	})
	table.insert(PP.optionsData,
	{
		type				= "checkbox",
		name				= GetString(PP_LAM_ACTIVATE),
		getFunc				= function() return SV.toggle end,
		setFunc				= function(value) SV.toggle = value end,
		default				= DEF.toggle,
		requiresReload		= true,
	})
	table.insert(PP.optionsData,
	{
		type				= "checkbox",
		name				= GetString(PP_LAM_SCENE_WORLDMAP_LARGE),
		getFunc				= function() return SV.large end,
		setFunc				= function(value) SV.large = value end,
		default				= DEF.large,
		disabled			= function() return not SV.toggle end,
		requiresReload		= true,
	})
--===============================================================================================--
	if not SV.toggle then return end

	local worldMapScene = SCENE_MANAGER:GetScene('worldMap')

	worldMapScene:RemoveFragment(FRAME_EMOTE_FRAGMENT_MAP)
	worldMapScene:RemoveFragment(WORLD_MAP_INFO_BG_FRAGMENT)
	worldMapScene:RemoveFragment(UNIFORM_BLUR_FRAGMENT)
	worldMapScene:RemoveFragment(KEYBIND_STRIP_MUNGE_BACKDROP_FRAGMENT)

	worldMapScene:AddFragment(PLAYER_PROGRESS_BAR_FRAGMENT)
	
	worldMapScene:RegisterCallback("StateChange", function(oldState, newState)
		if newState == SCENE_SHOWING or newState == SCENE_SHOWN then
			WORLD_MAP_FRAGMENT.duration = 1
			ZO_WorldMapMapFrame:SetHidden(true)
			ZO_PlayerProgress:SetHidden(true)
		elseif newState == SCENE_HIDDEN then
			ZO_PlayerProgress:SetHidden(false)
			-- ZO_WorldMapMapFrame:SetHidden(false)
			-- ZO_WorldMapContainerRaggedEdge:SetHidden(false)
		end
	end)

	ZO_WorldMapContainerRaggedEdge:SetHidden(true)
	-- ZO_WorldMap:SetDrawLayer(1)

	ZO_WorldMapZoomKeybindKeyLabel:SetFont("PerfectPixel/fonts/univers57.otf|16")
	ZO_WorldMapZoomKeybindNameLabel:SetFont("PerfectPixel/fonts/univers67.otf|18|outline")
	ZO_WorldMapZoomDivider:SetHidden(true)

	ZO_WorldMapInfoMenuBarLabel:SetHidden(true)
	ZO_WorldMapInfoMenuBarDivider:SetHidden(true)

	PP.mainBackdrop(ZO_WorldMapInfo, 'worldMap', --[[backdrop]] TOPLEFT, BOTTOMRIGHT, -16, 51, 0, 9, --[[tex]] PP.t.bg1, 8, 1, --[[bd]] 10, 10, 10, .8, --[[edge]] 0, 0, 0, 1, --[[texture]] false, .5)
	PP.mainBackdrop(ZO_WorldMap, 'worldMap', --[[backdrop]] TOPLEFT, BOTTOMRIGHT, -3, -3, 3, 3, --[[tex]] PP.t.bg1, 8, 1, --[[bd]] 10, 10, 10, .6, --[[edge]] 0, 0, 0, 1, --[[texture]] false, 0)
	PP.mainBackdrop(ZO_KeybindStripControl, 'worldMap', --[[backdrop]] TOPLEFT, BOTTOMRIGHT, -6, 0, 2, 6, --[[tex]] PP.t.bg1, 8, 1, --[[bd]] 10, 10, 10, .6, --[[edge]] 0, 0, 0, 1, --[[texture]] false, 0)
	
	PP.Anchor(ZO_WorldMapInfo, --[[#1]] TOPRIGHT, nil, TOPRIGHT, 0, 60, --[[#2]] true, BOTTOMRIGHT, nil, BOTTOMRIGHT, 1, -69)
	
	local tab = {ZO_WorldMapQuestsPane, ZO_WorldMapKeyPane, ZO_WorldMapLocationsList, ZO_WorldMapHousesList, ZO_WorldMapFiltersPvEContainer}
	for _, v in ipairs(tab) do
		PP.ScrollBar(v,	--[[sb_c]] 180, 180, 180, .7, --[[bd_c]] 20, 20, 20, .7, --[[edge]] 40, 40, 40, .9)
		ZO_Scroll_SetMaxFadeDistance(v, 10)
	end

	PP.Anchor(ZO_WorldMapQuests, --[[#1]] TOPLEFT, ZO_WorldMapInfo, TOPLEFT, 0, 60, --[[#2]] true, BOTTOMRIGHT, ZO_WorldMapInfo, BOTTOMRIGHT, 1, 0)
	-- ZO_WorldMapQuestsPane.useFadeGradient = nil

	PP.Anchor(ZO_WorldMapKey, --[[#1]] TOPLEFT, ZO_WorldMapInfo, TOPLEFT, -20, 60, --[[#2]] true, BOTTOMRIGHT, ZO_WorldMapInfo, BOTTOMRIGHT, 1, 0)
	-- ZO_WorldMapKeyPane.useFadeGradient = nil

	PP.Anchor(ZO_WorldMapFilters, --[[#1]] TOPLEFT, ZO_WorldMapInfo, TOPLEFT, -20, 60, --[[#2]] true, BOTTOMRIGHT, ZO_WorldMapInfo, BOTTOMRIGHT, 1, 0)

--	PP.ListBackdrop(ZO_WorldMapLocationsList, -10, -3, -13, 3, --[[tex]] nil, 8, 0, --[[bd]] 10, 10, 10, .7, --[[edge]] 50, 50, 50, 1)
	PP.Anchor(ZO_WorldMapLocations, --[[#1]] TOPLEFT, ZO_WorldMapInfo, TOPLEFT, -20, 60, --[[#2]] true, BOTTOMRIGHT, ZO_WorldMapInfo, BOTTOMRIGHT, 1, 0)
	-- ZO_WorldMapLocationsList.useFadeGradient = nil
	ZO_ScrollList_Commit(ZO_WorldMapLocationsList)
	
--	PP.ListBackdrop(ZO_WorldMapHousesList, -10, -3, -13, 3, --[[tex]] nil, 8, 0, --[[bd]] 10, 10, 10, .7, --[[edge]] 50, 50, 50, 1)
	PP.Anchor(ZO_WorldMapHouses, --[[#1]] TOPLEFT, ZO_WorldMapInfo, TOPLEFT, -20, 60, --[[#2]] true, BOTTOMRIGHT, ZO_WorldMapInfo, BOTTOMRIGHT, 1, 0)
	-- ZO_WorldMapHousesList.useFadeGradient = nil
	ZO_ScrollList_Commit(ZO_WorldMapHousesList)

	PP.Anchor(ZO_WorldMapZoom, --[[#1]] BOTTOM, GuiRoot, BOTTOM, 0, -50)
--LargeMap-----------------------------------------------------------------------------------------
	if SV.large then
		local zoom = ZO_WorldMap_GetPanAndZoom()
		local function MapSize()
			PP.Anchor(ZO_WorldMap, --[[#1]] TOP, nil, TOP, 70, 80, --[[#2]] true, BOTTOM, nil, BOTTOM, 70, -70)
			ZO_WorldMap:SetWidth(ZO_WorldMap:GetHeight())
		end
		local function MapZoom()
			zoom:SetCurrentNormalizedZoomInternal(zoom:GetCurrentNormalizedZoom() + 0.001)
			zoom:SetCurrentNormalizedZoomInternal(zoom:GetCurrentNormalizedZoom() - 0.001)
		end
		PP.Anchor(ZO_WorldMapZoom, --[[#1]] TOPLEFT, GuiRoot, TOPLEFT, 60, 100)

		ZO_PreHook(zoom, "SetCurrentNormalizedZoomInternal", function(normalizedZoom)
			if ( ZO_WorldMap_IsWorldMapShowing() ) and ( ZO_WorldMap_GetMode() >= 2 and ZO_WorldMap_GetMode() <=6 ) and ( ZO_WorldMap:GetAnchor(TOP) == false ) then
				MapSize()
			end
		end)
		ZO_PreHook(zoom, "OnWorldMapChanged", function(wasNavigateIn)
			if ( ZO_WorldMap_IsWorldMapShowing() ) and ( ZO_WorldMap_GetMode() >= 2 and ZO_WorldMap_GetMode() <=6 ) then
				MapZoom()
			end
		end)
		worldMapScene:RegisterCallback("StateChange", function(oldState, newState)
			if newState == SCENE_SHOWING and ( ZO_WorldMap_GetMode() >= 2 and ZO_WorldMap_GetMode() <=6 ) then
				MapZoom()
			end
		end)
	end
end