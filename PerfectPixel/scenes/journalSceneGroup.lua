PP.journalSceneGroup = function()
--===============================================================================================--
	local SV_VER		= 0.1
	local DEF = {
		largeQuestList	= true,
		questListBG		= false,
	}
	local SV = ZO_SavedVars:NewAccountWide(PP.ADDON_NAME, SV_VER, "JournalScene", DEF, GetWorldName())
	---------------------------------------------
	table.insert(PP.optionsData,
	{	type				= "submenu",
		name				= GetString(PP_LAM_SCENE_JOURNAL),
		controls    = {
		  {	type				= "checkbox",
			name				= GetString(PP_LAM_SCENE_JOURNAL_QUEST_LARGE_LIST),
			getFunc				= function() return SV.largeQuestList end,
			setFunc				= function(value) SV.largeQuestList = value end,
			default				= DEF.largeQuestList,
			requiresReload		= true,
		  },
		  {	type				= "checkbox",
			 name				= GetString(PP_LAM_SCENE_JOURNAL_QUEST_BG),
			getFunc				= function() return SV.questListBG end,
			setFunc				= function(value) SV.questListBG = value end,
			default				= DEF.questListBG,
			requiresReload		= true,
		  },
		},
	})
--===============================================================================================--
--questJournal--ZO_QuestJournal--------------------------------------------------------------------
	local questJournalScene = SCENE_MANAGER:GetScene('questJournal')
	
	questJournalScene:RemoveFragmentGroup(FRAGMENT_GROUP.FRAME_TARGET_STANDARD_RIGHT_PANEL)
	questJournalScene:RemoveFragment(FRAME_EMOTE_FRAGMENT_JOURNAL)
	questJournalScene:RemoveFragment(RIGHT_BG_FRAGMENT)
	questJournalScene:RemoveFragment(TREE_UNDERLAY_FRAGMENT)
	questJournalScene:RemoveFragment(TITLE_FRAGMENT)
	questJournalScene:RemoveFragment(JOURNAL_TITLE_FRAGMENT)
	questJournalScene:RemoveFragment(KEYBIND_STRIP_MUNGE_BACKDROP_FRAGMENT)

	questJournalScene:RegisterCallback("StateChange", function(oldState, newState)
		if newState == SCENE_SHOWING then
			PP.Anchor(ZO_MainMenuSceneGroupBar, --[[#1]] TOPRIGHT, GuiRoot, TOPRIGHT, -30, 64)
		elseif newState == SCENE_HIDDEN then
			PP.Anchor(ZO_MainMenuSceneGroupBar, --[[#1]] RIGHT, GuiRoot, RIGHT, -40, -340)
		end
	end)

	PP.mainBackdrop(ZO_QuestJournal,		'questJournal', --[[backdrop]] TOPLEFT, BOTTOMRIGHT, -10, -10, 0, 10,	--[[tex]] PP.t.bg1, 8, 1, --[[bd]] 10, 10, 10, .8, --[[edge]] 0, 0, 0, 1, --[[texture]] true, .5)
	PP.mainBackdrop(ZO_KeybindStripControl,	'questJournal', --[[backdrop]] TOPLEFT, BOTTOMRIGHT, -6, 0, 2, 6,		--[[tex]] PP.t.bg1, 8, 1, --[[bd]] 10, 10, 10, .6, --[[edge]] 0, 0, 0, 1, --[[texture]] false, 0)
	PP.ScrollBar(ZO_QuestJournalNavigationContainer, --[[sb_c]] 180, 180, 180, .7, --[[bd_c]] 20, 20, 20, .7, --[[edge]] 40, 40, 40, .9)

	if SV.questListBG then
		PP.ListBackdrop(ZO_QuestJournalNavigationContainer, -3, -3, -1, 3, --[[tex]] nil, 8, 0, --[[bd]] 5, 5, 5, .6, --[[edge]] 30, 30, 30, .6)
	end

	PP.Anchor(ZO_QuestJournal, --[[#1]] TOPRIGHT, GuiRoot, TOPRIGHT, 0, 120, --[[#2]] true, BOTTOMRIGHT, GuiRoot, BOTTOMRIGHT,	1, -70)
	PP.Anchor(ZO_QuestJournalQuestCount, --[[#1]] TOPLEFT, nil, TOPLEFT, 0, -6)
	PP.Anchor(ZO_QuestJournalNavigationContainerScroll, --[[#1]] TOPLEFT, nil, TOPLEFT, 5, 0, --[[#2]] true, BOTTOMRIGHT, nil, BOTTOMRIGHT, 0, 0)
	
	ZO_Scroll_SetMaxFadeDistance(ZO_QuestJournalNavigationContainer, 10)

	if SV.largeQuestList then
		PP.Anchor(ZO_QuestJournalNavigationContainerScroll, --[[#1]] TOPLEFT, nil, TOPLEFT, -10, 0, --[[#2]] true, BOTTOMRIGHT, nil, BOTTOMRIGHT, 0, 0)

		QUEST_JOURNAL_KEYBOARD.navigationTree:SetExclusive(false)
		QUEST_JOURNAL_KEYBOARD.navigationTree.defaultIndent = 46
		QUEST_JOURNAL_KEYBOARD.navigationTree.defaultSpacing = -24
		QUEST_JOURNAL_KEYBOARD.navigationTree.width = 335

		QUEST_JOURNAL_KEYBOARD.navigationTree.templateInfo.ZO_QuestJournalHeader.objectPool:SetCustomAcquireBehavior(function(control)
			local text = control:GetNamedChild("Text")
			local icon = control:GetNamedChild("Icon")
			control:SetMouseEnabled(false)
			control:SetAlpha(.9)
			if text then
				PP.Font(text, --[[Font]] PP.f.u67, 18, "outline", --[[Alpha]] nil, --[[Color]] nil, nil, nil, nil, --[[StyleColor]] 0, 0, 0, .8)
				text:SetMouseEnabled(false)
			end
			if icon then
				icon:SetHidden(true)
			end
			if control.node and not control.node:IsOpen() then
				control.node:SetOpen(true)
			end
		end)
		QUEST_JOURNAL_KEYBOARD.navigationTree.templateInfo.ZO_QuestJournalNavigationEntry.objectPool:SetCustomAcquireBehavior(function(control)
			if control then
				PP.Font(control, --[[Font]] PP.f.u67, 16, "outline", --[[Alpha]] nil, --[[Color]] nil, nil, nil, nil, --[[StyleColor]] 0, 0, 0, .5)
				control:SetWidth(280)
			end
			
		end)
		QUEST_JOURNAL_KEYBOARD:RefreshQuestList()
	end
--cadwellsAlmanac--ZO_Cadwell--------------------------------------------------------------------
	local cadwellsAlmanacScene = SCENE_MANAGER:GetScene('cadwellsAlmanac')
	
	cadwellsAlmanacScene:RemoveFragmentGroup(FRAGMENT_GROUP.FRAME_TARGET_STANDARD_RIGHT_PANEL)
	cadwellsAlmanacScene:RemoveFragment(FRAME_EMOTE_FRAGMENT_JOURNAL)
	cadwellsAlmanacScene:RemoveFragment(RIGHT_BG_FRAGMENT)
	cadwellsAlmanacScene:RemoveFragment(TREE_UNDERLAY_FRAGMENT)
	cadwellsAlmanacScene:RemoveFragment(TITLE_FRAGMENT)
	cadwellsAlmanacScene:RemoveFragment(JOURNAL_TITLE_FRAGMENT)
	cadwellsAlmanacScene:RemoveFragment(KEYBIND_STRIP_MUNGE_BACKDROP_FRAGMENT)

	cadwellsAlmanacScene:RegisterCallback("StateChange", function(oldState, newState)
		if newState == SCENE_SHOWING then
			PP.Anchor(ZO_MainMenuSceneGroupBar, --[[#1]] TOPRIGHT, GuiRoot, TOPRIGHT, -30, 64)
		elseif newState == SCENE_HIDDEN then
			PP.Anchor(ZO_MainMenuSceneGroupBar, --[[#1]] RIGHT, GuiRoot, RIGHT, -40, -340)
		end
	end)

	PP.mainBackdrop(ZO_Cadwell,		'cadwellsAlmanac', --[[backdrop]] TOPLEFT, BOTTOMRIGHT, -10, -10, 0, 10,	--[[tex]] PP.t.bg1, 8, 1, --[[bd]] 10, 10, 10, .8, --[[edge]] 0, 0, 0, 1, --[[texture]] true, .5)
	PP.mainBackdrop(ZO_KeybindStripControl,	'cadwellsAlmanac', --[[backdrop]] TOPLEFT, BOTTOMRIGHT, -6, 0, 2, 6,		--[[tex]] PP.t.bg1, 8, 1, --[[bd]] 10, 10, 10, .6, --[[edge]] 0, 0, 0, 1, --[[texture]] false, 0)
	
	PP.Anchor(ZO_Cadwell, --[[#1]] TOPRIGHT, GuiRoot, TOPRIGHT, 0, 120, --[[#2]] true, BOTTOMRIGHT, GuiRoot, BOTTOMRIGHT,	1, -70)


--loreLibrary--ZO_LoreLibrary----------------------------------------------------------------------
	local loreLibraryScene = SCENE_MANAGER:GetScene('loreLibrary')

	loreLibraryScene:RegisterCallback("StateChange", function(oldState, newState)
		if newState == SCENE_SHOWING then
			PP.Anchor(ZO_MainMenuSceneGroupBar, --[[#1]] TOPRIGHT, GuiRoot, TOPRIGHT, -30, 64)
		elseif newState == SCENE_HIDDEN then
			PP.Anchor(ZO_MainMenuSceneGroupBar, --[[#1]] RIGHT, GuiRoot, RIGHT, -40, -340)
		end
	end)

	loreLibraryScene:RemoveFragmentGroup(FRAGMENT_GROUP.FRAME_TARGET_STANDARD_RIGHT_PANEL)
	loreLibraryScene:RemoveFragment(FRAME_EMOTE_FRAGMENT_JOURNAL)
	loreLibraryScene:RemoveFragment(RIGHT_BG_FRAGMENT)
	loreLibraryScene:RemoveFragment(TREE_UNDERLAY_FRAGMENT)
	loreLibraryScene:RemoveFragment(TITLE_FRAGMENT)
	loreLibraryScene:RemoveFragment(JOURNAL_TITLE_FRAGMENT)
	loreLibraryScene:RemoveFragment(KEYBIND_STRIP_MUNGE_BACKDROP_FRAGMENT)

	PP.mainBackdrop(ZO_LoreLibrary,			'loreLibrary', --[[backdrop]] TOPLEFT, BOTTOMRIGHT, -10, -10, 0, 10,	--[[tex]] PP.t.bg1, 8, 1, --[[bd]] 10, 10, 10, .8, --[[edge]] 0, 0, 0, 1, --[[texture]] true, .5)
	PP.mainBackdrop(ZO_KeybindStripControl,	'loreLibrary', --[[backdrop]] TOPLEFT, BOTTOMRIGHT, -6, 0, 2, 6,		--[[tex]] PP.t.bg1, 8, 1, --[[bd]] 10, 10, 10, .6, --[[edge]] 0, 0, 0, 1, --[[texture]] false, 0)
	
	PP.Anchor(ZO_LoreLibrary, --[[#1]] TOPRIGHT, GuiRoot, TOPRIGHT,	0, 120, --[[#2]] true, BOTTOMRIGHT, GuiRoot, BOTTOMRIGHT, 1, -70)

--achievements--ZO_Achievements--------------------------------------------------------------------
	local achievementsScene = SCENE_MANAGER:GetScene('achievements')

	achievementsScene:RegisterCallback("StateChange", function(oldState, newState)
		if newState == SCENE_SHOWING then
			PP.Anchor(ZO_MainMenuSceneGroupBar, --[[#1]] TOPRIGHT, GuiRoot, TOPRIGHT, -30, 64)
		elseif newState == SCENE_HIDDEN then
			PP.Anchor(ZO_MainMenuSceneGroupBar, --[[#1]] RIGHT, GuiRoot, RIGHT, -40, -340)
		end
	end)

	achievementsScene:RemoveFragmentGroup(FRAGMENT_GROUP.FRAME_TARGET_STANDARD_RIGHT_PANEL)
	achievementsScene:RemoveFragment(FRAME_EMOTE_FRAGMENT_JOURNAL)
	achievementsScene:RemoveFragment(RIGHT_BG_FRAGMENT)
	achievementsScene:RemoveFragment(TREE_UNDERLAY_FRAGMENT)
	achievementsScene:RemoveFragment(TITLE_FRAGMENT)
	achievementsScene:RemoveFragment(JOURNAL_TITLE_FRAGMENT)
	achievementsScene:RemoveFragment(KEYBIND_STRIP_MUNGE_BACKDROP_FRAGMENT)

	PP.mainBackdrop(ZO_Achievements,		'achievements', --[[backdrop]] TOPLEFT, BOTTOMRIGHT, -10, -10, 0, 10,	--[[tex]] PP.t.bg1, 8, 1, --[[bd]] 10, 10, 10, .8, --[[edge]] 0, 0, 0, 1, --[[texture]] true, .5)
	PP.mainBackdrop(ZO_KeybindStripControl,	'achievements', --[[backdrop]] TOPLEFT, BOTTOMRIGHT, -6, 0, 2, 6,		--[[tex]] PP.t.bg1, 8, 1, --[[bd]] 10, 10, 10, .6, --[[edge]] 0, 0, 0, 1, --[[texture]] false, 0)
	
	PP.Anchor(ZO_Achievements, --[[#1]] TOPRIGHT,	GuiRoot, TOPRIGHT,	0, 120,	--[[#2]] true, BOTTOMRIGHT,	GuiRoot, BOTTOMRIGHT,	1, -70)

--leaderboards--ZO_Leaderboards--------------------------------------------------------------------
	local leaderboardsScene = SCENE_MANAGER:GetScene('leaderboards')

	leaderboardsScene:RegisterCallback("StateChange", function(oldState, newState)
		if newState == SCENE_SHOWING then
			PP.Anchor(ZO_MainMenuSceneGroupBar, --[[#1]] TOPRIGHT, GuiRoot, TOPRIGHT, -30, 64)
		elseif newState == SCENE_HIDDEN then
			PP.Anchor(ZO_MainMenuSceneGroupBar, --[[#1]] RIGHT, GuiRoot, RIGHT, -40, -340)
		end
	end)

	leaderboardsScene:RemoveFragmentGroup(FRAGMENT_GROUP.FRAME_TARGET_STANDARD_RIGHT_PANEL)
	leaderboardsScene:RemoveFragment(FRAME_EMOTE_FRAGMENT_JOURNAL)
	leaderboardsScene:RemoveFragment(RIGHT_BG_FRAGMENT)
	leaderboardsScene:RemoveFragment(TREE_UNDERLAY_FRAGMENT)
	leaderboardsScene:RemoveFragment(TITLE_FRAGMENT)
	leaderboardsScene:RemoveFragment(JOURNAL_TITLE_FRAGMENT)
	leaderboardsScene:RemoveFragment(KEYBIND_STRIP_MUNGE_BACKDROP_FRAGMENT)

	PP.mainBackdrop(ZO_Leaderboards,		'leaderboards', --[[backdrop]] TOPLEFT, BOTTOMRIGHT, -10, -10, 0, 10,	--[[tex]] PP.t.bg1, 8, 1, --[[bd]] 10, 10, 10, .8, --[[edge]] 0, 0, 0, 1, --[[texture]] true, .5)
	PP.mainBackdrop(ZO_KeybindStripControl,	'leaderboards', --[[backdrop]] TOPLEFT, BOTTOMRIGHT, -6, 0, 2, 6,		--[[tex]] PP.t.bg1, 8, 1, --[[bd]] 10, 10, 10, .6, --[[edge]] 0, 0, 0, 1, --[[texture]] false, 0)
	
	PP.Anchor(ZO_Leaderboards, --[[#1]] TOPRIGHT,	GuiRoot, TOPRIGHT,	0, 120,	--[[#2]] true, BOTTOMRIGHT,	GuiRoot, BOTTOMRIGHT,	1, -70)





end



