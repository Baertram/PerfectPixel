local PP = PP ---@class PP
local namespace	= 'Tooltips'

PP.tooltips = function()
--===============================================================================================--
	local sv, def = PP:AddNewSavedVars(0.3, namespace, {
		toggle							= true,
		comparative_OnHold				= false,

		skin_backdrop					= "PerfectPixel/tex/tex_white.dds",
		skin_backdrop_col				= {5/255, 5/255, 5/255, 250/255},
		skin_backdrop_insets			= 6,
		skin_backdrop_tile				= false,
		skin_backdrop_tile_size			= 8,
		skin_edge						= "PerfectPixel/tex/edge_outer_shadow_128x16.dds",
		skin_edge_col					= {60/255, 60/255, 60/255, 255/255},
		skin_edge_file_width			= 128,
		skin_edge_file_height			= 16,
		skin_edge_thickness				= 16,
		skin_edge_integral_wrapping		= false,

		edge_col_stolen					= {130/255, 20/255, 20/255, 255/255},
		edge_col_mythic					= {250/255, 125/255, 0/255, 255/255},
	})
	---------------------------------------------
	table.insert(PP.optionsData,
	{	type		= "submenu",
		name		= GetString(PP_LAM_TOOLTIPS),
		controls	= PP.PackTables(
			{
				{	type			= "checkbox",
					name			= GetString(PP_LAM_ACTIVATE),
					getFunc			= function() return sv.toggle end,
					setFunc			= function(value) sv.toggle = value end,
					default			= def.toggle,
					requiresReload	= true,
				},
				{	type			= "checkbox",
					name			= GetString(PP_LAM_COMPARATIVE_TOOLTIPS),
					tooltip			= GetString(PP_LAM_COMPARATIVE_TOOLTIPS_TT),
					getFunc			= function() return sv.comparative_OnHold end,
					setFunc			= function(value) sv.comparative_OnHold = value end,
					default			= def.comparative_OnHold,
					requiresReload	= true,
				},
			},
			PP:AddBackdropSettings(namespace),
			PP:AddEdgeSettings(namespace),
			{
				{	type = "header", name = 'Edge color',},
				{	type				= "colorpicker",
					name				= 'Stolen Item',
					getFunc				= function() return unpack(sv.edge_col_stolen) end,
					setFunc				= function(r, g, b, a) sv.edge_col_stolen = { r, g, b, a } end,
					width				= "full",
					default				= {r = def.edge_col_stolen[1], g = def.edge_col_stolen[2], b = def.edge_col_stolen[3], a = def.edge_col_stolen[4]},
				},
				{	type				= "colorpicker",
					name				= 'Mythic Item',
					getFunc				= function() return unpack(sv.edge_col_mythic) end,
					setFunc				= function(r, g, b, a) sv.edge_col_mythic = { r, g, b, a } end,
					width				= "full",
					default				= {r = def.edge_col_mythic[1], g = def.edge_col_mythic[2], b = def.edge_col_mythic[3], a = def.edge_col_mythic[4]},
				},
			}
		),
	})
--===============================================================================================--
	--IsShiftKeyDown() IsControlKeyDown()
	ZO_CreateStringId("SI_BINDING_NAME_PP_COMPARATIVE_TOOLTIPS", GetString(PP_LAM_COMPARATIVE_TOOLTIPS_BIND))

	if sv.comparative_OnHold then
		local comparativeTooltipsFlag = false
		function PP.comparativeTooltips(pressed)
			if PLAYER_INVENTORY:IsShowingBackpack() then
				comparativeTooltipsFlag = pressed

				if not ItemTooltip:IsControlHidden() then
					if pressed then
						-- d("Show")
						ItemTooltip:ShowComparativeTooltips()
                        local anchorIndex = 1
						if not ComparativeTooltip1:GetAnchor(anchorIndex) then
							-- d("anch")
							PP.Anchor(ComparativeTooltip1, --[[#1]] TOPRIGHT, ItemTooltip, TOPLEFT, -20, 0)
							PP.Anchor(ComparativeTooltip2, --[[#1]] TOPRIGHT, ComparativeTooltip1, TOPLEFT, -20, 0)
						end
					else
						-- d("Hide")
						ItemTooltip:HideComparativeTooltips()
					end
				end
			end
		end
		ZO_PreHook(ItemTooltip, "ShowComparativeTooltips", function()
			if not PLAYER_INVENTORY:IsShowingBackpack() then return end
			if comparativeTooltipsFlag then return end
			return true
		end)
	else
		function PP.comparativeTooltips(pressed) end
	end

---------------------------------------------------------------------------------------------------

	if not sv.toggle then return end

---------------------------------------------------------------------------------------------------
	--RedirectTextures
	-- RedirectTexture("EsoUI/Art/Miscellaneous/horizontaldivider.dds",	"PerfectPixel/tex/RedirectTextures/EsoUI/Art/Miscellaneous/horizontaldivider.dds")
	-- RedirectTexture("EsoUI/Art/Miscellaneous/horizontaldividerred.dds",	"PerfectPixel/tex/RedirectTextures/EsoUI/Art/Miscellaneous/horizontaldividerred.dds")

	local layouts = {
		['ItemTooltip']									= { ['y1'] = nil,	['y2'] = -30,	},
		['ItemTooltip_MasterCrafterSetStation']			= { ['y1'] = nil,	['y2'] = -10,	}, --Special layout with only -10 to properly show the tooltip bottom at master set crafting tables
		['ComparativeTooltip1']							= { ['y1'] = nil,	['y2'] = -30,	},
		['ComparativeTooltip2']							= { ['y1'] = nil,	['y2'] = -30,	},
		['PopupTooltip']								= { ['y1'] = nil,	['y2'] = -30,	},
		['InformationTooltip']							= { ['y1'] = 2,		['y2'] = -6,	},
		['AbilityTooltip']								= { ['y1'] = nil,	['y2'] = -16,	},
		['SkillTooltip']								= { ['y1'] = -4,	['y2'] = -6,	},
		['GameTooltip']									= { ['y1'] = 3,		['y2'] = -6,	},
		['AchievementTooltip']							= { ['y1'] = 3,		['y2'] = -16,	},
		['ZO_AchievementTooltip']						= { ['y1'] = nil,	['y2'] = nil,	},
		['ZO_MapLocationTooltip']						= { ['y1'] = nil,	['y2'] = -8,	},
		['ZO_MapQuestDetailsTooltip']					= { ['y1'] = 3,		['y2'] = -2,	},
		['ZO_ZoneStoryActivityCompletionTooltip']		= { ['y1'] = nil,	['y2'] = nil,	},
		['ZO_ZoneStoryActivityCompletionListTooltip']	= { ['y1'] = nil,	['y2'] = nil,	},
		['ZO_ActivityFinderTemplateTooltip_Keyboard']	= { ['x1'] = -8,	['y1'] = -8,	['x2'] = 8, ['y2'] = 8, },
		['HarvensSkillTooltipMorph1']					= { ['y1'] = nil,	['y2'] = -6,	},
		['HarvensSkillTooltipMorph2']					= { ['y1'] = nil,	['y2'] = -6,	},
		["ZO_KeepTooltip"]                            = { ["y1"] = nil, ["y2"] = nil, },
		["ZO_RetraitStation_KeyboardTopLevelReconstructPanelOptionsPreviewTooltip"] = { ["y1"] = nil, ["y2"] = nil, },
		["ZO_RetraitStation_KeyboardTopLevelRetraitPanelResultTooltip"] = { ["y1"] = nil, ["y2"] = nil, },
	}

	local function SetStyle_Bar(control)
		local bg				= control:GetNamedChild("BG")
		local barLeft			= control:GetNamedChild("BarLeft")
		local barLeftGloss		= control:GetNamedChild("BarLeftGloss")
		local barRight			= control:GetNamedChild("BarRight")
		local barRightGloss		= control:GetNamedChild("BarRightGloss")

		bg:SetHidden(true)

		PP.Anchor(barLeft, --[[#1]] LEFT, nil, LEFT, 0, 0, --[[#2]] true, RIGHT, nil, CENTER,	0, -1)
		barLeft:SetHeight(4)
		barLeft:SetTexture("PerfectPixel/tex/tex_white.dds")
		barLeft:SetLeadingEdge(nil)
		barLeft:EnableLeadingEdge(false)
		barLeft:SetAlpha(0.7)
		barLeftGloss:SetTexture("PerfectPixel/tex/tex_white.dds")
		barLeftGloss:SetLeadingEdge(nil)
		barLeftGloss:EnableLeadingEdge(false)
		barLeftGloss:SetColor(150/255, 150/255, 150/255, 0.5)

		PP.Anchor(barRight, --[[#1]] RIGHT, nil, RIGHT, 0, 0, --[[#2]] true, LEFT, nil, CENTER,	0, -1)
		barRight:SetHeight(4)
		barRight:SetTexture("PerfectPixel/tex/tex_white.dds")
		barRight:SetLeadingEdge(nil)
		barRight:EnableLeadingEdge(false)
		barRight:SetAlpha(0.7)
		barRightGloss:SetTexture("PerfectPixel/tex/tex_white.dds")
		barRightGloss:SetLeadingEdge(nil)
		barRightGloss:EnableLeadingEdge(false)
		barRightGloss:SetColor(150/255, 150/255, 150/255, 0.5)

		CreateControl("$(parent)Backdrop", control, CT_BACKDROP)

		local iTCB = control:GetNamedChild("Backdrop")
		PP.Anchor(iTCB, --[[#1]] TOPLEFT, control, TOPLEFT, -2, -1, --[[#2]] true, BOTTOMRIGHT, control, BOTTOMRIGHT,	2, -1)
		iTCB:SetCenterTexture("PerfectPixel/tex/tex_white.dds", 8, 1)
		iTCB:SetCenterColor(10/255, 10/255, 10/255, 0.8)
		iTCB:SetEdgeTexture("PerfectPixel/tex/tex_white.dds", 1, 1, 1, 0)
		iTCB:SetEdgeColor(50/255, 50/255, 50/255, 0.9)
		iTCB:SetInsets(1, 1, -1, -1)
	end

	local function applyLayout(tooltip, specialLayout, bg)
		local layout = specialLayout ~= nil and layouts[specialLayout] or layouts[tooltip:GetName()]

		if layout then
			PP.Anchor(bg, --[[#1]] nil, nil, nil, layout.x1, layout.y1, --[[#2]] true, nil, nil, nil, layout.x2, layout.y2)
		end
	end


	local function SetStyle_Tooltip(tooltip, specialLayout)
		local bg				= tooltip:GetNamedChild("BG") or tooltip:GetNamedChild("Frame")
		if not tooltip.isStyled then
			tooltip.isStyled = true

			local glow			= tooltip:GetNamedChild("Glow")
			local fadeLeft		= tooltip:GetNamedChild("FadeLeft")
			local fadeRight		= tooltip:GetNamedChild("FadeRight")
			local charges		= tooltip:GetNamedChild("Charges")
			local condition		= tooltip:GetNamedChild("Condition")
			local mungeOverlay	= bg:GetNamedChild("MungeOverlay")

			PP:CreateBackground(bg, --[[#1]] nil, nil, nil, 6, 6, --[[#2]] nil, nil, nil, -6, -6, namespace)

			if mungeOverlay then
				mungeOverlay:SetHidden(true)
			end

			if fadeLeft and fadeRight then
				PP.Anchor(fadeLeft,		--[[#1]] TOPRIGHT, nil, TOP, 0, 5)
				fadeLeft:SetHeight(1)
				PP.Anchor(fadeRight,	--[[#1]] TOPLEFT, nil, TOP, 0, 5)
				fadeRight:SetHeight(1)
			end

			if glow then
				PP.Anchor(glow, --[[#1]] TOPLEFT, bg, TOPLEFT, -30, -30, --[[#2]] true, BOTTOMRIGHT, bg, BOTTOMRIGHT, 30, 30)
			end

			if charges then
				SetStyle_Bar(charges)
			end
			if condition then
				SetStyle_Bar(condition)
			end

			applyLayout(tooltip, specialLayout, bg)
		else
			applyLayout(tooltip, specialLayout, bg)
		end
	end
	PP.SetStyle_Tooltip = SetStyle_Tooltip

	PP.Bar(SkillTooltipProgression, --[[height]] 8, --[[fontSize]] 15)

	ZO_SmithingTopLevelCreationPanelResultTooltipGlow:SetHidden(true)

	SetStyle_Tooltip(ComparativeTooltip1)
	SetStyle_Tooltip(ComparativeTooltip2)
	SetStyle_Tooltip(PopupTooltip)
	SetStyle_Tooltip(ZO_ProvisionerTopLevelTooltip)
	SetStyle_Tooltip(ZO_AlchemyTopLevelTooltip)
	SetStyle_Tooltip(ZO_EnchantingTopLevelTooltip)
	SetStyle_Tooltip(ZO_SmithingTopLevelCreationPanelResultTooltip)
	SetStyle_Tooltip(ZO_KeepTooltip)
    SetStyle_Tooltip(ZO_RetraitStation_KeyboardTopLevelReconstructPanelOptionsPreviewTooltip)
    SetStyle_Tooltip(ZO_RetraitStation_KeyboardTopLevelRetraitPanelResultTooltip)


	ZO_PreHook("InitializeTooltip", function(tooltip, control, ...)
		local specialLayout
		if ZO_SmithingTopLevelSetContainer ~= nil and control ~= nil and control.node ~= nil and control.node.data ~= nil and control.node.data.GetItemSetId ~= nil then
			specialLayout = "ItemTooltip_MasterCrafterSetStation"
		end
		SetStyle_Tooltip(tooltip, specialLayout)
	end)

	ZO_PreHook("ZO_ItemTooltip_UpdateVisualStyle", function(tooltipControl, isItemMythic, isItemStolen)
		local dividerTexture
		local bg = tooltipControl:GetNamedChild("BG")

		if isItemMythic then
			bg:SetEdgeColor(sv.edge_col_mythic[1], sv.edge_col_mythic[2], sv.edge_col_mythic[3], sv.edge_col_mythic[4])
			if isItemStolen then
				dividerTexture = "EsoUI/Art/Miscellaneous/horizontalDividerRed.dds"
			else
				dividerTexture = "EsoUI/Art/Miscellaneous/horizontalDivider_Mythic.dds"
			end
		else
		   if isItemStolen then
				bg:SetEdgeColor(sv.edge_col_stolen[1], sv.edge_col_stolen[2], sv.edge_col_stolen[3], sv.edge_col_stolen[4])
				dividerTexture = "EsoUI/Art/Miscellaneous/horizontalDividerRed.dds"
			else
				bg:SetEdgeColor(sv.skin_edge_col[1], sv.skin_edge_col[2], sv.skin_edge_col[3], sv.skin_edge_col[4])
				dividerTexture = "EsoUI/Art/Miscellaneous/horizontalDivider.dds"
			end
		end

		-- Color all dividers
		if tooltipControl.dividerPool then
			local dividers = tooltipControl.dividerPool:GetActiveObjects()
			for _, divider in pairs(dividers) do
				divider:SetTexture(dividerTexture)
			end
		end
		return true
	end)
end
