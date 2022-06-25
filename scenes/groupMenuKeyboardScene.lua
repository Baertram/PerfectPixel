PP.groupMenuKeyboardScene = function()
	local sceneFragmentsShown = {}

	KEYBOARD_GROUP_MENU_SCENE:RemoveFragment(FRAME_PLAYER_FRAGMENT)
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

	PP.Anchor(ZO_GroupMenu_Keyboard, --[[#1]] TOPRIGHT, GuiRoot, TOPRIGHT, 0, 90,	--[[#2]] true, BOTTOMRIGHT, GuiRoot, BOTTOMRIGHT, 0, -70)
	PP.Anchor(ZO_DungeonFinder_KeyboardListSection, --[[#1]] TOPLEFT, ZO_DungeonFinder_Keyboard, TOPLEFT, 0, 0,	--[[#2]] true, BOTTOMRIGHT, ZO_DungeonFinder_Keyboard, BOTTOMRIGHT, 20, 0)

	PP.Anchor(ZO_DungeonFinder_KeyboardActionButtonContainerQueueButton or ZO_DungeonFinder_KeyboardQueueButton,			--[[#1]] BOTTOM, ZO_SearchingForGroup, BOTTOM, 0, -4)
	PP.Anchor(ZO_DungeonFinder_KeyboardLockReason,			--[[#1]] BOTTOM, ZO_DungeonFinder_Keyboard, BOTTOM, 0, 0)

	PP.Anchor(ZO_BattlegroundFinder_KeyboardActionButtonContainerQueueButton or ZO_BattlegroundFinder_KeyboardQueueButton,	--[[#1]] BOTTOM, ZO_SearchingForGroup, BOTTOM, 0, -4)
	PP.Anchor(ZO_BattlegroundFinder_KeyboardLockReason,		--[[#1]] BOTTOM, ZO_BattlegroundFinder_Keyboard, BOTTOM, 0, 0)
	
	PP.Anchor(ZO_SearchingForGroupLeaveQueueButton,			--[[#1]] BOTTOM, ZO_SearchingForGroup, BOTTOM, 0, -40)

	PP.ScrollBar(ZO_DungeonFinder_KeyboardListSection,	--[[sb_c]] 180, 180, 180, .7, --[[bd_c]] 20, 20, 20, .7, false)

	ZO_Scroll_SetMaxFadeDistance(ZO_DungeonFinder_KeyboardListSection, 10)


	--Endeavours - TIMED_ACTIVITIES_KEYBOARD
	TIMED_ACTIVITIES_FRAGMENT:RegisterCallback("StateChange", function(oldState, newState)
		if newState == SCENE_FRAGMENT_SHOWN and not sceneFragmentsShown[TIMED_ACTIVITIES_FRAGMENT] then
			local timedActivitiesKeyboard = TIMED_ACTIVITIES_KEYBOARD
			local timedActivitiesScrollChild = timedActivitiesKeyboard.activitiesScrollChild
			if timedActivitiesScrollChild then
				PP.Bars(timedActivitiesScrollChild, true, nil, nil, nil, nil, false, 0, 2)
			end
			sceneFragmentsShown[TIMED_ACTIVITIES_FRAGMENT] = true
		end
	end)
end
