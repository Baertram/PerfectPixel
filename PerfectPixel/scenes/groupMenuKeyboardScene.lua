PP.groupMenuKeyboardScene = function()

	KEYBOARD_GROUP_MENU_SCENE:RemoveFragmentGroup(FRAGMENT_GROUP.FRAME_TARGET_STANDARD_RIGHT_PANEL)
	KEYBOARD_GROUP_MENU_SCENE:RemoveFragment(RIGHT_BG_FRAGMENT)
	KEYBOARD_GROUP_MENU_SCENE:RemoveFragment(TREE_UNDERLAY_FRAGMENT)
	KEYBOARD_GROUP_MENU_SCENE:RemoveFragment(TITLE_FRAGMENT)
	KEYBOARD_GROUP_MENU_SCENE:RemoveFragment(GROUP_TITLE_FRAGMENT)
	KEYBOARD_GROUP_MENU_SCENE:RemoveFragment(FRAME_EMOTE_FRAGMENT_SOCIAL)
	KEYBOARD_GROUP_MENU_SCENE:RemoveFragment(KEYBIND_STRIP_MUNGE_BACKDROP_FRAGMENT)

	ALLIANCE_WAR_FINDER_KEYBOARD.categoryData.categoryFragment.duration	= nil
	BATTLEGROUND_FINDER_KEYBOARD.categoryData.categoryFragment.duration	= nil
	DUNGEON_FINDER_KEYBOARD.categoryData.categoryFragment.duration		= nil
	GROUP_LIST_FRAGMENT.duration										= nil

	KEYBOARD_GROUP_MENU_SCENE:RegisterCallback("StateChange", function(oldState, newState)
		if newState == SCENE_SHOWING then
			PP.Anchor(ZO_DisplayName, --[[#1]] TOPLEFT, ZO_GroupMenu_Keyboard, TOPLEFT, -6, -6)
		elseif newState == SCENE_HIDDEN then
			PP.Anchor(ZO_DisplayName, --[[#1]] TOPLEFT, ZO_KeyboardFriendsList, TOPLEFT, 0, 0)
		end
	end)

	PP.mainBackdrop(ZO_GroupMenu_Keyboard,	'groupMenuKeyboard', --[[backdrop]] TOPLEFT, BOTTOMRIGHT, -10, -10, 0, 10, --[[tex]] PP.t.bg1, 8, 1, --[[bd]] 10, 10, 10, .8, --[[edge]] 0, 0, 0, 1, --[[texture]] true, .5)
	PP.mainBackdrop(ZO_KeybindStripControl,	'groupMenuKeyboard', --[[backdrop]] TOPLEFT, BOTTOMRIGHT, -6, 0, 2, 6, --[[tex]] PP.t.bg1, 8, 1, --[[bd]] 10, 10, 10, .6, --[[edge]] 0, 0, 0, 1, --[[texture]] false, 0)

	PP.Anchor(ZO_GroupMenu_Keyboard, --[[#1]] TOPRIGHT, GuiRoot, TOPRIGHT, 0, 90,	--[[#2]] true, BOTTOMRIGHT, GuiRoot, BOTTOMRIGHT, 1, -70)
	PP.Anchor(ZO_DungeonFinder_KeyboardListSection, --[[#1]] TOPLEFT, ZO_DungeonFinder_Keyboard, TOPLEFT, 0, 0,	--[[#2]] true, BOTTOMRIGHT, ZO_DungeonFinder_Keyboard, BOTTOMRIGHT, 22, 0)

	PP.Anchor(ZO_DungeonFinder_KeyboardQueueButton,			--[[#1]] BOTTOM, ZO_SearchingForGroup, BOTTOM, 0, -4)
	PP.Anchor(ZO_DungeonFinder_KeyboardLockReason,			--[[#1]] BOTTOM, ZO_DungeonFinder_Keyboard, BOTTOM, 0, 0)

	PP.Anchor(ZO_AllianceWarFinder_KeyboardQueueButton,		--[[#1]] BOTTOM, ZO_SearchingForGroup, BOTTOM, 0, -4)
	PP.Anchor(ZO_AllianceWarFinder_KeyboardLockReason,		--[[#1]] BOTTOM, ZO_AllianceWarFinder_Keyboard, BOTTOM, 0, 0)

	PP.Anchor(ZO_BattlegroundFinder_KeyboardQueueButton,	--[[#1]] BOTTOM, ZO_SearchingForGroup, BOTTOM, 0, -4)
	PP.Anchor(ZO_BattlegroundFinder_KeyboardLockReason,		--[[#1]] BOTTOM, ZO_BattlegroundFinder_Keyboard, BOTTOM, 0, 0)
	
	PP.Anchor(ZO_SearchingForGroupLeaveQueueButton,			--[[#1]] BOTTOM, ZO_SearchingForGroup, BOTTOM, 0, -40)

	PP.ListBackdrop(ZO_DungeonFinder_KeyboardListSection, -8, -3, -1, 3, --[[tex]] nil, 8, 0, --[[bd]] 5, 5, 5, .6, --[[edge]] 30, 30, 30, .6)
	PP.ScrollBar(ZO_DungeonFinder_KeyboardListSection,	--[[sb_c]] 180, 180, 180, .7, --[[bd_c]] 20, 20, 20, .7, --[[edge]] 40, 40, 40, .9)

	-- ZO_DungeonFinder_KeyboardListSection.useFadeGradient = nil
	ZO_Scroll_SetMaxFadeDistance(ZO_DungeonFinder_KeyboardListSection, 10)
end
