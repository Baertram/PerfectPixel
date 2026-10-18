local PP = PP ---@class PP

PP.hudTrackers = function()
	local PROGRESS_LABEL_OFFSET_Y = 1

	local function restoreGamepadProgressBar(progressBar)
		-- Backdrop only exists once PP.Bar has styled the bar in keyboard mode.
		local backdrop = progressBar:GetNamedChild("Backdrop")
		if backdrop then backdrop:SetHidden(true) end
		progressBar:GetNamedChild("BG"):SetHidden(false)
		progressBar:GetNamedChild("Overlay"):SetHidden(false)
		progressBar:EnableLeadingEdge(true)
		progressBar:GetNamedChild("Gloss"):EnableLeadingEdge(true)
	end

	-- Must run after ZO_ApplyPlatformTemplateToControl(bar, "ZO_HUDTracker_Base_ProgressBar"), which resets textures and size.
	local function applyProgressBarStyle(progressBar)
		if IsInGamepadPreferredMode() then
			restoreGamepadProgressBar(progressBar)
			return
		end
		PP.Bar(progressBar, --[[height]] 14, --[[fontSize]] 15)
		progressBar:GetNamedChild("Backdrop"):SetHidden(false)
		local progressLabel = progressBar:GetNamedChild("Progress")
		progressLabel:ClearAnchors()
		progressLabel:SetAnchor(CENTER, progressBar, CENTER, 0, PROGRESS_LABEL_OFFSET_Y)
	end

	SecurePostHook(TIMED_ACTIVITY_TRACKER, "ApplyPlatformStyle", function(self)
		applyProgressBarStyle(self.progressBar)
	end)

	SecurePostHook(DYNAMIC_EVENTS_TRACKER, "ApplyPlatformStyle", function(self)
		applyProgressBarStyle(self.progressBar)
	end)

	SecurePostHook(ACHIEVEMENT_TRACKER, "ApplyPlatformStyle", function(self)
		for _, criteriaProgressBar in self.criteriaProgressPool:ActiveAndFreeObjectIterator() do
			applyProgressBarStyle(criteriaProgressBar)
		end
	end)

	local infoBox = ZO_HUDEditor_Keyboard_TLInfoBox
	if infoBox then
		PP:CreateBackground(infoBox, --[[#1]] nil, nil, nil, -10, -10, --[[#2]] nil, nil, nil, 0, 10)
		local infoBoxBackground = infoBox:GetNamedChild("BG")
		if infoBoxBackground then
			infoBoxBackground:SetHidden(true)
		end
		--Make the background the same draw* as the HUD movable controls, and increase the level by 1 so it overlays it
		infoBox.PP_BG:SetDrawTier(DT_HIGH)
		infoBox.PP_BG:SetDrawLayer(DL_BACKGROUND)
		infoBox.PP_BG:SetDrawLevel(5)

		local infoBoxHeader = infoBox:GetNamedChild("Header")
		local infoBoxSelector = infoBoxHeader and infoBoxHeader:GetNamedChild("Selector")
		local selectedItemText = infoBoxSelector and infoBoxSelector:GetNamedChild("SelectedItemText")
		if selectedItemText then
			PP.Font(selectedItemText, --[[Font]] PP.f.u67, 16, "outline")
		end

		local coordinates = infoBox:GetNamedChild("Coordinates")
		local coordinatesHeader = coordinates and coordinates:GetNamedChild("Header")
		if coordinatesHeader then
			PP.Font(coordinatesHeader, --[[Font]] PP.f.u67, 16, "outline")
		end
		local xCoordinateName = coordinates and coordinates:GetNamedChild("XCoords") and coordinates:GetNamedChild("XCoords"):GetNamedChild("Name")
		local yCoordinateName = coordinates and coordinates:GetNamedChild("YCoords") and coordinates:GetNamedChild("YCoords"):GetNamedChild("Name")
		if xCoordinateName then
			PP.Font(xCoordinateName, --[[Font]] PP.f.u67, 16, "outline")
		end
		if yCoordinateName then
			PP.Font(yCoordinateName, --[[Font]] PP.f.u67, 16, "outline")
		end
	end

	local criteriaProgressPool = ACHIEVEMENT_TRACKER.criteriaProgressPool
	local zosCriteriaProgressFactoryBehavior = criteriaProgressPool.customFactoryBehavior
	criteriaProgressPool:SetCustomFactoryBehavior(function(criteriaProgressBar, ...)
		zosCriteriaProgressFactoryBehavior(criteriaProgressBar, ...)
		applyProgressBarStyle(criteriaProgressBar)
	end)
end
