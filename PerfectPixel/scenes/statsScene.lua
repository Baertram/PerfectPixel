PP.statsScene = function()
--STATS
	-- STATS_SCENE:RemoveFragment(FRAME_PLAYER_FRAGMENT)
	-- STATS_SCENE:RemoveFragment(FRAME_EMOTE_FRAGMENT_SKILLS)

	-- STATS.outfitDropdown
	PP:ForceRemoveFragment(STATS_SCENE, STATS_BG_FRAGMENT)

	PP:CreateBackground(ZO_StatsPanel,						--[[#1]] nil, ZO_AdvancedStatsPanel, nil, -15, -10,	--[[#2]] nil, nil, nil, 0, 10)
	local bg = ZO_StatsPanel.PP_BG
	 STATS_SCENE:RegisterCallback("StateChange", function(oldState, newState)
		 if newState == SCENE_HIDDEN then
			 bg:SetHidden(true)
		 --[[
		 --20241115 Baertram Not working as the attribute bars are not progress bars and thus BG and GLow etc. are missing!
		 elseif newState == SCENE_SHOWING then
			--Attribute bars
			--ZO_StatsPanelPaneScrollChildAttributesRow1
			--ZO_StatsPanelPaneScrollChildAttributesRow1Magicka
			--ZO_StatsPanelPaneScrollChildAttributesRow1Health
			--ZO_StatsPanelPaneScrollChildAttributesRow1Stamina
			for _, statsAttributeControl in ipairs(STATS.attributeControls) do
				PP.Bar(statsAttributeControl, 14, 15)
			end
	 	 ]]
		 end
    end)


	PP.Anchor(ZO_StatsPanel, --[[#1]] TOPRIGHT, GuiRoot, TOPRIGHT, 0, 120,	--[[#2]] true, BOTTOMRIGHT, GuiRoot, BOTTOMRIGHT, 0, -70)
	PP.Anchor(ZO_StatsPanelPane, --[[#1]] TOPLEFT, ZO_StatsPanelTitleSection, BOTTOMLEFT, 0, 0,	--[[#2]] true, BOTTOMRIGHT, ZO_StatsPanel, BOTTOMRIGHT, 0, -3)

	PP.ScrollBar(ZO_StatsPanelPane, --[[sb_c]] 180, 180, 180, 0.7, --[[bd_c]] 20, 20, 20, 0.7, true)
	ZO_Scroll_SetMaxFadeDistance(ZO_StatsPanelPane, PP.savedVars.ListStyle.list_fade_distance)




--ZO_ADVANCED_STATS_WINDOW
	for i = 1, #ADVANCED_STATS_FRAGMENT_GROUP do
		if ADVANCED_STATS_FRAGMENT_GROUP[i] == RIGHT_BG_FRAGMENT then
			ADVANCED_STATS_FRAGMENT_GROUP[i] = nil
		end
	end

	local asPanel	= ZO_AdvancedStatsPanel
	local asClose	= ZO_AdvancedStatsPanelClose
	local asList	= ZO_AdvancedStatsPanelAdvancedStatList

	asPanel:SetWidth(0)
	ZO_PreHookHandler(asPanel, 'OnEffectivelyShown', function(self) self:SetWidth(320) end)
	ZO_PreHookHandler(asPanel, 'OnEffectivelyHidden', function(self) self:SetWidth(0) end)

	PP.Anchor(asPanel,			--[[#1]] TOPRIGHT, ZO_StatsPanel, TOPLEFT, 0, 0,	--[[#2]] true, BOTTOMRIGHT, ZO_StatsPanel, BOTTOMLEFT, 0, 0)

	PP.Font(asClose.keyLabel,	--[[Font]] PP.f.u57, 16, "outline", --[[Alpha]] nil, --[[Color]] nil, nil, nil, nil, --[[StyleColor]] 0, 0, 0, 0.5)
	PP.Font(asClose.nameLabel,	--[[Font]] PP.f.u67, 18, "outline", --[[Alpha]] nil, --[[Color]] nil, nil, nil, nil, --[[StyleColor]] 0, 0, 0, 0.5)

	PP.Anchor(asList,			--[[#1]] nil, nil, nil, nil, nil,	--[[#2]] true, nil, nil, nil, -20, nil)
	PP.ScrollBar(asList,		--[[sb_c]] 180, 180, 180, 0.7, --[[bd_c]] 20, 20, 20, 0.7, true)
	ZO_Scroll_SetMaxFadeDistance(asList, PP.savedVars.ListStyle.list_fade_distance)
	ZO_ScrollList_Commit(asList)


--ZO_KEYBOARD_CLAIM_LEVEL_UP_REWARDS
	PP:CreateBackground(ZO_ClaimLevelUpRewardsScreen_Keyboard,	--[[#1]] nil, nil, nil, -1, 0,		--[[#2]] nil, nil, nil, -10, 10)
	PP.Anchor(ZO_ClaimLevelUpRewardsScreen_Keyboard, --[[#1]] TOPLEFT, nil, TOPLEFT, 0, 90,	--[[#2]] true, BOTTOMLEFT, nil, BOTTOMLEFT, 0, -250)
	PP.Anchor(ZO_ClaimLevelUpRewardsScreen_KeyboardList, --[[#1]] TOPLEFT, ZO_ClaimLevelUpRewardsScreen_KeyboardTitleDivider, BOTTOMLEFT, 16, 0,	--[[#2]] true, BOTTOM, ZO_ClaimLevelUpRewardsScreen_KeyboardClaimButton, CENTER, 0, -40)

	ZO_ClaimLevelUpRewardsScreen_KeyboardBG:SetHidden(true)
	ZO_ClaimLevelUpRewardsScreen_KeyboardTitleDivider:SetHidden(true)
	ZO_Scroll_SetMaxFadeDistance(ZO_ClaimLevelUpRewardsScreen_KeyboardList, PP.savedVars.ListStyle.list_fade_distance)

	PP.ScrollBar(ZO_ClaimLevelUpRewardsScreen_KeyboardList, --[[sb_c]] 180, 180, 180, 0.7, --[[bd_c]] 20, 20, 20, 0.7, true)

--ZO_KEYBOARD_UPCOMING_LEVEL_UP_REWARDS
	PP:CreateBackground(ZO_UpcomingLevelUpRewards_Keyboard,	--[[#1]] nil, nil, nil, -1, 0,		--[[#2]] nil, nil, nil, -10, 10)
	PP.Anchor(ZO_UpcomingLevelUpRewards_Keyboard, --[[#1]] TOPLEFT, nil, TOPLEFT, 0, 90,	--[[#2]] true, BOTTOMLEFT, nil, BOTTOMLEFT, 0, -250)
	PP.Anchor(ZO_UpcomingLevelUpRewards_KeyboardScrollContainer, --[[#1]] TOPLEFT, ZO_UpcomingLevelUpRewards_KeyboardTitleDivider, BOTTOMLEFT, 16, 0,	--[[#2]] true, BOTTOMLEFT, ZO_UpcomingLevelUpRewards_Keyboard, BOTTOMLEFT, 16, 0)

	ZO_UpcomingLevelUpRewards_KeyboardBG:SetHidden(true)
	ZO_UpcomingLevelUpRewards_KeyboardTitleDivider:SetHidden(true)
	ZO_Scroll_SetMaxFadeDistance(ZO_UpcomingLevelUpRewards_KeyboardScrollContainer, PP.savedVars.ListStyle.list_fade_distance)

	PP.ScrollBar(ZO_UpcomingLevelUpRewards_KeyboardScrollContainer, --[[sb_c]] 180, 180, 180, 0.7, --[[bd_c]] 20, 20, 20, 0.7, true)

end