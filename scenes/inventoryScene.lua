local PP		= PP
local namespace	= 'InventoryScene'

PP.inventoryScene = function()
	--===============================================================================================--
	local sv, def = PP:AddNewSavedVars(0.2, namespace, {
		NoSpin = true,
	})
	---------------------------------------------
	table.insert(PP.optionsData,
	{	type		= "submenu",
		name		= GetString(PP_LAM_SCENE_INV),
		controls	= {
			{	type			= "checkbox",
				name			= GetString(PP_LAM_SCENE_INV_NO_SPIN),
				-- tooltip			= GetString(PP_LAM_SCENE_INV_NO_SPIN_TT),
				getFunc			= function() return sv.NoSpin end,
				setFunc			= function(value) sv.NoSpin = value end,
				default			= def.NoSpin,
				requiresReload	= true,
			 },
		 },
	})
	--===============================================================================================--
	local TopOffsetY			= 110
	local BottomOffsetY			= -90
	local bankTopOffsetY		= 110
	local bankBottomOffsetY		= -90
	local mailTopOffsetY		= 110
	local mailBottomOffsetY		= -90

	-- Backpack Layout Fragment ---------------------
	BACKPACK_DEFAULT_LAYOUT_FRAGMENT["layoutData"]["inventoryTopOffsetY"]				= TopOffsetY
	BACKPACK_DEFAULT_LAYOUT_FRAGMENT["layoutData"]["inventoryBottomOffsetY"]			= BottomOffsetY

	BACKPACK_MENU_BAR_LAYOUT_FRAGMENT["layoutData"]["inventoryTopOffsetY"]				= TopOffsetY				--inventory scene
	BACKPACK_MENU_BAR_LAYOUT_FRAGMENT["layoutData"]["inventoryBottomOffsetY"]			= BottomOffsetY

	BACKPACK_STORE_LAYOUT_FRAGMENT["layoutData"]["inventoryTopOffsetY"]					= TopOffsetY
	BACKPACK_STORE_LAYOUT_FRAGMENT["layoutData"]["inventoryBottomOffsetY"]				= BottomOffsetY

	BACKPACK_HOUSE_BANK_LAYOUT_FRAGMENT["layoutData"]["inventoryTopOffsetY"]			= bankTopOffsetY
	BACKPACK_HOUSE_BANK_LAYOUT_FRAGMENT["layoutData"]["inventoryBottomOffsetY"]			= bankBottomOffsetY
	-- BACKPACK_HOUSE_BANK_LAYOUT_FRAGMENT:SetLayoutValue("hideCurrencyInfo", false)

	BACKPACK_BANK_LAYOUT_FRAGMENT["layoutData"]["inventoryTopOffsetY"]					= bankTopOffsetY
	BACKPACK_BANK_LAYOUT_FRAGMENT["layoutData"]["inventoryBottomOffsetY"]				= bankBottomOffsetY

	BACKPACK_GUILD_BANK_LAYOUT_FRAGMENT["layoutData"]["inventoryTopOffsetY"]			= bankTopOffsetY
	BACKPACK_GUILD_BANK_LAYOUT_FRAGMENT["layoutData"]["inventoryBottomOffsetY"]			= bankBottomOffsetY

	BACKPACK_MAIL_LAYOUT_FRAGMENT["layoutData"]["inventoryTopOffsetY"]					= mailTopOffsetY
	BACKPACK_MAIL_LAYOUT_FRAGMENT["layoutData"]["inventoryBottomOffsetY"]				= mailBottomOffsetY

	BACKPACK_FENCE_LAYOUT_FRAGMENT["layoutData"]["inventoryTopOffsetY"]					= bankTopOffsetY
	BACKPACK_FENCE_LAYOUT_FRAGMENT["layoutData"]["inventoryBottomOffsetY"]				= bankBottomOffsetY

	BACKPACK_LAUNDER_LAYOUT_FRAGMENT["layoutData"]["inventoryTopOffsetY"]				= bankTopOffsetY
	BACKPACK_LAUNDER_LAYOUT_FRAGMENT["layoutData"]["inventoryBottomOffsetY"]			= bankBottomOffsetY

	BACKPACK_PLAYER_TRADE_LAYOUT_FRAGMENT["layoutData"]["inventoryTopOffsetY"]			= TopOffsetY
	BACKPACK_PLAYER_TRADE_LAYOUT_FRAGMENT["layoutData"]["inventoryBottomOffsetY"]		= BottomOffsetY

	BACKPACK_TRADING_HOUSE_LAYOUT_FRAGMENT["layoutData"]["inventoryTopOffsetY"]			= bankTopOffsetY
	BACKPACK_TRADING_HOUSE_LAYOUT_FRAGMENT["layoutData"]["inventoryBottomOffsetY"]		= bankBottomOffsetY
	-- BACKPACK_TRADING_HOUSE_LAYOUT_FRAGMENT["layoutData"]["width"]						= 635
	-- BACKPACK_TRADING_HOUSE_LAYOUT_FRAGMENT["layoutData"]["sortByNameWidth"]				= 311
	BACKPACK_TRADING_HOUSE_LAYOUT_FRAGMENT["layoutData"]["sortByOffsetY"]				= 103
	BACKPACK_TRADING_HOUSE_LAYOUT_FRAGMENT["layoutData"]["backpackOffsetY"]				= 136
	BACKPACK_TRADING_HOUSE_LAYOUT_FRAGMENT["layoutData"]["emptyLabelOffsetY"]			= 200

	-------------------------------------------------
	local orgApplySharedBagLayout = ZO_InventoryManager.ApplySharedBagLayout
	function ZO_InventoryManager:ApplySharedBagLayout(inventoryControl, layoutData)
		inventoryControl:ClearAnchors()
		inventoryControl:SetAnchor(TOPRIGHT, GuiRoot, TOPRIGHT, 0, layoutData.inventoryTopOffsetY)
		inventoryControl:SetAnchor(BOTTOMRIGHT, GuiRoot, BOTTOMRIGHT, 0, layoutData.inventoryBottomOffsetY)

		local inventoryContainer = inventoryControl:GetNamedChild("List") or inventoryControl:GetNamedChild("Backpack")
		inventoryContainer:SetWidth(layoutData.width)
		inventoryContainer:ClearAnchors()
		inventoryContainer:SetAnchor(TOPRIGHT, inventoryControl, TOPRIGHT, 0, layoutData.backpackOffsetY)
		inventoryContainer:SetAnchor(BOTTOMRIGHT)

		ZO_ScrollList_SetHeight(inventoryContainer, inventoryContainer:GetHeight())
		ZO_ScrollList_Commit(inventoryContainer)

		local sortHeaders = inventoryControl:GetNamedChild("SortBy")
		sortHeaders:ClearAnchors()
		sortHeaders:SetAnchor(TOPRIGHT, inventoryControl, TOPRIGHT, 0, layoutData.sortByOffsetY)
		sortHeaders:SetWidth(layoutData.width)

		local emptyLabel = inventoryControl:GetNamedChild("Empty")
		if emptyLabel then
			emptyLabel:ClearAnchors()
			emptyLabel:SetAnchor(TOPLEFT, inventoryControl, TOPLEFT, 50, layoutData.emptyLabelOffsetY)
			emptyLabel:SetAnchor(TOPRIGHT, inventoryControl, TOPRIGHT, -50, layoutData.emptyLabelOffsetY)
		end
		local sortByName = sortHeaders:GetNamedChild("Name")
		sortByName:SetWidth(layoutData.sortByNameWidth)

		-- local filterDivider = inventoryControl:GetNamedChild("FilterDivider")
		-- filterDivider:ClearAnchors()
		-- filterDivider:SetAnchor(TOP, inventoryControl, TOP, 0, 0)
	end

	local invList = {ZO_PlayerInventory, ZO_CraftBag, QUICKSLOT_KEYBOARD.control, ZO_PlayerBank, ZO_HouseBank, ZO_GuildBank, ZO_StoreWindow, ZO_BuyBack, ZO_RepairWindow} -- ZO_InventoryWallet
	for _, v in ipairs(invList) do
		ZO_InventoryManager:ApplySharedBagLayout(v, BACKPACK_DEFAULT_LAYOUT_FRAGMENT.layoutData)
	end
	function ZO_InventoryManager:ApplySharedBagLayout(...) end

-- CHARACTER_WINDOW_STATS_FRAGMENT
	PP:CreateBackground(ZO_Character,		--[[#1]] nil, nil, nil, 0, 16, --[[#2]] nil, ZO_CharacterWindowStats, nil, -2, 32)
	ZO_CharacterWindowStats:SetWidth(30)
	ZO_PreHookHandler(ZO_CharacterWindowStats, 'OnEffectivelyShown', function(self, hidden) self:SetWidth(303) end)
	ZO_PreHookHandler(ZO_CharacterWindowStats, 'OnEffectivelyHidden', function(self, hidden) self:SetWidth(30) end)

--SCENE_MANAGER:GetScene('inventory')
	local inventoryScene = SCENE_MANAGER:GetScene('inventory')
	inventoryScene:RemoveFragment(RIGHT_PANEL_BG_FRAGMENT)
	inventoryScene:RemoveFragment(WIDE_LEFT_PANEL_BG_FRAGMENT)
---------------------------------------------------------------------------------------------------------------------
	if sv.NoSpin then
		TREASURE_MAP_INVENTORY_SCENE:RemoveFragment(FRAME_TARGET_CENTERED_FRAGMENT)
		TREASURE_MAP_INVENTORY_SCENE:RemoveFragment(FRAME_PLAYER_FRAGMENT)

		inventoryScene:RemoveFragment(FRAME_PLAYER_FRAGMENT)

		local itemPreview						= SYSTEMS:GetObject("itemPreview")
		local ex_PreviewInventoryItem			= itemPreview.PreviewInventoryItem
		local ex_IsCharacterPreviewingAvailable = IsCharacterPreviewingAvailable

		local function callback_EndCurrentPreview()
			itemPreview:UnregisterCallback("EndCurrentPreview", callback_EndCurrentPreview)
			inventoryScene:RemoveFragment(FRAME_PLAYER_FRAGMENT)
		end

		local function new_PreviewInventoryItem(...)
			inventoryScene:AddFragment(FRAME_PLAYER_FRAGMENT)
			itemPreview:RegisterCallback("EndCurrentPreview", callback_EndCurrentPreview)
			return ex_PreviewInventoryItem(...)
		end

		local function new_IsCharacterPreviewingAvailable(...)
			return true
		end

		inventoryScene:RegisterCallback("StateChange", function(oldState, newState)
			if newState == SCENE_SHOWING then
				IsCharacterPreviewingAvailable		= new_IsCharacterPreviewingAvailable
				itemPreview.PreviewInventoryItem	= new_PreviewInventoryItem
			elseif newState == SCENE_HIDDEN then
				IsCharacterPreviewingAvailable		= ex_IsCharacterPreviewingAvailable
				itemPreview.PreviewInventoryItem	= ex_PreviewInventoryItem
			end
		end)
	end
---------------------------------------------------------------------------------------------------------------------
	PP:CreateBackground(ZO_PlayerInventory,	--[[#1]] nil, nil, nil, -6, 0, --[[#2]] nil, nil, nil, 0, 6)
	PP:CreateBackground(ZO_QuestItems,		--[[#1]] nil, nil, nil, -6, 0, --[[#2]] nil, nil, nil, 0, 6)
	PP:CreateBackground(ZO_CraftBag,		--[[#1]] nil, nil, nil, -6, 0, --[[#2]] nil, nil, nil, 0, 6)
	PP:CreateBackground(ZO_InventoryWallet,	--[[#1]] nil, nil, nil, -6, 0, --[[#2]] nil, nil, nil, 0, 6)
	PP:CreateBackground(QUICKSLOT_KEYBOARD.control,		--[[#1]] nil, nil, nil, -6, 0, --[[#2]] nil, nil, nil, 0, 6)

	local inventoryLists = {ZO_PlayerInventoryList, ZO_QuestItemsList, ZO_CraftBagList, ZO_InventoryWalletList, QUICKSLOT_KEYBOARD.list}
	for _, v in ipairs(inventoryLists) do
		PP.ScrollBar(v,	--[[sb_c]] 180, 180, 180, .7, --[[bg_c]] 20, 20, 20, .7, true)
	end

	PP.Anchor(ZO_PlayerInventoryMenu,			--[[#1]] BOTTOM, ZO_InventoryWallet, TOP, -40, 0)
	PP.Anchor(ZO_PlayerInventoryFilterDivider,	--[[#1]] TOP, ZO_PlayerInventory, TOP, 0, 60)

	PP.Anchor(ZO_CraftBagFilterDivider,			--[[#1]] TOP, ZO_CraftBag, TOP, 0, 60)

	PP.Anchor(ZO_InventoryWallet,				--[[#1]] TOPRIGHT, GuiRoot, TOPRIGHT, 0, TopOffsetY, --[[#2]] true, BOTTOMRIGHT, GuiRoot, BOTTOMRIGHT, 0, BottomOffsetY)
	PP.Anchor(ZO_InventoryWalletFilterDivider,	--[[#1]] TOP, ZO_InventoryWallet, TOP, 0, 60)

	PP.Anchor(ZO_QuestItems,					--[[#1]] TOPRIGHT, GuiRoot, TOPRIGHT, 0, TopOffsetY, --[[#2]] true, BOTTOMRIGHT, GuiRoot, BOTTOMRIGHT, 0, BottomOffsetY)
	PP.Anchor(ZO_QuestItemsList,				--[[#1]] nil, nil, nil, 0, 1, --[[#2]] true, nil, nil, nil, nil, nil)
	PP.Anchor(ZO_QuestItemsSortBy,				--[[#1]] TOPRIGHT, ZO_QuestItems, TOPRIGHT, 0, 33)
	PP.Anchor(ZO_QuestItemsFilterDivider,		--[[#1]] TOP, ZO_QuestItems, TOP, 0, 30)
	-- ZO_QuestItemsFilterDivider:SetHidden(true)

	PP.Anchor(QUICKSLOT_KEYBOARD.control,		--[[#1]] TOPRIGHT, GuiRoot, TOPRIGHT, 0, TopOffsetY, --[[#2]] true, BOTTOMRIGHT, GuiRoot, BOTTOMRIGHT, 0, BottomOffsetY)
	PP.Anchor(ZO_QuickSlot_Keyboard_TopLevelFilterDivider,		--[[#1]] TOP, QUICKSLOT_KEYBOARD.control, TOP, 0, 60)

--SCENE_MANAGER:GetScene() 'bank', 'houseBank', 'guildBank',
	local banksTable = {
		{sName = 'bank',		tlc = ZO_PlayerBank	},
		{sName = 'houseBank',	tlc = ZO_HouseBank	},
		{sName = 'guildBank',	tlc = ZO_GuildBank	},
	}
	for i = 1, #banksTable do
		local bank		= banksTable[i]
		local scene		= SCENE_MANAGER:GetScene(bank.sName)
		local tlc		= bank.tlc

		scene:RemoveFragment(RIGHT_PANEL_BG_FRAGMENT)
		scene:AddFragment(FRAME_TARGET_BLUR_STANDARD_RIGHT_PANEL_MEDIUM_LEFT_PANEL_FRAGMENT)
		
		PP:CreateBackground(tlc, --[[#1]] nil, nil, nil, -6, 0, --[[#2]] nil, nil, nil, 0, 6)

		PP.ScrollBar(tlc:GetNamedChild("Backpack"), --[[sb_c]] 180, 180, 180, .7, --[[bg_c]] 20, 20, 20, .7, true)

		PP.Anchor(tlc,									--[[#1]] TOPRIGHT, GuiRoot, TOPRIGHT, 0, bankTopOffsetY, --[[#2]] true, BOTTOMRIGHT, GuiRoot, BOTTOMRIGHT, 0, bankBottomOffsetY)
		PP.Anchor(tlc:GetNamedChild("Menu"),			--[[#1]] BOTTOM, tlc, TOP, -40, 0)
		PP.Anchor(tlc:GetNamedChild("FilterDivider"),	--[[#1]] TOP, tlc, TOP, 0, 60)
	end

--SCENE_MANAGER:GetScene("store")
	local storeTable = {ZO_StoreWindow, ZO_BuyBack, ZO_RepairWindow}

	local storeScene = SCENE_MANAGER:GetScene("store")
	storeScene:RemoveFragment(RIGHT_PANEL_BG_FRAGMENT)
	storeScene:AddFragment(FRAME_TARGET_BLUR_STANDARD_RIGHT_PANEL_MEDIUM_LEFT_PANEL_FRAGMENT)

	PP:CreateBackground(ZO_StoreWindow,		--[[#1]] nil, nil, nil, -6, 0, --[[#2]] nil, nil, nil, 0, 6)
	PP:CreateBackground(ZO_BuyBack,			--[[#1]] nil, nil, nil, -6, 0, --[[#2]] nil, nil, nil, 0, 6)
	PP:CreateBackground(ZO_RepairWindow,	--[[#1]] nil, nil, nil, -6, 0, --[[#2]] nil, nil, nil, 0, 6)

	for _, v in ipairs(storeTable) do
		local list			= v:GetNamedChild("List")
		local filterDivider	= v:GetNamedChild("FilterDivider")

		PP.Anchor(v,				--[[#1]] TOPRIGHT, GuiRoot, TOPRIGHT, 0, TopOffsetY, --[[#2]] true, BOTTOMRIGHT, GuiRoot, BOTTOMRIGHT, 0, BottomOffsetY)
		PP.Anchor(filterDivider,	--[[#1]] TOP, ZO_StoreWindow, TOP, 0, 60)
		PP.ScrollBar(list,			--[[sb_c]] 180, 180, 180, .7, --[[bg_c]] 20, 20, 20, .7, true)
	end

	PP.Anchor(ZO_StoreWindowMenu,	--[[#1]] BOTTOM, ZO_StoreWindow, TOP, -40, 0)

	PP.Anchor(ZO_StoreWindowSortBy,	--[[#1]] nil, nil, nil, nil, 60)
	PP.Anchor(ZO_StoreWindowList,	--[[#1]] nil, nil, nil, nil, 93, --[[#2]] true, nil, nil, nil, nil, nil)
	

--SCENE_MANAGER:GetScene("stables")
	local stablesScene = SCENE_MANAGER:GetScene("stables")
	stablesScene:RemoveFragment(RIGHT_PANEL_BG_FRAGMENT)
	stablesScene:AddFragment(FRAME_TARGET_BLUR_STANDARD_RIGHT_PANEL_MEDIUM_LEFT_PANEL_FRAGMENT)

	PP:CreateBackground(ZO_StablePanel,		--[[#1]] nil, nil, nil, -6, 0, --[[#2]] nil, nil, nil, 0, 6)

	PP.Anchor(ZO_StablePanel,				--[[#1]] TOPRIGHT, GuiRoot, TOPRIGHT, 0, TopOffsetY, --[[#2]] true, BOTTOMRIGHT, GuiRoot, BOTTOMRIGHT, 0, BottomOffsetY)
	PP.Anchor(ZO_StableWindowMenu,			--[[#1]] BOTTOM, ZO_StablePanel, TOP, -40, 0)

	local tabStablesBar = {ZO_StablePanelSpeedTrainRowBarContainer, ZO_StablePanelStaminaTrainRowBarContainer, ZO_StablePanelCarryTrainRowBarContainer}
	for _, bar in pairs(tabStablesBar) do
		PP.Bar(bar:GetNamedChild("StatusBarBar"), --[[height]] 8, --[[fontSize]] 15)
		bar:GetNamedChild("StatusBar"):SetHeight(16)
		PP.Font(bar:GetNamedChild("Value"), --[[Font]] PP.f.u67, 24, "outline", --[[Alpha]] nil, --[[Color]] nil, nil, nil, nil, --[[StyleColor]] 0, 0, 0, .5)
	end

--SCENE_MANAGER:GetScene("fence_keyboard")
	local fence_keyboardScene = SCENE_MANAGER:GetScene("fence_keyboard")
	fence_keyboardScene:RemoveFragment(RIGHT_PANEL_BG_FRAGMENT)
	fence_keyboardScene:AddFragment(FRAME_TARGET_BLUR_STANDARD_RIGHT_PANEL_MEDIUM_LEFT_PANEL_FRAGMENT)

	PP.Anchor(ZO_Fence_Keyboard_WindowMenu,		--[[#1]] BOTTOM, ZO_PlayerInventory, TOP, -40, 0)

	--RowSellPrice
	local fence_currency = {
		showTooltips	= true,
		font			= PP.f.u67 .. "|15|shadow",
		iconSide		= RIGHT,
	}
	local function ColorCost(control, data, scrollList)
		local priceControl = control:GetNamedChild("SellPrice")
		ZO_CurrencyControl_SetCurrencyData(priceControl, CURT_MONEY, data.stackLaunderPrice, CURRENCY_DONT_SHOW_ALL, (GetCurrencyAmount(CURT_MONEY, CURRENCY_LOCATION_CHARACTER) < data.stackLaunderPrice))
		ZO_CurrencyControl_SetCurrency(priceControl, fence_currency)
	end
	ZO_PreHook(PLAYER_INVENTORY, "RefreshBackpackWithFenceData", function(self, callback)
		if callback then
			ZO_ScrollList_RefreshVisible(self.inventories[BAG_BACKPACK].listView, nil, ColorCost)
			return true
		end
	end)

	--FENCE_KEYBOARD -> SI_FENCE_HAGGLING_SKILL_BONUS_LABEL
	--Set the fence haggling bonus text to a short <number>% only
	ZO_PreHook(FENCE_KEYBOARD, "UpdateHagglingLabel", function(selfVar, skillLevel)
		if skillLevel > 0 then
			ZO_PlayerInventoryInfoBarAltMoney:SetText(zo_strformat("|cEECA2A<<1>>|r%", skillLevel))
			ZO_PlayerInventoryInfoBarAltMoney:SetHidden(false)
		else
			ZO_PlayerInventoryInfoBarAltMoney:SetHidden(true)
		end
		return true --prevent original function call
	end)
	--FENCE_KEYBOARD -> SI_FENCE_SELL_LIMIT
	--Change the fenced/laundered items text to a short <coin texture/launder texture> <number>/<numberTotal>
	local stillPossibleText = "|cffffff<<1>> / <<2>>|r"
	local alreadyMaxText = "|cff0000<<1>> / <<2>>|r"
	local launderOrSellTextures = {
		[true] = 	zo_iconFormat("EsoUI/Art/Vendor/vendor_tabIcon_fence_up.dds", 32, 32),  --launder
		[false] = 	zo_iconFormat("EsoUI/Art/Vendor/vendor_tabIcon_sell_up.dds", 36, 36), --sell
	}
	ZO_PreHook(FENCE_KEYBOARD, "UpdateTransactionLabel", function(selfVar, totalTransactions, usedTransactions, transactionsRemainingString, transactionsFullString)
		local textureStr = launderOrSellTextures[selfVar:IsLaundering()] or ""
		if textureStr ~= "" then textureStr = " " .. textureStr end
		local transactionString = (usedTransactions >= totalTransactions) and alreadyMaxText or stillPossibleText
		ZO_PlayerInventoryInfoBarAltFreeSlots:SetText(textureStr .. zo_strformat(transactionString, usedTransactions, totalTransactions))
		return true --prevent original function call
	end)


--SCENE_MANAGER:GetScene("trade") TRADE_WINDOW SCENE_MANAGER:Show("trade")
	local tradeScene = SCENE_MANAGER:GetScene("trade")
	tradeScene:RemoveFragment(TITLE_FRAGMENT)
	tradeScene:RemoveFragment(PLAYER_TRADE_TITLE_FRAGMENT)
	tradeScene:RemoveFragment(RIGHT_BG_FRAGMENT)
	tradeScene:AddFragment(FRAME_TARGET_BLUR_STANDARD_RIGHT_PANEL_FRAGMENT)

	PP:CreateBackground(ZO_Trade,		--[[#1]] nil, nil, nil, -10, 0, --[[#2]] nil, nil, nil, 0, 6)
	PP:HideBackgroundForScene(tradeScene, ZO_PlayerInventory.PP_BG)

	PP.Anchor(ZO_Trade, --[[#1]] TOPRIGHT,	GuiRoot, TOPRIGHT, 0, 100, --[[#2]] true, BOTTOMRIGHT, GuiRoot, BOTTOMRIGHT, 0, -80)

-----------------------------------------------------------------------------------------------------------------------------------------------

	ZO_PreHook("ZO_InventorySlot_SetHighlightHidden", function(listPart, hidden, instant)
		if listPart and listPart.backdrop then
			if hidden then
				listPart.backdrop:SetCenterColor(unpack(PP.savedVars.ListStyle.list_skin_backdrop_col))
			else
				listPart.backdrop:SetCenterColor(unpack(PP.savedVars.ListStyle.list_skin_backdrop_hl_col))
			end
			return true
		end
	end)
	ZO_PreHook("ZO_InventorySlot_SetControlScaledUp", function(control, scaledUp, instant)
		return true
	end)

	-- SafeAddString(SI_CRAFT_BAG_STATUS_ESO_PLUS_UNLOCKED_DESCRIPTION, nil, 100)
	-- SafeAddString(SI_CRAFT_BAG_STATUS_LOCKED_DESCRIPTION, nil, 100)

	function ZO_InventoryMenuBar:LayoutCraftBagTooltip(tooltip)
		local str	= HasCraftBagAccess() and SI_ESO_PLUS_STATUS_UNLOCKED or SI_ESO_PLUS_STATUS_LOCKED
		local title	= zo_strformat(SI_INVENTORY_CRAFT_BAG_STATUS, ZO_DEFAULT_ENABLED_COLOR:Colorize(GetString(str)))
		SetTooltipText(tooltip, title)
	end

	--NEW--********************************************************************************************
	--RowSellPrice
	-- ITEM_SLOT_CURRENCY_OPTIONS.font							= PP.f.u67 .. "|15|shadow"
	-- ITEM_BACKPACK_SLOT_CURRENCY_OPTIONS.font				= PP.f.u67 .. "|15|shadow"

	--InfoBarMoney, AltMoney
	-- ZO_KEYBOARD_CURRENCY_OPTIONS.font						= PP.f.u67 .. "|18|outline"
	-- ZO_KEYBOARD_CURRENCY_BANK_TOOLTIP_OPTIONS.font			= PP.f.u67 .. "|18|outline"
	-- ZO_KEYBOARD_CURRENCY_GUILD_BANK_TOOLTIP_OPTIONS.font	= PP.f.u67 .. "|18|outline"

	--*************************************************************************************************
end