local PP		= PP
local namespace	= 'CompanionScene'

PP.companionsScene = function()
	--===============================================================================================--
	local sv, def = PP:AddNewSavedVars(0.3, namespace, {
		unwrappedSkillsTree	= true,
	})
	---------------------------------------------
	table.insert(PP.optionsData,
			{	type				= "submenu",
				 name				= GetString(PP_LAM_SCENE_COMPANION_SKILLS),
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
	--Companion keyboard object
	local companionKeyboard = COMPANION_KEYBOARD


	--===============================================================================================--
	--Companion character (1st shown upon talking to companion)
	local companionCharacterKeyboard = COMPANION_CHARACTER_KEYBOARD
	local companionCharacterKeyboardScene = COMPANION_CHARACTER_KEYBOARD_SCENE
	local companionCharacterKeyboardFragment = COMPANION_CHARACTER_KEYBOARD_FRAGMENT
	--OnDeferredInit: No

	local function onCompanionCharacterSceneShown()
		companionCharacterKeyboardScene:RemoveFragment(FRAME_PLAYER_FRAGMENT)
		companionCharacterKeyboardScene:RemoveFragment(FRAME_EMOTE_FRAGMENT_SKILLS)
		companionCharacterKeyboardScene:RemoveFragment(RIGHT_BG_FRAGMENT)
		companionCharacterKeyboardScene:RemoveFragment(TREE_UNDERLAY_FRAGMENT)
		companionCharacterKeyboardScene:RemoveFragment(TITLE_FRAGMENT)
		companionCharacterKeyboardScene:RemoveFragment(COMPANION_TITLE_FRAGMENT)
	end
	companionCharacterKeyboardScene:RegisterCallback("StateChange", function(oldState, newState)
        if newState == SCENE_SHOWN then
d("[PP]Companion character scene shown")
			if HasActiveCompanion() then
				onCompanionCharacterSceneShown()
			end
        end
    end)

	local companionCharacterFragmentBGWasUnhidden = false
	local function onCompanionCharacterFragmentShown()
		local companionControl = companionKeyboard.control
		local companionMenuHeaderBar = GetControl(companionControl, "MenuHeaderBar")

		local companionCharacterKeyboardControl = companionCharacterKeyboard.control
		local companionNavigationTree = companionCharacterKeyboard.navigationTree

		PP:CreateBackground(companionCharacterKeyboardControl, --[[#1]] nil, nil, nil, -10, -5, --[[#2]] nil, nil, nil, 0, 44)
		if not companionCharacterFragmentBGWasUnhidden then
			local bg = companionCharacterKeyboardControl.PP_BG
			bg:SetHidden(false)
			companionCharacterFragmentBGWasUnhidden = true
		end
		PP.Anchor(companionCharacterKeyboardControl, --[[#1]] TOPRIGHT, GuiRoot, TOPRIGHT, 0, 115,	--[[#2]] true, BOTTOMRIGHT, GuiRoot, BOTTOMRIGHT, 0, -104)

		PP.Anchor(companionMenuHeaderBar, --[[#1]] TOPRIGHT, GuiRoot, TOPRIGHT, -30, 64)
	end
	companionCharacterKeyboardFragment:RegisterCallback("StateChange", function(oldState, newState)
        if newState == SCENE_SHOWN then
d("[PP]Companion character fragment shown")
			if HasActiveCompanion() then
				onCompanionCharacterFragmentShown()
			end
        end
    end)


	--===============================================================================================--
	--Companion character window (left: companion character doll)
	local companionCharacterWindowKeyboard = COMPANION_WINDOW_KEYBOARD
	local companionCharacterWindowKeyboardFragment = COMPANION_CHARACTER_WINDOW_FRAGMENT
	--OnDeferredInit: No

	local companionCharacterWindowFragmentBGWasUnhidden = false
	local function onCompanionCharacterWindowFragmentShown()
		local companionCharacterWindowControl = companionCharacterWindowKeyboard.control
		PP:CreateBackground(companionCharacterWindowControl,		--[[#1]] nil, nil, nil, 0, 16, --[[#2]] nil, ZO_CharacterWindowStats, nil, -2, 32)
		if not companionCharacterWindowFragmentBGWasUnhidden then
			local bg = companionCharacterWindowControl.PP_BG
			bg:SetHidden(false)
			companionCharacterWindowFragmentBGWasUnhidden = true
		end
	end
	companionCharacterWindowKeyboardFragment:RegisterCallback("StateChange", function(oldState, newState)
        if newState == SCENE_SHOWN then
d("[PP]Companion character window fragment shown")
			if HasActiveCompanion() then
				onCompanionCharacterWindowFragmentShown()
			end
        end
    end)


	--===============================================================================================--
	--Companion overview (at character scene)
	local companionOverviewKeyboard = COMPANION_OVERVIEW_KEYBOARD
	local companionOverviewKeyboardFragment = COMPANION_OVERVIEW_KEYBOARD_FRAGMENT
	--OnDeferredInit: Yes

	PP.onDeferredInitCheck(companionOverviewKeyboard, function()
d("[PP]Companion overview OnDeferredInit done")
		local companionOverViewControl = companionOverviewKeyboard.control

		PP.Anchor(companionOverViewControl, --[[#1]] TOPRIGHT, GuiRoot, TOPRIGHT, 0, 115,	--[[#2]] true, BOTTOMRIGHT, GuiRoot, BOTTOMRIGHT, 0, -104)

		local companionOverviewLevelAndXPBarContainer = GetControl(companionOverViewControl, "LevelProgress")  --All anchored to this one?
		PP.Anchor(companionOverviewLevelAndXPBarContainer, --[[#1]] TOPLEFT, companionOverViewControl, TOPLEFT, 0, 0,	--[[#2]] true, TOPRIGHT, companionOverViewControl, TOPRIGHT, -20, 0)

		--local companionOverviewLevelProgressIcon = GetControl(companionOverViewControl, "LevelProgressIcon")
		--local companionOverviewOutfitContainer = GetControl(companionOverViewControl, "Outfit")
		--local companionOverviewSkilslLabel = GetControl(companionOverViewControl, "SkillsLabel")
		--local companionOverviewSkillsPriorityBar = GetControl(companionOverViewControl, "ReadOnlyActionBar")
		--local companionOverviewRapport = GetControl(companionOverViewControl, "LevelProgress")
	end)

	local function onCompanionOverviewFragmentShown()

	end
	companionOverviewKeyboardFragment:RegisterCallback("StateChange", function(oldState, newState)
        if newState == SCENE_SHOWN then
d("[PP]Companion overview fragment shown")
			if HasActiveCompanion() then
				onCompanionOverviewFragmentShown()
			end
        end
    end)

	--===============================================================================================--
	--Companion equipment (at character scene)
	local companionEquipmentKeyboard = COMPANION_EQUIPMENT_KEYBOARD
	local companionEquipmentKeyboardFragment = COMPANION_EQUIPMENT_KEYBOARD_FRAGMENT
	--OnDeferredInit: No

	local function onCompanionEQuipmentFragmentShown()
		local companionEquipmentControl = companionEquipmentKeyboard.control
		PP.Anchor(companionEquipmentControl, --[[#1]] TOPRIGHT, GuiRoot, TOPRIGHT, 0, 115,	--[[#2]] true, BOTTOMRIGHT, GuiRoot, BOTTOMRIGHT, 0, -104)

		local companionEquipmentFilterDivider = GetControl(companionEquipmentControl, "FilterDivider")
		PP.Anchor(companionEquipmentFilterDivider, --[[#1]] TOP, companionEquipmentControl, TOP, 0, 60,	--[[#2]] nil, nil, nil, nil, nil, nil)

		local companionEquipmentInfoBarDivider = GetControl(companionEquipmentControl, "InfoBarDivider")
		companionEquipmentInfoBarDivider:SetHidden(true)

		--List
		local companionEquipmentSortBy = GetControl(companionEquipmentControl, "SortBy")
		local companionEquipmentList = companionEquipmentKeyboard.list

		PP.ScrollBar(companionEquipmentList)
		PP.Anchor(companionEquipmentList, --[[#1]] TOPLEFT, companionEquipmentSortBy, BOTTOMLEFT, 0, 5, --[[#2]] true, BOTTOMRIGHT, companionEquipmentControl, BOTTOMRIGHT, 0, 0)
		ZO_Scroll_SetMaxFadeDistance(companionEquipmentList, 10)
		ZO_ScrollList_Commit(companionEquipmentList)
	end
	companionEquipmentKeyboardFragment:RegisterCallback("StateChange", function(oldState, newState)
        if newState == SCENE_SHOWN then
d("[PP]Companion equipment fragment shown")
			if HasActiveCompanion() then
				onCompanionEQuipmentFragmentShown()
			end
        end
    end)


	--===============================================================================================--
	--Companion skills
	local onCompanionSkillsSceneShownApplied = false
	local companionSkillsKeyboard = COMPANION_SKILLS_KEYBOARD
	local companionSkillsKeyboardScene    = COMPANION_SKILLS_KEYBOARD_SCENE
	local companionSkillsKeyboardFragment = COMPANION_CHARACTER_KEYBOARD_FRAGMENT
	--OnDeferredInit: No

	local companionSkillsSceneBGWasUnhidden = false
	local function onCompanionSkillsSceneShown()
		companionSkillsKeyboardScene:RemoveFragment(FRAME_PLAYER_FRAGMENT)
		companionSkillsKeyboardScene:RemoveFragment(FRAME_EMOTE_FRAGMENT_SKILLS)
		companionSkillsKeyboardScene:RemoveFragment(RIGHT_BG_FRAGMENT)
		companionSkillsKeyboardScene:RemoveFragment(TREE_UNDERLAY_FRAGMENT)
		companionSkillsKeyboardScene:RemoveFragment(TITLE_FRAGMENT)
		companionSkillsKeyboardScene:RemoveFragment(COMPANION_TITLE_FRAGMENT)

		local skillPanel = companionSkillsKeyboard.control
		local skillLineInfo = GetControl(skillPanel, "SkillLineInfo")
		local skillList = GetControl(skillPanel, "SkillList")
		local skillLinesContainer = GetControl(skillPanel, "SkillLinesContainer")

		PP:CreateBackground(skillPanel, --[[#1]] nil, nil, nil, -10, -5, --[[#2]] nil, nil, nil, 0, 44)
		if not companionSkillsSceneBGWasUnhidden then
			local bg = skillPanel.PP_BG
			bg:SetHidden(false)
			companionSkillsSceneBGWasUnhidden = true
		end

		PP.Anchor(skillPanel, --[[#1]] TOPRIGHT, GuiRoot, TOPRIGHT, 0, 115,	--[[#2]] true, BOTTOMRIGHT, GuiRoot, BOTTOMRIGHT, 0, -104)

		--ZO_CompanionSkills_Panel_KeyboardSkillLineInfo
		PP.Anchor(skillLineInfo, --[[#1]] TOP, skillPanel, TOP, 112, -5, --[[#2]] false, LEFT, skillLinesContainer, RIGHT, 65, 0)

		--PP.Font(ZO_SkillsSkillInfoName, --[[Font]] PP.f.u67, 20, "outline", --[[Alpha]] nil, --[[Color]] nil, nil, nil, nil, --[[StyleColor]] 0, 0, 0, 0.5)
		--PP.Font(ZO_SkillsSkillInfoRank, --[[Font]] PP.f.u67, 54, "outline", --[[Alpha]] nil, --[[Color]] nil, nil, nil, nil, --[[StyleColor]] 0, 0, 0, 0.5)
		--PP.Anchor(ZO_SkillsSkillInfoRank, --[[#1]] LEFT, nil, LEFT, -50, 0)
		--PP.Bar(ZO_SkillsSkillInfoXPBar, --[[height]] 14, --[[fontSize]] 15)
		--PP.Anchor(ZO_SkillsSkillInfoXPBar, --[[#1]] TOPLEFT, ZO_SkillsSkillInfoRank, BOTTOMRIGHT, 15, -30, --[[#2]] true, BOTTOMRIGHT, ZO_SkillsSkillList, TOPRIGHT, -20, -16)

		--ZO_CompanionSkills_Panel_KeyboardSkillList

		PP.ScrollBar(skillList)
		PP.Anchor(skillList, --[[#1]] TOPLEFT, skillLineInfo, BOTTOMLEFT, -60, 2, --[[#2]] true, BOTTOMRIGHT, skillPanel, BOTTOMRIGHT, 0, -40)

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

		--PP.Anchor(ZO_SkillsAssignableActionBar, --[[#1]] TOPLEFT, skillList, BOTTOMLEFT, -50, 0)

		--ZO_SkillsSkillLinesContainer
		ZO_Scroll_SetMaxFadeDistance(skillLinesContainer, 10)
		PP.Anchor(skillLinesContainer, --[[#1]] TOPLEFT, skillPanel, TOPLEFT, 0, 5,	--[[#2]] true, BOTTOMLEFT, skillPanel, BOTTOMLEFT, 0, 34)
		PP.ScrollBar(skillLinesContainer)

		if sv.unwrappedSkillsTree then
			local tree = COMPANION_SKILLS_KEYBOARD.skillLinesTree
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

		end

		onCompanionSkillsSceneShownApplied = true
	end

	companionSkillsKeyboardScene:RegisterCallback("StateChange", function(oldState, newState)
        if newState == SCENE_SHOWN then
d("[PP]Companion skills scene showing")
			if not onCompanionSkillsSceneShownApplied then
				onCompanionSkillsSceneShown()
			end
        end
    end)


	--===============================================================================================--
	--Companion collections
	local companionCollectionsKeyboard = COMPANION_COLLECTION_BOOK_KEYBOARD
	local companionCollectionsKeyboardScene = COMPANION_COLLECTION_BOOK_KEYBOARD_SCENE
	--OnDeferredInit: Yes

	PP.onDeferredInitCheck(companionCollectionsKeyboard, function()
d("[PP]Companion collections book OnDeferredInit done")
	end)


	local function onCompanionCollectionsSceneShown()

	end
	companionCollectionsKeyboardScene:RegisterCallback("StateChange", function(oldState, newState)
        if newState == SCENE_SHOWN then
d("[PP]Companion collections scene shown")
			if HasActiveCompanion() then
				onCompanionCollectionsSceneShown()
			end
        end
    end)
end

















