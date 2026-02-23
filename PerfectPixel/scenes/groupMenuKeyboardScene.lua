local PP = PP ---@class PP
PP.groupMenuKeyboardScene = function()

	--KEYBOARD_GROUP_MENU_SCENE:RemoveFragment(FRAME_PLAYER_FRAGMENT)
	PP.RemoveFragmentFromSceneAndKeepPreviewFunctionality(KEYBOARD_GROUP_MENU_SCENE, FRAME_PLAYER_FRAGMENT, {"PreviewInventoryItem", "PreviewOutfit", "PreviewCollectible"}, PROMOTIONAL_EVENTS_PREVIEW_OPTIONS_FRAGMENT)

	KEYBOARD_GROUP_MENU_SCENE:RemoveFragment(RIGHT_BG_FRAGMENT)
	KEYBOARD_GROUP_MENU_SCENE:RemoveFragment(TREE_UNDERLAY_FRAGMENT)
	KEYBOARD_GROUP_MENU_SCENE:RemoveFragment(TITLE_FRAGMENT)
	KEYBOARD_GROUP_MENU_SCENE:RemoveFragment(GROUP_TITLE_FRAGMENT)
	KEYBOARD_GROUP_MENU_SCENE:RemoveFragment(FRAME_EMOTE_FRAGMENT_SOCIAL)

	PP:CreateBackground(ZO_GroupMenu_Keyboard, --[[#1]] nil, nil, nil, -10, -10, --[[#2]] nil, nil, nil, 0, 10)

	KEYBOARD_GROUP_MENU_SCENE:RegisterCallback("StateChange", function(oldState, newState)
		if newState == SCENE_SHOWING then
			PP.Anchor(ZO_DisplayName, --[[#1]] TOPLEFT, ZO_GroupMenu_Keyboard, TOPLEFT, -6, -6)
		elseif newState == SCENE_HIDDEN then
			PP.Anchor(ZO_DisplayName, --[[#1]] TOPLEFT, ZO_KeyboardFriendsList, TOPLEFT, 0, 0)
		end
	end)

	PP.Anchor(ZO_GroupMenu_Keyboard, --[[#1]] TOPRIGHT, GuiRoot, TOPRIGHT, 0, 120,	--[[#2]] true, BOTTOMRIGHT, GuiRoot, BOTTOMRIGHT, 0, -70)
	PP.Anchor(ZO_DungeonFinder_KeyboardListSection, --[[#1]] TOPLEFT, ZO_DungeonFinder_Keyboard, TOPLEFT, 0, 0,	--[[#2]] true, BOTTOMRIGHT, ZO_DungeonFinder_Keyboard, BOTTOMRIGHT, 20, -40)

	-- PP.Anchor(ZO_DungeonFinder_KeyboardActionButtonContainerQueueButton,			--[[#1]] BOTTOM, ZO_SearchingForGroup, BOTTOM, 0, -4)
	-- PP.Anchor(ZO_DungeonFinder_KeyboardLockReason,									--[[#1]] BOTTOM, ZO_DungeonFinder_Keyboard, BOTTOM, 0, 0)

	-- PP.Anchor(ZO_BattlegroundFinder_KeyboardActionButtonContainerQueueButton,		--[[#1]] BOTTOM, ZO_SearchingForGroup, BOTTOM, 0, -4)
	-- PP.Anchor(ZO_BattlegroundFinder_KeyboardLockReason,								--[[#1]] BOTTOM, ZO_BattlegroundFinder_Keyboard, BOTTOM, 0, 0)

	-- PP.Anchor(ZO_SearchingForGroupLeaveQueueButton,									--[[#1]] BOTTOM, ZO_SearchingForGroup, BOTTOM, 0, -40)

	PP.ScrollBar(ZO_DungeonFinder_KeyboardListSection)

	ZO_Scroll_SetMaxFadeDistance(ZO_DungeonFinder_KeyboardListSection, 10)

    --- ???
    -- Endeavours - TIMED_ACTIVITIES_KEYBOARD removed in updated 101049!
    if GetAPIVersion() <= 101048 then
        local sceneFragmentsShown = {}

        TIMED_ACTIVITIES_FRAGMENT:RegisterCallback("StateChange", function (oldState, newState)
            if newState == SCENE_FRAGMENT_SHOWN and not sceneFragmentsShown[TIMED_ACTIVITIES_FRAGMENT] then
                local timedActivitiesKeyboard = TIMED_ACTIVITIES_KEYBOARD
                local timedActivitiesScrollChild = timedActivitiesKeyboard.activitiesScrollChild
                if timedActivitiesScrollChild then
                    PP.Bars(timedActivitiesScrollChild, true, 18, 16, nil, nil, true)
                    -- Move the progessBar a bit to the right to show the left edge
                    for i = 1, timedActivitiesScrollChild:GetNumChildren(), 1 do
                        local childCtrl = timedActivitiesScrollChild:GetChild(i)
                        if childCtrl ~= nil then
                            local name = childCtrl:GetNamedChild("Name")
                            local progressBar = childCtrl:GetNamedChild("ProgressBar")
                            local rewardContainer = childCtrl:GetNamedChild("RewardContainer")
                            if name ~= nil and rewardContainer ~= nil and progressBar ~= nil then
                                -- Do not use PP.Anchor, else it will call ClearAnchors() and break the right (2nd) anchor
                                progressBar:SetAnchor(TOPLEFT, name, BOTTOMLEFT, 2, 5)
                            end
                        end
                    end
                end
                sceneFragmentsShown[TIMED_ACTIVITIES_FRAGMENT] = true
            end
        end)
    end

	--API101044 Golden pursuits - PROMOTIONAL_EVENTS_PREVIEW_OPTIONS_FRAGMENT
	local goldenPursuitsFragment = PROMOTIONAL_EVENTS_PREVIEW_OPTIONS_FRAGMENT
	local goldenPursuitsKeyboard = PROMOTIONAL_EVENTS_KEYBOARD

	local function reanchorGoldenPursuitControls()
		local goldenPursuitsScrollList = goldenPursuitsKeyboard.activityList
		local orig_ScrollListDataType1SetupCallback = goldenPursuitsScrollList.dataTypes[1].setupCallback
		local goldenPursuitsCampaignPanel = ZO_PromotionalEvents_KeyboardTLContentsCampaignPanel
		local goldenPursuitsCampaignPanelBG = goldenPursuitsCampaignPanel:GetNamedChild("BG")
		local goldenPursuitsCampaignPanelName = goldenPursuitsCampaignPanel:GetNamedChild("Name") --ZO_PromotionalEvents_KeyboardTLContentsCampaignPanelName
		local goldenPursuitsCampaignPanelDuration = goldenPursuitsCampaignPanel:GetNamedChild("Duration") --ZO_PromotionalEvents_KeyboardTLContentsCampaignPanelDuration
		local goldenPursuitsCampaignPanelProgress = goldenPursuitsCampaignPanel:GetNamedChild("Progress")
		local goldenPursuitsCampaignPanelHelp = goldenPursuitsCampaignPanel:GetNamedChild("Help")

		--Hide the image at the top of Golden Pursuits and move the list etc. to the top
		goldenPursuitsCampaignPanelBG:SetHidden(true)      --Title Background
		goldenPursuitsCampaignPanelHelp:SetHidden(true)    --Help Icon

		goldenPursuitsCampaignPanelName:ClearAnchors() --Name
		goldenPursuitsCampaignPanelName:SetAnchor(TOPLEFT, goldenPursuitsCampaignPanel, TOPLEFT, 0, -75, ANCHOR_CONSTRAINS_XY)

		goldenPursuitsCampaignPanelDuration:ClearAnchors() --Duration
		goldenPursuitsCampaignPanelDuration:SetAnchor(TOPRIGHT, goldenPursuitsCampaignPanel, TOPRIGHT, 0, -73, ANCHOR_CONSTRAINS_XY)

		goldenPursuitsCampaignPanelProgress:ClearAnchors() --Progress bar
		goldenPursuitsCampaignPanelProgress:SetAnchor(TOPLEFT,	goldenPursuitsCampaignPanelName, BOTTOMLEFT, 9, 120)

		return goldenPursuitsScrollList, goldenPursuitsCampaignPanelProgress, orig_ScrollListDataType1SetupCallback
	end
	PP.ReanchorGoldenPursuitControls = reanchorGoldenPursuitControls

	PP.onDeferredInitCheck(PROMOTIONAL_EVENTS_KEYBOARD, function()
--d("[PP]GoldenPursuits - onDeferredInitCheck")
		goldenPursuitsFragment:RegisterCallback("StateChange", function(oldState, newState)
			goldenPursuitsKeyboard = goldenPursuitsKeyboard or PROMOTIONAL_EVENTS_KEYBOARD
			if newState == SCENE_FRAGMENT_SHOWN then --and not sceneFragmentsShown[goldenPursuitsFragment] then
	--d("[PP]GoldenPursuits - Shown")
				local goldenPursuitsScrollList, goldenPursuitsCampaignPanelProgress, orig_ScrollListDataType1SetupCallback = reanchorGoldenPursuitControls()

				--List
				goldenPursuitsScrollList:ClearAnchors() --Scroll List
				goldenPursuitsScrollList:SetAnchor(TOPLEFT,	goldenPursuitsCampaignPanelProgress, BOTTOMLEFT, 0, 20)
				goldenPursuitsScrollList:SetAnchor(BOTTOMRIGHT, nil, BOTTOMRIGHT, 0, 0)
				ZO_Scroll_SetMaxFadeDistance(goldenPursuitsScrollList, PP.savedVars.ListStyle.list_fade_distance)
				ZO_ScrollList_Commit(goldenPursuitsScrollList)

				if not sceneFragmentsShown[goldenPursuitsFragment] then
					local goldenPursuitScrollListContents = goldenPursuitsScrollList:GetNamedChild("Contents")
					if goldenPursuitScrollListContents then

						goldenPursuitsScrollList.dataTypes[1].setupCallback = function(ctrl, ...)
							orig_ScrollListDataType1SetupCallback(ctrl, ...)
							local progressBar = ctrl:GetNamedChild("Progress")
							if progressBar then
								PP.Bar(progressBar, 18, 16, nil, nil, true)
							end
						end

						--Change the overall campaign bar
						PP.Bar(goldenPursuitsKeyboard.campaignProgress, 18, 16, nil, nil, true)

						--Change the bars of each possible task
						PP.Bars(goldenPursuitScrollListContents, true, 18, 16, nil, nil, true)
						--Move the progessBar of the tasks a bit to the right to show the left edge
						for i=1, goldenPursuitScrollListContents:GetNumChildren(), 1 do
							local childCtrl = goldenPursuitScrollListContents:GetChild(i)
							if childCtrl ~= nil then
								local name = childCtrl:GetNamedChild("Name")
								local progressBar = childCtrl:GetNamedChild("ProgressBar")
								local rewardContainer = childCtrl:GetNamedChild("RewardContainer")
								if name ~= nil and rewardContainer ~= nil and progressBar ~= nil then
									--Do not use PP.Anchor, else it will call ClearAnchors() and break the right (2nd) anchor
									progressBar:SetAnchor(TOPLEFT, name, BOTTOMLEFT, 2, 5)
								end
							end
						end

						PP.ScrollBar(goldenPursuitsScrollList)
					end
				end
				sceneFragmentsShown[PROMOTIONAL_EVENTS_PREVIEW_OPTIONS_FRAGMENT] = true
			end
		end)
	end, nil, 1)

	--Tribute finder
	local tributeFinderObj = TRIBUTE_FINDER_KEYBOARD
	local tributeFinderClubRankControl = tributeFinderObj.clubRankControl
	local tributeFinderClubRankControlXPBar = GetControl(tributeFinderClubRankControl, "XPBar") --ZO_TributeFinder_KeyboardClubRankXPBar
	PP.Bar(tributeFinderClubRankControlXPBar, 14, 15, nil, nil, true)
end
