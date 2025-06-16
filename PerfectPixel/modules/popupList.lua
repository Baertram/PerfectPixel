local PP = PP ---@class PP

PP.popupList = function()
    ZO_PreHookHandler(ZO_PopupListTL, "OnEffectivelyShown", function()
        ZO_PopupListTLBG:SetCenterTexture("", 4, 0)
        ZO_PopupListTLBG:SetCenterColor(10 / 255, 10 / 255, 10 / 255, 0.96)
        ZO_PopupListTLBG:SetEdgeTexture("", 1, 1, 1, 0)
        ZO_PopupListTLBG:SetEdgeColor(60 / 255, 60 / 255, 60 / 255, 1)
        ZO_PopupListTLBG:SetInsets(-1, -1, 1, 1)

        local mungeOverlay = ZO_PopupListTLBG:GetNamedChild("MungeOverlay")
        if mungeOverlay then
            mungeOverlay:SetHidden(true)
        end
    end)

    if ZO_PopupListTLList then
        PP.ScrollBar(ZO_PopupListTLList)
        ZO_Scroll_SetMaxFadeDistance(ZO_PopupListTLList, 10)
    end

    ZO_PostHook(POPUP_LIST, "SetUpListRewardItem", function(self, control, data)
        if control.PP_Styled then return end

        control.data = data

        local icon = control:GetNamedChild("Icon")
        if icon and icon.SetDimensions then
            local stackCount = icon:GetNamedChild("StackCount")
            if stackCount and stackCount.SetFont then
                PP.Font(stackCount, --[[Font]] PP.f.u67, 15, "shadow")
            end
        end

        local name = control:GetNamedChild("Name")
        if name and name.SetFont then
            PP.Font(name, --[[Font]] PP.f.u67, 16, "shadow")
            if name.SetVerticalAlignment then
                name:SetVerticalAlignment(TEXT_ALIGN_CENTER)
            end
            if name.SetLineSpacing then
                name:SetLineSpacing(-2)
                PP:SetLockFn(name, "SetLineSpacing")
            end
        end

        local defaultBackdrop = control:GetNamedChild("Backdrop")
        if defaultBackdrop and defaultBackdrop.SetTexture then
            defaultBackdrop:SetTexture("PerfectPixel/tex/tex_clear.dds")
        end

        local highlight = control:GetNamedChild("Highlight")
        if highlight and highlight.SetHidden then
            highlight:SetHidden(true)
        end

        control.PP_Styled = true
    end)

    ZO_PostHook(POPUP_LIST, "SetUpListBlankItem", function(self, control, data)
        if control.PP_Styled then return end

        local bg = control:GetNamedChild("Bg")
        if bg and bg.SetHidden then
            bg:SetHidden(true)
        end

        control.PP_Styled = true
    end)
end
