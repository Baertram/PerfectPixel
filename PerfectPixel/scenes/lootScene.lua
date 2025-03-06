local PP = PP ---@class PP

PP.lootScene = function()
--===============================================================================================--
	local SV_VER		= 0.1
	local DEF = {
		toggle			= true,
		pos				= { x = -60, y = -37 },
		adaptiveSize	= true,
		maxSize			= 10,
		movable			= true,
		mouseFocus		= false,
	}
	local SV = ZO_SavedVars:NewAccountWide(PP.ADDON_NAME, SV_VER, "LootScene", DEF, GetWorldName())
	---------------------------------------------
	table.insert(PP.optionsData,
	{	type				= "submenu",
		name				= "Loot Scene",
		controls = {
			{	type				= "checkbox",
				name				= GetString(PP_LAM_ACTIVATE),
				getFunc				= function() return SV.toggle end,
				setFunc				= function(value) SV.toggle = value end,
				default				= DEF.toggle,
				requiresReload		= true,
			},
			{	type				= "checkbox",
				name				= "Movable window",
				getFunc				= function() return SV.movable end,
				setFunc				= function(value) SV.movable = value end,
				default				= DEF.movable,
				disabled			= function() return not SV.toggle end,
				requiresReload		= true,
			},
			{	type				= "checkbox",
				name				= "Mouse focus by first slot",
				getFunc				= function() return SV.mouseFocus end,
				setFunc				= function(value) SV.mouseFocus = value end,
				default				= DEF.mouseFocus,
				disabled			= function() return not SV.toggle end,
			},
			{	type = "header", name = "Adaptive size window", },
			{	type				= "checkbox",
				name				= GetString(PP_LAM_ACTIVATE),
				getFunc				= function() return SV.adaptiveSize end,
				setFunc				= function(value) SV.adaptiveSize = value end,
				default				= DEF.adaptiveSize,
				disabled			= function() return not SV.toggle end,
				requiresReload		= true,
			},
			{	type 				= "slider", name = "Max size (slots)",
				max					= 20, min = 1,
				getFunc				= function() return SV.maxSize end,
				setFunc				= function(value) SV.maxSize = value end,
				default				= DEF.maxSize,
				disabled			= function() return not SV.toggle or not SV.adaptiveSize end,
			},
		},
	})
--===============================================================================================--
	if not SV.toggle then return end

	LOOT_SCENE:RemoveFragment(FRAME_EMOTE_FRAGMENT_LOOT)

	local lootWindow	= LOOT_WINDOW.control
	local titleControl	= LOOT_WINDOW_FRAGMENT.titleControl
	local alphaControl	= LOOT_WINDOW_FRAGMENT.alphaControl
	local bg			= alphaControl:GetNamedChild("BG")
	local divider		= alphaControl:GetNamedChild("Divider")
	local lootList		= LOOT_WINDOW.list
	local button1		= alphaControl:GetNamedChild("Button1")
	local button2		= alphaControl:GetNamedChild("Button2")
	
	local reticle		= RETICLE.interactContext

	PP:CreateBackground(lootWindow, --[[#1]] nil, nil, nil, -6, 34, --[[#2]] nil, nil, nil, 0, -44)
	PP.ScrollBar(lootList,	--[[sb_c]] 180, 180, 180, 0.7, --[[bd_c]] 20, 20, 20, 0.7, true)

	bg:SetHidden(true)
	divider:SetHidden(true)

----titleControl---------------------------------
	titleControl:SetDimensionConstraints(0, 0, lootList:GetWidth() - 20, 0)
	PP.Font(titleControl, --[[Font]] PP.f.u67, 22, "outline", --[[Alpha]] nil, --[[Color]] nil, nil, nil, nil, --[[StyleColor]] 0, 0, 0, 0.8)
	titleControl:SetVerticalAlignment(TEXT_ALIGN_BOTTOM)
	titleControl:SetHorizontalAlignment(TEXT_ALIGN_CENTER)
	PP.Anchor(titleControl, --[[#1]] BOTTOM, lootList, TOP, 0, -10)

	local orig_titleSetText = titleControl.SetText
	function titleControl.SetText(self, text)
		if text == "" then
			orig_titleSetText(self, reticle:GetText())
		else
			orig_titleSetText(self, text)
		end
	end
-------------------------------------------------
	PP.Anchor(ZO_LootStealthIcon, --[[#1]] TOP, lootWindow, TOP, 0, -30)
	PP.Font(ZO_LootStealthIconStealthText, --[[Font]] PP.f.u67, 24, "outline", --[[Alpha]] 1, --[[Color]] nil, nil, nil, nil, --[[StyleColor]] 0, 0, 0, 0.8)

	PP.Anchor(button1, --[[#1]] BOTTOMRIGHT, alphaControl, BOTTOMRIGHT, -10, -10)

	PP.Font(button1.keyLabel,	--[[Font]] PP.f.u57, 16, "outline")
	PP.Font(button1.nameLabel,	--[[Font]] PP.f.u67, 18, "outline")
	PP.Font(button2.keyLabel,	--[[Font]] PP.f.u57, 16, "outline")
	PP.Font(button2.nameLabel,	--[[Font]] PP.f.u67, 18, "outline")
-------------------------------------------------
	
	local layout	= PP:GetLayout('inventorySlot', lootList)
	local savedVars	= PP:GetSavedVars('ListStyle')

	local function onCreateFn(control, ...)
		PP.Inv_Slot(control, 'onCreate', { 'parent', 'Bg', 'Highlight', 'MultiIcon', 'ButtonStackCount', 'Button', 'Name' }, layout, savedVars, ...)
	end

	local function onUpdateFn(control, ...)
		PP.Inv_Slot(control, 'onUpdate', {'MultiIcon', 'ButtonIcon', 'Status', 'SellPrice', 'Backdrop'}, layout, savedVars, ...)
	end

	PP:RefreshStyle_InventoryList(lootList, layout, nil, onCreateFn, onUpdateFn)

	ZO_PreHook(LOOT_WINDOW_FRAGMENT, "Show", function(self)
		SHARED_INFORMATION_AREA:SetHidden(self.control, false)

		ZO_PlayLootWindowSound(false)

		TUTORIAL_SYSTEM:SuppressTutorialType(TUTORIAL_TYPE_HUD_INFO_BOX, true, TUTORIAL_SUPPRESSED_BY_LOOT)

		self.alphaControl:SetAlpha(1)
		self.keybindButton:SetAlpha(0)

		self:OnShown()

		if SV.mouseFocus then
			WINDOW_MANAGER:SetMouseFocusByName(lootList.data[1].control:GetName())
		end
		return true
	end)

----Adaptive size window----------------------------------------------------------------------------
	if SV.adaptiveSize then
		local uniformControlHeight	= lootList.uniformControlHeight
		local minH					= 90

		ZO_PreHook(LOOT_WINDOW, "UpdateAllControlText", function(self)
			local itemCount = self.itemCount <= SV.maxSize and self.itemCount or SV.maxSize
			if itemCount > 0 then
				lootWindow:SetHeight(minH + uniformControlHeight * itemCount)

				if itemCount < 5 then
					for i = 1, #self.list.data do
						if self.list.data[i].typeId == 2 then
							self.list.data[i] = nil
						end
					end
				end
				ZO_ScrollList_Commit(self.list)
			end
		end)
	end

----Movable window----------------------------------------------------------------------------
	local pos = SV.pos

	-- lootWindow:SetAnchor(TOPLEFT, reticle, BOTTOMLEFT, pos.x, pos.y)
	lootWindow:SetAnchorOffsets(pos.x, pos.y, 1)
	lootWindow:SetClampedToScreen(true)

	if SV.movable then
		PP.SetMovableControl(titleControl, lootWindow, pos)
	end
---------------------------------------------------------------------------------------------------
end