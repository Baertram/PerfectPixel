local PP = PP ---@class PP
local removeFragmentsFromScene = PP.removeFragmentsFromScene

PP.journalSceneGroup = function()
	--===============================================================================================--
	local SV_VER		= 0.4
	local DEF = {
		largeQuestList	= true,
	}
	local SV = ZO_SavedVars:NewAccountWide(PP.ADDON_NAME, SV_VER, "JournalScene", DEF, GetWorldName())
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
	--===============================================================================================--
	local function achievementsProgressBars()
		PP.Bars(ACHIEVEMENTS.summaryProgressBarsScrollChild, false, nil, nil, nil, nil, true)
	end
	local scenes = {
		{ scene = QUEST_JOURNAL_SCENE,							gVar = QUEST_JOURNAL_KEYBOARD,		},
		{ scene = ANTIQUITY_JOURNAL_KEYBOARD_SCENE,				gVar = ANTIQUITY_JOURNAL_KEYBOARD,	},
		{ scene = SCENE_MANAGER:GetScene('cadwellsAlmanac'),	gVar = CADWELLS_ALMANAC,			},
		{ scene = LORE_LIBRARY_SCENE,							gVar = LORE_LIBRARY,				},
		{ scene = SCENE_MANAGER:GetScene('achievements'),		gVar = ACHIEVEMENTS,				--[[sceneShowCallback = achievementsProgressBars]]},
		{ scene = LEADERBOARDS_SCENE,							gVar = LEADERBOARDS,				},
	}
	local fragments	= { FRAME_PLAYER_FRAGMENT, RIGHT_BG_FRAGMENT, TREE_UNDERLAY_FRAGMENT, TITLE_FRAGMENT, JOURNAL_TITLE_FRAGMENT, }
	-- local scenesShown = {}
	for _, sceneInfo in ipairs(scenes) do
		local scene = sceneInfo.scene
		local gVar = sceneInfo.gVar
		-- local filter 		= 		gVar.filter or gVar.categoryFilter
		-- local progressBar   = 		gVar.categoryProgress
		-- local sceneShowCallback = 	scenes[i].sceneShowCallback

		removeFragmentsFromScene(scene, fragments)

		local tlc	= gVar.control
		-- local list	= gVar.list

		PP:CreateBackground(tlc, --[[#1]] nil, nil, nil, -10, -10, --[[#2]] nil, nil, nil, 0, 10)
		PP.Anchor(tlc, --[[#1]] TOPRIGHT, GuiRoot, TOPRIGHT, 0, 120, --[[#2]] true, BOTTOMRIGHT, GuiRoot, BOTTOMRIGHT, 0, -70)

		-- PP.Anchor(list, --[[#1]] nil, nil, nil, 0, 3, --[[#2]] true, nil, nil, nil, 0, 0)
		-- PP.ScrollBar(list,	--[[sb_c]] 180, 180, 180, .7, --[[bd_c]] 20, 20, 20, .7, false)
		-- ZO_ScrollList_Commit(list)
		-- if progressBar then
		-- PP.Bar(progressBar, --[[h]] 14, --[[f]] 15, 255, nil)
		-- end
		-- if filter then
		-- Change the drawTier of the filter dropdown boxes so they get overlayed by the background backdrop
		-- filter:SetDrawTier(DT_MEDIUM)
		-- filter:SetDrawLayer(DL_TEXT)
		-- filter:SetDrawLevel(1)
		-- end

		-- if sceneShowCallback ~= nil then
		-- scene:RegisterCallback("StateChange", function(oldState, newState)
		-- if newState == SCENE_SHOWN and not scenesShown[scene] then
		-- sceneShowCallback()
		-- scenesShown[scene] = true
		-- end
		-- end)
		-- end
	end

	--questJournal--ZO_QuestJournal--------------------------------------------------------------------
	PP.ScrollBar(ZO_QuestJournalNavigationContainer, --[[sb_c]] 180, 180, 180, 0.7, --[[bd_c]] 20, 20, 20, 0.7, false)
	PP.Anchor(ZO_QuestJournalQuestCount, --[[#1]] TOPLEFT, nil, TOPLEFT, 0, -6)
	PP.Anchor(ZO_QuestJournalNavigationContainerScroll, --[[#1]] TOPLEFT, nil, TOPLEFT, 5, 0, --[[#2]] true, BOTTOMRIGHT, nil, BOTTOMRIGHT, 0, 0)
	PP.Font(ZO_QuestJournalQuestCount, --[[Font]] PP.f.u67, 24, "outline", --[[Alpha]] nil, --[[Color]] nil, nil, nil, nil, --[[StyleColor]] 0, 0, 0, 0.5)
	ZO_Scroll_SetMaxFadeDistance(ZO_QuestJournalNavigationContainer, 10)

	if SV.largeQuestList then
		local questJournalKeyboardObj = scenes[1].gVar --QUEST_JOURNAL_KEYBOARD
		local tree = questJournalKeyboardObj.navigationTree
		tree.defaultIndent = 50		--[[def (40)]]
		tree.defaultSpacing = 0		--[[def (-10)]]
		tree.width = 340			--[[def (300)]]
		-- tree:SetExclusive(false) >> breaks the game
		tree.exclusiveCloseNodeFunction = function(treeNode)
			treeNode:SetOpen(true, false)
		end

		PP.Anchor(ZO_QuestJournalNavigationContainerScroll, --[[#1]] TOPLEFT, nil, TOPLEFT, 0, 0, --[[#2]] true, BOTTOMRIGHT, nil, BOTTOMRIGHT, 0, 0)

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
			PP.Font(control, --[[Font]] PP.f.u67, 16, "outline", --[[Alpha]] nil, --[[Color]] nil, nil, nil, nil, --[[StyleColor]] 0, 0, 0, 0.5)
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

		questJournalKeyboardObj.listDirty = true
	end

	--Antiquities--ZO_Cadwell--------------------------------------------------------------------
	--cadwellsAlmanac--ZO_Cadwell--------------------------------------------------------------------
	--Antiquities--------------------------------------------------------------------
	--PTS API101043 2024-08-07
	local antiquityJournalKeyboardObj = scenes[2].gVar --ANTIQUITY_JOURNAL_KEYBOARD
	PP.onDeferredInitCheck(antiquityJournalKeyboardObj, function()
		PP.ScrollBar(antiquityJournalKeyboardObj.contentList, --[[sb_c]] 180, 180, 180, 0.7, --[[bd_c]] 20, 20, 20, 0.7, false) --ZO_AntiquityJournal_Keyboard_TopLevelContentsContentList
		--API101045 2025-01-17 Add missing progressbar UI styling
		PP.Bar(antiquityJournalKeyboardObj.categoryProgress, 14, 15)
	end, nil) -- ZO_AntiquityJournal_Keyboard:OnDeferredInitialize

--loreLibrary--ZO_LoreLibrary----------------------------------------------------------------------
	local loreLibraryObj = scenes[4].gVar --LORE_LIBRARY
	PP.ScrollBar(loreLibraryObj.navigationTree.scrollControl, --[[sb_c]] 180, 180, 180, 0.7, --[[bd_c]] 20, 20, 20, 0.7, false) --ZO_LoreLibraryNavigationContainer
	PP.ScrollBar(loreLibraryObj.list.list, --[[sb_c]] 180, 180, 180, 0.7, --[[bd_c]] 20, 20, 20, 0.7, false)


--achievements--ZO_Achievements--------------------------------------------------------------------

	--PTS API101043 2024-08-07
	local achievementsObj = scenes[5].gVar --ACHIEVEMENTS
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


--leaderboards--ZO_Leaderboards--------------------------------------------------------------------
	PP.ScrollBar(ZO_LeaderboardsList, --[[sb_c]] 180, 180, 180, 0.7, --[[bd_c]] 20, 20, 20, 0.7, false)
end