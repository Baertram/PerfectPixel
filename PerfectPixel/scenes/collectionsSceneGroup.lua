PP.collectionsSceneGroup = function()

--collectionsBook--ZO_CollectionsBook_TopLevel-----------------------------------------------------
	local collectionsBookScene = SCENE_MANAGER:GetScene('collectionsBook')

	--	collectionsBookScene:RemoveFragmentGroup(FRAGMENT_GROUP.FRAME_TARGET_STANDARD_RIGHT_PANEL)
	--	collectionsBookScene:RemoveFragment(RIGHT_BG_ITEM_PREVIEW_OPTIONS_FRAGMENT)
	collectionsBookScene:RemoveFragment(FRAME_TARGET_BLUR_STANDARD_RIGHT_PANEL_FRAGMENT)
	collectionsBookScene:RemoveFragment(RIGHT_BG_FRAGMENT)
	collectionsBookScene:RemoveFragment(FRAME_EMOTE_FRAGMENT_JOURNAL)
	collectionsBookScene:RemoveFragment(TREE_UNDERLAY_FRAGMENT)
	collectionsBookScene:RemoveFragment(TITLE_FRAGMENT)
	collectionsBookScene:RemoveFragment(COLLECTIONS_TITLE_FRAGMENT)
	collectionsBookScene:RemoveFragment(KEYBIND_STRIP_MUNGE_BACKDROP_FRAGMENT)

	collectionsBookScene:RegisterCallback("StateChange", function(oldState, newState)
		if newState == SCENE_SHOWING then
			PP.Anchor(ZO_MainMenuSceneGroupBar, --[[#1]] TOPRIGHT, GuiRoot, TOPRIGHT, -30, 64)
		elseif newState == SCENE_HIDDEN then
			PP.Anchor(ZO_MainMenuSceneGroupBar, --[[#1]] RIGHT, GuiRoot, RIGHT, -40, -340)
		end
	end)

	PP.mainBackdrop(ZO_CollectionsBook_TopLevel,		'collectionsBook', --[[backdrop]] TOPLEFT, BOTTOMRIGHT, -10, -10, 0, 10,	--[[tex]] PP.t.bg1, 8, 1, --[[bd]] 10, 10, 10, .8, --[[edge]] 0, 0, 0, 1, --[[texture]] true, .7)
	PP.mainBackdrop(ZO_KeybindStripControl,	'collectionsBook', --[[backdrop]] TOPLEFT, BOTTOMRIGHT, -6, 0, 2, 6,		--[[tex]] PP.t.bg1, 8, 1, --[[bd]] 10, 10, 10, .6, --[[edge]] 0, 0, 0, 1, --[[texture]] false, 0)

	PP.Anchor(ZO_CollectionsBook_TopLevel, --[[#1]] TOPRIGHT, GuiRoot, TOPRIGHT, 0, 120, --[[#2]] true, BOTTOMRIGHT, GuiRoot, BOTTOMRIGHT,	1, -70)
	PP.Anchor(ZO_CollectionsBook_TopLevelCategories, --[[#1]] TOPLEFT, ZO_CollectionsBook_TopLevel, TOPLEFT,	0, 77, --[[#2]] true, BOTTOMLEFT, ZO_CollectionsBook_TopLevel, BOTTOMLEFT, 0, 0)
	
	PP.ListBackdrop(ZO_CollectionsBook_TopLevelListContainerList, -10, -3, 0, 3, --[[tex]] nil, 8, 0, --[[bd]] 5, 5, 5, .6, --[[edge]] 30, 30, 30, .6)
	PP.ScrollBar(ZO_CollectionsBook_TopLevelListContainerList, --[[sb_c]] 180, 180, 180, .8, --[[bd_c]] 20, 20, 20, .6, --[[edge]] 40, 40, 40, .9)
	
	ZO_CollectionsBook_TopLevelListContainerList.useFadeGradient = nil
	
	PP.Anchor(ZO_CollectionsBook_TopLevelList, --[[#1]] TOPLEFT, ZO_CollectionsBook_TopLevelCategories, TOPRIGHT, 0, -10, --[[#2]] true, BOTTOMRIGHT, ZO_CollectionsBook_TopLevel, BOTTOMRIGHT,	1, 0)
	
--dlcBook--ZO_DLCBook_Keyboard---------------------------------------------------------------------
	local dlcBookScene = SCENE_MANAGER:GetScene('dlcBook')

	--	dlcBookScene:RemoveFragmentGroup(FRAGMENT_GROUP.FRAME_TARGET_STANDARD_RIGHT_PANEL)
	dlcBookScene:RemoveFragment(FRAME_TARGET_BLUR_STANDARD_RIGHT_PANEL_FRAGMENT)
	dlcBookScene:RemoveFragment(RIGHT_BG_FRAGMENT)
	dlcBookScene:RemoveFragment(FRAME_EMOTE_FRAGMENT_JOURNAL)
	dlcBookScene:RemoveFragment(TREE_UNDERLAY_FRAGMENT)
	dlcBookScene:RemoveFragment(TITLE_FRAGMENT)
	dlcBookScene:RemoveFragment(COLLECTIONS_TITLE_FRAGMENT)
	dlcBookScene:RemoveFragment(KEYBIND_STRIP_MUNGE_BACKDROP_FRAGMENT)

	dlcBookScene:RegisterCallback("StateChange", function(oldState, newState)
		if newState == SCENE_SHOWING then
			PP.Anchor(ZO_MainMenuSceneGroupBar, --[[#1]] TOPRIGHT, GuiRoot, TOPRIGHT, -30, 64)
		elseif newState == SCENE_HIDDEN then
			PP.Anchor(ZO_MainMenuSceneGroupBar, --[[#1]] RIGHT, GuiRoot, RIGHT, -40, -340)
		end
	end)

	PP.mainBackdrop(ZO_DLCBook_Keyboard,	'dlcBook', --[[backdrop]] TOPLEFT, BOTTOMRIGHT, -10, -10, 0, 10,	--[[tex]] PP.t.bg1, 8, 1, --[[bd]] 10, 10, 10, .8, --[[edge]] 0, 0, 0, 1, --[[texture]] true, .7)
	PP.mainBackdrop(ZO_KeybindStripControl,	'dlcBook', --[[backdrop]] TOPLEFT, BOTTOMRIGHT, -6, 0, 2, 6,		--[[tex]] PP.t.bg1, 8, 1, --[[bd]] 10, 10, 10, .6, --[[edge]] 0, 0, 0, 1, --[[texture]] false, 0)

	PP.Anchor(ZO_DLCBook_Keyboard, --[[#1]] TOPRIGHT, GuiRoot, TOPRIGHT,	0, 120, --[[#2]] true, BOTTOMRIGHT, GuiRoot, BOTTOMRIGHT, 1, -70)

--housingBook--ZO_HousingBook_Keyboard-------------------------------------------------------------
	local housingBookScene = SCENE_MANAGER:GetScene('housingBook')

	--	housingBookScene:RemoveFragmentGroup(FRAGMENT_GROUP.FRAME_TARGET_STANDARD_RIGHT_PANEL)
	housingBookScene:RemoveFragment(FRAME_TARGET_BLUR_STANDARD_RIGHT_PANEL_FRAGMENT)
	housingBookScene:RemoveFragment(RIGHT_BG_FRAGMENT)
	housingBookScene:RemoveFragment(FRAME_EMOTE_FRAGMENT_JOURNAL)
	housingBookScene:RemoveFragment(TREE_UNDERLAY_FRAGMENT)
	housingBookScene:RemoveFragment(TITLE_FRAGMENT)
	housingBookScene:RemoveFragment(COLLECTIONS_TITLE_FRAGMENT)
	housingBookScene:RemoveFragment(KEYBIND_STRIP_MUNGE_BACKDROP_FRAGMENT)

	housingBookScene:RegisterCallback("StateChange", function(oldState, newState)
		if newState == SCENE_SHOWING then
			PP.Anchor(ZO_MainMenuSceneGroupBar, --[[#1]] TOPRIGHT, GuiRoot, TOPRIGHT, -30, 64)
		elseif newState == SCENE_HIDDEN then
			PP.Anchor(ZO_MainMenuSceneGroupBar, --[[#1]] RIGHT, GuiRoot, RIGHT, -40, -340)
		end
	end)

	PP.mainBackdrop(ZO_HousingBook_Keyboard,	'housingBook', --[[backdrop]] TOPLEFT, BOTTOMRIGHT, -10, -10, 0, 10,	--[[tex]] PP.t.bg1, 8, 1, --[[bd]] 10, 10, 10, .8, --[[edge]] 0, 0, 0, 1, --[[texture]] true, .7)
	PP.mainBackdrop(ZO_KeybindStripControl,		'housingBook', --[[backdrop]] TOPLEFT, BOTTOMRIGHT, -6, 0, 2, 6,		--[[tex]] PP.t.bg1, 8, 1, --[[bd]] 10, 10, 10, .6, --[[edge]] 0, 0, 0, 1, --[[texture]] false, 0)

	PP.Anchor(ZO_HousingBook_Keyboard, --[[#1]] TOPRIGHT,	GuiRoot, TOPRIGHT,	0, 120,	--[[#2]] true, BOTTOMRIGHT,	GuiRoot, BOTTOMRIGHT,	1, -70)

--outfitStylesBook--ZO_OutfitStylesBook_Keyboard_TopLevel------------------------------------------
	local outfitStylesBookScene = SCENE_MANAGER:GetScene('outfitStylesBook')

	--	outfitStylesBookScene:RemoveFragmentGroup(FRAGMENT_GROUP.FRAME_TARGET_STANDARD_RIGHT_PANEL_MEDIUM_LEFT_PANEL)
	outfitStylesBookScene:RemoveFragment(FRAME_TARGET_BLUR_STANDARD_RIGHT_PANEL_MEDIUM_LEFT_PANEL_FRAGMENT)
	outfitStylesBookScene:RemoveFragment(MEDIUM_LEFT_PANEL_BG_FRAGMENT)
	outfitStylesBookScene:RemoveFragment(RIGHT_BG_FRAGMENT)
	outfitStylesBookScene:RemoveFragment(FRAME_EMOTE_FRAGMENT_JOURNAL)
	outfitStylesBookScene:RemoveFragment(TREE_UNDERLAY_FRAGMENT)
	outfitStylesBookScene:RemoveFragment(TITLE_FRAGMENT)
	outfitStylesBookScene:RemoveFragment(COLLECTIONS_TITLE_FRAGMENT)
	outfitStylesBookScene:RemoveFragment(KEYBIND_STRIP_MUNGE_BACKDROP_FRAGMENT)

	outfitStylesBookScene:RegisterCallback("StateChange", function(oldState, newState)
		if newState == SCENE_SHOWING then
			PP.Anchor(ZO_MainMenuSceneGroupBar, --[[#1]] TOPRIGHT, GuiRoot, TOPRIGHT, -30, 64)
		elseif newState == SCENE_HIDDEN then
			PP.Anchor(ZO_MainMenuSceneGroupBar, --[[#1]] RIGHT, GuiRoot, RIGHT, -40, -340)
		end
	end)

	PP.mainBackdrop(ZO_OutfitStylesBook_Keyboard_TopLevel,	'outfitStylesBook', --[[backdrop]] TOPLEFT, BOTTOMRIGHT, -10, -10, 0, 10,	--[[tex]] PP.t.bg1, 8, 1, --[[bd]] 10, 10, 10, .8, --[[edge]] 0, 0, 0, 1, --[[texture]] true, .7)
	PP.mainBackdrop(ZO_RestyleSheetWindowTopLevel_Keyboard,	'outfitStylesBook', --[[backdrop]] TOPLEFT, BOTTOMRIGHT, -20, -30, 10, -32,	--[[tex]] PP.t.bg1, 8, 1, --[[bd]] 10, 10, 10, .8, --[[edge]] 0, 0, 0, 1, --[[texture]] true, .7)
	PP.mainBackdrop(ZO_KeybindStripControl,					'outfitStylesBook', --[[backdrop]] TOPLEFT, BOTTOMRIGHT, -6, 0, 2, 6,		--[[tex]] PP.t.bg1, 8, 1, --[[bd]] 10, 10, 10, .6, --[[edge]] 0, 0, 0, 1, --[[texture]] false, 0)

	PP.Anchor(ZO_OutfitStylesBook_Keyboard_TopLevel, --[[#1]] TOPRIGHT,	GuiRoot, TOPRIGHT,	0, 120,		--[[#2]] true, BOTTOMRIGHT,	GuiRoot, BOTTOMRIGHT,	1, -70)
	PP.Anchor(ZO_OutfitStylesPanelTopLevel_Keyboard, --[[#1]] TOPRIGHT,	GuiRoot, TOPRIGHT,	-2, 122,	--[[#2]] true, BOTTOMRIGHT,	GuiRoot, BOTTOMRIGHT,	1, -70)
	PP.Anchor(ZO_OutfitStylesBook_Keyboard_TopLevelCategories, --[[#1]] TOPLEFT, ZO_OutfitStylesBook_Keyboard_TopLevel, TOPLEFT,	0, 77, --[[#2]] true, BOTTOMLEFT, ZO_OutfitStylesBook_Keyboard_TopLevel, BOTTOMLEFT, 0, 0)

	PP.Anchor(ZO_RestyleSheetWindowTopLevel_KeyboardTitleDividerTexture,					--[[#1]] TOPLEFT, nil, TOPLEFT,	-140, 0, --[[#2]] true, BOTTOMRIGHT, nil, BOTTOMRIGHT, 90, 0)

	PP.Anchor(ZO_RestyleSheetWindowTopLevel_KeyboardEquipmentSheetSecondaryWeaponSwap, --[[#1]] LEFT, ZO_RestyleSheetWindowTopLevel_KeyboardEquipmentSheetSecondary, RIGHT,	10, 20)
	PP.Anchor(ZO_RestyleSheetWindowTopLevel_KeyboardEquipmentSheetPrimaryDividerTexture,	--[[#1]] TOPLEFT, nil, TOPLEFT,	-140, 0, --[[#2]] true, BOTTOMRIGHT, nil, BOTTOMRIGHT, 90, 0)
	ZO_RestyleSheetWindowTopLevel_KeyboardEquipmentSheetSecondaryDivider:SetHidden(true)

	PP.Anchor(ZO_RestyleSheetWindowTopLevel_KeyboardOutfitStylesSheetSecondaryWeaponSwap, --[[#1]] LEFT, ZO_RestyleSheetWindowTopLevel_KeyboardOutfitStylesSheetSecondary, RIGHT,	10, 20)
	PP.Anchor(ZO_RestyleSheetWindowTopLevel_KeyboardOutfitStylesSheetPrimaryDividerTexture, --[[#1]] TOPLEFT, nil, TOPLEFT,	-140, 0, --[[#2]] true, BOTTOMRIGHT, nil, BOTTOMRIGHT, 90, 0)
	ZO_RestyleSheetWindowTopLevel_KeyboardOutfitStylesSheetSecondaryDivider:SetHidden(true)

	PP.Anchor(ZO_RestyleSheetWindowTopLevel_KeyboardCollectibleSheetPrimaryDividerTexture, --[[#1]] TOPLEFT, nil, TOPLEFT,	-140, 0, --[[#2]] true, BOTTOMRIGHT, nil, BOTTOMRIGHT, 90, 0)
	ZO_RestyleSheetWindowTopLevel_KeyboardCollectibleSheetSecondaryDivider:SetHidden(true)

--	ZO_OutfitStylesPanelTopLevel_Keyboard

	PP.ListBackdrop(ZO_OutfitStylesPanelTopLevel_KeyboardPaneContainerList, -10, -3, 0, 3, --[[tex]] nil, 8, 0, --[[bd]] 5, 5, 5, .6, --[[edge]] 30, 30, 30, .6)
	PP.ScrollBar(ZO_OutfitStylesPanelTopLevel_KeyboardPaneContainerList, --[[sb_c]] 180, 180, 180, .7, --[[bd_c]] 20, 20, 20, .7, --[[edge]] 40, 40, 40, .9)
	ZO_OutfitStylesPanelTopLevel_KeyboardPaneContainerList.useFadeGradient = nil
end



