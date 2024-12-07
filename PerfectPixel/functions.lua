local PP		= PP
local SM		= SCENE_MANAGER
local tinsert	= table.insert

-- media
PP.backgrounds = {}
PP.backgroundsHiddenForScene = {}

--[[colors
def2 = ( 197, 194, 158 )
def = ( 173, 166, 132 )
red = ( 222, 36, 33 )
over = ( 232, 232, 184 )
96/255, 125/255, 139/255
]]
-- functions
-- PP.AllowedDataTypeIds = {[1] = true, [2] = true, [3] = true}
-- function PP.СheckAllowedDataTypeId(typeId)
	-- return self.AllowedDataTypeIds[typeId]
-- end
function PP:AddNewSavedVars(version, namespace, defaults)
	local SV = self.savedVars

	if not SV[namespace] then
		SV[namespace] = ZO_SavedVars:NewAccountWide(self.ADDON_NAME, version, namespace, defaults, GetWorldName())
	end

	return SV[namespace], SV[namespace].default
end

function PP:GetSavedVars(namespace)
	local SV = self.savedVars[namespace]

	if not SV then return SV end

	return SV, SV.default
end

function PP.Dummy() end
local Dummy = PP.Dummy

function PP.PostHooksSetupCallback(list, mode, typeId, onCreateFn, onUpdateFn)
	local dataType = list.dataTypes[typeId]
	if not dataType then return end

	local pool				= dataType.pool
	local _hooks			= dataType.hooks
	local _customFactory	= pool.customFactoryBehavior
	local _setupCallback	= dataType.setupCallback

	if not _hooks then
		dataType.hooks = {}
		for m = 1, 3 do
			dataType.hooks[m] = {
				OnCreate	= Dummy,
				OnUpdate	= Dummy,
			}
		end

		local hooks = dataType.hooks

		if _customFactory then
			pool.customFactoryBehavior = function(...)
				_customFactory(...)
				hooks[list.mode].OnCreate(...)
			end
		else
			pool.customFactoryBehavior = function(...)
				hooks[list.mode].OnCreate(...)
			end
		end

		dataType.setupCallback = function(...)
			_setupCallback(...)
			hooks[list.mode].OnUpdate(...)
		end

		if onCreateFn then
			hooks[mode].OnCreate = onCreateFn
		end

		if onUpdateFn then
			hooks[mode].OnUpdate = onUpdateFn
		end
	elseif _hooks then
		local exOnCreate = _hooks[mode].OnCreate
		local exOnUpdate = _hooks[mode].OnUpdate

		if onCreateFn then
			if exOnCreate == Dummy then
				_hooks[mode].OnCreate = onCreateFn
			else
				_hooks[mode].OnCreate = function(...)
					exOnCreate(...)
					onCreateFn(...)
				end
			end
		end

		if onUpdateFn then
			if exOnUpdate == Dummy then
				_hooks[mode].OnUpdate = onUpdateFn
			else
				_hooks[mode].OnUpdate = function(...)
					exOnUpdate(...)
					onUpdateFn(...)
				end
			end
		end
	end
end

local TLW_BG = CreateTopLevelWindow(nil)
TLW_BG:SetDrawLayer(0)
TLW_BG:SetDrawLevel(0)
TLW_BG:SetDrawTier(0)

PP.TLW_BG = TLW_BG

function PP:CreateBackground(parent, --[[#1]] point1, relTo1, relPoint1, x1, y1, --[[#2]] point2, relTo2, relPoint2, x2, y2, namespace, width, height)
	local namespace		= namespace or 'WindowStyle'
	local sv			= self:GetSavedVars(namespace)
	local insets		= sv.skin_backdrop_insets
	local parent		= parent
	local bg
	local exBG

	self.lastInsets = sv.skin_backdrop_insets

	if parent.PP_BG then return end

	if parent:GetType() == CT_BACKDROP then
		bg		= parent
		parent	= parent:GetParent()
		exBG	= true
	else
		bg		= CreateControl(parent:GetName() .. "_PP_BG", self.TLW_BG, CT_BACKDROP)
		bg:SetHidden(true)
	end

	bg:SetAnchor(point1 or TOPLEFT,		relTo1 or parent,	relPoint1 or TOPLEFT,		(x1 or 0) - insets, (y1 or 0) - insets)
	if width == nil and height == nil then
		bg:SetAnchor(point2 or BOTTOMRIGHT,	relTo2 or parent,	relPoint2 or BOTTOMRIGHT,	(x2 or 0) + insets, (y2 or 0) + insets)
	end

	bg:SetCenterTexture(sv.skin_backdrop, sv.skin_backdrop_tile_size, sv.skin_backdrop_tile and 1 or 0)
	bg:SetCenterColor(unpack(sv.skin_backdrop_col))
	bg:SetInsets(insets, insets, -insets, -insets)
	bg:SetEdgeTexture(sv.skin_edge, sv.skin_edge_file_width, sv.skin_edge_file_height, sv.skin_edge_thickness, 0)
	bg:SetEdgeColor(unpack(sv.skin_edge_col))
	bg:SetIntegralWrapping(sv.skin_edge_integral_wrapping)

	if width ~= nil and height ~= nil then
		bg:SetDimensions(width, height)
	else
		if width ~= nil then
			bg:SetWidth(width)
		elseif height ~= nil then
			bg:SetHeigt(height)
		end
	end

	parent.PP_BG = bg

	if not self.backgrounds[namespace] then
		self.backgrounds[namespace] = {}
	end
	table.insert(self.backgrounds[namespace], bg)

	if exBG then return end

	ZO_PreHookHandler(parent, 'OnEffectivelyShown', function(self, bool)
		local bg		= self.PP_BG
		local isValid	= PP.backgroundsHiddenForScene[bg]
		local isHide	= isValid and isValid[SM:GetCurrentScene()]

		bg:SetHidden(isHide or bool)
	end)
	ZO_PreHookHandler(parent, 'OnEffectivelyHidden', function(self, bool)
		self.PP_BG:SetHidden(bool)
	end)
end

function PP:UpdateBackgrounds(namespace)
	local namespace		= namespace or 'WindowStyle'
	local sv			= self:GetSavedVars(namespace)
	local backgrounds	= self.backgrounds[namespace]
	local insets		= sv.skin_backdrop_insets
	local normInsets	= self.lastInsets - insets

	self.lastInsets	= insets

	if not backgrounds then return end

	for i = 1, #backgrounds do
		local bg = backgrounds[i]

		local --[[#1]] get1_isA, p1, rTo1, rp1, x1, y1 = bg:GetAnchor(0)
		local --[[#2]] get2_isA, p2, rTo2, rp2, x2, y2 = bg:GetAnchor(1)

		bg:ClearAnchors()
		bg:SetAnchor(p1, rTo1, rp1, x1 + normInsets, y1 + normInsets)
		bg:SetAnchor(p2, rTo2, rp2, x2 - normInsets, y2 - normInsets)

		bg:SetCenterTexture(sv.skin_backdrop, sv.skin_backdrop_tile_size, sv.skin_backdrop_tile and 1 or 0)
		bg:SetCenterColor(unpack(sv.skin_backdrop_col))
		bg:SetInsets(insets, insets, -insets, -insets)
		bg:SetEdgeTexture(sv.skin_edge, sv.skin_edge_file_width, sv.skin_edge_file_height, sv.skin_edge_thickness, 0)
		bg:SetEdgeColor(unpack(sv.skin_edge_col))
		bg:SetIntegralWrapping(sv.skin_edge_integral_wrapping)
	end
end

function PP:HideBackgroundForScene(scene, pp_bg)
	if not self.backgroundsHiddenForScene[pp_bg] then
		self.backgroundsHiddenForScene[pp_bg] = {}
	end

	self.backgroundsHiddenForScene[pp_bg][scene] = true
end

function PP:ForceRemoveFragment(scene, targetFragment)
	local existingFn = scene.AddFragment
	function scene:AddFragment(fragment, ...)
		if fragment == targetFragment then
			return
		else
			existingFn(self, fragment, ...)
		end
	end
	scene:RemoveFragment(targetFragment)
end

function PP:SetLockFn(object, fnName)
	local exFn		= object[fnName]
	local marker	= '_' .. fnName

	if object[marker] then return end

	object[marker]	= exFn
	object[fnName] = function(...) end
end

function PP:CallLockFn(object, fnName, ...)
	local marker	= '_' .. fnName
	local fn		= object[marker]
	if fn then
		fn(object, ...)
	end
end


-- CallLockFn
---------------------------------------------------------------------------------------------------
-- SCENE_FRAGMENT_SHOWN		= "shown"
-- SCENE_FRAGMENT_HIDDEN	= "hidden"
-- SCENE_FRAGMENT_SHOWING	= "showing"
-- SCENE_FRAGMENT_HIDING	= "hiding"
-- SCENE_SHOWN				= "shown"
-- SCENE_HIDDEN				= "hidden"
-- SCENE_SHOWING			= "showing"

--(3)--TOPLEFT		(1)---TOP		(9)---TOPRIGHT
--(2)--LEFT			(128)-CENTER	(8)---RIGHT
--(6)--BOTTOMLEFT	(4)---BOTTOM	(12)--BOTTOMRIGHT

-- isValid, point, relTo, relPoint, offsX, offsY, constraints = control:GetAnchor(anchorIndex)

-- Another stupidity from ZoS. -- SetAnchorOffsets > anchorIndex = 1, 2 | GetAnchor() > anchorIndex = 0, 1 
PP.Anchor = function(control, --[[#1]] set1_p, set1_rTo, set1_rp, set1_x, set1_y, --[[#2]] toggle, set2_p, set2_rTo, set2_rp, set2_x, set2_y)
	local --[[#1]] get1_isA, get1_p, get1_rTo, get1_rp, get1_x, get1_y = control:GetAnchor(0)
	local --[[#2]] get2_isA, get2_p, get2_rTo, get2_rp, get2_x, get2_y = control:GetAnchor(1)
	control:ClearAnchors()
	control:SetAnchor(set1_p or get1_p, set1_rTo or get1_rTo, set1_rp or get1_rp, set1_x or get1_x, set1_y or get1_y)
	if toggle then
		control:SetAnchor(set2_p or get2_p, set2_rTo or get2_rTo, set2_rp or get2_rp, set2_x or get2_x, set2_y or get2_y)
	end
end
local PP_Anchor = PP.Anchor

--outline, thick-outline, soft-shadow-thin, soft-shadow-thick, shadow
PP.Font = function(control, --[[Font]] font, size, outline, --[[Alpha]] a, --[[Color]] c_r, c_g, c_b, c_a, --[[StyleColor]] sc_r, sc_g, sc_b, sc_a)
	if not control then
		return
	end
	if font then
		control:SetFont(string.format("%s|%s|%s", font, size, outline))
	end
	if a then
		control:SetAlpha(a)
	end
	if c_r and c_g and c_b and c_a then
		control:SetColor(c_r/255, c_g/255, c_b/255, c_a)
	end
	if sc_r and sc_g and sc_b and sc_a then
		control:SetStyleColor(sc_r/255, sc_g/255, sc_b/255, sc_a)
	end
end
local PP_Font = PP.Font

PP.ListBackdrop = function(control, x_1, y_1, x_2, y_2, --[[tex]] tex, size, mod, --[[bd]] c_r, c_g, c_b, c_a, --[[edge]] edge_r, edge_g, edge_b, edge_a, --[[e_tex]] e_tex, e_t)
	if not control:GetNamedChild("Backdrop") then
		local targetBackdrop = CreateControl(control:GetName() .. "Backdrop", control, CT_BACKDROP)
		targetBackdrop:SetDrawLayer(0)
		targetBackdrop:SetDrawLevel(0)
		targetBackdrop:SetDrawTier(0)
		targetBackdrop:SetAnchor(TOPLEFT,		control, TOPLEFT,		x_1, y_1)
		targetBackdrop:SetAnchor(BOTTOMRIGHT,	control, BOTTOMRIGHT,	x_2, y_2)
		targetBackdrop:SetCenterTexture(tex, size, mod)
		targetBackdrop:SetCenterColor(c_r/255, c_g/255, c_b/255, c_a)
		targetBackdrop:SetEdgeTexture(e_tex or nil, 128, 16, e_t or 1, 0)
		targetBackdrop:SetEdgeColor(edge_r/255, edge_g/255, edge_b/255, edge_a)
		-- targetBackdrop:SetInsets(1, 1, -1, -1)
	end
end

----------------------------------
PP.CreateBackdrop = function(control)
	if control.backdrop then return control.backdrop end

	local backdrop = CreateControl("$(parent)Backdrop", control, CT_BACKDROP)

	backdrop:SetAnchorFill(control)
	backdrop:SetDrawTier(0)

	control.backdrop = backdrop

	return backdrop
end

local function offset(slider, hidden)
	local contents = slider:GetParent().contents
	if contents == nil then return end
	if hidden then
		PP_Anchor(contents, --[[#1]] TOPLEFT, nil, TOPLEFT, 0, 0, --[[#2]] true, BOTTOMRIGHT, nil, BOTTOMRIGHT, -6, 0)
	else
		PP_Anchor(contents, --[[#1]] TOPLEFT, nil, TOPLEFT, 0, 0, --[[#2]] true, BOTTOMRIGHT, nil, BOTTOMRIGHT, -15, 0)
	end
end


PP.ScrollBar = function(control)
	local slider	= control:GetType() == CT_SLIDER and control or control.scrollbar or control:GetParent().scrollbar
	local sb		= slider
	local up		= slider:GetNamedChild("Up")	or slider:GetNamedChild("ScrollUp")
	local down		= slider:GetNamedChild("Down")	or slider:GetNamedChild("ScrollDown")
	local thumb		= slider:GetThumbTextureControl()
	local contents	= slider:GetParent().contents
	local tex		= "PerfectPixel/tex/tex_white.dds"

	up:SetHidden(true)
	down:SetHidden(true)

	sb:SetBackgroundMiddleTexture(tex) --(string fileName, number texTop, number texLeft, number texBottom, number texRight)
	sb:SetBackgroundTopTexture(nil)
	sb:SetBackgroundBottomTexture(nil)
	sb:SetColor(50/255, 50/255, 50/255, 1)
	sb:ClearAnchors()
	sb:SetAnchor(TOPLEFT, nil, TOPRIGHT, 0, 0)
	sb:SetAnchor(BOTTOMLEFT, nil, BOTTOMRIGHT, -10, 0)
	sb:SetAlpha(0.6)
	sb:SetHitInsets(-4, 0, 5, 0)
	sb:SetWidth(4)
	sb.thumb = thumb

	thumb:SetWidth(4)
	thumb:SetTexture(tex)	--(string filename, string disabledFilename, string highlightedFilename, number thumbWidth, number thumbHeight, number texTop, number texLeft, number texBottom, number texRight)
	thumb:SetColor(120/255, 120/255, 120/255, 1)
	thumb:SetHitInsets(-4, 0, 5, 0)

	if not contents then return end


	offset(sb, true)

	ZO_PreHookHandler(sb, 'OnEffectivelyShown', function()
		offset(sb, false)
	end)
	ZO_PreHookHandler(sb, 'OnEffectivelyHidden', function()
		offset(sb, true)
	end)

end

PP.Bar = function(control, --[[height]] height, --[[fontSize]] fSize, bgEdgeColor, glowEdgeColor, reAnchorText)
	local bar		= control
	local barText	= control:GetNamedChild("Progress")
	local bg		= control:GetNamedChild("BG")
	local overlay	= control:GetNamedChild("Overlay")
	local gloss		= control:GetNamedChild("Gloss")
	local glow		= control:GetNamedChild("GlowContainer")
	local glowC		= control:GetNamedChild("GlowContainerCenter")
	local glowL		= control:GetNamedChild("GlowContainerLeft")
	local glowR		= control:GetNamedChild("GlowContainerRight")

	if glow then
		glowC:SetHidden(true)
		glowL:SetHidden(true)
		glowR:SetHidden(true)

		if not glow:GetNamedChild("Backdrop") then
			local glowBG = CreateControl("$(parent)Backdrop", glow, CT_BACKDROP)
			glowBG:SetCenterTexture(nil, 8, 0)
			glowBG:SetCenterColor(0/255, 0/255, 0/255, 0)
			glowBG:SetEdgeTexture(nil, 1, 1, 1, 0)
			glowBG:SetEdgeColor(173/255, 166/255, 132/255, 1)
			PP_Anchor(glowBG, --[[#1]] TOPLEFT, bar, TOPLEFT, -3, -3, --[[#2]] true, BOTTOMRIGHT, bar, BOTTOMRIGHT, 3, 3)
		end
	end

	if barText then
		PP_Font(barText, --[[Font]] PP.f.u67, fSize, "outline", --[[Alpha]] nil, --[[Color]] nil, nil, nil, nil, --[[StyleColor]] 0, 0, 0, 0.5)
	end

	bg:SetHidden(true)
	overlay:SetHidden(true)

	bar:SetHeight(height)
	bar:SetTexture(nil)
	bar:SetLeadingEdge(nil)
	bar:EnableLeadingEdge(false)
	gloss:SetTexture(nil)
	gloss:SetLeadingEdge(nil)
	gloss:EnableLeadingEdge(false)
	gloss:SetColor(0/255, 0/255, 0/255, 0.1)

--
	if not control:GetNamedChild("Backdrop") then
		local barBG = CreateControl("$(parent)Backdrop", control, CT_BACKDROP)

		PP_Anchor(barBG, --[[#1]] TOPLEFT, control, TOPLEFT, -2, -2, --[[#2]] true, BOTTOMRIGHT, control, BOTTOMRIGHT,	2, 2)
		barBG:SetCenterTexture(nil, 8, 0)
		barBG:SetCenterColor(10/255, 10/255, 10/255, 0.8)
		barBG:SetEdgeTexture(nil, 1, 1, 1, 0)
		barBG:SetEdgeColor(60/255, 60/255, 60/255, 0.9)
		barBG:SetInsets(-1, -1, 1, 1)
	end
end
local PP_bar = PP.Bar

PP.Bars = function(progressBarsOverviewContainer --[[parentControl]], isProgressBarPassedIn, height, fontSize, bgEdgeColor, glowEdgeColor, reAnchorText)
	isProgressBarPassedIn = isProgressBarPassedIn or false
	--Change all child control Progressbars at progressBarsOverviewContainer
	for i=1, progressBarsOverviewContainer:GetNumChildren(), 1 do
		local childCtrl = progressBarsOverviewContainer:GetChild(i)
		if childCtrl ~= nil then
			local progressBar = childCtrl:GetNamedChild("Progress") or childCtrl:GetNamedChild("ProgressBar")
			if progressBar ~= nil then
				PP_bar((isProgressBarPassedIn == true and progressBar) or childCtrl,
				--[[height]] height or 14,
				--[[fontSize]] fontSize or 15,
						bgEdgeColor,
						glowEdgeColor,
						reAnchorText
				)
			end
		end
	end
end

PP.ResetStyle = function()
	for _, list in ipairs(PP.TabList) do
		for typeId in pairs(list.dataTypes) do
			if typeId == 1 or typeId == 2 or typeId == 3 then
				local dataType = ZO_ScrollList_GetDataTypeTable(list, typeId)
				local pool = dataType.pool

				if dataType.height then
					dataType.height = PP.savedVars.ListStyle.list_control_height
				end

				if list.mode == 3 then return end

				for _, control in pairs(pool.m_Free) do
					dataType.hooks[list.mode].OnCreate(control)
				end
				for _, control in pairs(pool.m_Active) do
					dataType.hooks[list.mode].OnCreate(control)
				end
			end
		end

		if list.uniformControlHeight then
			list.uniformControlHeight = PP.savedVars.ListStyle.list_uniform_control_height
		end
		if list.useFadeGradient then
			ZO_Scroll_SetMaxFadeDistance(list, PP.savedVars.ListStyle.list_fade_distance)
		end
	end
	PLAYER_INVENTORY:UpdateList(INVENTORY_BACKPACK)
	ZO_ScrollList_Commit(ZO_PlayerInventoryList)

	ZO_Scroll_SetMaxFadeDistance(ZO_LootAlphaContainerList, PP.savedVars.ListStyle.list_fade_distance)
	ZO_LootAlphaContainerList.uniformControlHeight = PP.savedVars.ListStyle.list_uniform_control_height

	ZO_Scroll_SetMaxFadeDistance(MAIL_INBOX.navigationTree.scrollControl, PP.savedVars.ListStyle.list_fade_distance)

	if not TRADING_HOUSE.searchResultsList then return end
	ZO_Scroll_SetMaxFadeDistance(TRADING_HOUSE.searchResultsList, PP.savedVars.ListStyle.list_fade_distance)
end

PP.Hook_m_Factory = function(dataType, callback)
	local pool = dataType.pool
	local exFactory = pool.m_Factory

	pool.m_Factory = function(objectPool)
		local object = exFactory(objectPool)
		callback(object)
		return object
	end
end

PP.Hook_SetupCallback = function(dataType, callback)
	local exSetupCallback = dataType.setupCallback
	dataType.setupCallback = function(control, data)
		exSetupCallback(control, data)
		callback(control, data)
	end
end

--
local stateColor = {
	[BSTATE_NORMAL]           = { 173 / 255, 166 / 255, 132 / 255, 1 },        --BSTATE_NORMAL
	[BSTATE_PRESSED]          = { 220 / 255, 220 / 255, 220 / 255, 1 },        --BSTATE_PRESSED
	[BSTATE_DISABLED]         = { 173 / 255 * 0.5, 166 / 255 * 0.5, 132 / 255 * 0.5, 1 }, --BSTATE_DISABLED_PRESSED
	[BSTATE_DISABLED_PRESSED] = { 220 / 255 * 0.5, 220 / 255 * 0.5, 220 / 255 * 0.5, 1 }, --BSTATE_DISABLED
}

function PP:CreateAnimatedButton(parent, --[[#1]] point1, relTo1, relPoint1, x1, y1, texture, height, width, tooltipText, sv, fn)
	local control		= CreateControl(nil, parent, CT_CONTROL)
	local over			= CreateControl(nil, control, CT_TEXTURE)
	local checkBox		= CreateControl(nil, control, CT_TEXTURE)
	parent.control		= control
	control.over		= over
	control.checkBox	= checkBox

	control:SetAnchor(point1 or CENTER, relTo1 or parent, relPoint1 or CENTER, x1 or 0, y1 or 0)
	control:SetDimensions(height, width)
	control:SetMouseEnabled(true)

	over:SetAnchorFill(control)
	over:SetTexture("PerfectPixel/tex/GradientDown.dds")
	over:SetColor(1, 1, 1, 1)
	over:SetAlpha(0)

	checkBox:SetPixelRoundingEnabled(false)
	checkBox:SetAnchor(CENTER)
	checkBox:SetDimensions(height, width)
	checkBox:SetTexture(texture)
	checkBox:SetColor(unpack(stateColor[BSTATE_NORMAL]))

	--anim--
	local animation, timeline	= CreateSimpleAnimation(ANIMATION_SCALE, checkBox)
	checkBox.timeline			= timeline
	animation:SetStartScale(1)
	animation:SetEndScale(0.8)
	animation:SetDuration(100)
	--anim--

	function control:SetState(checkState)
		local checkBox			= self.checkBox
		local checkStateType	= type(checkState)
		local state				= false

		if checkStateType == "boolean" then
			state = checkState and BSTATE_PRESSED or BSTATE_NORMAL
		elseif checkStateType == "number" then
			state = checkState
		end

		local r, g, b, a = unpack(stateColor[state])
		checkBox:SetColor(r, g, b, a)
		control:SetMouseEnabled(true)

		if state == BSTATE_DISABLED or state == BSTATE_DISABLED_PRESSED then
			control:SetMouseEnabled(false)
		end
	end

	function control:SetToggleFunction(fn)
		self.toggleFunction = fn
	end

	control:SetHandler("OnMouseEnter", function(self)
		self.over:SetAlpha(0.2)

		if not self.tooltipText then return end
		InitializeTooltip(InformationTooltip, control, BOTTOM, 0, -10)
		SetTooltipText(InformationTooltip, self.tooltipText)
	end)
	control:SetHandler("OnMouseExit", function(self)
		self.over:SetAlpha(0)

		if not self.tooltipText then return end
		ClearTooltip(InformationTooltip)
	end)
	control:SetHandler("OnMouseDown", function(self, button)
		self.checkBox.timeline:PlayForward()
	end)
	control:SetHandler("OnMouseDoubleClick", control:GetHandler("OnMouseDown"))
	control:SetHandler("OnMouseUp", function(self, button, upInside)
		local state = self.toggleFunction()
		self:SetState(state)
		self.checkBox.timeline:PlayBackward()
		PlaySound(SOUNDS.DEFAULT_CLICK)
	end)

	if tooltipText then
		control.tooltipText = tooltipText
	end

	if sv == nil then
		control:SetState(parent:GetState())
		local orig_SetState = parent.SetState
		function parent:SetState(newState, locked)
			orig_SetState(self, newState, locked)
			control:SetState(newState)
		end
		control:SetToggleFunction(function()
			ZO_CheckButton_OnClicked(parent)
			return ZO_CheckButton_IsChecked(parent)
		end)
	else
		control:SetState(sv)
		control:SetToggleFunction(fn)
	end

	return control
end

-- Function to remove fragments from a scene
local removeFragmentsFromScene = function(scene, fragments)
	for _, fragment in ipairs(fragments) do
	  scene:RemoveFragment(fragment)
	end
end

PP.removeFragmentsFromScene = removeFragmentsFromScene

--Added with API101043 - ZOs uses more and more DeferredInitialization meanwhile so we craete a wrapper function for that
local postHookedOnDeferredInitControls = {}
function PP.onDeferredInitCheck(object, callbackFunc, preCheckFunc)
	if callbackFunc == nil then return end
	--PreCheck funtion is needed?
	local doNow = true
	if type(preCheckFunc) == "function" then
		doNow = preCheckFunc(object)
	end
	if not doNow then return end

	--No deferred init available? Run callback directly
	if object ~= nil then
		if object.OnDeferredInitialize == nil then
			callbackFunc(object)
		else
			if not postHookedOnDeferredInitControls[object] then
				SecurePostHook(object, "OnDeferredInitialize", function(...) callbackFunc(object, ...) end)
				postHookedOnDeferredInitControls[object] = true
			end
		end
	end
end

-- Another stupidity from ZoS. -- GetUIMouseDeltas() does not work correctly at high frame rates.
function PP.SetMovableControl(targetControl, movableControl, --[[table > pos.x and pos.y]] pos)
	local m_lastPosX, m_lastPosY

	targetControl:SetMouseEnabled(true)

	local function UpdatePosition()
		local m_posX, m_posY = GetUIMousePosition()
		local deltaX, deltaY = m_posX - m_lastPosX, m_posY - m_lastPosY

		m_lastPosX, m_lastPosY = m_posX, m_posY

		pos.x, pos.y = pos.x + deltaX, pos.y + deltaY

		movableControl:SetAnchorOffsets(pos.x, pos.y, 1)
	end

	ZO_PreHookHandler(targetControl, "OnMouseDown", function(self, ...)
		m_lastPosX, m_lastPosY = GetUIMousePosition()
		self:SetHandler("OnUpdate", UpdatePosition)
	end)

	ZO_PreHookHandler(targetControl, "OnMouseUp", function(self, ...)
		self:SetHandler("OnUpdate", nil)
	end)
end

function PP.GetLinks(tlc, children)
	local cache = {}

	for k, name in ipairs(children) do
		for i = 1, #name do
			local control = tlc:GetNamedChild(name[i])
			-- local control = GetControl(tlc, name[i])

			cache[k] = control or false

			-- if control == nil then
				-- d('|cff0000 not found ->| ' .. name[i])
			-- else
				-- d(control:GetName())
			-- end

			if control then break end
		end
	end

	return tlc, unpack(cache)
end

function PP:SetLayoutLinks()
	for _, t1 in pairs(self.layouts) do
		for k2, t2 in pairs(t1) do
			if k2 ~= 'default' then
				local def = t1.default
				setmetatable(t2, {__index = def})
				-- for k3, t3 in pairs(t2) do
					-- setmetatable(t3, {__index = def[k3]})
				-- end
			end
		end
	end
end

function PP:AddNewLayout(name, data)
	self.layouts[name] = data
	
	PP:SetLayoutLinks()
end

function PP:GetLayout(name, extra)
	local layout = PP.layouts[name]

	return layout[extra] or layout.default
end

--InfoBar----------------------------------------
local function fn(label)
	label:SetHeight(32)
	label:SetVerticalAlignment(TEXT_ALIGN_CENTER)
	PP_Font(label, --[[Font]] PP.f.u67, 18, "outline", --[[Alpha]] nil, --[[Color]] nil, nil, nil, nil, --[[StyleColor]] 0, 0, 0, 0.6)
	PP:SetLockFn(label, 'SetFont')
end

function PP:RefreshStyle_InfoBar(infoBar, layout)
	local divider	= infoBar:GetNamedChild("Divider")
	local slots		= infoBar:GetNamedChild("FreeSlots")
	local altSlots	= infoBar:GetNamedChild("AltFreeSlots")
	local money		= infoBar:GetNamedChild("Money")
	local altMoney	= infoBar:GetNamedChild("AltMoney")
	local retrait	= infoBar:GetNamedChild("RetraitCurrency")
	local currency1	= infoBar:GetNamedChild("Currency1")
	local currency2	= infoBar:GetNamedChild("Currency2")
	local layout	= layout or { infoBar_y = 6 }
	
	PP_Anchor(infoBar, --[[#1]] TOPLEFT, nil, BOTTOMLEFT, 0, layout.infoBar_y, --[[#2]] true, TOPRIGHT, nil, BOTTOMRIGHT, 0, layout.infoBar_y)

	if divider and divider:GetType() == CT_CONTROL then
		divider:SetHidden(true)
	end
	if slots and slots:GetType() == CT_LABEL then
		PP_Anchor(slots,	--[[#1]] TOPLEFT,	nil, TOPLEFT, 0, 0)
		fn(slots)
	end
	if altSlots and altSlots:GetType() == CT_LABEL then
		PP_Anchor(altSlots, --[[#1]] LEFT,	nil, RIGHT, 16, 0)
		fn(altSlots)
	end
	if money and money:GetType() == CT_LABEL then
		PP_Anchor(money,	--[[#1]] TOPRIGHT,	nil, TOPRIGHT, -4, 0)
		fn(money)
	end
	if altMoney and altMoney:GetType() == CT_LABEL then
		PP_Anchor(altMoney,	--[[#1]] RIGHT,	nil, LEFT, -16, 0)
		fn(altMoney)
	end
	if retrait and retrait:GetType() == CT_LABEL then
		fn(retrait)
	end
	if currency1 and currency1:GetType() == CT_LABEL then
		fn(currency1)
	end
	if currency2 and currency2:GetType() == CT_LABEL then
		fn(currency2)
	end
end

--ZO_MenuBar
function PP:RefreshStyle_MenuBar(menuBar, layout)
	local menuBar	= menuBar.m_object and menuBar or menuBar:GetNamedChild('Bar')
	local m_object	= menuBar.m_object
	
	m_object.m_animationDuration	= layout.duration
	m_object.m_normalSize			= layout.nSize
	m_object.m_downSize				= layout.dSize
	-- m_object.m_buttonPadding		= layout.m_bPadding
	-- m_object.m_point				= layout.m_point
	-- m_object.m_relativePoint		= layout.m_rPoint

	for _, v in pairs(m_object.m_pool:GetActiveObjects()) do
		v.m_object.m_anim = nil
		-- local flash = v:GetNamedChild("Flash")
		-- if flash then
			-- v:GetNamedChild("Flash")["m_fadeAnimation"] = nil
		-- end
		if v.m_object.m_image:GetHeight() == layout.defSize then
			v.m_object.m_image:SetDimensions(layout.dSize, layout.dSize)
		end
	end
	-- menuBar.m_object:UpdateButtons()

	local divider	= menuBar:GetParent():GetNamedChild("Divider")
	local label		= menuBar:GetNamedChild("Active") or menuBar:GetNamedChild("Label")
	if divider and divider:GetType() == CT_CONTROL then
		divider:SetHidden(true)
	end
	if label and label:GetType() == CT_LABEL then
		PP_Font(label, --[[Font]] PP.f.u67, layout.label_f_s, layout.fontOutline, --[[Alpha]] 0.9, --[[Color]] nil, nil, nil, nil, --[[StyleColor]] 0, 0, 0, 0.5)
		label:SetVerticalAlignment(TEXT_ALIGN_CENTER)
		label:SetHidden(layout.noLabel)
	end
end


--Player fragment spin remove but keeping item preview at the scene active
--[[
local SM = SCENE_MANAGER

local ex_PreviewMarketProduct = itemPreview.PreviewMarketProduct
local function new_PreviewMarketProduct(...)
	SM:GetCurrentScene():AddFragment(FRAME_PLAYER_FRAGMENT)
	itemPreview:RegisterCallback("EndCurrentPreview", callback_EndCurrentPreview)
	return ex_PreviewMarketProduct(...)
end


	function ZO_ItemPreview_Shared:PreviewMarketProduct(marketProductId)
		self:SharedPreviewSetup(ZO_ITEM_PREVIEW_MARKET_PRODUCT, marketProductId)
	end

	function ZO_ItemPreview_Shared:PreviewFurnitureMarketProduct(marketProductId)
		self:SharedPreviewSetup(ZO_ITEM_PREVIEW_FURNITURE_MARKET_PRODUCT, marketProductId)
	end

	function ZO_ItemPreview_Shared:PreviewCollectibleAsFurniture(collectibleId)
		self:SharedPreviewSetup(ZO_ITEM_PREVIEW_COLLECTIBLE_AS_FURNITURE, collectibleId)
	end

	function ZO_ItemPreview_Shared:PreviewPlacedFurniture(furnitureId)
		self:SharedPreviewSetup(ZO_ITEM_PREVIEW_PLACED_FURNITURE, furnitureId)
	end

	function ZO_ItemPreview_Shared:PreviewProvisionerItemAsFurniture(recipeListIndex, recipeIndex)
		self:SharedPreviewSetup(ZO_ITEM_PREVIEW_PROVISIONER_ITEM_AS_FURNITURE, recipeListIndex, recipeIndex)
	end

	function ZO_ItemPreview_Shared:PreviewTradingHouseSearchResult(tradingHouseIndex)
		self:SharedPreviewSetup(ZO_ITEM_PREVIEW_TRADING_HOUSE_SEARCH_RESULT, tradingHouseIndex)
	end

	function ZO_ItemPreview_Shared:PreviewStoreEntry(storeEntryIndex)
		self:SharedPreviewSetup(ZO_ITEM_PREVIEW_STORE_ENTRY, storeEntryIndex)
	end

	function ZO_ItemPreview_Shared:PreviewOutfit(actorCategory, outfitIndex)
		self:SharedPreviewSetup(ZO_ITEM_PREVIEW_OUTFIT, actorCategory, outfitIndex)
	end

	function ZO_ItemPreview_Shared:PreviewCollectible(collectibleId)
		self:SharedPreviewSetup(ZO_ITEM_PREVIEW_COLLECTIBLE, collectibleId)
	end
]]
--Backup original "is preview available" function and then overwrite if always returnign true. Register a scene state
--change callback and on showing replace the original with the other function, also replacing the preview functions for
--inventory, collectible etc. (dependent on the scene). On state hidden replace the overwritten functions with the backuped
--originals again. Previewing function will also add the fragment which got removed (e.g. player fragment to stop spinning around)
--and ending the preview removes that fragment again
local ex_PreviewFuncs = {}
local ex_IsCharacterPreviewingAvailable --contains the original IsCharacterPreviewingAvailable function
local function new_IsCharacterPreviewingAvailable(...) --always return true, independently from FRAME_PLAYER_FRAGMENT
	return true
end
local sceneCallbacksForPreviewDone = {}
local new_PreviewFuncs = {}
local function RemoveFragmentFromSceneAndKeepPreviewFunctionality(scene, fragmentToRemove, previewFuncNameTab, stateChangeFragment)
	if scene == nil or sceneCallbacksForPreviewDone[scene] or fragmentToRemove == nil or ZO_IsTableEmpty(previewFuncNameTab) then return end
	scene:RemoveFragment(fragmentToRemove)
	local sceneName = scene.name

	local itemPreview = SYSTEMS:GetObject("itemPreview")
	if itemPreview == nil then return end

	if ex_IsCharacterPreviewingAvailable == nil then
		ex_IsCharacterPreviewingAvailable = IsCharacterPreviewingAvailable
	end

	if stateChangeFragment ~= nil then
		stateChangeFragment:RegisterCallback("StateChange", function(oldState, newState)
			if newState == SCENE_FRAGMENT_SHOWING then
				KEYBOARD_GROUP_MENU_SCENE:AddFragment(fragmentToRemove)
			elseif newState == SCENE_FRAGMENT_HIDDEN then
				KEYBOARD_GROUP_MENU_SCENE:RemoveFragment(fragmentToRemove)
			end
		end )
	end

	local function callback_EndCurrentPreview()
		itemPreview:UnregisterCallback("EndCurrentPreview", callback_EndCurrentPreview)
		scene:RemoveFragment(fragmentToRemove)
	end

	for _, previewFuncName in ipairs(previewFuncNameTab) do
		local ex_PreviewFunc = ex_PreviewFuncs[previewFuncName] or itemPreview[previewFuncName]
		if ex_PreviewFunc ~= nil then
			ex_PreviewFuncs[previewFuncName] = ex_PreviewFuncs[previewFuncName] or ex_PreviewFunc

			local previewFuncNameOfScene = sceneName .. "_" .. previewFuncName
			new_PreviewFuncs[previewFuncNameOfScene] = new_PreviewFuncs[previewFuncNameOfScene] or function(...)
				scene:AddFragment(fragmentToRemove)
				itemPreview:RegisterCallback("EndCurrentPreview", callback_EndCurrentPreview)
				return ex_PreviewFunc(...)
			end
		end
	end

	scene:RegisterCallback("StateChange", function(oldState, newState)
		if newState == SCENE_SHOWING then
			IsCharacterPreviewingAvailable = new_IsCharacterPreviewingAvailable
			for idx, previewFuncName in ipairs(previewFuncNameTab) do
				itemPreview[previewFuncName] = new_PreviewFuncs[sceneName .. "_" .. previewFuncName]
			end

		elseif newState == SCENE_HIDDEN then
			IsCharacterPreviewingAvailable = ex_IsCharacterPreviewingAvailable
			for idx, previewFuncName in ipairs(previewFuncNameTab) do
				itemPreview[previewFuncName] = ex_PreviewFuncs[previewFuncName]
			end
		end
	end)
	sceneCallbacksForPreviewDone[scene] = true
end
PP.RemoveFragmentFromSceneAndKeepPreviewFunctionality = RemoveFragmentFromSceneAndKeepPreviewFunctionality