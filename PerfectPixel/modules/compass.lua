local PP = PP --- @class PP

PP.compass = function ()
    local SV, DEF = PP:AddNewSavedVars(0.2, "Compass",
                                       {
                                           toggle      = true,
                                           col         = { 0 / 255, 0 / 255, 0 / 255, 0.6 },
                                           col_e       = { 0 / 255, 0 / 255, 0 / 255, 1 },
                                           -- Quest area
                                           qa_col      = { 96 / 255, 125 / 255, 139 / 255, 0.5 },
                                           qa_col_e    = { 96 / 255, 125 / 255, 139 / 255, 0 },
                                           -- Combat indicator
                                           ci_toggle   = true,
                                           ci_col      = { 222 / 255, 36 / 255, 33 / 255, 0.7 },
                                           -- Boss bar
                                           hideBossBar    = false,
                                           skin_backdrop  = "PerfectPixel/tex/tex_white.dds",
                                           skin_edge      = "PerfectPixel/tex/edge_outer_shadow_128x16.dds",
                                       })
    local refreshCompassTextures
    ---------------------------------------------
    table.insert(PP.optionsData,
                 {
                     type     = "submenu",
                     name     = GetString(PP_LAM_COMPASS),
                     controls =
                     {
                         {
                             type           = "checkbox",
                             name           = GetString(PP_LAM_ACTIVATE),
                             getFunc        = function () return SV.toggle end,
                             setFunc        = function (value) SV.toggle = value end,
                             default        = DEF.toggle,
                             requiresReload = true,
                         },
                         {
                             type             = "iconpicker",
                             name             = GetString(PP_LAM_LIST_STYLE_BACKDROP),
                             choices          = PP.LAM_MediaTable.backdrop,
                             choicesTooltips  = PP.LAM_MediaTable.name_backdrop,
                             getFunc          = function () return SV.skin_backdrop end,
                             setFunc          = function (texturePath)
                                 SV.skin_backdrop = texturePath
                                 if refreshCompassTextures then
                                     refreshCompassTextures()
                                 end
                             end,
                             maxColumns       = 3,
                             visibleRows      = 5,
                             iconSize         = 52,
                             default          = DEF.skin_backdrop,
                             width            = "half",
                             disabled         = function () return not SV.toggle end,
                         },
                         {
                             type             = "iconpicker",
                             name             = GetString(PP_LAM_LIST_STYLE_EDGE),
                             choices          = PP.LAM_MediaTable.edge,
                             choicesTooltips  = PP.LAM_MediaTable.name_edge,
                             getFunc          = function () return SV.skin_edge end,
                             setFunc          = function (texturePath)
                                 SV.skin_edge = texturePath
                                 if refreshCompassTextures then
                                     refreshCompassTextures()
                                 end
                             end,
                             maxColumns       = 3,
                             visibleRows      = 5,
                             iconSize         = 52,
                             default          = DEF.skin_edge,
                             width            = "half",
                             disabled         = function () return not SV.toggle end,
                         },
                         {
                             type           = "colorpicker",
                             name           = GetString(PP_LAM_COLOR),
                             getFunc        = function () return unpack(SV.col) end,
                             setFunc        = function (r, g, b, a) SV.col = { r, g, b, a } end,
                             width          = "full",
                             default        = { r = DEF.col[1], g = DEF.col[2], b = DEF.col[3], a = DEF.col[4] },
                             disabled       = function () return not SV.toggle end,
                             requiresReload = true,
                         },
                         {
                             type           = "colorpicker",
                             name           = GetString(PP_LAM_EDGE_COLOR),
                             getFunc        = function () return unpack(SV.col_e) end,
                             setFunc        = function (r, g, b, a) SV.col_e = { r, g, b, a } end,
                             width          = "full",
                             default        = { r = DEF.col_e[1], g = DEF.col_e[2], b = DEF.col_e[3], a = DEF.col_e[4] },
                             disabled       = function () return not SV.toggle end,
                             requiresReload = true,
                         },
                         -- Quest area---------------------------------
                         {
                             type = "header",
                             name = GetString(PP_LAM_COMPASS_QUEST),
                         },
                         {
                             type     = "colorpicker",
                             name     = GetString(PP_LAM_COLOR),
                             getFunc  = function () return unpack(SV.qa_col) end,
                             setFunc  = function (r, g, b, a) SV.qa_col = { r, g, b, a } end,
                             width    = "full",
                             default  = { r = DEF.qa_col[1], g = DEF.qa_col[2], b = DEF.qa_col[3], a = DEF.qa_col[4] },
                             disabled = function () return not SV.toggle end,
                         },
                         {
                             type     = "colorpicker",
                             name     = GetString(PP_LAM_EDGE_COLOR),
                             getFunc  = function () return unpack(SV.qa_col_e) end,
                             setFunc  = function (r, g, b, a) SV.qa_col_e = { r, g, b, a } end,
                             width    = "full",
                             default  = { r = DEF.qa_col_e[1], g = DEF.qa_col_e[2], b = DEF.qa_col_e[3], a = DEF.qa_col_e[4] },
                             disabled = function () return not SV.toggle end,
                         },
                         -- Combat indicator---------------------------
                         {
                             type = "header",
                             name = GetString(PP_LAM_COMPASS_COMBAT),
                         },
                         {
                             type           = "checkbox",
                             name           = GetString(PP_LAM_ACTIVATE),
                             getFunc        = function () return SV.ci_toggle end,
                             setFunc        = function (value) SV.ci_toggle = value end,
                             default        = DEF.ci_toggle,
                             disabled       = function () return not SV.toggle end,
                             requiresReload = true,
                         },
                         {
                             type     = "colorpicker",
                             name     = GetString(PP_LAM_EDGE_COLOR),
                             getFunc  = function () return unpack(SV.ci_col) end,
                             setFunc  = function (r, g, b, a) SV.ci_col = { r, g, b, a } end,
                             width    = "full",
                             default  = { r = DEF.ci_col[1], g = DEF.ci_col[2], b = DEF.ci_col[3], a = DEF.ci_col[4] },
                             disabled = function () return not SV.toggle or not SV.ci_toggle end,
                         },
                         -- Boss bar-----------------------------------
                         {
                             type = "header",
                             name = "Boss Bar",
                         },
                         {
                             type           = "checkbox",
                             name           = "Hide boss bar",
                             getFunc        = function () return SV.hideBossBar end,
                             setFunc        = function (value) SV.hideBossBar = value end,
                             default        = DEF.hideBossBar,
                             disabled       = function () return not SV.toggle end,
                             requiresReload = true,
                         },
                     },
                 })
    -- ===============================================================================================--
    if not SV.toggle then return end

    local compassFrame = ZO_CompassFrame
    local compassBackdropControls = {}
    -- CompassAreaTextureAnimationIn animation 5 is the SizeAnimation. Compass.lua resizes that same animation on EVENT_SCREEN_RESIZED.
    local AREA_TEXTURE_SIZE_ANIMATION_INDEX = 5

    local function GetCompassEdgeTextureDimensions(edgeTexturePath)
        local edgeFileWidth, edgeFileHeight = edgeTexturePath:match("(%d+)x(%d+)%.dds$")
        edgeFileWidth = tonumber(edgeFileWidth)
        edgeFileHeight = tonumber(edgeFileHeight)
        if not edgeFileWidth or not edgeFileHeight then
            return 128, 16, 16
        end
        return edgeFileWidth, edgeFileHeight, edgeFileHeight
    end

    local function ApplyCompassBackdropTextures(backdropControl)
        local edgeFileWidth, edgeFileHeight, edgeThickness = GetCompassEdgeTextureDimensions(SV.skin_edge)
        backdropControl:SetCenterTexture(SV.skin_backdrop, 8, 0)
        backdropControl:SetEdgeTexture(SV.skin_edge, edgeFileWidth, edgeFileHeight, edgeThickness, 0)
    end

    local function RegisterCompassBackdrop(backdropControl)
        compassBackdropControls[#compassBackdropControls + 1] = backdropControl
        ApplyCompassBackdropTextures(backdropControl)
    end

    local function GetCompassFrameCapWidth()
        return ZO_CompassFrameLeft:GetWidth()
    end

    local function GetAreaTextureEndDimensions(areaTextureControl)
        local parentWidth, parentHeight = areaTextureControl:GetParent():GetDimensions()
        local capWidth = GetCompassFrameCapWidth()
        return parentWidth + (capWidth * 2), parentHeight
    end

    local function ApplyCompassFrameBackdropAnchors(compassFrameBackdrop)
        local capWidth = GetCompassFrameCapWidth()
        PP.Anchor(compassFrameBackdrop, --[[#1]] TOPLEFT, compassFrame, TOPLEFT, -capWidth, 0, --[[#2]] true, BOTTOMRIGHT, compassFrame, BOTTOMRIGHT, capWidth, 0)
    end

    local function HideAndLockCompassFrameTextures()
        ZO_CompassFrameLeft:SetHidden(true)
        ZO_CompassFrameRight:SetHidden(true)
        ZO_CompassFrameCenter:SetHidden(true)
        ZO_CompassFrameCenterTopMungeOverlay:SetHidden(true)
        ZO_CompassFrameCenterBottomMungeOverlay:SetHidden(true)

        PP:SetLockFn(ZO_CompassFrameLeft, "SetHidden")
        PP:SetLockFn(ZO_CompassFrameRight, "SetHidden")
        PP:SetLockFn(ZO_CompassFrameCenter, "SetHidden")
        PP:SetLockFn(ZO_CompassFrameCenterTopMungeOverlay, "SetHidden")
        PP:SetLockFn(ZO_CompassFrameCenterBottomMungeOverlay, "SetHidden")
    end

    local compassFrameBackdrop = CreateControl("$(parent)Backdrop", compassFrame, CT_BACKDROP)
    compassFrameBackdrop:SetInsets(5, 5, -5, -5)
    compassFrameBackdrop:SetCenterColor(SV.col[1], SV.col[2], SV.col[3], SV.col[4])
    compassFrameBackdrop:SetEdgeColor(SV.col_e[1], SV.col_e[2], SV.col_e[3], SV.col_e[4])
    RegisterCompassBackdrop(compassFrameBackdrop)

    HideAndLockCompassFrameTextures()
    ApplyCompassFrameBackdropAnchors(compassFrameBackdrop)

    -- CompassFrame:ApplyStyle reapplies the platform template, which changes cap width and, on gamepad, boss-bar height.
    ZO_PostHook(COMPASS_FRAME, "ApplyStyle", function ()
        ApplyCompassFrameBackdropAnchors(compassFrameBackdrop)
    end)

    -- Combat indicator---------------------------------------------------------------------------------
    if SV.ci_toggle then
        local function OnPlayerCombatState()
            if IsUnitInCombat("player") then
                compassFrameBackdrop:SetEdgeColor(SV.ci_col[1], SV.ci_col[2], SV.ci_col[3], SV.ci_col[4])
            else
                compassFrameBackdrop:SetEdgeColor(SV.col_e[1], SV.col_e[2], SV.col_e[3], SV.col_e[4])
            end
        end
        compassFrameBackdrop:RegisterForEvent(EVENT_PLAYER_COMBAT_STATE, OnPlayerCombatState)
        compassFrameBackdrop:RegisterForEvent(EVENT_PLAYER_ACTIVATED, OnPlayerCombatState)
    end

    -- Quest area---------------------------------------------------------------------------------------
    local function HideAreaTexturePieces(areaTexture)
        areaTexture.center:SetHidden(true)
        areaTexture.left:SetHidden(true)
        areaTexture.right:SetHidden(true)
    end

    local function ApplyQuestAreaBackdrop(areaTexture)
        local questAreaBackdrop = areaTexture.backdrop
        if not questAreaBackdrop then
            questAreaBackdrop = CreateControl("$(parent)Backdrop", areaTexture, CT_BACKDROP)
            areaTexture.backdrop = questAreaBackdrop
            PP.Anchor(questAreaBackdrop, --[[#1]] TOPLEFT, areaTexture, TOPLEFT, 0, 0, --[[#2]] true, BOTTOMRIGHT, areaTexture, BOTTOMRIGHT, 0, 0)
            questAreaBackdrop:SetInsets(5, 5, -5, -5)
            RegisterCompassBackdrop(questAreaBackdrop)
        end

        questAreaBackdrop:SetCenterColor(SV.qa_col[1], SV.qa_col[2], SV.qa_col[3], SV.qa_col[4])
        questAreaBackdrop:SetEdgeColor(SV.qa_col_e[1], SV.qa_col_e[2], SV.qa_col_e[3], SV.qa_col_e[4])
    end

    -- Returning true skips Compass:SetAreaTexturePlatformTextures, which would apply areapin2frame / area2frameAnim.
    ZO_PreHook(Compass, "SetAreaTexturePlatformTextures", function (self, areaTexture, pinType)
        areaTexture.pinType = pinType or areaTexture.pinType
        HideAreaTexturePieces(areaTexture)
        ApplyQuestAreaBackdrop(areaTexture)
        return true
    end)

    local function ApplyAreaTextureEndWidth(areaTexture)
        local sizeAnimation = areaTexture.animationIn:GetAnimation(AREA_TEXTURE_SIZE_ANIMATION_INDEX)
        local animatedControl = sizeAnimation:GetAnimatedControl()
        local areaTextureWidth = GetAreaTextureEndDimensions(animatedControl)
        if sizeAnimation:IsPlaying() then
            sizeAnimation:SetEndWidth(areaTextureWidth)
        else
            animatedControl:SetWidth(areaTextureWidth)
        end
    end

    local function ApplyActiveAreaTextureWidths()
        local areaAnimationPools = COMPASS.areaAnimationPools
        if not areaAnimationPools then
            return
        end

        for _, areaAnimationPool in pairs(areaAnimationPools) do
            for _, animationTimeline in areaAnimationPool:ActiveObjectIterator() do
                local areaTexture = animationTimeline.areaTexture
                if areaTexture and areaTexture.animationIn then
                    ApplyAreaTextureEndWidth(areaTexture)
                end
            end
        end
    end

    ZO_PostHook("ZO_Compass_AnimationIn_Size", function (animation, animatingControl)
        local pinControl = animatingControl.pin
        if not pinControl then
            return
        end

        local pinScale = pinControl:GetScale()
        local areaTextureWidth, areaTextureHeight = GetAreaTextureEndDimensions(animatingControl)
        animation:SetStartAndEndWidth(32 * pinScale, areaTextureWidth)
        animation:SetStartAndEndHeight(32 * pinScale, areaTextureHeight)
    end)

    -- CompassFrame:UpdateWidth is the EVENT_SCREEN_RESIZED handler. Posthook it so the stock registration is left in place.
    ZO_PostHook(COMPASS_FRAME, "UpdateWidth", function ()
        ApplyActiveAreaTextureWidths()
    end)

    -- CARDINAL_DIRECTION---------------------------------------------------------------------------------------
    local function ApplyCardinalDirectionFont()
        local cardinalFont = ZO_CreateFontString(PP.f.u67, 17, FONT_STYLE_OUTLINE)
        local compassContainer = COMPASS.container
        compassContainer:SetCardinalDirection(GetString(SI_COMPASS_NORTH_ABBREVIATION), cardinalFont, CARDINAL_DIRECTION_NORTH)
        compassContainer:SetCardinalDirection(GetString(SI_COMPASS_EAST_ABBREVIATION), cardinalFont, CARDINAL_DIRECTION_EAST)
        compassContainer:SetCardinalDirection(GetString(SI_COMPASS_WEST_ABBREVIATION), cardinalFont, CARDINAL_DIRECTION_WEST)
        compassContainer:SetCardinalDirection(GetString(SI_COMPASS_SOUTH_ABBREVIATION), cardinalFont, CARDINAL_DIRECTION_SOUTH)
    end

    ZO_PostHook(Compass, "SetCardinalDirections", function ()
        ApplyCardinalDirectionFont()
    end)
    ApplyCardinalDirectionFont()

    -- ZO_BossBar---------------------------------------------------------------------------------------
    local function ApplyBossBarStatusBar(statusBar)
        statusBar:SetTexture(SV.skin_backdrop)
        statusBar:SetTextureCoords(0, 1, 0, 1)
        -- The keyboard template's leading edge sits in the middle of the 23px bar and leaves a notch.
        statusBar:SetLeadingEdge(nil, nil, nil)
        statusBar:EnableLeadingEdge(false)
    end

    local function ApplyBossBarStyle()
        ZO_BossBarBracketLeft:SetHidden(true)
        ZO_BossBarBracketRight:SetHidden(true)

        local barLeft = ZO_BossBarHealth:GetNamedChild("BarLeft")
        local barRight = ZO_BossBarHealth:GetNamedChild("BarRight")
        local barLeftGloss = barLeft:GetNamedChild("Gloss")
        local barRightGloss = barRight:GetNamedChild("Gloss")

        ApplyBossBarStatusBar(barLeft)
        ApplyBossBarStatusBar(barRight)
        ApplyBossBarStatusBar(barLeftGloss)
        ApplyBossBarStatusBar(barRightGloss)
        barLeftGloss:SetColor(150 / 255, 150 / 255, 150 / 255, 0.2)
        barRightGloss:SetColor(150 / 255, 150 / 255, 150 / 255, 0.2)

        local healthText = ZO_BossBarHealthText
        PP.Font(healthText, --[[Font]] PP.f.u67, 16, "outline")
        healthText:SetHorizontalAlignment(TEXT_ALIGN_CENTER)
        healthText:SetVerticalAlignment(TEXT_ALIGN_CENTER)
        local healthTextOffsetY = 2
        PP.Anchor(healthText, --[[#1]] LEFT, nil, LEFT, 0, healthTextOffsetY, --[[#2]] true, RIGHT, nil, RIGHT, 0, healthTextOffsetY)
    end

    ApplyBossBarStyle()
    -- BossBar:ApplyStyle reapplies ZO_BossBar_*_Template, which restores attributeBar_dynamic_fill.dds.
    ZO_PostHook(BOSS_BAR, "ApplyStyle", function ()
        ApplyBossBarStyle()
    end)

    refreshCompassTextures = function ()
        for backdropIndex = 1, #compassBackdropControls do
            ApplyCompassBackdropTextures(compassBackdropControls[backdropIndex])
        end
        ApplyBossBarStyle()
    end

    if SV.hideBossBar then
        COMPASS_FRAME:SetBossBarHiddenForReason("PerfectPixel", true)
    end
end