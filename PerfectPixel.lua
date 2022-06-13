if not PP then PP = {} end
PP.SV = {}
PP.ADDON_NAME		= "PerfectPixel"
PP.ADDON_AUTHOR		= "@KL1SK, helped by Baertram"
PP.ADDON_WEBSITE	= "https://www.esoui.com/downloads/info2103-PerfectPixel.html"
PP.ADDON_VERSION 	= "0.11.26"

-- media
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PP.media = {
	--
	name_backdrop = {
		"Clean",
		"PP - oblique line\n 8x8",
		"PP - dots\n 8x8",
	},
	backdrop = {
		"",
		"PerfectPixel/textures/line.dds",
		"PerfectPixel/textures/dots.dds",
	},
	--
	name_edge = {
		"Clean",
		"Edge\n 128x16",
		-- "edge3\n 64x8",
	},
	edge = {
		"",
		"PerfectPixel/textures/edge.dds",
		-- "PerfectPixel/textures/edge3.dds",
		
	},
	--
}
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local function Settings()
	PP.optionsData = {}
	local panelData = {
		type					= "panel",
		name					= PP.ADDON_NAME,
		version					= PP.ADDON_VERSION,
		author					= PP.ADDON_AUTHOR .. " and great help from Votan/Baertram",
		website					= PP.ADDON_WEBSITE,
		slashCommand			= "/pp",
		registerForRefresh		= true,
		registerForDefaults		= true,
	}
	LibAddonMenu2:RegisterAddonPanel("PerfectPixelOptions", panelData)

	CALLBACK_MANAGER:RegisterCallback("LAM-PanelOpened", function(panel)
		if panel ~= PerfectPixelOptions then return end
		SCENE_MANAGER:GetScene('gameMenuInGame'):AddFragment(INVENTORY_FRAGMENT)
	end)
	CALLBACK_MANAGER:RegisterCallback("LAM-PanelClosed", function(panel)
		if panel ~= PerfectPixelOptions then return end
		SCENE_MANAGER:GetScene('gameMenuInGame'):RemoveFragment(INVENTORY_FRAGMENT)
	end)
--===============================================================================================--
	local SV_VER				= 0.2
	local DEF_SKIN = {
		skin_backdrop					= "",
		skin_backdrop_col				= {10/255, 12/255, 14/255, 200/255},
		skin_backdrop_insets			= 0,
		skin_backdrop_tile				= false,
		skin_backdrop_tile_size			= 8,
		skin_edge						= "",
		skin_edge_col					= {0/255, 0/255, 0/255, 255/255},
		skin_edge_thickness				= 1,
		skin_edge_file_width			= 128,
		skin_edge_file_height			= 16,
		skin_edge_integral_wrapping		= false,
	}
	PP.SV = ZO_SavedVars:NewAccountWide(PP.ADDON_NAME, SV_VER, "Window style", DEF_SKIN, GetWorldName())
	table.insert(PP.optionsData,
	{	type = "submenu", name = GetString(PP_LAM_WINDOW_STYLE),
		controls = {
			{	type = "header", name = GetString(PP_LAM_WINDOW_STYLE), },
			{	type				= 'iconpicker', name = GetString(PP_LAM_LIST_STYLE_BACKDROP),
				choices				= PP.media.backdrop,
				choicesTooltips		= PP.media.name_backdrop,
				getFunc				= function() return PP.SV.skin_backdrop end,
				setFunc				= function(str) PP.SV.skin_backdrop = str end,
				maxColumns			= 3,
				visibleRows			= 5,
				iconSize			= 52,
				default				= DEF_SKIN.skin_backdrop,
				width				= "half",
			},
			{	type 				= "slider", name = GetString(PP_LAM_LIST_STYLE_INSETS),
				max					= 100, min = 0,
				getFunc				= function() return PP.SV.skin_backdrop_insets end,
				setFunc				= function(value) PP.SV.skin_backdrop_insets = value end,
				default				= DEF_SKIN.skin_backdrop_insets,
				width				= "half",
			},
			{	type				= "checkbox", name = GetString(PP_LAM_LIST_STYLE_TILE_LAYING),
				getFunc				= function() return PP.SV.skin_backdrop_tile end,
				setFunc				= function(value) PP.SV.skin_backdrop_tile = value end,
				default				= DEF_SKIN.skin_backdrop_tile,
				width				= "half",
			},
			{	type				= 'dropdown',
				name				= GetString(PP_LAM_LIST_STYLE_TILE_SIZE),
				choices				= {2, 4, 8, 16, 32, 64, 128, 256, 512, 1024},
				getFunc				= function() return PP.SV.skin_backdrop_tile_size end,
				setFunc				= function(value) PP.SV.skin_backdrop_tile_size = value end,
				default				= DEF_SKIN.skin_backdrop_tile_size,
				width				= "half",
				disabled			= function() return not PP.SV.skin_backdrop_tile end,
			},
			{	type				= "colorpicker", name = GetString(PP_LAM_LIST_STYLE_COLOR),
				getFunc				= function() return unpack(PP.SV.skin_backdrop_col) end,
				setFunc				= function(r, g, b, a) PP.SV.skin_backdrop_col = { r, g, b, a } end,
				width				= "half",
				default				= {r = DEF_SKIN.skin_backdrop_col[1], g = DEF_SKIN.skin_backdrop_col[2], b = DEF_SKIN.skin_backdrop_col[3], a = DEF_SKIN.skin_backdrop_col[4]},
			},

			{	type = "header", name = GetString(PP_LAM_LIST_STYLE_EDGE), },
			{	type				= 'iconpicker',
				-- name				= "Edge",
				choices				= PP.media.edge,
				choicesTooltips		= PP.media.name_edge,
				getFunc				= function() return PP.SV.skin_edge end,
				setFunc				= function(str) PP.SV.skin_edge = str end,
				maxColumns			= 3,
				visibleRows			= 5,
				iconSize			= 52,
				default				= DEF_SKIN.skin_edge,
				width				= "half",
			},
			{	type 				= "slider", name = GetString(PP_LAM_LIST_STYLE_THICKNESS),
				max					= 128, min = 1,
				getFunc				= function() return PP.SV.skin_edge_thickness end,
				setFunc				= function(value) PP.SV.skin_edge_thickness = value end,
				default				= DEF_SKIN.skin_edge_thickness,
				width				= "half",
			},
			{	type				= 'dropdown',
				name				= GetString(PP_LAM_LIST_STYLE_FILE_WIDTH),
				choices				= {2, 4, 8, 16, 32, 64, 128, 256, 512, 1024},
				getFunc				= function() return PP.SV.skin_edge_file_width end,
				setFunc				= function(value) PP.SV.skin_edge_file_width = value end,
				default				= DEF_SKIN.skin_edge_file_width,
				width				= "half",
			},
			{	type				= 'dropdown',
				name				= GetString(PP_LAM_LIST_STYLE_FILE_HEIGHT),
				choices				= {2, 4, 8, 16, 32, 64, 128, 256, 512, 1024},
				getFunc				= function() return PP.SV.skin_edge_file_height end,
				setFunc				= function(value) PP.SV.skin_edge_file_height = value end,
				default				= DEF_SKIN.skin_edge_file_height,
				width				= "half",
			},
			{	type				= "colorpicker", name = GetString(PP_LAM_LIST_STYLE_COLOR),
				getFunc				= function() return unpack(PP.SV.skin_edge_col) end,
				setFunc				= function(r, g, b, a) PP.SV.skin_edge_col = { r, g, b, a } end,
				width				= "half",
				default				= {r = DEF_SKIN.skin_edge_col[1], g = DEF_SKIN.skin_edge_col[2], b = DEF_SKIN.skin_edge_col[3], a = DEF_SKIN.skin_edge_col[4]},
			},
			{	type				= "checkbox", name = GetString(PP_LAM_LIST_STYLE_STRETCH_TEXTURE_EDGE),
				getFunc				= function() return PP.SV.skin_edge_integral_wrapping end,
				setFunc				= function(value) PP.SV.skin_edge_integral_wrapping = value end,
				default				= DEF_SKIN.skin_edge_integral_wrapping,
				width				= "half",
			},
		},
	})
	---------------------------------------------
	local DEF_LIST_SKIN = {
		list_skin_backdrop					= "",
		list_skin_backdrop_col				= {10/255, 10/255, 10/255, 220/255},
		list_skin_backdrop_hl_col			= {96/255*.3, 125/255*.3, 139/255*.3, 220/255},
		list_skin_backdrop_insets			= 0,
		list_skin_backdrop_tile				= false,
		list_skin_backdrop_tile_size		= 8,
		list_skin_edge						= "PerfectPixel/textures/edge.dds",
		list_skin_edge_col					= {10/255, 10/255, 10/255, 240/255},
		list_skin_edge_sel_col				= {96/255, 125/255, 139/255, 220/255},
		list_skin_edge_thickness			= 10,
		list_skin_edge_file_width			= 128,
		list_skin_edge_file_height			= 16,
		list_skin_edge_integral_wrapping	= false,
		list_fade_distance					= 6,
		list_uniform_control_height			= 42,
		list_control_height					= 40,
	}
	PP.SV.list_skin = ZO_SavedVars:NewAccountWide(PP.ADDON_NAME, SV_VER, "List style", DEF_LIST_SKIN, GetWorldName())

	table.insert(PP.optionsData,
	{	type = "submenu", name = GetString(PP_LAM_LIST_STYLE),
		controls = {
			{	type = "header", name = GetString(PP_LAM_LIST_STYLE_BACKDROP), },
			{	type				= 'iconpicker',
				-- name				= "Backdrop",
				choices				= PP.media.backdrop,
				choicesTooltips		= PP.media.name_backdrop,
				getFunc				= function() return PP.SV.list_skin.list_skin_backdrop end,
				setFunc				= function(str) PP.SV.list_skin.list_skin_backdrop = str PP.ResetStyle() end,
				maxColumns			= 3,
				visibleRows			= 5,
				iconSize			= 52,
				default				= DEF_LIST_SKIN.list_skin_backdrop,
				width				= "half",
			},
			{	type 				= "slider", name = GetString(PP_LAM_LIST_STYLE_INSETS),
				max					= 100, min = 0,
				getFunc				= function() return PP.SV.list_skin.list_skin_backdrop_insets end,
				setFunc				= function(value) PP.SV.list_skin.list_skin_backdrop_insets = value PP.ResetStyle() end,
				default				= DEF_LIST_SKIN.list_skin_backdrop_insets,
				width				= "half",
			},
			{	type				= "checkbox", name = GetString(PP_LAM_LIST_STYLE_TILE_LAYING),
				getFunc				= function() return PP.SV.list_skin.list_skin_backdrop_tile end,
				setFunc				= function(value) PP.SV.list_skin.list_skin_backdrop_tile = value PP.ResetStyle() end,
				default				= DEF_LIST_SKIN.list_skin_backdrop_tile,
				width				= "half",
			},
			{	type				= 'dropdown',
				name				= GetString(PP_LAM_LIST_STYLE_TILE_SIZE),
				choices				= {2, 4, 8, 16, 32, 64, 128, 256, 512, 1024},
				getFunc				= function() return PP.SV.list_skin.list_skin_backdrop_tile_size end,
				setFunc				= function(value) PP.SV.list_skin.list_skin_backdrop_tile_size = value PP.ResetStyle() end,
				default				= DEF_LIST_SKIN.list_skin_backdrop_tile_size,
				width				= "half",
				disabled			= function() return not PP.SV.list_skin.list_skin_backdrop_tile end,
			},
			{	type				= "colorpicker", name = GetString(PP_LAM_LIST_STYLE_COLOR),
				getFunc				= function() return unpack(PP.SV.list_skin.list_skin_backdrop_col) end,
				setFunc				= function(r, g, b, a) PP.SV.list_skin.list_skin_backdrop_col = { r, g, b, a } PP.ResetStyle() end,
				width				= "half",
				default				= {r = DEF_LIST_SKIN.list_skin_backdrop_col[1], g = DEF_LIST_SKIN.list_skin_backdrop_col[2], b = DEF_LIST_SKIN.list_skin_backdrop_col[3], a = DEF_LIST_SKIN.list_skin_backdrop_col[4]},
			},
			{	type				= "colorpicker", name = GetString(PP_LAM_LIST_STYLE_HIGHLIGHT_COLOR),
				getFunc				= function() return unpack(PP.SV.list_skin.list_skin_backdrop_hl_col) end,
				setFunc				= function(r, g, b, a) PP.SV.list_skin.list_skin_backdrop_hl_col = { r, g, b, a } PP.ResetStyle() end,
				width				= "half",
				default				= {r = DEF_LIST_SKIN.list_skin_backdrop_hl_col[1], g = DEF_LIST_SKIN.list_skin_backdrop_hl_col[2], b = DEF_LIST_SKIN.list_skin_backdrop_hl_col[3], a = DEF_LIST_SKIN.list_skin_backdrop_hl_col[4]},
			},

			{	type = "header", name = GetString(PP_LAM_LIST_STYLE_EDGE), },
			{	type				= 'iconpicker',
				-- name				= "Edge",
				choices				= PP.media.edge,
				choicesTooltips		= PP.media.name_edge,
				getFunc				= function() return PP.SV.list_skin.list_skin_edge end,
				setFunc				= function(str) PP.SV.list_skin.list_skin_edge = str PP.ResetStyle() end,
				maxColumns			= 3,
				visibleRows			= 5,
				iconSize			= 52,
				default				= DEF_LIST_SKIN.list_skin_edge,
				width				= "half",
			},
			{	type 				= "slider", name = GetString(PP_LAM_LIST_STYLE_THICKNESS),
				max					= 128, min = 1,
				getFunc				= function() return PP.SV.list_skin.list_skin_edge_thickness end,
				setFunc				= function(value) PP.SV.list_skin.list_skin_edge_thickness = value PP.ResetStyle() end,
				default				= DEF_LIST_SKIN.list_skin_edge_thickness,
				width				= "half",
			},
			{	type				= 'dropdown',
				name				= GetString(PP_LAM_LIST_STYLE_FILE_WIDTH),
				choices				= {2, 4, 8, 16, 32, 64, 128, 256, 512, 1024},
				getFunc				= function() return PP.SV.list_skin.list_skin_edge_file_width end,
				setFunc				= function(value) PP.SV.list_skin.list_skin_edge_file_width = value PP.ResetStyle() end,
				default				= DEF_LIST_SKIN.list_skin_edge_file_width,
				width				= "half",
			},
			{	type				= 'dropdown',
				name				= GetString(PP_LAM_LIST_STYLE_FILE_HEIGHT),
				choices				= {2, 4, 8, 16, 32, 64, 128, 256, 512, 1024},
				getFunc				= function() return PP.SV.list_skin.list_skin_edge_file_height end,
				setFunc				= function(value) PP.SV.list_skin.list_skin_edge_file_height = value PP.ResetStyle() end,
				default				= DEF_LIST_SKIN.list_skin_edge_file_height,
				width				= "half",
			},
			{	type				= "colorpicker", name = GetString(PP_LAM_LIST_STYLE_COLOR),
				getFunc				= function() return unpack(PP.SV.list_skin.list_skin_edge_col) end,
				setFunc				= function(r, g, b, a) PP.SV.list_skin.list_skin_edge_col = { r, g, b, a } PP.ResetStyle() end,
				width				= "half",
				default				= {r = DEF_LIST_SKIN.list_skin_edge_col[1], g = DEF_LIST_SKIN.list_skin_edge_col[2], b = DEF_LIST_SKIN.list_skin_edge_col[3], a = DEF_LIST_SKIN.list_skin_edge_col[4]},
			},
			{	type				= "colorpicker", name = GetString(PP_LAM_LIST_STYLE_SELECTED_COLOR),
				getFunc				= function() return unpack(PP.SV.list_skin.list_skin_edge_sel_col) end,
				setFunc				= function(r, g, b, a) PP.SV.list_skin.list_skin_edge_sel_col = { r, g, b, a } PP.ResetStyle() end,
				width				= "half",
				default				= {r = DEF_LIST_SKIN.list_skin_edge_sel_col[1], g = DEF_LIST_SKIN.list_skin_edge_sel_col[2], b = DEF_LIST_SKIN.list_skin_edge_sel_col[3], a = DEF_LIST_SKIN.list_skin_edge_sel_col[4]},
			},
			{	type				= "checkbox", name = GetString(PP_LAM_LIST_STYLE_STRETCH_TEXTURE_EDGE),
				getFunc				= function() return PP.SV.list_skin.list_skin_edge_integral_wrapping end,
				setFunc				= function(value) PP.SV.list_skin.list_skin_edge_integral_wrapping = value PP.ResetStyle() end,
				default				= DEF_LIST_SKIN.list_skin_edge_integral_wrapping,
				width				= "half",
			},
			{	type = "header", name = GetString(PP_LAM_LIST_STYLE_LIST), },
			{	type 				= "slider", name = GetString(PP_LAM_LIST_STYLE_FADE_DISTANCE),
				max					= 100, min = 0,
				getFunc				= function() return PP.SV.list_skin.list_fade_distance end,
				setFunc				= function(value) PP.SV.list_skin.list_fade_distance = value PP.ResetStyle() end,
				default				= DEF_LIST_SKIN.list_fade_distance,
				width				= "half",
			},
			{	type 				= "slider", name = GetString(PP_LAM_LIST_STYLE_UNIFORM_CONTROL_HEIGHT),
				max					= 100, min = 1,
				getFunc				= function() return PP.SV.list_skin.list_uniform_control_height end,
				setFunc				= function(value) PP.SV.list_skin.list_uniform_control_height = value PP.ResetStyle() end,
				default				= DEF_LIST_SKIN.list_uniform_control_height,
				width				= "half",
			},
			{	type 				= "slider", name = GetString(PP_LAM_LIST_STYLE_CONTROL_HEIGHT),
				max					= 100, min = 1,
				getFunc				= function() return PP.SV.list_skin.list_control_height end,
				setFunc				= function(value) PP.SV.list_skin.list_control_height = value PP.ResetStyle() end,
				default				= DEF_LIST_SKIN.list_control_height,
				width				= "half",
			},
		},
	})
--===============================================================================================--

end

local function Core()
--===============================================================================================--
	local SV_VER				= 0.3
	local DEF = {
		DoNotInterrupt_toggle	= true,
		blur_background_toggle	= true,
		-- fade_scene_duration		= 20,
	}
	local SV = ZO_SavedVars:NewAccountWide(PP.ADDON_NAME, SV_VER, "Scene manager", DEF, GetWorldName())
	---------------------------------------------
	table.insert(PP.optionsData,
	{	type				= "submenu",
		name				= GetString(PP_LAM_OTHERS),
		controls = {
			{	type				= "checkbox",
				name				= GetString(PP_LAM_DONOTINTERRUPT),
				getFunc				= function() return SV.DoNotInterrupt_toggle end,
				setFunc				= function(value) SV.DoNotInterrupt_toggle = value end,
				default				= DEF.DoNotInterrupt_toggle,
			},
			{	type				= "checkbox",
				name				= GetString(PP_LAM_BLUR_BG),
				getFunc				= function() return SV.blur_background_toggle end,
				setFunc				= function(value) SV.blur_background_toggle = value end,
				default				= DEF.blur_background_toggle,
			},
			-- {	type 				= "slider", name = GetString(PP_LAM_FADE_SCENE_DURATION),
				-- max					= 1000, min = 0,
				-- getFunc				= function() return SV.fade_scene_duration end,
				-- setFunc				= function(value) SV.fade_scene_duration = value end,
				-- default				= DEF.fade_scene_duration,
			-- },
		},
	})
--===============================================================================================--
	local function RefreshControlMode_1(control, data, dataType)
		control:SetHeight(PP.SV.list_skin.list_control_height)
		--"SellPrice"--------------------
		if control:GetNamedChild("SellPrice") then
			local sp = control:GetNamedChild("SellPrice")
			PP.Font(sp, --[[Font]] PP.f.u67, 15, "shadow", --[[Alpha]] nil, --[[Color]] nil, nil, nil, nil, --[[StyleColor]] 0, 0, 0, .5)
			sp:SetHidden(false)
			PP:SetLockedFn(sp, 'SetFont')
	end
		--"ButtonStackCount"-------------
		if control:GetNamedChild("ButtonStackCount") then
			local stack = control:GetNamedChild("ButtonStackCount")
			PP.Font(stack, --[[Font]] PP.f.u67, 15, "outline", --[[Alpha]] nil, --[[Color]] nil, nil, nil, nil, --[[StyleColor]] 0, 0, 0, .5)
			PP.Anchor(stack, --[[#1]] LEFT, control:GetNamedChild("ButtonIcon"), LEFT, 34, 8)
		end
		--"Button"-------------
		if control:GetNamedChild("Button") then
			local button = control:GetNamedChild("Button")
			button:SetDimensions(36, 36)
			PP.Anchor(button, --[[#1]] CENTER, control, LEFT, 60, 0)
			if GridList then
				button.customTooltipAnchor = nil
			end
		end
		--"Status"-------------
		if control:GetNamedChild("Status") then
			local status = control:GetNamedChild("Status")
			status:SetDimensions(26, 26)
			PP.Anchor(status, --[[#1]] CENTER, control, LEFT, 18, 0)
			status:SetAlpha(1)
			status:SetMouseEnabled(true)
			status:GetNamedChild("Texture"):SetMouseEnabled(true)
			status:GetNamedChild("Texture"):SetDrawLayer(DL_BACKGROUND)
		end
		--"Name"-------------
		if control:GetNamedChild("Name") then
			local name = control:GetNamedChild("Name")
			PP.Font(name, --[[Font]] PP.f.u67, 15, "shadow", --[[Alpha]] nil, --[[Color]] nil, nil, nil, nil, --[[StyleColor]] 0, 0, 0, .5)
			PP.Anchor(name, --[[#1]] LEFT, control, LEFT, 110, -1)
			name:SetLineSpacing(0)
			name:SetVerticalAlignment(TEXT_ALIGN_CENTER)
			name:SetHidden(false)
		end
		--"SellInformation"----------
		if control:GetNamedChild("SellInformation") then
			local sellInfo = control:GetNamedChild("SellInformation")
			sellInfo:SetDimensions(32, 32)
			sellInfo:ClearAnchors()
			sellInfo:SetAnchor(RIGHT, control:GetNamedChild("SellPrice"), LEFT, -5, 0)
			sellInfo:SetAlpha(1)
			sellInfo:SetDrawLayer(DL_CONTROLS)
			sellInfo:SetMouseEnabled(true)
		end
		--"Trait"----------
		if control:GetNamedChild("TraitInfo") then
			local trait = control:GetNamedChild("TraitInfo")
			trait:SetDimensions(32, 32)
			trait:SetAnchorFill(control:GetNamedChild("SellInformation"))
			trait:SetAlpha(1)
			trait:SetDrawLayer(DL_CONTROLS)
			trait:SetMouseEnabled(true)
		end
		--"Bg"-------------
		if control:GetNamedChild("Bg") then
			local bg = control:GetNamedChild("Bg")
			bg:SetTexture(PP.t.clear)
		end
		--"Highlight"-------------
		if control:GetNamedChild("Highlight") then
			local highlight = control:GetNamedChild("Highlight")
			highlight:SetHidden(true)
			-- highlight:SetTexture(PP.t.clear)
		end
		--"Backdrop"-------------
		local backdrop = PP.CreateBackdrop(control)
		backdrop:SetCenterColor(unpack(PP.SV.list_skin.list_skin_backdrop_col))
		backdrop:SetCenterTexture(PP.SV.list_skin.list_skin_backdrop, PP.SV.list_skin.list_skin_backdrop_tile_size, PP.SV.list_skin.list_skin_backdrop_tile and 1 or 0)
		backdrop:SetEdgeColor(unpack(PP.SV.list_skin.list_skin_edge_col))
		backdrop:SetEdgeTexture(PP.SV.list_skin.list_skin_edge, PP.SV.list_skin.list_skin_edge_file_width, PP.SV.list_skin.list_skin_edge_file_height, PP.SV.list_skin.list_skin_edge_thickness, 0)
		backdrop:SetInsets(PP.SV.list_skin.list_skin_backdrop_insets, PP.SV.list_skin.list_skin_backdrop_insets, -PP.SV.list_skin.list_skin_backdrop_insets, -PP.SV.list_skin.list_skin_backdrop_insets)
		backdrop:SetIntegralWrapping(PP.SV.list_skin.list_skin_edge_integral_wrapping)
		---------------------------------
	end

	for _, list in ipairs( PP.TabList ) do
		list.refreshControlMode_1 = RefreshControlMode_1
		for typeId in pairs(list.dataTypes) do
			if typeId == 1 or typeId == 2 or typeId == 3 then
				local dataType = ZO_ScrollList_GetDataTypeTable(list, typeId)

				if dataType.height then
					dataType.height = PP.SV.list_skin.list_control_height
				end
----------------Impresarrio Fix--------------------------------------------------------------------
				if list ~= ZO_StoreWindowList then
					PP.Hook_m_Factory(dataType, function(control)
						if list.mode == 3 then return end
						list.refreshControlMode_1(control, data, dataType)
					end)
				else
					PP.Hook_SetupCallback(dataType, function(control, data)
						if list.mode == 3 or control.changes then return end
						control.changes = true
						list.refreshControlMode_1(control, data, dataType)
					end)
				end
---------------------------------------------------------------------------------------------------
				if list.mode ~= 3 then
					local pool = dataType.pool

					for _, control in pairs(pool.m_Free) do
						list.refreshControlMode_1(control, data, dataType)
					end
					for _, control in pairs(pool.m_Active) do
						list.refreshControlMode_1(control, data, dataType)
					end
				end
			end
		end
	end
	---------------------------------------------
	for _, list in ipairs(PP.TabList) do
		if list.uniformControlHeight then
			list.uniformControlHeight = PP.SV.list_skin.list_uniform_control_height
		end
		if list.useFadeGradient then
			ZO_Scroll_SetMaxFadeDistance(list, PP.SV.list_skin.list_fade_distance)
		end
	end

---------------------------------------------------------------------------------------------------
-- ZO_KeybindStrip --> Moved to modules/keybindStrip.lua
	--local keybindStripHeight = 31
	--ZO_KeybindStripControl:SetHeight(keybindStripHeight)
	--ZO_KeybindStripMungeBackground:SetHeight(keybindStripHeight)
	--ZO_KeybindStripMungeBackgroundTexture:SetHidden(true)
	--PP:CreateBackground(ZO_KeybindStripMungeBackground, --[[#1]] nil, nil, nil, -6, 0, --[[#2]] nil, nil, nil, 6, 6)

-- ZO_MainMenuSceneGroupBar
	PP.Anchor(ZO_MainMenuSceneGroupBar, --[[#1]] TOPRIGHT, GuiRoot, TOPRIGHT, -30, 64)

--FIX market scene
	local tabMarketScenes = {"market", "endeavorSealStoreSceneKeyboard", "esoPlusOffersSceneKeyboard", "dailyLoginRewards", "giftInventoryKeyboard"}
	for _, scene in pairs(tabMarketScenes) do
		SCENE_MANAGER:GetScene(scene):RegisterCallback("StateChange", function(oldState, newState)
			if newState == SCENE_SHOWING then
				PP.Anchor(ZO_MainMenuSceneGroupBar, --[[#1]] RIGHT, GuiRoot, RIGHT, -40, -340)
				ZO_KeybindStripMungeBackgroundTexture:SetHidden(false)
			elseif newState == SCENE_HIDDEN then
				PP.Anchor(ZO_MainMenuSceneGroupBar, --[[#1]] TOPRIGHT, GuiRoot, TOPRIGHT, -30, 64)
				ZO_KeybindStripMungeBackgroundTexture:SetHidden(true)
			end
		end)
	end

--CROWN_CRATE_KEYBOARD_SCENE
	PP.Anchor(ZO_CrownCratesGemsCounter, --[[#1]] BOTTOMLEFT, GuiRoot, BOTTOMLEFT, 10, -2)
	ZO_CrownCratesGemsCounterGemIcon:SetDimensions(22, 22)
	PP.Font(ZO_CrownCratesGemsCounterGemsHeader, --[[Font]] PP.f.u67, 20, "outline", --[[Alpha]] nil, --[[Color]] nil, nil, nil, nil, --[[StyleColor]] 0, 0, 0, .5)
	PP.Font(ZO_CrownCratesGemsCounterGems, --[[Font]] PP.f.u67, 20, "outline", --[[Alpha]] nil, --[[Color]] nil, nil, nil, nil, --[[StyleColor]] 0, 0, 0, .5)
	
--FadeAnimations---------------------------------------------------------------------------------------
	-- treasureMapQuickSlot
	-- treasureMapInventory
	-- DEFAULT_SCENE_TRANSITION_TIME = 1
	-- ZO_CONVEYOR_TRANSITION_TIME = 1
	-- DEFAULT_HUD_DURATION = 1
	PLAYER_PROGRESS_BAR_FRAGMENT.suppressFadeTimeline:GetAnimation():SetDuration(1)

	local fade_scene_duration = 20

	ZO_PreHook(ZO_FadeSceneFragment, "Show", function(self, ...)
		if self.duration > fade_scene_duration then
			self.duration = fade_scene_duration
			self.control:SetAlpha(1)
			local alphaAnimation = self:GetAnimation():GetFirstAnimation()
			alphaAnimation:SetEndAlpha(1)
			alphaAnimation:SetStartAlpha(1)
		end
	end)
	ZO_PreHook(ZO_HUDFadeSceneFragment, "Show", function(self, ...)
		if self.showDuration > fade_scene_duration then
			self.showDuration = fade_scene_duration
			self.control:SetAlpha(1)
			local alphaAnimation = self:GetAnimation():GetFirstAnimation()
			alphaAnimation:SetEndAlpha(1)
			alphaAnimation:SetStartAlpha(1)
		end
	end)

	-- ZO_PreHook(ZO_PlayerProgressBarFragment, "Hide", function(self, ...)
		-- local instant = self.sceneManager:GetCurrentScene() == self.sceneManager:GetBaseScene()
		-- ZO_Animation_PlayBackwardOrInstantlyToStart(self.suppressFadeTimeline, true)
		-- return true
	-- end)

---------------------------------------------------------------------------------------------------
	ZO_PreHook("SetFullscreenEffect", function()
		if SV.blur_background_toggle then return end
		return true
	end)
	--
	ZO_PreHook(END_IN_WORLD_INTERACTIONS_FRAGMENT, "Show", function(self)
		if not SV.DoNotInterrupt_toggle then return end
		EndPendingInteraction()
		self:OnShown()
		return true
	end)
---------------------------------------------------------------------------------------------------
end

--ZO_KeybindStripStyle---------------------------
local tabKeybindStripStyles = {KEYBIND_STRIP_STANDARD_STYLE, KEYBIND_STRIP_CHAMPION_KEYBOARD_STYLE}
for _, keybindStrip in pairs(tabKeybindStripStyles) do
	keybindStrip.nameFont				= PP.f.u67 .. "|18|outline"
	keybindStrip.keyFont				= PP.f.u57 .. "|16"
	keybindStrip.resizeToFitPadding		= 20
	keybindStrip.leftAnchorOffset		= 10
	keybindStrip.centerAnchorOffset		= 0
	keybindStrip.rightAnchorOffset		= -10
end

RedirectTexture("EsoUI/Art/Miscellaneous/interactKeyFrame_edge.dds", "PerfectPixel/textures/RedirectTextures/EsoUI/Art/Miscellaneous/interactKeyFrame_edge.dds")
RedirectTexture("EsoUI/Art/Miscellaneous/interactkeyframe_center.dds", "PerfectPixel/textures/RedirectTextures/EsoUI/Art/Miscellaneous/interactkeyframe_center.dds")

---------------------------------------------------------------------------------------------------
local function OnAddonLoaded(eventType, addonName)
	if addonName == PP.ADDON_NAME then
	--UnregisterForEvent--
		EVENT_MANAGER:UnregisterForEvent(PP.ADDON_NAME, EVENT_ADD_ON_LOADED)

		--
		Settings()
		Core()
		--
		PP.tooltips()
		PP.compass()
		PP.reticle()
		PP.tabs()
		PP.dialogsMenu()
		--PP.chatWindow() not at addon loaded as chat will be ready after event_player_activated
		--
		PP.inventoryScene()

		PP.tradingHouseScene()

		PP.lootScene()
		
		PP.restyleStationKeyboardSceneGroup()

		PP.craftStationScenes()

		PP.statsScene()
		PP.skillsScene()
		PP.journalSceneGroup()
		PP.collectionsSceneGroup()
		PP.worldMapScene()
		PP.groupMenuKeyboardScene()
		PP.friendsListGroup()
		PP.guildSceneGroup()
		PP.allianceWarSceneGroup()
		PP.mailSceneGroup()
		PP.notificationsScene()
		PP.helpSceneGroup()
		--
		PP.gameMenuInGameScene()
		--
		--
		PP.scrolling()
		PP.performanceMeter()
		-- PP.playerProgressBar()
		PP.keybindStripModule.Load(true)

		PP.compatibility()
		--
		EVENT_MANAGER:RegisterForEvent(PP.ADDON_NAME .. "searchBox", EVENT_PLAYER_ACTIVATED,
				function()
					PP.searchBox()
					PP.chatWindow()
				end)
		--
		LibAddonMenu2:RegisterOptionControls("PerfectPixelOptions", PP.optionsData)
	end
end
EVENT_MANAGER:RegisterForEvent(PP.ADDON_NAME, EVENT_ADD_ON_LOADED, OnAddonLoaded)