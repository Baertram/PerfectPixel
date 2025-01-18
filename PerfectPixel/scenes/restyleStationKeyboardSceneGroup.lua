local PP = PP ---@class PP

PP.restyleStationKeyboardSceneGroup = function()

	--restyle_station_keyboard--ZO_RESTYLE_SCENE--ZO_RestyleStationTopLevel_Keyboard-------------------
	local restyleStationScene = SCENE_MANAGER:GetScene('restyle_station_keyboard')

	restyleStationScene:RemoveFragment(RIGHT_BG_FRAGMENT)
	restyleStationScene:RemoveFragment(MEDIUM_LEFT_PANEL_BG_FRAGMENT)
	restyleStationScene:RemoveFragment(TREE_UNDERLAY_FRAGMENT)
	restyleStationScene:RemoveFragment(TITLE_FRAGMENT)
	restyleStationScene:RemoveFragment(RESTYLE_TITLE_FRAGMENT)
	restyleStationScene:AddFragment(FRAME_TARGET_BLUR_STANDARD_RIGHT_PANEL_MEDIUM_LEFT_PANEL_FRAGMENT)

	PP.onDeferredInitCheck(ZO_RESTYLE_STATION_KEYBOARD, function()
		PP:CreateBackground(ZO_RestyleStationTopLevel_Keyboard, --[[#1]] nil, nil, nil, -10, -10, --[[#2]] nil, nil, nil, 0, 10)
		PP:CreateBackground(ZO_RestyleSheetWindowTopLevel_Keyboard, --[[#1]] nil, nil, nil, -20, -30, --[[#2]] nil, nil, nil, 10, -32)

		PP.Anchor(ZO_RestyleStationTopLevel_Keyboard,			--[[#1]] TOPRIGHT, nil, TOPRIGHT, 0, 120,	--[[#2]] true, BOTTOMRIGHT, nil, BOTTOMRIGHT,	0, -70)
		PP.Anchor(ZO_RestyleStationTopLevel_KeyboardCategories,	--[[#1]] TOPLEFT, nil, TOPLEFT,	0, 77,		--[[#2]] true, BOTTOMRIGHT, ZO_DyeingTopLevel_Keyboard, BOTTOMLEFT, 0, 0)
		PP.Anchor(ZO_RestyleStationTopLevel_KeyboardTabs,		--[[#1]] TOPRIGHT, GuiRoot, TOPRIGHT, -30, 64)
		PP.Anchor(ZO_RestyleStationTopLevel_KeyboardInfoBar,	--[[#1]] TOPRIGHT, ZO_RestyleStationTopLevel_Keyboard, BOTTOMRIGHT,	0, 5)

		PP.Anchor(ZO_DyeingTopLevel_Keyboard, --[[#1]] TOPRIGHT,	GuiRoot, TOPRIGHT, -2, 94, --[[#2]] true, BOTTOMRIGHT,	GuiRoot, BOTTOMRIGHT, -8, -70)
		PP.Anchor(ZO_DyeingTopLevel_KeyboardPane, --[[#1]] TOPLEFT, ZO_DyeingTopLevel_KeyboardPaneDivider, BOTTOMLEFT, 0, -10, --[[#2]] true, BOTTOMRIGHT, nil, BOTTOMRIGHT, 9, 0)

		PP.ScrollBar(ZO_DyeingTopLevel_KeyboardPane, --[[sb_c]] 180, 180, 180, 0.8, --[[bd_c]] 20, 20, 20, 0.6, false)
		ZO_Scroll_SetMaxFadeDistance(ZO_DyeingTopLevel_KeyboardPane, 10)

		local function onRestyleTabChange()
			ZO_RestyleSheetWindowTopLevel_KeyboardEquipmentSheetSecondaryDivider:SetHidden(true)
			ZO_RestyleSheetWindowTopLevel_KeyboardCompanionEquipmentSheetSecondaryDivider:SetHidden(true)

			ZO_RestyleSheetWindowTopLevel_KeyboardOutfitStylesSheetSecondaryDivider:SetHidden(true)
			ZO_RestyleSheetWindowTopLevel_KeyboardCompanionOutfitStylesSheetSecondaryDivider:SetHidden(true)

			ZO_RestyleSheetWindowTopLevel_KeyboardCollectibleSheetPrimaryDivider:SetHidden(true)
			ZO_RestyleSheetWindowTopLevel_KeyboardCollectibleSheetSecondaryDivider:SetHidden(true)
			ZO_RestyleSheetWindowTopLevel_KeyboardCompanionCollectibleStylesSheetPrimaryDivider:SetHidden(true)
			ZO_RestyleSheetWindowTopLevel_KeyboardCompanionCollectibleStylesSheetSecondaryDivider:SetHidden(true)
		end
		SecurePostHook(ZO_RESTYLE_STATION_KEYBOARD, "OnTabFilterChanged", onRestyleTabChange)

		ZO_RestyleStationTopLevel_KeyboardTabsLabel:SetHidden(false)
		ZO_DyeingTopLevel_KeyboardPaneDivider:SetHidden(true)

		if ZO_RestyleSheetWindowTopLevel_KeyboardOutfitStylesSheetCostContainer ~= nil then
			PP.Font(ZO_RestyleSheetWindowTopLevel_KeyboardOutfitStylesSheetCostContainerCostLabel, --[[Font]] PP.f.u67, 18, "outline", --[[Alpha]] nil, --[[Color]] nil, nil, nil, nil, --[[StyleColor]] 0, 0, 0, 0.6)
			PP.Anchor(ZO_RestyleSheetWindowTopLevel_KeyboardOutfitStylesSheetCostContainer, --[[#1]] BOTTOMLEFT, ZO_RestyleSheetWindowTopLevel_KeyboardOutfitStylesSheet, BOTTOM, 10, -10)
		elseif ZO_RestyleSheetWindowTopLevel_KeyboardOutfitStylesSheetCost ~= nil then
			PP.Font(ZO_RestyleSheetWindowTopLevel_KeyboardOutfitStylesSheetCost, --[[Font]] PP.f.u67, 18, "outline", --[[Alpha]] nil, --[[Color]] nil, nil, nil, nil, --[[StyleColor]] 0, 0, 0, 0.6)
			PP.Anchor(ZO_RestyleSheetWindowTopLevel_KeyboardOutfitStylesSheetCost, --[[#1]] TOPLEFT, ZO_RestyleSheetWindowTopLevel_KeyboardOutfitStylesSheetSecondary, BOTTOMLEFT, -10, -5)
		end

		onRestyleTabChange()
	end)
end



