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
	for _, tabs in pairs(PP.Tabs) do
		local duration, nSize, dSize = 50, 40, 46
		tabs.m_object.m_animationDuration	= duration
		tabs.m_object.m_normalSize			= nSize
		tabs.m_object.m_downSize			= dSize

		for _, v in pairs(tabs.m_object.m_pool:GetActiveObjects()) do
			v.m_object.m_anim = nil
			-- local flash = v:GetNamedChild("Flash")
			-- if flash then
				-- v:GetNamedChild("Flash")["m_fadeAnimation"] = nil
			-- end
			if v.m_object.m_image:GetHeight() == 51 then
				v.m_object.m_image:SetDimensions(dSize, dSize)
			end
		end
		-- tabs.m_object:UpdateButtons()

		local label = tabs:GetNamedChild("Active") or tabs:GetNamedChild("Label")
		if label and label:GetType() == CT_LABEL then
			PP.Font(label, --[[Font]] PP.f.u67, 16, "outline", --[[Alpha]] nil, --[[Color]] nil, nil, nil, nil, --[[StyleColor]] 0, 0, 0, .5)
		end
	end
--MenuBar------------------------------------
	for _, menuBar in pairs(PP.MenuBar) do
		local duration, nSize, dSize = 50, 50, 60
		menuBar.m_object.m_animationDuration	= duration
		menuBar.m_object.m_normalSize			= nSize
		menuBar.m_object.m_downSize				= dSize

		for _, v in pairs(menuBar.m_object.m_pool:GetActiveObjects()) do
			v.m_object.m_anim = nil
			-- local flash = v:GetNamedChild("Flash")
			-- if flash then
				-- v:GetNamedChild("Flash")["m_fadeAnimation"] = nil
			-- end
			if v.m_object.m_image:GetHeight() == 64 then
				v.m_object.m_image:SetDimensions(dSize, dSize)
			end
		end

		-- menuBar.m_object:UpdateButtons()

		local divider	= menuBar:GetParent():GetNamedChild("Divider")
		local label		= menuBar:GetNamedChild("Label")
		if divider and divider:GetType() == CT_CONTROL then
			divider:SetHidden(true)
		end
		if label and label:GetType() == CT_LABEL then
			PP.Font(label, --[[Font]] PP.f.u67, 22, "outline", --[[Alpha]] .9, --[[Color]] nil, nil, nil, nil, --[[StyleColor]] 0, 0, 0, .5)
			label:SetHidden(SV.MenuBarLabel_toggle)
		end
	end
--InfoBar------------------------------------
	local height = 32

	local function fn(label)
		label:SetHeight(height)
		label:SetVerticalAlignment(TEXT_ALIGN_CENTER)
		PP.Font(label, --[[Font]] PP.f.u67, 18, "outline", --[[Alpha]] nil, --[[Color]] nil, nil, nil, nil, --[[StyleColor]] 0, 0, 0, .6)
		PP:SetLockFn(label, 'SetFont')
	end

	PP.Anchor(ZO_PlayerInventoryInfoBar, --[[#1]] TOPLEFT, ZO_PlayerInventoryList, BOTTOMLEFT, 0, 2, --[[#2]] true, TOPRIGHT, ZO_PlayerInventoryList, BOTTOMRIGHT, 0, 2)
	PP.Anchor(ZO_ProvisionerTopLevelInfoBar, --[[#1]] TOPLEFT, ZO_SmithingTopLevelRefinementPanelInventoryBackpack, BOTTOMLEFT, 0, 2, --[[#2]] true, TOPRIGHT, ZO_SmithingTopLevelRefinementPanelInventoryBackpack, BOTTOMRIGHT, 0, 2)

	for _, infoBar in pairs(PP.InfoBar) do
		local divider	= infoBar:GetNamedChild("Divider")
		local slots		= infoBar:GetNamedChild("FreeSlots")
		local altSlots	= infoBar:GetNamedChild("AltFreeSlots")
		local money		= infoBar:GetNamedChild("Money")
		local altMoney	= infoBar:GetNamedChild("AltMoney")
		local retrait	= infoBar:GetNamedChild("RetraitCurrency")
		local currency1	= infoBar:GetNamedChild("Currency1")
		local currency2	= infoBar:GetNamedChild("Currency2")

		if divider and divider:GetType() == CT_CONTROL then
			divider:SetHidden(true)
		end
		if slots and slots:GetType() == CT_LABEL then
			PP.Anchor(slots,	--[[#1]] TOPLEFT,	nil, TOPLEFT, 0, 0)
			fn(slots)
		end
		if altSlots and altSlots:GetType() == CT_LABEL then
			PP.Anchor(altSlots, --[[#1]] LEFT,	nil, RIGHT, 16, 0)
			fn(altSlots)
		end
		if money and money:GetType() == CT_LABEL then
			PP.Anchor(money,	--[[#1]] TOPRIGHT,	nil, TOPRIGHT, -4, 0)
			fn(money)
		end
		if altMoney and altMoney:GetType() == CT_LABEL then
			PP.Anchor(altMoney,	--[[#1]] RIGHT,	nil, LEFT, -16, 0)
			fn(altMoney)
		end
		if retrait and retrait:GetType() == CT_LABEL then
			fn(retrait)
		end
		if currency1 and currency1:GetType() == CT_LABEL then
			fn(currency1)
		end
		if currency2 and currency2:GetType() == CT_LABEL then
			fn(currency2)
		end
		PP.Anchor(infoBar, --[[#1]] TOPLEFT, nil, BOTTOMLEFT, 0, 2, --[[#2]] true, TOPRIGHT, nil, BOTTOMRIGHT, 0, 2)
	end

--------------------------------NEW***
	local t = {SI_INVENTORY_BACKPACK_REMAINING_SPACES, SI_INVENTORY_BACKPACK_COMPLETELY_FULL, }
	for _, v in pairs(t) do
		SafeAddString(v, select(1 , GetString(v):gsub(".*:", "|t24:24:/esoui/art/tooltips/icon_bag.dds|t")), 100)
	end

	local t = {SI_INVENTORY_HOUSE_BANK_REMAINING_SPACES, SI_INVENTORY_HOUSE_BANK_COMPLETELY_FULL, SI_INVENTORY_BANK_REMAINING_SPACES, SI_INVENTORY_BANK_COMPLETELY_FULL, }
	for _, v in pairs(t) do
		SafeAddString(v, select(1 , GetString(v):gsub(".*:", "|t24:24:/esoui/art/tooltips/icon_bank.dds|t")), 100)
	end
end
