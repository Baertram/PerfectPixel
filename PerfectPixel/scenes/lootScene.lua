PP.lootScene = function()
	
	local lootScene = SCENE_MANAGER:GetScene('loot')
	lootScene:RemoveFragment(FRAME_EMOTE_FRAGMENT_LOOT)
	lootScene:RemoveFragment(KEYBIND_STRIP_MUNGE_BACKDROP_FRAGMENT)

	PP.mainBackdrop(ZO_Loot, 'loot', --[[backdrop]] TOPLEFT, BOTTOMRIGHT, -6, 34, 2, -44, --[[tex]] PP.t.bg1, 8, 1, --[[bd]] 10, 10, 10, .7, --[[edge]] 0, 0, 0, 1, --[[texture]] false, 0)

	PP.ListBackdrop(ZO_LootAlphaContainerList, -3, -3, -1, 3, --[[tex]] nil, 8, 0, --[[bd]] 5, 5, 5, .6, --[[edge]] 30, 30, 30, .6)
	PP.ScrollBar(ZO_LootAlphaContainerList,	--[[sb_c]] 180, 180, 180, .7, --[[bd_c]] 20, 20, 20, .7, --[[edge]] 40, 40, 40, .9)

	ZO_LootAlphaContainerBG:SetHidden(true)
	ZO_LootAlphaContainerDivider:SetHidden(true)

	PP.Font(ZO_LootTitle, --[[Font]] PP.f.u67, 20, "outline", --[[Alpha]] nil, --[[Color]] nil, nil, nil, nil, --[[StyleColor]] 0, 0, 0, .5)

	PP.Anchor(ZO_LootAlphaContainerButton1, --[[#1]] BOTTOMRIGHT, ZO_LootAlphaContainer, BOTTOMRIGHT, -10, -10)

	PP.Font(ZO_LootAlphaContainerButton1KeyLabel,	--[[Font]] PP.f.u57, 16, "outline", --[[Alpha]] nil, --[[Color]] nil, nil, nil, nil, --[[StyleColor]] 0, 0, 0, .5)
	PP.Font(ZO_LootAlphaContainerButton1NameLabel,	--[[Font]] PP.f.u67, 18, "outline", --[[Alpha]] nil, --[[Color]] nil, nil, nil, nil, --[[StyleColor]] 0, 0, 0, .5)
	PP.Font(ZO_LootAlphaContainerButton2KeyLabel,	--[[Font]] PP.f.u57, 16, "outline", --[[Alpha]] nil, --[[Color]] nil, nil, nil, nil, --[[StyleColor]] 0, 0, 0, .5)
	PP.Font(ZO_LootAlphaContainerButton2NameLabel,	--[[Font]] PP.f.u67, 18, "outline", --[[Alpha]] nil, --[[Color]] nil, nil, nil, nil, --[[StyleColor]] 0, 0, 0, .5)

	ZO_LootAlphaContainerList.uniformControlHeight = 42
	ZO_LootAlphaContainerList.useFadeGradient = nil

	for i = 1, 2 do
		local ZO_LootAlphaContainerList = ZO_LootAlphaContainerList.dataTypes[i]
		ZO_LootAlphaContainerList.pool:SetCustomAcquireBehavior(function(control)
			control:SetHeight(40)
			if control:GetNamedChild("Button") then
				local button = control:GetNamedChild("Button")
					button:SetDimensions(36, 36)
					PP.Anchor(button, --[[#1]] CENTER, control, LEFT, 60, 0)
			end
			if control:GetNamedChild("MultiIcon") then
				local multiIcon = control:GetNamedChild("MultiIcon")
					multiIcon:SetDimensions(36, 36)
					PP.Anchor(multiIcon, --[[#1]] CENTER, control, LEFT, 60, 0)
			end
			if control:GetNamedChild("Name") then
				local name = control:GetNamedChild("Name")
					PP.Font(name, --[[Font]] PP.f.u67, 15, "outline", --[[Alpha]] nil, --[[Color]] nil, nil, nil, nil, --[[StyleColor]] 0, 0, 0, .5)
					PP.Anchor(name, --[[#1]] LEFT, control, LEFT, 110, -1)
			end
			if control:GetNamedChild("ButtonStackCount") then
				local stack = control:GetNamedChild("ButtonStackCount")
					PP.Font(stack, --[[Font]] PP.f.u67, 15, "outline", --[[Alpha]] nil, --[[Color]] nil, nil, nil, nil, --[[StyleColor]] 0, 0, 0, .5)
					PP.Anchor(stack, --[[#1]] LEFT, control, LEFT, 76, 8)
			end
			if control:GetNamedChild("SellPrice") then
				local sp = control:GetNamedChild("SellPrice")
					PP.Font(sp, --[[Font]] PP.f.u67, 15, "outline", --[[Alpha]] nil, --[[Color]] nil, nil, nil, nil, --[[StyleColor]] 0, 0, 0, .5)
					PP.Anchor(sp, --[[#1]] RIGHT, control, RIGHT, -4, 0)
			end
			if control:GetNamedChild("Bg") then
				local bg = control:GetNamedChild("Bg")
					bg:SetTexture(PP.t.clear)
			end
			if not control:GetNamedChild("Backdrop") and (i == 1) then
				CreateControl( control:GetName() .. "Backdrop", control, CT_BACKDROP)
				local backdrop = control:GetNamedChild("Backdrop")
					PP.Anchor(backdrop, --[[#1]] TOPLEFT, control, TOPLEFT, 0, 0, --[[#2]] true, BOTTOMRIGHT, control, BOTTOMRIGHT, 0, 0)
					backdrop:SetCenterColor(20/255, 20/255, 20/255, .6)
					backdrop:SetCenterTexture(nil, 4, 0)
					backdrop:SetEdgeColor(40/255, 40/255, 40/255, .9)
					backdrop:SetEdgeTexture(nil, 1, 1, 1, 0)
					backdrop:SetInsets(1, 1, -1, -1)
					backdrop:SetDrawLayer(0)
					backdrop:SetDrawLevel(0)
					backdrop:SetDrawTier(0)
					backdrop:SetPixelRoundingEnabled(false)
					backdrop:SetInheritAlpha(false)
					backdrop:SetInheritScale(false)
			end
			if control:GetNamedChild("Highlight") then
				local highlight = control:GetNamedChild("Highlight")
				highlight:SetTexture(PP.t.clear)
			end
		end)
	end
	
	ZO_PreHook(LOOT_WINDOW_FRAGMENT, "AnimateNextShow",	function() return true end)
end