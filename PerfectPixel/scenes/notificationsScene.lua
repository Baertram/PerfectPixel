local PP = PP ---@class PP
local removeFragmentsFromScene = PP.removeFragmentsFromScene

PP.notificationsScene = function()
	local scenes = {
		{ scene = NOTIFICATIONS_SCENE,	gVar = ZO_Notifications, },
	}
	local fragments	= { FRAME_PLAYER_FRAGMENT, FRAME_TARGET_STANDARD_RIGHT_PANEL_FRAGMENT, RIGHT_BG_FRAGMENT, TITLE_FRAGMENT, NOTIFICATIONS_TITLE_FRAGMENT, }

	for _, sceneInfo in ipairs(scenes) do
		local scene = sceneInfo.scene
		local gVar = sceneInfo.gVar

		removeFragmentsFromScene(scene, fragments)

		local tlc = gVar.control or gVar

		PP:CreateBackground(tlc, --[[#1]] nil, nil, nil, -10, -10, --[[#2]] nil, nil, nil, 0, 10)
		PP.Anchor(tlc, --[[#1]] TOPRIGHT, GuiRoot, TOPRIGHT, 0, 120, --[[#2]] true, BOTTOMRIGHT, GuiRoot, BOTTOMRIGHT, 0, -70)

		ZO_ScrollList_Commit(tlc:GetNamedChild("List"))
	end
end