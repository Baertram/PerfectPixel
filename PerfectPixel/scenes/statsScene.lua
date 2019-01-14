PP.statsScene = function()

	local statsScene = SCENE_MANAGER:GetScene('stats')
	statsScene:RemoveFragmentGroup(FRAGMENT_GROUP.FRAME_TARGET_CENTERED)
	statsScene:RemoveFragment(FRAME_EMOTE_FRAGMENT_SKILLS)
	statsScene:RemoveFragment(STATS_BG_FRAGMENT)
	statsScene:RemoveFragment(KEYBIND_STRIP_MUNGE_BACKDROP_FRAGMENT)

	PP.Anchor(ZO_StatsPanel, --[[#1]] TOPRIGHT, GuiRoot, TOPRIGHT, 0, 90,	--[[#2]] true, BOTTOMRIGHT, GuiRoot, BOTTOMRIGHT, 1, -70)
	PP.Anchor(ZO_StatsPanelPane, --[[#1]] TOPLEFT, ZO_StatsPanelTitleSection, BOTTOMLEFT, 0, 0,	--[[#2]] true, BOTTOMRIGHT, ZO_StatsPanel, BOTTOMRIGHT, 0, -3)

	PP.mainBackdrop(ZO_StatsPanel, 'stats', --[[backdrop]] TOPLEFT, BOTTOMRIGHT, -15, -10, 0, 10, --[[tex]] PP.t.bg1, 8, 1, --[[bd]] 10, 10, 10, .8, --[[edge]] 0, 0, 0, 1, --[[texture]] true, .5)
	PP.mainBackdrop(ZO_KeybindStripControl,	'stats', --[[backdrop]] TOPLEFT, BOTTOMRIGHT, -6, 0, 2, 6, --[[tex]] PP.t.bg1, 8, 1, --[[bd]] 10, 10, 10, .6, --[[edge]] 0, 0, 0, 1, --[[texture]] false, 0)

	PP.ScrollBar(ZO_StatsPanelPane, --[[sb_c]] 200, 200, 200, .8, --[[bd_c]] 10, 10, 10, .7, --[[edge]] 40, 40, 40, 1)

	--ZO_ClaimLevelUpRewardsScreen_Keyboard
	PP.Anchor(ZO_ClaimLevelUpRewardsScreen_Keyboard, --[[#1]] TOPLEFT, nil, TOPLEFT, 0, 90,	--[[#2]] true, BOTTOMLEFT, nil, BOTTOMLEFT, 0, -250)
	PP.Anchor(ZO_ClaimLevelUpRewardsScreen_KeyboardList, --[[#1]] TOPLEFT, ZO_ClaimLevelUpRewardsScreen_KeyboardTitleDivider, BOTTOMLEFT, 16, 0,	--[[#2]] true, BOTTOM, ZO_ClaimLevelUpRewardsScreen_KeyboardClaimButton, CENTER, 0, -40)

	ZO_ClaimLevelUpRewardsScreen_KeyboardBG:SetHidden(true)
	ZO_ClaimLevelUpRewardsScreen_KeyboardTitleDivider:SetHidden(true)
	ZO_Scroll_SetMaxFadeDistance(ZO_ClaimLevelUpRewardsScreen_KeyboardList, 10)

	PP.ListBackdrop(ZO_ClaimLevelUpRewardsScreen_Keyboard, -1, 0, -10, 10, --[[tex_1]] PP.t.bg1, 8, 1, --[[bd]] 10, 10, 10, .8, --[[edge]] 0, 0, 0, 1)
	PP.ListBackdrop(ZO_ClaimLevelUpRewardsScreen_KeyboardList, -11, -3, -1, 3, --[[tex]] nil, 8, 0, --[[bd]] 10, 10, 10, .6, --[[edge]] 30, 30, 30, .6)
	PP.ScrollBar(ZO_ClaimLevelUpRewardsScreen_KeyboardList, --[[sb_c]] 180, 180, 180, .7, --[[bd_c]] 20, 20, 20, .7, --[[edge]] 40, 40, 40, .9)
	--ZO_UpcomingLevelUpRewards_Keyboard
	PP.Anchor(ZO_UpcomingLevelUpRewards_Keyboard, --[[#1]] TOPLEFT, nil, TOPLEFT, 0, 90,	--[[#2]] true, BOTTOMLEFT, nil, BOTTOMLEFT, 0, -250)
	PP.Anchor(ZO_UpcomingLevelUpRewards_KeyboardScrollContainer, --[[#1]] TOPLEFT, ZO_UpcomingLevelUpRewards_KeyboardTitleDivider, BOTTOMLEFT, 16, 0,	--[[#2]] true, BOTTOMLEFT, ZO_UpcomingLevelUpRewards_Keyboard, BOTTOMLEFT, 16, 0)

	ZO_UpcomingLevelUpRewards_KeyboardBG:SetHidden(true)
	ZO_UpcomingLevelUpRewards_KeyboardTitleDivider:SetHidden(true)
	ZO_Scroll_SetMaxFadeDistance(ZO_UpcomingLevelUpRewards_KeyboardScrollContainer, 10)

	PP.ListBackdrop(ZO_UpcomingLevelUpRewards_Keyboard, -1, 0, -10, 10, --[[tex_1]] PP.t.bg1, 8, 1, --[[bd]] 10, 10, 10, .8, --[[edge]] 0, 0, 0, 1)
	PP.ListBackdrop(ZO_UpcomingLevelUpRewards_KeyboardScrollContainer, -11, -3, -1, 3, --[[tex]] nil, 8, 0, --[[bd]] 10, 10, 10, .6, --[[edge]] 30, 30, 30, .6)
	PP.ScrollBar(ZO_UpcomingLevelUpRewards_KeyboardScrollContainer, --[[sb_c]] 180, 180, 180, .7, --[[bd_c]] 20, 20, 20, .7, --[[edge]] 40, 40, 40, .9)
end