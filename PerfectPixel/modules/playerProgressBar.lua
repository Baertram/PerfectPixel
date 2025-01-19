local PP = PP ---@class PP

PP.playerProgressBar = function()

	ZO_PreHook(PLAYER_PROGRESS_BAR, "Show", function(self, ...)
		self.fadeTimeline:GetAnimation():SetDuration(1)
	end)
	-- ZO_PreHook(PLAYER_PROGRESS_BAR, "Hide", function(self, ...)
		-- self.fadeTimeline:GetAnimation():SetDuration(1)
	-- end)

	ZO_PreHook(PLAYER_PROGRESS_BAR, "RefreshTemplate", function(self, ...)
		local bar		= PLAYER_PROGRESS_BAR.barControl
		bar:SetHeight(14)
		bar:SetTexture(nil)
		bar:SetLeadingEdge(nil)
		bar:EnableLeadingEdge(false)

		local bg		= bar:GetNamedChild("BG")
		bg:SetHidden(true)

		local overlay	= bar:GetNamedChild("Overlay")
		overlay:SetHidden(true)

		local enlbar	= PLAYER_PROGRESS_BAR.enlightenedBarControl
		enlbar:SetAnchorFill(bar)
		enlbar:SetHeight(14)
		enlbar:SetTexture(nil)
		enlbar:SetLeadingEdge(nil)
		enlbar:EnableLeadingEdge(false)
		
		local gloss		= bar:GetNamedChild("Gloss")
		gloss:SetHeight(14)
		gloss:SetTexture(nil)
		gloss:SetLeadingEdge(nil)
		gloss:EnableLeadingEdge(false)


		if not bar:GetNamedChild("Backdrop") then
			local barBG = CreateControl("$(parent)Backdrop", bar, CT_BACKDROP)

			PP.Anchor(barBG, --[[#1]] TOPLEFT, bar, TOPLEFT, -2, -2, --[[#2]] true, BOTTOMRIGHT, bar, BOTTOMRIGHT,	2, 2)
			barBG:SetCenterTexture(nil, 8, 0)
			barBG:SetCenterColor(10/255, 10/255, 10/255, 0.8)
			barBG:SetEdgeTexture("", 1, 1, 1, 0)
			barBG:SetEdgeColor(60/255, 60/255, 60/255, 0.9)
			barBG:SetInsets(-1, -1, 1, 1)
		end

		return true
	end)
	
end

-- PlayInstantlyToEnd()
-- PlayInstantlyToStart()


-- local PROGRESS_BAR_KEYBOARD_STYLE = 
-- {
    -- template = "ZO_PlayerProgressTemplate",
    -- championTemplate = "ZO_PlayerChampionProgressTemplate"
-- }

-- function PlayerProgressBar:RefreshTemplate()
    -- local template
    -- local style
    -- local barTypeInfo = self:GetBarTypeInfo()
    -- local useChampionPoints = CanUnitGainChampionPoints("player")
    -- if IsInGamepadPreferredMode() then
        -- template = "ZO_GamepadPlayerProgressBarTemplate"
        -- style = PROGRESS_BAR_GAMEPAD_STYLE
    -- else
        -- template = "ZO_PlayerProgressBarTemplate"
        -- style = PROGRESS_BAR_KEYBOARD_STYLE
    -- end

    -- if barTypeInfo and (barTypeInfo.barTypeClass == PPB_CLASS_SKILL or barTypeInfo.barTypeClass == PPB_CLASS_XP) then
        -- ApplyTemplateToControl(self.control, style.template)
    -- elseif useChampionPoints then
        -- ApplyTemplateToControl(self.control, style.championTemplate)
    -- else
        -- ApplyTemplateToControl(self.control, style.template)
    -- end
    -- ApplyTemplateToControl(self.barControl, template)
-- end

-- /script 

-- PP.Bar(PLAYER_PROGRESS_BAR.barControl, --[[height]] 14, --[[fontSize]] 14)

-- ApplyTemplateToControl(PLAYER_PROGRESS_BAR.control, "ZO_PlayerChampionProgressTemplate")
