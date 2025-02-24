local PP = PP ---@class PP
--local namespace	= 'LockpickingScene'

PP.lockpickingScene = function()
	--Lockpicking
	local lockpickSceneChanged = false
	local function lockPickSceneShowingCallback()
		local lockPickObject = LOCK_PICK
		local timerBarParent = lockPickObject.timer.control
		if timerBarParent == nil then return end

		local timerBarLabel = timerBarParent:GetNamedChild("Time")
		PP.Font(timerBarLabel, PP.f.u67, 16, "outline", nil, nil, nil, nil, nil, 0, 0, 0, 0.5)

		local timerBar = timerBarParent:GetNamedChild("ZO_LockpickTimerBarStatus1")
		PP.Bar(timerBar, 14, 15, nil, nil, nil, nil)
	end

	PP.onStateChangeCallback(LOCK_PICK_SCENE, function(oldState, newState)
		if newState == SCENE_SHOWN and not lockpickSceneChanged then
			lockPickSceneShowingCallback()
			lockpickSceneChanged = true
		end
	end)
end