local PP = PP --- @class PP

local HIGHLIGHT_EDGE_OUTSET = 2

local function ApplyMenuHighlightBackdrop(highlightControl)
    highlightControl:SetCenterTexture("", 4, 0)
    highlightControl:SetCenterColor((96 / 255) * 0.3, (125 / 255) * 0.3, (139 / 255) * 0.3, 1)
    highlightControl:SetEdgeTexture("", 1, 1, 1, 0)
    highlightControl:SetEdgeColor((96 / 255) * 0.5, (125 / 255) * 0.5, (139 / 255) * 0.5, 0)
    highlightControl:SetInsets(0, 0, 0, 0)
end

local function ApplyMenuHighlightAnchors(highlightControl, itemControl)
    local menuLeft = ZO_Menu:GetLeft()
    local menuRight = ZO_Menu:GetRight()
    local itemLeft = itemControl:GetLeft()
    local itemRight = itemControl:GetRight()
    if not (menuLeft and menuRight and itemLeft and itemRight) then
        return
    end

    local menuPad = ZO_Menu.menuPad
    local highlightInsetLeft = HIGHLIGHT_EDGE_OUTSET
    local highlightInsetRight = menuPad - HIGHLIGHT_EDGE_OUTSET
    local highlightOffsetLeft = (menuLeft + highlightInsetLeft) - itemLeft
    local highlightOffsetRight = (menuRight - highlightInsetRight) - itemRight

    highlightControl:ClearAnchors()
    ZO_Anchor:New(TOPLEFT, itemControl, TOPLEFT, highlightOffsetLeft, 0):AddToControl(highlightControl)
    ZO_Anchor:New(BOTTOMRIGHT, itemControl, BOTTOMRIGHT, highlightOffsetRight, 0):AddToControl(highlightControl)
end

local function ApplyAcquiredMenuHighlights()
    local menuItems = ZO_Menu.items
    if not menuItems then
        return
    end

    for _, menuEntry in pairs(menuItems) do
        local itemControl = menuEntry.item
        local highlightControl = itemControl and itemControl.highlight
        if highlightControl then
            ApplyMenuHighlightBackdrop(highlightControl)
            ApplyMenuHighlightAnchors(highlightControl, itemControl)
        end
    end
end

PP.contextMenus = function ()
    -- ZO_Menu
    ZO_PreHookHandler(ZO_Menu, "OnShow", function ()
        ZO_MenuBG:SetCenterTexture("", 4, 0)
        ZO_MenuBG:SetCenterColor(10 / 255, 10 / 255, 10 / 255, 0.96)
        ZO_MenuBG:SetEdgeTexture("", 1, 1, 1, 0)
        ZO_MenuBG:SetEdgeColor(60 / 255, 60 / 255, 60 / 255, 1)
        ZO_MenuBG:SetInsets(-1, -1, 1, 1)
        ZO_MenuBGMungeOverlay:SetHidden(true)
        zo_callLater(ApplyAcquiredMenuHighlights, 0)
    end)

    PP.Anchor(ZO_MenuBG, --[[#1]] TOPLEFT, nil, TOPLEFT, -2, 4, --[[#2]] true, BOTTOMRIGHT, nil, BOTTOMRIGHT, -2, -4)
    -- ZO_MenuBG:SetInheritAlpha(false)

    ApplyMenuHighlightBackdrop(ZO_MenuHighlight)
    -- ZO_MenuHighlight:SetInheritAlpha(false)

    ZO_PostHook("ZO_Menu_SelectItem", function (itemControl)
        ApplyMenuHighlightAnchors(ZO_MenuHighlight, itemControl)
    end)

    ZO_PostHook("ZO_Menu_AcquireAndApplyHighlight", function (itemControl)
        local highlightControl = itemControl.highlight
        if highlightControl then
            ApplyMenuHighlightBackdrop(highlightControl)
            ApplyMenuHighlightAnchors(highlightControl, itemControl)
        end
    end)
    -- > See compatibility.lua for "LibCustomMenu" submenu changes!
end