PP.notificationsScene = function()

--ZO_Notifications--notifications--NOTIFICATIONS_SCENE---------------------------------------------
	NOTIFICATIONS_SCENE:RemoveFragment(KEYBIND_STRIP_MUNGE_BACKDROP_FRAGMENT)
	-- NOTIFICATIONS_SCENE:RemoveFragment(END_IN_WORLD_INTERACTIONS_FRAGMENT)
	NOTIFICATIONS_SCENE:RemoveFragment(FRAME_TARGET_STANDARD_RIGHT_PANEL_FRAGMENT)
	NOTIFICATIONS_SCENE:RemoveFragment(FRAME_TARGET_BLUR_STANDARD_RIGHT_PANEL_FRAGMENT)
	NOTIFICATIONS_SCENE:RemoveFragment(RIGHT_BG_FRAGMENT)
	NOTIFICATIONS_SCENE:RemoveFragment(TITLE_FRAGMENT)
	NOTIFICATIONS_SCENE:RemoveFragment(NOTIFICATIONS_TITLE_FRAGMENT)
	NOTIFICATIONS_SCENE:RemoveFragment(FRAME_PLAYER_FRAGMENT)
	-- NOTIFICATIONS_SCENE:RemoveFragment(FRAME_EMOTE_FRAGMENT_SOCIAL)

	PP.mainBackdrop(ZO_Notifications,		'notifications', --[[Backdrop]] TOPLEFT,	BOTTOMRIGHT, 	-10, -10, 0, 10, --[[tex]] PP.t.bg1, 8, 1, --[[bd]]	10, 10, 10, .8, --[[edge]]	0, 0, 0, 1, --[[texture]] true, .5)
	PP.mainBackdrop(ZO_KeybindStripControl,	'notifications', --[[backdrop]] TOPLEFT, BOTTOMRIGHT, -6, 0, 2, 6, --[[tex]] PP.t.bg1, 8, 1, --[[bd]] 10, 10, 10, .6, --[[edge]] 0, 0, 0, 1, --[[texture]] false, 0)

	PP.Anchor(ZO_Notifications, --[[#1]] TOPRIGHT, GuiRoot, TOPRIGHT, 0, 90,	--[[#2]] true, BOTTOMRIGHT, GuiRoot, BOTTOMRIGHT, 1, -70)

	ZO_ScrollList_Commit(ZO_NotificationsList)
---------------------------------------------------------------------------------------------------
end