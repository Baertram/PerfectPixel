local PP		= PP
local namespace	= 'ChatWindow'

PP.chatWindow = function()
--===============================================================================================--
	local sv, def = PP:AddNewSavedVars(0.3, namespace, {
		toggle							= true,
		skin_backdrop					= "PerfectPixel/tex/tex_white.dds",
		skin_backdrop_col				= {0/255, 0/255, 0/255, 160/255},
		skin_backdrop_insets			= 6,
		skin_backdrop_tile				= false,
		skin_backdrop_tile_size			= 8,
		skin_edge						= "PerfectPixel/tex/edge_outer_shadow_128x16.dds",
		skin_edge_col					= {0/255, 0/255, 0/255, 160/255},
		skin_edge_thickness				= 16,
		skin_edge_file_width			= 128,
		skin_edge_file_height			= 16,
		skin_edge_integral_wrapping		= false,
	})
	---------------------------------------------
	table.insert(PP.optionsData,
	{	type		= "submenu",
		name		= GetString(PP_LAM_SCENE_CHAT),
		controls	= PP.PackTables(
			{
				{	type			= "checkbox",
					name			= GetString(PP_LAM_ACTIVATE),
					getFunc			= function() return sv.toggle end,
					setFunc			= function(value) sv.toggle = value end,
					default			= def.toggle,
					requiresReload	= true,
				}
			},
			PP:AddBackdropSettings(namespace),
			PP:AddEdgeSettings(namespace)
		),
	})
--===============================================================================================--

	if not sv.toggle == true then return end

--KEYBOARD_CHAT_SYSTEM-----------------------------------------------------------------------------
	local cw		= ZO_ChatWindow
	local bg		= cw:GetNamedChild('Bg')
	local container	= cw:GetNamedChild("WindowContainer")
	local textEntry	= cw:GetNamedChild("TextEntry")
	local minimize	= cw:GetNamedChild("Minimize")

	PP:CreateBackground(bg, --[[#1]] nil, nil, nil, 6, 6, --[[#2]] nil, nil, nil, -6, -6, namespace)

	ZO_PostHook(KEYBOARD_CHAT_SYSTEM, 'OnPlayerActivated', function(...)
		PP.Anchor(container,	--[[#1]] nil, nil, nil, nil, nil, --[[#2]] true, nil, nil, nil, -18, -5)
		PP.Anchor(textEntry,	--[[#1]] nil, nil, nil, nil, nil, --[[#2]] true, nil, nil, nil, -13, nil)
		PP.Anchor(minimize,		--[[#1]] nil, nil, nil, 5, nil)
		PP:UpdateBackgrounds('ChatWindow')
	end)

	--scrollbar
	local sb		= cw:GetNamedChild("Scrollbar")
	local up		= sb:GetNamedChild("ScrollUp")
	local down		= sb:GetNamedChild("ScrollDown")
	local bend		= sb:GetNamedChild("ScrollEnd")

	local thumb		= sb:GetThumbTextureControl()
	local contents	= sb:GetParent().contents
	local tex		= "PerfectPixel/tex/tex_white.dds"

	up:SetHidden(true)
	down:SetHidden(true)
	bend:SetHidden(true)
	PP:SetLockFn(up, 'SetHidden')
	PP:SetLockFn(down, 'SetHidden')
	PP:SetLockFn(bend, 'SetHidden')

	PP.Anchor(up,	--[[#1]] TOP, nil, TOP, nil, nil)
	PP.Anchor(down,	--[[#1]] BOTTOM, nil, BOTTOM, nil, nil)

	PP.Anchor(bend,	--[[#1]] BOTTOM, nil, BOTTOM, -14, nil)
	bend:SetDrawLayer(DL_OVERLAY)
	bend:SetHidden(true)

	local t_states = {
		[BSTATE_NORMAL]				= false,
		[BSTATE_PRESSED]			= false,
		[BSTATE_DISABLED]			= true,
		[BSTATE_DISABLED_PRESSED]	= true,
	}
	ZO_PreHook(bend, 'SetState', function(self, state, ...)
		PP:CallingBlockedFn(self, 'SetHidden', t_states[state])
	end)

	PP.Anchor(sb, --[[#1]] nil, nil, nil, -13, 48, --[[#2]] true, nil, nil, nil, -13, -48)

	sb:SetBackgroundMiddleTexture(tex)
	sb:SetBackgroundTopTexture(nil)
	sb:SetBackgroundBottomTexture(nil)
	sb:SetColor(50/255, 50/255, 50/255, 1)
	sb:SetAlpha(.6)
	sb:SetHitInsets(-4, 0, 5, 0)
	sb:SetWidth(4)
	sb.thumb = thumb

	thumb:SetWidth(4)
	thumb:SetTexture(tex)
	thumb:SetColor(120/255, 120/255, 120/255, 1)
	thumb:SetHitInsets(-4, 0, 5, 0)		
end