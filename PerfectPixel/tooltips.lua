PP.tooltips = function()
---------------------------------------------------------------------------------------------------
	local SV_VER		= 0.1
	local DEF = {
		toggle			= true,
	}
	local SV = ZO_SavedVars:NewAccountWide(PP.ADDON_NAME, SV_VER, "Tooltips", DEF, GetWorldName())
--Tooltips-----------------------------------------------------------------------------------------
	table.insert(PP.optionsData,
	{	type				= "header",
		name				= GetString(PP_LAM_TOOLTIPS),
	})
	table.insert(PP.optionsData,
	{	type				= "checkbox",
		name				= GetString(PP_LAM_ACTIVATE),
		getFunc				= function() return SV.toggle end,
		setFunc				= function(value) SV.toggle = value end,
		default				= DEF.toggle,
		requiresReload		= true,
	})
---------------------------------------------------------------------------------------------------
	if not SV.toggle then return end

	--ZO_Menu
	ZO_PreHookHandler(ZO_Menu, 'OnShow', function()
		ZO_MenuBG:SetCenterTexture(nil, 4, 0)
		ZO_MenuBG:SetCenterColor(10/255, 10/255, 10/255, .96)
		ZO_MenuBG:SetEdgeTexture(nil, 1, 1, 1, 0)
		ZO_MenuBG:SetEdgeColor(60/255, 60/255, 60/255, 1)
		ZO_MenuBG:SetInsets(-1, -1, 1, 1)
		ZO_MenuBGMungeOverlay:SetHidden(true)
	end)

	PP.Anchor(ZO_MenuBG, --[[#1]] TOPLEFT, nil, TOPLEFT, -3, 3, --[[#2]] true, BOTTOMRIGHT, nil, BOTTOMRIGHT, -1, -3)
	ZO_MenuBG:SetInheritAlpha(false)

	ZO_MenuHighlight:SetCenterTexture(nil, 4, 0)
	ZO_MenuHighlight:SetCenterColor(96/255*.3, 125/255*.3, 139/255*.3, 1)
	ZO_MenuHighlight:SetEdgeTexture(nil, 1, 1, 1, 0)
	ZO_MenuHighlight:SetEdgeColor(96/255*.5, 125/255*.5, 139/255*.5, 0)
	ZO_MenuHighlight:SetInsets(0, 0, 0, 0)
	ZO_MenuHighlight:SetInheritAlpha(false)

	ZO_PreHook("ZO_Menu_SelectItem", function(control)
		ZO_MenuHighlight:ClearAnchors()
		ZO_MenuHighlight:SetAnchor(TOPLEFT, control, TOPLEFT, -6, 0)
		ZO_MenuHighlight:SetAnchor(BOTTOMRIGHT, control, BOTTOMRIGHT, 2, 0)
		ZO_MenuHighlight:SetHidden(false)
		control.nameLabel:SetColor(control.nameLabel.highlightColor:UnpackRGBA())
		return true
	end)
	-----------------------------------------------------------------------------------------------
	--RedirectTextures---------------------------------------------------------------------------------
	-- RedirectTexture("EsoUI/Art/Miscellaneous/horizontaldivider.dds",	"PerfectPixel/textures/RedirectTextures/EsoUI/Art/Miscellaneous/horizontaldivider.dds")
	-- RedirectTexture("EsoUI/Art/Miscellaneous/horizontaldividerred.dds",	"PerfectPixel/textures/RedirectTextures/EsoUI/Art/Miscellaneous/horizontaldividerred.dds")

	ZO_PreHook("ZO_PlayShowAnimationOnComparisonTooltip", function(tooltip)
		return true
	end)
	ZO_PreHook("ZO_PlayHideAnimationOnComparisonTooltip", function(tooltip)
		return true
	end)
	ZO_PreHook("ClearTooltip", function(tooltip)
		tooltip:SetHidden(true)
		-- return false
	end)

	local tab = {
		ItemTooltip, ComparativeTooltip1, ComparativeTooltip2, PopupTooltip, InformationTooltip, AbilityTooltip, SkillTooltip,	GameTooltip, AchievementTooltip,
		ZO_MapLocationTooltip, ZO_MapQuestDetailsTooltip,
		ZO_SmithingTopLevelCreationPanelResultTooltip, ZO_ProvisionerTopLevelTooltip, ZO_AlchemyTopLevelTooltip,
		HarvensSkillTooltipMorph1, HarvensSkillTooltipMorph2,
	}

	for _, v in ipairs(tab) do
		if not v then return end
		local iTB = v:GetNamedChild("BG")
		iTB:GetNamedChild("MungeOverlay"):SetHidden(true)

		iTB:SetCenterTexture(PP.t.bg1, 4, 1)
		iTB:SetCenterColor(10/255, 10/255, 10/255, .9)
		iTB:SetEdgeTexture(nil, 1, 1, 1, 0)
		iTB:SetEdgeColor(60/255, 60/255, 60/255, 1)
		iTB:SetInsets(-1, -1, 1, 1)

		PP.Anchor(iTB, --[[#1]] TOPLEFT, nil, TOPLEFT, 5, 5, --[[#2]] true, BOTTOMRIGHT, nil, BOTTOMRIGHT,	-5, -36)
		
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

	PP.Anchor(InformationTooltipBG,			--[[#1]] TOPLEFT, nil, TOPLEFT, 4, 5,	--[[#2]] true, BOTTOMRIGHT, nil, BOTTOMRIGHT, -4, -10)
	PP.Anchor(AbilityTooltipBG,				--[[#1]] TOPLEFT, nil, TOPLEFT, 5, -1,	--[[#2]] true, BOTTOMRIGHT, nil, BOTTOMRIGHT, -5, -20)
	PP.Anchor(SkillTooltipBG,				--[[#1]] TOPLEFT, nil, TOPLEFT, 5, -1,	--[[#2]] true, BOTTOMRIGHT, nil, BOTTOMRIGHT, -5, -20)
	PP.Anchor(GameTooltipBG,				--[[#1]] TOPLEFT, nil, TOPLEFT, 5, 5,	--[[#2]] true, BOTTOMRIGHT, nil, BOTTOMRIGHT, -5, -9)
	PP.Anchor(AchievementTooltipBG,			--[[#1]] TOPLEFT, nil, TOPLEFT, 5, 5,	--[[#2]] true, BOTTOMRIGHT, nil, BOTTOMRIGHT, -5, -20)
	PP.Anchor(ZO_MapLocationTooltipBG,		--[[#1]] TOPLEFT, nil, TOPLEFT, 5, 5,	--[[#2]] true, BOTTOMRIGHT, nil, BOTTOMRIGHT, -5, -15)
	PP.Anchor(ZO_MapQuestDetailsTooltipBG,	--[[#1]] TOPLEFT, nil, TOPLEFT, 5, 5,	--[[#2]] true, BOTTOMRIGHT, nil, BOTTOMRIGHT, -5, -5)
	--HarvensImprovedSkillsWindow compatibility ---------------------------------------------------
	if HarvensSkillTooltipMorph1 then
		PP.Anchor(HarvensSkillTooltipMorph1BG, --[[#1]] TOPLEFT, nil, TOPLEFT, 5, -1, --[[#2]] true, BOTTOMRIGHT, nil, BOTTOMRIGHT, -5, -20)
		PP.Anchor(HarvensSkillTooltipMorph2BG, --[[#1]] TOPLEFT, nil, TOPLEFT, 5, -1, --[[#2]] true, BOTTOMRIGHT, nil, BOTTOMRIGHT, -5, -20)
	end

	local flag = true
	ZO_PreHook("ZO_ItemTooltip_SetStolen", function(tooltipControl, isItemStolen)
		if tooltipControl:GetNamedChild("BG") then
			if (isItemStolen) then
				tooltipControl:GetNamedChild("BG"):SetEdgeColor(130/255, 20/255, 20/255, 1)
			else
				tooltipControl:GetNamedChild("BG"):SetEdgeColor(60/255, 60/255, 60/255, 1)
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