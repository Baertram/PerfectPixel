local PP = PP ---@class (partial) PP
--local namespace	= 'LockpickingScene'

PP.lockpickingScene = function()
--===============================================================================================--
	local SV_VER		= 0.1
	local DEF = {
		enableScenesPPLook	= true,
	}
	local SV = PP:AddNewSavedVars(SV_VER, "LockpickingScene", DEF)
	---------------------------------------------
	table.insert(PP.optionsData,
	{	type				= "submenu",
		name				= GetString(PP_LAM_SCENE_LOCKPICKING),
		controls = {
			{	type				= "checkbox",
				name				= GetString(PP_LAM_ACTIVATE),
				getFunc				= function() return SV.enableScenesPPLook end,
				setFunc				= function(value) SV.enableScenesPPLook = value end,
				default				= DEF.enableScenesPPLook,
				requiresReload		= true,
			},
		},
	})
--===============================================================================================--

	if not SV.enableScenesPPLook then return end

	--Lockpicking
	local lockpickSceneChanged = false
	local function lockPickSceneShowingCallback()
		local lockPickObject = LOCK_PICK
		local timerBarParent = lockPickObject.timer.control
		if timerBarParent == nil then return end

		local timerBarLabel = timerBarParent:GetNamedChild("Time")
		PP.Font(timerBarLabel, PP.f.u67, 16, "outline", --[[Alpha]] nil, --[[Color]] nil, nil, nil, nil, --[[StyleColor]] 0, 0, 0, 0.5)

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