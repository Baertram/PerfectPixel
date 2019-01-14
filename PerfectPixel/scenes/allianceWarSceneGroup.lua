PP.allianceWarSceneGroup = function()

--ZO_CampaignOverview------------------------------------------------------------------------------------------------------------------------------
	CAMPAIGN_OVERVIEW_SCENE:RemoveFragmentGroup(FRAGMENT_GROUP.FRAME_TARGET_STANDARD_RIGHT_PANEL)
	CAMPAIGN_OVERVIEW_SCENE:RemoveFragment(RIGHT_BG_FRAGMENT)
	CAMPAIGN_OVERVIEW_SCENE:RemoveFragment(TREE_UNDERLAY_FRAGMENT)
	CAMPAIGN_OVERVIEW_SCENE:RemoveFragment(TITLE_FRAGMENT)
	CAMPAIGN_OVERVIEW_SCENE:RemoveFragment(ALLIANCE_WAR_TITLE_FRAGMENT)
	CAMPAIGN_OVERVIEW_SCENE:RemoveFragment(KEYBIND_STRIP_MUNGE_BACKDROP_FRAGMENT)
	
	CAMPAIGN_OVERVIEW_SCENE:RegisterCallback("StateChange", function(oldState, newState)
		if newState == SCENE_SHOWING then
			PP.Anchor(ZO_MainMenuSceneGroupBar, --[[#1]] TOPRIGHT, GuiRoot, TOPRIGHT, -30, 64)
		elseif newState == SCENE_HIDDEN then
			PP.Anchor(ZO_MainMenuSceneGroupBar, --[[#1]] RIGHT, GuiRoot, RIGHT, -40, -340)
		end
	end)
	
	PP.mainBackdrop(ZO_CampaignOverview,	'campaignOverview', --[[Backdrop]] TOPLEFT,	BOTTOMRIGHT, 	-10, -10, 0, 10, --[[tex]] PP.t.bg1, 8, 1, --[[bd]]	10, 10, 10, .8, --[[edge]]	0, 0, 0, 1, --[[texture]] true, .5)
	PP.mainBackdrop(ZO_KeybindStripControl,	'campaignOverview', --[[backdrop]] TOPLEFT, BOTTOMRIGHT, -6, 0, 2, 6, --[[tex]] PP.t.bg1, 8, 1, --[[bd]] 10, 10, 10, .6, --[[edge]] 0, 0, 0, 1, --[[texture]] false, 0)
	
	PP.Anchor(ZO_CampaignOverview, --[[#1]] TOPRIGHT, GuiRoot, TOPRIGHT, 0, 120,	--[[#2]] true, BOTTOMRIGHT, GuiRoot, BOTTOMRIGHT, 1, -70)
	PP.Anchor(ZO_CampaignOverviewCategories, --[[#1]] TOPLEFT, ZO_CampaignOverview, TOPLEFT, 0, 68)
	PP.Anchor(ZO_CampaignSelector, --[[#1]] BOTTOMRIGHT, ZO_CampaignOverviewTopDivider, TOPRIGHT, -165, 25)


--ZO_CampaignBrowser
	CAMPAIGN_BROWSER_SCENE:RemoveFragmentGroup(FRAGMENT_GROUP.FRAME_TARGET_STANDARD_RIGHT_PANEL)
	CAMPAIGN_BROWSER_SCENE:RemoveFragment(RIGHT_BG_FRAGMENT)
	CAMPAIGN_BROWSER_SCENE:RemoveFragment(TREE_UNDERLAY_FRAGMENT)
	CAMPAIGN_BROWSER_SCENE:RemoveFragment(TITLE_FRAGMENT)
	CAMPAIGN_BROWSER_SCENE:RemoveFragment(ALLIANCE_WAR_TITLE_FRAGMENT)
	CAMPAIGN_BROWSER_SCENE:RemoveFragment(KEYBIND_STRIP_MUNGE_BACKDROP_FRAGMENT)

	CAMPAIGN_BROWSER_SCENE:RegisterCallback("StateChange", function(oldState, newState)
		if newState == SCENE_SHOWING then
			PP.Anchor(ZO_MainMenuSceneGroupBar, --[[#1]] TOPRIGHT, GuiRoot, TOPRIGHT, -30, 64)
		elseif newState == SCENE_HIDDEN then
			PP.Anchor(ZO_MainMenuSceneGroupBar, --[[#1]] RIGHT, GuiRoot, RIGHT, -40, -340)
		end
	end)
	
	PP.mainBackdrop(ZO_CampaignBrowser,		"campaignBrowser", --[[Backdrop]] TOPLEFT,	BOTTOMRIGHT, 	-10, -10, 0, 10, --[[tex]] PP.t.bg1, 8, 1, --[[bd]]	10, 10, 10, .8, --[[edge]]	0, 0, 0, 1, --[[texture]] true, .5)
	PP.mainBackdrop(ZO_KeybindStripControl,	"campaignBrowser", --[[backdrop]] TOPLEFT, BOTTOMRIGHT, -6, 0, 2, 6, --[[tex]] PP.t.bg1, 8, 1, --[[bd]] 10, 10, 10, .6, --[[edge]] 0, 0, 0, 1, --[[texture]] false, 0)
	
	PP.Anchor(ZO_CampaignBrowser, --[[#1]] TOPRIGHT, GuiRoot, TOPRIGHT, 0, 120, 	--[[#2]] true, BOTTOMRIGHT, GuiRoot, BOTTOMRIGHT, 1, -70)
---------------------------------------------------------------------------------------------------
end