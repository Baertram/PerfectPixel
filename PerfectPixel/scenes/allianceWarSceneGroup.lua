local PP = PP
local removeFragmentsFromScene = PP.removeFragmentsFromScene

PP.allianceWarSceneGroup = function()
	local scenes = {
		{ scene = CAMPAIGN_OVERVIEW_SCENE,	gVar = CAMPAIGN_OVERVIEW,	},
		{ scene = CAMPAIGN_BROWSER_SCENE,	gVar = CAMPAIGN_BROWSER,	},
	}
	local fragments	= { FRAME_PLAYER_FRAGMENT, RIGHT_BG_FRAGMENT, TREE_UNDERLAY_FRAGMENT, TITLE_FRAGMENT, ALLIANCE_WAR_TITLE_FRAGMENT, }

	for _, sceneInfo in ipairs(scenes) do
		local scene = sceneInfo.scene
		local gVar = sceneInfo.gVar

		-- Remove fragments from the current scene
		removeFragmentsFromScene(scene, fragments)

		local tlc	= gVar.control
		--local list	= gVar.list

		PP:CreateBackground(tlc, --[[#1]] nil, nil, nil, -10, -10, --[[#2]] nil, nil, nil, 0, 10)
		PP.Anchor(tlc, --[[#1]] TOPRIGHT, GuiRoot, TOPRIGHT, 0, 120, --[[#2]] true, BOTTOMRIGHT, GuiRoot, BOTTOMRIGHT, 0, -70)
		-- ZO_ScrollList_Commit(list)
	end

--ZO_CampaignOverview------------------------------------------------------------------------------------------------------------------------------
	PP.Anchor(ZO_CampaignOverviewCategories, --[[#1]] TOPLEFT, ZO_CampaignOverview, TOPLEFT, 0, 68)
	PP.Anchor(ZO_CampaignSelector, --[[#1]] BOTTOMRIGHT, ZO_CampaignOverviewTopDivider, TOPRIGHT, -165, 25)

--ZO_CampaignBrowser
---------------------------------------------------------------------------------------------------
end