local PP = PP
local removeFragmentsFromScene = PP.removeFragmentsFromScene

PP.helpSceneGroup = function()
	local scenes = {
		{ scene = SCENE_MANAGER:GetScene('helpTutorials'), gVar = HELP, },
		{ scene = HELP_EMOTES_SCENE,                       gVar = KEYBOARD_PLAYER_EMOTE, },
		{ scene = HELP_CUSTOMER_SUPPORT_SCENE,             gVar = HELP_CUSTOMER_SUPPORT_KEYBOARD, },
	}
	local fragments	= { FRAME_PLAYER_FRAGMENT, FRAME_TARGET_STANDARD_RIGHT_PANEL_FRAGMENT, RIGHT_BG_FRAGMENT, TREE_UNDERLAY_FRAGMENT, TITLE_FRAGMENT, HELP_TITLE_FRAGMENT, }

	for _, sceneInfo in ipairs(scenes) do
		local scene = sceneInfo.scene
		local gVar = sceneInfo.gVar

		removeFragmentsFromScene(scene, fragments)

		local tlc = gVar.control or gVar

		PP:CreateBackground(tlc, --[[#1]] nil, nil, nil, -10, -10, --[[#2]] nil, nil, nil, 0, 10)
		PP.Anchor(tlc, --[[#1]] TOPRIGHT, GuiRoot, TOPRIGHT, 0, 120, --[[#2]] true, BOTTOMRIGHT, GuiRoot, BOTTOMRIGHT, 0, -70)
	end
end

