local PP = PP ---@class PP
local removeFragmentsFromScene = PP.removeFragmentsFromScene

PP.friendsListGroup = function()
	local scenes = {
		{ scene = FRIENDS_LIST_SCENE,	gVar = FRIENDS_LIST,	},
		{ scene = IGNORE_LIST_SCENE,	gVar = IGNORE_LIST,		},
	}
	local fragments	= { FRAME_PLAYER_FRAGMENT, RIGHT_BG_FRAGMENT, TITLE_FRAGMENT, CONTACTS_TITLE_FRAGMENT, }

	for _, sceneInfo in ipairs(scenes) do
		local scene = sceneInfo.scene
		local gVar = sceneInfo.gVar

		removeFragmentsFromScene(scene, fragments)

		local tlc	= gVar.control
		local list	= gVar.list

		PP:CreateBackground(tlc, --[[#1]] nil, nil, nil, -10, -10, --[[#2]] nil, nil, nil, 0, 10)
		PP.Anchor(tlc, --[[#1]] TOPRIGHT, GuiRoot, TOPRIGHT, 0, 120, --[[#2]] true, BOTTOMRIGHT, GuiRoot, BOTTOMRIGHT, 0, -70)

		PP.Anchor(list, --[[#1]] nil, nil, nil, 0, 3, --[[#2]] true, nil, nil, nil, 0, 0)
		PP.ScrollBar(list,	--[[sb_c]] 180, 180, 180, 0.7, --[[bd_c]] 20, 20, 20, 0.7, false)
		ZO_ScrollList_Commit(list)
	end
end



