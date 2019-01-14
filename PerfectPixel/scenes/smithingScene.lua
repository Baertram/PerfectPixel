PP.smithingScene = function()
	local tab1 = {ZO_SmithingTopLevelRefinementPanelInventoryBackpack, ZO_SmithingTopLevelDeconstructionPanelInventoryBackpack, ZO_SmithingTopLevelImprovementPanelInventoryBackpack}

	local smithingScene = SCENE_MANAGER:GetScene('smithing')
	smithingScene:RemoveFragment(RIGHT_PANEL_BG_FRAGMENT)
	smithingScene:RemoveFragment(KEYBIND_STRIP_MUNGE_BACKDROP_FRAGMENT)

	smithingScene:RegisterCallback("StateChange", function(oldState, newState)
		if newState == SCENE_SHOWING then
			PP.Anchor(ZO_SharedRightPanelBackground, --[[#1]] TOPRIGHT,	nil, TOPRIGHT, 0, 60,	--[[#2]] true, BOTTOMLEFT, nil, BOTTOMRIGHT, -564, -50)
		elseif newState == SCENE_HIDDEN then
			PP.Anchor(ZO_SharedRightPanelBackground, --[[#1]] RIGHT, nil, RIGHT, 0, 20,			--[[#2]] false, BOTTOMLEFT, nil, BOTTOMRIGHT, 0, 0)
		end
	end)	

	PP.mainBackdrop(ZO_SmithingTopLevel,	'smithing', --[[backdrop]] nil, BOTTOMRIGHT, -570, 105, 1, -74, --[[tex]] PP.t.bg1, 8, 1, --[[bd]] 10, 10, 10, .7, --[[edge]]	0, 0, 0, 1, --[[texture]] true, .5)
	PP.mainBackdrop(ZO_KeybindStripControl,	'smithing', --[[backdrop]] TOPLEFT, BOTTOMRIGHT, -6, 0, 2, 6, --[[tex]] PP.t.bg1, 8, 1, --[[bd]] 10, 10, 10, .6, --[[edge]] 0, 0, 0, 1, --[[texture]] false, 0)

	for _, v in ipairs(tab1) do
		PP.ListBackdrop(v, -3, -3, -1, 3, --[[tex]] nil, 8, 0, --[[bd]] 5, 5, 5, .6, --[[edge]] 30, 30, 30, .6)
		PP.ScrollBar(v,	--[[sb_c]] 180, 180, 180, .7, --[[bd_c]] 20, 20, 20, .7, --[[edge]] 40, 40, 40, .9)
	end

	ZO_SmithingTopLevelImprovementPanelBoosterContainerDivider:SetHidden(true)

end