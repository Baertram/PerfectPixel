local PP = PP ---@class PP
local removeFragmentsFromScene = PP.removeFragmentsFromScene

local DEFAULT_ALLIANCE_WAR_SCENES = {
	{ scene = CAMPAIGN_OVERVIEW_SCENE, gVar = CAMPAIGN_OVERVIEW, },
	{ scene = CAMPAIGN_BROWSER_SCENE, gVar = CAMPAIGN_BROWSER, },
}

local FRAGMENTS_TO_REMOVE = {
	FRAME_PLAYER_FRAGMENT,
	RIGHT_BG_FRAGMENT,
	TREE_UNDERLAY_FRAGMENT,
	TITLE_FRAGMENT,
	ALLIANCE_WAR_TITLE_FRAGMENT,
}

local function EditScene(scene, topLevelControl, editElementsFunc, ...)
	-- Remove fragments from the current scene
	removeFragmentsFromScene(scene, FRAGMENTS_TO_REMOVE)

	PP:CreateBackground(topLevelControl, --[[#1]] nil, nil, nil, -10, -10, --[[#2]] nil, nil, nil, 0, 10)
	PP.Anchor(topLevelControl, --[[#1]] TOPRIGHT, GuiRoot, TOPRIGHT, 0, 120, --[[#2]] true, BOTTOMRIGHT, GuiRoot, BOTTOMRIGHT, 0, -70)

	if type(editElementsFunc) == "function" then
		editElementsFunc(...)
	end
end
PP.allianceWarSceneGroupEditScene = EditScene

local function EditElements()
--ZO_CampaignOverview------------------------------------------------------------------------------------------------------------------------------
	PP.Anchor(ZO_CampaignOverviewCategories, --[[#1]] TOPLEFT, ZO_CampaignOverview, TOPLEFT, 0, 68)
	PP.Anchor(ZO_CampaignSelector, --[[#1]] BOTTOMRIGHT, ZO_CampaignOverviewTopDivider, TOPRIGHT, -165, 25)


	--PTS API101048 2025-09-19
	if VENGEANCE_PERKS_KEYBOARD then
		local function EmptyCellHidden(control, data)
			if data.isEmptyCell then
				control:SetHidden(true)
			end
		end

		PP.onDeferredInitCheck(VENGEANCE_PERKS_KEYBOARD, function()
			PP.ScrollBar(ZO_Vengeance_Perks_Keyboard_TopLevelListContainerListScrollBar)

			local dataType00 = ZO_ScrollList_GetDataTypeTable(ZO_Vengeance_Perks_Keyboard_TopLevelListContainerList, 1)
			local existingSetupCallback00 = dataType00.setupCallback
			dataType00["controlHeight"] = 120
			dataType00["controlWidth"] = 180
			dataType00["spacingX"] = 6
			dataType00["spacingY"] = 6
			dataType00.setupCallback = function(control, data)
				existingSetupCallback00(control, data)
				EmptyCellHidden(control, data)

				control:SetDimensions(dataType00["controlWidth"], dataType00["controlHeight"])
				if control:GetNamedChild("OverlayBorder") then
					local backdrop = control:GetNamedChild("OverlayBorder")
					backdrop:SetCenterColor(10/255, 10/255, 10/255, 0.7)
					backdrop:SetCenterTexture("", 4, 0)
					backdrop:SetEdgeColor(40/255, 40/255, 40/255, 0.9)
					backdrop:SetEdgeTexture("", 1, 1, 1, 0)
					backdrop:SetInsets(1, 1, -1, -1)
					backdrop:SetDrawLayer(0)
					backdrop:SetDrawTier(0)
				end
				if control:GetNamedChild("Highlight") then
					local highlight = control:GetNamedChild("Highlight")
					highlight:SetTextureCoords(0.29, 0.575, 0.002, 0.3)
					PP.Anchor(highlight, --[[#1]] TOPLEFT, control, TOPLEFT, 1, 1, --[[#2]] true, BOTTOMRIGHT, control, BOTTOMRIGHT,	-1, -1)
				end
				if control:GetNamedChild("Title") then
					local title = control:GetNamedChild("Title")
					PP.Font(title, --[[Font]] PP.f.u67, 16, "outline")
				end
			end
		end, nil)
	end

--ZO_CampaignBrowser
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
		EditScene(scene.scene, scene.gVar.control)
	end

	EditElements()
end