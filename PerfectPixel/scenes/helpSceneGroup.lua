PP.helpSceneGroup = function()

--ZO_Help  helpTutorials---------------------------------------------------------------------------
	local helpTutorialsScene = SCENE_MANAGER:GetScene("helpTutorials")
	helpTutorialsScene:RemoveFragment(KEYBIND_STRIP_MUNGE_BACKDROP_FRAGMENT)
	-- helpTutorialsScene:RemoveFragment(END_IN_WORLD_INTERACTIONS_FRAGMENT)
	helpTutorialsScene:RemoveFragment(FRAME_TARGET_STANDARD_RIGHT_PANEL_FRAGMENT)
	helpTutorialsScene:RemoveFragment(FRAME_TARGET_BLUR_STANDARD_RIGHT_PANEL_FRAGMENT)
	helpTutorialsScene:RemoveFragment(RIGHT_BG_FRAGMENT)
	helpTutorialsScene:RemoveFragment(TREE_UNDERLAY_FRAGMENT)
	helpTutorialsScene:RemoveFragment(TITLE_FRAGMENT)
	helpTutorialsScene:RemoveFragment(HELP_TITLE_FRAGMENT)
	helpTutorialsScene:RemoveFragment(FRAME_PLAYER_FRAGMENT)

	helpTutorialsScene:RegisterCallback("StateChange", function(oldState, newState)
		if newState == SCENE_SHOWING then
			PP.Anchor(ZO_MainMenuSceneGroupBar, --[[#1]] TOPRIGHT, GuiRoot, TOPRIGHT, -30, 64)
		elseif newState == SCENE_HIDDEN then
			PP.Anchor(ZO_MainMenuSceneGroupBar, --[[#1]] RIGHT, GuiRoot, RIGHT, -40, -340)
		end
	end)

	PP.mainBackdrop(ZO_Help, 'helpTutorials', --[[Backdrop]] TOPLEFT,	BOTTOMRIGHT, 	-10, -10, 0, 10, --[[tex]] PP.t.bg1, 8, 1, --[[bd]]	10, 10, 10, .8, --[[edge]]	0, 0, 0, 1, --[[texture]] true, .5)
	PP.mainBackdrop(ZO_KeybindStripControl, 'helpTutorials', --[[backdrop]] TOPLEFT, BOTTOMRIGHT, -6, 0, 2, 6, --[[tex]] PP.t.bg1, 8, 1, --[[bd]] 10, 10, 10, .6, --[[edge]] 0, 0, 0, 1, --[[texture]] false, 0)

	PP.Anchor(ZO_Help, --[[#1]] TOPRIGHT, GuiRoot, TOPRIGHT, 0, 120,	--[[#2]] true, BOTTOMRIGHT, GuiRoot, BOTTOMRIGHT, 1, -70)

--ZO_HelpCustomerService_Keyboard  helpCustomerSupport  HELP_CUSTOMER_SUPPORT_SCENE----------------
	HELP_CUSTOMER_SUPPORT_SCENE:RemoveFragment(KEYBIND_STRIP_MUNGE_BACKDROP_FRAGMENT)
	HELP_CUSTOMER_SUPPORT_SCENE:RemoveFragment(END_IN_WORLD_INTERACTIONS_FRAGMENT)
	HELP_CUSTOMER_SUPPORT_SCENE:RemoveFragment(FRAME_TARGET_STANDARD_RIGHT_PANEL_FRAGMENT)
	HELP_CUSTOMER_SUPPORT_SCENE:RemoveFragment(FRAME_TARGET_BLUR_STANDARD_RIGHT_PANEL_FRAGMENT)
	HELP_CUSTOMER_SUPPORT_SCENE:RemoveFragment(RIGHT_BG_FRAGMENT)
	HELP_CUSTOMER_SUPPORT_SCENE:RemoveFragment(TREE_UNDERLAY_FRAGMENT)
	HELP_CUSTOMER_SUPPORT_SCENE:RemoveFragment(TITLE_FRAGMENT)
	HELP_CUSTOMER_SUPPORT_SCENE:RemoveFragment(HELP_TITLE_FRAGMENT)
	HELP_CUSTOMER_SUPPORT_SCENE:RemoveFragment(FRAME_PLAYER_FRAGMENT)

	HELP_CUSTOMER_SUPPORT_SCENE:RegisterCallback("StateChange", function(oldState, newState)
		if newState == SCENE_SHOWING then
			PP.Anchor(ZO_MainMenuSceneGroupBar, --[[#1]] TOPRIGHT, GuiRoot, TOPRIGHT, -30, 64)
		elseif newState == SCENE_HIDDEN then
			PP.Anchor(ZO_MainMenuSceneGroupBar, --[[#1]] RIGHT, GuiRoot, RIGHT, -40, -340)
		end
	end)

	PP.mainBackdrop(ZO_HelpCustomerService_Keyboard, 'helpCustomerSupport', --[[Backdrop]] TOPLEFT,	BOTTOMRIGHT, 	-10, -10, 0, 10, --[[tex]] PP.t.bg1, 8, 1, --[[bd]]	10, 10, 10, .8, --[[edge]]	0, 0, 0, 1, --[[texture]] true, .5)
	PP.mainBackdrop(ZO_KeybindStripControl, 'helpCustomerSupport', --[[backdrop]] TOPLEFT, BOTTOMRIGHT, -6, 0, 2, 6, --[[tex]] PP.t.bg1, 8, 1, --[[bd]] 10, 10, 10, .6, --[[edge]] 0, 0, 0, 1, --[[texture]] false, 0)

	PP.Anchor(ZO_HelpCustomerService_Keyboard, --[[#1]] TOPRIGHT, GuiRoot, TOPRIGHT, 0, 120,	--[[#2]] true, BOTTOMRIGHT, GuiRoot, BOTTOMRIGHT, 1, -70)

--ZO_PlayerEmote_Keyboard  helpEmotes  HELP_EMOTES_SCENE-------------------------------------------
	HELP_EMOTES_SCENE:RemoveFragment(KEYBIND_STRIP_MUNGE_BACKDROP_FRAGMENT)
	HELP_EMOTES_SCENE:RemoveFragment(END_IN_WORLD_INTERACTIONS_FRAGMENT)
	HELP_EMOTES_SCENE:RemoveFragment(FRAME_TARGET_STANDARD_RIGHT_PANEL_FRAGMENT)
	HELP_EMOTES_SCENE:RemoveFragment(FRAME_TARGET_BLUR_STANDARD_RIGHT_PANEL_FRAGMENT)
	HELP_EMOTES_SCENE:RemoveFragment(RIGHT_BG_FRAGMENT)
	HELP_EMOTES_SCENE:RemoveFragment(TREE_UNDERLAY_FRAGMENT)
	HELP_EMOTES_SCENE:RemoveFragment(TITLE_FRAGMENT)
	HELP_EMOTES_SCENE:RemoveFragment(HELP_TITLE_FRAGMENT)
	HELP_EMOTES_SCENE:RemoveFragment(FRAME_PLAYER_FRAGMENT)

	HELP_EMOTES_SCENE:RegisterCallback("StateChange", function(oldState, newState)
		if newState == SCENE_SHOWING then
			PP.Anchor(ZO_MainMenuSceneGroupBar, --[[#1]] TOPRIGHT, GuiRoot, TOPRIGHT, -30, 64)
		elseif newState == SCENE_HIDDEN then
			PP.Anchor(ZO_MainMenuSceneGroupBar, --[[#1]] RIGHT, GuiRoot, RIGHT, -40, -340)
		end
	end)

	PP.mainBackdrop(ZO_PlayerEmote_Keyboard, 'helpEmotes', --[[Backdrop]] TOPLEFT,	BOTTOMRIGHT, 	-10, -10, 0, 10, --[[tex]] PP.t.bg1, 8, 1, --[[bd]]	10, 10, 10, .8, --[[edge]]	0, 0, 0, 1, --[[texture]] true, .5)
	PP.mainBackdrop(ZO_KeybindStripControl, 'helpEmotes', --[[backdrop]] TOPLEFT, BOTTOMRIGHT, -6, 0, 2, 6, --[[tex]] PP.t.bg1, 8, 1, --[[bd]] 10, 10, 10, .6, --[[edge]] 0, 0, 0, 1, --[[texture]] false, 0)

	PP.Anchor(ZO_PlayerEmote_Keyboard, --[[#1]] TOPRIGHT, GuiRoot, TOPRIGHT, 0, 120,	--[[#2]] true, BOTTOMRIGHT, GuiRoot, BOTTOMRIGHT, 1, -70)

---------------------------------------------------------------------------------------------------
end

