PP.storeScene = function()

	local storeScene = SCENE_MANAGER:GetScene("store")
	storeScene:RemoveFragment(RIGHT_PANEL_BG_FRAGMENT)
	storeScene:RemoveFragment(KEYBIND_STRIP_MUNGE_BACKDROP_FRAGMENT)

	storeScene:RegisterCallback("StateChange", function(oldState, newState)
		if newState == SCENE_SHOWING then
			PP.Anchor(ZO_SharedRightPanelBackground, --[[#1]] TOPRIGHT,	nil, TOPRIGHT, 0, 60,	--[[#2]] true, BOTTOMLEFT, nil, BOTTOMRIGHT, -564, -50)
			ZO_ScrollList_Commit(ZO_StoreWindowList)
		elseif newState == SCENE_HIDDEN then
			PP.Anchor(ZO_SharedRightPanelBackground, --[[#1]] RIGHT, nil, RIGHT, 0, 20,			--[[#2]] false, BOTTOMLEFT, nil, BOTTOMRIGHT, 0, 0)
		end
	end)	

	PP.mainBackdrop(ZO_StoreWindow,			'store', --[[backdrop]] TOPLEFT, BOTTOMRIGHT, -6, 0, 2, 6, --[[tex]] PP.t.bg1, 8, 1, --[[bd]] 10, 10, 10, .7, --[[edge]] 0, 0, 0, 1, --[[texture]] true, .5)
	PP.mainBackdrop(ZO_KeybindStripControl,	'store', --[[backdrop]] TOPLEFT, BOTTOMRIGHT, -6, 0, 2, 6, --[[tex]] PP.t.bg1, 8, 1, --[[bd]] 10, 10, 10, .6, --[[edge]] 0, 0, 0, 1, --[[texture]] false, 0)

	local tab = {ZO_StoreWindowList, ZO_BuyBackList, ZO_RepairWindowList}
	for _, v in ipairs(tab) do
		PP.ListBackdrop(v, -3, -3, -1, 3, --[[tex]] nil, 8, 0, --[[bd]] 5, 5, 5, .6, --[[edge]] 30, 30, 30, .6)
		PP.ScrollBar(v,	--[[sb_c]] 180, 180, 180, .7, --[[bd_c]] 20, 20, 20, .7, --[[edge]] 40, 40, 40, .9)
	end

--stables
	local stablesScene = SCENE_MANAGER:GetScene("stables")
	stablesScene:RemoveFragment(RIGHT_PANEL_BG_FRAGMENT)
	stablesScene:RemoveFragment(KEYBIND_STRIP_MUNGE_BACKDROP_FRAGMENT)

	stablesScene:RegisterCallback("StateChange", function(oldState, newState)
		if newState == SCENE_SHOWING then
			PP.Anchor(ZO_SharedRightPanelBackground, --[[#1]] TOPRIGHT,	nil, TOPRIGHT, 0, 60,	--[[#2]] true, BOTTOMLEFT, nil, BOTTOMRIGHT, -564, -50)
			ZO_ScrollList_Commit(ZO_StoreWindowList)
		elseif newState == SCENE_HIDDEN then
			PP.Anchor(ZO_SharedRightPanelBackground, --[[#1]] RIGHT, nil, RIGHT, 0, 20,			--[[#2]] false, BOTTOMLEFT, nil, BOTTOMRIGHT, 0, 0)
		end
	end)	

	PP.mainBackdrop(ZO_StoreWindow,			'stables', --[[backdrop]] TOPLEFT, BOTTOMRIGHT, -6, 0, 2, 6, --[[tex]] PP.t.bg1, 8, 1, --[[bd]] 10, 10, 10, .7, --[[edge]] 0, 0, 0, 1, --[[texture]] true, .5)
	PP.mainBackdrop(ZO_KeybindStripControl,	'stables', --[[backdrop]] TOPLEFT, BOTTOMRIGHT, -6, 0, 2, 6, --[[tex]] PP.t.bg1, 8, 1, --[[bd]] 10, 10, 10, .6, --[[edge]] 0, 0, 0, 1, --[[texture]] false, 0)

--fence_keyboard
	local fence_keyboardScene = SCENE_MANAGER:GetScene("fence_keyboard")
	fence_keyboardScene:RemoveFragment(RIGHT_PANEL_BG_FRAGMENT)
	fence_keyboardScene:RemoveFragment(KEYBIND_STRIP_MUNGE_BACKDROP_FRAGMENT)

	fence_keyboardScene:RegisterCallback("StateChange", function(oldState, newState)
		if newState == SCENE_SHOWING then
			PP.Anchor(ZO_SharedRightPanelBackground, --[[#1]] TOPRIGHT,	nil, TOPRIGHT, 0, 60,	--[[#2]] true, BOTTOMLEFT, nil, BOTTOMRIGHT, -564, -70)
		elseif newState == SCENE_HIDDEN then
			PP.Anchor(ZO_SharedRightPanelBackground, --[[#1]] RIGHT, nil, RIGHT, 0, 20,			--[[#2]] false, BOTTOMLEFT, nil, BOTTOMRIGHT, 0, 0)
		end
	end)	

	PP.mainBackdrop(ZO_PlayerInventory, 	'fence_keyboard', --[[backdrop]] TOPLEFT, BOTTOMRIGHT, -6, 0, 2, 6, --[[tex]] PP.t.bg1, 8, 1, --[[bd]] 10, 10, 10, .7, --[[edge]] 0, 0, 0, 1, --[[texture]] true, .5)
	PP.mainBackdrop(ZO_KeybindStripControl,	'fence_keyboard', --[[backdrop]] TOPLEFT, BOTTOMRIGHT, -6, 0, 2, 6, --[[tex]] PP.t.bg1, 8, 1, --[[bd]] 10, 10, 10, .6, --[[edge]] 0, 0, 0, 1, --[[texture]] false, 0)
end