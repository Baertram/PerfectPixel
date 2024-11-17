PP.compass = function()
	local SV, DEF = PP:AddNewSavedVars(0.2, 'Compass', {
		toggle			= true,
		col				= {0/255, 0/255, 0/255, 0.6},
		col_e			= {0/255, 0/255, 0/255, 1},
		--Quest area
		qa_col			= {96/255, 125/255, 139/255, 0.5},
		qa_col_e		= {96/255, 125/255, 139/255, 0},
		--Combat indicator
		ci_toggle		= true,
		ci_col			= {222/255, 36/255, 33/255, 0.7},
		--Boss bar
		hideBossBar		= false,
	})
	---------------------------------------------
	table.insert(PP.optionsData,
	{	type				= "submenu",
		name				= GetString(PP_LAM_COMPASS),
		controls = {
			{	type				= "checkbox",
				name				= GetString(PP_LAM_ACTIVATE),
				getFunc				= function() return SV.toggle end,
				setFunc				= function(value) SV.toggle = value end,
				default				= DEF.toggle,
				requiresReload		= true,
			},
			{	type				= "colorpicker",
				name				= GetString(PP_LAM_COLOR),
				getFunc				= function() return unpack(SV.col) end,
				setFunc				= function(r, g, b, a) SV.col = { r, g, b, a } end,
				width				= "full",
				default				= {r = DEF.col[1], g = DEF.col[2], b = DEF.col[3], a = DEF.col[4]},
				disabled			= function() return not SV.toggle end,
				requiresReload		= true,
			},
			{	type				= "colorpicker",
				name				= GetString(PP_LAM_EDGE_COLOR),
				getFunc				= function() return unpack(SV.col_e) end,
				setFunc				= function(r, g, b, a) SV.col_e = { r, g, b, a } end,
				width				= "full",
				default				= {r = DEF.col_e[1], g = DEF.col_e[2], b = DEF.col_e[3], a = DEF.col_e[4]},
				disabled			= function() return not SV.toggle end,
				requiresReload		= true,
			},
			--Quest area---------------------------------
			{	type				= "header",
				name				= GetString(PP_LAM_COMPASS_QUEST),
			},
			{	type				= "colorpicker",
				name				= GetString(PP_LAM_COLOR),
				getFunc				= function() return unpack(SV.qa_col) end,
				setFunc				= function(r, g, b, a) SV.qa_col = { r, g, b, a } end,
				width				= "full",
				default				= {r = DEF.qa_col[1], g = DEF.qa_col[2], b = DEF.qa_col[3], a = DEF.qa_col[4]},
				disabled			= function() return not SV.toggle end,
			},
			{	type				= "colorpicker",
				name				= GetString(PP_LAM_EDGE_COLOR),
				getFunc				= function() return unpack(SV.qa_col_e) end,
				setFunc				= function(r, g, b, a) SV.qa_col_e = { r, g, b, a } end,
				width				= "full",
				default				= {r = DEF.qa_col_e[1], g = DEF.qa_col_e[2], b = DEF.qa_col_e[3], a = DEF.qa_col_e[4]},
				disabled			= function() return not SV.toggle end,
			},
			--Combat indicator---------------------------
			{	type				= "header",
				name				= GetString(PP_LAM_COMPASS_COMBAT),
			},
			{	type				= "checkbox",
				name				= GetString(PP_LAM_ACTIVATE),
				getFunc				= function() return SV.ci_toggle end,
				setFunc				= function(value) SV.ci_toggle = value end,
				default				= DEF.ci_toggle,
				disabled			= function() return not SV.toggle end,
				requiresReload		= true,
			},
			{	type				= "colorpicker",
				name				= GetString(PP_LAM_EDGE_COLOR),
				getFunc				= function() return unpack(SV.ci_col) end,
				setFunc				= function(r, g, b, a) SV.ci_col = { r, g, b, a } end,
				width				= "full",
				default				= {r = DEF.ci_col[1], g = DEF.ci_col[2], b = DEF.ci_col[3], a = DEF.ci_col[4]},
				disabled			= function() return not SV.toggle or not SV.ci_toggle end,
			},
			--Boss bar-----------------------------------
			{	type				= "header",
				name				= "Boss Bar",
			},
			{	type				= "checkbox",
				name				= "Hide boss bar",
				getFunc				= function() return SV.hideBossBar end,
				setFunc				= function(value) SV.hideBossBar = value end,
				default				= DEF.hideBossBar,
				disabled			= function() return not SV.toggle end,
				requiresReload		= true,
			},
		},
	})
--===============================================================================================--
	if not SV.toggle then return end

	local compassFrame = ZO_CompassFrame

	ZO_CompassFrameLeft:SetHidden(true)
	ZO_CompassFrameRight:SetHidden(true)
	ZO_CompassFrameCenter:SetHidden(true)

	local CF_B = CreateControl("$(parent)Backdrop", compassFrame, CT_BACKDROP)

	PP.Anchor(CF_B, --[[#1]] TOPLEFT, compassFrame, TOPLEFT, -5, 3, --[[#2]] true, BOTTOMRIGHT, compassFrame, BOTTOMRIGHT,	5, -3)
	CF_B:SetCenterTexture("PerfectPixel/tex/tex_white.dds", 8, 0)
	CF_B:SetEdgeTexture("PerfectPixel/tex/edge_outer_shadow_128x16.dds", 128, 16, 16, 0)
	CF_B:SetInsets(5, 5, -5, -5)
	CF_B:SetCenterColor(SV.col[1], SV.col[2], SV.col[3], SV.col[4])
	CF_B:SetEdgeColor(SV.col_e[1], SV.col_e[2], SV.col_e[3], SV.col_e[4])

--Combat indicator---------------------------------------------------------------------------------
	if SV.ci_toggle then
		local function OnPlayerCombatState()
			if IsUnitInCombat("player") then
				CF_B:SetEdgeColor(SV.ci_col[1], SV.ci_col[2], SV.ci_col[3], SV.ci_col[4])
			else
				CF_B:SetEdgeColor(SV.col_e[1], SV.col_e[2], SV.col_e[3], SV.col_e[4])
			end
		end
		compassFrame:RegisterForEvent(EVENT_PLAYER_COMBAT_STATE, OnPlayerCombatState)
		compassFrame:RegisterForEvent(EVENT_PLAYER_ACTIVATED, OnPlayerCombatState)
	end

--Quest area---------------------------------------------------------------------------------------
	ZO_PreHook(Compass, "SetAreaTexturePlatformTextures", function(self, areaTexture, pinType)
		areaTexture.pinType = pinType or areaTexture.pinType

		if not areaTexture.backdrop then
			areaTexture.center:SetHidden(true)
			areaTexture.left:SetHidden(true)
			areaTexture.right:SetHidden(true)

			areaTexture.backdrop = CreateControl("$(parent)Backdrop", areaTexture, CT_BACKDROP)
			local qa_b = areaTexture.backdrop
			PP.Anchor(qa_b, --[[#1]] TOPLEFT, compassFrame, TOPLEFT, -5, 3, --[[#2]] true, BOTTOMRIGHT, compassFrame, BOTTOMRIGHT,	5, -3)
			qa_b:SetCenterTexture("PerfectPixel/tex/tex_white.dds", 8, 0)
			qa_b:SetEdgeTexture("PerfectPixel/tex/edge_outer_shadow_128x16.dds", 128, 16, 16, 0)
			qa_b:SetInsets(5, 5, -5, -5)
			qa_b:SetCenterColor(SV.qa_col[1], SV.qa_col[2], SV.qa_col[3], SV.qa_col[4])
			qa_b:SetEdgeColor(SV.qa_col_e[1], SV.qa_col_e[2], SV.qa_col_e[3], SV.qa_col_e[4])
		end

		areaTexture.backdrop:SetCenterColor(SV.qa_col[1], SV.qa_col[2], SV.qa_col[3], SV.qa_col[4])
		areaTexture.backdrop:SetEdgeColor(SV.qa_col_e[1], SV.qa_col_e[2], SV.qa_col_e[3], SV.qa_col_e[4])
	end)
--CARDINAL_DIRECTION---------------------------------------------------------------------------------------
	local font = PP.f.u67 .. "|17|outline"
	COMPASS.container:SetCardinalDirection(GetString(SI_COMPASS_NORTH_ABBREVIATION),	font, CARDINAL_DIRECTION_NORTH)
	COMPASS.container:SetCardinalDirection(GetString(SI_COMPASS_EAST_ABBREVIATION),		font, CARDINAL_DIRECTION_EAST)
	COMPASS.container:SetCardinalDirection(GetString(SI_COMPASS_WEST_ABBREVIATION),		font, CARDINAL_DIRECTION_WEST)
	COMPASS.container:SetCardinalDirection(GetString(SI_COMPASS_SOUTH_ABBREVIATION),	font, CARDINAL_DIRECTION_SOUTH)
--ZO_BossBar---------------------------------------------------------------------------------------
	ZO_BossBarBracketLeft:SetHidden(true)
	ZO_BossBarBracketRight:SetHidden(true)

	PP.Anchor(ZO_BossBarHealth, --[[#1]] TOPLEFT, compassFrame, TOPLEFT, -8, 0, --[[#2]] true, BOTTOMRIGHT, compassFrame, BOTTOMRIGHT,	8, 0)
	PP.Font(ZO_BossBarHealthText, --[[Font]] PP.f.u67, 16, "outline", --[[Alpha]] nil, --[[Color]] nil, nil, nil, nil, --[[StyleColor]] 0, 0, 0, 0.5)

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
	barLeftGloss:SetColor(150/255, 150/255, 150/255, 0.2)

	barRight:SetHeight(20)
	barRight:SetTexture(nil)
	barRight:SetLeadingEdge(nil)
	barRight:EnableLeadingEdge(false)
	barRightGloss:SetTexture(nil)
	barRightGloss:SetLeadingEdge(nil)
	barRightGloss:EnableLeadingEdge(false)
	barRightGloss:SetColor(150/255, 150/255, 150/255, 0.2)

	if SV.hideBossBar then
		ZO_PreHook(COMPASS_FRAME, "SetBossBarActive", function(self, ...)
			self.bossBarActive = false
			return true
		end)
	end

end