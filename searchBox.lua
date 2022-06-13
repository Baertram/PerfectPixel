PP.searchBox = function()

	-- PP.Anchor(ZO_PlayerInventorySearchBox,	--[[#1]] BOTTOMRIGHT,	ZO_PlayerInventory,	TOPRIGHT,	-20, -64,	--[[#2]] false, BOTTOMRIGHT, GuiRoot, BOTTOMRIGHT, 0, -130)
	-- PP.Anchor(ZO_CraftBagSearchBox,			--[[#1]] BOTTOMRIGHT,	ZO_CraftBag,		TOPRIGHT,	-20, -64,	--[[#2]] false, BOTTOMRIGHT, GuiRoot, BOTTOMRIGHT, 0, -130)

	MAIN_MENU_KEYBOARD.categoryAreaFragments[1].duration = 1

	EVENT_MANAGER:UnregisterForEvent(PP.ADDON_NAME .. "searchBox", EVENT_PLAYER_ACTIVATED, PP.searchBox)
end
