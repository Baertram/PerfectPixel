PP.guildSceneGroup = function()
	local scenes = {
		{ scene = GUILD_HOME_SCENE,					gVar = GUILD_HOME,							},
		{ scene = GUILD_ROSTER_SCENE,				gVar = GUILD_ROSTER_KEYBOARD,				},
		{ scene = GUILD_RANKS_SCENE,				gVar = GUILD_RANKS,							},
		{ scene = GUILD_HISTORY_SCENE,				gVar = GUILD_HISTORY,						},
		{ scene = GUILD_CREATE_SCENE,				gVar = ZO_GuildCreate,						}, --local = GUILD_CREATE ...
		{ scene = GUILD_HERALDRY_SCENE,				gVar = GUILD_HERALDRY,						},
		{ scene = KEYBOARD_GUILD_RECRUITMENT_SCENE,	gVar = GUILD_RECRUITMENT_KEYBOARD,			},
		{ scene = KEYBOARD_GUILD_BROWSER_SCENE,		gVar = GUILD_BROWSER_KEYBOARD,				},
		{ scene = KEYBOARD_LINK_GUILD_INFO_SCENE,	gVar = GUILD_BROWSER_GUILD_INFO_KEYBOARD,	},
	}
	local fragments	= { FRAME_PLAYER_FRAGMENT, RIGHT_BG_FRAGMENT, TREE_UNDERLAY_FRAGMENT, TITLE_FRAGMENT, GUILD_LINK_TITLE_FRAGMENT, }

	for i=1, #scenes do
		local scene			= scenes[i].scene
		local gVar			= scenes[i].gVar

		for i=1, #fragments do
			scene:RemoveFragment(fragments[i])
		end

		local tlc = gVar.control or gVar

		PP:CreateBackground(tlc, --[[#1]] nil, nil, nil, -10, -10, --[[#2]] nil, nil, nil, 0, 10)
		PP.Anchor(tlc, --[[#1]] TOPRIGHT, GuiRoot, TOPRIGHT, 0, 120, --[[#2]] true, BOTTOMRIGHT, GuiRoot, BOTTOMRIGHT, 0, -70)
	end

--guildHome--ZO_GuildHome--------------------------------------------------------------------
	PP.Anchor(ZO_GuildHomeKeep, --[[#1]] nil, nil, nil, 0, 80)
	PP.Anchor(ZO_GuildHomePane, --[[#1]] TOPLEFT, ZO_GuildHomeKeep, TOPRIGHT, 30, 0, --[[#2]] true, BOTTOMRIGHT, ZO_GuildHome, BOTTOMRIGHT,	0, 0)
	PP.ScrollBar(ZO_GuildHomePane,	--[[sb_c]] 180, 180, 180, .7, --[[bd_c]] 20, 20, 20, .7, false)
	ZO_Scroll_SetMaxFadeDistance(ZO_GuildHomePane, 10)
	ZO_GuildHomeInfoMotD:SetDimensions(650, 400)
	PP.ScrollBar(ZO_GuildHomeInfoMotDPane,	--[[sb_c]] 180, 180, 180, .7, --[[bd_c]] 20, 20, 20, .7, false)
	ZO_Scroll_SetMaxFadeDistance(ZO_GuildHomeInfoMotDPane, 10)
	ZO_GuildHomeInfoDescription:SetDimensions(650, 200)
	PP.ScrollBar(ZO_GuildHomeInfoDescriptionPane,	--[[sb_c]] 180, 180, 180, .7, --[[bd_c]] 20, 20, 20, .7, false)
	ZO_Scroll_SetMaxFadeDistance(ZO_GuildHomeInfoDescriptionPane, 10)

--guildRoster--ZO_GuildRoster--------------------------------------------------------------------
	PP.Anchor(ZO_GuildRosterList, --[[#1]] TOPLEFT, ZO_GuildRosterHeaders, BOTTOMLEFT, 0, 3, --[[#2]] true, BOTTOMRIGHT, ZO_GuildRoster, BOTTOMRIGHT,	0, 0)
	PP.Anchor(ZO_GuildRosterHeaders, --[[#1]] TOPLEFT, nil, TOPLEFT, 0, 67, --[[#2]] true, TOPRIGHT, nil, TOPRIGHT,	0, 67)
	PP.Anchor(ZO_GuildRosterHideOffline, --[[#1]] LEFT, ZO_GuildSharedInfoTradingHouse, RIGHT, 30, 0)
	PP.ScrollBar(ZO_GuildRosterList,	--[[sb_c]] 180, 180, 180, .7, --[[bd_c]] 20, 20, 20, .7, false)
	ZO_Scroll_SetMaxFadeDistance(ZO_GuildRosterList, 10)
	ZO_ScrollList_Commit(ZO_GuildRosterList)

--guildRanks--ZO_GuildRanks----------------------------------------------------------------------
	PP.Anchor(ZO_GuildRanksListHeader, --[[#1]] TOPLEFT, ZO_GuildRanks, TOPLEFT,	10, 80)
	
--guildHistory--ZO_GuildHistory--------------------------------------------------------------------
	PP.Anchor(ZO_GuildHistoryList, --[[#1]] TOPLEFT, ZO_GuildHistoryActivityLogHeader, BOTTOMLEFT, 0, 0, --[[#2]] true, BOTTOMRIGHT, ZO_GuildHistory, BOTTOMRIGHT,	0, 0)
	PP.Anchor(ZO_GuildHistoryCategoriesHeader, --[[#1]] TOPLEFT, ZO_GuildHistory, TOPLEFT,	10, 80)
	PP.ScrollBar(ZO_GuildHistoryList,	--[[sb_c]] 180, 180, 180, .7, --[[bd_c]] 20, 20, 20, .7, false)
	ZO_Scroll_SetMaxFadeDistance(ZO_GuildHistoryList, 10)
	ZO_ScrollList_Commit(ZO_GuildHistoryList)

--guildRecruitmentKeyboard-------------------------------------------------------------------------
	PP.Anchor(ZO_GuildRecruitment_Keyboard_TopLevelList, --[[#1]] TOPLEFT, ZO_GuildRecruitment_Keyboard_TopLevel, TOPLEFT,	0, 80)
	PP.ScrollBar(ZO_GuildRecruitment_GuildListingInfo_Keyboard_TopLevelInfoPanel,	--[[sb_c]] 180, 180, 180, .7, --[[bd_c]] 20, 20, 20, .7, false)
	ZO_Scroll_SetMaxFadeDistance(ZO_GuildRecruitment_GuildListingInfo_Keyboard_TopLevelInfoPanel, 10)

--KEYBOARD_LINK_GUILD_INFO_SCENE GUILD_BROWSER_GUILD_INFO_KEYBOARD.control
	PP:HideBackgroundForScene(KEYBOARD_GUILD_BROWSER_SCENE, GUILD_BROWSER_GUILD_INFO_KEYBOARD.control.PP_BG)
	PP.Anchor(ZO_GuildBrowser_GuildList_Keyboard_TopLevel, --[[#1]] TOPRIGHT, GuiRoot, TOPRIGHT,	0, 120, --[[#2]] true, BOTTOMRIGHT, GuiRoot, BOTTOMRIGHT, 0, -70)
	PP.Anchor(ZO_GuildBrowser_GuildList_Keyboard_TopLevelList, --[[#1]] nil, nil, nil, nil, nil, --[[#2]] true, nil, nil, nil, 0, 0)
	PP.ScrollBar(ZO_GuildBrowser_GuildList_Keyboard_TopLevelList,	--[[sb_c]] 180, 180, 180, .7, --[[bd_c]] 20, 20, 20, .7, false)
	ZO_Scroll_SetMaxFadeDistance(ZO_GuildBrowser_GuildList_Keyboard_TopLevelList, 10)
--ZO_GuildSelector GUILD_SELECTOR
	PP.Anchor(ZO_GuildSelector, --[[#1]] BOTTOMLEFT, ZO_GuildHome, TOPLEFT, -70, -8)
	PP.Font(ZO_GuildSelectorComboBoxSelectedItemText, --[[Font]] PP.f.u67, 30, "outline", --[[Alpha]] .9, --[[Color]] nil, nil, nil, nil, --[[StyleColor]] 0, 0, 0, .8)
	ZO_GuildSelectorDivider:SetHidden(true)
end



