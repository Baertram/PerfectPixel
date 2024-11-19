PP.tabs = function()
--===============================================================================================--
	local SV_VER						= 0.1
	local DEF = {
		TopBarBG_toggle					= true,
		MenuBarLabel_toggle				= true,
	}
	local SV = ZO_SavedVars:NewAccountWide(PP.ADDON_NAME, SV_VER, "Tabs", DEF, GetWorldName())
	---------------------------------------------
	table.insert(PP.optionsData,
	{	type				= "submenu",
		name				= GetString(PP_LAM_TABS),
		controls = {
			{	type				= "checkbox",
				name				= GetString(PP_LAM_TABS_HIDE_MENU_BAR_LABEL),
				getFunc				= function() return SV.MenuBarLabel_toggle end,
				setFunc				= function(value) SV.MenuBarLabel_toggle = value end,
				default				= DEF.MenuBarLabel_toggle,
				requiresReload		= true,
			},
			{	type				= "checkbox",
				name				= GetString(PP_LAM_TABS_HIDE_TOP_BAR_BG),
				getFunc				= function() return SV.TopBarBG_toggle end,
				setFunc				= function(value) SV.TopBarBG_toggle = value end,
				default				= DEF.TopBarBG_toggle,
				requiresReload		= true,
			},
		},
	})
--===============================================================================================--
--ZO_MainMenu
	ZO_TopBarBackground:SetHidden(SV.TopBarBG_toggle)

	PP.Anchor(ZO_MainMenu, --[[#1]] TOP, nil, TOP, -55, 20)

--Tabs---------------------------------------
	local tabs_layout = PP:GetLayout('menuBar', 'tabs')
	for _, tabs in pairs(PP.Tabs) do
		PP:RefreshStyle_MenuBar(tabs, tabs_layout)
	end
--MenuBar------------------------------------
	local menu_layout = PP:GetLayout('menuBar', 'menu')
	for _, menuBar in pairs(PP.MenuBar) do
		PP:RefreshStyle_MenuBar(menuBar, menu_layout)
	end

--InfoBar----------------------------------------
	PP.Anchor(ZO_ProvisionerTopLevelInfoBar, --[[#1]] TOPLEFT, ZO_SmithingTopLevelRefinementPanelInventoryBackpack, BOTTOMLEFT, 0, 2, --[[#2]] true, TOPRIGHT, ZO_SmithingTopLevelRefinementPanelInventoryBackpack, BOTTOMRIGHT, 0, 2)
	
	for _, infoBar in pairs(PP.InfoBar) do
		PP:RefreshStyle_InfoBar(infoBar, nil)
	end

	local infoBarString = {
		{
			exString	= { SI_INVENTORY_BACKPACK_REMAINING_SPACES, SI_INVENTORY_BACKPACK_COMPLETELY_FULL },
			icon		= "|t24:24:/esoui/art/tooltips/icon_bag.dds|t",
		},
		{
			exString	= { SI_INVENTORY_HOUSE_BANK_REMAINING_SPACES, SI_INVENTORY_HOUSE_BANK_COMPLETELY_FULL, SI_INVENTORY_BANK_REMAINING_SPACES, SI_INVENTORY_BANK_COMPLETELY_FULL },
			icon		= "|t24:24:/esoui/art/tooltips/icon_bank.dds|t",
		},
		---------------
		{
			exString	= { SI_FENCE_SELL_LIMIT, SI_FENCE_SELL_LIMIT_REACHED },
			icon		= "|t36:36:/esoui/art/vendor/vendor_tabicon_sell_up.dds|t",
		},
		{
			exString	= { SI_FENCE_LAUNDER_LIMIT, SI_FENCE_LAUNDER_LIMIT_REACHED },
			icon		= "|t36:36:/esoui/art/vendor/vendor_tabicon_fence_up.dds|t",
		},
	}

	for _, invType in ipairs(infoBarString) do
		for _, str in ipairs(invType.exString) do
			SafeAddString(str, select(1, GetString(str):gsub(".*:", invType.icon)), 100)
		end
	end
end
