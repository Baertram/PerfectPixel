local PP = PP ---@class PP

function PP.Core()
	--===============================================================================================--
	PP:AddNewSavedVars(0.2, 'WindowStyle', {
		skin_backdrop					= "PerfectPixel/tex/tex_white.dds",
		skin_backdrop_col				= {10/255, 12/255, 14/255, 200/255},
		skin_backdrop_insets			= 6,
		skin_backdrop_tile				= false,
		skin_backdrop_tile_size			= 8,
		skin_edge						= "PerfectPixel/tex/edge_outer_shadow_128x16.dds",
		skin_edge_col					= {0/255, 0/255, 0/255, 240/255},
		skin_edge_thickness				= 16,
		skin_edge_file_width			= 128,
		skin_edge_file_height			= 16,
		skin_edge_integral_wrapping		= false,
	})

	PP:AddNewSavedVars(0.2, 'ListStyle', {
		list_skin_backdrop					= "PerfectPixel/tex/tex_white.dds",
		list_skin_backdrop_col				= {10/255, 10/255, 10/255, 220/255},
		list_skin_backdrop_hl_col			= {96/255*0.3, 125/255*0.3, 139/255*0.3, 220/255},
		list_skin_backdrop_insets			= 0,
		list_skin_backdrop_tile				= false,
		list_skin_backdrop_tile_size		= 8,
		list_skin_edge						= "PerfectPixel/tex/edge_soft_shadow_128x16.dds",
		list_skin_edge_col					= {10/255, 10/255, 10/255, 240/255},
		list_skin_edge_sel_col				= {96/255, 125/255, 139/255, 220/255},
		list_skin_edge_thickness			= 10,
		list_skin_edge_file_width			= 128,
		list_skin_edge_file_height			= 16,
		list_skin_edge_integral_wrapping	= false,
		list_fade_distance					= 6,
		list_uniform_control_height			= 42,
		list_control_height					= 40,
	})

	PP:AddNewSavedVars(0.3, 'SceneManager', {
		DoNotInterrupt_toggle	= true,
		blur_background_toggle	= true,
		fade_scene_duration		= 20,
	})
	--===============================================================================================--
	local function OnCreateFn(control, data, dataType)
		control:SetHeight(PP.savedVars.ListStyle.list_control_height)
		--"SellPrice"--------------------
		local sp = control:GetNamedChild("SellPriceText")
		if sp then
			PP.Font(sp, --[[Font]] PP.f.u67, 15, "shadow", --[[Alpha]] nil, --[[Color]] nil, nil, nil, nil, --[[StyleColor]] 0, 0, 0, 0.5)
			control:GetNamedChild("SellPrice"):SetHidden(false)
			PP:SetLockFn(sp, 'SetFont')
		end
		--"ButtonStackCount"-------------
		if control:GetNamedChild("ButtonStackCount") then
			local stack = control:GetNamedChild("ButtonStackCount")
			PP.Font(stack, --[[Font]] PP.f.u67, 15, "outline", --[[Alpha]] nil, --[[Color]] nil, nil, nil, nil, --[[StyleColor]] 0, 0, 0, 0.5)
			PP.Anchor(stack, --[[#1]] LEFT, control:GetNamedChild("ButtonIcon"), LEFT, 34, 8)
		end
		--"Button"-------------
		if control:GetNamedChild("Button") then
			local button = control:GetNamedChild("Button")
			button:SetDimensions(36, 36)
			PP.Anchor(button, --[[#1]] CENTER, control, LEFT, 60, 0)
			if GridList then
				button.customTooltipAnchor = nil
			end
		end
		--"Status"-------------
		if control:GetNamedChild("Status") then
			local status = control:GetNamedChild("Status")
			status:SetDimensions(26, 26)
			PP.Anchor(status, --[[#1]] CENTER, control, LEFT, 18, 0)
			status:SetAlpha(1)
			status:SetMouseEnabled(true)
			status:SetDrawLevel(1)

			status:GetNamedChild("Texture"):SetMouseEnabled(true)
			status:GetNamedChild("Texture"):SetDrawLevel(1)
		end
		--"Name"-------------
		if control:GetNamedChild("Name") then
			local name = control:GetNamedChild("Name")
			PP.Font(name, --[[Font]] PP.f.u67, 15, "shadow", --[[Alpha]] nil, --[[Color]] nil, nil, nil, nil, --[[StyleColor]] 0, 0, 0, 0.5)
			PP.Anchor(name, --[[#1]] LEFT, control, LEFT, 110, -1)
			name:SetLineSpacing(0)
			name:SetVerticalAlignment(TEXT_ALIGN_CENTER)
			name:SetHidden(false)
		end
		--"SellInformation"----------
		if control:GetNamedChild("SellInformation") then
			local sellInfo = control:GetNamedChild("SellInformation")
			sellInfo:SetDimensions(32, 32)
			sellInfo:ClearAnchors()
			sellInfo:SetAnchor(RIGHT, control:GetNamedChild("SellPrice"), LEFT, -5, 0)
			sellInfo:SetAlpha(1)
			sellInfo:SetMouseEnabled(true)
			sellInfo:SetDrawLayer(1)
			sellInfo:SetDrawLevel(1)
		end
		--"Trait"----------
		if control:GetNamedChild("TraitInfo") then
			local trait = control:GetNamedChild("TraitInfo")
			trait:SetDimensions(32, 32)
			trait:SetAnchorFill(control:GetNamedChild("SellInformation"))
			trait:SetAlpha(1)
			trait:SetMouseEnabled(true)
			trait:SetDrawLevel(1)
		end
		--"Bg"-------------
		if control:GetNamedChild("Bg") then
			local bg = control:GetNamedChild("Bg")
			bg:SetTexture("PerfectPixel/tex/tex_clear.dds")
		end
		--"Highlight"-------------
		if control:GetNamedChild("Highlight") then
			local highlight = control:GetNamedChild("Highlight")
			highlight:SetHidden(true)
			-- highlight:SetTexture("PerfectPixel/tex/tex_clear.dds")
		end
		--"Backdrop"-------------
		local backdrop = PP.CreateBackdrop(control)
		backdrop:SetCenterColor(unpack(PP.savedVars.ListStyle.list_skin_backdrop_col))
		backdrop:SetCenterTexture(PP.savedVars.ListStyle.list_skin_backdrop, PP.savedVars.ListStyle.list_skin_backdrop_tile_size, PP.savedVars.ListStyle.list_skin_backdrop_tile and 1 or 0)
		backdrop:SetEdgeColor(unpack(PP.savedVars.ListStyle.list_skin_edge_col))
		backdrop:SetEdgeTexture(PP.savedVars.ListStyle.list_skin_edge, PP.savedVars.ListStyle.list_skin_edge_file_width, PP.savedVars.ListStyle.list_skin_edge_file_height, PP.savedVars.ListStyle.list_skin_edge_thickness, 0)
		backdrop:SetInsets(PP.savedVars.ListStyle.list_skin_backdrop_insets, PP.savedVars.ListStyle.list_skin_backdrop_insets, -PP.savedVars.ListStyle.list_skin_backdrop_insets, -PP.savedVars.ListStyle.list_skin_backdrop_insets)
		backdrop:SetIntegralWrapping(PP.savedVars.ListStyle.list_skin_edge_integral_wrapping)
		---------------------------------
	end

	for _, list in ipairs( PP.TabList ) do
		for typeId in pairs(list.dataTypes) do
			if typeId == 1 or typeId == 2 or typeId == 3 then
				local dataType	= ZO_ScrollList_GetDataTypeTable(list, typeId)
				local pool		= dataType.pool
				local mode		= list.mode

				if dataType.height then
					dataType.height = PP.savedVars.ListStyle.list_control_height
				end

				PP.PostHooksSetupCallback(list, 1, typeId, OnCreateFn)
				PP.PostHooksSetupCallback(list, 2, typeId, OnCreateFn)

				if mode ~= 3 then
					for _, control in pairs(pool.m_Free) do
						dataType.hooks[mode].OnCreate(control)
					end
					for _, control in pairs(pool.m_Active) do
						dataType.hooks[mode].OnCreate(control)
					end
				end
			end
		end
	end
	---------------------------------------------
	for _, list in ipairs(PP.TabList) do
		if list.uniformControlHeight then
			list.uniformControlHeight = PP.savedVars.ListStyle.list_uniform_control_height
		end
		if list.useFadeGradient then
			ZO_Scroll_SetMaxFadeDistance(list, PP.savedVars.ListStyle.list_fade_distance)
		end
	end

---------------------------------------------------------------------------------------------------

-- ZO_MainMenuSceneGroupBar
	PP.Anchor(ZO_MainMenuSceneGroupBar, --[[#1]] TOPRIGHT, GuiRoot, TOPRIGHT, -30, 64)

--FIX market scene
	local tabMarketScenes = {"market", "endeavorSealStoreSceneKeyboard", "esoPlusOffersSceneKeyboard", "dailyLoginRewards", "giftInventoryKeyboard"}
	for _, scene in pairs(tabMarketScenes) do
		SCENE_MANAGER:GetScene(scene):RegisterCallback("StateChange", function(oldState, newState)
			if newState == SCENE_SHOWING then
				PP.Anchor(ZO_MainMenuSceneGroupBar, --[[#1]] RIGHT, GuiRoot, RIGHT, -40, -340)
				ZO_KeybindStripMungeBackgroundTexture:SetHidden(false)
			elseif newState == SCENE_HIDDEN then
				PP.Anchor(ZO_MainMenuSceneGroupBar, --[[#1]] TOPRIGHT, GuiRoot, TOPRIGHT, -30, 64)
				ZO_KeybindStripMungeBackgroundTexture:SetHidden(true)
			end
		end)
	end

--CROWN_CRATE_KEYBOARD_SCENE
	PP.Anchor(ZO_CrownCratesGemsCounter, --[[#1]] BOTTOMLEFT, GuiRoot, BOTTOMLEFT, 10, -2)
	ZO_CrownCratesGemsCounterGemIcon:SetDimensions(22, 22)
	PP.Font(ZO_CrownCratesGemsCounterGemsHeader, --[[Font]] PP.f.u67, 20, "outline", --[[Alpha]] nil, --[[Color]] nil, nil, nil, nil, --[[StyleColor]] 0, 0, 0, 0.5)
	PP.Font(ZO_CrownCratesGemsCounterGems, --[[Font]] PP.f.u67, 20, "outline", --[[Alpha]] nil, --[[Color]] nil, nil, nil, nil, --[[StyleColor]] 0, 0, 0, 0.5)
	
--FadeAnimations---------------------------------------------------------------------------------------
	-- treasureMapQuickSlot
	-- treasureMapInventory
	-- DEFAULT_SCENE_TRANSITION_TIME = 1
	-- ZO_CONVEYOR_TRANSITION_TIME = 1
	-- DEFAULT_HUD_DURATION = 1
	PLAYER_PROGRESS_BAR_FRAGMENT.suppressFadeTimeline:GetAnimation():SetDuration(1)

	ZO_PreHook(ZO_FadeSceneFragment, "Show", function(self, ...)
		local fade_scene_duration = PP.savedVars.SceneManager.fade_scene_duration
		if self.duration and self.duration > fade_scene_duration then
			self.duration = fade_scene_duration
			self.control:SetAlpha(1)
			local alphaAnimation = self:GetAnimation():GetFirstAnimation()
			alphaAnimation:SetEndAlpha(1)
			alphaAnimation:SetStartAlpha(1)
		end
	end)

	ZO_PreHook(ZO_HUDFadeSceneFragment, "Show", function(self, ...)
		local fade_scene_duration = PP.savedVars.SceneManager.fade_scene_duration
		if self.showDuration and self.showDuration > fade_scene_duration then
			self.showDuration = fade_scene_duration
			self.hideDuration = 0
			self.control:SetAlpha(1)
			local alphaAnimation = self:GetAnimation():GetFirstAnimation()
			alphaAnimation:SetEndAlpha(1)
			alphaAnimation:SetStartAlpha(1)
		end
	end)

	-- ZO_PreHook(ZO_PlayerProgressBarFragment, "Hide", function(self, ...)
		-- local instant = self.sceneManager:GetCurrentScene() == self.sceneManager:GetBaseScene()
		-- ZO_Animation_PlayBackwardOrInstantlyToStart(self.suppressFadeTimeline, true)
		-- return true
	-- end)

---------------------------------------------------------------------------------------------------
	ZO_PreHook("SetFullscreenEffect", function()
		if PP.savedVars.SceneManager.blur_background_toggle then return end
		return true
	end)
	--
	ZO_PreHook(END_IN_WORLD_INTERACTIONS_FRAGMENT, "Show", function(self)
		if not PP.savedVars.SceneManager.DoNotInterrupt_toggle then return end
		EndPendingInteraction()
		self:OnShown()
		return true
	end)
---------------------------------------------------------------------------------------------------
end