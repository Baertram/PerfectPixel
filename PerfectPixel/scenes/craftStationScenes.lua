local PP = PP ---@class PP
local namespace	= 'CraftStations'

PP.craftStationScenes = function()
	--===============================================================================================--
	local sv, def = PP:AddNewSavedVars(0.2, namespace, {
		Provisioner_ShowTooltip	= true,
	})
	--===============================================================================================--
	local children = {
		{ 'InventoryBackpack', 'Backpack', 'NavigationContainer'										},	--1	list
		{ 'Categories'																					},	--2	categories
		{ 'SortBy', 'InventorySortBy'																	},	--3	sortBy
		{ 'Tabs', 'InventoryTabs'																		},	--4	tabs
		{ 'FilterDivider', 'InventoryFilterDivider', 'TabsDivider', 'ButtonDivider', 'MenuBarDivider'	},	--5	filterDivider
		{ 'PatternListDivider', 'InventoryButtonDivider', 'ResearchLineList', 'ButtonDivider', 'ProvisioningFiltersNavigationDivider'			},	--6	listDivider
		{ 'InfoBar', 'InventoryInfoBar'																	},	--7	infoBar
	}

	local tlcs = {
		--Smithing
		{ ZO_SmithingTopLevelRefinementPanel, 'smithing' },
		{ ZO_SmithingTopLevelCreationPanel },
		{ ZO_SmithingTopLevelDeconstructionPanel },
		{ ZO_SmithingTopLevelImprovementPanel },
		{ ZO_SmithingTopLevelResearchPanel },
		--Universal Deconstruction
		{ ZO_UniversalDeconstructionTopLevel_KeyboardPanel, 'universalDeconstructionSceneKeyboard' },
		--Enchanting
		{ ZO_EnchantingTopLevelInventory, 'enchanting' },
		--Alchemy
		{ ZO_AlchemyTopLevelInventory, 'alchemy' },
		--Provisioning
		{ ZO_ProvisionerTopLevel, 'provisioner' },
		--Retrait
		{ ZO_RetraitStation_KeyboardTopLevelRetraitPanel, 'retrait_keyboard_root' },
	}

	local l_tabs = PP:GetLayout('menuBar', 'tabs')
	local l_menu = PP:GetLayout('menuBar', 'menu')

	for i = 1, #tlcs do
		local control, scene     = tlcs[i][1], tlcs[i][2]
		local craftStationLayout = PP:GetLayout('inventory', control)

		if control then
			local tlc, list, categories, sortBy, tabs, filterDivider, listDivider, infoBar = PP.GetLinks(control, children)
			local menu = tlc:GetParent():GetNamedChild("ModeMenu")

			if tlc == ZO_ProvisionerTopLevel then
				tlc = CreateControl("$(parent)Panel", tlc, CT_CONTROL)
				tlc:SetAnchorFill(ZO_SmithingTopLevelRefinementPanel)
				tlc:SetWidth(craftStationLayout.list_w)

				PP:CreateBackground(ZO_ProvisionerTopLevelFilletPanelSlotContainer,		--[[#1]] nil, nil, nil, -6, 0, --[[#2]] nil, nil, nil, 0, 6)
				ZO_ProvisionerTopLevelFilletPanelSlotContainerBg:SetHidden(true)
			end

			PP:CreateBackground(tlc,		--[[#1]] nil, nil, nil, -6, 0, --[[#2]] nil, nil, nil, 0, 6)
			PP.Anchor(tlc,					--[[#1]] TOPRIGHT, GuiRoot, TOPRIGHT, 0, craftStationLayout.tl_t_y, --[[#2]] true, BOTTOMRIGHT, GuiRoot, BOTTOMRIGHT, 0, craftStationLayout.tl_b_y)

			if tlc:GetNamedChild('Inventory') then
				tlc:GetNamedChild('Inventory'):SetAnchorFill(tlc)
			end
			if list then
				PP.ScrollBar(list)

--[[
Checking type on argument offsetY failed in ControlSetAnchorLua
if control is ZO_EnchantingTopLevelInventory -> list_t_y got 2 enties (I guess for enchanting mode create and mode extarct?)
->local craftStationLayout = PP:GetLayout('inventory', ZO_EnchantingTopLevelInventory)
-->Will be properly applying the table's entry Y offset then at e.g. ENCHANTING inventory:SetMode function below
]]
				local listOffsetY = craftStationLayout.list_t_y
				local listOffsetYCopy = listOffsetY --remove reference so we do not overwrite the original layout
				if type(listOffsetY) == "table" then
					listOffsetYCopy = 0
				end
				local listOffsetBY = craftStationLayout.list_b_y
				local listOffsetBYCopy = listOffsetBY --remove reference so we do not overwrite the original layout
				if type(listOffsetBYCopy) == "table" then
					listOffsetBYCopy = 0
				end
				PP.Anchor(list,				--[[#1]] TOPRIGHT, tlc, TOPRIGHT, 0, listOffsetYCopy, --[[#2]] true, BOTTOMRIGHT, tlc, BOTTOMRIGHT, 0, listOffsetBYCopy)

				list:SetWidth(craftStationLayout.list_w)
			end
			-- if categories then
				-- PP.ScrollBar(categories)
			-- end
			if sortBy then
				PP.Anchor(sortBy,			--[[#1]] BOTTOM, list, TOP, 0, 0)
				local sortByName = sortBy:GetNamedChild("Name")
				sortByName:SetWidth(craftStationLayout.sort_name_w)
				sortByName:SetAnchorOffsets(craftStationLayout.sort_name_t_x, nil, 1)
			end
			if tabs then
				PP.Anchor(tabs,				--[[#1]] TOPRIGHT, tlc, TOPRIGHT, -20, 10)
				tabs:SetHidden(craftStationLayout.noTabs)
				PP:RefreshStyle_MenuBar(tabs, l_tabs)
			end
			if filterDivider then
				PP.Anchor(filterDivider,	--[[#1]] TOP, tlc, TOP, 0, 52)
				filterDivider:SetHidden(craftStationLayout.noFDivider)
			end
			if listDivider then
				PP.Anchor(listDivider,		--[[#1]] TOP, tlc, TOP, 0, 98)
			end
			if menu then
				PP.Anchor(menu,			--[[#1]] TOPRIGHT, GuiRoot, TOPRIGHT, -30, 64)
				PP:RefreshStyle_MenuBar(menu, l_menu)
			end
			if infoBar then
				PP:RefreshStyle_InfoBar(infoBar, craftStationLayout)
			end

			local slotContainer = control:GetNamedChild("SlotContainer")
			if slotContainer then
				PP:CreateBackground(slotContainer,		--[[#1]] nil, nil, nil, -6, 0, --[[#2]] nil, nil, nil, 0, 6)
				local oldSlotContainerBg = slotContainer:GetNamedChild("Bg")
				if oldSlotContainerBg then
					oldSlotContainerBg:SetHidden(true)
				end
			elseif control == ZO_SmithingTopLevelCreationPanel then
				PP:CreateBackground(ZO_SmithingTopLevelCreationPanelMultiCraftContainer,		--[[#1]] nil, nil, nil, -6, 0, --[[#2]] nil, nil, nil, 0, 6)
				ZO_SmithingTopLevelCreationPanelMultiCraftContainerBg:SetHidden(true)
			elseif control == ZO_AlchemyTopLevelInventory then
				PP:CreateBackground(ZO_AlchemyTopLevelSlotContainer,		--[[#1]] nil, nil, nil, -6, 0, --[[#2]] nil, nil, nil, 0, 6)
				ZO_AlchemyTopLevelSlotContainerBg:SetHidden(true)
			end

		end

		if scene then
			local s		= SCENE_MANAGER:GetScene(scene)
			local a_f	= craftStationLayout.addFragments
			local r_f	= craftStationLayout.removeFragments
			local fr_f	= craftStationLayout.forceRemoveFragment
			local h_bg	= craftStationLayout.hideBgForScene

			for j = 1, #a_f do
				s:AddFragment(a_f[j])
			end
			for k = 1, #r_f do
				s:RemoveFragment(r_f[k])
			end
			for l = 1, #fr_f do
				PP:ForceRemoveFragment(s, fr_f[l])
			end
			for m = 1, #h_bg do
				PP:HideBackgroundForScene(SCENE_MANAGER:GetScene(scene), h_bg[m].PP_BG)
			end
		end
	end

	local TopOffsetY			= 110
	local BottomOffsetY			= -90
---------------------------------------------------------------------------------------------------
	-- SMITHING --==SCENE_MANAGER:GetScene('smithing')==--
	PP.Anchor(ZO_SmithingTopLevelSetContainer, --[[#1]] TOPRIGHT, ZO_SmithingTopLevelCreationPanel, TOPRIGHT, 0, 0, --[[#2]] true, BOTTOMRIGHT, ZO_SmithingTopLevelCreationPanel, BOTTOMRIGHT, 0, 0)
	PP.ScrollBar(ZO_SmithingTopLevelSetContainerCategories)
	ZO_SmithingTopLevelImprovementPanelBoosterContainerDivider:SetHidden(true)

	function SMITHING:RefreshModeMenuAnchors()
		if self.mode == SMITHING_MODE_CREATION and ZO_Smithing_IsConsolidatedStationCraftingMode() then
			PP.Anchor(ZO_SmithingTopLevelCreationPanel_PP_BG, --[[#1]] nil, ZO_SmithingTopLevelSetContainer, nil, nil, nil, --[[#2]] true, nil, nil, nil, nil, nil)
		else
			PP.Anchor(ZO_SmithingTopLevelCreationPanel_PP_BG, --[[#1]] nil, ZO_SmithingTopLevelCreationPanel, nil, nil, nil, --[[#2]] true, nil, nil, nil, nil, nil)
		end
	end
	function SMITHING:GetBackgroundFragmentGroupForMode(...)  end

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
---------------------------------------------------------------------------------------------------
	-- ENCHANTING --==SCENE_MANAGER:GetScene('enchanting')==--
	PP:SetLockFn(ZO_EnchantingTopLevelInventorySortBy, 'ClearAnchors')
	PP:SetLockFn(ZO_EnchantingTopLevelInventorySortBy, 'SetAnchor')

	local el = PP:GetLayout('inventory', ZO_EnchantingTopLevelInventory)
	ZO_PreHook(ZO_EnchantingInventory, "ChangeMode", function(self, enchantingMode)
		self.list:SetAnchorOffsets(0, el.list_t_y[enchantingMode], 1)

		ZO_EnchantingTopLevelRuneSlotContainerBg:SetHidden(true)
		ZO_EnchantingTopLevelExtractionSlotContainerBg:SetHidden(true)
	end)

	PP:CreateBackground(ZO_EnchantingTopLevelRuneSlotContainer, --[[#1]] nil, nil, nil, -10, -10, --[[#2]] nil, nil, nil, -30, 10)
	PP:CreateBackground(ZO_EnchantingTopLevelExtractionSlotContainer, --[[#1]] nil, nil, nil, -10, -10, --[[#2]] nil, nil, nil, 0, 10)

---------------------------------------------------------------------------------------------------
	-- ZO_RETRAIT_KEYBOARD ZO_RETRAIT_STATION_KEYBOARD --==SCENE_MANAGER:GetScene('retrait_keyboard_root')==-- -- ZO_RetraitStation_KeyboardTopLevel-- ZO_RetraitStation_KeyboardTopLevelReconstructPanel	
	local retrait_panel		= ZO_RETRAIT_KEYBOARD
	local traitContainer	= retrait_panel.traitContainer
	local traitList			= retrait_panel.traitList

	PP:CreateBackground(ZO_RetraitStation_KeyboardTopLevelReconstructPanelOptions, --[[#1]] nil, nil, nil, -10, -10, --[[#2]] nil, nil, nil, 0, 10)
	ZO_RetraitStation_KeyboardTopLevelReconstructPanel:SetAnchorFill(ZO_ItemSetsBook_Keyboard_TopLevel)

	PP:CreateBackground(traitContainer:GetNamedChild("BG"),	--[[#1]] nil, nil, nil, -10, -10, --[[#2]] nil, nil, nil, -2, -2)

	traitList.highlightTemplate = nil
	traitList.selectionTemplate = nil

	PP.Anchor(traitList, --[[#1]] TOPLEFT, traitContainer, TOPLEFT, -6, -6, --[[#2]] true, BOTTOMRIGHT, traitContainer, BOTTOMRIGHT, 0, 6)
	PP.Anchor(ZO_RetraitStation_KeyboardTopLevelRetraitPanelTraitContainerSelectTraitLabel, --[[#1]] BOTTOM, traitContainer, TOP, 0, -6)

	PP.ScrollBar(traitList)

	PP.Font(ZO_RetraitStation_KeyboardTopLevelRetraitPanelTraitContainerSelectTraitLabel, --[[Font]] PP.f.u67, 22, "outline", --[[Alpha]] 0.9, --[[Color]] nil, nil, nil, nil, --[[StyleColor]] 0, 0, 0, 0.5)

	ZO_RetraitStation_KeyboardTopLevelRetraitPanelTraitContainerDivider:SetHidden(true)
	ZO_RetraitStation_KeyboardTopLevelRetraitPanelTraitContainerBGMungeOverlay:SetHidden(true)

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

	function ZO_RETRAIT_STATION_KEYBOARD:RefreshModeMenuAnchors() end
---------------------------------------------------------------------------------------------------


--==ZO_WritAdvisor==--
	local waTLC = ZO_WritAdvisor_Keyboard_TopLevel
	PP:CreateBackground(waTLC,		--[[#1]] nil, nil, nil, 0, -24, --[[#2]] nil, nil, nil, 0, 17)
	PP.Anchor(waTLC:GetNamedChild("HeaderContainerDivider"), --[[#1]] TOPLEFT, waTLC, TOPLEFT, 0, 20, --[[#2]] true, TOPRIGHT, waTLC, TOPRIGHT, -30, 20)

	for i = 1, #WRIT_ADVISOR_KEYBOARD_FRAGMENT_GROUP do
		if WRIT_ADVISOR_KEYBOARD_FRAGMENT_GROUP[i] == MEDIUM_LEFT_PANEL_BG_FRAGMENT then
			WRIT_ADVISOR_KEYBOARD_FRAGMENT_GROUP[i] = nil
		end
	end
---------------------------------------------------------------------------------------------------


---------------------------------------------------------------------------------------------------
	-- PROVISIONER --==SCENE_MANAGER:GetScene('provisioner')==--
	ZO_ProvisionerTopLevelProvisioningFiltersHaveIngredients:SetAnchorFill(ZO_SmithingTopLevelCreationPanelHaveMaterials)
	PP.Font(ZO_ProvisionerTopLevelTabsLabel, --[[Font]] PP.f.u67, 20, "shadow", --[[Alpha]] 0.9, --[[Color]] nil, nil, nil, nil, --[[StyleColor]] 0, 0, 0, 0.5)
	ZO_ProvisionerTopLevelTabsLabel:SetAnchorOffsets(-10, 0, 1)
	ZO_ProvisionerTopLevelDetails:SetHidden(true)
	ZO_ProvisionerTopLevelDetailsDivider:SetHidden(true)
	PP:SetLockFn(ZO_ProvisionerTopLevelDetails,			'SetHidden')
	PP:SetLockFn(ZO_ProvisionerTopLevelDetailsDivider,	'SetHidden')
	PP:SetLockFn(ZO_ProvisionerTopLevelTabsLabel,		'SetFont')
	PP:SetLockFn(ZO_ProvisionerTopLevelTabsLabel,		'SetAnchor')
	PP:SetLockFn(ZO_ProvisionerTopLevelTabs,			'SetAnchor')
	ZO_ProvisionerTopLevelTabs.m_object.m_buttonPadding = 5

	-- function ZO_Provisioner:OnTabFilterChanged(filterData)
	-- function ZO_Provisioner:ConfigureFromSettings(settings)

	local PROVISIONER				= PROVISIONER
	local ingredientRowsContainer	= PROVISIONER.ingredientRowsContainer
	local ingredientRows			= PROVISIONER.ingredientRows
	local multiCraftContainer		= PROVISIONER.multiCraftContainer
	local resultTooltip				= PROVISIONER.resultTooltip
	local detailsPane				= PROVISIONER.detailsPane
	local recipeTree				= PROVISIONER.recipeTree
	local provisionerPanel			= ZO_ProvisionerTopLevelPanel
	PROVISIONER.ingredientRows		= {}

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


--========================================================================	
	local function OnCheckChanged()
		local var = sv.Provisioner_ShowTooltip == false and true or false
		sv.Provisioner_ShowTooltip = var
		return var
	end

	local cTooltip	= PP:CreateAnimatedButton(provisionerPanel, TOPLEFT, nil, TOPLEFT, 4, 10, "esoui/art/menubar/gamepad/gp_playermenu_icon_tutorial.dds", 32, 32, GetString(PP_LAM_CRAFT_STATIONS_PROVISIONER_SHOWTOOLTIP), sv.Provisioner_ShowTooltip, OnCheckChanged)

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
		ingredientRowsPool = self.ingredientRowsPool

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
		if sv.Provisioner_ShowTooltip then
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
							local levelPassiveAbilityName = ZO_CachedStrFormat(SI_ABILITY_NAME, GetAbilityName(levelPassiveAbilityId, "player"))
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
		if sv.Provisioner_ShowTooltip then
			ZO_SelectableLabel_OnMouseExit(self)
			ClearTooltip(ItemTooltip)
			return true
		end
	end)

	--Reused in several crafting scenes, like enchanting, jewelry, smithing, clothier, woodworking, provisioner -> all of them at the "Recipes" tab
	SecurePostHook(PROVISIONER, "EmbedInCraftingScene", function()
		--Move the provisioner multicraft control to the same bottom Y offset -64 like other PP crafting backgrounds use
		--so it's all at 1 line while switching the different craftingModes (e.g. at enchanting)
		ZO_ProvisionerTopLevelMultiCraftContainerBg:SetHidden(true)
		ZO_ProvisionerTopLevelMultiCraftContainer:ClearAnchors()
		ZO_ProvisionerTopLevelMultiCraftContainer:SetAnchor(BOTTOM, GuiRoot, BOTTOM, 0, -64)
	end)
	PP:CreateBackground(ZO_ProvisionerTopLevelMultiCraftContainer, --[[#1]] nil, nil, nil, -10, -10, --[[#2]] nil, nil, nil, 0, 10)
	ZO_ProvisionerTopLevelMultiCraftContainerBg:SetHidden(true)
--===============================================================================================--
end