PP.reticle = function()
--===============================================================================================--
	local SV_VER		= 0.1
	local DEF = {
		toggle				= true,
		StealthText_toggle	= false,
	}
	local SV = ZO_SavedVars:NewAccountWide(PP.ADDON_NAME, SV_VER, "Reticle", DEF, GetWorldName())
	---------------------------------------------
	table.insert(PP.optionsData,
	{	type				= "header",
		name				= GetString(PP_LAM_RETICLE),
	})
	table.insert(PP.optionsData,
	{	type				= "checkbox",
		name				= GetString(PP_LAM_ACTIVATE),
		getFunc				= function() return SV.toggle end,
		setFunc				= function(value) SV.toggle = value end,
		default				= DEF.toggle,
		requiresReload		= true,
	})
	table.insert(PP.optionsData,
	{	type				= "checkbox",
		name				= GetString(PP_LAM_RETICLE_HIDE_STEALTH),
		getFunc				= function() return SV.StealthText_toggle end,
		setFunc				= function(value) SV.StealthText_toggle = value end,
		default				= DEF.StealthText_toggle,
		requiresReload		= true,
	})
--===============================================================================================--
--ZO_Reticle
	if SV.toggle then
		PP.Anchor(ZO_ReticleContainerInteractKeybindButton, --[[#1]] TOPLEFT, ZO_ReticleContainerInteractContext, BOTTOMLEFT, 0, 0)
		PP.Font(ZO_ReticleContainerInteractContext,					--[[Font]] PP.f.u67, 20, "outline", --[[Alpha]] nil, --[[Color]] nil, nil, nil, nil, --[[StyleColor]] 0, 0, 0, .8)
		-- PP.Anchor(ZO_ReticleContainerInteractKeybindButtonKeyLabel, --[[#1]] RIGHT, ZO_ReticleContainerInteractKeybindButtonNameLabel, LEFT, -10, 0)
		PP.Font(ZO_ReticleContainerNonInteractText,					--[[Font]] PP.f.u67, 20, "outline", --[[Alpha]] nil, --[[Color]] nil, nil, nil, nil, --[[StyleColor]] 0, 0, 0, .8)
		PP.Font(ZO_ReticleContainerInteractKeybindButtonKeyLabel,	--[[Font]] PP.f.u57, 16, "",		--[[Alpha]] nil, --[[Color]] nil, nil, nil, nil, --[[StyleColor]] 0, 0, 0, .5)
		PP.Font(ZO_ReticleContainerInteractKeybindButtonNameLabel,	--[[Font]] PP.f.u67, 19, "outline",	--[[Alpha]] nil, --[[Color]] nil, nil, nil, nil, --[[StyleColor]] 0, 0, 0, .8)
	end

	ZO_ReticleContainerStealthIconStealthText:SetHidden(SV.StealthText_toggle)
	PP.Font(ZO_LootStealthIconStealthText, --[[Font]] PP.f.u67, 24, "outline", --[[Alpha]] 1, --[[Color]] nil, nil, nil, nil, --[[StyleColor]] 0, 0, 0, .8)
	PP.Anchor(ZO_LootStealthIconStealthText, --[[#1]] TOP, ZO_Loot, TOP, 0, -60)
end