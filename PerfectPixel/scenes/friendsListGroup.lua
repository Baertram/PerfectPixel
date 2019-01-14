PP.friendsListGroup = function()

--friendsList--ZO_KeyboardFriendsList--------------------------------------------------------------------
	local friendsListScene = SCENE_MANAGER:GetScene('friendsList')
	
	friendsListScene:RemoveFragmentGroup(FRAGMENT_GROUP.FRAME_TARGET_STANDARD_RIGHT_PANEL)
	friendsListScene:RemoveFragment(FRAME_EMOTE_FRAGMENT_SOCIAL)
	friendsListScene:RemoveFragment(RIGHT_BG_FRAGMENT)
	friendsListScene:RemoveFragment(TITLE_FRAGMENT)
	friendsListScene:RemoveFragment(CONTACTS_TITLE_FRAGMENT)
	friendsListScene:RemoveFragment(KEYBIND_STRIP_MUNGE_BACKDROP_FRAGMENT)

	friendsListScene:RegisterCallback("StateChange", function(oldState, newState)
		if newState == SCENE_SHOWING then
			PP.Anchor(ZO_MainMenuSceneGroupBar, --[[#1]] TOPRIGHT, GuiRoot, TOPRIGHT, -30, 64)
			ZO_ScrollList_Commit(ZO_KeyboardFriendsListList)
		elseif newState == SCENE_HIDDEN then
			PP.Anchor(ZO_MainMenuSceneGroupBar, --[[#1]] RIGHT, GuiRoot, RIGHT, -40, -340)
		end
	end)

	PP.mainBackdrop(ZO_KeyboardFriendsList,		'friendsList', --[[backdrop]] TOPLEFT, BOTTOMRIGHT, -10, -10, 0, 10,	--[[tex]] PP.t.bg1, 8, 1, --[[bd]] 10, 10, 10, .8, --[[edge]] 0, 0, 0, 1, --[[texture]] true, .5)
	PP.mainBackdrop(ZO_KeybindStripControl,	'friendsList', --[[backdrop]] TOPLEFT, BOTTOMRIGHT, -6, 0, 2, 6,		--[[tex]] PP.t.bg1, 8, 1, --[[bd]] 10, 10, 10, .6, --[[edge]] 0, 0, 0, 1, --[[texture]] false, 0)
	
	PP.Anchor(ZO_KeyboardFriendsList, --[[#1]] TOPRIGHT, GuiRoot, TOPRIGHT, 0, 120, --[[#2]] true, BOTTOMRIGHT, GuiRoot, BOTTOMRIGHT,	1, -70)


--ignoreList--ZO_KeyboardIgnoreList--------------------------------------------------------------------
	local ignoreListScene = SCENE_MANAGER:GetScene('ignoreList')
	
	ignoreListScene:RemoveFragmentGroup(FRAGMENT_GROUP.FRAME_TARGET_STANDARD_RIGHT_PANEL)
	ignoreListScene:RemoveFragment(FRAME_EMOTE_FRAGMENT_SOCIAL)
	ignoreListScene:RemoveFragment(RIGHT_BG_FRAGMENT)
	ignoreListScene:RemoveFragment(TITLE_FRAGMENT)
	ignoreListScene:RemoveFragment(CONTACTS_TITLE_FRAGMENT)
	ignoreListScene:RemoveFragment(KEYBIND_STRIP_MUNGE_BACKDROP_FRAGMENT)

	ignoreListScene:RegisterCallback("StateChange", function(oldState, newState)
		if newState == SCENE_SHOWING then
			PP.Anchor(ZO_MainMenuSceneGroupBar, --[[#1]] TOPRIGHT, GuiRoot, TOPRIGHT, -30, 64)
			ZO_ScrollList_Commit(ZO_KeyboardIgnoreListList)
		elseif newState == SCENE_HIDDEN then
			PP.Anchor(ZO_MainMenuSceneGroupBar, --[[#1]] RIGHT, GuiRoot, RIGHT, -40, -340)
		end
	end)

	PP.mainBackdrop(ZO_KeyboardIgnoreList,		'ignoreList', --[[backdrop]] TOPLEFT, BOTTOMRIGHT, -10, -10, 0, 10,	--[[tex]] PP.t.bg1, 8, 1, --[[bd]] 10, 10, 10, .8, --[[edge]] 0, 0, 0, 1, --[[texture]] true, .5)
	PP.mainBackdrop(ZO_KeybindStripControl,	'ignoreList', --[[backdrop]] TOPLEFT, BOTTOMRIGHT, -6, 0, 2, 6,		--[[tex]] PP.t.bg1, 8, 1, --[[bd]] 10, 10, 10, .6, --[[edge]] 0, 0, 0, 1, --[[texture]] false, 0)
	
	PP.Anchor(ZO_KeyboardIgnoreList, --[[#1]] TOPRIGHT, GuiRoot, TOPRIGHT, 0, 120, --[[#2]] true, BOTTOMRIGHT, GuiRoot, BOTTOMRIGHT,	1, -70)

end



