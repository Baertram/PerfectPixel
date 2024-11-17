PP.collectionsSceneGroup = function()
	--orig
	function ZO_RestyleCommon_Keyboard.UpdateAnchors(control, hasSubTabs)

		local offset = control == ZO_DyeingTopLevel_Keyboard and 160 or 180

		control:ClearAnchors()
		if hasSubTabs then
			PP.Anchor(control, --[[#1]] TOPRIGHT, GuiRoot, TOPRIGHT, -2, offset, --[[#2]] true, BOTTOMRIGHT, GuiRoot, BOTTOMRIGHT, -8, -70)
		else
			PP.Anchor(control, --[[#1]] TOPRIGHT, GuiRoot, TOPRIGHT, -2, 122, --[[#2]] true, BOTTOMRIGHT, GuiRoot, BOTTOMRIGHT,	-8, -70)
		end
	end

	--Update summary progressBars at e.g. set collections book
	local function updateContentScrollChildProgressBars(scrollChildCtrl, useScrollChildCtrl, height, fontSize)
		if scrollChildCtrl then
			PP.Bars(scrollChildCtrl, useScrollChildCtrl, --[[h]] height, --[[f]] fontSize)
		end
	end

	local fragments	= {RIGHT_BG_FRAGMENT, TREE_UNDERLAY_FRAGMENT, TITLE_FRAGMENT, COLLECTIONS_TITLE_FRAGMENT, MEDIUM_LEFT_PANEL_BG_FRAGMENT}
	local scenes	= {
		{COLLECTIONS_BOOK_SCENE,		COLLECTIONS_BOOK,					},
		{DLC_BOOK_SCENE,				DLC_BOOK_KEYBOARD,					},
		{HOUSING_BOOK_SCENE,			HOUSING_BOOK_KEYBOARD,				},
		{ZO_OUTFIT_STYLES_BOOK_SCENE,	ZO_OUTFIT_STYLES_BOOK_KEYBOARD,		},
		{nil,							ZO_OUTFIT_STYLES_PANEL_KEYBOARD,	},
		--[[?]]		{ITEM_SETS_BOOK_SCENE,			ITEM_SET_COLLECTIONS_BOOK_KEYBOARD--[[,	itemSetCollectionsProgressBars]]}, --ZO_ItemSetsBook_Keyboard_TopLevelFiltersApparelFilterTypes
		{TRIBUTE_PATRON_BOOK_SCENE,		TRIBUTE_PATRON_BOOK_KEYBOARD		},
	}

	--[[?]]	local scenesShown = {}
	for i=1, #scenes do
		local scene			= scenes[i][1]
		local gVar			= scenes[i][2]
		--[[?]] local sceneShowCallback = scenes[i][3]
		local tlw			= gVar.control
		local list			= gVar.gridListPanelList	and gVar.gridListPanelList.list
		local search		= gVar.contentSearchEditBox	and gVar.contentSearchEditBox:GetParent()
		local categories	= gVar.categories
		local progressBar	= gVar.progressBar or gVar.categoryProgress
		local summaryContentScrollChild = gVar.summaryScrollChild

		if scene then
			for j=1, #fragments do
				local fragment = fragments[j]
				if scene:HasFragment(fragment) then
					scene:RemoveFragment(fragment)
				end
			end

			PP:CreateBackground(tlw, --[[#1]] nil, nil, nil, -10, -10, --[[#2]] nil, nil, nil, 0, 10)
			PP.Anchor(tlw, --[[#1]] TOPRIGHT, GuiRoot, TOPRIGHT, 0, 120, --[[#2]] true, BOTTOMRIGHT, GuiRoot, BOTTOMRIGHT, 0, -70)
			--[[?]]			if sceneShowCallback then
			--[[?]]				scene:RegisterCallback("StateChange", function(oldState, newState)
				--[[?]]					if newState == SCENE_SHOWN and not scenesShown[scene] then
					--[[?]]						sceneShowCallback()
					--[[?]]						scenesShown[scene] = true
					--[[?]]					end
				--[[?]]				end)
			--[[?]]			end
		end

		if categories then
			PP.Anchor(categories, --[[#1]] TOPLEFT, tlw, TOPLEFT, 0, 50, --[[#2]] true, BOTTOMLEFT, tlw, BOTTOMLEFT, 0, 0)
			PP.ScrollBar(categories, --[[sb_c]] 180, 180, 180, 0.8, --[[bd_c]] 20, 20, 20, 0.6, false)
			ZO_Scroll_SetMaxFadeDistance(categories, 10)
		end
		if search then
			search:GetNamedChild("Label"):SetHidden(true)
			PP.Anchor(search, --[[#1]] TOPLEFT, tlw, TOPLEFT, 10, 10)
		end
		if list then
			ZO_Scroll_SetMaxFadeDistance(list, 10)
			PP.ScrollBar(list, --[[sb_c]] 180, 180, 180, 0.8, --[[bd_c]] 20, 20, 20, 0.6, false)
		end
		if progressBar then
			PP.Bar(progressBar, --[[h]] 14, --[[f]] 15)
		end
		--At set collecitons book: This will only have 1 line as PP inits, so we need to call it again on each SetCollectionsOpen
		updateContentScrollChildProgressBars(summaryContentScrollChild, true, 14, 15)
	end

	--COLLECTIONS_BOOK_SCENE, COLLECTIONS_BOOK

	local function EmptyCellHidden(control, data)
		if data.isEmptyCell then
			control:SetHidden(true)
		end
	end

	--PTS API101043 2024-08-07
	PP.onDeferredInitCheck(COLLECTIONS_BOOK, function()
		PP.Anchor(ZO_CollectionsBook_TopLevelList, --[[#1]] TOPLEFT, ZO_CollectionsBook_TopLevelCategories, TOPRIGHT, 0, 16, --[[#2]] true, BOTTOMRIGHT, ZO_CollectionsBook_TopLevel, BOTTOMRIGHT,	0, 0)
		PP.ScrollBar(COLLECTIONS_BOOK.gridListPanelList.list, --[[sb_c]] 180, 180, 180, 0.8, --[[bd_c]] 20, 20, 20, 0.6, false)
		PP.ScrollBar(COLLECTIONS_BOOK.categoryTree.scrollControl, --[[sb_c]] 180, 180, 180, 0.8, --[[bd_c]] 20, 20, 20, 0.6, false)


		local dataType00 = ZO_ScrollList_GetDataTypeTable(ZO_CollectionsBook_TopLevelListContainerList, 1)
		local existingSetupCallback00 = dataType00.setupCallback
		dataType00["controlHeight"] = 120
		dataType00["controlWidth"] = 180
		dataType00["spacingX"] = 6
		dataType00["spacingY"] = 6
		dataType00.setupCallback = function(control, data)
			existingSetupCallback00(control, data)
			EmptyCellHidden(control, data)

			control:SetDimensions(dataType00["controlWidth"], dataType00["controlHeight"])
			if control:GetNamedChild("OverlayBorder") then
				local backdrop = control:GetNamedChild("OverlayBorder")
				backdrop:SetCenterColor(10/255, 10/255, 10/255, 0.7)
				backdrop:SetCenterTexture(nil, 4, 0)
				backdrop:SetEdgeColor(40/255, 40/255, 40/255, 0.9)
				backdrop:SetEdgeTexture(nil, 1, 1, 1, 0)
				backdrop:SetInsets(1, 1, -1, -1)
				backdrop:SetDrawLayer(0)
				backdrop:SetDrawTier(0)
			end
			if control:GetNamedChild("Highlight") then
				local highlight = control:GetNamedChild("Highlight")
				highlight:SetTextureCoords(0.29, 0.575, 0.002, 0.3)
				PP.Anchor(highlight, --[[#1]] TOPLEFT, control, TOPLEFT, 1, 1, --[[#2]] true, BOTTOMRIGHT, control, BOTTOMRIGHT,	-1, -1)
			end
			if control:GetNamedChild("Title") then
				local title = control:GetNamedChild("Title")
				PP.Font(title, --[[Font]] PP.f.u67, 16, "outline", --[[Alpha]] nil, --[[Color]] nil, nil, nil, nil, --[[StyleColor]] 0, 0, 0, 0.5)
			end
		end
	end, nil)


	--[[?]]--HOUSING_BOOK_SCENE, HOUSING_BOOK_KEYBOARD
	--PTS API101043 2024-08-07
	PP.onDeferredInitCheck(HOUSING_BOOK_KEYBOARD, function()
		--[[?]]	PP.ScrollBar(HOUSING_BOOK_KEYBOARD.navigationList, --[[sb_c]] 180, 180, 180, 0.8, --[[bd_c]] 20, 20, 20, 0.6, false)	--ZO_HousingBook_KeyboardNavigationList
	end, nil)


	--ZO_OUTFIT_STYLES_BOOK_SCENE, ZO_OUTFIT_STYLES_BOOK_KEYBOARD, ZO_OUTFIT_STYLES_PANEL_KEYBOARD

	--PTS API101043 2024-08-07
	PP.onDeferredInitCheck(ZO_RESTYLE_SHEET_WINDOW_KEYBOARD, function()
		PP:CreateBackground(ZO_RestyleSheetWindowTopLevel_Keyboard, --[[#1]] nil, nil, nil, -20, -30, --[[#2]] nil, nil, nil, 10, -32)
		PP.Anchor(ZO_RestyleSheetWindowTopLevel_KeyboardTitleDividerTexture,					--[[#1]] TOPLEFT, nil, TOPLEFT,	-140, 0, --[[#2]] true, BOTTOMRIGHT, nil, BOTTOMRIGHT, 90, 0)

		PP.Anchor(ZO_RestyleSheetWindowTopLevel_KeyboardEquipmentSheetSecondaryWeaponSwap, --[[#1]] TOPRIGHT, ZO_RestyleSheetWindowTopLevel_KeyboardEquipmentSheetSecondary, BOTTOMRIGHT,	5, -5)
		PP.Anchor(ZO_RestyleSheetWindowTopLevel_KeyboardOutfitStylesSheetSecondaryWeaponSwap, --[[#1]] TOPRIGHT, ZO_RestyleSheetWindowTopLevel_KeyboardOutfitStylesSheetSecondary, BOTTOMRIGHT,	5, -5)

		PP.Anchor(ZO_RestyleSheetWindowTopLevel_KeyboardEquipmentSheetPrimaryDividerTexture,	--[[#1]] TOPLEFT, nil, TOPLEFT,	-140, 0, --[[#2]] true, BOTTOMRIGHT, nil, BOTTOMRIGHT, 90, 0)
		PP.Anchor(ZO_RestyleSheetWindowTopLevel_KeyboardOutfitStylesSheetPrimaryDividerTexture, --[[#1]] TOPLEFT, nil, TOPLEFT,	-140, 0, --[[#2]] true, BOTTOMRIGHT, nil, BOTTOMRIGHT, 90, 0)
		PP.Anchor(ZO_RestyleSheetWindowTopLevel_KeyboardCollectibleSheetPrimaryDividerTexture, --[[#1]] TOPLEFT, nil, TOPLEFT,	-140, 0, --[[#2]] true, BOTTOMRIGHT, nil, BOTTOMRIGHT, 90, 0)

		ZO_RestyleSheetWindowTopLevel_KeyboardEquipmentSheetSecondaryDivider:SetHidden(true)
		ZO_RestyleSheetWindowTopLevel_KeyboardCompanionEquipmentSheetSecondaryDivider:SetHidden(true)

		ZO_RestyleSheetWindowTopLevel_KeyboardOutfitStylesSheetSecondaryDivider:SetHidden(true)
		ZO_RestyleSheetWindowTopLevel_KeyboardCompanionOutfitStylesSheetSecondaryDivider:SetHidden(true)

		ZO_RestyleSheetWindowTopLevel_KeyboardCollectibleSheetSecondaryDivider:SetHidden(true)
		ZO_RestyleSheetWindowTopLevel_KeyboardCompanionCollectibleStylesSheetSecondaryDivider:SetHidden(true)
	end)

	--PTS API101043 2024-08-07
	PP.onDeferredInitCheck(ZO_OUTFIT_STYLES_PANEL_KEYBOARD, function()
		PP.Anchor(ZO_OutfitStylesPanelTopLevel_Keyboard, --[[#1]] TOPRIGHT,	GuiRoot, TOPRIGHT, -2, 122, --[[#2]] true, BOTTOMRIGHT,	GuiRoot, BOTTOMRIGHT,	-8, -70)
		PP.Anchor(ZO_OutfitStylesPanelTopLevel_KeyboardPaneContainer, --[[#1]] TOPLEFT, nil, TOPLEFT,	0, 0, --[[#2]] true, BOTTOMRIGHT, nil, BOTTOMRIGHT,	8, 0)

		local dataType01 = ZO_ScrollList_GetDataTypeTable(ZO_OutfitStylesPanelTopLevel_KeyboardPaneContainerList, 1)
		local existingSetupCallback01 = dataType01.setupCallback
		dataType01["controlHeight"] = 68
		dataType01["controlWidth"] = 68
		dataType01["spacingX"] = 6
		dataType01["spacingY"] = 6
		dataType01.setupCallback = function(control, data)
			existingSetupCallback01(control, data)
			EmptyCellHidden(control, data)

			control:SetDimensions(dataType01["controlWidth"], dataType01["controlHeight"])

			local backdrop = control:GetNamedChild("Backdrop")
			backdrop:SetCenterColor(10/255, 10/255, 10/255, 0.7)
			backdrop:SetCenterTexture(nil, 4, 0)
			backdrop:SetEdgeColor(40/255, 40/255, 40/255, 0.9)
			backdrop:SetEdgeTexture(nil, 1, 1, 1, 0)
			backdrop:SetInsets(1, 1, -1, -1)
			---------------------------------
		end
	end)


	--ITEM_SETS_BOOK_SCENE, ITEM_SET_COLLECTIONS_BOOK_KEYBOARD
	--==ZO_ItemSetsBook_Keyboard_TopLevel==--
	-- local item_set = ITEM_SET_COLLECTIONS_BOOK_KEYBOARD

	-- PP:CreateBackground(item_set.control,	--[[#1]] nil, nil, nil, -10, -10, --[[#2]] nil, nil, nil, 0, 10)


	local ISCB		= ITEM_SET_COLLECTIONS_BOOK_KEYBOARD
	local iscbTLC	= ISCB.control
	local iscbList	= ISCB.gridListPanelList.list

	PP.Anchor(ZO_ItemSetsBook_Keyboard_TopLevelFilters,		--[[#1]] TOPLEFT, iscbTLC, TOPLEFT,	0, 0, --[[#2]] true, TOPRIGHT, iscbTLC, TOPRIGHT, 0, 0)

	PP.Anchor(ZO_ItemSetsBook_Keyboard_TopLevelCategoryContentCategoryProgress, --[[#1]] TOPLEFT, ZO_ItemSetsBook_Keyboard_TopLevelCategoryContent, TOPLEFT, 0, 0, --[[#2]] true, TOPRIGHT, ZO_ItemSetsBook_Keyboard_TopLevelCategoryContent, TOPRIGHT, -8, 0)

	PP.Anchor(ZO_ItemSetsBook_Keyboard_TopLevelCategoryContent,		--[[#1]] TOPLEFT, ZO_ItemSetsBook_Keyboard_TopLevelCategories, TOPRIGHT,	10, 0, --[[#2]] true, BOTTOMRIGHT, ZO_ItemSetsBook_Keyboard_TopLevel, BOTTOMRIGHT, 0, 0)
	PP.Anchor(ZO_ItemSetsBook_Keyboard_TopLevelCategoryContentList,	--[[#1]] TOPLEFT, ZO_ItemSetsBook_Keyboard_TopLevelCategoryContentCategoryProgress, BOTTOMLEFT,	0, 10, --[[#2]] true, BOTTOMRIGHT, ZO_ItemSetsBook_Keyboard_TopLevelCategoryContent, BOTTOMRIGHT, 0, 0)

	--------------------------
	local dataType02 = ZO_ScrollList_GetDataTypeTable(iscbList, 1)
	local existingSetupCallback02 = dataType02.setupCallback
	dataType02["controlHeight"] = 68
	dataType02["controlWidth"] = 68
	dataType02["spacingX"] = 6
	dataType02["spacingY"] = 6
	dataType02.setupCallback = function(control, data)
		existingSetupCallback02(control, data)
		EmptyCellHidden(control, data)

		control:SetDimensions(dataType02["controlWidth"], dataType02["controlHeight"])

		local backdrop = control:GetNamedChild("OverlayBorder")
		backdrop:SetCenterColor(10/255, 10/255, 10/255, 0.7)
		backdrop:SetCenterTexture(nil, 4, 0)
		backdrop:SetEdgeColor(40/255, 40/255, 40/255, 0.9)
		backdrop:SetEdgeTexture(nil, 1, 1, 1, 0)
		backdrop:SetInsets(1, 1, -1, -1)
		backdrop:SetDrawLayer(0)
		backdrop:SetDrawLevel(0)
		backdrop:SetDrawTier(0)
	end
	local dataType_2 = ZO_ScrollList_GetDataTypeTable(iscbList, 2)
	local existingSetupCallback = dataType_2.setupCallback
	dataType_2.setupCallback = function(control, data)
		existingSetupCallback(control, data)
		local progressBar = control:GetNamedChild("Progress")
		PP.Bar(progressBar, --[[height]] 14, --[[fontSize]] 15)
	end

	--[[?]]--[[?]]--[[?]]--[[?]]--[[?]]
	--Tribute Patron card game - collections
	--ZO_TributePatronBook_Keyboard_TopLevelInfoContainerGridListContainerListContents
	local TPB		= TRIBUTE_PATRON_BOOK_KEYBOARD
	local tpbTLC	= TPB.control --ZO_TributePatronBook_Keyboard_TopLevel
	local tpbFilters = GetControl(tpbTLC, "Filters")
	local tpbSearchLabel = GetControl(tpbFilters, "SearchLabel")
	local tpbGridList = TPB.gridList
	local tpbList	= tpbGridList.list --ZO_TributePatronBook_Keyboard_TopLevelInfoContainerGridListContainerList
	local tpbListContents = GetControl(tpbList, "Contents")
	local tpbCategories = TPB.categories --ZO_TributePatronBook_Keyboard_TopLevelCategories

	tpbSearchLabel:SetHeight(0)
	tpbSearchLabel:ClearAnchors()
	tpbSearchLabel:SetHidden(true)
	PP.Anchor(tpbFilters,		--[[#1]] TOPLEFT, tpbTLC, TOPLEFT,	1, -23, 		--[[#2]] true, TOPRIGHT, tpbTLC, TOPRIGHT, 1, -23)

	PP.Anchor(tpbList,			--[[#1]] TOPLEFT, tpbCategories, TOPRIGHT, 0, 0, 	--[[#2]] true, BOTTOMRIGHT, tpbTLC, BOTTOMRIGHT, 0, 0)
	PP.Anchor(tpbListContents,	--[[#1]] TOPLEFT, tpbList, TOPLEFT,	0, 0, 			--[[#2]] true, BOTTOMRIGHT, tpbList, BOTTOMRIGHT, 0, 0)
	PP.ScrollBar(tpbList, 		--[[sb_c]] 180, 180, 180, 0.8, --[[bd_c]] 20, 20, 20, 0.6, false)
	ZO_Scroll_SetMaxFadeDistance(tpbList, 10)

	--------------------------
	for gridScrollListDataType, dataTypeData in ipairs(tpbList.dataTypes) do
		if dataTypeData.selectable ~= nil and dataTypeData.selectable == true then
			local dataType_loop = ZO_ScrollList_GetDataTypeTable(tpbList, gridScrollListDataType)
			local existingSetupCallback_loop = dataType_loop.setupCallback
			dataType_loop.setupCallback = function(control, data)
				existingSetupCallback_loop(control, data)

				local backdrop = control:GetNamedChild("OverlayBorder")
				if backdrop ~= nil then
					backdrop:SetCenterColor(10/255, 10/255, 10/255, 0.7)
					backdrop:SetCenterTexture(nil, 4, 0)
					backdrop:SetEdgeColor(40/255, 40/255, 40/255, 0.9)
					backdrop:SetEdgeTexture(nil, 1, 1, 1, 0)
					backdrop:SetInsets(1, 1, -1, -1)
					backdrop:SetDrawLayer(DL_BACKGROUND)
					backdrop:SetDrawLevel(0)
					backdrop:SetDrawTier(DT_LOW)
				end

				local highlight = control:GetNamedChild("Highlight")
				if highlight then
					highlight:SetTextureCoords(0.29, 0.575, 0.002, 0.3)
					PP.Anchor(highlight, --[[#1]] TOPLEFT, control, TOPLEFT, 1, 1, --[[#2]] true, BOTTOMRIGHT, control, BOTTOMRIGHT,	-1, -1)
				end
			end
		end
	end

	--------------------------
	--On each open of the set collecitons book: Update the summary progress bars as they might have added new
	local setCollectionsBookScene = scenes[6][1]
	local setCollectionsBookSceneGVar = scenes[6][2]
	setCollectionsBookScene:RegisterCallback("StateChange", function(oldState, newState)
		if newState == SCENE_SHOWN then
			updateContentScrollChildProgressBars(setCollectionsBookSceneGVar.summaryScrollChild, true, 14, 15)
		end
	end)
end