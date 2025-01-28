local PP = PP ---@class PP
local removeFragmentsFromScene = PP.removeFragmentsFromScene

local DEFAULT_ALLIANCE_WAR_SCENES = {
	{
		sceneObj = CAMPAIGN_OVERVIEW_SCENE,
		someGlobalObj = CAMPAIGN_OVERVIEW,
	},
	{
		sceneObj = CAMPAIGN_BROWSER_SCENE,
		someGlobalObj = CAMPAIGN_BROWSER,
	},
}

local FRAGMENTS_TO_REMOVE = {
	FRAME_PLAYER_FRAGMENT,
	RIGHT_BG_FRAGMENT,
	TREE_UNDERLAY_FRAGMENT,
	TITLE_FRAGMENT,
	ALLIANCE_WAR_TITLE_FRAGMENT,
}

local function MainStuffMustDoneHere(scene, topLevelControl)
	removeFragmentsFromScene(scene, FRAGMENTS_TO_REMOVE)

	PP:CreateBackground(topLevelControl, --[[#1]] nil, nil, nil, -10, -10, --[[#2]] nil, nil, nil, 0, 10)
	PP.Anchor(topLevelControl, --[[#1]] TOPRIGHT, GuiRoot, TOPRIGHT, 0, 120, --[[#2]] true, BOTTOMRIGHT, GuiRoot, BOTTOMRIGHT, 0, -70)
end
PP.allianceWarSceneGroupMainStuff = MainStuffMustDoneHere

local function AdditionalStuff()
	PP.Anchor(ZO_CampaignOverviewCategories, --[[#1]] TOPLEFT, ZO_CampaignOverview, TOPLEFT, 0, 68)
	PP.Anchor(ZO_CampaignSelector, --[[#1]] BOTTOMRIGHT, ZO_CampaignOverviewTopDivider, TOPRIGHT, -165, 25)

	local campaignBrowserXPBarChanged = false
	CAMPAIGN_BROWSER_SCENE:RegisterCallback("StateChange", function(oldState, newState)
		if newState == SCENE_SHOWN and not campaignBrowserXPBarChanged then
			PP.Bar(GetControl(ZO_CampaignAvARank, "XPBar"), 14, 15, nil, nil, true)
			campaignBrowserXPBarChanged = true
        --elseif newState == SCENE_HIDDEN then
        end
	end)
end

PP.allianceWarSceneGroup = function()
	for _, scene in ipairs(DEFAULT_ALLIANCE_WAR_SCENES) do
		MainStuffMustDoneHere(scene.sceneObj, scene.someGlobalObj.control)
	end

	AdditionalStuff()
end