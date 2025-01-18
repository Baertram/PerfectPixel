local PP = PP ---@class PP
local namespace	= 'PerformanceMeter'

PP.performanceMeter = function()
--===============================================================================================--
	local sv, def = PP:AddNewSavedVars(0.2, namespace, {
		toggle							= true,
		skin_backdrop					= "PerfectPixel/tex/tex_white.dds",
		skin_backdrop_col				= {10/255, 12/255, 14/255, 200/255},
		skin_backdrop_insets			= 6,
		skin_backdrop_tile				= false,
		skin_backdrop_tile_size			= 8,
		skin_edge						= "PerfectPixel/tex/edge_outer_shadow_128x16.dds",
		skin_edge_col					= {0/255, 0/255, 0/255, 240/255},
		skin_edge_thickness				= 16,
		skin_edge_file_width			= 128,
		skin_edge_file_height			= 16,
		skin_edge_integral_wrapping		= false,
	})
	---------------------------------------------
	table.insert(PP.optionsData,
	{	type		= "submenu",
		name		= GetString(PP_LAM_SCENE_PERFORMANCE_METER),
		controls	= PP.PackTables(
			{
				{	type				= "checkbox",
					name				= GetString(PP_LAM_ACTIVATE),
					getFunc				= function() return sv.toggle end,
					setFunc				= function(value) sv.toggle = value end,
					default				= def.toggle,
					requiresReload		= true,
				}
			},
			PP:AddBackdropSettings(namespace),
			PP:AddEdgeSettings(namespace)
		),
	})
--===============================================================================================--
	if not sv.toggle == true then return end

	local pm = ZO_PerformanceMeters
	local bg = ZO_PerformanceMetersBg

	-- bg:SetTexture("PerfectPixel/tex/tex_clear.dds")
	PP:CreateBackground(pm, --[[#1]] nil, nil, nil, 20, 20, --[[#2]] nil, nil, nil, -20, -20, namespace)
	bg:SetHidden(true)

end