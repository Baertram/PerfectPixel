PP.skillsScene = function()

	local skillsScene = SCENE_MANAGER:GetScene('skills')

	skillsScene:RemoveFragment(FRAME_PLAYER_FRAGMENT)
	skillsScene:RemoveFragment(FRAME_EMOTE_FRAGMENT_SKILLS)
	skillsScene:RemoveFragment(RIGHT_BG_FRAGMENT)
	skillsScene:RemoveFragment(TREE_UNDERLAY_FRAGMENT)
	skillsScene:RemoveFragment(TITLE_FRAGMENT)
	skillsScene:RemoveFragment(SKILLS_TITLE_FRAGMENT)
	skillsScene:RemoveFragment(KEYBIND_STRIP_MUNGE_BACKDROP_FRAGMENT)

	ZO_PreHook(MEDIUM_LEFT_PANEL_BG_FRAGMENT, "Show", function()
		if SCENE_MANAGER:GetScene('skills'):IsShowing() then
			return true
		else
			return
		end
	end)
	
	PP.Anchor(ZO_Skills, --[[#1]] TOPRIGHT, GuiRoot, TOPRIGHT, 0, 85,	--[[#2]] true, BOTTOMRIGHT, GuiRoot, BOTTOMRIGHT, 1, -104)
	PP.mainBackdrop(ZO_Skills,				'skills', --[[backdrop]] TOPLEFT, BOTTOMRIGHT, -10, -5, 0, 44, --[[tex]] PP.t.bg1, 8, 1, --[[bd]] 10, 10, 10, .8, --[[edge]] 0, 0, 0, 1, --[[texture]] true, .7)
	PP.mainBackdrop(ZO_KeybindStripControl,	'skills', --[[backdrop]] TOPLEFT, BOTTOMRIGHT, -6, 0, 2, 6, --[[tex]] PP.t.bg1, 8, 1, --[[bd]] 10, 10, 10, .6, --[[edge]] 0, 0, 0, 1, --[[texture]] false, 0)

--ZO_SkillsSkillList
	PP.ListBackdrop(ZO_SkillsSkillList, -3, -3, -1, 3, --[[tex]] nil, 8, 0, --[[bd]] 5, 5, 5, .6, --[[edge]] 30, 30, 30, .6)
	PP.ScrollBar(ZO_SkillsSkillList,	--[[sb_c]] 180, 180, 180, .7, --[[bd_c]] 20, 20, 20, .7, --[[edge]] 40, 40, 40, .9)
	
	PP.Anchor(ZO_SkillsSkillList, --[[#1]] TOPLEFT, ZO_SkillsSkillInfo, BOTTOMLEFT, -60, 0, --[[#2]] true, BOTTOMRIGHT, ZO_Skills, BOTTOMRIGHT, 1, -40)

	ZO_SkillsSkillList.useFadeGradient = nil
	ZO_SkillsSkillList.dataTypes[2].height = 28

--ZO_SkillsSkillLinesContainer
	PP.Anchor(ZO_SkillsSkillLinesContainer, --[[#1]] TOPLEFT, ZO_SkillsSkyShards, BOTTOMLEFT, 0, 0,	--[[#2]] true, BOTTOMLEFT, ZO_Skills, BOTTOMLEFT, 0, -50)

--ZO_SkillsAdvisor_Keyboard_TopLevel	--ZO_SharedMediumLeftPanelBackground
	PP.Backdrop(ZO_Skills, ZO_SkillsAdvisor_Keyboard_TopLevel, --[[#1]] nil, nil, nil, 0, -30, --[[#2]] nil, nil, nil, 32, 10, --[[tex_1]] PP.t.bg1, 8, 1, --[[bd]] 10, 10, 10, .8, --[[edge]] 0, 0, 0, 1)
	PP.ListBackdrop(ZO_SkillsAdvisor_Suggestions_Keyboard_TopLevelSkillSuggestionList, -11, -3, -1, 3, --[[tex]] nil, 8, 0, --[[bd]] 10, 10, 10, .6, --[[edge]] 30, 30, 30, .6)
	PP.ScrollBar(ZO_SkillsAdvisor_Suggestions_Keyboard_TopLevelSkillSuggestionList, --[[sb_c]] 180, 180, 180, .7, --[[bd_c]] 20, 20, 20, .7, --[[edge]] 40, 40, 40, .9)
	PP.Anchor(ZO_SkillsAdvisor_Suggestions_Keyboard_TopLevel, --[[#1]] TOPLEFT, ZO_SkillsAdvisor_Keyboard_TopLevelDivider, BOTTOMLEFT, 3, -5, --[[#2]] true, BOTTOMRIGHT, ZO_SkillsAdvisor_Keyboard_TopLevel, BOTTOMRIGHT, 30, 4)
	
	ZO_SkillsAdvisor_Suggestions_Keyboard_TopLevelSkillSuggestionList.useFadeGradient = nil

end

















