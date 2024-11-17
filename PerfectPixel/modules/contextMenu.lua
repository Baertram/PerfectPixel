PP.contextMenus = function()
	--ZO_Menu
	ZO_PreHookHandler(ZO_Menu, 'OnShow', function()
		ZO_MenuBG:SetCenterTexture(nil, 4, 0)
		ZO_MenuBG:SetCenterColor(10/255, 10/255, 10/255, 0.96)
		ZO_MenuBG:SetEdgeTexture(nil, 1, 1, 1, 0)
		ZO_MenuBG:SetEdgeColor(60/255, 60/255, 60/255, 1)
		ZO_MenuBG:SetInsets(-1, -1, 1, 1)
		ZO_MenuBGMungeOverlay:SetHidden(true)
	end)

	PP.Anchor(ZO_MenuBG, --[[#1]] TOPLEFT, nil, TOPLEFT, -2, 4, --[[#2]] true, BOTTOMRIGHT, nil, BOTTOMRIGHT, -2, -4)
	-- ZO_MenuBG:SetInheritAlpha(false)

	ZO_MenuHighlight:SetCenterTexture(nil, 4, 0)
	ZO_MenuHighlight:SetCenterColor(96/255*0.3, 125/255*0.3, 139/255*0.3, 1)
	ZO_MenuHighlight:SetEdgeTexture(nil, 1, 1, 1, 0)
	ZO_MenuHighlight:SetEdgeColor(96/255*0.5, 125/255*0.5, 139/255*0.5, 0)
	ZO_MenuHighlight:SetInsets(0, 0, 0, 0)
	-- ZO_MenuHighlight:SetInheritAlpha(false)

	ZO_PreHook("ZO_Menu_SelectItem", function(control)
		control:SetWidth(ZO_Menu:GetWidth() - 16)
		ZO_MenuHighlight:ClearAnchors()
		ZO_MenuHighlight:SetAnchor(TOPLEFT, control, TOPLEFT, -6, 0)
		ZO_MenuHighlight:SetAnchor(BOTTOMRIGHT, control, BOTTOMRIGHT, 2, 0)
		ZO_MenuHighlight:SetHidden(false)
		control.nameLabel:SetColor(control.nameLabel.highlightColor:UnpackRGBA())
		return true
	end)
	--> See compatibility.lua for "LibCustomMenu" submenu changes!
end