PP.enchantingScene = function()

	local enchantingScene = SCENE_MANAGER:GetScene('enchanting')
	enchantingScene:RemoveFragment(RIGHT_PANEL_BG_FRAGMENT)
	enchantingScene:RemoveFragment(KEYBIND_STRIP_MUNGE_BACKDROP_FRAGMENT)

	enchantingScene:RegisterCallback("StateChange", function(oldState, newState)
		if newState == SCENE_SHOWING then
			PP.Anchor(ZO_SharedRightPanelBackground, --[[#1]] TOPRIGHT,	nil, TOPRIGHT, 0, 60,	--[[#2]] true, BOTTOMLEFT, nil, BOTTOMRIGHT, -564, -50)
		elseif CS then
			if newState == SCENE_SHOWN then
				if CS.Account.option[8] then
					ZO_SharedRightPanelBackground:SetHidden(true)
					ZO_EnchantingTopLevel:SetHidden(true)
					ZO_EnchantingTopLevel.mainFrame:SetHidden(true)
					ZO_KeybindStripControl:SetHidden(true)
					ZO_KeybindStripControl.mainFrame:SetHidden(true)
				end
			end
		elseif newState == SCENE_HIDDEN then
			PP.Anchor(ZO_SharedRightPanelBackground, --[[#1]] RIGHT, nil, RIGHT, 0, 20,			--[[#2]] false, BOTTOMLEFT, nil, BOTTOMRIGHT, 0, 0)
		end
	end)	

	PP.mainBackdrop(ZO_EnchantingTopLevel, 'enchanting', --[[backdrop]] nil, BOTTOMRIGHT, -570, 105, 1, -74, --[[tex]] PP.t.bg1, 8, 1, --[[bd]] 10, 10, 10, .7, --[[edge]] 0, 0, 0, 1, --[[texture]] true, .5)
	PP.mainBackdrop(ZO_KeybindStripControl, 'enchanting', --[[backdrop]] TOPLEFT, BOTTOMRIGHT, -6, 0, 2, 6, --[[tex]] PP.t.bg1, 8, 1, --[[bd]] 10, 10, 10, .6, --[[edge]] 0, 0, 0, 1, --[[texture]] false, 0)

	PP.ListBackdrop(ZO_EnchantingTopLevelInventoryBackpack, -3, -3, -1, 3, --[[tex]] nil, 8, 0, --[[bd]] 5, 5, 5, .6, --[[edge]] 30, 30, 30, .6)
	PP.ScrollBar(ZO_EnchantingTopLevelInventoryBackpack,	--[[sb_c]] 180, 180, 180, .7, --[[bd_c]] 20, 20, 20, .7, --[[edge]] 40, 40, 40, .9)
end