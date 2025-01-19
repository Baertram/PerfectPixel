local PP = PP ---@class PP
local namespace	= 'KeybindStrip'

PP.keybindStrip = function()
--===============================================================================================--
	local sv, def = PP:AddNewSavedVars(0.3, namespace, {
		toggle							= true,
		keybindStrip_height				= 31,
		individual_color_settings		= false,

		skin_backdrop					= "PerfectPixel/tex/tex_white.dds",
		skin_backdrop_col				= {10/255, 12/255, 14/255, 200/255},
		skin_backdrop_insets			= 6,
		skin_backdrop_tile				= false,
		skin_backdrop_tile_size			= 8,
		skin_edge						= "PerfectPixel/tex/edge_outer_shadow_128x16.dds",
		skin_edge_col					= {0/255, 0/255, 0/255, 240/255},
		skin_edge_file_width			= 128,
		skin_edge_file_height			= 16,
		skin_edge_thickness				= 16,
		skin_edge_integral_wrapping		= false,
	})
	---------------------------------------------
	table.insert(PP.optionsData,
	{	type		= "submenu",
		name		= GetString(PP_LAM_KEYBINDSTRIP),
		controls	= PP.PackTables(
			{
				{	type			= "checkbox",
					name			= GetString(PP_LAM_ACTIVATE),
					getFunc			= function() return sv.toggle end,
					setFunc			= function(value) sv.toggle = value end,
					default			= def.toggle,
					requiresReload	= true,
				},
				{	type 			= "slider", name = 'Height',
					max				= 75, min = 5,
					getFunc			= function() return sv.keybindStrip_height end,
					setFunc			= function(value) sv.keybindStrip_height = value ZO_KeybindStripControl:SetHeight(value) ZO_KeybindStripMungeBackground:SetHeight(value) end,
					default			= def.keybindStrip_height,
					width			= "half",
					disabled		= function() return not sv.toggle end,
				},
				{	type				= "checkbox",
					name				= "Individual background settings",
					getFunc				= function() return sv.individual_color_settings end,
					setFunc				= function(value) sv.individual_color_settings = value end,
					default				= def.individual_color_settings,
					disabled			= function() return not sv.toggle end,
					requiresReload		= true,
				},
			},
			PP:AddBackdropSettings(namespace),
			PP:AddEdgeSettings(namespace)
		),
	})
--===============================================================================================--
	if not sv.toggle then return end

	PP:CreateBackground(ZO_KeybindStripMungeBackground, --[[#1]] nil, nil, nil, -6, 0, --[[#2]] nil, nil, nil, 6, 6, sv.individual_color_settings and namespace or nil)

	ZO_KeybindStripControl:SetHeight(sv.keybindStrip_height)
	ZO_KeybindStripMungeBackground:SetHeight(sv.keybindStrip_height)

	ZO_KeybindStripMungeBackgroundTexture:SetHidden(true)

--ZO_KeybindStripStyle---------------------------
	local t = {KEYBIND_STRIP_STANDARD_STYLE, KEYBIND_STRIP_CHAMPION_KEYBOARD_STYLE}
	for _, keybindStrip in ipairs(t) do
		keybindStrip.nameFont				= PP.f.u67 .. "|18|outline"
		keybindStrip.keyFont				= PP.f.u57 .. "|16"
		keybindStrip.resizeToFitPadding		= 20
		keybindStrip.leftAnchorOffset		= 10
		keybindStrip.centerAnchorOffset		= 0
		keybindStrip.rightAnchorOffset		= -10
	end

	RedirectTexture("EsoUI/Art/Miscellaneous/interactKeyFrame_edge.dds", "PerfectPixel/tex/RedirectTextures/EsoUI/Art/Miscellaneous/interactKeyFrame_edge.dds")
	RedirectTexture("EsoUI/Art/Miscellaneous/interactkeyframe_center.dds", "PerfectPixel/tex/RedirectTextures/EsoUI/Art/Miscellaneous/interactkeyframe_center.dds")
end