local PP		= PP
local namespace	= 'CraftStations'

PP.craftStationScenes = function()
	local SV_VER				= 0.1
	local DEF = {
		Provisioner_ShowTooltip	= true,
	}
	local SV = ZO_SavedVars:NewAccountWide(PP.ADDON_NAME, SV_VER, "CraftStations", DEF, GetWorldName())

	local TopOffsetY			= 110
	local BottomOffsetY			= -90

--===============================================================================================--
--==ZO_WritAdvisor==--
	local waTLC = ZO_WritAdvisor_Keyboard_TopLevel
	PP:CreateBackground(waTLC,		--[[#1]] nil, nil, nil, 0, -24, --[[#2]] nil, nil, nil, 0, 17)
	PP.Anchor(waTLC:GetNamedChild("HeaderContainerDivider"), --[[#1]] TOPLEFT, waTLC, TOPLEFT, 0, 20, --[[#2]] true, TOPRIGHT, waTLC, TOPRIGHT, -30, 20)

	for i = 1, #WRIT_ADVISOR_KEYBOARD_FRAGMENT_GROUP do
		if WRIT_ADVISOR_KEYBOARD_FRAGMENT_GROUP[i] == MEDIUM_LEFT_PANEL_BG_FRAGMENT then
			WRIT_ADVISOR_KEYBOARD_FRAGMENT_GROUP[i] = nil
		end
	end
--===============================================================================================--
--==SMITHING_SCENE==-- --==SCENE_MANAGER:GetScene('smithing')==--
	local smithingTab = {ZO_SmithingTopLevelRefinementPanel, ZO_SmithingTopLevelDeconstructionPanel, ZO_SmithingTopLevelImprovementPanel}

	SMITHING_SCENE:RemoveFragment(RIGHT_PANEL_BG_FRAGMENT)
	SMITHING_SCENE:AddFragment(FRAME_TARGET_BLUR_STANDARD_RIGHT_PANEL_MEDIUM_LEFT_PANEL_FRAGMENT)

	PP:ForceRemoveFragment(SMITHING_SCENE, THIN_LEFT_PANEL_BG_FRAGMENT)
	PP:ForceRemoveFragment(SMITHING_SCENE, MEDIUM_LEFT_PANEL_BG_FRAGMENT)

	PP:CreateBackground(ZO_SmithingTopLevelRefinementPanel,		--[[#1]] nil, nil, nil, -6, 0, --[[#2]] nil, nil, nil, 0, 6)
	PP:CreateBackground(ZO_SmithingTopLevelDeconstructionPanel,	--[[#1]] nil, nil, nil, -6, 0, --[[#2]] nil, nil, nil, 0, 6)
	PP:CreateBackground(ZO_SmithingTopLevelImprovementPanel,	--[[#1]] nil, nil, nil, -6, 0, --[[#2]] nil, nil, nil, 0, 6)
	PP:CreateBackground(ZO_SmithingTopLevelCreationPanel,		--[[#1]] nil, nil, nil, -6, 0, --[[#2]] nil, nil, nil, 0, 6)
	PP:CreateBackground(ZO_SmithingTopLevelResearchPanel,		--[[#1]] nil, nil, nil, -6, 0, --[[#2]] nil, nil, nil, 0, 6)

	for _, v in ipairs(smithingTab) do
		local inventoryBackpackCtrl = v:GetNamedChild("InventoryBackpack")
		if inventoryBackpackCtrl ~= nil then
			PP.ScrollBar(inventoryBackpackCtrl,	--[[sb_c]] 180, 180, 180, 0.7, --[[bd_c]] 20, 20, 20, 0.7, true)
		end
		PP.Anchor(v, --[[#1]] TOPRIGHT, ZO_SmithingTopLevel, TOPRIGHT, 0, TopOffsetY, --[[#2]] true, BOTTOMRIGHT, ZO_SmithingTopLevel, BOTTOMRIGHT, 0, BottomOffsetY)
		local inventoryCtrl = v:GetNamedChild("Inventory")
		if inventoryCtrl ~= nil then
			PP.Anchor(inventoryCtrl, --[[#1]] TOPLEFT, v, TOPLEFT, 0, 0, --[[#2]] true, BOTTOMRIGHT, v, BOTTOMRIGHT, 0, 0)
			PP.Anchor(v:GetNamedChild("InventoryFilterDivider"),	--[[#1]] TOP, inventoryCtrl, TOP, 0, 60)
		end
	end
	PP.Anchor(ZO_SmithingTopLevelImprovementPanelInventory, --[[#1]] TOPLEFT, ZO_SmithingTopLevelImprovementPanel, TOPLEFT, 0, 0, --[[#2]] true, BOTTOMRIGHT, ZO_SmithingTopLevelImprovementPanel, BOTTOMRIGHT, 0, -145)
	ZO_SmithingTopLevelImprovementPanelBoosterContainerDivider:SetHidden(true)

	PP.Anchor(ZO_SmithingTopLevelResearchPanel, --[[#1]] TOPRIGHT, ZO_SmithingTopLevel, TOPRIGHT, 0, TopOffsetY, --[[#2]] true, BOTTOMRIGHT, ZO_SmithingTopLevel, BOTTOMRIGHT, 0, BottomOffsetY)
	PP.Anchor(ZO_SmithingTopLevelResearchPanelResearchLineList,	--[[#1]] TOP, ZO_SmithingTopLevelResearchPanel, TOP, 0, 104)

	PP.Anchor(ZO_SmithingTopLevelResearchPanelButtonDivider, --[[#1]] TOP, ZO_SmithingTopLevelResearchPanel, TOP, 0, 60)

	PP.Anchor(ZO_SmithingTopLevelModeMenu, --[[#1]] BOTTOM, ZO_SmithingTopLevelRefinementPanel, TOP, -40, 0)

	-- PP.Anchor(ZO_SmithingTopLevelDeconstructionPanelInventorySortBy, --[[#1]] nil, nil, nil, -8, nil)
	PP.Anchor(ZO_SmithingTopLevelImprovementPanelBoosterContainerHeader, --[[#1]] TOPLEFT, ZO_SmithingTopLevelImprovementPanelBoosterContainer, TOPLEFT, 0, 20)

	--Creation panel
	PP.Anchor(ZO_SmithingTopLevelCreationPanel, --[[#1]] TOPRIGHT, ZO_SmithingTopLevel, TOPRIGHT, 0, TopOffsetY, --[[#2]] true, BOTTOMRIGHT, ZO_SmithingTopLevel, BOTTOMRIGHT, 0, BottomOffsetY)
	--If Master crafter tables are available
	if ZO_SmithingTopLevelSetContainer ~= nil then
		--The new crafting stations reset the ModeMenu on each tab change...
		PP.Anchor(ZO_SmithingTopLevelModeMenu, --[[#1]] BOTTOM, ZO_SmithingTopLevelRefinementPanel, TOPRIGHT, -40, 0)
		function SMITHING.RefreshModeMenuAnchors()
			--Override. Will be called at each SMITHING.SetMode and would reanchor the ZO_SmithingTopLevelModeMenu again.
		end
		function SMITHING:GetBackgroundFragmentGroupForMode(mode)
			--Override. Will be called at each SMITHING.SetMode and would return background fragments we do not want to show
			--RIGHT_BG_FRAGMENT, TREE_UNDERLAY_FRAGMENT
			--RIGHT_PANEL_BG_FRAGMENT
			--ZO_SharedRightBackgroundLeft:SetHidden(true) / ZO_SharedTreeUnderlay:SetHidden(true)
			--ZO_SharedRightPanelBackgroundLeft:SetHidden(true)
			return
		end

		PP.Anchor(ZO_SmithingTopLevelCreationPanelTabsDivider,	--[[#1]] TOP, ZO_SmithingTopLevelCreationPanel, TOP, 0, 60)

		PP:CreateBackground(ZO_SmithingTopLevelSetContainer,		--[[#1]] nil, nil, nil, -6, 0, --[[#2]] BOTTOMRIGHT, ZO_SmithingTopLevelCreationPanel, BOTTOMLEFT, -6, 6)
		PP.ScrollBar(ZO_SmithingTopLevelSetContainerCategories,	--[[sb_c]] 180, 180, 180, 0.7, --[[bd_c]] 20, 20, 20, 0.7, true)

		--todo: fix tooltip at set's scroll container too!
		--function ZO_ConsolidatedSmithingSetNavigationEntry_OnMouseEnter
		-->InitializeTooltip(ItemTooltip, control, RIGHT, -25, 0)
		-->ItemTooltip:SetGenericItemSet
		--Set collections book tooltips use the same function and that works flawlessly, but crafted sets here do not add a bottom line and no space at the end.
		--Maybe because these tooltips only show the normal text and no icon etc. ?
		--> PP's tooltip layouts['ItemTooltip'] got y1 = -30 and this makes it look like that!
		--> If we change that to 0 it looks okay here at the crafting tables, but it looks bad for the normal/other ItemTooltip tooltips then...
		--> The layout only applies once, so we need to consider chngng it on each tooltip, or find a -15 medium value that fits all?

	else
		PP.Anchor(ZO_SmithingTopLevelCreationPanelTabsDivider,	--[[#1]] TOP, ZO_SmithingTopLevelCreationPanel, TOP, 0, 60)
	end


--?	--Smithing research slots backgrounds
	local maxSmithingResearchTraits = 9 --currently 9 at 2022-06-23
	local smithingResearchSlotTemplate = "ZO_SmithingResearchSlot%d"
	local smithingResearchpanelCtrl = SMITHING.researchPanel.control
	ZO_PostHookHandler(smithingResearchpanelCtrl, "OnEffectivelyShown", function()
		zo_callLater(function()
			for i=1, maxSmithingResearchTraits, 1 do
				local child = smithingResearchpanelCtrl:GetNamedChild(string.format(smithingResearchSlotTemplate, i))
				if child then
					local bg = child:GetNamedChild("Bg")
					if bg then
						bg:SetAlpha(0)
					end
				end
			end
		end, 25)
	end)

--===============================================================================================--
--==KEYBOARD_RETRAIT_ROOT_SCENE==-- --==SCENE_MANAGER:GetScene('retrait_keyboard_root')==--ZO_RETRAIT_KEYBOARD.traitContainer
	local retrait_station	= ZO_RETRAIT_STATION_KEYBOARD
	local retrait_panel		= ZO_RETRAIT_KEYBOARD
	local traitContainer	= retrait_panel.traitContainer
	local traitList			= retrait_panel.traitList

	KEYBOARD_RETRAIT_ROOT_SCENE:AddFragment(FRAME_TARGET_BLUR_CENTERED_FRAGMENT)

	PP:ForceRemoveFragment(KEYBOARD_RETRAIT_ROOT_SCENE, THIN_LEFT_PANEL_BG_FRAGMENT)
	PP:ForceRemoveFragment(KEYBOARD_RETRAIT_ROOT_SCENE, RIGHT_PANEL_BG_FRAGMENT)
	PP:ForceRemoveFragment(KEYBOARD_RETRAIT_ROOT_SCENE, RIGHT_BG_FRAGMENT)
	PP:ForceRemoveFragment(KEYBOARD_RETRAIT_ROOT_SCENE, TREE_UNDERLAY_FRAGMENT)
	
	PP:CreateBackground(retrait_panel.control,	--[[#1]] nil, nil, nil, -6, 0, --[[#2]] nil, nil, nil, 0, 6)

	PP.ScrollBar(ZO_RetraitStation_KeyboardTopLevelRetraitPanelInventoryBackpack,	--[[sb_c]] 180, 180, 180, 0.7, --[[bd_c]] 20, 20, 20, 0.7, true)

	PP.Anchor(ZO_RetraitStation_KeyboardTopLevelRetraitPanel, --[[#1]] TOPRIGHT, ZO_RetraitStation_KeyboardTopLevel, TOPRIGHT, 0, TopOffsetY, --[[#2]] true, BOTTOMRIGHT, ZO_RetraitStation_KeyboardTopLevel, BOTTOMRIGHT, 0, BottomOffsetY)
	PP.Anchor(ZO_RetraitStation_KeyboardTopLevelRetraitPanelInventory, --[[#1]] TOPLEFT, ZO_RetraitStation_KeyboardTopLevelRetraitPanel, TOPLEFT, 0, 0, --[[#2]] true, BOTTOMRIGHT, ZO_RetraitStation_KeyboardTopLevelRetraitPanel, BOTTOMRIGHT, 0, 0)

	function retrait_station:RefreshModeMenuAnchors() end
	retrait_station.modeMenu:SetWidth(550)
	PP.Anchor(retrait_station.modeMenu, --[[#1]] BOTTOM, retrait_panel.control, TOP, -40, 0)

	PP.Anchor(ZO_RetraitStation_KeyboardTopLevelRetraitPanelInventoryFilterDivider,	--[[#1]] TOP, ZO_RetraitStation_KeyboardTopLevelRetraitPanelInventory, TOP, 0, 60)

	--ZO_RetraitStation_KeyboardTopLevelRetraitPanelTraitContainer
	PP:CreateBackground(traitContainer:GetNamedChild("BG"),	--[[#1]] nil, nil, nil, -10, -10, --[[#2]] nil, nil, nil, -2, -2)

	traitList.highlightTemplate = nil
	traitList.selectionTemplate = nil

	PP.Anchor(traitList, --[[#1]] TOPLEFT, traitContainer, TOPLEFT, -6, -6, --[[#2]] true, BOTTOMRIGHT, traitContainer, BOTTOMRIGHT, 0, 6)
	-- PP.Anchor(ZO_RetraitStation_KeyboardTopLevelRetraitPanelTraitContainerBG, --[[#1]] TOPLEFT, traitList, TOPLEFT, -6, -6, --[[#2]] true, BOTTOMRIGHT, traitList, BOTTOMRIGHT, 0, 6)
	PP.Anchor(ZO_RetraitStation_KeyboardTopLevelRetraitPanelTraitContainerSelectTraitLabel, --[[#1]] BOTTOM, traitContainer, TOP, 0, -6)

	PP.ScrollBar(traitList,	--[[sb_c]] 180, 180, 180, 0.7, --[[bd_c]] 20, 20, 20, 0.7, true)

	PP.Font(ZO_RetraitStation_KeyboardTopLevelRetraitPanelTraitContainerSelectTraitLabel, --[[Font]] PP.f.u67, 22, "outline", --[[Alpha]] 0.9, --[[Color]] nil, nil, nil, nil, --[[StyleColor]] 0, 0, 0, 0.5)
	
	ZO_RetraitStation_KeyboardTopLevelRetraitPanelTraitContainerDivider:SetHidden(true)
	ZO_RetraitStation_KeyboardTopLevelRetraitPanelTraitContainerBGMungeOverlay:SetHidden(true)

	-- local bg = ZO_RetraitStation_KeyboardTopLevelRetraitPanelTraitContainerBG
	-- bg:SetCenterTexture(PP.SV.skin_backdrop, PP.SV.skin_backdrop_tile_size, PP.SV.skin_backdrop_tile and 1 or 0)
	-- bg:SetCenterColor(unpack(PP.SV.skin_backdrop_col))
	-- bg:SetEdgeTexture(PP.SV.skin_edge, PP.SV.skin_edge_file_width, PP.SV.skin_edge_file_height, PP.SV.skin_edge_thickness, 0)
	-- bg:SetEdgeColor(unpack(PP.SV.skin_edge_col))
	-- bg:SetInsets(PP.SV.skin_backdrop_insets, PP.SV.skin_backdrop_insets, -PP.SV.skin_backdrop_insets, -PP.SV.skin_backdrop_insets)
	-- bg:SetIntegralWrapping(PP.SV.skin_edge_integral_wrapping)

	ZO_PreHook("ZO_RetraitStation_Retrait_Keyboard_OnTraitRowMouseEnter", function(control)
		control.backdrop:SetCenterColor(unpack(PP.savedVars.ListStyle.list_skin_backdrop_hl_col))
	end)
	ZO_PreHook("ZO_RetraitStation_Retrait_Keyboard_OnTraitRowMouseExit", function(control)
		control.backdrop:SetCenterColor(unpack(PP.savedVars.ListStyle.list_skin_backdrop_col))
	end)

	ZO_PreHook("ZO_RetraitStation_Retrait_Keyboard_OnTraitRowMouseUp", function(control, button, upInside)
		if upInside then
			if control.data.knownTrait then
				local lastSelected = traitList.traitSelectedControl

				if lastSelected == control then return end
				control.backdrop:SetEdgeColor(unpack(PP.savedVars.ListStyle.list_skin_edge_sel_col))
				traitList.traitSelectedControl = control

				if not lastSelected then return end
				lastSelected.backdrop:SetEdgeColor(unpack(PP.savedVars.ListStyle.list_skin_edge_col))
			end
		end
	end)

	local orig_RefreshTraitList = ZO_RetraitStation_Retrait_Keyboard.RefreshTraitList
	function ZO_RetraitStation_Retrait_Keyboard.RefreshTraitList(...)
		if traitList.traitSelectedControl then
			traitList.traitSelectedControl.backdrop:SetEdgeColor(unpack(PP.savedVars.ListStyle.list_skin_edge_col))
			traitList.traitSelectedControl = nil
		end

		traitContainer:SetHeight(600)
		orig_RefreshTraitList(...)
		traitContainer:SetHeight(traitList.uniformControlHeight * #traitList.data - (traitList.uniformControlHeight - ZO_ScrollList_GetDataTypeTable(traitList, 1).height))
	end


--===============================================================================================--
--Baertram 2022-04-17
--==UNIVERSAL_DECONSTRUCTION_KEYBOARD_SCENE==-- --==SCENE_MANAGER:GetScene('universalDeconstructionSceneKeyboard')==--
	local universalDeconScene = UNIVERSAL_DECONSTRUCTION_KEYBOARD_SCENE
	local universalDeconTab = {ZO_UniversalDeconstructionTopLevel_KeyboardPanel}

	universalDeconScene:RemoveFragment(RIGHT_PANEL_BG_FRAGMENT)
	universalDeconScene:AddFragment(FRAME_TARGET_BLUR_STANDARD_RIGHT_PANEL_MEDIUM_LEFT_PANEL_FRAGMENT)

	PP:ForceRemoveFragment(universalDeconScene, THIN_LEFT_PANEL_BG_FRAGMENT)
	PP:ForceRemoveFragment(universalDeconScene, MEDIUM_LEFT_PANEL_BG_FRAGMENT)
	
	PP:CreateBackground(ZO_UniversalDeconstructionTopLevel_KeyboardPanel,	--[[#1]] nil, nil, nil, -6, 0, --[[#2]] nil, nil, nil, 0, 6)

	for _, v in ipairs(universalDeconTab) do
		PP.ScrollBar(v:GetNamedChild("InventoryBackpack"),	--[[sb_c]] 180, 180, 180, 0.7, --[[bd_c]] 20, 20, 20, 0.7, true)
		PP.Anchor(v:GetNamedChild("Inventory"), --[[#1]] TOPLEFT, v, TOPLEFT, 0, 0, --[[#2]] true, BOTTOMRIGHT, v, BOTTOMRIGHT, 0, 0)
		PP.Anchor(v, --[[#1]] TOPRIGHT, ZO_UniversalDeconstructionTopLevel_Keyboard, TOPRIGHT, 0, TopOffsetY, --[[#2]] true, BOTTOMRIGHT, ZO_UniversalDeconstructionTopLevel_Keyboard, BOTTOMRIGHT, 0, BottomOffsetY)
		PP.Anchor(v:GetNamedChild("InventoryFilterDivider"),	--[[#1]] TOP, v:GetNamedChild("Inventory"), TOP, 0, 60)
	end
	ZO_UniversalDeconstructionTopLevel_KeyboardModeMenuBar:SetHidden(true)

--===============================================================================================--
--==ENCHANTING_SCENE==-- --==SCENE_MANAGER:GetScene('enchanting')==--
	ENCHANTING_SCENE:RemoveFragment(RIGHT_PANEL_BG_FRAGMENT)
	ENCHANTING_SCENE:AddFragment(FRAME_TARGET_BLUR_STANDARD_RIGHT_PANEL_MEDIUM_LEFT_PANEL_FRAGMENT)

	PP:CreateBackground(ZO_EnchantingTopLevelInventory,	--[[#1]] nil, nil, nil, -6, 0, --[[#2]] nil, nil, nil, 0, 6)
	PP.ScrollBar(ZO_EnchantingTopLevelInventoryBackpack,	--[[sb_c]] 180, 180, 180, 0.7, --[[bd_c]] 20, 20, 20, 0.7, true)
	PP.Anchor(ZO_EnchantingTopLevelInventory,				--[[#1]] TOPRIGHT, ZO_EnchantingTopLevel, TOPRIGHT, 0, TopOffsetY, --[[#2]] true, BOTTOMRIGHT, ZO_EnchantingTopLevel, BOTTOMRIGHT, 0, BottomOffsetY)
	PP.Anchor(ZO_EnchantingTopLevelModeMenu,				--[[#1]] BOTTOM, ZO_EnchantingTopLevelInventory, TOP, -40, 0)
	PP.Anchor(ZO_EnchantingTopLevelInventoryFilterDivider,	--[[#1]] TOP, ZO_EnchantingTopLevelInventory, TOP, 0, 60)

--===============================================================================================--
--==ALCHEMY_SCENE==--ALCHEMY
	ALCHEMY_SCENE:RemoveFragment(RIGHT_PANEL_BG_FRAGMENT)
	ALCHEMY_SCENE:AddFragment(FRAME_TARGET_BLUR_STANDARD_RIGHT_PANEL_MEDIUM_LEFT_PANEL_FRAGMENT)

	PP:CreateBackground(ZO_AlchemyTopLevelInventory,	--[[#1]] nil, nil, nil, -6, 0, --[[#2]] nil, nil, nil, 0, 6)
	PP.ScrollBar(ZO_AlchemyTopLevelInventoryBackpack,	--[[sb_c]] 180, 180, 180, 0.7, --[[bd_c]] 20, 20, 20, 0.7, true)
	PP.Anchor(ZO_AlchemyTopLevelInventory,				--[[#1]] TOPRIGHT, ZO_AlchemyTopLevel, TOPRIGHT, 0, TopOffsetY, --[[#2]] true, BOTTOMRIGHT, ZO_AlchemyTopLevel, BOTTOMRIGHT, 0, BottomOffsetY)
	PP.Anchor(ZO_AlchemyTopLevelModeMenu,				--[[#1]] BOTTOM, ZO_AlchemyTopLevelInventory, TOP, -40, 0)
	PP.Anchor(ZO_AlchemyTopLevelInventoryFilterDivider,	--[[#1]] TOP, ZO_AlchemyTopLevelInventory, TOP, 0, 60)

--===============================================================================================--
--==PROVISIONER_SCENE==-- --==SCENE_MANAGER:GetScene('provisioner')==--
	PROVISIONER_SCENE:RemoveFragment(RIGHT_PANEL_BG_FRAGMENT)
	PROVISIONER_SCENE:AddFragment(FRAME_TARGET_BLUR_CENTERED_FRAGMENT)

	local PROVISIONER				= PROVISIONER
	local ingredientRowsContainer	= PROVISIONER.ingredientRowsContainer
	local ingredientRows			= PROVISIONER.ingredientRows
	local multiCraftContainer		= PROVISIONER.multiCraftContainer
	local resultTooltip				= PROVISIONER.resultTooltip
	local detailsPane				= PROVISIONER.detailsPane
	local recipeTree				= PROVISIONER.recipeTree

	local provisionerPanel = CreateControl("$(parent)Panel", ZO_ProvisionerTopLevel, CT_CONTROL)
	provisionerPanel:SetWidth(565)
	PP.Anchor(provisionerPanel,				--[[#1]] TOPRIGHT, ZO_ProvisionerTopLevel, TOPRIGHT, 0, TopOffsetY, --[[#2]] true, BOTTOMRIGHT, ZO_ProvisionerTopLevel, BOTTOMRIGHT, 0, BottomOffsetY)
	PP:CreateBackground(provisionerPanel,	--[[#1]] nil, nil, nil, -6, 0, --[[#2]] nil, nil, nil, 0, 6)

	PP.Anchor(ZO_ProvisionerTopLevelTabs, --[[#1]] TOPRIGHT, provisionerPanel, TOPRIGHT, -33, 14)
	ZO_ProvisionerTopLevelTabs.m_object.m_buttonPadding = -5
	ZO_ProvisionerTopLevelTabs.m_object.m_point = 8
	ZO_ProvisionerTopLevelTabs.m_object.m_relativePoint = 2
	PP.Anchor(ZO_ProvisionerTopLevelTabsLabel,	--[[#1]] RIGHT, ZO_ProvisionerTopLevelTabs, LEFT, -20, 0)

	PP.Anchor(ZO_ProvisionerTopLevelNavigationContainer, --[[#1]] TOPRIGHT,	provisionerPanel, TOPRIGHT, 0, TopOffsetY,	--[[#2]] true, BOTTOMRIGHT, provisionerPanel, BOTTOMRIGHT, 0, 0)
	ZO_ProvisionerTopLevelNavigationContainer:SetWidth(565)
	PP.ScrollBar(ZO_ProvisionerTopLevelNavigationContainer,	--[[sb_c]] 180, 180, 180, 0.7, --[[bd_c]] 20, 20, 20, 0.7, true)
	ZO_Scroll_SetMaxFadeDistance(ZO_ProvisionerTopLevelNavigationContainer, 10)

	local function updateProvisionerUIHiddenState()
		ZO_ProvisionerTopLevelDetailsDivider:SetHidden(true)
		if ZO_ProvisionerTopLevelDetails ~= nil then
			ZO_ProvisionerTopLevelDetails:SetHidden(true)
		end
	end
	updateProvisionerUIHiddenState()

	if ZO_ProvisionerTopLevelNavigationDivider ~= nil then
		PP.Anchor(ZO_ProvisionerTopLevelNavigationDivider,	--[[#1]] nil, nil, nil, 0, 40)
	end
	PP.Anchor(ZO_ProvisionerTopLevelMenuBarDivider,	--[[#1]] TOP, provisionerPanel, TOP, 0, 60)
	if ZO_ProvisionerTopLevelHaveIngredients ~= nil then
		PP.Anchor(ZO_ProvisionerTopLevelHaveIngredients,		--[[#1]] nil, nil, nil, 30, 14)
	end
--------------------------------------
	SecurePostHook(PROVISIONER, "OnTabFilterChanged", function()
		updateProvisionerUIHiddenState()
	end)


	-- function ZO_Provisioner:ConfigureFromSettings(settings)
	ZO_PreHook(ZO_Provisioner, "ConfigureFromSettings", function(self, settings)
		if self.settings ~= settings then
			--Sort the buttons by their descriptor DESC so that it will be food, drinks, furniture, fish filet
			table.sort(settings.tabs, function(a, b) return a.descriptor > b.descriptor end)

			self.settings = settings

			self.skillInfoHeader:SetHidden(not settings.showProvisionerSkillLevel)
			ZO_MenuBar_ClearButtons(self.tabs)
			for _, tab in ipairs(settings.tabs) do
				ZO_MenuBar_AddButton(self.tabs, tab)
			end
			ZO_MenuBar_SelectDescriptor(self.tabs, settings.tabs[1].descriptor)
		end
	end)
--------------------------------------
	-- recipeTree.defaultIndent = 20		--[[def (60)]]
	recipeTree.defaultSpacing = -11		--[[def (-10)]]
	do
		-- TreeHeaderSetup(node, control, data, open, userRequested, enabled)
		local treeHeader = recipeTree["templateInfo"]["ZO_ProvisionerNavigationHeader"]
		local existingSetupCallback = treeHeader.setupFunction
		treeHeader.setupFunction = function(node, control, data, open, userRequested, enabled)
			existingSetupCallback(node, control, data, open, userRequested, enabled)
			control:SetHeight(48)
			control.text:SetDimensionConstraints(0, 0, 400, 0)
		end
	end
	-- do
		-- ["ZO_ProvisionerNavigationEntry"]
		-- TreeEntrySetup(node, control, data, open, userRequested, enabled)
		-- local treeHeader = recipeTree["templateInfo"]["ZO_ProvisionerNavigationEntry"]
		-- local existingSetupCallback = treeHeader.setupFunction
		-- treeHeader.setupFunction = function(node, control, data, open, userRequested, enabled)
			-- existingSetupCallback(node, control, data, open, userRequested, enabled)

			-- local text = control:GetText()
			-- local link = GetRecipeResultItemLink(data["recipeListIndex"], data["recipeIndex"])
			-- local level = GetItemLinkRequiredLevel(link)
			-- local levelcp = GetItemLinkRequiredChampionPoints(link)
			-- if levelcp > 0 then
				-- control:SetText(string.rep(" " , 6 - string.len(levelcp) * 2) .. "|cbababa*" .. levelcp .. "|r   " .. text)
			-- elseif level > 1 then
				-- control:SetText(string.rep(" " , 8 - string.len(level) * 2) .. "|cbababa" .. level .. "|r   " .. text)
			-- else
				-- control:SetText(string.rep(" " , 8) .. "   " .. text)
			-- end
		-- end
	-- end
	
--------------------------------------
	detailsPane:SetHidden(true)
	PROVISIONER.ingredientRows = {}

--========================================================================	
	local function OnCheckChanged()
		local var = SV.Provisioner_ShowTooltip == false and true or false
		SV.Provisioner_ShowTooltip = var
		return var
	end

	local cTooltip	= PP:CreateAnimatedButton(provisionerPanel, TOPLEFT, nil, TOPLEFT, 4, 10, "esoui/art/menubar/gamepad/gp_playermenu_icon_tutorial.dds", 32, 32, GetString(PP_LAM_CRAFT_STATIONS_PROVISIONER_SHOWTOOLTIP), SV.Provisioner_ShowTooltip, OnCheckChanged)
	-- local cIngr		= PP:CreateAnimatedButton(ZO_ProvisionerTopLevelHaveIngredients, LEFT, cTooltip, RIGHT, 6, 0, "esoui/art/inventory/gamepad/gp_inventory_icon_miscellaneous.dds", 32, 32, GetString(SI_CRAFTING_HAVE_INGREDIENTS_TOOLTIP))
	-- local cSkills	= PP:CreateAnimatedButton(ZO_ProvisionerTopLevelHaveSkills, LEFT, cIngr, RIGHT, 6, 0, "esoui/art/inventory/gamepad/gp_inventory_icon_materials.dds", 32, 32, GetString(SI_CRAFTING_HAVE_SKILLS_TOOLTIP))
	-- PP:CreateAnimatedButton(ZO_ProvisionerTopLevelIsQuestItem, LEFT, cSkills, RIGHT, 6, 0, "esoui/art/inventory/gamepad/gp_inventory_icon_quest.dds", 32, 32, GetString(SI_CRAFTING_IS_QUEST_ITEM_TOOLTIP))
	
	-- PP:CreateAnimatedButton(ZO_SmithingTopLevelDeconstructionPanelInventoryIncludeBanked, nil, nil, nil, 20, 20, "/esoui/art/icons/servicemappins/servicepin_bank.dds", 32, 32)
	--========================================================================
	local _, _, maxWidth = resultTooltip:GetDimensionConstraints()

	local function Create(pool, objectKey)
		local control	= CreateControl(nil, GuiRoot, CT_CONTROL)
		local name		= CreateControl(nil, control, CT_LABEL)
		local count		= CreateControl(nil, control, CT_LABEL)

		control:SetHidden(true)
		control:SetWidth(maxWidth)

		name:SetFont(PP.f.u67 .. "|16|shadow")
		name:SetAnchor(LEFT, control, LEFT, 5, 0)
		name:SetAnchor(RIGHT, count, LEFT, -12, 0)
		name:SetMaxLineCount(1)
		name:SetWrapMode(TEXT_WRAP_MODE_ELLIPSIS)
		name:SetHorizontalAlignment(TEXT_ALIGN_LEFT)

		count:SetFont(PP.f.u57 .. "|16|shadow")
		count:SetAnchor(RIGHT, control, RIGHT, -5, 0)
		count:SetMaxLineCount(1)
		count:SetWrapMode(TEXT_WRAP_MODE_ELLIPSIS)
		count:SetHorizontalAlignment(TEXT_ALIGN_RIGHT)

		control.name	= name
		control.count	= count
		
		return control
	end

	local function Reset(control, pool)
		control:SetHidden(true)
		control:ClearAnchors()
	end

	PROVISIONER.ingredientRowsPool	= ZO_ObjectPool:New(Create, Reset)
	local ingredientRowsPool		= PROVISIONER.ingredientRowsPool

	ingredientRowsPool.customAcquireBehavior = function(control, key)
		control:SetHidden(false)
	end

	function ingredientRowsPool:ReleaseIngredientRowsTo(listId)
		local list = self[listId]
		for i = 1, #list do
			self:ReleaseObject(list[i])
		end
		self[listId] = {}
	end

	function PROVISIONER:AddIngredientRowsTooltip(tooltip, numIngredients, recipeListIndex, recipeIndex, listId)
		local ingredientRowsPool = self.ingredientRowsPool
		
		if not ingredientRowsPool[listId] then
			ingredientRowsPool[listId] = {}
		end
		
		ingredientRowsPool:ReleaseIngredientRowsTo(listId)

		for ingredientIndex = 1, numIngredients do
			local row, key									= ingredientRowsPool:AcquireObject()
			local name, icon, requiredQuantity, _, quality	= GetRecipeIngredientItemInfo(recipeListIndex, recipeIndex, ingredientIndex)
			local ingredientCount							= GetCurrentRecipeIngredientCount(recipeListIndex, recipeIndex, ingredientIndex)
			local numIterations								= self:GetMultiCraftNumIterations()
			local _requiredQuantity							= numIterations > 1 and requiredQuantity * numIterations or requiredQuantity

			ingredientRowsPool[listId][ingredientIndex] = key

			row.name:SetText(zo_iconFormat(icon, 30, 30) .. "  " .. zo_strformat(SI_TOOLTIP_ITEM_NAME, name))
			row.name:SetColor(GetInterfaceColor(INTERFACE_COLOR_TYPE_ITEM_QUALITY_COLORS, quality))
			row.count:SetText(_requiredQuantity .. " " .. zo_iconFormat("/esoui/art/treeicons/housing_indexicon_hearth_up.dds", 30, 30) .. string.rep(" " , 10 - string.len(ingredientCount) * 2) .. ingredientCount .. " " .. zo_iconFormat("EsoUI/Art/Tooltips/icon_craft_bag.dds", 26, 26))
			if _requiredQuantity > ingredientCount then
				row.count:SetColor(222/255, 36/255, 33/255, 1)
			else
				row.count:SetColor(255/255, 255/255, 255/255, 1)
			end
			tooltip:AddControl(row)
			row:SetAnchor(CENTER)
		end
	end

	local orig_SetProvisionerResultItem = resultTooltip.SetProvisionerResultItem
	function resultTooltip:SetProvisionerResultItem(recipeListIndex, recipeIndex)
		orig_SetProvisionerResultItem(self, recipeListIndex, recipeIndex)
		local data				= PROVISIONER.recipeTree:GetSelectedData()
		local numIngredients	= data.numIngredients
		PROVISIONER:AddIngredientRowsTooltip(self, numIngredients, recipeListIndex, recipeIndex, 1)
	end
--------------------------------------
	ZO_PreHook("ZO_ProvisionerNavigationEntry_OnMouseEnter", function(self)
		if SV.Provisioner_ShowTooltip then
			ZO_SelectableLabel_OnMouseEnter(self)
			InitializeTooltip(ItemTooltip, self, RIGHT, -64, 0)
			
			local data				= self.data
			local numIngredients	= data.numIngredients
			local recipeListIndex	= data.recipeListIndex
			local recipeIndex		= data.recipeIndex

			ItemTooltip:SetProvisionerResultItem(recipeListIndex, recipeIndex)
			PROVISIONER:AddIngredientRowsTooltip(ItemTooltip, numIngredients, recipeListIndex, recipeIndex, 2)

			if self.enabled and (not self.meetsLevelReq or not self.meetsQualityReq) then
				--loop over tradeskills
				if not self.meetsLevelReq then
					 for tradeskill, levelReq in pairs(data.tradeskillsLevelReqs) do
						local level = GetNonCombatBonus(GetNonCombatBonusLevelTypeForTradeskillType(tradeskill))
						if level < levelReq then
							local levelPassiveAbilityId = GetTradeskillLevelPassiveAbilityId(tradeskill)
							local levelPassiveAbilityName = GetAbilityName(levelPassiveAbilityId)
							ItemTooltip:AddLine(zo_strformat(SI_RECIPE_REQUIRES_LEVEL_PASSIVE, levelPassiveAbilityName, levelReq), "", ZO_ERROR_COLOR:UnpackRGBA())
						end
					end
				end
				if not self.meetsQualityReq then
					ItemTooltip:AddLine(zo_strformat(SI_PROVISIONER_REQUIRES_RECIPE_QUALITY, data.qualityReq), "", ZO_ERROR_COLOR:UnpackRGBA())
				end
			end
			return true
		end
	end)

	ZO_PreHook("ZO_ProvisionerNavigationEntry_OnMouseExit", function(self)
		if SV.Provisioner_ShowTooltip then
			ZO_SelectableLabel_OnMouseExit(self)
			ClearTooltip(ItemTooltip)
			return true
		end
	end)
--===============================================================================================--
end