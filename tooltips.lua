PP.tooltips = function()
	---------------------------------------------------------------------------------------------------
	local SV_VER			= 0.1
	local DEF = {
		toggle				= true,
		comparative_OnHold	= false,
		ttAlpha				= 90,
	}
	local SV = ZO_SavedVars:NewAccountWide(PP.ADDON_NAME, SV_VER, "Tooltips", DEF, GetWorldName())

	--Tooltips-----------------------------------------------------------------------------------------
	table.insert(PP.optionsData,
			{	type				= "submenu",
				 name				= GetString(PP_LAM_TOOLTIPS),
				 controls = {
					 {	type				= "checkbox",
						  name				= GetString(PP_LAM_ACTIVATE),
						  getFunc				= function() return SV.toggle end,
						  setFunc				= function(value) SV.toggle = value end,
						  default				= DEF.toggle,
						  requiresReload		= true,
					 },
					 {	type				= "slider",
						  name				= GetString(PP_LAM_TRANSPARENCY),
						  min				= 0,
						  max 				= 99,
						  step				= 1,
						  getFunc			= function() return SV.ttAlpha end,
						  setFunc				= function(value) SV.ttAlpha = value end,
						  default				= DEF.ttAlpha,
						  disabled 			= function() return not SV.toggle end,
						  requiresReload		= true,
					 },
					 {	type				= "checkbox",
						  name				= GetString(PP_LAM_COMPARATIVE_TOOLTIPS),
						  tooltip				= GetString(PP_LAM_COMPARATIVE_TOOLTIPS_TT),
						  getFunc				= function() return SV.comparative_OnHold end,
						  setFunc				= function(value) SV.comparative_OnHold = value end,
						  default				= DEF.comparative_OnHold,
						  requiresReload		= true,
					 },
				 },
			})
	---------------------------------------------------------------------------------------------------IsShiftKeyDown() IsControlKeyDown()
	ZO_CreateStringId("SI_BINDING_NAME_PP_COMPARATIVE_TOOLTIPS", GetString(PP_LAM_COMPARATIVE_TOOLTIPS_BIND))

	if SV.comparative_OnHold then
		local comparativeTooltipsFlag = false
		function PP.comparativeTooltips(pressed)
			if PLAYER_INVENTORY:IsShowingBackpack() then
				comparativeTooltipsFlag = pressed

				if not ItemTooltip:IsControlHidden() then
					if pressed then
						-- d("Show")
						ItemTooltip:ShowComparativeTooltips()
						if not ComparativeTooltip1:GetAnchor() then
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

	if not SV.toggle then return end

	-----------------------------------------------------------------------------------------------
	--RedirectTextures---------------------------------------------------------------------------------
	-- RedirectTexture("EsoUI/Art/Miscellaneous/horizontaldivider.dds",	"PerfectPixel/textures/RedirectTextures/EsoUI/Art/Miscellaneous/horizontaldivider.dds")
	-- RedirectTexture("EsoUI/Art/Miscellaneous/horizontaldividerred.dds",	"PerfectPixel/textures/RedirectTextures/EsoUI/Art/Miscellaneous/horizontaldividerred.dds")


	--▼--▼--▼--

	-- ZO_PreHook("ZO_PlayShowAnimationOnComparisonTooltip", function(tooltip)
	-- return true
	-- end)

	-- ZO_PreHook("ZO_PlayHideAnimationOnComparisonTooltip", function(tooltip)
	-- return true
	-- end)

	-- local orig_ClearTooltip = ClearTooltip
	-- function ClearTooltip(tooltip)
	-- orig_ClearTooltip(tooltip)
	-- if tooltip.animation and tooltip.animation:GetDuration() ~= 50 then
	-- tooltip.animation:GetAnimation():SetDuration(50)
	-- end
	-- end
	--▲--▲--▲--

	local tab = {
		ItemTooltip, ComparativeTooltip1, ComparativeTooltip2, PopupTooltip, InformationTooltip, AbilityTooltip, SkillTooltip, GameTooltip,
		AchievementTooltip, ZO_AchievementTooltip,
		ZO_MapLocationTooltip, ZO_MapQuestDetailsTooltip, ZO_ZoneStoryActivityCompletionTooltip, ZO_ZoneStoryActivityCompletionListTooltip,
		ZO_SmithingTopLevelCreationPanelResultTooltip, ZO_ProvisionerTopLevelTooltip, ZO_AlchemyTopLevelTooltip, ZO_RetraitStation_KeyboardTopLevelRetraitPanelResultTooltip,

	}
	--Compatibilty - Other AddOns
	if HarvensSkillTooltipMorph1 then
		table.insert(tab, HarvensSkillTooltipMorph1)
		table.insert(tab, HarvensSkillTooltipMorph2)
	end


	--Alpha of the tooltip = 100 - Transparency of settings * 0.1 for the alpha value 0 to 1
	local alpha
	if SV.ttAlpha and SV.ttAlpha >= 0 and SV.ttAlpha <= 99 then
		alpha = 100 - SV.ttAlpha
		if alpha > 10 then
			alpha = alpha * 0.01
		else
			alpha = alpha * 0.1
		end
		if alpha < 0 then alpha = 0 end
		if alpha > 1 then alpha = 1 end
	else
		alpha = 0.9
	end

	for _, v in ipairs(tab) do
		if not v then return end
		local iTB = v:GetNamedChild("BG")
		iTB:GetNamedChild("MungeOverlay"):SetHidden(true)

		iTB:SetCenterTexture(PP.t.bg1, 4, 1)
		iTB:SetCenterColor(10/255, 10/255, 10/255, alpha)
		iTB:SetEdgeTexture(nil, 1, 1, 1, 0)
		iTB:SetEdgeColor(60/255, 60/255, 60/255, 1)
		iTB:SetInsets(-1, -1, 1, 1)

		PP.Anchor(iTB, --[[#1]] TOPLEFT, nil, TOPLEFT, 5, 5, --[[#2]] true, BOTTOMRIGHT, nil, BOTTOMRIGHT,	-5, -30)

		local fadeLeft	= v:GetNamedChild("FadeLeft")
		local fadeRight	= v:GetNamedChild("FadeRight")
		if fadeLeft and fadeRight then
			PP.Anchor(fadeLeft,		--[[#1]] TOPRIGHT, nil, TOP, 0, 5)
			fadeLeft:SetHeight(1)
			PP.Anchor(fadeRight,	--[[#1]] TOPLEFT, nil, TOP, 0, 5)
			fadeRight:SetHeight(1)
		end

		local glow = v:GetNamedChild("Glow")
		if glow then
			PP.Anchor(glow, --[[#1]] TOPLEFT, iTB, TOPLEFT, -30, -30, --[[#2]] true, BOTTOMRIGHT, iTB, BOTTOMRIGHT, 30, 30)
		end
	end

	PP.Anchor(InformationTooltipBG,							--[[#1]] TOPLEFT, nil, TOPLEFT, 4, 5,	--[[#2]] true, BOTTOMRIGHT, nil, BOTTOMRIGHT, -4, -10)
	PP.Anchor(AbilityTooltipBG,								--[[#1]] TOPLEFT, nil, TOPLEFT, 5, -1,	--[[#2]] true, BOTTOMRIGHT, nil, BOTTOMRIGHT, -5, -20)
	PP.Anchor(SkillTooltipBG,								--[[#1]] TOPLEFT, nil, TOPLEFT, 5, -1,	--[[#2]] true, BOTTOMRIGHT, nil, BOTTOMRIGHT, -5, -10)
	PP.Anchor(GameTooltipBG,								--[[#1]] TOPLEFT, nil, TOPLEFT, 5, 5,	--[[#2]] true, BOTTOMRIGHT, nil, BOTTOMRIGHT, -5, -9)
	PP.Anchor(AchievementTooltipBG,							--[[#1]] TOPLEFT, nil, TOPLEFT, 5, 5,	--[[#2]] true, BOTTOMRIGHT, nil, BOTTOMRIGHT, -5, -20)
	PP.Anchor(ZO_AchievementTooltipBG,						--[[#1]] TOPLEFT, nil, TOPLEFT, 0, 0,	--[[#2]] true, BOTTOMRIGHT, nil, BOTTOMRIGHT, 0, 0)
	PP.Anchor(ZO_MapLocationTooltipBG,						--[[#1]] TOPLEFT, nil, TOPLEFT, 5, 5,	--[[#2]] true, BOTTOMRIGHT, nil, BOTTOMRIGHT, -5, -15)
	PP.Anchor(ZO_MapQuestDetailsTooltipBG,					--[[#1]] TOPLEFT, nil, TOPLEFT, 5, 5,	--[[#2]] true, BOTTOMRIGHT, nil, BOTTOMRIGHT, -5, -5)
	PP.Anchor(ZO_ZoneStoryActivityCompletionTooltipBG,		--[[#1]] TOPLEFT, nil, TOPLEFT, 0, 0,	--[[#2]] true, BOTTOMRIGHT, nil, BOTTOMRIGHT, 0, 0)
	PP.Anchor(ZO_ZoneStoryActivityCompletionListTooltipBG,	--[[#1]] TOPLEFT, nil, TOPLEFT, 0, 0,	--[[#2]] true, BOTTOMRIGHT, nil, BOTTOMRIGHT, 0, 0)
	--HarvensImprovedSkillsWindow compatibility ---------------------------------------------------
	if HarvensSkillTooltipMorph1 then
		PP.Anchor(HarvensSkillTooltipMorph1BG, --[[#1]] TOPLEFT, nil, TOPLEFT, 5, -1, --[[#2]] true, BOTTOMRIGHT, nil, BOTTOMRIGHT, -5, -20)
		PP.Anchor(HarvensSkillTooltipMorph2BG, --[[#1]] TOPLEFT, nil, TOPLEFT, 5, -1, --[[#2]] true, BOTTOMRIGHT, nil, BOTTOMRIGHT, -5, -20)
	end

	PP.Bar(SkillTooltipProgression, --[[height]] 8, --[[fontSize]] 15)

	ZO_PreHook("ZO_ItemTooltip_UpdateVisualStyle", function(tooltipControl, isItemMythic, isItemStolen)
		local dividerTexture
		local bg = tooltipControl:GetNamedChild("BG")

		if isItemMythic then
			bg:SetEdgeColor(250/255, 125/255, 0/255, 1)
			if isItemStolen then
				dividerTexture = "EsoUI/Art/Miscellaneous/horizontalDividerRed.dds"
			else
				dividerTexture = "EsoUI/Art/Miscellaneous/horizontalDivider_Mythic.dds"
			end
		else
		   if isItemStolen then
				bg:SetEdgeColor(130/255, 20/255, 20/255, 1)
				dividerTexture = "EsoUI/Art/Miscellaneous/horizontalDividerRed.dds"
			else
				bg:SetEdgeColor(60/255, 60/255, 60/255, 1)
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

	for _, v in ipairs(tab) do
		local charges	= v:GetNamedChild("Charges")
		local condition	= v:GetNamedChild("Condition")

		local function func(control)
			local bg				= control:GetNamedChild("BG")
			local barLeft			= control:GetNamedChild("BarLeft")
			local barLeftGloss		= control:GetNamedChild("BarLeftGloss")
			local barRight			= control:GetNamedChild("BarRight")
			local barRightGloss		= control:GetNamedChild("BarRightGloss")

			bg:SetHidden(true)

			PP.Anchor(barLeft, --[[#1]] LEFT, nil, LEFT, 0, 0, --[[#2]] true, RIGHT, nil, CENTER,	0, -1)
			barLeft:SetHeight(4)
			barLeft:SetTexture(nil)
			barLeft:SetLeadingEdge(nil)
			barLeft:EnableLeadingEdge(false)
			barLeft:SetAlpha(.7)
			barLeftGloss:SetTexture(nil)
			barLeftGloss:SetLeadingEdge(nil)
			barLeftGloss:EnableLeadingEdge(false)
			barLeftGloss:SetColor(150/255, 150/255, 150/255, .5)

			PP.Anchor(barRight, --[[#1]] RIGHT, nil, RIGHT, 0, 0, --[[#2]] true, LEFT, nil, CENTER,	0, -1)
			barRight:SetHeight(4)
			barRight:SetTexture(nil)
			barRight:SetLeadingEdge(nil)
			barRight:EnableLeadingEdge(false)
			barRight:SetAlpha(.7)
			barRightGloss:SetTexture(nil)
			barRightGloss:SetLeadingEdge(nil)
			barRightGloss:EnableLeadingEdge(false)
			barRightGloss:SetColor(150/255, 150/255, 150/255, .5)

			CreateControl(control:GetName() .. "Backdrop", control, CT_BACKDROP)

			local iTCB = control:GetNamedChild("Backdrop")
			PP.Anchor(iTCB, --[[#1]] TOPLEFT, control, TOPLEFT, -2, -1, --[[#2]] true, BOTTOMRIGHT, control, BOTTOMRIGHT,	2, -1)
			iTCB:SetCenterTexture(PP.t.bg2, 8, 1)
			iTCB:SetCenterColor(10/255, 10/255, 10/255, .8)
			iTCB:SetEdgeTexture(nil, 1, 1, 1, 0)
			iTCB:SetEdgeColor(50/255, 50/255, 50/255, .9)
			iTCB:SetInsets(1, 1, -1, -1)
		end
		if charges then
			func(charges)
		end
		if condition then
			func(condition)
		end
	end
end