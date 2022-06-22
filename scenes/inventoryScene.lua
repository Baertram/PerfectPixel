local quickSlotData = PP.quickslotData
local quickSlotControl = quickSlotData.quickSlotControl

PP.inventoryScene = function()
	--===============================================================================================--
	local SV_VER			= 0.1
	local DEF = {
		NoSpin				= true,
	}
	local SV = ZO_SavedVars:NewAccountWide(PP.ADDON_NAME, SV_VER, "InventoryScene", DEF, GetWorldName())
	---------------------------------------------
	table.insert(PP.optionsData,
			{	type				= "submenu",
				 name				= GetString(PP_LAM_SCENE_INV),
				 controls = {
					 {	type				= "checkbox",
						  name				= GetString(PP_LAM_SCENE_INV_NO_SPIN),
						  tooltip				= GetString(PP_LAM_SCENE_INV_NO_SPIN_TT),
						  getFunc				= function() return SV.NoSpin end,
						  setFunc				= function(value) SV.NoSpin = value end,
						  default				= DEF.NoSpin,
						  requiresReload		= true,
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

	local invList = {ZO_PlayerInventory, ZO_CraftBag, quickSlotControl, ZO_PlayerBank, ZO_HouseBank, ZO_GuildBank, ZO_StoreWindow, ZO_BuyBack, ZO_RepairWindow} -- ZO_InventoryWallet
	for _, v in ipairs(invList) do
		ZO_InventoryManager:ApplySharedBagLayout(v, BACKPACK_DEFAULT_LAYOUT_FRAGMENT.layoutData)
	end
	function ZO_InventoryManager:ApplySharedBagLayout(...) end

-- CHARACTER_WINDOW_STATS_FRAGMENT
	PP:CreateBackground(ZO_Character,		--[[#1]] nil, nil, nil, 0, 16, --[[#2]] nil, ZO_CharacterWindowStats, nil, -2, 32, true)
	ZO_CharacterWindowStats:SetWidth(30)
	ZO_PreHookHandler(ZO_CharacterWindowStats, 'OnEffectivelyShown', function(self, hidden) self:SetWidth(303) end)
	ZO_PreHookHandler(ZO_CharacterWindowStats, 'OnEffectivelyHidden', function(self, hidden) self:SetWidth(30) end)

--SCENE_MANAGER:GetScene('inventory')
	local inventoryScene = SCENE_MANAGER:GetScene('inventory')
	inventoryScene:RemoveFragment(RIGHT_PANEL_BG_FRAGMENT)
	inventoryScene:RemoveFragment(WIDE_LEFT_PANEL_BG_FRAGMENT)

	if SV.NoSpin then
		inventoryScene:RemoveFragment(FRAME_PLAYER_FRAGMENT)

		TREASURE_MAP_INVENTORY_SCENE:RemoveFragment(FRAME_TARGET_CENTERED_FRAGMENT)
		TREASURE_MAP_INVENTORY_SCENE:RemoveFragment(FRAME_PLAYER_FRAGMENT)

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

	PP:CreateBackground(ZO_PlayerInventory,	--[[#1]] nil, nil, nil, -6, 0, --[[#2]] nil, nil, nil, 0, 6)
	PP:CreateBackground(ZO_QuestItems,		--[[#1]] nil, nil, nil, -6, 0, --[[#2]] nil, nil, nil, 0, 6)
	PP:CreateBackground(ZO_CraftBag,		--[[#1]] nil, nil, nil, -6, 0, --[[#2]] nil, nil, nil, 0, 6)
	PP:CreateBackground(ZO_InventoryWallet,	--[[#1]] nil, nil, nil, -6, 0, --[[#2]] nil, nil, nil, 0, 6)

	local quickSlotData = PP.quickslotData
	PP:CreateBackground(quickSlotData.quickSlotControl,		--[[#1]] nil, nil, nil, -6, 0, --[[#2]] nil, nil, nil, 0, 6)
	local inventoryLists = {ZO_PlayerInventoryList, ZO_QuestItemsList, ZO_CraftBagList, ZO_InventoryWalletList, quickSlotData.quickslotListControl}
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

	PP.Anchor(quickSlotControl,	--[[#1]] TOPRIGHT, GuiRoot, TOPRIGHT, 0, TopOffsetY, --[[#2]] true, BOTTOMRIGHT, GuiRoot, BOTTOMRIGHT, 0, BottomOffsetY)
	PP.Anchor(quickSlotData.quickSlotFilterDividerControl,	--[[#1]] TOP, quickSlotControl, TOP, 0, 60)

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

	do
		local function RefreshControlMode_1_Dynamic(control, data, typeId)
			local sp = control:GetNamedChild("SellPrice")
			sp:SetFont(PP.f.u67 .. "|15|outline")
			sp:SetHidden(false)
		end

		for _, v in ipairs(storeTable) do
			local list = v:GetNamedChild("List")
			PP.ScrollBar(list,	--[[sb_c]] 180, 180, 180, .7, --[[bg_c]] 20, 20, 20, .7, true)
			local filterDivider = v:GetNamedChild("FilterDivider")
			PP.Anchor(v,							--[[#1]] TOPRIGHT, GuiRoot, TOPRIGHT, 0, TopOffsetY, --[[#2]] true, BOTTOMRIGHT, GuiRoot, BOTTOMRIGHT, 0, BottomOffsetY)
			PP.Anchor(filterDivider,				--[[#1]] TOP, ZO_StoreWindow, TOP, 0, 60)

			list.refreshControlMode_1_dynamic	= RefreshControlMode_1_Dynamic

			for typeId in pairs(list.dataTypes) do
				if typeId == 1 or typeId == 2 or typeId == 3 then
					local dataType = ZO_ScrollList_GetDataTypeTable(list, typeId)

					PP.Hook_SetupCallback(dataType, function(control, data)
						if list.mode ~= 3 then
							list.refreshControlMode_1_dynamic(control, data, typeId)
						end
					end)
				end
			end
		end
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

--SCENE_MANAGER:GetScene("trade") TRADE_WINDOW SCENE_MANAGER:Show("trade")
	local tradeScene = SCENE_MANAGER:GetScene("trade")
	tradeScene:RemoveFragment(TITLE_FRAGMENT)
	tradeScene:RemoveFragment(PLAYER_TRADE_TITLE_FRAGMENT)
	tradeScene:RemoveFragment(RIGHT_BG_FRAGMENT)
	tradeScene:AddFragment(FRAME_TARGET_BLUR_STANDARD_RIGHT_PANEL_FRAGMENT)

	--PP:CreateBackground(ZO_MailSend, --[[#1]] nil, nil, nil, -10, -10, --[[#2]] nil, nil, nil, 0, 6, true, 0)
	PP:CreateBackground(ZO_Trade,		--[[#1]] nil, nil, nil, -10, 0, --[[#2]] nil, nil, nil, 0, 6, true, 0)
	PP:HideBackgroundForScene(tradeScene, ZO_PlayerInventory.PP_BG)

	PP.Anchor(ZO_Trade, --[[#1]] TOPRIGHT,	GuiRoot, TOPRIGHT, 0, 100, --[[#2]] true, BOTTOMRIGHT, GuiRoot, BOTTOMRIGHT, 0, -80)


-----------------------------------------------------------------------------------------------------------------------------------------------

	ZO_PreHook("ZO_InventorySlot_SetHighlightHidden", function(listPart, hidden, instant)
		if listPart and listPart.backdrop then
			if hidden then
				listPart.backdrop:SetCenterColor(unpack(PP.SV.list_skin.list_skin_backdrop_col))
			else
				listPart.backdrop:SetCenterColor(unpack(PP.SV.list_skin.list_skin_backdrop_hl_col))
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