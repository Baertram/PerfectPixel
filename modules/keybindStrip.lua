PP.keybindStripModule = {}

local keybindStripFragment = 			KEYBIND_STRIP_FADE_FRAGMENT
local keybindStripFragment_Gamepad = 	KEYBIND_STRIP_GAMEPAD_FRAGMENT
local championKeybindStripFragment = 	CHAMPION_KEYBIND_STRIP_FADE_FRAGMENT
local marketKeybindStripFragment = 		MARKET_KEYBIND_STRIP_FRAGMENT


function PP.keybindStripModule.keybindStripUpdateKeybindStripBG(firstLoad, fragmentVar)
PP._lastKeybindFragment = fragmentVar
	firstLoad = firstLoad or false
	local SV = PP.keybindStripModule.SV
	if SV.toggle then
		local isInGamepadMode = IsInGamepadPreferredMode()
		--Do not change hidden state of keybind bar if looting items
		if (isInGamepadMode == true and GAMEPAD_LOOT_PICKUP_FRAGMENT:IsShowing()) or  LOOT_WINDOW_FRAGMENT:IsShowing() then
			return
		end

		-- ZO_KeybindStrip
		local keybindStripHeight = SV.keybindBGHeight
		ZO_KeybindStripControl:SetHeight(keybindStripHeight)
		if isInGamepadMode then
			ZO_KeybindStripGamepadBackground:SetHeight(keybindStripHeight)
			if firstLoad == true then
				ZO_KeybindStripGamepadBackground:SetHidden(true)
			else
				ZO_KeybindStripGamepadBackground:SetHidden(SV.keybindTransparency)
			end
		else
			ZO_KeybindStripMungeBackground:SetHeight(keybindStripHeight)
			if firstLoad == true then
				ZO_KeybindStripMungeBackground:SetHidden(true)
			else
				ZO_KeybindStripMungeBackground:SetHidden(SV.keybindTransparency)
			end

		end
		ZO_KeybindStripMungeBackgroundTexture:SetHidden(true)
	end
end
local keybindStripUpdateKeybindStripBG = PP.keybindStripModule.keybindStripUpdateKeybindStripBG


PP.keybindStripModule.Load = function(firstLoad)
--===============================================================================================--
	local SV_VER		= 0.1
	local DEF = {
		toggle	= true,
		keybindTransparency = false,
		keybindBGHeight = 31,
		keybindOffsetY = 0,
	}
	PP.keybindStripModule.SV = ZO_SavedVars:NewAccountWide(PP.ADDON_NAME, SV_VER, "KeybindStrip", DEF, GetWorldName())
	local SV = PP.keybindStripModule.SV
	---------------------------------------------
	table.insert(PP.optionsData,
	{	type				= "submenu",
		name				= GetString(PP_LAM_KEYBINDSTRIP),
		controls = {
			{	type				= "checkbox",
				name				= GetString(PP_LAM_ACTIVATE),
				getFunc				= function() return SV.toggle end,
				setFunc				= function(value) SV.toggle = value
					ZO_KeybindStripControl:SetHidden(true)
				end,
				default				= DEF.toggle,
				requiresReload		= true,
			},
			{	type				= "checkbox",
				name				= GetString(PP_LAM_TRANSPARENCY),
				getFunc				= function() return SV.keybindTransparency end,
				setFunc				= function(value) SV.keybindTransparency = value
					ZO_KeybindStripControl:SetHidden(true)
				end,
				default				= DEF.toggle,
			 	disabled			= function() return not SV.toggle end,
			},
			{	type 				= "slider", name = 'Height',
				max					= 75, min = 5,
				getFunc				= function() return SV.keybindBGHeight end,
				setFunc				= function(value) SV.keybindBGHeight = value
					ZO_KeybindStripControl:SetHidden(true)
				end,
				default				= DEF.keybindBGHeight,
				width				= "half",
				disabled			= function() return not SV.toggle end,
			},
		},
	})
--===============================================================================================--

	PP:CreateBackground(ZO_KeybindStripMungeBackground, --[[#1]] nil, nil, nil, -6, 0, --[[#2]] nil, nil, nil, 6, 6)
	keybindStripUpdateKeybindStripBG(firstLoad, nil)

	local fragmentsForCallback = { keybindStripFragment, championKeybindStripFragment, marketKeybindStripFragment,
								   keybindStripFragment_Gamepad }
	for _, fragmentToAddCallback in ipairs(fragmentsForCallback) do
		fragmentToAddCallback:RegisterCallback("StateChange", function(oldState, newState)
			if newState == SCENE_FRAGMENT_SHOWN then
				keybindStripUpdateKeybindStripBG(false, fragmentToAddCallback)
			end
		end)
	end

end