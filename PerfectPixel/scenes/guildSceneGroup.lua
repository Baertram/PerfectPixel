PP.guildSceneGroup = function()

	PP.Anchor(ZO_GuildSelector, --[[#1]] BOTTOMLEFT, ZO_GuildHome, TOPLEFT, -70, -5)
	PP.Font(ZO_GuildSelectorComboBoxSelectedItemText, --[[Font]] PP.f.u67, 30, "outline", --[[Alpha]] .9, --[[Color]] nil, nil, nil, nil, --[[StyleColor]] 0, 0, 0, .8)
	ZO_GuildSelectorDivider:SetHidden(true)

--guildHome--ZO_GuildHome--------------------------------------------------------------------
	local guildHomeScene = SCENE_MANAGER:GetScene('guildHome')
	
	guildHomeScene:RemoveFragmentGroup(FRAGMENT_GROUP.FRAME_TARGET_STANDARD_RIGHT_PANEL)
	guildHomeScene:RemoveFragment(FRAME_EMOTE_FRAGMENT_SOCIAL)
	guildHomeScene:RemoveFragment(RIGHT_BG_FRAGMENT)
	guildHomeScene:RemoveFragment(TREE_UNDERLAY_FRAGMENT)
	guildHomeScene:RemoveFragment(KEYBIND_STRIP_MUNGE_BACKDROP_FRAGMENT)

	guildHomeScene:RegisterCallback("StateChange", function(oldState, newState)
		if newState == SCENE_SHOWING then
			PP.Anchor(ZO_MainMenuSceneGroupBar, --[[#1]] TOPRIGHT, GuiRoot, TOPRIGHT, -30, 64)
		elseif newState == SCENE_HIDDEN then
			PP.Anchor(ZO_MainMenuSceneGroupBar, --[[#1]] RIGHT, GuiRoot, RIGHT, -40, -340)
		end
	end)

	ZO_Scroll_SetMaxFadeDistance(ZO_GuildHomePane, 10)
	PP.Anchor(ZO_GuildHomePane, --[[#1]] TOPLEFT, nil, TOPLEFT, 240, 70, --[[#2]] true, BOTTOMRIGHT, nil, BOTTOMRIGHT,	0, 0)
	PP.ScrollBar(ZO_GuildHomePane,	--[[sb_c]] 180, 180, 180, .7, --[[bd_c]] 20, 20, 20, .7, --[[edge]] 40, 40, 40, .9)
	ZO_Scroll_SetMaxFadeDistance(ZO_GuildHomeInfoMotDPane, 10)
	PP.ListBackdrop(ZO_GuildHomePane, -3, -3, -1, 3, --[[tex]] nil, 8, 0, --[[bd]] 5, 5, 5, .6, --[[edge]] 30, 30, 30, .6)
	PP.ScrollBar(ZO_GuildHomeInfoMotDPane,	--[[sb_c]] 180, 180, 180, .7, --[[bd_c]] 20, 20, 20, .7, --[[edge]] 40, 40, 40, .9)
	ZO_GuildHomeInfoMotD:SetDimensions(620, 450)
	ZO_GuildHomeInfoUpdatesDivider:SetHidden(true)

	PP.mainBackdrop(ZO_GuildHome,		'guildHome', --[[backdrop]] TOPLEFT, BOTTOMRIGHT, -10, -10, 0, 10,	--[[tex]] PP.t.bg1, 8, 1, --[[bd]] 10, 10, 10, .8, --[[edge]] 0, 0, 0, 1, --[[texture]] true, .5)
	PP.mainBackdrop(ZO_KeybindStripControl,	'guildHome', --[[backdrop]] TOPLEFT, BOTTOMRIGHT, -6, 0, 2, 6,		--[[tex]] PP.t.bg1, 8, 1, --[[bd]] 10, 10, 10, .6, --[[edge]] 0, 0, 0, 1, --[[texture]] false, 0)

	PP.Anchor(ZO_GuildHome, --[[#1]] TOPRIGHT, GuiRoot, TOPRIGHT, 0, 120, --[[#2]] true, BOTTOMRIGHT, GuiRoot, BOTTOMRIGHT,	1, -70)

--guildRoster--ZO_GuildRoster--------------------------------------------------------------------
	local guildRosterScene = SCENE_MANAGER:GetScene('guildRoster')
	
	guildRosterScene:RemoveFragmentGroup(FRAGMENT_GROUP.FRAME_TARGET_STANDARD_RIGHT_PANEL)
	guildRosterScene:RemoveFragment(FRAME_EMOTE_FRAGMENT_SOCIAL)
	guildRosterScene:RemoveFragment(RIGHT_BG_FRAGMENT)
	guildRosterScene:RemoveFragment(KEYBIND_STRIP_MUNGE_BACKDROP_FRAGMENT)

	guildRosterScene:RegisterCallback("StateChange", function(oldState, newState)
		if newState == SCENE_SHOWING then
			PP.Anchor(ZO_MainMenuSceneGroupBar, --[[#1]] TOPRIGHT, GuiRoot, TOPRIGHT, -30, 64)
			ZO_ScrollList_Commit(ZO_GuildRosterList)
		elseif newState == SCENE_HIDDEN then
			PP.Anchor(ZO_MainMenuSceneGroupBar, --[[#1]] RIGHT, GuiRoot, RIGHT, -40, -340)
		end
	end)

	ZO_Scroll_SetMaxFadeDistance(ZO_GuildRosterList, 10)
	PP.ListBackdrop(ZO_GuildRosterList, -3, -3, -1, 3, --[[tex]] nil, 8, 0, --[[bd]] 5, 5, 5, .6, --[[edge]] 30, 30, 30, .6)
	PP.ScrollBar(ZO_GuildRosterList,	--[[sb_c]] 180, 180, 180, .7, --[[bd_c]] 20, 20, 20, .7, --[[edge]] 40, 40, 40, .9)
	PP.Anchor(ZO_GuildRosterList, --[[#1]] TOPLEFT, ZO_GuildRosterHeaders, BOTTOMLEFT, 0, 3, --[[#2]] true, BOTTOMRIGHT, ZO_GuildRoster, BOTTOMRIGHT,	0, 0)
	PP.Anchor(ZO_GuildRosterHeaders, --[[#1]] TOPLEFT, nil, TOPLEFT, 0, 67, --[[#2]] true, TOPRIGHT, nil, TOPRIGHT,	0, 67)

	PP.mainBackdrop(ZO_GuildRoster,		'guildRoster', --[[backdrop]] TOPLEFT, BOTTOMRIGHT, -10, -10, 0, 10,	--[[tex]] PP.t.bg1, 8, 1, --[[bd]] 10, 10, 10, .8, --[[edge]] 0, 0, 0, 1, --[[texture]] true, .5)
	PP.mainBackdrop(ZO_KeybindStripControl,	'guildRoster', --[[backdrop]] TOPLEFT, BOTTOMRIGHT, -6, 0, 2, 6,		--[[tex]] PP.t.bg1, 8, 1, --[[bd]] 10, 10, 10, .6, --[[edge]] 0, 0, 0, 1, --[[texture]] false, 0)
	
	PP.Anchor(ZO_GuildRoster, --[[#1]] TOPRIGHT, GuiRoot, TOPRIGHT, 0, 120, --[[#2]] true, BOTTOMRIGHT, GuiRoot, BOTTOMRIGHT,	1, -70)


--guildRanks--ZO_GuildRanks----------------------------------------------------------------------
	local guildRanksScene = SCENE_MANAGER:GetScene('guildRanks')

	guildRanksScene:RegisterCallback("StateChange", function(oldState, newState)
		if newState == SCENE_SHOWING then
			PP.Anchor(ZO_MainMenuSceneGroupBar, --[[#1]] TOPRIGHT, GuiRoot, TOPRIGHT, -30, 64)
		elseif newState == SCENE_HIDDEN then
			PP.Anchor(ZO_MainMenuSceneGroupBar, --[[#1]] RIGHT, GuiRoot, RIGHT, -40, -340)
		end
	end)

	guildRanksScene:RemoveFragmentGroup(FRAGMENT_GROUP.FRAME_TARGET_STANDARD_RIGHT_PANEL)
	guildRanksScene:RemoveFragment(FRAME_EMOTE_FRAGMENT_SOCIAL)
	guildRanksScene:RemoveFragment(RIGHT_BG_FRAGMENT)
	guildRanksScene:RemoveFragment(TREE_UNDERLAY_FRAGMENT)
	guildRanksScene:RemoveFragment(KEYBIND_STRIP_MUNGE_BACKDROP_FRAGMENT)

	PP.mainBackdrop(ZO_GuildRanks,			'guildRanks', --[[backdrop]] TOPLEFT, BOTTOMRIGHT, -10, -10, 0, 10,	--[[tex]] PP.t.bg1, 8, 1, --[[bd]] 10, 10, 10, .8, --[[edge]] 0, 0, 0, 1, --[[texture]] true, .5)
	PP.mainBackdrop(ZO_KeybindStripControl,	'guildRanks', --[[backdrop]] TOPLEFT, BOTTOMRIGHT, -6, 0, 2, 6,		--[[tex]] PP.t.bg1, 8, 1, --[[bd]] 10, 10, 10, .6, --[[edge]] 0, 0, 0, 1, --[[texture]] false, 0)
	
	PP.Anchor(ZO_GuildRanks, --[[#1]] TOPRIGHT, GuiRoot, TOPRIGHT,	0, 120, --[[#2]] true, BOTTOMRIGHT, GuiRoot, BOTTOMRIGHT, 1, -70)
	PP.Anchor(ZO_GuildRanksListHeader, --[[#1]] TOPLEFT, ZO_GuildRanks, TOPLEFT,	0, 75)
	

--guildHistory--ZO_GuildHistory--------------------------------------------------------------------
	local guildHistoryScene = SCENE_MANAGER:GetScene('guildHistory')

	guildHistoryScene:RegisterCallback("StateChange", function(oldState, newState)
		if newState == SCENE_SHOWING then
			PP.Anchor(ZO_MainMenuSceneGroupBar, --[[#1]] TOPRIGHT, GuiRoot, TOPRIGHT, -30, 64)
			ZO_ScrollList_Commit(ZO_GuildHistoryList)
		elseif newState == SCENE_HIDDEN then
			PP.Anchor(ZO_MainMenuSceneGroupBar, --[[#1]] RIGHT, GuiRoot, RIGHT, -40, -340)
		end
	end)

	ZO_Scroll_SetMaxFadeDistance(ZO_GuildHistoryList, 10)
	PP.ListBackdrop(ZO_GuildHistoryList, -10, -3, 9, 3, --[[tex]] nil, 8, 0, --[[bd]] 5, 5, 5, .6, --[[edge]] 30, 30, 30, .6)
	PP.ScrollBar(ZO_GuildHistoryList,	--[[sb_c]] 180, 180, 180, .7, --[[bd_c]] 20, 20, 20, .7, --[[edge]] 40, 40, 40, .9)
	PP.Anchor(ZO_GuildHistoryListScrollBar, --[[#1]] TOPLEFT, nil, TOPRIGHT, 0, 3, --[[#2]] true, BOTTOMLEFT, nil, BOTTOMRIGHT,	-6, -3)

	PP.Anchor(ZO_GuildHistoryList, --[[#1]] TOPLEFT, ZO_GuildHistoryActivityLogHeader, BOTTOMLEFT, 0, 0, --[[#2]] true, BOTTOMRIGHT, ZO_GuildHistory, BOTTOMRIGHT,	-10, 0)

	guildHistoryScene:RemoveFragmentGroup(FRAGMENT_GROUP.FRAME_TARGET_STANDARD_RIGHT_PANEL)
	guildHistoryScene:RemoveFragment(FRAME_EMOTE_FRAGMENT_SOCIAL)
	guildHistoryScene:RemoveFragment(RIGHT_BG_FRAGMENT)
	guildHistoryScene:RemoveFragment(TREE_UNDERLAY_FRAGMENT)
	guildHistoryScene:RemoveFragment(KEYBIND_STRIP_MUNGE_BACKDROP_FRAGMENT)

	PP.mainBackdrop(ZO_GuildHistory,		'guildHistory', --[[backdrop]] TOPLEFT, BOTTOMRIGHT, -10, -10, 0, 10,	--[[tex]] PP.t.bg1, 8, 1, --[[bd]] 10, 10, 10, .8, --[[edge]] 0, 0, 0, 1, --[[texture]] true, .5)
	PP.mainBackdrop(ZO_KeybindStripControl,	'guildHistory', --[[backdrop]] TOPLEFT, BOTTOMRIGHT, -6, 0, 2, 6,		--[[tex]] PP.t.bg1, 8, 1, --[[bd]] 10, 10, 10, .6, --[[edge]] 0, 0, 0, 1, --[[texture]] false, 0)

	PP.Anchor(ZO_GuildHistory, --[[#1]] TOPRIGHT,	GuiRoot, TOPRIGHT,	0, 120,	--[[#2]] true, BOTTOMRIGHT,	GuiRoot, BOTTOMRIGHT,	1, -70)
	PP.Anchor(ZO_GuildHistoryCategoriesHeader, --[[#1]] TOPLEFT, ZO_GuildHistory, TOPLEFT,	0, 75)

--guildCreate--ZO_GuildCreate--------------------------------------------------------------------
	local guildCreateScene = SCENE_MANAGER:GetScene('guildCreate')

	guildCreateScene:RegisterCallback("StateChange", function(oldState, newState)
		if newState == SCENE_SHOWING then
			PP.Anchor(ZO_MainMenuSceneGroupBar, --[[#1]] TOPRIGHT, GuiRoot, TOPRIGHT, -30, 64)
		elseif newState == SCENE_HIDDEN then
			PP.Anchor(ZO_MainMenuSceneGroupBar, --[[#1]] RIGHT, GuiRoot, RIGHT, -40, -340)
		end
	end)

	guildCreateScene:RemoveFragmentGroup(FRAGMENT_GROUP.FRAME_TARGET_STANDARD_RIGHT_PANEL)
	guildCreateScene:RemoveFragment(FRAME_EMOTE_FRAGMENT_SOCIAL)
	guildCreateScene:RemoveFragment(RIGHT_BG_FRAGMENT)
	guildCreateScene:RemoveFragment(TREE_UNDERLAY_FRAGMENT)
	guildCreateScene:RemoveFragment(KEYBIND_STRIP_MUNGE_BACKDROP_FRAGMENT)

	PP.mainBackdrop(ZO_GuildCreate,		'guildCreate', --[[backdrop]] TOPLEFT, BOTTOMRIGHT, -10, -10, 0, 10,	--[[tex]] PP.t.bg1, 8, 1, --[[bd]] 10, 10, 10, .8, --[[edge]] 0, 0, 0, 1, --[[texture]] true, .5)
	PP.mainBackdrop(ZO_KeybindStripControl,	'guildCreate', --[[backdrop]] TOPLEFT, BOTTOMRIGHT, -6, 0, 2, 6,		--[[tex]] PP.t.bg1, 8, 1, --[[bd]] 10, 10, 10, .6, --[[edge]] 0, 0, 0, 1, --[[texture]] false, 0)

	PP.Anchor(ZO_GuildCreate, --[[#1]] TOPRIGHT,	GuiRoot, TOPRIGHT,	0, 120,	--[[#2]] true, BOTTOMRIGHT,	GuiRoot, BOTTOMRIGHT,	1, -70)

--guildHeraldry--ZO_GuildHeraldry--------------------------------------------------------------------
	local guildHeraldryScene = SCENE_MANAGER:GetScene('guildHeraldry')

	guildHeraldryScene:RegisterCallback("StateChange", function(oldState, newState)
		if newState == SCENE_SHOWING then
			PP.Anchor(ZO_MainMenuSceneGroupBar, --[[#1]] TOPRIGHT, GuiRoot, TOPRIGHT, -30, 64)
		elseif newState == SCENE_HIDDEN then
			PP.Anchor(ZO_MainMenuSceneGroupBar, --[[#1]] RIGHT, GuiRoot, RIGHT, -40, -340)
		end
	end)

	guildHeraldryScene:RemoveFragmentGroup(FRAGMENT_GROUP.FRAME_TARGET_STANDARD_RIGHT_PANEL)
	guildHeraldryScene:RemoveFragment(FRAME_EMOTE_FRAGMENT_SOCIAL)
	guildHeraldryScene:RemoveFragment(RIGHT_BG_FRAGMENT)
	guildHeraldryScene:RemoveFragment(TREE_UNDERLAY_FRAGMENT)
	guildHeraldryScene:RemoveFragment(KEYBIND_STRIP_MUNGE_BACKDROP_FRAGMENT)

	PP.mainBackdrop(ZO_GuildHeraldry,		'guildHeraldry', --[[backdrop]] TOPLEFT, BOTTOMRIGHT, -10, -10, 0, 10,	--[[tex]] PP.t.bg1, 8, 1, --[[bd]] 10, 10, 10, .8, --[[edge]] 0, 0, 0, 1, --[[texture]] true, .5)
	PP.mainBackdrop(ZO_KeybindStripControl,	'guildHeraldry', --[[backdrop]] TOPLEFT, BOTTOMRIGHT, -6, 0, 2, 6,		--[[tex]] PP.t.bg1, 8, 1, --[[bd]] 10, 10, 10, .6, --[[edge]] 0, 0, 0, 1, --[[texture]] false, 0)

	PP.Anchor(ZO_GuildHeraldry, --[[#1]] TOPRIGHT,	GuiRoot, TOPRIGHT,	0, 120,	--[[#2]] true, BOTTOMRIGHT,	GuiRoot, BOTTOMRIGHT,	1, -70)

end



