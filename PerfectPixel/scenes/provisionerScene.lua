PP.provisionerScene = function()

	local provisionerScene = SCENE_MANAGER:GetScene('provisioner')
	provisionerScene:RemoveFragment(RIGHT_PANEL_BG_FRAGMENT)
	provisionerScene:RemoveFragment(KEYBIND_STRIP_MUNGE_BACKDROP_FRAGMENT)

	provisionerScene:RegisterCallback("StateChange", function(oldState, newState)
		if newState == SCENE_SHOWING or newState == SCENE_SHOWN then
			PP.Anchor(ZO_SharedRightPanelBackground,	--[[#1]] TOPRIGHT,	nil, TOPRIGHT, 0, 60,	--[[#2]] true, BOTTOMLEFT, nil, BOTTOMRIGHT, -564, -50)
			PP.Anchor(ZO_ProvisionerTopLevelTabs,		--[[#1]] TOPRIGHT,	ZO_SharedRightPanelBackground, TOPRIGHT, -20, 10)
			if ESOMRL then
				if CS and CS.Account.option[7] then
					return
				else
					PP.Anchor(ESOMRL, --[[#1]] TOPLEFT,	ZO_ProvisionerTopLevelNavigationContainer, TOPLEFT, 0, -100)
				end
			end
			if CS and CS.Account.option[7] then
				ZO_SharedRightPanelBackground:SetHidden(true)
				ZO_ProvisionerTopLevel:SetHidden(true)
				ZO_ProvisionerTopLevel.mainFrame:SetHidden(true)
				ZO_KeybindStripControl:SetHidden(true)
				ZO_KeybindStripControl.mainFrame:SetHidden(true)
			end
		elseif newState == SCENE_HIDDEN then
			PP.Anchor(ZO_SharedRightPanelBackground,	--[[#1]] RIGHT, nil, RIGHT, 0, 20,			--[[#2]] false, BOTTOMLEFT, nil, BOTTOMRIGHT, 0, 0)
		end
	end)

	PP.mainBackdrop(ZO_ProvisionerTopLevel, 'provisioner', --[[backdrop]] nil, BOTTOMRIGHT, -570, 55, 1, -74, --[[tex]] PP.t.bg1, 8, 1, --[[bd]] 10, 10, 10, .7, --[[edge]] 0, 0, 0, 1, --[[texture]] true, .5)
	PP.mainBackdrop(ZO_KeybindStripControl, 'provisioner', --[[backdrop]] TOPLEFT, BOTTOMRIGHT, -6, 0, 2, 6, --[[tex]] PP.t.bg1, 8, 1, --[[bd]] 10, 10, 10, .6, --[[edge]] 0, 0, 0, 1, --[[texture]] false, 0)

	PP.ListBackdrop(ZO_ProvisionerTopLevelNavigationContainer, -3, -3, -1, 3, --[[tex]] nil, 8, 0, --[[bd]] 5, 5, 5, .6, --[[edge]] 30, 30, 30, .6)
	PP.ScrollBar(ZO_ProvisionerTopLevelNavigationContainer,	--[[sb_c]] 180, 180, 180, .7, --[[bd_c]] 20, 20, 20, .7, --[[edge]] 40, 40, 40, .9)

	-- ZO_ProvisionerTopLevelNavigationContainer.useFadeGradient = nil
	ZO_Scroll_SetMaxFadeDistance(ZO_ProvisionerTopLevelNavigationContainer, 10)
	PP.Anchor(ZO_ProvisionerTopLevelNavigationContainer, --[[#1]] TOPLEFT,	ZO_ProvisionerTopLevelNavigationDivider, BOTTOMLEFT, 26, 0,	--[[#2]] true, BOTTOMLEFT, ZO_ProvisionerTopLevelDetailsDivider, TOPLEFT, 16, 0)
	ZO_ProvisionerTopLevelNavigationContainer:SetWidth(565)

	PP.Anchor(ZO_ProvisionerTopLevelMenuBarDivider,		--[[#1]] TOPRIGHT,	ZO_ProvisionerTopLevelTabs, TOPRIGHT, 0, 0)
	PP.Anchor(ZO_ProvisionerTopLevelHaveIngredients,	--[[#1]] TOPLEFT, ZO_ProvisionerTopLevelNavigationContainer, TOPLEFT, 6, -55)
	PP.Anchor(ZO_ProvisionerTopLevelHaveSkills,			--[[#1]] TOPLEFT, ZO_ProvisionerTopLevelHaveIngredients, TOPLEFT, 0, 26)

	ZO_ProvisionerTopLevelNavigationDivider:SetHidden(true)
	ZO_ProvisionerTopLevelDetailsDivider:SetHidden(true)
	ZO_ProvisionerTopLevelMenuBarDivider:SetHidden(true)

	ZO_ProvisionerTopLevelDetailsIngredientsLabel:SetHidden(true)
	PP.Anchor(ZO_ProvisionerTopLevelDetailsIngredients, --[[#1]] TOPLEFT, ZO_ProvisionerTopLevelNavigationContainer, BOTTOMLEFT, 5, 10)	

	ZO_PreHookHandler(ZO_ProvisionerTopLevelTabsLabel, 'OnTextChanged', function()
		ZO_ProvisionerTopLevelTabsLabel:SetFont("PerfectPixel/fonts/univers67.otf|16|outline")
	end)
end