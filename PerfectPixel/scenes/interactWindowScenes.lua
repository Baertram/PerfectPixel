local PP = PP ---@class PP

local function StyleInteractWindowBackdrop(windowControl)
	if not windowControl then
		return
	end
	PP:CreateBackground(windowControl, --[[#1]] nil, nil, nil, -10, -10, --[[#2]] nil, nil, nil, 0, 10)
	local vanillaBackground = windowControl:GetNamedChild("BG")
	if vanillaBackground then
		vanillaBackground:SetHidden(true)
	end
	local titleDivider = windowControl:GetNamedChild("Divider")
	if titleDivider then
		titleDivider:SetHidden(true)
	end
end

local function StyleInteractWindowLabel(labelControl, fontSize, fontStyle)
	if not labelControl then
		return
	end
	PP.Font(labelControl, --[[Font]] PP.f.u67, fontSize, fontStyle)
end

PP.genericSelectorScene = function()
	local selectorControl = ZO_GenericSelector_KeyboardTL
	if not selectorControl and GENERIC_SELECTOR_KEYBOARD then
		selectorControl = GENERIC_SELECTOR_KEYBOARD.control
	end
	StyleInteractWindowBackdrop(selectorControl)
	if selectorControl then
		StyleInteractWindowLabel(selectorControl:GetNamedChild("Title"), 22, "outline")
	end

	-- Choice icons, highlights, and hover textures come from GetGenericSelectorChoice*AtIndex.
	if ZO_GenericSelector_Keyboard and ZO_GenericSelector_Shared then
		local sharedSetupGridEntry = ZO_GenericSelector_Shared.SetupGridEntry
		function ZO_GenericSelector_Keyboard:SetupGridEntry(control, data)
			sharedSetupGridEntry(self, control, data)
			local choiceNameLabel = control.nameLabel or control:GetNamedChild("Name")
			StyleInteractWindowLabel(choiceNameLabel, 16, "outline")
		end
	end

	local rewardsControl = ZO_GenericSelectorRewards_KeyboardTL
	StyleInteractWindowBackdrop(rewardsControl)
	if rewardsControl then
		StyleInteractWindowLabel(rewardsControl:GetNamedChild("Title"), 18, "outline")
	end

	local rewardsKeyboard = ZO_GENERIC_SELECTOR_REWARDS
	local rewardLabelPool = rewardsKeyboard and rewardsKeyboard.rewardLabelControlPool
	if rewardLabelPool then
		-- SetupRewards sets ZO_NORMAL_TEXT or ZO_DISABLED_TEXT after the label is acquired.
		local existingFactoryBehavior = rewardLabelPool.customFactoryBehavior
		rewardLabelPool:SetCustomFactoryBehavior(function(rewardLabel, ...)
			if existingFactoryBehavior then
				existingFactoryBehavior(rewardLabel, ...)
			end
			StyleInteractWindowLabel(rewardLabel, 16, "soft-shadow-thin")
		end)
	end
end

PP.trialProgressionScene = function()
	local trialProgressionControl = ZO_TrialProgression_Keyboard_TL
	if not trialProgressionControl and TRIAL_PROGRESSION_KEYBOARD then
		trialProgressionControl = TRIAL_PROGRESSION_KEYBOARD.control
	end
	StyleInteractWindowBackdrop(trialProgressionControl)
	if not trialProgressionControl then
		return
	end

	local headerControl = trialProgressionControl:GetNamedChild("Header")
	if not headerControl then
		return
	end
	StyleInteractWindowLabel(headerControl:GetNamedChild("Title"), 22, "outline")
	StyleInteractWindowLabel(headerControl:GetNamedChild("Subtitle"), 18, "outline")
end
