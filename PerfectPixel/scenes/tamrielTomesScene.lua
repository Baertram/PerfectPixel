local PP = PP --- @class PP

PP.tamrielTomesScene = function ()
    --Tamriel Tomes will be added with API101049 first
    if TAMRIEL_TOMES_SCREEN_KEYBOARD == nil then return end


    -- TimedActivities keyboard scene - ZO_TimedActivities_KeyboardTL--------------------------------
    local timedActivitiesScene = SCENE_MANAGER:GetScene("TimedActivitiesKeyboard")

    timedActivitiesScene:RemoveFragment(RIGHT_BG_FRAGMENT)
    timedActivitiesScene:RemoveFragment(TITLE_FRAGMENT)

    -- Class-level hook: applies to every tile instance, called once per tile control creation
    SecurePostHook(ZO_TimedActivityTile_Keyboard, "PostInitializePlatform", function (self)
        PP.Bar(self.progressBar, 14, 15)
    end)

    PP.onDeferredInitCheck(TIMED_ACTIVITIES_KEYBOARD, function ()
        -- ZO_TimedActivities_KeyboardTLBG is an existing CT_BACKDROP (ZO_DefaultBackdrop + AnchorFill)
        -- Passing it directly reskins it with PP style rather than creating a second backdrop
        PP:CreateBackground(ZO_TimedActivities_KeyboardTLBG)

        PP.Font(ZO_TimedActivities_KeyboardTLContentHeaderTitle, --[[Font]] PP.f.u67, 24, "outline")
        PP.Font(ZO_TimedActivities_KeyboardTLContentHeaderResetTime, --[[Font]] PP.f.u67, 18, "outline")

        PP.ScrollBar(ZO_TimedActivities_KeyboardTLContentList, --[[sb_c]] 180, 180, 180, 0.8, --[[bd_c]] 20, 20, 20, 0.6, false)
        ZO_Scroll_SetMaxFadeDistance(ZO_TimedActivities_KeyboardTLContentList, 10)
    end)

    -- TamrielTomes main keyboard scene - ZO_TamrielTomes_KeyboardTL---------------------------------
    local tamrielTomesScene = SCENE_MANAGER:GetScene("TamrielTomesSceneKeyboard")

    tamrielTomesScene:RemoveFragment(RIGHT_BG_FRAGMENT)
    tamrielTomesScene:RemoveFragment(TREE_UNDERLAY_FRAGMENT)
    tamrielTomesScene:RemoveFragment(TITLE_FRAGMENT)

    PP.onDeferredInitCheck(TAMRIEL_TOMES_SCREEN_KEYBOARD, function ()
        PP:CreateBackground(ZO_TamrielTomes_KeyboardTL, --[[#1]] nil, nil, nil, -10, -10, --[[#2]] nil, nil, nil, 0, 10)
        ZO_TamrielTomes_KeyboardTLPageBackground:SetHidden(true)

        PP.Anchor(ZO_TamrielTomes_KeyboardTL, --[[#1]] TOPRIGHT, GuiRoot, TOPRIGHT, 0, 120, --[[#2]] true, BOTTOMRIGHT, GuiRoot, BOTTOMRIGHT, 0, -70)

        PP.Font(ZO_TamrielTomes_KeyboardTLHeaderTitle, --[[Font]] PP.f.u67, 28, "outline")
        PP.Font(ZO_TamrielTomes_KeyboardTLHeaderSubtitle, --[[Font]] PP.f.u67, 16, "outline")

        PP.ScrollBar(ZO_TamrielTomes_KeyboardTLBookGridList, --[[sb_c]] 180, 180, 180, 0.8, --[[bd_c]] 20, 20, 20, 0.6, false)
        ZO_Scroll_SetMaxFadeDistance(ZO_TamrielTomes_KeyboardTLBookGridList, 10)
    end)

    -- TamrielTomes intro sub-scene - ZO_TamrielTomesIntro_KeyboardTL-----------------------------
    -- The intro is a full-screen 1810x998 two-page tome spread. Its BookBG texture IS the
    -- readable surface for all text and layout — hiding it breaks the screen entirely. No PP
    -- background or BookBG changes are applied here; fragment removal is safe as a no-op.
    local introScene = SCENE_MANAGER:GetScene("TamrielTomesIntroSceneKeyboard")

    introScene:RemoveFragment(RIGHT_BG_FRAGMENT)
    introScene:RemoveFragment(TITLE_FRAGMENT)

    -- TamrielTomes purchase sub-scene - ZO_TamrielTomesPurchase_KeyboardTL-----------------------
    local purchaseScene = SCENE_MANAGER:GetScene("TamrielTomesPurchaseSceneKeyboard")

    purchaseScene:RemoveFragment(RIGHT_BG_FRAGMENT)
    purchaseScene:RemoveFragment(TITLE_FRAGMENT)

    PP.onDeferredInitCheck(TAMRIEL_TOMES_PURCHASE_SCREEN_KEYBOARD, function ()
        PP:CreateBackground(ZO_TamrielTomesPurchase_KeyboardTL, --[[#1]] nil, nil, nil, -10, -10, --[[#2]] nil, nil, nil, 0, 10)
        ZO_TamrielTomesPurchase_KeyboardTLBookBG:SetHidden(true)

        PP.Anchor(ZO_TamrielTomesPurchase_KeyboardTL, --[[#1]] TOPRIGHT, GuiRoot, TOPRIGHT, 0, 120, --[[#2]] true, BOTTOMRIGHT, GuiRoot, BOTTOMRIGHT, 0, -70)

        PP.Font(ZO_TamrielTomesPurchase_KeyboardTLTitle, --[[Font]] PP.f.u67, 24, "outline")

        PP.ScrollBar(ZO_TamrielTomesPurchase_KeyboardTLGridList, --[[sb_c]] 180, 180, 180, 0.8, --[[bd_c]] 20, 20, 20, 0.6, false)
    end)
end