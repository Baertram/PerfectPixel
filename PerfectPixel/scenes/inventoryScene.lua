PP.inventoryScene = function()
--===============================================================================================--
	local SV_VER			= 0.1
	local DEF = {
		NoSpin				= true,
	}
	local SV = ZO_SavedVars:NewAccountWide(PP.ADDON_NAME, SV_VER, "InventoryScene", DEF, GetWorldName())
	---------------------------------------------
	table.insert(PP.optionsData,
	{	type				= "header",
		name				= GetString(PP_LAM_SCENE_INV),
	})
	table.insert(PP.optionsData,
	{	type				= "checkbox",
		name				= GetString(PP_LAM_SCENE_INV_NO_SPIN),
		tooltip				= GetString(PP_LAM_SCENE_INV_NO_SPIN_TT),
		getFunc				= function() return SV.NoSpin end,
		setFunc				= function(value) SV.NoSpin = value end,
		default				= DEF.NoSpin,
		requiresReload		= true,
	})
--===============================================================================================--
	local inventoryScene = SCENE_MANAGER:GetScene('inventory')
	inventoryScene:RemoveFragment(RIGHT_PANEL_BG_FRAGMENT)
	inventoryScene:RemoveFragment(FRAME_EMOTE_FRAGMENT_INVENTORY)
	inventoryScene:RemoveFragment(WIDE_LEFT_PANEL_BG_FRAGMENT)
	inventoryScene:RemoveFragment(KEYBIND_STRIP_MUNGE_BACKDROP_FRAGMENT)
	if SV.NoSpin then
		inventoryScene:RemoveFragment(FRAME_PLAYER_FRAGMENT)
		-- Fix dyeStampConfirmationKeyboard------
		local orgIsCharacterPreviewingAvailable = IsCharacterPreviewingAvailable
		function IsCharacterPreviewingAvailable()
			if SCENE_MANAGER:IsShowing("inventory") then
				return true
			else
				return orgIsCharacterPreviewingAvailable()
			end
		end
	end

	inventoryScene:RegisterCallback("StateChange", function(oldState, newState)
		if newState == SCENE_SHOWING then
			PP.Anchor(ZO_SharedRightPanelBackground, --[[#1]] TOPRIGHT,	nil, TOPRIGHT, 0, 60,	--[[#2]] true, BOTTOMLEFT, nil, BOTTOMRIGHT, -564, -50)
			ZO_ScrollList_Commit(ZO_PlayerInventoryBackpack)
		elseif newState == SCENE_HIDDEN then
			PP.Anchor(ZO_SharedRightPanelBackground, --[[#1]] RIGHT, nil, RIGHT, 0, 20,			--[[#2]] false, BOTTOMLEFT, nil, BOTTOMRIGHT, 0, 0)
		end
	end)

	PP.mainBackdrop(ZO_PlayerInventory,			'inventory', --[[backdrop]] TOPLEFT, BOTTOMRIGHT, -6, 0, 2, 6, --[[tex]] PP.t.bg1, 8, 1, --[[bd]] 10, 10, 10, .7, --[[edge]] 0, 0, 0, 1, --[[texture]] true, .5)
	PP.mainBackdrop(ZO_KeybindStripControl,		'inventory', --[[backdrop]] TOPLEFT, BOTTOMRIGHT, -6, 0, 2, 6, --[[tex]] PP.t.bg1, 8, 1, --[[bd]] 10, 10, 10, .6, --[[edge]] 0, 0, 0, 1, --[[texture]] false, 0)
	--ZO_Character
	PP.mainBackdrop(ZO_Character,				'inventory', --[[backdrop]] TOPLEFT, BOTTOMRIGHT, 0, 16, 310, 32, --[[tex]] PP.t.bg1, 8, 1, --[[bd]] 10, 10, 10, .8, --[[edge]] 0, 0, 0, 1, --[[texture]] true, .7)

	local tab = {ZO_PlayerInventoryList, ZO_PlayerInventoryQuest, ZO_CraftBagList, ZO_InventoryWalletList, ZO_QuickSlotList}
	for _, v in ipairs(tab) do
		PP.ListBackdrop(v, -3, -3, -1, 3, --[[tex]] nil, 8, 0, --[[bd]] 5, 5, 5, .6, --[[edge]] 30, 30, 30, .6)
		PP.ScrollBar(v,	--[[sb_c]] 180, 180, 180, .7, --[[bd_c]] 20, 20, 20, .7, --[[edge]] 40, 40, 40, .9)
	end

	ZO_PreHook("ZO_InventorySlot_SetHighlightHidden", function(listPart, hidden, instant)
		if listPart then
			local backdrop = listPart:GetNamedChild("Backdrop")
			if backdrop and backdrop:GetType() == CT_BACKDROP then
				if hidden then
					backdrop:SetCenterColor(20/255, 20/255, 20/255, .7)
					backdrop:SetEdgeColor(40/255, 40/255, 40/255, .9)
				else
					backdrop:SetCenterColor(96/255*.3, 125/255*.3, 139/255*.3, .7)
					backdrop:SetEdgeColor(96/255*.5, 125/255*.5, 139/255*.5, .9)
				end
			end
			local highlight = listPart:GetNamedChild("Highlight")
			if highlight and highlight:GetType() == CT_TEXTURE then
				if hidden then
					highlight:SetAlpha(0)
				else
					highlight:SetAlpha(1)
				end
			end
        end
		return true
	end)
	ZO_PreHook("ZO_InventorySlot_SetControlScaledUp", function(control, scaledUp, instant)
		return true
	end)
	ZO_PreHook(ZO_InventoryMenuBar, "LayoutCraftBagTooltip", function(tooltip)
		local title
		if HasCraftBagAccess() then
			title = zo_strformat(SI_INVENTORY_CRAFT_BAG_STATUS, ZO_DEFAULT_ENABLED_COLOR:Colorize(GetString(SI_ESO_PLUS_STATUS_UNLOCKED)))
		else
			title = zo_strformat(SI_INVENTORY_CRAFT_BAG_STATUS, ZO_DEFAULT_ENABLED_COLOR:Colorize(GetString(SI_ESO_PLUS_STATUS_LOCKED)))
		end
		SetTooltipText(InformationTooltip, title)
		return true
	end)
end