local PP		= PP
local namespace	= 'SkillsScene'

PP.skillsScene = function()
	--===============================================================================================--
	local sv, def = PP:AddNewSavedVars(0.3, namespace, {
		unwrappedSkillsTree	= true,
	})
	---------------------------------------------
	table.insert(PP.optionsData,
	{	type				= "submenu",
		name				= GetString(PP_LAM_SCENE_SKILLS),
		controls = {
			--Skills tree---------------------------------
			{	type				= "checkbox",
				name				= GetString(PP_LAM_SCENE_SKILLS_SKILLS_TREE_UNWRAPPED),
				getFunc				= function() return sv.unwrappedSkillsTree end,
				setFunc				= function(value) sv.unwrappedSkillsTree = value end,
				default				= def.unwrappedSkillsTree,
				requiresReload		= true,
			},
		},
	})
	--===============================================================================================--
	-- local skillsScene = SCENE_MANAGER:GetScene('skills')
	KEYBOARD_SKILLS_SCENE:RemoveFragment(FRAME_PLAYER_FRAGMENT)
	KEYBOARD_SKILLS_SCENE:RemoveFragment(FRAME_EMOTE_FRAGMENT_SKILLS)
	KEYBOARD_SKILLS_SCENE:RemoveFragment(RIGHT_BG_FRAGMENT)
	KEYBOARD_SKILLS_SCENE:RemoveFragment(TREE_UNDERLAY_FRAGMENT)
	KEYBOARD_SKILLS_SCENE:RemoveFragment(TITLE_FRAGMENT)
	KEYBOARD_SKILLS_SCENE:RemoveFragment(SKILLS_TITLE_FRAGMENT)

	PP:CreateBackground(ZO_Skills, --[[#1]] nil, nil, nil, -10, -5, --[[#2]] nil, nil, nil, 0, 44)

	PP.Anchor(ZO_Skills, --[[#1]] TOPRIGHT, GuiRoot, TOPRIGHT, 0, 115,	--[[#2]] true, BOTTOMRIGHT, GuiRoot, BOTTOMRIGHT, 0, -104)

	PP.Anchor(ZO_SkillsAvailablePoints, --[[#1]] TOPLEFT, nil, TOPLEFT, 0, 0)
	PP.Font(ZO_SkillsAvailablePoints, --[[Font]] PP.f.u67, 24, "outline", --[[Alpha]] nil, --[[Color]] nil, nil, nil, nil, --[[StyleColor]] 0, 0, 0, 0.5)
	PP.Font(ZO_SkillsSkyShards, --[[Font]] PP.f.u67, 24, "outline", --[[Alpha]] nil, --[[Color]] nil, nil, nil, nil, --[[StyleColor]] 0, 0, 0, 0.5)
--ZO_SkillsSkillInfo
	PP.Anchor(ZO_SkillsSkillInfo, --[[#1]] TOP, ZO_Skills, TOP, 112, -5, --[[#2]] false, LEFT, ZO_SkillsSkillLinesContainer, RIGHT, 65, 0)
	
	PP.Font(ZO_SkillsSkillInfoName, --[[Font]] PP.f.u67, 20, "outline", --[[Alpha]] nil, --[[Color]] nil, nil, nil, nil, --[[StyleColor]] 0, 0, 0, 0.5)
	PP.Font(ZO_SkillsSkillInfoRank, --[[Font]] PP.f.u67, 54, "outline", --[[Alpha]] nil, --[[Color]] nil, nil, nil, nil, --[[StyleColor]] 0, 0, 0, 0.5)
	PP.Anchor(ZO_SkillsSkillInfoRank, --[[#1]] LEFT, nil, LEFT, -50, 0)
	PP.Bar(ZO_SkillsSkillInfoXPBar, --[[height]] 14, --[[fontSize]] 15)
	PP.Anchor(ZO_SkillsSkillInfoXPBar, --[[#1]] TOPLEFT, ZO_SkillsSkillInfoRank, BOTTOMRIGHT, 15, -30, --[[#2]] true, BOTTOMRIGHT, ZO_SkillsSkillList, TOPRIGHT, -20, -16)

--ZO_SkillsSkillList

	local skillList = ZO_SkillsSkillList

	PP.ScrollBar(skillList)
	PP.Anchor(skillList, --[[#1]] TOPLEFT, ZO_SkillsSkillInfo, BOTTOMLEFT, -60, 2, --[[#2]] true, BOTTOMRIGHT, ZO_Skills, BOTTOMRIGHT, 0, -40)

	-- skillList.useFadeGradient = nil
	ZO_Scroll_SetMaxFadeDistance(skillList, 10)
	skillList.dataTypes[2].height = 28

	PP.Hook_SetupCallback(skillList.dataTypes[1], function(control, data)
		local xpBar = control:GetNamedChild("XPBar")
		if xpBar then
			PP.Anchor(xpBar, --[[#1]] BOTTOMLEFT, control:GetNamedChild("Slot"), BOTTOMRIGHT, 13, -6)
			PP.Bar(xpBar, --[[height]] 14, --[[fontSize]] 15)
		end
	end)

	PP.Anchor(ZO_SkillsAssignableActionBar, --[[#1]] TOPLEFT, skillList, BOTTOMLEFT, -50, 0)

--ZO_SkillsSkillLinesContainer

	local skillLinesContainer = ZO_SkillsSkillLinesContainer

	ZO_Scroll_SetMaxFadeDistance(skillLinesContainer, 10)
	PP.Anchor(skillLinesContainer, --[[#1]] TOPLEFT, ZO_SkillsSkyShards, BOTTOMLEFT, 0, 5,	--[[#2]] true, BOTTOMLEFT, ZO_Skills, BOTTOMLEFT, 0, 34)
	PP.ScrollBar(skillLinesContainer)

	if sv.unwrappedSkillsTree then
		local tree = SKILLS_WINDOW.skillLinesTree
		tree.defaultIndent = 50
		tree.defaultSpacing = 0
		-- tree:SetExclusive(false) >> breaks the game
		tree.exclusiveCloseNodeFunction = function(treeNode)
			treeNode:SetOpen(true, false)
		end

		--SpentSkillPoints  compatibility--
		local treeHeader	= tree.templateInfo.SSP_Header			or tree.templateInfo.ZO_SkillIconHeader
		local treeEntry		= tree.templateInfo.SSP_NavigationEntry	or tree.templateInfo.ZO_SkillsNavigationEntry

		--TreeHeaderSetup(node, control, skillTypeData, open)
		local existingSetupCallback00 = treeHeader.setupFunction
		treeHeader.setupFunction = function(node, control, skillTypeData, open)
			existingSetupCallback00(node, control, skillTypeData, open)
			control:SetDimensionConstraints(300, 26, 300, 26)
			control:SetMouseEnabled(false)
			control.allowIconScaling = false
			--text--
			local icon = control:GetNamedChild("Icon")
			local text = control:GetNamedChild("Text")
			text:SetSelected(true)
			PP.Font(text, --[[Font]] PP.f.u67, 16, "outline", --[[Alpha]] nil, --[[Color]] 173*0.9, 166*0.9, 132*0.9, 1, --[[StyleColor]] 0, 0, 0, 0.8)
			PP.Anchor(text, --[[#1]] LEFT, icon, RIGHT, 0, 2)
			text:SetVerticalAlignment(TEXT_ALIGN_CENTER)
			-- text:SetDesaturation(-1)
			text:SetMouseEnabled(false)
			text:SetPixelRoundingEnabled(false) -- Fix shaking when scrolling
			--icon--
			PP.Anchor(icon, --[[#1]] LEFT, control, LEFT, 0, 0)
			icon:SetDimensions(40, 40)
			icon:SetMouseEnabled(false)
			icon:SetPixelRoundingEnabled(false) -- Fix shaking when scrolling
			--StatusIcon--
			local sIcon = control:GetNamedChild("StatusIcon")
			sIcon:SetHidden(true)
			--Channel--
			control:GetNamedChild("Channel"):SetMouseEnabled(false)

			icon.animation:GetAnimation():SetDuration(nil)
			icon:SetScale(1)
			icon:SetTexture(control.skillTypeData.keyboardNormalIcon)
			icon:SetDrawLevel(1)
			--SpentSkillPoints  compatibility--
			if control:GetNamedChild("PointText") then
				PP.Font(control:GetNamedChild("PointText"), --[[Font]] PP.f.u67, 20, "outline", --[[Alpha]] nil, --[[Color]] nil, nil, nil, nil, --[[StyleColor]] 0, 0, 0, 0.5)
				PP.Anchor(control:GetNamedChild("PointText"), --[[#1]] nil, nil, nil, 220, 2)
			end

			if control:GetNamedChild("Bg") then return end
			local bg = CreateControl("$(parent)Bg", control, CT_TEXTURE)
			bg:SetAnchorFill(control)
			bg:SetTexture("PerfectPixel/tex/GradientRight.dds")
			bg:SetColor(173/255, 166/255, 132/255, 0.4)
			bg:SetDrawLevel(0)
			bg:SetPixelRoundingEnabled(false) -- Fix shaking when scrolling
		end

		--TreeEntrySetup(node, control, skillLineData, open)
		local existingSetupCallback01 = treeEntry.setupFunction
		treeEntry.setupFunction = function(node, control, skillLineData, open)
			existingSetupCallback01(node, control, skillLineData, open)
			control:SetHeight(22)
			control:SetVerticalAlignment(TEXT_ALIGN_CENTER)
			PP.Font(control, --[[Font]] PP.f.u67, 16, "outline", --[[Alpha]] nil, --[[Color]] nil, nil, nil, nil, --[[StyleColor]] 0, 0, 0, 0.5)
			--StatusIcon--
			PP.Anchor(control:GetNamedChild("StatusIcon"), --[[#1]] nil, nil, nil, -2, 0)
			control:SetPixelRoundingEnabled(false) -- Fix shaking when scrolling
			--SpentSkillPoints  compatibility--
			if control:GetNamedChild("LevelText") then
				PP.Font(control:GetNamedChild("LevelText"), --[[Font]] PP.f.u67, 16, "outline", --[[Alpha]] nil, --[[Color]] nil, nil, nil, nil, --[[StyleColor]] 0, 0, 0, 0.5)
				PP.Anchor(control:GetNamedChild("LevelText"), --[[#1]] nil, nil, nil, -74, 1)
			end
			if control:GetNamedChild("PointText") then
				PP.Font(control:GetNamedChild("PointText"), --[[Font]] PP.f.u67, 16, "outline", --[[Alpha]] nil, --[[Color]] nil, nil, nil, nil, --[[StyleColor]] 0, 0, 0, 0.5)
				PP.Anchor(control:GetNamedChild("PointText"), --[[#1]] nil, nil, nil, 160, 1)
			end

		end
	end

--ZO_SkillsAdvisor_Keyboard_TopLevel	--ZO_SharedMediumLeftPanelBackground
	PP:CreateBackground(ZO_SkillsAdvisor_Keyboard_TopLevel, --[[#1]] nil, nil, nil, 0, -30, --[[#2]] nil, nil, nil, 32, 12)
	
	PP.ScrollBar(ZO_SkillsAdvisor_Suggestions_Keyboard_TopLevelSkillSuggestionList)
	PP.Anchor(ZO_SkillsAdvisor_Suggestions_Keyboard_TopLevel, --[[#1]] TOPLEFT, ZO_SkillsAdvisor_Keyboard_TopLevelDivider, BOTTOMLEFT, 3, -5, --[[#2]] true, BOTTOMRIGHT, ZO_SkillsAdvisor_Keyboard_TopLevel, BOTTOMRIGHT, 30, 4)
	
	ZO_Scroll_SetMaxFadeDistance(ZO_SkillsAdvisor_Suggestions_Keyboard_TopLevelSkillSuggestionList, 10)

	ZO_PreHook(ZO_SkillsAdvisor_Keyboard, "OnShowing", function(self)
		if self.dirtyFlag then
			self:UpdateSkillsAdvisorBuildSelection()
		else
			self:SetSelectedSkillBuildName()
			self:HandleTabChange()
		end
		return true
	end)



	--API101042 Gold Road - Scribing
	SecurePostHook(SCRIBING_KEYBOARD, "OnDeferredInitialize", function()
		local scribingAltarSceneName = "scribingKeyboard"
		local scribingAltarScene = SCENE_MANAGER:GetScene(scribingAltarSceneName)

		local scribingAltarContainer = SCRIBING_KEYBOARD.libraryContainer
		local scribingAltarSearchContainer = SCRIBING_KEYBOARD.searchContainer
		local scribingAltarCraftedAbilitiesContainer = SCRIBING_KEYBOARD.craftedAbilitiesControl
		--Scripts header
		local scribingAltarScriptsBackHeaderControl = SCRIBING_KEYBOARD.backHeaderControl
		--Mode menu bar
		local scribingAltarModeMenuBarControl = SCRIBING_KEYBOARD.modeBar
		--Slots container
		local scribingAltarSclotsContainer = SCRIBING_KEYBOARD.slotsContainer

		--Right
		scribingAltarScene:RemoveFragment(FRAME_PLAYER_FRAGMENT)
		scribingAltarScene:RemoveFragment(RIGHT_BG_FRAGMENT)
		scribingAltarScene:RemoveFragment(TREE_UNDERLAY_FRAGMENT)
		--scribingLibraryScene:RemoveFragment(RIGHT_PANEL_TITLE_FRAGMENT) -> Raises errors as the scene fragment tries to show again
		local scribingPanelKeyboardFragment = SCRIBING_FRAGMENT_KEYBOARD
		scribingPanelKeyboardFragment:RegisterCallback("StateChange", function(oldState, newState)
			if newState == SCENE_FRAGMENT_SHOWING or newState == SCENE_FRAGMENT_SHOWN then
				--scribingPanelKeyboardFragment.control:SetHidden(true)
				ZO_Scribing_Keyboard_TLLibraryFilterDivider:SetHidden(true)
				ZO_Scribing_Keyboard_TLLibraryInfoBarDivider:SetHidden(true)
				ZO_Scribing_Keyboard_TLModeMenuDivider:SetHidden(true)
				--Left
				ZO_Scribing_Keyboard_TLSlotsContainerBG:SetHidden(true)
			end
		end)

		PP:CreateBackground(scribingAltarContainer, --[[#1]] nil, nil, nil, -10, -5, --[[#2]] nil, nil, nil, 0, 44)
		PP.Anchor(scribingAltarContainer, --[[#1]] TOPRIGHT, GuiRoot, TOPRIGHT, 0, 85,	--[[#2]] true, BOTTOMRIGHT, GuiRoot, BOTTOMRIGHT, 0, -104)
		PP.Anchor(scribingAltarSearchContainer, --[[#1]] TOPLEFT, scribingAltarContainer, TOPLEFT, 10, 10	--[[#2]] )
		PP.Anchor(scribingAltarCraftedAbilitiesContainer, --[[#1]] TOPRIGHT, scribingAltarSearchContainer, BOTTOMRIGHT, 0, 15,	--[[#2]] true, BOTTOMRIGHT, scribingAltarContainer, BOTTOMRIGHT, 0, 0)
		PP.Anchor(scribingAltarScriptsBackHeaderControl, --[[#1]] TOPLEFT, scribingAltarSearchContainer, BOTTOMLEFT, -30, 15)
		PP.Anchor(scribingAltarModeMenuBarControl, --[[#1]] TOPRIGHT, scribingAltarContainer, TOPRIGHT, -15, 15)


		--Left
		scribingAltarScene:RemoveFragment(MEDIUM_LEFT_PANEL_BG_FRAGMENT)
		PP:CreateBackground(MEDIUM_LEFT_PANEL_BG_FRAGMENT.control, --[[#1]] nil, nil, nil, -10, -5, --[[#2]] nil, nil, nil, 0, 44)
		PP:CreateBackground(scribingAltarSclotsContainer, --[[#1]] nil, nil, nil, -10, -5, --[[#2]] nil, nil, nil, 0, 44)

		PP.ScrollBar(ZO_Scribing_Keyboard_TLLibraryCraftedAbilitiesGridListContainerList)
		PP.ScrollBar(ZO_Scribing_Keyboard_TLLibraryScripts)
	end)


	SecurePostHook(SCRIBING_LIBRARY_KEYBOARD, "OnDeferredInitialize", function()
		local scribingSceneName ="scribingLibraryKeyboard"
		local scribingLibraryScene = SCENE_MANAGER:GetScene(scribingSceneName)
		local scribingLibraryContainer = SCRIBING_LIBRARY_KEYBOARD.libraryContainer
		local scribingLibrarySearchContainer = SCRIBING_LIBRARY_KEYBOARD.searchContainer
		local scribingLibraryCraftedAbilitiesContainer = SCRIBING_LIBRARY_KEYBOARD.craftedAbilitiesControl
		--Scripts header
		local scribingLibraryScriptsBackHeaderControl = SCRIBING_LIBRARY_KEYBOARD.backHeaderControl

		--Right
		scribingLibraryScene:RemoveFragment(FRAME_PLAYER_FRAGMENT)
		scribingLibraryScene:RemoveFragment(RIGHT_BG_FRAGMENT)
		scribingLibraryScene:RemoveFragment(TREE_UNDERLAY_FRAGMENT)
		--scribingLibraryScene:RemoveFragment(RIGHT_PANEL_TITLE_FRAGMENT) -> Raises errors as the scene fragment tries to show again
		local rightPanelTitleFragment = RIGHT_PANEL_TITLE_FRAGMENT
		rightPanelTitleFragment:RegisterCallback("StateChange", function(oldState, newState)
			if newState == SCENE_FRAGMENT_SHOWING or newState == SCENE_FRAGMENT_SHOWN then
				if SCENE_MANAGER.currentScene ~= scribingLibraryScene then return end
				rightPanelTitleFragment.control:SetHidden(true)
				ZO_ScribingLibrary_Keyboard_TLLibraryFilterDivider:SetHidden(true)
				ZO_ScribingLibrary_Keyboard_TLLibraryInfoBarDivider:SetHidden(true)
			end
		end)

		PP:CreateBackground(scribingLibraryContainer, --[[#1]] nil, nil, nil, -10, -5, --[[#2]] nil, nil, nil, 0, 44)
		PP.Anchor(scribingLibraryContainer, --[[#1]] TOPRIGHT, GuiRoot, TOPRIGHT, 0, 85,	--[[#2]] true, BOTTOMRIGHT, GuiRoot, BOTTOMRIGHT, 0, -104)
		PP.Anchor(scribingLibrarySearchContainer, --[[#1]] TOPLEFT, scribingLibraryContainer, TOPLEFT, 10, 10	--[[#2]] )
		PP.Anchor(scribingLibraryCraftedAbilitiesContainer, --[[#1]] TOPRIGHT, scribingLibrarySearchContainer, BOTTOMRIGHT, 0, 15,	--[[#2]] true, BOTTOMRIGHT, scribingLibraryContainer, BOTTOMRIGHT, 0, 0)
		PP.Anchor(scribingLibraryScriptsBackHeaderControl, --[[#1]] TOPLEFT, scribingLibrarySearchContainer, BOTTOMLEFT, -30, 15)

		--Left
		scribingLibraryScene:RemoveFragment(MEDIUM_LEFT_PANEL_BG_FRAGMENT)
		PP:CreateBackground(MEDIUM_LEFT_PANEL_BG_FRAGMENT.control, --[[#1]] nil, nil, nil, -10, -5, --[[#2]] nil, nil, nil, 0, 44)

		PP.ScrollBar(ZO_ScribingLibrary_Keyboard_TLLibraryCraftedAbilitiesGridListContainerList)
		PP.ScrollBar(ZO_ScribingLibrary_Keyboard_TLLibraryScripts)
	end)
end

















