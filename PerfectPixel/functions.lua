if not PP then PP = {} end
-- media
PP.t = {			--[[	Textures	]]
	bg1		=	"PerfectPixel/textures/background.dds",
	bg2		=	"PerfectPixel/textures/background2.dds",
	bg3		=	"PerfectPixel/textures/gray50.dds",
	gU		=	"PerfectPixel/textures/GradientUp.dds",
	gD		=	"PerfectPixel/textures/GradientDown.dds",
	gL		=	"PerfectPixel/textures/GradientLeft.dds",
	gR		=	"PerfectPixel/textures/GradientRight.dds",
	clear	=	"PerfectPixel/textures/clear.dds",
	def1	=	"esoui/art/tooltips/munge_overlay.dds",
	def2	=	"EsoUI/Art/Miscellaneous/centerscreen_left.dds",
}
PP.f = {			--[[	Fonts		]]
	univers57	=	"PerfectPixel/fonts/univers57.otf|15", -- "/EsoUI/Common/Fonts/univers57.otf",
	univers67	=	"PerfectPixel/fonts/univers67.otf|15", -- "/EsoUI/Common/Fonts/univers67.otf",
	u57			=	"PerfectPixel/fonts/univers57.otf", -- "/EsoUI/Common/Fonts/univers57.otf",
	u67			=	"PerfectPixel/fonts/univers67.otf", -- "/EsoUI/Common/Fonts/univers67.otf",
}
--[[colors
def = ( 173, 166, 132 )
red = ( 222, 36, 33 )
96/255, 125/255, 139/255
]]
-- functions

PP.mainBackdrop = function(control, scene, --[[backdrop]] point_1, point_2, x_1, y_1, x_2, y_2, --[[tex]] tex, size, mod, --[[bd]] c_r, c_g, c_b, c_a, --[[edge]]	edge_r, edge_g, edge_b, edge_a, --[[texture]] toggle, g_a)
	if not control.mainFrame then
		control.mainFrame = CreateTopLevelWindow()
		control.mainFrame:SetHidden(true)
		control.mainFrame:SetInheritAlpha(false)
		control.mainFrame:SetInheritScale(false)
		control.mainFrame:SetDrawLayer(0)
		control.mainFrame:SetDrawLevel(0)
		control.mainFrame:SetDrawTier(0)

		control.backdrop = CreateControl(nil, control.mainFrame, CT_BACKDROP)
		control.backdrop:SetAnchor(point_1 or TOPLEFT, control, point_1 or TOPRIGHT, x_1, y_1)
		control.backdrop:SetAnchor(point_2, control, point_2, x_2, y_2)

		control.backdrop:SetCenterTexture(tex, size, mod)
		control.backdrop:SetCenterColor(c_r/255, c_g/255, c_b/255, c_a)
		control.backdrop:SetInsets(1, 1, -1, -1)

		control.backdrop:SetEdgeTexture(nil, 1, 1, 1, 0)
		control.backdrop:SetEdgeColor(edge_r/255, edge_g/255, edge_b/255, edge_a)

		control.backdrop:SetPixelRoundingEnabled(false)
		control.backdrop:SetInheritAlpha(false)

		control.backdrop:SetDrawLayer(0)
		control.backdrop:SetDrawLevel(1)
		control.backdrop:SetDrawTier(0)

		if toggle then
			control.texture = CreateControl(nil, control.mainFrame, CT_TEXTURE)
			control.texture:SetAnchor(TOPLEFT, control.backdrop, TOPLEFT, 1, 1)
			control.texture:SetAnchor(BOTTOMRIGHT, control.backdrop, TOPRIGHT, -1, 100)
			control.texture:SetTexture(nil)
			control.texture:SetGradientColors(ORIENTATION_VERTICAL, 132/255, 117/255, 69/255, 0,	132/255, 117/255, 69/255, g_a)
			
			control.texture:SetPixelRoundingEnabled(false)
			control.texture:SetInheritAlpha(false)
			
			control.texture:SetDrawLayer(0)
			control.texture:SetDrawLevel(0)
			control.texture:SetDrawTier(0)
		end
	end
	SCENE_MANAGER:GetScene(scene):AddFragment(ZO_SimpleSceneFragment:New(control.mainFrame))
end

PP.Backdrop = function(	mainControl, control, --[[#1]] poi_1, con_1, poi_2, x_1, y_1, --[[#2]] poi_3, con_2, poi_4, x_2, y_2,
						--[[tex_1]] tex_1, size_1, mod_1, --[[bd]] c_r_1, c_g_1, c_b_1, c_a_1, --[[edge]] e_r_1, e_g_1, e_b_1, e_a_1,
						--[[tex_2]] toggle, tex_2, size_2, mod_2, --[[bd]] c_r_2, c_g_2, c_b_2, c_a_2)

	mainControl.bg = CreateControl(control:GetName() .. '_BG', mainControl.mainFrame, CT_BACKDROP)
	mainControl.bg:SetAnchor(poi_1 or TOPLEFT,		con_1 or control, poi_2 or TOPLEFT,		x_1, y_1)
	mainControl.bg:SetAnchor(poi_3 or BOTTOMRIGHT,	con_2 or control, poi_4 or BOTTOMRIGHT,	x_2, y_2)
	mainControl.bg:SetCenterTexture(tex_1, size_1, mod_1)
	mainControl.bg:SetCenterColor(c_r_1/255, c_g_1/255, c_b_1/255, c_a_1)
	mainControl.bg:SetEdgeTexture(nil, 1, 1, 1, 0)
	mainControl.bg:SetEdgeColor(e_r_1/255, e_g_1/255, e_b_1/255, e_a_1)
	mainControl.bg:SetInsets(1, 1, -1, -1)
	mainControl.bg:SetHidden(true)

	mainControl.bg:SetPixelRoundingEnabled(false)
	mainControl.bg:SetInheritAlpha(false)
	mainControl.bg:SetInheritScale(false)
	
	mainControl.bg:SetDrawLayer(0)
	mainControl.bg:SetDrawLevel(2)
	mainControl.bg:SetDrawTier(0)
	if toggle then
		mainControl.tex = CreateControl(nil, mainControl.bg, CT_BACKDROP)
		mainControl.tex:SetAnchor(TOPLEFT,		mainControl.bg, TOPLEFT,		1, 1)
		mainControl.tex:SetAnchor(BOTTOMRIGHT,	mainControl.bg, BOTTOMRIGHT,	-1, -1)
		mainControl.tex:SetCenterTexture(tex_2, size_2, mod_2)
		mainControl.tex:SetCenterColor(c_r_2/255, c_g_2/255, c_b_2/255, c_a_2)
		mainControl.tex:SetEdgeTexture(nil, 1, 1, 0, 0)
		mainControl.tex:SetEdgeColor(0, 0, 0, 0)

		mainControl.tex:SetPixelRoundingEnabled(false)
		mainControl.tex:SetInheritAlpha(false)
		mainControl.tex:SetInheritScale(false)
		
		mainControl.tex:SetDrawLayer(0)
		mainControl.tex:SetDrawLevel(3)
		mainControl.tex:SetDrawTier(0)
	end

	ZO_PreHookHandler(control, 'OnShow', function()
		control:GetNamedChild("_BG"):SetHidden(false)    
	end)
	ZO_PreHookHandler(control, 'OnHide', function()
		control:GetNamedChild("_BG"):SetHidden(true)    
	end)
end

PP.BTexture = function(control, poi1_1, con_1, poi2_1, x_1, y_1, poi1_2, con_2, poi2_2, x_2, y_2, --[[tex]] tex, size, mod,
	--[[bd]] c_r, c_g, c_b, c_a, --[[edge]] edge_r, edge_g, edge_b, edge_a, --[[t_tex]] toggle, t_tex, sizet, modt, --[[ct]] ct_r, ct_g, ct_b, ct_a	)

	if not control:GetNamedChild("Backdrop") then
		CreateControl(control:GetName() .. "Backdrop", control, CT_BACKDROP)
			local targetBackdrop = control:GetNamedChild("Backdrop")
			targetBackdrop:SetPixelRoundingEnabled(false)
			targetBackdrop:SetInheritAlpha(false)
			targetBackdrop:SetInheritScale(false)
			targetBackdrop:SetDrawLayer(0)
			targetBackdrop:SetDrawLevel(0)
			targetBackdrop:SetDrawTier(0)
			targetBackdrop:SetAnchor(poi1_1 or TOPLEFT, con_1 or control, poi2_1 or TOPLEFT, x_1, y_1)
			targetBackdrop:SetAnchor(poi1_2 or BOTTOMRIGHT,	con_2 or control, poi2_2 or BOTTOMRIGHT,	x_2, y_2)
			targetBackdrop:SetCenterTexture(tex, size, mod)
			targetBackdrop:SetCenterColor(c_r/255, c_g/255, c_b/255, c_a)
			targetBackdrop:SetEdgeTexture(nil, 1, 1, 1, 0)
			targetBackdrop:SetEdgeColor(edge_r/255, edge_g/255, edge_b/255, edge_a)
			targetBackdrop:SetInsets(1, 1, -1, -1)
		if toggle then
			CreateControl(targetBackdrop:GetName() .. "Texture", targetBackdrop, CT_BACKDROP)
				local backdropTexture = targetBackdrop:GetNamedChild("Texture")
				backdropTexture:SetAnchor(TOPLEFT, targetBackdrop, TOPLEFT, 1, 1)
				backdropTexture:SetAnchor(BOTTOMRIGHT, targetBackdrop, BOTTOMRIGHT, -1, -1)
				backdropTexture:SetCenterTexture(t_tex, sizet, modt)
				backdropTexture:SetCenterColor(ct_r/255, ct_g/255, ct_b/255, ct_a)
				backdropTexture:SetEdgeTexture(nil, 1, 1, 0, 0)
				backdropTexture:SetEdgeColor(0, 0, 0, 0)
				backdropTexture:SetPixelRoundingEnabled(false)
				backdropTexture:SetInheritAlpha(false)
				backdropTexture:SetInheritScale(false)
				backdropTexture:SetDrawLayer(0)
				backdropTexture:SetDrawLevel(0)
				backdropTexture:SetDrawTier(0)
		end
	end
end

PP.ListBackdrop = function(control, x_1, y_1, x_2, y_2, --[[tex]] tex, size, mod, --[[bd]] c_r, c_g, c_b, c_a, --[[edge]] edge_r, edge_g, edge_b, edge_a)
	if not control:GetNamedChild("Backdrop") then
			CreateControl(control:GetName() .. "Backdrop", control, CT_BACKDROP)
				local targetBackdrop = control:GetNamedChild("Backdrop")
				targetBackdrop:SetPixelRoundingEnabled(false)
				targetBackdrop:SetInheritAlpha(false)
				targetBackdrop:SetInheritScale(false)
				targetBackdrop:SetDrawLayer(0)
				targetBackdrop:SetDrawLevel(0)
				targetBackdrop:SetDrawTier(0)
				targetBackdrop:SetAnchor(TOPLEFT,		control, TOPLEFT,		x_1, y_1)
				targetBackdrop:SetAnchor(BOTTOMRIGHT,	control, BOTTOMRIGHT,	x_2, y_2)
				targetBackdrop:SetCenterTexture(tex, size, mod)
				targetBackdrop:SetCenterColor(c_r/255, c_g/255, c_b/255, c_a)
				targetBackdrop:SetEdgeTexture(nil, 1, 1, 1, 0)
				targetBackdrop:SetEdgeColor(edge_r/255, edge_g/255, edge_b/255, edge_a)
				-- targetBackdrop:SetInsets(1, 1, -1, -1)
	end
end

PP.ListDivider = function(control, x_1, y_1, x_2, y_2, --[[tex]] tex, size, mod, --[[bd]] c_r, c_g, c_b, c_a, --[[edge]] edge_r, edge_g, edge_b, edge_a)
	if not control:GetNamedChild("Backdrop") then
			CreateControl(control:GetName() .. "Backdrop", control, CT_BACKDROP)
				local targetBackdrop = control:GetNamedChild("Backdrop")
				targetBackdrop:SetPixelRoundingEnabled(false)
				targetBackdrop:SetInheritAlpha(false)
				targetBackdrop:SetInheritScale(false)
				targetBackdrop:SetDrawLayer(0)
				targetBackdrop:SetDrawLevel(0)
				targetBackdrop:SetDrawTier(0)
				targetBackdrop:SetAnchor(TOPLEFT,		control, TOPLEFT,		x_1, y_1)
				targetBackdrop:SetAnchor(BOTTOMRIGHT,	control, BOTTOMRIGHT,	x_2, y_2)
				targetBackdrop:SetCenterTexture(tex, size, mod)
				targetBackdrop:SetCenterColor(c_r/255, c_g/255, c_b/255, c_a)
				targetBackdrop:SetEdgeTexture(nil, 1, 1, 1, 0)
				targetBackdrop:SetEdgeColor(edge_r/255, edge_g/255, edge_b/255, edge_a)
				targetBackdrop:SetInsets(1, 1, -1, -1)
	end
end

PP.Anchor = function(targetControl, --[[#1]] point_1, anchorTargetControl_1, relativePoint_1, x_1, y_1, --[[#2]] toggle, point_2, anchorTargetControl_2, relativePoint_2, x_2, y_2)
	local parent = targetControl:GetParent()
	local an = targetControl
		an:ClearAnchors()
		an:SetAnchor( point_1 or TOPLEFT, anchorTargetControl_1 or parent, relativePoint_1 or TOPLEFT, x_1 or 0, y_1 or 0)
		if toggle then
			an:SetAnchor( point_2 or BOTTOMRIGHT, anchorTargetControl_2 or parent, relativePoint_2 or BOTTOMRIGHT, x_2 or 0, y_2 or 0) 
		end
end

PP.Font = function(targetControl, --[[Font]] font, size, outline, --[[Alpha]] a, --[[Color]] c_r, c_g, c_b, c_a, --[[StyleColor]] sc_r, sc_g, sc_b, sc_a)
	targetControl:SetFont(string.format("%s|%s|%s", font, size, outline))
	if a then
		targetControl:SetAlpha(a)
	elseif c_r and c_g and c_b and c_a then
		targetControl:SetColor(c_r/255, c_g/255, c_b/255, c_a)
	elseif sc_r and sc_g and sc_b and sc_a then
		targetControl:SetStyleColor(sc_r/255, sc_g/255, sc_b/255, sc_a)
	end
end

PP.ScrollBar = function(control, --[[sb_c]] sb_r, sb_g, sb_b, sb_a, --[[bd]] c_r, c_g, c_b, c_a, --[[edge]] edge_r, edge_g, edge_b, edge_a)
	if not control.scrollbar then
		control = control:GetParent()
	end
	local sb, up, down	= control.scrollbar, control.upButton or control.scrollUpButton, control.downButton or control.scrollDownButton
	local contents		= control.contents
	local parent	= control:GetParent():GetParent()
	if parent == GuiRoot then
		parent = control:GetParent()
	end
	sb:GetNamedChild('Up'):SetHidden(true)
	sb:GetNamedChild('Down'):SetHidden(true)
	sb:SetInheritAlpha(false)
	sb:SetBackgroundTopTexture(nil)
	sb:SetBackgroundMiddleTexture(nil)
	sb:SetBackgroundBottomTexture(nil)
	sb:SetThumbTexture(nil, nil, nil, 4)
	sb:SetColor( sb_r/255, sb_g/255, sb_b/255, sb_a)
	sb:SetWidth(14)
	sb:ClearAnchors()
	sb:SetAnchor(TOPLEFT, nil, TOPRIGHT, 0, 3)
	sb:SetAnchor(BOTTOMLEFT, nil, BOTTOMRIGHT, -16, -3)
	sb:SetAlpha(sb_a)

	if not sb:GetNamedChild('_BG') then
		local bg = CreateControl(sb:GetName() .. "_BG", sb:GetNamedChild('ThumbMunge'), CT_BACKDROP)
		-- local bg = CreateControl(sb:GetName() .. "_BG", sb:GetParent(), CT_BACKDROP)
		bg:SetPixelRoundingEnabled(false)
		bg:SetInheritAlpha(false)
		bg:SetInheritScale(false)
		bg:SetDrawLayer(0)
		bg:SetDrawLevel(0)
		bg:SetDrawTier(0)
		bg:SetAnchor(TOPLEFT, sb, TOPLEFT, 2, -3)
		bg:SetAnchor(BOTTOMRIGHT, sb, BOTTOMRIGHT, -2, 3)
		bg:SetCenterTexture(nil, 4, 0)
		bg:SetCenterColor(c_r/255, c_g/255, c_b/255, c_a)
		bg:SetEdgeTexture(nil, 1, 1, 1, 0)
		bg:SetEdgeColor(edge_r/255, edge_g/255, edge_b/255, edge_a)
		bg:SetInsets(1, 1, -1, -1)
	end

	sb["alphaAnimation"] = nil
	sb["timeline"] = nil

	if contents then
		local flag = nil
		ZO_PreHookHandler(parent, 'OnShow', function()
			if flag then return end
			if sb:IsHidden() then
				PP.Anchor(contents, --[[#1]] TOPLEFT, nil, TOPLEFT, 0, 0, --[[#2]] true, BOTTOMRIGHT, nil, BOTTOMRIGHT, -4, 0)
			else
				PP.Anchor(contents, --[[#1]] TOPLEFT, nil, TOPLEFT, 0, 0, --[[#2]] true, BOTTOMRIGHT, nil, BOTTOMRIGHT, -16, 0)
			end
			flag = true
			-- d(parent:GetName())
		end)
		ZO_PreHookHandler(sb, 'OnShow', function()
			PP.Anchor(contents, --[[#1]] TOPLEFT, nil, TOPLEFT, 0, 0, --[[#2]] true, BOTTOMRIGHT, nil, BOTTOMRIGHT, -16, 0)
			-- d("Show")
		end)
		ZO_PreHookHandler(sb, 'OnHide', function()
			PP.Anchor(contents, --[[#1]] TOPLEFT, nil, TOPLEFT, 0, 0, --[[#2]] true, BOTTOMRIGHT, nil, BOTTOMRIGHT, -4, 0)
			-- d("Hide")
		end)
	end
end

PP.search_results = nil
--[[
PP.Searcher(GuiRoot, 'Tabs', function()
		d(PP.search_results:GetName())
end)
]]--
PP.Searcher = function(control, searched, func)
	for i = 1, control:GetNumChildren() do
		if control:GetChild(i) then
			if (control:GetNumChildren() ~= 0) then
				PP.Searcher(control:GetChild(i), searched, func)
			end
			if control:GetNamedChild(searched) ~= nil then
				PP.search_results = control:GetNamedChild(searched)
				func()
				return
			end
		end
	end
end

--[[
/script
PP.Search(GuiRoot, '.*TabsActive', function(control)
	d(control)
end)
]]--
PP.Search = function(control, searched, func)
	local flag = nil
	local function search(control)
		local num = control:GetNumChildren()
		for i = 1, num do
			local child = control:GetChild(i)
			if child then
				local found = string.match(child:GetName(), searched)
				if found and ( flag ~= found )then
					flag = found
					func(GetControl(found))
				end				
				if num ~= 0 then
					search(child)
				end
			end
		end
	end
	search(control)
end









