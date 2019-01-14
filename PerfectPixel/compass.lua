PP.compass = function()
--===============================================================================================--
	local SV_VER		= 0.1
	local DEF = {
		toggle			= true,
		col				= {0/255, 0/255, 0/255, .6},
		col_e			= {0/255, 0/255, 0/255, 1},
	--Quest area
		qa_col			= {96/255, 125/255, 139/255, .5},
		qa_col_e		= {96/255, 125/255, 139/255, 0},
	--Combat indicator
		ci_toggle		= true,
		ci_col			= {222/255, 36/255, 33/255, .7},
	}
	local SV = ZO_SavedVars:NewAccountWide(PP.ADDON_NAME, SV_VER, "Compass", DEF, GetWorldName())
	---------------------------------------------
	table.insert(PP.optionsData,
	{	type				= "submenu",
		name				= GetString(PP_LAM_COMPASS),
		controls    = {
		  {	type				= "checkbox",
			name				= GetString(PP_LAM_ACTIVATE),
			getFunc				= function() return SV.toggle end,
			setFunc				= function(value) SV.toggle = value end,
			default				= DEF.toggle,
			requiresReload		= true,
		  },
		  {	type				= "colorpicker",
			name				= GetString(PP_LAM_COMPASS_COLOR),
			getFunc				= function() return unpack(SV.col) end,
			setFunc				= function(r, g, b, a) SV.col = { r, g, b, a } end,
			width				= "full",
			default				= {r = DEF.col[1], g = DEF.col[2], b = DEF.col[3], a = DEF.col[4]},
			disabled			= function() return not SV.toggle end,
			requiresReload		= true,
		  },
		  {	type				= "colorpicker",
			name				= GetString(PP_LAM_COMPASS_EDGE_COLOR),
			getFunc				= function() return unpack(SV.col_e) end,
			setFunc				= function(r, g, b, a) SV.col_e = { r, g, b, a } end,
			width				= "full",
			default				= {r = DEF.col_e[1], g = DEF.col_e[2], b = DEF.col_e[3], a = DEF.col_e[4]},
			disabled			= function() return not SV.toggle end,
			requiresReload		= true,
		  },
		  --Quest area---------------------------------
		  {	type				= "colorpicker",
			name				= GetString(PP_LAM_COMPASS_QUEST_COLOR),
			getFunc				= function() return unpack(SV.qa_col) end,
			setFunc				= function(r, g, b, a) SV.qa_col = { r, g, b, a } end,
			width				= "full",
			default				= {r = DEF.qa_col[1], g = DEF.qa_col[2], b = DEF.qa_col[3], a = DEF.qa_col[4]},
			disabled			= function() return not SV.toggle end,
			requiresReload		= true,
		  },
		  {	type				= "colorpicker",
			name				= GetString(PP_LAM_COMPASS_QUEST_EDGE_COLOR),
			getFunc				= function() return unpack(SV.qa_col_e) end,
			setFunc				= function(r, g, b, a) SV.qa_col_e = { r, g, b, a } end,
			width				= "full",
			default				= {r = DEF.qa_col_e[1], g = DEF.qa_col_e[2], b = DEF.qa_col_e[3], a = DEF.qa_col_e[4]},
			disabled			= function() return not SV.toggle end,
			requiresReload		= true,
		  },
		  --Combat indicator---------------------------
		  {	type				= "checkbox",
			name				= GetString(PP_LAM_COMPASS_COMBAT_INDICATOR),
			getFunc				= function() return SV.ci_toggle end,
			setFunc				= function(value) SV.ci_toggle = value end,
			default				= DEF.ci_toggle,
			disabled			= function() return not SV.toggle end,
			requiresReload		= true,
		  },
		  {	type				= "colorpicker",
			name				= GetString(PP_LAM_COMPASS_COMBAT_INDICATOR_EDGE_COLOR),
			getFunc				= function() return unpack(SV.ci_col) end,
			setFunc				= function(r, g, b, a) SV.ci_col = { r, g, b, a } end,
			width				= "full",
			default				= {r = DEF.ci_col[1], g = DEF.ci_col[2], b = DEF.ci_col[3], a = DEF.ci_col[4]},
			disabled			= function() return not SV.toggle or not SV.ci_toggle end,
			requiresReload		= true,
		  },
		},
	})
--===============================================================================================--
	if not SV.toggle then return end

	tab = {	ZO_CompassFrameCenter, ZO_CompassFrameLeft, ZO_CompassFrameRight, }
	for _, v in ipairs(tab) do
		v:SetAlpha(0)
	end
	CreateControl("$(parent)Backdrop", ZO_CompassFrame, CT_BACKDROP)

	local CF_B = ZO_CompassFrame:GetNamedChild("Backdrop")

	PP.Anchor(CF_B, --[[#1]] TOPLEFT, ZO_CompassFrame, TOPLEFT, -10, 8, --[[#2]] true, BOTTOMRIGHT, ZO_CompassFrame, BOTTOMRIGHT,	10, -7)
	CF_B:SetInheritAlpha(false)
	CF_B:SetPixelRoundingEnabled(false)
	CF_B:SetInheritScale(false)
	CF_B:SetCenterTexture(nil, 8, 0)
	CF_B:SetEdgeTexture(nil, 1, 1, 1, 0)
	CF_B:SetInsets(-1, -1, 1, 1)
	CF_B:SetCenterColor(unpack(SV.col))
	CF_B:SetEdgeColor(unpack(SV.col_e))

--Combat indicator---------------------------------------------------------------------------------
	if SV.ci_toggle then
		local function OnPlayerCombatState()
			if IsUnitInCombat("player") then
				CF_B:SetEdgeColor(unpack(SV.ci_col))
			else
				CF_B:SetEdgeColor(unpack(SV.col_e))
			end
		end
		EVENT_MANAGER:RegisterForEvent(PP.ADDON_NAME, EVENT_PLAYER_COMBAT_STATE, OnPlayerCombatState)
	end

--Quest area---------------------------------------------------------------------------------------
	ZO_PreHook(Compass, "ApplyTemplateToAreaTexture", function(self, areaTexture)
		if areaTexture and not areaTexture:GetNamedChild("Backdrop") then
			areaTexture:GetNamedChild("Center"):SetHidden(true)
			areaTexture:GetNamedChild("Left"):SetHidden(true)
			areaTexture:GetNamedChild("Right"):SetHidden(true)

			CreateControl("$(parent)Backdrop", areaTexture, CT_BACKDROP)
			local CF_B = areaTexture:GetNamedChild("Backdrop")
			PP.Anchor(CF_B, --[[#1]] TOPLEFT, ZO_CompassFrame, TOPLEFT, -10, 8, --[[#2]] true, BOTTOMRIGHT, ZO_CompassFrame, BOTTOMRIGHT,	10, -7)
			CF_B:SetInheritAlpha(false)
			CF_B:SetPixelRoundingEnabled(false)
			CF_B:SetInheritScale(false)
			CF_B:SetCenterTexture(nil, 8, 0)
			CF_B:SetEdgeTexture(nil, 1, 1, 1, 0)
			CF_B:SetInsets(1, 1, -1, -1)
			CF_B:SetCenterColor(unpack(SV.qa_col))
			CF_B:SetEdgeColor(unpack(SV.qa_col_e))
		end
	end)
--CARDINAL_DIRECTION---------------------------------------------------------------------------------------
	local font = "PerfectPixel/fonts/univers67.otf|17|outline"
	COMPASS.container:SetCardinalDirection(GetString(SI_COMPASS_NORTH_ABBREVIATION), font, CARDINAL_DIRECTION_NORTH)
	COMPASS.container:SetCardinalDirection(GetString(SI_COMPASS_EAST_ABBREVIATION), font, CARDINAL_DIRECTION_EAST)
	COMPASS.container:SetCardinalDirection(GetString(SI_COMPASS_WEST_ABBREVIATION), font, CARDINAL_DIRECTION_WEST)
	COMPASS.container:SetCardinalDirection(GetString(SI_COMPASS_SOUTH_ABBREVIATION), font, CARDINAL_DIRECTION_SOUTH)
--ZO_BossBar---------------------------------------------------------------------------------------
	ZO_BossBarBracketLeft:SetHidden(true)
	ZO_BossBarBracketRight:SetHidden(true)

	PP.Anchor(ZO_BossBarHealth, --[[#1]] TOPLEFT, ZO_CompassFrame, TOPLEFT, -8, 0, --[[#2]] true, BOTTOMRIGHT, ZO_CompassFrame, BOTTOMRIGHT,	8, 0)
	PP.Font(ZO_BossBarHealthText, --[[Font]] PP.f.u67, 16, "outline", --[[Alpha]] nil, --[[Color]] nil, nil, nil, nil, --[[StyleColor]] 0, 0, 0, .5)

	local barLeft =			ZO_BossBarHealth:GetNamedChild("BarLeft")
	local barLeftGloss =	ZO_BossBarHealth:GetNamedChild("BarLeftGloss")
	local barRight =		ZO_BossBarHealth:GetNamedChild("BarRight")
	local barRightGloss =	ZO_BossBarHealth:GetNamedChild("BarRightGloss")

	barLeft:SetHeight(20)
	barLeft:SetTexture(nil)
	barLeft:SetLeadingEdge(nil)
	barLeft:EnableLeadingEdge(false)
	barLeftGloss:SetTexture(nil)
	barLeftGloss:SetLeadingEdge(nil)
	barLeftGloss:EnableLeadingEdge(false)
	barLeftGloss:SetColor(150/255, 150/255, 150/255, .2)

	barRight:SetHeight(20)
	barRight:SetTexture(nil)
	barRight:SetLeadingEdge(nil)
	barRight:EnableLeadingEdge(false)
	barRightGloss:SetTexture(nil)
	barRightGloss:SetLeadingEdge(nil)
	barRightGloss:EnableLeadingEdge(false)
	barRightGloss:SetColor(150/255, 150/255, 150/255, .2)

end