local PP = PP ---@class PP
local media		= PP.media
local unpack	= unpack
local tinsert	= table.insert

PP.LAM_MediaTable	= {
	name_backdrop	= {},
	backdrop		= {},
	name_edge		= {},
	edge			= {},
	name_font		= {},
	font			= {},
}

local LAM_MediaTable = PP.LAM_MediaTable

for k, v in ipairs(media.textures) do
	LAM_MediaTable.name_backdrop[k]	= v.name
	LAM_MediaTable.backdrop[k]		= v.item
end
for k, v in ipairs(media.edges) do
	LAM_MediaTable.name_edge[k]	= v.name
	LAM_MediaTable.edge[k]		= v.item
end
for k, v in ipairs(media.fonts) do
	LAM_MediaTable.name_font[k]	= v.name
	LAM_MediaTable.font[k]		= v.item
end

--==Settings template===================================================================--
function PP.PackTables(...)
	local tables	= {...}
	local pack		= {}

	for _, t in ipairs(tables) do
		for _, v in ipairs(t) do
			table.insert(pack, v)
		end
	end

	return pack
end

function PP:AddBackdropSettings(namespace, updateFn)
	namespace			= namespace	or 'WindowStyle'
	updateFn			= updateFn	or self.UpdateBackgrounds
	local sv, def			= self:GetSavedVars(namespace)

	return
	{
		{	type = "header", name = GetString(PP_LAM_WINDOW_STYLE), },
		{	type				= 'iconpicker', name = GetString(PP_LAM_LIST_STYLE_BACKDROP),
			choices				= LAM_MediaTable.backdrop,
			choicesTooltips		= LAM_MediaTable.name_backdrop,
			getFunc				= function() return sv.skin_backdrop end,
			setFunc				= function(str) sv.skin_backdrop = str updateFn(self, namespace) end,
			maxColumns			= 3,
			visibleRows			= 5,
			iconSize			= 52,
			default				= def.skin_backdrop,
			width				= "half",
		},
		{	type 				= "slider", name = GetString(PP_LAM_LIST_STYLE_INSETS),
			max					= 100, min = 0,
			getFunc				= function() return sv.skin_backdrop_insets end,
			setFunc				= function(value) sv.skin_backdrop_insets = value updateFn(self, namespace) end,
			default				= def.skin_backdrop_insets,
			width				= "half",
		},
		{	type				= "checkbox", name = GetString(PP_LAM_LIST_STYLE_TILE_LAYING),
			getFunc				= function() return sv.skin_backdrop_tile end,
			setFunc				= function(value) sv.skin_backdrop_tile = value updateFn(self, namespace) end,
			default				= def.skin_backdrop_tile,
			width				= "half",
		},
		{	type				= 'dropdown',
			name				= GetString(PP_LAM_LIST_STYLE_TILE_SIZE),
			choices				= {2, 4, 8, 16, 32, 64, 128, 256, 512, 1024},
			getFunc				= function() return sv.skin_backdrop_tile_size end,
			setFunc				= function(value) sv.skin_backdrop_tile_size = value updateFn(self, namespace) end,
			default				= def.skin_backdrop_tile_size,
			width				= "half",
			disabled			= function() return not sv.skin_backdrop_tile end,
		},
		{	type				= "colorpicker", name = GetString(PP_LAM_LIST_STYLE_COLOR),
			getFunc				= function() return unpack(sv.skin_backdrop_col) end,
			setFunc				= function(r, g, b, a) sv.skin_backdrop_col = { r, g, b, a } updateFn(self, namespace) end,
			width				= "half",
			default				= {r = def.skin_backdrop_col[1], g = def.skin_backdrop_col[2], b = def.skin_backdrop_col[3], a = def.skin_backdrop_col[4]},
		},
	}
end

function PP:AddEdgeSettings(namespace, updateFn)
	namespace			= namespace	or 'WindowStyle'
	updateFn			= updateFn	or self.UpdateBackgrounds
	local sv, def			= self:GetSavedVars(namespace)

	return
	{
		{	type = "header", name = GetString(PP_LAM_LIST_STYLE_EDGE), },
		{	type				= 'iconpicker',
			-- name				= "Edge",
			choices				= LAM_MediaTable.edge,
			choicesTooltips		= LAM_MediaTable.name_edge,
			getFunc				= function() return sv.skin_edge end,
			setFunc				= function(str) sv.skin_edge = str updateFn(self, namespace) end,
			maxColumns			= 3,
			visibleRows			= 5,
			iconSize			= 52,
			default				= def.skin_edge,
			width				= "half",
		},
		{	type 				= "slider", name = GetString(PP_LAM_LIST_STYLE_THICKNESS),
			max					= 128, min = 1,
			getFunc				= function() return sv.skin_edge_thickness end,
			setFunc				= function(value) sv.skin_edge_thickness = value updateFn(self, namespace) end,
			default				= def.skin_edge_thickness,
			width				= "half",
		},
		{	type				= 'dropdown',
			name				= GetString(PP_LAM_LIST_STYLE_FILE_WIDTH),
			choices				= {2, 4, 8, 16, 32, 64, 128, 256, 512, 1024},
			getFunc				= function() return sv.skin_edge_file_width end,
			setFunc				= function(value) sv.skin_edge_file_width = value updateFn(self, namespace) end,
			default				= def.skin_edge_file_width,
			width				= "half",
		},
		{	type				= 'dropdown',
			name				= GetString(PP_LAM_LIST_STYLE_FILE_HEIGHT),
			choices				= {2, 4, 8, 16, 32, 64, 128, 256, 512, 1024},
			getFunc				= function() return sv.skin_edge_file_height end,
			setFunc				= function(value) sv.skin_edge_file_height = value updateFn(self, namespace) end,
			default				= def.skin_edge_file_height,
			width				= "half",
		},
		{	type				= "colorpicker", name = GetString(PP_LAM_LIST_STYLE_COLOR),
			getFunc				= function() return unpack(sv.skin_edge_col) end,
			setFunc				= function(r, g, b, a) sv.skin_edge_col = { r, g, b, a } updateFn(self, namespace) end,
			width				= "half",
			default				= {r = def.skin_edge_col[1], g = def.skin_edge_col[2], b = def.skin_edge_col[3], a = def.skin_edge_col[4]},
		},
		{	type				= "checkbox", name = GetString(PP_LAM_LIST_STYLE_STRETCH_TEXTURE_EDGE),
			getFunc				= function() return sv.skin_edge_integral_wrapping end,
			setFunc				= function(value) sv.skin_edge_integral_wrapping = value updateFn(self, namespace) end,
			default				= def.skin_edge_integral_wrapping,
			width				= "half",
		},
	}
end

--===============================================================================================--
function PP.Settings()

--==LAM=============================================================================================--
	local panelData = {
		type					= "panel",
		name					= PP.ADDON_NAME,
		version					= PP.ADDON_VERSION,
		author					= PP.ADDON_AUTHOR .. " and great help from Votan.",
		website					= PP.ADDON_WEBSITE,
		slashCommand			= "/pp",
		registerForRefresh		= true,
		registerForDefaults		= true,
	}
	if LibAddonMenu2 then
		LibAddonMenu2:RegisterAddonPanel("PerfectPixelOptions", panelData)

		CALLBACK_MANAGER:RegisterCallback("LAM-PanelOpened", function(panel)
			if panel ~= PerfectPixelOptions then return end
			SCENE_MANAGER:GetScene('gameMenuInGame'):AddFragment(INVENTORY_FRAGMENT)
		end)
		CALLBACK_MANAGER:RegisterCallback("LAM-PanelClosed", function(panel)
			if panel ~= PerfectPixelOptions then return end
			SCENE_MANAGER:GetScene('gameMenuInGame'):RemoveFragment(INVENTORY_FRAGMENT)
		end)
	end

--==WindowStyle=============================================================================================--
	table.insert(PP.optionsData,
	{	type = "submenu", name = GetString(PP_LAM_WINDOW_STYLE),
		controls = PP.PackTables(
			PP:AddBackdropSettings('WindowStyle'),
			PP:AddEdgeSettings('WindowStyle')
		),
	})
--==ListStyle=============================================================================================--
	table.insert(PP.optionsData,
	{	type = "submenu", name = GetString(PP_LAM_LIST_STYLE),
		controls = {
			{	type = "header", name = GetString(PP_LAM_LIST_STYLE_BACKDROP), },
			{	type				= 'iconpicker',
				-- name				= "Backdrop",
				choices				= LAM_MediaTable.backdrop,
				choicesTooltips		= LAM_MediaTable.name_backdrop,
				getFunc				= function() return PP.savedVars.ListStyle.list_skin_backdrop end,
				setFunc				= function(str) PP.savedVars.ListStyle.list_skin_backdrop = str PP.ResetStyle() end,
				maxColumns			= 3,
				visibleRows			= 5,
				iconSize			= 52,
				default				= PP.savedVars.ListStyle.default.list_skin_backdrop,
				width				= "half",
			},
			{	type 				= "slider", name = GetString(PP_LAM_LIST_STYLE_INSETS),
				max					= 100, min = 0,
				getFunc				= function() return PP.savedVars.ListStyle.list_skin_backdrop_insets end,
				setFunc				= function(value) PP.savedVars.ListStyle.list_skin_backdrop_insets = value PP.ResetStyle() end,
				default				= PP.savedVars.ListStyle.default.list_skin_backdrop_insets,
				width				= "half",
			},
			{	type				= "checkbox", name = GetString(PP_LAM_LIST_STYLE_TILE_LAYING),
				getFunc				= function() return PP.savedVars.ListStyle.list_skin_backdrop_tile end,
				setFunc				= function(value) PP.savedVars.ListStyle.list_skin_backdrop_tile = value PP.ResetStyle() end,
				default				= PP.savedVars.ListStyle.default.list_skin_backdrop_tile,
				width				= "half",
			},
			{	type				= 'dropdown',
				name				= GetString(PP_LAM_LIST_STYLE_TILE_SIZE),
				choices				= {2, 4, 8, 16, 32, 64, 128, 256, 512, 1024},
				getFunc				= function() return PP.savedVars.ListStyle.list_skin_backdrop_tile_size end,
				setFunc				= function(value) PP.savedVars.ListStyle.list_skin_backdrop_tile_size = value PP.ResetStyle() end,
				default				= PP.savedVars.ListStyle.default.list_skin_backdrop_tile_size,
				width				= "half",
				disabled			= function() return not PP.savedVars.ListStyle.list_skin_backdrop_tile end,
			},
			{	type				= "colorpicker", name = GetString(PP_LAM_LIST_STYLE_COLOR),
				getFunc				= function() return unpack(PP.savedVars.ListStyle.list_skin_backdrop_col) end,
				setFunc				= function(r, g, b, a) PP.savedVars.ListStyle.list_skin_backdrop_col = { r, g, b, a } PP.ResetStyle() end,
				width				= "half",
				default				= {r = PP.savedVars.ListStyle.default.list_skin_backdrop_col[1], g = PP.savedVars.ListStyle.default.list_skin_backdrop_col[2], b = PP.savedVars.ListStyle.default.list_skin_backdrop_col[3], a = PP.savedVars.ListStyle.default.list_skin_backdrop_col[4]},
			},
			{	type				= "colorpicker", name = GetString(PP_LAM_LIST_STYLE_HIGHLIGHT_COLOR),
				getFunc				= function() return unpack(PP.savedVars.ListStyle.list_skin_backdrop_hl_col) end,
				setFunc				= function(r, g, b, a) PP.savedVars.ListStyle.list_skin_backdrop_hl_col = { r, g, b, a } PP.ResetStyle() end,
				width				= "half",
				default				= {r = PP.savedVars.ListStyle.default.list_skin_backdrop_hl_col[1], g = PP.savedVars.ListStyle.default.list_skin_backdrop_hl_col[2], b = PP.savedVars.ListStyle.default.list_skin_backdrop_hl_col[3], a = PP.savedVars.ListStyle.default.list_skin_backdrop_hl_col[4]},
			},

			{	type = "header", name = GetString(PP_LAM_LIST_STYLE_EDGE), },
			{	type				= 'iconpicker',
				-- name				= "Edge",
				choices				= LAM_MediaTable.edge,
				choicesTooltips		= LAM_MediaTable.name_edge,
				getFunc				= function() return PP.savedVars.ListStyle.list_skin_edge end,
				setFunc				= function(str) PP.savedVars.ListStyle.list_skin_edge = str PP.ResetStyle() end,
				maxColumns			= 3,
				visibleRows			= 5,
				iconSize			= 52,
				default				= PP.savedVars.ListStyle.default.list_skin_edge,
				width				= "half",
			},
			{	type 				= "slider", name = GetString(PP_LAM_LIST_STYLE_THICKNESS),
				max					= 128, min = 1,
				getFunc				= function() return PP.savedVars.ListStyle.list_skin_edge_thickness end,
				setFunc				= function(value) PP.savedVars.ListStyle.list_skin_edge_thickness = value PP.ResetStyle() end,
				default				= PP.savedVars.ListStyle.default.list_skin_edge_thickness,
				width				= "half",
			},
			{	type				= 'dropdown',
				name				= GetString(PP_LAM_LIST_STYLE_FILE_WIDTH),
				choices				= {2, 4, 8, 16, 32, 64, 128, 256, 512, 1024},
				getFunc				= function() return PP.savedVars.ListStyle.list_skin_edge_file_width end,
				setFunc				= function(value) PP.savedVars.ListStyle.list_skin_edge_file_width = value PP.ResetStyle() end,
				default				= PP.savedVars.ListStyle.default.list_skin_edge_file_width,
				width				= "half",
			},
			{	type				= 'dropdown',
				name				= GetString(PP_LAM_LIST_STYLE_FILE_HEIGHT),
				choices				= {2, 4, 8, 16, 32, 64, 128, 256, 512, 1024},
				getFunc				= function() return PP.savedVars.ListStyle.list_skin_edge_file_height end,
				setFunc				= function(value) PP.savedVars.ListStyle.list_skin_edge_file_height = value PP.ResetStyle() end,
				default				= PP.savedVars.ListStyle.default.list_skin_edge_file_height,
				width				= "half",
			},
			{	type				= "colorpicker", name = GetString(PP_LAM_LIST_STYLE_COLOR),
				getFunc				= function() return unpack(PP.savedVars.ListStyle.list_skin_edge_col) end,
				setFunc				= function(r, g, b, a) PP.savedVars.ListStyle.list_skin_edge_col = { r, g, b, a } PP.ResetStyle() end,
				width				= "half",
				default				= {r = PP.savedVars.ListStyle.default.list_skin_edge_col[1], g = PP.savedVars.ListStyle.default.list_skin_edge_col[2], b = PP.savedVars.ListStyle.default.list_skin_edge_col[3], a = PP.savedVars.ListStyle.default.list_skin_edge_col[4]},
			},
			{	type				= "colorpicker", name = GetString(PP_LAM_LIST_STYLE_SELECTED_COLOR),
				getFunc				= function() return unpack(PP.savedVars.ListStyle.list_skin_edge_sel_col) end,
				setFunc				= function(r, g, b, a) PP.savedVars.ListStyle.list_skin_edge_sel_col = { r, g, b, a } PP.ResetStyle() end,
				width				= "half",
				default				= {r = PP.savedVars.ListStyle.default.list_skin_edge_sel_col[1], g = PP.savedVars.ListStyle.default.list_skin_edge_sel_col[2], b = PP.savedVars.ListStyle.default.list_skin_edge_sel_col[3], a = PP.savedVars.ListStyle.default.list_skin_edge_sel_col[4]},
			},
			{	type				= "checkbox", name = GetString(PP_LAM_LIST_STYLE_STRETCH_TEXTURE_EDGE),
				getFunc				= function() return PP.savedVars.ListStyle.list_skin_edge_integral_wrapping end,
				setFunc				= function(value) PP.savedVars.ListStyle.list_skin_edge_integral_wrapping = value PP.ResetStyle() end,
				default				= PP.savedVars.ListStyle.default.list_skin_edge_integral_wrapping,
				width				= "half",
			},
			{	type = "header", name = GetString(PP_LAM_LIST_STYLE_LIST), },
			{	type 				= "slider", name = GetString(PP_LAM_LIST_STYLE_FADE_DISTANCE),
				max					= 100, min = 0,
				getFunc				= function() return PP.savedVars.ListStyle.list_fade_distance end,
				setFunc				= function(value) PP.savedVars.ListStyle.list_fade_distance = value PP.ResetStyle() end,
				default				= PP.savedVars.ListStyle.default.list_fade_distance,
				width				= "half",
			},
			{	type 				= "slider", name = GetString(PP_LAM_LIST_STYLE_UNIFORM_CONTROL_HEIGHT),
				max					= 100, min = 1,
				getFunc				= function() return PP.savedVars.ListStyle.list_uniform_control_height end,
				setFunc				= function(value) PP.savedVars.ListStyle.list_uniform_control_height = value PP.ResetStyle() end,
				default				= PP.savedVars.ListStyle.default.list_uniform_control_height,
				width				= "half",
			},
			{	type 				= "slider", name = GetString(PP_LAM_LIST_STYLE_CONTROL_HEIGHT),
				max					= 100, min = 1,
				getFunc				= function() return PP.savedVars.ListStyle.list_control_height end,
				setFunc				= function(value) PP.savedVars.ListStyle.list_control_height = value PP.ResetStyle() end,
				default				= PP.savedVars.ListStyle.default.list_control_height,
				width				= "half",
			},
		},
	})
--==SceneManager=============================================================================================--
	table.insert(PP.optionsData,
	{	type				= "submenu",
		name				= GetString(PP_LAM_OTHERS),
		controls = {
			{	type				= "checkbox",
				name				= GetString(PP_LAM_DONOTINTERRUPT),
				getFunc				= function() return PP.savedVars.SceneManager.DoNotInterrupt_toggle end,
				setFunc				= function(value) PP.savedVars.SceneManager.DoNotInterrupt_toggle = value end,
				default				= PP.savedVars.SceneManager.default.DoNotInterrupt_toggle,
			},
			{	type				= "checkbox",
				name				= GetString(PP_LAM_BLUR_BG),
				getFunc				= function() return PP.savedVars.SceneManager.blur_background_toggle end,
				setFunc				= function(value) PP.savedVars.SceneManager.blur_background_toggle = value end,
				default				= PP.savedVars.SceneManager.default.blur_background_toggle,
			},
			{	type 				= "slider", name = GetString(PP_LAM_FADE_SCENE_DURATION),
				max					= 1000, min = 0,
				getFunc				= function() return PP.savedVars.SceneManager.fade_scene_duration end,
				setFunc				= function(value) PP.savedVars.SceneManager.fade_scene_duration = value end,
				default				= PP.savedVars.SceneManager.default.fade_scene_duration,
			},
		},
	})

end
