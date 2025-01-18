local PP = PP ---@class PP

PP.scrolling = function()
--===============================================================================================--
	local SV_VER		= 0.1
	local DEF = {
		toggle				= false,
		duration			= 400,
		intensity			= 1,
	}
	local SV = ZO_SavedVars:NewAccountWide(PP.ADDON_NAME, SV_VER, "Scrolling", DEF, GetWorldName())
	-----------------------------------------
	table.insert(PP.optionsData,
	{	type				= "submenu",
		name				= 'Scrolling (BETA)',
		controls = {
			{	type				= "checkbox",
				name				= GetString(PP_LAM_ACTIVATE),
				getFunc				= function() return SV.toggle end,
				setFunc				= function(value) SV.toggle = value end,
				default				= DEF.toggle,
				requiresReload		= true,
			},
			{	type 				= "slider", name = 'Duration',
				max					= 1000, min = 1,
				getFunc				= function() return SV.duration end,
				setFunc				= function(value) SV.duration = value end,
				default				= DEF.duration,
				width				= "half",
				disabled			= function() return not SV.toggle end,
			},
			{	type 				= "slider", name = 'Intensity',
				min					= 0.0, max = 10.0, step = 0.01, decimals = 2,
				getFunc				= function() return SV.intensity end,
				setFunc				= function(value) SV.intensity = value end,
				default				= DEF.intensity,
				width				= "half",
				disabled			= function() return not SV.toggle end,
			},
		},
	})
--===============================================================================================--
	if not SV.toggle then return end

	local function SetSliderValue(self, targetValue, animateInstantly, overrideDurationMS)
		if self.scrollbar then
			local startValue = self.scrollbar:GetValue()
			local scrollMin, scrollMax = self.scrollbar:GetMinMax()
			targetValue = zo_clamp(targetValue, scrollMin, scrollMax)
			if zo_abs(startValue - targetValue) > 0.001 then 
				self.timeline:Stop()
				self.animationStart = startValue
				self.animationTarget = targetValue
				self.animationUnits = PP.SCROLL_ANIMATION
				self.animation:SetDuration(overrideDurationMS or SV.duration)
				if animateInstantly then
					self.timeline:PlayInstantlyToEnd()
				else
					self.timeline:PlayFromStart()
				end
			elseif self.onScrollCompleteCallback then 
				local SCROLL_ANIMATION_COMPLETE = true
				self.onScrollCompleteCallback(SCROLL_ANIMATION_COMPLETE) 
				self.onScrollCompleteCallback = nil 
			end
		end
	end

	local orig_ZO_ScrollList_ScrollRelative = ZO_ScrollList_ScrollRelative

	function ZO_ScrollList_ScrollRelative(self, delta, onScrollCompleteCallback, animateInstantly)

		if not self.lock then
			local scrollValue
			if self.animationTarget then
				scrollValue = self.animationTarget + delta * SV.intensity
			else
				scrollValue = self.scrollbar:GetValue() + delta * SV.intensity
			end

			self.onScrollCompleteCallback = onScrollCompleteCallback
			SetSliderValue(self, scrollValue, animateInstantly)
		elseif onScrollCompleteCallback then
			onScrollCompleteCallback(true)
		end
	end
end