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
	{	type				= "header",
		name				= GetString(PP_LAM_TABS),
	})
	table.insert(PP.optionsData,
	{	type				= "checkbox",
		name				= GetString(PP_LAM_TABS_HIDE_MENU_BAR_LABEL),
		getFunc				= function() return SV.MenuBarLabel_toggle end,
		setFunc				= function(value) SV.MenuBarLabel_toggle = value end,
		default				= DEF.MenuBarLabel_toggle,
		requiresReload		= true,
	})
	table.insert(PP.optionsData,
	{	type				= "checkbox",
		name				= GetString(PP_LAM_TABS_HIDE_TOP_BAR_BG),
		getFunc				= function() return SV.TopBarBG_toggle end,
		setFunc				= function(value) SV.TopBarBG_toggle = value end,
		default				= DEF.TopBarBG_toggle,
		requiresReload		= true,
	})
--===============================================================================================--
--ZO_MainMenu
	ZO_TopBarBackground:SetHidden(SV.TopBarBG_toggle)

	PP.Anchor(ZO_MainMenu, --[[#1]] TOP, nil, TOP, -55, 20)

--Tabs---------------------------------------
	PP.Search(GuiRoot, 'ZO_.*Tabs', function(v)
		local duration, nSize, dSize = 50, 40, 46
		if v and v:GetType() == CT_CONTROL then
			v["m_object"]["m_animationDuration"]	= duration
			v["m_object"]["m_normalSize"]			= nSize
			v["m_object"]["m_downSize"]				= dSize
			for _, button in pairs(v["m_object"]["m_buttons"]) do
				local button = button[1]["m_object"]
				button["m_anim"] = nil
				if button["m_image"]:GetHeight() ~= nSize or dSize then
					button["m_image"]:SetDimensions(dSize, dSize)
				end
			end
		end

		local label = v:GetNamedChild("Active")
		if label and label:GetType() == CT_LABEL then
			PP.Font(label, --[[Font]] PP.f.u67, 16, "outline", --[[Alpha]] nil, --[[Color]] nil, nil, nil, nil, --[[StyleColor]] 0, 0, 0, .5)
		end
	end)
--InfoBar------------------------------------
	PP.Search(GuiRoot, 'ZO_.*InfoBar', function(v)
		local divider	= v:GetNamedChild("Divider")
		local slots		= v:GetNamedChild("FreeSlots")
		local altSlots	= v:GetNamedChild("AltFreeSlots")
		local money		= v:GetNamedChild("Money")
		local altMoney	= v:GetNamedChild("AltMoney")

		if divider and divider:GetType() == CT_CONTROL then
			divider:SetHidden(true)
		end
		if slots and slots:GetType() == CT_LABEL then
			PP.Anchor(slots,	--[[#1]] TOPLEFT,	nil, TOPLEFT, 2, 0)
			PP.Font(slots,		--[[Font]] PP.f.u67, 18, "outline", --[[Alpha]] nil, --[[Color]] nil, nil, nil, nil, --[[StyleColor]] 0, 0, 0, .6)
		end
		if altSlots and altSlots:GetType() == CT_LABEL then
			PP.Font(altSlots,	--[[Font]] PP.f.u67, 18, "outline", --[[Alpha]] nil, --[[Color]] nil, nil, nil, nil, --[[StyleColor]] 0, 0, 0, .6)
		end
		if money and money:GetType() == CT_LABEL then
			PP.Anchor(money,	--[[#1]] TOPRIGHT,	nil, TOPRIGHT, -4, 4)
			PP.Font(money,		--[[Font]] PP.f.u67, 18, "outline", --[[Alpha]] nil, --[[Color]] nil, nil, nil, nil, --[[StyleColor]] 0, 0, 0, .6)
			ZO_PreHookHandler(money, 'OnTextChanged', function()
				money:SetFont("PerfectPixel/fonts/univers67.otf|18|outline")
			end)
		end
		if altMoney and altMoney:GetType() == CT_LABEL then
			PP.Font(altMoney,	--[[Font]] PP.f.u67, 18, "outline", --[[Alpha]] nil, --[[Color]] nil, nil, nil, nil, --[[StyleColor]] 0, 0, 0, .6)
			ZO_PreHookHandler(altMoney, 'OnTextChanged', function()
				altMoney:SetFont("PerfectPixel/fonts/univers67.otf|18|outline")
			end)
		end
	end)

--MenuBar------------------------------------
	PP.Search(GuiRoot, 'ZO_.*Bar', function(v)
		local duration, nSize, dSize = 50, 50, 60
		if v and v:GetType() == CT_CONTROL and v["m_object"] then
			v["m_object"]["m_animationDuration"]	= duration
			v["m_object"]["m_normalSize"]			= nSize
			v["m_object"]["m_downSize"]				= dSize
			for _, button in pairs(v["m_object"]["m_buttons"]) do
				local button = button[1]["m_object"]
				button["m_anim"] = nil
				-- if button["m_image"]:GetHeight() ~= nSize or dSize then
					-- button["m_image"]:SetDimensions(dSize, dSize)
				-- end
			end

			local divider	= v:GetParent():GetNamedChild("Divider")
			local label		= v:GetNamedChild("Label")
			if divider and divider:GetType() == CT_CONTROL then
				divider:SetHidden(true)
			end
			if label and label:GetType() == CT_LABEL then
				PP.Font(label, --[[Font]] PP.f.u67, 22, "outline", --[[Alpha]] .9, --[[Color]] nil, nil, nil, nil, --[[StyleColor]] 0, 0, 0, .5)
				label:SetHidden(SV.MenuBarLabel_toggle)
			end
		end
	end)

end
