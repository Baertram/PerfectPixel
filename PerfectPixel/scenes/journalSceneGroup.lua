local PP = PP ---@class PP
local removeFragmentsFromScene = PP.removeFragmentsFromScene

local DEFAULT_JOURNAL_SCENES = {
	{ scene = QUEST_JOURNAL_SCENE,							gVar = QUEST_JOURNAL_KEYBOARD,		},
	{ scene = ANTIQUITY_JOURNAL_KEYBOARD_SCENE,				gVar = ANTIQUITY_JOURNAL_KEYBOARD,	},
	{ scene = SCENE_MANAGER:GetScene('cadwellsAlmanac'),	gVar = CADWELLS_ALMANAC,			},
	{ scene = LORE_LIBRARY_SCENE,							gVar = LORE_LIBRARY,				},
	{ scene = SCENE_MANAGER:GetScene('achievements'),		gVar = ACHIEVEMENTS,				--[[sceneShowCallback = achievementsProgressBars]]},
	{ scene = LEADERBOARDS_SCENE,							gVar = LEADERBOARDS,				},
}

local FRAGMENTS_TO_REMOVE = {
	FRAME_PLAYER_FRAGMENT,
	RIGHT_BG_FRAGMENT,
	TREE_UNDERLAY_FRAGMENT,
	TITLE_FRAGMENT,
	JOURNAL_TITLE_FRAGMENT,
}

local function EditScene(scene, topLevelControl, editElementsFunc, ...)
	-- local filter 		= 		gVar.filter or gVar.categoryFilter
	-- local progressBar   = 		gVar.categoryProgress
	-- local sceneShowCallback = 	scenes[i].sceneShowCallback

	removeFragmentsFromScene(scene, FRAGMENTS_TO_REMOVE)

	local tlc	= topLevelControl
	-- local list	= gVar.list

	PP:CreateBackground(tlc, --[[#1]] nil, nil, nil, -10, -15, --[[#2]] nil, nil, nil, 0, 10)
	PP.Anchor(tlc, --[[#1]] TOPRIGHT, GuiRoot, TOPRIGHT, 0, 120, --[[#2]] true, BOTTOMRIGHT, GuiRoot, BOTTOMRIGHT, 0, -70)

	--[=[
	PP.Anchor(list, --[[#1]] nil, nil, nil, 0, 3, --[[#2]] true, nil, nil, nil, 0, 0)
	PP.ScrollBar(list,	--[[sb_c]] 180, 180, 180, .7, --[[bd_c]] 20, 20, 20, .7, false)
	ZO_ScrollList_Commit(list)
	if progressBar then
	PP.Bar(progressBar, --[[h]] 14, --[[f]] 15, 255, nil)
	end
	if filter then
	Change the drawTier of the filter dropdown boxes so they get overlayed by the background backdrop
	filter:SetDrawTier(DT_MEDIUM)
	filter:SetDrawLayer(DL_TEXT)
	filter:SetDrawLevel(1)
	end

	if sceneShowCallback ~= nil then
	scene:RegisterCallback("StateChange", function(oldState, newState)
	if newState == SCENE_SHOWN and not scenesShown[scene] then
	sceneShowCallback()
	scenesShown[scene] = true
	end
	end)
	end
	]=]

	if type(editElementsFunc) == "function" then
		editElementsFunc(...)
	end
end
PP.journalSceneGroupEditScene = EditScene

local SV

local function SetupSavedVariables()
	local SV_VER		= 0.4
	local DEF = {
		largeQuestList	= true,
	}
	SV = ZO_SavedVars:NewAccountWide(PP.ADDON_NAME, SV_VER, "JournalScene", DEF, GetWorldName())
	---------------------------------------------
	table.insert(PP.optionsData,
			{	type				= "submenu",
					name				= GetString(PP_LAM_SCENE_JOURNAL),
					controls = {
						{	type				= "checkbox",
							name				= GetString(PP_LAM_SCENE_JOURNAL_QUEST_LARGE_LIST),
							getFunc				= function() return SV.largeQuestList end,
							setFunc				= function(value) SV.largeQuestList = value end,
							default				= DEF.largeQuestList,
							requiresReload		= true,
						},
					},
			})
end

local JOURNAL_SCROLLBAR_SB = { 180, 180, 180, 0.7 }
local JOURNAL_SCROLLBAR_BD = { 20, 20, 20, 0.7 }

local function Edit_ZO_QuestJournal()
	SetupSavedVariables()

	-- Update 50: quest list UI lives on ZO_QUEST_JOURNAL_QUESTS_KEYBOARD (QuestsPanel), not flat globals
	local questsKeyboard = ZO_QUEST_JOURNAL_QUESTS_KEYBOARD
	if not questsKeyboard or not questsKeyboard.control then
		return
	end

	local questCount = questsKeyboard.questCount
	local navContainer = questsKeyboard.control:GetNamedChild("NavigationContainer")
	local navScroll = navContainer and navContainer:GetNamedChild("Scroll")
	if not questCount or not navContainer or not navScroll then
		return
	end

	--questJournal--ZO_QuestJournal--------------------------------------------------------------------
	PP.ScrollBar(navContainer, --[[sb_c]] JOURNAL_SCROLLBAR_SB[1], JOURNAL_SCROLLBAR_SB[2], JOURNAL_SCROLLBAR_SB[3], JOURNAL_SCROLLBAR_SB[4], --[[bd_c]] JOURNAL_SCROLLBAR_BD[1], JOURNAL_SCROLLBAR_BD[2], JOURNAL_SCROLLBAR_BD[3], JOURNAL_SCROLLBAR_BD[4], false)
	PP.Anchor(questCount, --[[#1]] TOPLEFT, nil, TOPLEFT, 0, -6)
	PP.Anchor(navScroll, --[[#1]] TOPLEFT, nil, TOPLEFT, 5, 0, --[[#2]] true, BOTTOMRIGHT, nil, BOTTOMRIGHT, 0, 0)
	PP.Font(questCount, --[[Font]] PP.f.u67, 24, "outline")
	ZO_Scroll_SetMaxFadeDistance(navContainer, 10)

	if SV.largeQuestList then
		local tree = questsKeyboard.navigationTree
		if tree then
		tree.defaultIndent = 50		--[[def (40)]]
		tree.defaultSpacing = 0		--[[def (-10)]]
		tree.width = 340			--[[def (300)]]
		-- tree:SetExclusive(false) >> breaks the game
		tree.exclusiveCloseNodeFunction = function(treeNode)
			treeNode:SetOpen(true, false)
		end

		PP.Anchor(navScroll, --[[#1]] TOPLEFT, nil, TOPLEFT, 0, 0, --[[#2]] true, BOTTOMRIGHT, nil, BOTTOMRIGHT, 0, 0)

		--TreeHeaderSetup(node, control, name, open)
		local treeHeader = tree.templateInfo.ZO_SimpleArrowIconHeader
		treeHeader.setupFunction = function(node, control, name, open)
			control:SetDimensionConstraints(320, 26, 320, 26)
			control:SetMouseEnabled(false)
			control.icon:SetHidden(true)
			control.iconHighlight:SetHidden(true)

			--text--
			local text = control.text
			text:SetModifyTextType(MODIFY_TEXT_TYPE_UPPERCASE)
			text:SetText(name)
			text:SetSelected(true)
			text:SetVerticalAlignment(TEXT_ALIGN_CENTER)
			PP.Font(text, --[[Font]] PP.f.u67, 16, "outline", --[[Alpha]] nil, --[[Color]] 197, 194, 158, 1, --[[StyleColor]] 0, 0, 0, 0.8)
			PP.Anchor(text, --[[#1]] TOPLEFT, control, TOPLEFT, 20, 2, --[[#2]] true, BOTTOMRIGHT, control, BOTTOMRIGHT, 0, 0)
			text:SetMouseEnabled(false)
			text:SetPixelRoundingEnabled(false) -- Fix shaking when scrolling

			if control:GetNamedChild("Bg") then return end
			local bg = CreateControl("$(parent)Bg", control, CT_TEXTURE)
			bg:SetAnchorFill(control)
			bg:SetTexture("PerfectPixel/tex/GradientRight.dds")
			bg:SetColor(173/255, 166/255, 132/255, 0.4)
			bg:SetDrawLevel(0)
			bg:SetPixelRoundingEnabled(false) -- Fix shaking when scrolling
		end

		--TreeEntrySetup(node, control, data, open)
		local treeEntry = tree.templateInfo.ZO_QuestJournalNavigationEntry
		local existingSetupCallback = treeEntry.setupFunction
		treeEntry.setupFunction = function(node, control, data, open)
			existingSetupCallback(node, control, data, open)
			PP.Font(control, --[[Font]] PP.f.u67, 16, "outline")
			control:SetDimensions(290, 22)
			control:SetVerticalAlignment(TEXT_ALIGN_CENTER)
			control:SetPixelRoundingEnabled(false) -- Fix shaking when scrolling

			--icon--
			local icon = control:GetNamedChild("Icon")
			PP.Anchor(icon, --[[#1]] nil, nil, nil, -2, 0)
			icon:SetDimensions(22, 22)
			icon:SetPixelRoundingEnabled(false) -- Fix shaking when scrolling
		end

		local pool = treeEntry.objectPool

		local function treeEntrySetHandler(control)
			ZO_PreHookHandler(control, 'OnMouseEnter', function(self)
				if self:IsSelected() then return end
				self:SetColor(230/255, 230/255, 150/255, 1)
			end)
			ZO_PreHookHandler(control, 'OnMouseExit', function(self)
				if self:IsSelected() then return end
				self:SetColor(220/255, 216/255, 34/255, 1)	-- def_color = 220, 216, 34, 1.00
			end)
		end
		local exCustomFactoryBehavior = pool.customFactoryBehavior
		pool.customFactoryBehavior = function(control, ...)
			if exCustomFactoryBehavior then
				exCustomFactoryBehavior(control, ...)
			end
			treeEntrySetHandler(control)
		end
		for _, control in pairs(pool.m_Free) do
			treeEntrySetHandler(control)
		end
		for _, control in pairs(pool.m_Active) do
			treeEntrySetHandler(control)
		end

		questsKeyboard.listDirty = true
		end
	end
	local showOnMap = questsKeyboard.showOnMapKeybindButton
	if showOnMap then
		--shrink size of the keybind like at the keybind strip
		local nameLabel = showOnMap:GetNamedChild("NameLabel")
		local keyLabel = showOnMap:GetNamedChild("KeyLabel")
		if nameLabel then
			nameLabel:SetFont(PP.f.u67 .. "|18|outline")
		end
		if keyLabel then
			keyLabel:SetFont(PP.f.u67 .. "|18|outline")
		end
	end
end

local function StyleJournalLabel(label, size, outline)
	if not label then
		return
	end
	PP.Font(label, --[[Font]] PP.f.u67, size, outline, --[[Alpha]] nil, --[[Color]] nil, nil, nil, nil, --[[StyleColor]] 0, 0, 0, 0.5)
end

local function Edit_ZO_QuestJournal_ModeBar()
	-- Update 50: quests/rumors tabs live on ZO_QuestJournalModeBar, anchored to ZO_SharedRightPanelBackground.
	-- Buttons are created in ZO_QuestJournal_Keyboard:OnShowing, after PP.tabs has already run.
	local modeBar = ZO_QuestJournalModeBar
	if not modeBar or not ZO_QuestJournal_Keyboard then
		return
	end

	-- Scene group bar (QUESTS, lore, achievements) already occupies GuiRoot TOPRIGHT -30, 64.
	-- Keep this sub-mode bar in the journal panel header, under that row.
	local journalPanel = (ZO_QUEST_JOURNAL_QUESTS_KEYBOARD and ZO_QUEST_JOURNAL_QUESTS_KEYBOARD.control)
		or (ZO_QUEST_JOURNAL_RUMORS_KEYBOARD and ZO_QUEST_JOURNAL_RUMORS_KEYBOARD.control)
	if journalPanel then
		PP.Anchor(modeBar, --[[#1]] TOPRIGHT, journalPanel, TOPRIGHT, -24, 16)
	end
	modeBar:SetDrawLevel(2)
	local menuLayout = PP:GetLayout("menuBar", "menu")
	SecurePostHook(ZO_QuestJournal_Keyboard, "OnShowing", function()
		PP:RefreshStyle_MenuBar(modeBar, menuLayout)
	end)
end

local function StyleRumorNavigationTree(rumorsKeyboard, navContainer)
	local navigationTree = rumorsKeyboard.navigationTree
	if not navigationTree then
		return
	end

	navigationTree.defaultIndent = 50		--[[def (60)]]
	navigationTree.defaultSpacing = 0		--[[def (-10)]]
	navigationTree.width = 340			--[[def (300)]]
	navigationTree.exclusiveCloseNodeFunction = function(treeNode)
		treeNode:SetOpen(true, false)
	end

	local navScroll = navContainer and navContainer:GetNamedChild("Scroll")
	if navScroll then
		PP.Anchor(navScroll, --[[#1]] TOPLEFT, nil, TOPLEFT, 0, 0, --[[#2]] true, BOTTOMRIGHT, nil, BOTTOMRIGHT, 0, 0)
	end

	-- TreeHeaderSetup(node, control, data, open, userRequested)
	local treeHeader = navigationTree.templateInfo.ZO_StatusSimpleArrowIconHeader
	if treeHeader then
		local existingHeaderSetup = treeHeader.setupFunction
		treeHeader.setupFunction = function(node, control, data, open, userRequested)
			existingHeaderSetup(node, control, data, open, userRequested)
			control:SetDimensionConstraints(320, 26, 320, 26)
			control:SetMouseEnabled(false)
			if control.icon then
				control.icon:SetHidden(true)
			end
			if control.iconHighlight then
				control.iconHighlight:SetHidden(true)
			end

			local headerText = control.text
			if headerText then
				headerText:SetModifyTextType(MODIFY_TEXT_TYPE_UPPERCASE)
				headerText:SetText(data.name)
				headerText:SetSelected(true)
				headerText:SetVerticalAlignment(TEXT_ALIGN_CENTER)
				PP.Font(headerText, --[[Font]] PP.f.u67, 16, "outline", --[[Alpha]] nil, --[[Color]] 197, 194, 158, 1, --[[StyleColor]] 0, 0, 0, 0.8)
				PP.Anchor(headerText, --[[#1]] TOPLEFT, control, TOPLEFT, 28, 2, --[[#2]] true, BOTTOMRIGHT, control, BOTTOMRIGHT, 0, 0)
				headerText:SetMouseEnabled(false)
				headerText:SetPixelRoundingEnabled(false)
			end

			local headerStatusIcon = control.statusIcon or control:GetNamedChild("StatusIcon")
			if headerStatusIcon then
				headerStatusIcon:SetDimensions(18, 18)
				PP.Anchor(headerStatusIcon, --[[#1]] LEFT, control, LEFT, 4, 0)
				headerStatusIcon:SetPixelRoundingEnabled(false)
			end

			if control:GetNamedChild("Bg") then return end
			local headerBackground = CreateControl("$(parent)Bg", control, CT_TEXTURE)
			headerBackground:SetAnchorFill(control)
			headerBackground:SetTexture("PerfectPixel/tex/GradientRight.dds")
			headerBackground:SetColor(173/255, 166/255, 132/255, 0.4)
			headerBackground:SetDrawLevel(0)
			headerBackground:SetPixelRoundingEnabled(false)
		end
	end

	-- TreeEntrySetup(node, control, data, open)
	local treeEntry = navigationTree.templateInfo.ZO_QuestJournal_RumorNavigationEntry
	if not treeEntry then
		return
	end

	local existingEntrySetup = treeEntry.setupFunction
	treeEntry.setupFunction = function(node, control, data, open)
		existingEntrySetup(node, control, data, open)
		PP.Font(control, --[[Font]] PP.f.u67, 16, "outline")
		control:SetDimensions(290, 22)
		control:SetVerticalAlignment(TEXT_ALIGN_CENTER)
		control:SetPixelRoundingEnabled(false)

		local entryStatusIcon = control.statusIcon or control:GetNamedChild("StatusIcon")
		if entryStatusIcon then
			PP.Anchor(entryStatusIcon, --[[#1]] nil, nil, nil, -2, 0)
			entryStatusIcon:SetDimensions(22, 22)
			entryStatusIcon:SetPixelRoundingEnabled(false)
		end
	end

	local entryPool = treeEntry.objectPool
	if not entryPool then
		return
	end

	local function rumorTreeEntrySetHandler(control)
		ZO_PreHookHandler(control, "OnMouseEnter", function(self)
			if self:IsSelected() then return end
			self:SetColor(230/255, 230/255, 150/255, 1)
		end)
		ZO_PreHookHandler(control, "OnMouseExit", function(self)
			if self:IsSelected() then return end
			self:SetColor(220/255, 216/255, 34/255, 1)
		end)
	end
	local existingCustomFactoryBehavior = entryPool.customFactoryBehavior
	entryPool.customFactoryBehavior = function(control, ...)
		if existingCustomFactoryBehavior then
			existingCustomFactoryBehavior(control, ...)
		end
		rumorTreeEntrySetHandler(control)
	end
	for _, control in pairs(entryPool.m_Free) do
		rumorTreeEntrySetHandler(control)
	end
	for _, control in pairs(entryPool.m_Active) do
		rumorTreeEntrySetHandler(control)
	end

	rumorsKeyboard.listDirty = true
end

local function StyleRumorListRows(rumorList)
	local listStyleSavedVars = PP.savedVars.ListStyle
	-- Template height is ZO_QUEST_JOURNAL_RUMOR_ENTRY_HEIGHT_KEYBOARD (52). A shorter stride overlaps the rows.
	local rumorRowHeight = ZO_QUEST_JOURNAL_RUMOR_ENTRY_HEIGHT_KEYBOARD or 52

	local function OnCreateRumorRow(rumorRowControl)
		rumorRowControl:SetHeight(rumorRowHeight)
		local rowBackground = rumorRowControl:GetNamedChild("Bg")
		local rowHighlight = rumorRowControl:GetNamedChild("Highlight")
		if rowBackground then
			rowBackground:SetHidden(true)
		end
		if rowHighlight then
			rowHighlight:SetHidden(true)
		end

		local rumorNameLabel = rumorRowControl:GetNamedChild("Name")
		if rumorNameLabel then
			PP.Font(rumorNameLabel, --[[Font]] PP.f.u67, 16, "outline")
			rumorNameLabel:SetVerticalAlignment(TEXT_ALIGN_CENTER)
			PP.Anchor(rumorNameLabel, --[[#1]] TOPLEFT, rumorRowControl, TOPLEFT, 40, 0, --[[#2]] true, BOTTOMRIGHT, rumorRowControl, BOTTOMRIGHT, -16, 0)
		end

		local rumorStatusIcon = rumorRowControl:GetNamedChild("StatusIcon")
		if rumorStatusIcon and rumorNameLabel then
			rumorStatusIcon:SetDimensions(22, 22)
			PP.Anchor(rumorStatusIcon, --[[#1]] RIGHT, rumorNameLabel, LEFT, -4, 0)
			rumorStatusIcon:SetPixelRoundingEnabled(false)
		end

		PP:CreateBgToSlot(rumorRowControl)

		ZO_PostHookHandler(rumorRowControl, "OnMouseEnter", function(self)
			if self.backdrop then
				self.backdrop:SetCenterColor(unpack(listStyleSavedVars.list_skin_backdrop_hl_col))
			end
		end)
		ZO_PostHookHandler(rumorRowControl, "OnMouseExit", function(self)
			if self.backdrop then
				self.backdrop:SetCenterColor(unpack(listStyleSavedVars.list_skin_backdrop_col))
			end
		end)
	end

	-- SCROLL_LIST_UNIFORM is 1. Rumor rows are data type 1 (RUMOR_LIST_RUMOR_ENTRY_ID).
	local function OnUpdateRumorRow(rumorRowControl)
		rumorRowControl:SetHeight(rumorRowHeight)
	end
	PP.PostHooksSetupCallback(rumorList, 1, 1, OnCreateRumorRow, OnUpdateRumorRow)

	local rumorDataType = ZO_ScrollList_GetDataTypeTable(rumorList, 1)
	if rumorDataType then
		rumorDataType.height = rumorRowHeight
		local rumorRowPool = rumorDataType.pool
		if rumorRowPool then
			for _, rumorRowControl in pairs(rumorRowPool.m_Free) do
				OnCreateRumorRow(rumorRowControl)
			end
			for _, rumorRowControl in pairs(rumorRowPool.m_Active) do
				OnCreateRumorRow(rumorRowControl)
			end
		end
	end
	rumorList.uniformControlHeight = rumorRowHeight
	rumorList.highlightTemplateOrFunction = nil
end

local function StyleRumorDetails(rumorsKeyboard)
	StyleJournalLabel(rumorsKeyboard.rumorDetailsTitleLabel, 22, "outline")
	StyleJournalLabel(rumorsKeyboard.rumorInfoBGTitle, 18, "outline")
	StyleJournalLabel(rumorsKeyboard.rumorInfoOutcomeTitle, 18, "outline")
	StyleJournalLabel(rumorsKeyboard.rumorInfoBGTextLabel, 16, "soft-shadow-thin")
	StyleJournalLabel(rumorsKeyboard.rumorInfoOutcomeLabel, 16, "soft-shadow-thin")
	StyleJournalLabel(rumorsKeyboard.rumorListDescription, 16, "soft-shadow-thin")

	local backLabel = rumorsKeyboard.backLabel
	if backLabel then
		StyleJournalLabel(backLabel.text or backLabel:GetNamedChild("Text"), 16, "outline")
	end

	local cluePool = rumorsKeyboard.cluePool
	if not cluePool then
		return
	end

	local existingClueFactoryBehavior = cluePool.customFactoryBehavior
	cluePool.customFactoryBehavior = function(clueControl, ...)
		if existingClueFactoryBehavior then
			existingClueFactoryBehavior(clueControl, ...)
		end
		StyleJournalLabel(clueControl:GetNamedChild("Name"), 16, "outline")
	end
end

local function Edit_ZO_QuestJournal_Rumors()
	local rumorsKeyboard = ZO_QUEST_JOURNAL_RUMORS_KEYBOARD
	if not rumorsKeyboard or not rumorsKeyboard.control then
		return
	end

	local rumorCount = rumorsKeyboard.rumorCountLabel
	if rumorCount then
		PP.Anchor(rumorCount, --[[#1]] TOPLEFT, nil, TOPLEFT, 0, -6)
		PP.Font(rumorCount, --[[Font]] PP.f.u67, 24, "outline")
	end

	local navContainer = rumorsKeyboard.navigationContainer
	if navContainer then
		PP.ScrollBar(navContainer, --[[sb_c]] JOURNAL_SCROLLBAR_SB[1], JOURNAL_SCROLLBAR_SB[2], JOURNAL_SCROLLBAR_SB[3], JOURNAL_SCROLLBAR_SB[4], --[[bd_c]] JOURNAL_SCROLLBAR_BD[1], JOURNAL_SCROLLBAR_BD[2], JOURNAL_SCROLLBAR_BD[3], JOURNAL_SCROLLBAR_BD[4], false)
		ZO_Scroll_SetMaxFadeDistance(navContainer, 10)
	end

	if SV and SV.largeQuestList then
		StyleRumorNavigationTree(rumorsKeyboard, navContainer)
	end

	local rumorList = rumorsKeyboard.rumorList
	if rumorList then
		PP.ScrollBar(rumorList, --[[sb_c]] JOURNAL_SCROLLBAR_SB[1], JOURNAL_SCROLLBAR_SB[2], JOURNAL_SCROLLBAR_SB[3], JOURNAL_SCROLLBAR_SB[4], --[[bd_c]] JOURNAL_SCROLLBAR_BD[1], JOURNAL_SCROLLBAR_BD[2], JOURNAL_SCROLLBAR_BD[3], JOURNAL_SCROLLBAR_BD[4], false)
		ZO_Scroll_SetMaxFadeDistance(rumorList, PP.savedVars.ListStyle.list_fade_distance)
		StyleRumorListRows(rumorList)
	end

	local rumorInfoContainer = rumorsKeyboard.rumorInfoContainer
	if rumorInfoContainer then
		PP.ScrollBar(rumorInfoContainer, --[[sb_c]] JOURNAL_SCROLLBAR_SB[1], JOURNAL_SCROLLBAR_SB[2], JOURNAL_SCROLLBAR_SB[3], JOURNAL_SCROLLBAR_SB[4], --[[bd_c]] JOURNAL_SCROLLBAR_BD[1], JOURNAL_SCROLLBAR_BD[2], JOURNAL_SCROLLBAR_BD[3], JOURNAL_SCROLLBAR_BD[4], false)
	end

	local rumorClueContainer = rumorsKeyboard.rumorClueContainer
	if rumorClueContainer then
		PP.ScrollBar(rumorClueContainer, --[[sb_c]] JOURNAL_SCROLLBAR_SB[1], JOURNAL_SCROLLBAR_SB[2], JOURNAL_SCROLLBAR_SB[3], JOURNAL_SCROLLBAR_SB[4], --[[bd_c]] JOURNAL_SCROLLBAR_BD[1], JOURNAL_SCROLLBAR_BD[2], JOURNAL_SCROLLBAR_BD[3], JOURNAL_SCROLLBAR_BD[4], false)
	end

	StyleRumorDetails(rumorsKeyboard)
end

local function Edit_ZO_Cadwell()
	--Antiquities--ZO_Cadwell--------------------------------------------------------------------
	--cadwellsAlmanac--ZO_Cadwell--------------------------------------------------------------------
	--Antiquities--------------------------------------------------------------------
	--PTS API101043 2024-08-07
	local antiquityJournalKeyboardObj = ANTIQUITY_JOURNAL_KEYBOARD  -- scenes[2].gVar --ANTIQUITY_JOURNAL_KEYBOARD
	PP.onDeferredInitCheck(antiquityJournalKeyboardObj, function()
		PP.ScrollBar(antiquityJournalKeyboardObj.contentList, --[[sb_c]] 180, 180, 180, 0.7, --[[bd_c]] 20, 20, 20, 0.7, false) --ZO_AntiquityJournal_Keyboard_TopLevelContentsContentList
		--API101045 2025-01-17 Add missing progressbar UI styling
		PP.Bar(antiquityJournalKeyboardObj.categoryProgress, 14, 15)
	end, nil) -- ZO_AntiquityJournal_Keyboard:OnDeferredInitialize
end

local function Edit_ZO_Achievements()
	--achievements--ZO_Achievements--------------------------------------------------------------------

	--PTS API101043 2024-08-07
	local achievementsObj = ACHIEVEMENTS  -- scenes[5].gVar --ACHIEVEMENTS
	PP.onDeferredInitCheck(achievementsObj, function()
		PP.ScrollBar(ZO_AchievementsContentsCategories, --[[sb_c]] 180, 180, 180, 0.7, --[[bd_c]] 20, 20, 20, 0.7, false)
		PP.ScrollBar(achievementsObj.contentList, --[[sb_c]] 180, 180, 180, 0.7, --[[bd_c]] 20, 20, 20, 0.7, false)
		PP.ScrollBar(GetControl(achievementsObj.summaryInset, "ProgressBars"), --[[sb_c]] 180, 180, 180, 0.7, --[[bd_c]] 20, 20, 20, 0.7, false)

		--API101045 2025-01-17 Add missing progressbar UI styling
		PP.Bar(achievementsObj.categoryProgress, 14, 15)
		PP.Bars(achievementsObj.summaryProgressBarsScrollChild, false, 14, 15, nil, nil, true)

	end, nil)

	--achievement "most recent" icons
	-- local recentAchievementIconTemplate = "ZO_IconAchievement"
	-- for i=1, 6, 1 do
		-- local recentAchievementIcon = GetControl(recentAchievementIconTemplate .. tostring(i))
		-- if recentAchievementIcon ~= nil then
			-- recentAchievementIcon:SetDrawTier(DT_MEDIUM)
			-- recentAchievementIcon:SetDrawLayer(DL_CONTROLS)
			-- recentAchievementIcon:SetDrawLevel(1)
		-- end
	-- end
end

local function Edit_ZO_LoreLibrary()
	--loreLibrary--ZO_LoreLibrary----------------------------------------------------------------------
	local loreLibraryObj = LORE_LIBRARY  -- scenes[4].gVar --LORE_LIBRARY
	PP.ScrollBar(loreLibraryObj.navigationTree.scrollControl, --[[sb_c]] 180, 180, 180, 0.7, --[[bd_c]] 20, 20, 20, 0.7, false) --ZO_LoreLibraryNavigationContainer
	PP.ScrollBar(loreLibraryObj.list.list, --[[sb_c]] 180, 180, 180, 0.7, --[[bd_c]] 20, 20, 20, 0.7, false)
    ZO_Scroll_SetMaxFadeDistance(ZO_LoreLibraryList, PP.savedVars.ListStyle.list_fade_distance)
    ZO_Scroll_SetMaxFadeDistance(ZO_LoreLibraryNavigationContainer, PP.savedVars.ListStyle.list_fade_distance)
end

local function Edit_ZO_Leaderboard()
	--leaderboards--ZO_Leaderboards--------------------------------------------------------------------
	PP.ScrollBar(ZO_LeaderboardsList, --[[sb_c]] 180, 180, 180, 0.7, --[[bd_c]] 20, 20, 20, 0.7, false)
end

local function EditElements()
	Edit_ZO_QuestJournal()
	Edit_ZO_QuestJournal_ModeBar()
	Edit_ZO_QuestJournal_Rumors()
	Edit_ZO_Cadwell()
	Edit_ZO_Achievements()
	Edit_ZO_LoreLibrary()
	Edit_ZO_Leaderboard()
end

local function EditQuestJournalSceneFootprint(scene)
	-- Update 50: quest/rumor UI is on child panels with their own ZO_RightPanelFootPrint (GuiRoot anchors).
	-- PP must style those panels like the pre-U50 single ZO_QuestJournal top level.
	local questsPanel = ZO_QUEST_JOURNAL_QUESTS_KEYBOARD and ZO_QUEST_JOURNAL_QUESTS_KEYBOARD.control
	local rumorsPanel = ZO_QUEST_JOURNAL_RUMORS_KEYBOARD and ZO_QUEST_JOURNAL_RUMORS_KEYBOARD.control
	if questsPanel then
		EditScene(scene, questsPanel)
	end
	if rumorsPanel then
		EditScene(scene, rumorsPanel)
	end
end

PP.journalSceneGroup = function()
	-- local function achievementsProgressBars()
	-- 	PP.Bars(ACHIEVEMENTS.summaryProgressBarsScrollChild, false, nil, nil, nil, nil, true)
	-- end

	for _, scene in ipairs(DEFAULT_JOURNAL_SCENES) do
		if scene.gVar == QUEST_JOURNAL_KEYBOARD then
			EditQuestJournalSceneFootprint(scene.scene)
		else
			EditScene(scene.scene, scene.gVar.control)
		end
	end

	EditElements()
end