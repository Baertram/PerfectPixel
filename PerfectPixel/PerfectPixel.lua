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