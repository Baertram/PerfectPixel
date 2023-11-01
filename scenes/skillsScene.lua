PP.skillsScene = function()
--===============================================================================================--
	local SV_VER			= 0.2
	local DEF = {
		unwrappedSkillsTree	= true,
		skillsTreeBG		= false,
		skillsListBG		= false,
	}
	local SV = ZO_SavedVars:NewAccountWide(PP.ADDON_NAME, SV_VER, "SkillsScene", DEF, GetWorldName())
	---------------------------------------------
	table.insert(PP.optionsData,
	{	type				= "submenu",
		name				= GetString(PP_LAM_SCENE_SKILLS),
		controls = {
			--Skills tree---------------------------------
			{	type				= "checkbox",
				name				= GetString(PP_LAM_SCENE_SKILLS_SKILLS_TREE_UNWRAPPED),
				getFunc				= function() return SV.unwrappedSkillsTree end,
				setFunc				= function(value) SV.unwrappedSkillsTree = value end,
				default				= DEF.unwrappedSkillsTree,
				requiresReload		= true,
			},
			{	type				= "checkbox",
				name				= GetString(PP_LAM_SCENE_SKILLS_SKILLS_TREE_BG),
				getFunc				= function() return SV.skillsTreeBG end,
				setFunc				= function(value) SV.skillsTreeBG = value end,
				default				= DEF.skillsTreeBG,
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

	PP.Anchor(ZO_Skills, --[[#1]] TOPRIGHT, GuiRoot, TOPRIGHT, 0, 85,	--[[#2]] true, BOTTOMRIGHT, GuiRoot, BOTTOMRIGHT, 0, -104)

	PP.Anchor(ZO_SkillsAvailablePoints, --[[#1]] TOPLEFT, nil, TOPLEFT, 0, 0)
	PP.Font(ZO_SkillsAvailablePoints, --[[Font]] PP.f.u67, 24, "outline", --[[Alpha]] nil, --[[Color]] nil, nil, nil, nil, --[[StyleColor]] 0, 0, 0, .5)
	PP.Font(ZO_SkillsSkyShards, --[[Font]] PP.f.u67, 24, "outline", --[[Alpha]] nil, --[[Color]] nil, nil, nil, nil, --[[StyleColor]] 0, 0, 0, .5)
--ZO_SkillsSkillInfo
	PP.Anchor(ZO_SkillsSkillInfo, --[[#1]] TOP, ZO_Skills, TOP, 112, -5, --[[#2]] false, LEFT, ZO_SkillsSkillLinesContainer, RIGHT, 65, 0)
	
	PP.Font(ZO_SkillsSkillInfoName, --[[Font]] PP.f.u67, 20, "outline", --[[Alpha]] nil, --[[Color]] nil, nil, nil, nil, --[[StyleColor]] 0, 0, 0, .5)
	PP.Font(ZO_SkillsSkillInfoRank, --[[Font]] PP.f.u67, 54, "outline", --[[Alpha]] nil, --[[Color]] nil, nil, nil, nil, --[[StyleColor]] 0, 0, 0, .5)
	PP.Anchor(ZO_SkillsSkillInfoRank, --[[#1]] LEFT, nil, LEFT, -50, 0)
	PP.Bar(ZO_SkillsSkillInfoXPBar, --[[height]] 14, --[[fontSize]] 15)
	PP.Anchor(ZO_SkillsSkillInfoXPBar, --[[#1]] TOPLEFT, ZO_SkillsSkillInfoRank, BOTTOMRIGHT, 15, -30, --[[#2]] true, BOTTOMRIGHT, ZO_SkillsSkillList, TOPRIGHT, -20, -16)

--ZO_SkillsSkillList

	local skillList = ZO_SkillsSkillList

	PP.ScrollBar(skillList,	--[[sb_c]] 180, 180, 180, .7, --[[bd_c]] 20, 20, 20, .7, false)
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
	PP.ScrollBar(skillLinesContainer,	--[[sb_c]] 180, 180, 180, .7, --[[bd_c]] 20, 20, 20, .7, false)

	if SV.unwrappedSkillsTree then
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
		local existingSetupCallback = treeHeader.setupFunction
		treeHeader.setupFunction = function(node, control, skillTypeData, open)
			existingSetupCallback(node, control, skillTypeData, open)
			control:SetDimensionConstraints(300, 23, 300, 23)
			control:SetMouseEnabled(false)
			control.allowIconScaling = false
			--text--
			local icon = control:GetNamedChild("Icon")
			local text = control:GetNamedChild("Text")
			text:SetSelected(true)
			PP.Font(text, --[[Font]] PP.f.u67, 15, "outline", --[[Alpha]] nil, --[[Color]] 173, 166, 132, 1, --[[StyleColor]] 0, 0, 0, .8)
			PP.Anchor(text, --[[#1]] LEFT, icon, RIGHT, 5, 0)
			text:SetVerticalAlignment(TEXT_ALIGN_CENTER)
			text:SetDesaturation(-1)
			text:SetMouseEnabled(false)
			--icon--
			PP.Anchor(icon, --[[#1]] LEFT, control, LEFT, 0, 0)
			icon:SetDimensions(33, 33)
			icon:SetMouseEnabled(false)
			--StatusIcon--
			local sIcon = control:GetNamedChild("StatusIcon")
			sIcon:SetHidden(true)
			--Channel--
			control:GetNamedChild("Channel"):SetMouseEnabled(false)

			icon.animation:GetAnimation():SetDuration(nil)
			icon:SetScale(1)
			icon:SetTexture(control.skillTypeData.keyboardNormalIcon)

			--SpentSkillPoints  compatibility--
			if control:GetNamedChild("PointText") then
				PP.Font(control:GetNamedChild("PointText"), --[[Font]] PP.f.u67, 20, "outline", --[[Alpha]] nil, --[[Color]] nil, nil, nil, nil, --[[StyleColor]] 0, 0, 0, .5)
				PP.Anchor(control:GetNamedChild("PointText"), --[[#1]] nil, nil, nil, 220, 2)
			end

			if control:GetNamedChild("Backdrop") then return end
			PP.ListBackdrop(control, 15, 0, 0, 0, --[[tex]] "PerfectPixel/tex/GradientRight.dds", 16, 0, --[[bd]] 173*.3, 166*.3, 132*.3, 1, --[[edge]] 0, 0, 0, 0)
		end

		--TreeEntrySetup(node, control, skillLineData, open)
		local existingSetupCallback = treeEntry.setupFunction
		treeEntry.setupFunction = function(node, control, skillLineData, open)
			existingSetupCallback(node, control, skillLineData, open)
			control:SetHeight(21)
			control:SetVerticalAlignment(TEXT_ALIGN_CENTER)
			PP.Font(control, --[[Font]] PP.f.u67, 15, "outline", --[[Alpha]] nil, --[[Color]] nil, nil, nil, nil, --[[StyleColor]] 0, 0, 0, .5)
			--StatusIcon--
			PP.Anchor(control:GetNamedChild("StatusIcon"), --[[#1]] nil, nil, nil, -2, 0)

			--SpentSkillPoints  compatibility--
			if control:GetNamedChild("LevelText") then
				PP.Font(control:GetNamedChild("LevelText"), --[[Font]] PP.f.u67, 14, "outline", --[[Alpha]] nil, --[[Color]] nil, nil, nil, nil, --[[StyleColor]] 0, 0, 0, .5)
				PP.Anchor(control:GetNamedChild("LevelText"), --[[#1]] nil, nil, nil, -74, 1)
			end
			if control:GetNamedChild("PointText") then
				PP.Font(control:GetNamedChild("PointText"), --[[Font]] PP.f.u67, 14, "outline", --[[Alpha]] nil, --[[Color]] nil, nil, nil, nil, --[[StyleColor]] 0, 0, 0, .5)
				PP.Anchor(control:GetNamedChild("PointText"), --[[#1]] nil, nil, nil, 160, 1)
			end

		end
	end

--ZO_SkillsAdvisor_Keyboard_TopLevel	--ZO_SharedMediumLeftPanelBackground
	PP:CreateBackground(ZO_SkillsAdvisor_Keyboard_TopLevel, --[[#1]] nil, nil, nil, 0, -30, --[[#2]] nil, nil, nil, 32, 12)
	
	PP.ScrollBar(ZO_SkillsAdvisor_Suggestions_Keyboard_TopLevelSkillSuggestionList, --[[sb_c]] 180, 180, 180, .7, --[[bd_c]] 20, 20, 20, .7, true)
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

end

















