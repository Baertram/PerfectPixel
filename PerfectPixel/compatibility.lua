local CM = CALLBACK_MANAGER
local tinsert = table.insert

local PP = PP

PP.compatibilityFunctions = {}
PP.compatibility = function ()
    local function Compatibility()
        -- ==LibCustomMenu==--
        if LibCustomMenu then
            local lcmSM = LibCustomMenuSubmenu
            local lcmSMBG = GetControl(lcmSM, "BG")
            local lcmSMBGMungeOverlay = GetControl(lcmSMBG, "MungeOverlay")
            local lcmSMHighlight = GetControl(lcmSM, "Highlight")

            ZO_PreHookHandler(LibCustomMenuSubmenu, "OnShow", function ()
                lcmSMBG:SetCenterTexture("", 4, 0)
                lcmSMBG:SetCenterColor(10 / 255, 10 / 255, 10 / 255, 0.96)
                lcmSMBG:SetEdgeTexture("", 1, 1, 1, 0)
                lcmSMBG:SetEdgeColor(60 / 255, 60 / 255, 60 / 255, 1)
                lcmSMBG:SetInsets(-1, -1, 1, 1)
                if lcmSMBGMungeOverlay then lcmSMBGMungeOverlay:SetHidden(true) end
            end)

            PP.Anchor(lcmSMBG, --[[#1]] TOPLEFT, nil, TOPLEFT, -2, 4, --[[#2]] true, BOTTOMRIGHT, nil, BOTTOMRIGHT, -2, -4)
            -- lcmSMBG:SetInheritAlpha(false)

            if lcmSMHighlight then
                lcmSMHighlight:SetCenterTexture("", 4, 0)
                lcmSMHighlight:SetCenterColor(96 / 255 * 0.3, 125 / 255 * 0.3, 139 / 255 * 0.3, 1)
                lcmSMHighlight:SetEdgeTexture("", 1, 1, 1, 0)
                lcmSMHighlight:SetEdgeColor(96 / 255 * 0.5, 125 / 255 * 0.5, 139 / 255 * 0.5, 0)
                lcmSMHighlight:SetInsets(0, 0, 0, 0)
                -- lcmSMHighlight:SetInheritAlpha(false)
            end
        end

        -- ===============================================================================================--
        -- ==LibScrollableMenu==--
        if LibScrollableMenu then
            local lsm = LibScrollableMenu
            local lsm_SetCustomScrollableMenuOptions = SetCustomScrollableMenuOptions

            local CUSTOM_HIGHLIGHT_TEXT_COLOR = ZO_ColorDef:New("FFFFFF") --white

            -- Cache styled controls to avoid re-styling
            local styledLSMControls = {}

            local function defaultEntryTypeLayout(highlight)
                highlight:SetCenterTexture("", 4, 0)
                highlight:SetEdgeTexture("", 1, 1, 1, 0)
                highlight:SetInsets(0, 0, 0, 0)
                highlight:SetBlendMode(TEX_BLEND_MODE_ADD)
                if highlight:IsPixelRoundingEnabled() then
                    highlight:SetPixelRoundingEnabled(false)
                end
            end

            local function styleLSMHighlight(highlight, entryType)
                --d("[PP]styleLSMHighlight - highlight: " .. tostring(highlight ~= nil and highlight:GetName() or "nil"))
                if not highlight or styledLSMControls[highlight] or not entryType then return end

                local entryTypeToLayout =
                {
                    [lsm.LSM_ENTRY_TYPE_NORMAL] =
                    {
                        layoutFunc = function (highLightControl)
                            highlight:SetCenterColor(96 / 255 * 0.3, 125 / 255 * 0.3, 139 / 255 * 0.3, 1)
                            highlight:SetEdgeColor(96 / 255 * 0.5, 125 / 255 * 0.5, 139 / 255 * 0.5, 0)
                            defaultEntryTypeLayout(highlight)
                        end,
                    },
                    [lsm.LSM_ENTRY_TYPE_BUTTON] =
                    {
                        layoutFunc = function (highLightControl)
                            highlight:SetCenterColor(96 / 255 * 0.3, 125 / 255 * 0.3, 139 / 255 * 0.3, 1)
                            highlight:SetEdgeColor(200 / 255 * 0.5, 200 / 255 * 0.5, 200 / 255 * 0.5, 1)
                            defaultEntryTypeLayout(highlight)
                        end,
                    },
                    [lsm.LSM_ENTRY_TYPE_SUBMENU] =
                    {
                        layoutFunc = function (highLightControl)
                            defaultEntryTypeLayout(highlight)
                        end,
                    },
                }
                local layoutData = entryTypeToLayout[entryType] or entryTypeToLayout[LSM_ENTRY_TYPE_NORMAL]
                if layoutData and type(layoutData.layoutFunc) == "function" then
                    layoutData.layoutFunc(highlight)
                    styledLSMControls[highlight] = true
                end
            end

            --Called from XML code to apply the row's highlight values
            function PP.compatibilityFunctions.ApplyLSMRowHighlight(highlightControl, entryType)
                --d("[PP]applyPPLSMRowHighlight - highlight: " .. tostring(highlightControl:GetName()))
                styleLSMHighlight(highlightControl, entryType)
            end

            local function hideControlMungeOverlays(parentControl)
                --d("[PP]hideControlMungeOverlays")
                if not parentControl or styledLSMControls[parentControl] then return end
                local overlayControls =
                {
                    GetControl(parentControl, "MungeOverlay"),
                    GetControl(parentControl, "HeaderBGDividerMungeOverlay"),
                    GetControl(parentControl, "HeaderDividerSimpleMungeOverlay"),
                    GetControl(parentControl, "HeaderDividerSimpleDividerMungeOverlay")
                }
                for _, control in ipairs(overlayControls) do
                    if control then
                        --d(">sethidden true on " .. tostring(control:GetName()))
                        control:SetHidden(true)
                    end
                end
                --SetCenterTexture(*string* _filename_, *layout_measurement* _tilingInterval_, *[TextureAddressMode|#TextureAddressMode]* _addressMode_)
                --parentControl:SetCenterTexture("", 4, 0)
                parentControl:SetCenterColor(10 / 255, 10 / 255, 10 / 255, 0.96)
                --SetEdgeTexture(*string* _filename_, *integer* _edgeFileWidth_, *integer* _edgeFileHeight_, *layout_measurement* _cornerSize_, *integer* _edgeFilePadding_)
                --parentControl:SetEdgeTexture("", 1, 1, 1, 0)
                parentControl:SetEdgeColor(60 / 255, 60 / 255, 60 / 255, 1)
                --SetInsets(*layout_measurement* _left_, *layout_measurement* _top_, *layout_measurement* _right_, *layout_measurement* _bottom_)
                --parentControl:SetInsets(-1, -1, 1, 1)
                styledLSMControls[parentControl] = true
            end

            local function addPPStyle(control, data, templateName)
                --d("[PP]addPP - control: " .. tostring(control) .. ", data: " .. tostring(data) .. "; templateName: " ..tostring(templateName))
                if control and not styledLSMControls[control] then
                    PP:CreateBackground(control, nil, nil, nil, -2, 1, nil, nil, nil, -2, -1)
                    hideControlMungeOverlays(control)
                    --[[
					if data ~= nil then

						data._highlightTemplate = styleLSMHighlight(control)
					else
						local highlight = GetControl(control, "Highlight")
						styleLSMHighlight(highlight)
					end
					]]
                    styledLSMControls[control] = true
                end
            end

            local function addPPBackgroundToLSMDropdown(dropdownControl, dropdownObject)
                --d("[PP]addPPBackgroundToLSMDropdown")
                if not dropdownControl then return end

                dropdownObject = dropdownObject or dropdownControl.m_dropdownObject
                if not dropdownObject then return end
                --d(">dropdownObject found")
                local comboBoxDropdownCtrl = dropdownObject.control

                -- Style background only once
                local bg = comboBoxDropdownCtrl ~= nil and GetControl(comboBoxDropdownCtrl, "BG")
                --d(">bg found: " ..tostring(bg))
                addPPStyle(bg, nil, nil)

                -- Style scrollbar only once
                local scrollList = dropdownObject.scroll
                if scrollList and not styledLSMControls[scrollList] then
                    --d(">scrollList found: " ..tostring(scrollList))
                    PP.ScrollBar(scrollList)
                    styledLSMControls[scrollList] = true
                end
            end

            local PP_LSMDropdownOptions =
            {
                --visibleRowsDropdown = 30,
                --visibleRowsSubmenu = 30,
                --maxDropdownHeight = 400,
                --sortEntries = true,
                --sortType = ZO_SORT_BY_NAME,
                --sortOrder = ZO_SORT_ORDER_UP,
                --font = PP.f.u67,
                --spacing = 2,
                --disableFadeGradient = false,
                --headerColor = ZO_ColorDef:New("E6E6E6FF"),
                --normalColor = ZO_ColorDef:New("E6E6E6FF"),
                --disabledColor = ZO_ColorDef:New("666666FF"),
                --highlightContextMenuOpeningControl = true,
                --useDefaultHighlightForSubmenuWithCallback = false,
                --highlightColor =	CUSTOM_HIGHLIGHT_TEXT_COLOR,
                --highlightTemplate =	"ZO_TallListSelectedHighlight",
                --titleText = "Dropdown Title",
                --titleFont = PP.f.u67,
                --subtitleText = "Dropdown Subtitle",
                --subtitleFont = PP.f.u57,
                titleTextAlignment = TEXT_ALIGN_CENTER,

                --Apply PP highlight stle, same as ZO_Menu uses, to LSM entryTypes' highlights
                XMLRowHighlightTemplates =
                {
                    [lsm.LSM_ENTRY_TYPE_NORMAL] =
                    {
                        template = "PP_LibScrollableMenu_Highlight_Default",
                        color = CUSTOM_HIGHLIGHT_TEXT_COLOR,
                    },
                    [lsm.LSM_ENTRY_TYPE_SUBMENU] =
                    {
                        template = "PP_LibScrollableMenu_Highlight_Default",
                        templateWithCallback = "PP_LibScrollableMenu_Highlight_SubmenuCallbackGreen",
                        color = CUSTOM_HIGHLIGHT_TEXT_COLOR,
                    },
                    [lsm.LSM_ENTRY_TYPE_CHECKBOX] =
                    {
                        template = "PP_LibScrollableMenu_Highlight_Default",
                        color = CUSTOM_HIGHLIGHT_TEXT_COLOR,
                    },
                    [lsm.LSM_ENTRY_TYPE_BUTTON] =
                    {
                        template = "PP_LibScrollableMenu_Highlight_Button_Default",
                        color = CUSTOM_HIGHLIGHT_TEXT_COLOR,
                    },
                    [lsm.LSM_ENTRY_TYPE_RADIOBUTTON] =
                    {
                        template = "PP_LibScrollableMenu_Highlight_Default",
                        color = CUSTOM_HIGHLIGHT_TEXT_COLOR,
                    },
                },
            }

            local function mixinPPOptionsToLSMOptions(dropdownObject, options)
                --d(">mixinPPOptionsToLSMOptions - dropdownObject: " .. tostring(dropdownObject and dropdownObject.m_container or nil) .. ", options: " ..tostring(options))
                if options == nil then
                    if dropdownObject then
                        if dropdownObject.GetOptions then
                            options = dropdownObject:GetOptions()
                            --d(">>options taken from dropdownObject:GetOptions()")
                        else
                            local comboBoxObject = ZO_ComboBox_ObjectFromContainer(dropdownObject)
                            options = (comboBoxObject ~= nil and comboBoxObject:GetOptions()) or nil
                            --d(">>options taken from ZO_ComboBox_ObjectFromContainer():GetOptions()")
                        end
                    end
                    options = options or {}
                end
                zo_mixin(options, PP_LSMDropdownOptions)
                return options
            end

            local function mixinPPOptionsAndUpdateThemToDropdown(dropdownObject, dropdownControl, isContextMenu)
                dropdownObject = dropdownObject or dropdownControl.m_dropdownObject
                if dropdownObject then
                    --d(">mixinPPOptionsAndUpdateThemToDropdown")
                    local options
                    options = mixinPPOptionsToLSMOptions(dropdownObject, options)
                    lsm_SetCustomScrollableMenuOptions(options, (not isContextMenu and dropdownObject) or nil)
                end
            end

            -- Register LSM callback handlers with options -> Maybe that this register comes after the other addon was loaded :-(
            -->So we use the 'OnMenuShow' and 'OnContextMenuShow' callbacks below for a 2nd chance to mixin the PP options
            lsm:RegisterCallback("OnDropdownMenuAdded", function (dropdownObject, options)
                local dropDownTLCCtrl = dropdownObject.m_container

                --[[
				d("[PP]================================================================")
				d("[PP]LSM OnDropdownMenuAdded - dropdown: " ..tostring(lsm.GetControlName(dropDownTLCCtrl)))
				d("[PP]================================================================")
				]]
                --Overwrite the options of the LSM with the PP styled options
                return mixinPPOptionsToLSMOptions(dropdownObject, options)
            end)

            lsm:RegisterCallback("OnMenuShow", function (dropdownControl, dropdownObject)
                --[[
				d("[PP]--------------------------------------------------")
				d("[PP]LSM OnMenuShow - dropdown: " .. tostring(lsm.GetControlName(dropdownControl)) .. ", name: " .. tostring(lsm.GetControlName(dropdownControl)))
				d("[PP]--------------------------------------------------")
				]]
                addPPBackgroundToLSMDropdown(dropdownControl, dropdownObject)
                mixinPPOptionsAndUpdateThemToDropdown(dropdownObject, dropdownControl)
            end)

            lsm:RegisterCallback("OnSubMenuShow", function (dropdownControl, dropdownObject)
                local dropDownTLCCtrl = dropdownObject.m_container
                --[[
				d("[PP]LSM OnSubMenuShow - dropdown: " .. tostring(lsm.GetControlName(dropDownTLCCtrl)) .. ", name: " .. tostring(lsm.GetControlName(dropdownControl)))
				]]
                addPPBackgroundToLSMDropdown(dropdownControl, dropdownObject)
                --options of mainMenu should be copied to submenu automatically so no need to PPify (mixin) it explicitly here
            end)

            lsm:RegisterCallback("OnContextMenuShow", function (dropdownControl, dropdownObject)
                local dropDownTLCCtrl = dropdownObject.m_container
                --[[
				d("[PP]!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
				d("[PP]LSM " .. tostring(contextMenuCallback) .." - dropdown: " .. tostring(lsm.GetControlName(dropDownTLCCtrl)) .. ", name: " .. tostring(lsm.GetControlName(dropdownControl)))
				d("[PP]!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
				]]
                addPPBackgroundToLSMDropdown(dropdownControl, dropdownObject)
                mixinPPOptionsAndUpdateThemToDropdown(dropdownObject, dropdownControl, true)
            end)
        end
        -- ===============================================================================================--


        -- ==CraftBagExtended==--
        if CraftBagExtended then
            CraftBagExtendedVendorMenu:SetParent(ZO_StoreWindowMenu)
            PP.Anchor(CraftBagExtendedVendorMenu, --[[#1]] TOPLEFT, ZO_StoreWindowMenu, TOPLEFT, 80, 0)

            CraftBagExtendedHouseBankMenu:SetParent(ZO_HouseBankMenu)
            PP.Anchor(CraftBagExtendedHouseBankMenu, --[[#1]] TOPLEFT, ZO_HouseBankMenu, TOPLEFT, 80, 0)

            CraftBagExtendedBankMenu:SetParent(ZO_PlayerBankMenu)
            PP.Anchor(CraftBagExtendedBankMenu, --[[#1]] TOPLEFT, ZO_PlayerBankMenu, TOPLEFT, 80, 0)

            CraftBagExtendedGuildBankMenu:SetParent(ZO_GuildBankMenu)
            PP.Anchor(CraftBagExtendedGuildBankMenu, --[[#1]] TOPLEFT, ZO_GuildBankMenu, TOPLEFT, 80, 0)

            CraftBagExtendedMailMenu:SetParent(ZO_MailSend)
            PP.Anchor(CraftBagExtendedMailMenu, --[[#1]] TOPLEFT, ZO_MailSend, TOPLEFT, 420, -55)

            -- CraftBagExtendedTradeMenu:SetParent(parent)
            -- PP.Anchor(CraftBagExtendedTradeMenu,		--[[#1]] TOPLEFT, parent,		TOPLEFT, 80, 0)
        end
        -- ===============================================================================================--

        -- ==AddonSelector==--
        if AddonSelector then
            local SV_VER = 0.1
            local addonSV = ZO_SavedVars:NewAccountWide(PP.ADDON_NAME, SV_VER, "GameMenuScene", {}, GetWorldName())
            if addonSV.addons_toggle then
                local function reAnchorAddOnsUIForAddonSelectorNow()
			        PP.Anchor(ZO_AddOns, --[[#1]] TOPLEFT, GuiRoot, TOPLEFT, 256, 35, --[[#2]] true, BOTTOMRIGHT, GuiRoot, BOTTOMLEFT, 1200, -80)
                    PP.Anchor(ZO_AddOnsList, --[[#1]] TOPLEFT, AddonSelector, BOTTOMLEFT, 0, 10, --[[#2]] true, BOTTOMRIGHT, ZO_AddOns, BOTTOMRIGHT, -20, -60)
                end
                reAnchorAddOnsUIForAddonSelectorNow()

                PP.Anchor(AddonSelectorBottomDivider, --[[#1]] BOTTOM, AddonSelector, BOTTOM, 40, 0)
                PP.Anchor(AddonSelectorSearchBox, --[[#1]] TOPRIGHT, ZO_AddOns, TOPRIGHT, -6, 6)
                if AddonSelectorAutoReloadUI and AddonSelectorAutoReloadUILabel then
                    PP.Anchor(AddonSelectorAutoReloadUILabel, --[[#1]] TOPRIGHT, AddonSelectorSearchBox, BOTTOMRIGHT, 0, 6)
                    PP.Anchor(AddonSelectorAutoReloadUI, --[[#1]] RIGHT, AddonSelectorAutoReloadUILabel, LEFT, -6, 0)
                end
                PP.Anchor(AddonSelectorSettingsOpenDropdown, --[[#1]] TOPLEFT, ZO_AddOns, TOP, 40, -7)

                PP.Font(AddonSelectorDeselectAddonsButtonKeyLabel, --[[Font]] PP.f.u57, 16, "outline", --[[Alpha]] nil, --[[Color]] nil, nil, nil, nil, --[[StyleColor]] 0, 0, 0, 0.5)
                PP.Font(AddonSelectorDeselectAddonsButtonNameLabel, --[[Font]] PP.f.u67, 18, "outline", --[[Alpha]] nil, --[[Color]] nil, nil, nil, nil, --[[StyleColor]] 0, 0, 0, 0.5)
                PP.Font(AddonSelectorSelectAddonsButtonKeyLabel, --[[Font]] PP.f.u57, 16, "outline", --[[Alpha]] nil, --[[Color]] nil, nil, nil, nil, --[[StyleColor]] 0, 0, 0, 0.5)
                PP.Font(AddonSelectorSelectAddonsButtonNameLabel, --[[Font]] PP.f.u67, 18, "outline", --[[Alpha]] nil, --[[Color]] nil, nil, nil, nil, --[[StyleColor]] 0, 0, 0, 0.5)
                PP.Font(AddonSelectorToggleAddonStateButtonKeyLabel, --[[Font]] PP.f.u57, 16, "outline", --[[Alpha]] nil, --[[Color]] nil, nil, nil, nil, --[[StyleColor]] 0, 0, 0, 0.5)
                PP.Font(AddonSelectorToggleAddonStateButtonNameLabel, --[[Font]] PP.f.u67, 18, "outline", --[[Alpha]] nil, --[[Color]] nil, nil, nil, nil, --[[StyleColor]] 0, 0, 0, 0.5)
                PP.Font(AddonSelectorStartAddonSearchButtonKeyLabel, --[[Font]] PP.f.u57, 16, "outline", --[[Alpha]] nil, --[[Color]] nil, nil, nil, nil, --[[StyleColor]] 0, 0, 0, 0.5)
                PP.Font(AddonSelectorStartAddonSearchButtonNameLabel, --[[Font]] PP.f.u67, 18, "outline", --[[Alpha]] nil, --[[Color]] nil, nil, nil, nil, --[[StyleColor]] 0, 0, 0, 0.5)

                --Register these 2 events to react on an ALT+TAB or WIN outside and reanchor the ZO_AddOns UI properly again
                EVENT_MANAGER:UnregisterForEvent("PerfectPixel_ZO_AddOns_EVENT_GAME_FOCUS_CHANGED", EVENT_GAME_FOCUS_CHANGED)
                EVENT_MANAGER:RegisterForEvent("PerfectPixel_ZO_AddOns_EVENT_GAME_FOCUS_CHANGED", EVENT_GAME_FOCUS_CHANGED, function()
                    EVENT_MANAGER:UnregisterForEvent("PerfectPixel_ZO_AddOns_EVENT_ALL_GUI_SCREENS_RESIZED", EVENT_ALL_GUI_SCREENS_RESIZED)
                    EVENT_MANAGER:RegisterForEvent("PerfectPixel_ZO_AddOns_EVENT_ALL_GUI_SCREENS_RESIZED", EVENT_ALL_GUI_SCREENS_RESIZED, function()
                        reAnchorAddOnsUIForAddonSelectorNow()
                        EVENT_MANAGER:UnregisterForEvent("PerfectPixel_ZO_AddOns_EVENT_ALL_GUI_SCREENS_RESIZED", EVENT_ALL_GUI_SCREENS_RESIZED)
                    end)
                end)
            end
        end
        -- ===============================================================================================--

        -- ==MailLooter==--
        if MailLooter then
            MAIL_LOOTER_SCENE:RemoveFragment(TITLE_FRAGMENT)
            MAIL_LOOTER_SCENE:RemoveFragment(MAIL_TITLE_FRAGMENT)
            MAIL_LOOTER_SCENE:RemoveFragment(FRAME_PLAYER_FRAGMENT)
            PP.Anchor(MailLooterLootList, --[[#1]] TOP, MailLooterLootHeaders, BOTTOM, 0, 0, --[[#2]] true, BOTTOMRIGHT, ZO_MailInbox, BOTTOMRIGHT, 0, -100)
        end
        -- ===============================================================================================--

        -- ==ESO Master Recipe List==--
        if ESOMRL then
            local resultTooltip = PROVISIONER.resultTooltip
            PP:SetLockFn(resultTooltip, "SetAnchor")
            PP:SetLockFn(resultTooltip, "ClearAnchors")
        end
        -- ===============================================================================================--

        -- ==Potion Maker==--
        if PotMaker then
            PP.Anchor(ZO_AlchemyTopLevelContent, --[[#1]] TOPRIGHT, ZO_AlchemyTopLevel, TOPRIGHT, 0, 100, --[[#2]] true, BOTTOMRIGHT, ZO_AlchemyTopLevel, BOTTOMRIGHT, 0, -80)
            ZO_AlchemyTopLevelContent:SetWidth(565)
            --PP:CreateBackground(ZO_AlchemyTopLevelPotionMaker, --[[#1]] nil, nil, nil, -6, 0, --[[#2]] nil, nil, nil, 0, 6)
            --PP:CreateBackground(ZO_AlchemyTopLevelPoisonMaker, --[[#1]] nil, nil, nil, -6, 0, --[[#2]] nil, nil, nil, 0, 6)
            PP:CreateBackground(ZO_AlchemyTopLevelPotionMaker, --[[#1]] nil, nil, nil, -6, 10, --[[#2]] nil, nil, nil, 0, -4)
            PP:CreateBackground(ZO_AlchemyTopLevelPoisonMaker, --[[#1]] nil, nil, nil, -6, 10, --[[#2]] nil, nil, nil, 0, -4)
        end
        -- ===============================================================================================--

        -- ==KyzderpsDerps==--
        if KyzderpsDerps then
            PP:CreateBackground(SpawnTimerContainerBackdrop, --[[#1]] nil, nil, nil, -6, 0, --[[#2]] nil, nil, nil, 0, 6)
        end

        -- ===============================================================================================--

        -- ==VotansMiniMap==--
        if VOTANS_MINIMAP then
            WORLD_MAP_SCENE:RegisterCallback("StateChange", function (oldState, newState)
                if newState == SCENE_SHOWN then
                    WORLD_MAP_FRAGMENT.duration = PP.savedVars.SceneManager.fade_scene_duration
                end
            end)

            if PP.savedVars.Compass.toggle then
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
        end

        -- ===============================================================================================--

        -- ==Azurah==--
        if Azurah then
            if PP.savedVars.Compass.toggle then
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
        end
        -- ===============================================================================================--

        -- ==InventoryInsightFromAshes==--
        if IIFA_GUI then
            PP:CreateBackground(IIFA_GUI_BG, --[[#1]] nil, nil, nil, 0, 0, --[[#2]] nil, nil, nil, 0, 0)
            PP.ScrollBar(IIFA_GUI_ListHolder_Slider)
            PP.Anchor(IIFA_GUI_ListHolder_Slider, --[[#1]] nil, nil, nil, nil, nil, --[[#2]] true, nil, nil, nil, 14, 0)
            ZO_Scroll_SetMaxFadeDistance(IIFA_GUI_ListHolder, PP.savedVars.ListStyle.list_fade_distance)
            PP.Font(IIFA_GUI_Header_Label, --[[Font]] PP.f.u67, 18, "outline", --[[Alpha]] nil, --[[Color]] nil, nil, nil, nil, --[[StyleColor]] 0, 0, 0, 0.5)
            if IIFA_GUI_ListHolder and IIFA_GUI_ListHolder_Counts then
                --PP.Anchor(IIFA_GUI_ListHolder_Counts_Items, --[[#1]] nil, nil, nil, nil, nil, --[[#2]] true, nil, nil, nil, -59, 0)
                --PP.Anchor(IIFA_GUI_ListHolder_Counts_Slots, --[[#1]] nil, nil, nil, nil, nil, --[[#2]] true, nil, nil, nil, -59, 0)
                IIFA_GUI_ListHolder_Counts_Items:SetAnchorOffsets(0, 59)
                IIFA_GUI_ListHolder_Counts_Slots:SetAnchorOffsets(0, 59)
            end
            IIFA_GUI_BGMungeOverlay:SetHidden(true)
            PP.SetStyle_Tooltip(GetControl("IIFA_ITEM_TOOLTIP"))
            PP.SetStyle_Tooltip(GetControl("IIFA_POPUP_TOOLTIP"))
            PP:CreateBackground(IIFA_CharBagFrame, --[[#1]] nil, nil, nil, 0, 0, --[[#2]] nil, nil, nil, 0, 0)
            PP:CreateBackground(IIFA_CharBagFrame_BG, --[[#1]] nil, nil, nil, 0, 0, --[[#2]] nil, nil, nil, 0, 0)
            IIFA_CharBagFrame_BGMungeOverlay:SetHidden(true)
            PP:CreateBackground(IIFA_CharCurrencyFrame, --[[#1]] nil, nil, nil, 0, 0, --[[#2]] nil, nil, nil, 0, 0)
            PP:CreateBackground(IIFA_CharCurrencyFrame_BG, --[[#1]] nil, nil, nil, 0, 0, --[[#2]] nil, nil, nil, 0, 0)
            IIFA_CharCurrencyFrame_BGMungeOverlay:SetHidden(true)
        end

        -- ===============================================================================================--

        -- ==WizardsWardrobe==--
        if WizardsWardrobe then
            PP.ScrollBar(WizardsWardrobeWindowSetupListScrollBar)
            PP.ScrollBar(WizardsWardrobeArrangeDialogListScrollBar)
            ZO_Scroll_SetMaxFadeDistance(WizardsWardrobeWindowSetupList, PP.savedVars.ListStyle.list_fade_distance)
            ZO_Scroll_SetMaxFadeDistance(WizardsWardrobeArrangeDialogList, PP.savedVars.ListStyle.list_fade_distance)

            PP:CreateBackground(WizardsWardrobeWindowBG, --[[#1]] nil, nil, nil, 0, 0, --[[#2]] nil, nil, nil, 0, 0)
            PP:CreateBackground(WizardsWardrobePrebuffBG, --[[#1]] nil, nil, nil, 0, 0, --[[#2]] nil, nil, nil, 0, 0)
            PP:CreateBackground(WizardsWardrobeCodeDialogBG, --[[#1]] nil, nil, nil, 0, 0, --[[#2]] nil, nil, nil, 0, 0)
            PP:CreateBackground(WizardsWardrobeArrangeDialogBG, --[[#1]] nil, nil, nil, 0, 0, --[[#2]] nil, nil, nil, 0, 0)
            PP:CreateBackground(WizardsWardrobeTransferDialogBG, --[[#1]] nil, nil, nil, 0, 0, --[[#2]] nil, nil, nil, 0, 0)
            PP:CreateBackground(WizardsWardrobePreviewPreviewBG, --[[#1]] nil, nil, nil, 0, 0, --[[#2]] nil, nil, nil, 0, 0)

            WizardsWardrobeWindowBGMungeOverlay:SetHidden(true)
            WizardsWardrobePrebuffBGMungeOverlay:SetHidden(true)
            WizardsWardrobeCodeDialogBGMungeOverlay:SetHidden(true)
            WizardsWardrobeArrangeDialogBGMungeOverlay:SetHidden(true)
            WizardsWardrobeTransferDialogBGMungeOverlay:SetHidden(true)
            WizardsWardrobePreviewPreviewBGMungeOverlay:SetHidden(true)
        end
        -- ===============================================================================================--

        -- ==WPamA==--
        if WPamA then
            PP:CreateBackground(WPamA_WinBG, --[[#1]] nil, nil, nil, 0, 0, --[[#2]] nil, nil, nil, 0, 0)
            WPamA_WinBGMungeOverlay:SetHidden(true)
        end

        -- ===============================================================================================--

        -- ==TimWitchesUI==--
        if tim99_WitchesFestival then
            PP:CreateBackground(TimWitchesUIBG, --[[#1]] nil, nil, nil, 0, 0, --[[#2]] nil, nil, nil, 0, 0)
            TimWitchesUIBGMungeOverlay:SetHidden(true)
        end

        -- ===============================================================================================--

        -- ==DolgubonSetCrafterWindow==--
        if DolgubonSetCrafter then
            -- Define all scroll bars and their associated content elements
            local scrollElements =
            {
                {
                    scrollBar = "DolgubonSetCrafterWindowFavouritesScrollListScrollBar",
                    contents = "DolgubonSetCrafterWindowFavouritesScrollListContents",
                    thumbMunge = "DolgubonSetCrafterWindowFavouritesScrollListScrollBarThumbMunge",
                },
                {
                    scrollBar = "DolgubonSetCrafterWindowMaterialListListScrollBar",
                    contents = "DolgubonSetCrafterWindowMaterialListListContents",
                    thumbMunge = "DolgubonSetCrafterWindowMaterialListListScrollBarThumbMunge",
                },
                {
                    scrollBar = "CraftingQueueScrollListScrollBar",
                    contents = "CraftingQueueScrollListContents",
                    thumbMunge = "CraftingQueueScrollListScrollBarThumbMunge",
                },
                {
                    scrollBar = "DolgubonSetCrafterWindowFurnitureListScrollBar",
                    contents = "DolgubonSetCrafterWindowFurnitureListContents",
                    thumbMunge = "DolgubonSetCrafterWindowFurnitureListScrollBarThumbMunge",
                },
            }

            -- Create backgrounds for main elements
            local backgrounds =
            {
                DolgubonSetCrafterWindowFavouritesScroll,
                DolgubonSetCrafterWindow,
            }
            for _, control in ipairs(backgrounds) do
                PP:CreateBackground(control, nil, nil, nil, 0, 0, nil, nil, nil, 0, 0)
            end

            -- Apply scroll bar styling and settings to all scroll elements
            for _, element in ipairs(scrollElements) do
                local scrollBar = _G[element.scrollBar]
                local contents = _G[element.contents]
                local thumbMunge = _G[element.thumbMunge]

                PP.ScrollBar(scrollBar)
                PP.Anchor(scrollBar, nil, nil, nil, nil, nil, true, nil, nil, nil, nil, nil)
                ZO_Scroll_SetMaxFadeDistance(contents, PP.savedVars.ListStyle.list_fade_distance)
                thumbMunge:SetHidden(true)
            end

            -- Hide unnecessary UI elements
            local elementsToHide =
            {
                DolgubonSetCrafterWindowBackdrop,
                DolgubonSetCrafterWindowDivider,
                DolgubonSetCrafterWindowFavouritesBackdrop,
            }
            for _, control in ipairs(elementsToHide) do
                control:SetHidden(true)
            end
        end

        --Dolgubons Lazy Writ Creator
        if DolgubonsWrits then
            local dlwcSmallUI = DolgubonsWrits
            if dlwcSmallUI then
                if DolgubonsWritCrafterSavedVars and 
                   DolgubonsWritCrafterSavedVars["Default"][GetDisplayName()]["$AccountWide"]["skin"] ~= "default" then
                    -- Skip styling for DolgubonsWrits if skin is not "default"
                else
                    PP:CreateBackground(dlwcSmallUI, nil, nil, nil, 0, 0, nil, nil, nil, 0, 0)
                    DolgubonsWritsBackdropBackdrop:SetHidden(true)
                end
            end
        end

        if DolgubonsLazyWritStatsWindow then
            PP:CreateBackground(DolgubonsLazyWritStatsWindowBackdrop, nil, nil, nil, 0, 0, nil, nil, nil, 0, 0)
            local scrollList = DolgubonsLazyWritStatsWindowRewardScroll.object.list
            PP.ScrollBar(scrollList)

            -- Style all rows in the list
            local dataType = ZO_ScrollList_GetDataTypeTable(scrollList, 1)
            local originalSetupCallback = dataType.setupCallback
            dataType.setupCallback = function (control, data)
                originalSetupCallback(control, data)

                -- Create backdrop if it doesn't exist
                if not control.backdrop then
                    local backdrop = PP.CreateBackdrop(control)
                    backdrop:SetCenterColor(20 / 255, 20 / 255, 20 / 255, 0.8)
                    backdrop:SetEdgeColor(40 / 255, 40 / 255, 40 / 255, 0.9)
                    backdrop:SetEdgeTexture("", 1, 1, 1, 0)
                    backdrop:SetInsets(1, 1, -1, -1)
                end

                -- Style each craft section in the row
                for i = 1, 7 do
                    local craftControl = control:GetNamedChild("Craft" .. i)
                    if craftControl then
                        -- Hide the default backdrop
                        local bg = craftControl:GetNamedChild("BG")
                        if bg then
                            bg:SetHidden(true)
                        end

                        -- Style the labels
                        local nameLabel = craftControl:GetNamedChild("Name")
                        local amountLabel = craftControl:GetNamedChild("Amount")

                        if nameLabel then
                            -- Keep original color (76BCC3 from WritCreater.xml)
                            PP.Font(nameLabel, PP.f.u67, 16, "outline")
                            PP.Anchor(nameLabel, --[[#1]] LEFT, craftControl, LEFT, 5, 0)
                        end

                        if amountLabel then
                            PP.Font(amountLabel, PP.f.u67, 16, "outline")
                            PP.Anchor(amountLabel, --[[#1]] RIGHT, craftControl, RIGHT, -5, 0)
                        end
                    end
                end

                -- Adjust row height (30px from XML)
                control:SetHeight(30)
                control:SetMouseEnabled(true)

                -- Add mouseover highlight behavior
                control:SetHandler("OnMouseEnter", function (self)
                    self.backdrop:SetCenterColor(30 / 255, 30 / 255, 30 / 255, 0.8)
                end)
                control:SetHandler("OnMouseExit", function (self)
                    self.backdrop:SetCenterColor(20 / 255, 20 / 255, 20 / 255, 0.8)
                end)
            end
        end

        -- ===============================================================================================--
        -- ==LibSets==--
        if LibSets then
            PP:CreateBackground(LibSets_SearchUI_TLC_KeyboardBG, --[[#1]] nil, nil, nil, 0, 0, --[[#2]] nil, nil, nil, 0, 0)
            PP.ScrollBar(LibSets_SearchUI_TLC_KeyboardContentListScrollBar)
            PP.Anchor(LibSets_SearchUI_TLC_KeyboardContentListScrollBar, --[[#1]] nil, nil, nil, nil, nil, --[[#2]] true, nil, nil, nil, nil, nil)
            ZO_Scroll_SetMaxFadeDistance(LibSets_SearchUI_TLC_KeyboardContentList, PP.savedVars.ListStyle.list_fade_distance)

            --Item set collections
            ITEM_SETS_BOOK_SCENE:RegisterCallback("StateChange", function (oldState, newState)
                if newState == SCENE_SHOWN then
                    if ZO_ItemSetsBook_Keyboard_TopLevelFiltersLibSetsMoreOptions ~= nil then
                        PP.Anchor(ZO_ItemSetsBook_Keyboard_TopLevelFiltersLibSetsMoreOptions, --[[#1]] RIGHT, ZO_ItemSetsBook_Keyboard_TopLevelFilters, RIGHT, -4, -8, --[[#2]] false, nil, nil, nil, nil, nil)
                    end
                end
            end)
        end

        -- ===============================================================================================--

        -- ==PortToFriend==--
        -- if PortToFriend then
        -- PP:CreateBackground(PortToFriend_Body_Backdrop, --[[#1]] nil, nil, nil, 0, 0, --[[#2]] nil, nil, nil, 0, 0)
        -- PortToFriend_Body_BackdropMungeOverlay:SetHidden(true)
        -- end

        -- ===============================================================================================--
        -- ===============================================================================================--

        -- ==MailHistory==--
        if MailHistory then
            PP:CreateBackground(MailHistory_MainWindow_Backdrop, --[[#1]] nil, nil, nil, 0, 0, --[[#2]] nil, nil, nil, 0, 0)
            PP.ScrollBar(MailHistory_ScrollListScrollBar)
            PP.Anchor(MailHistory_ScrollListScrollBar, --[[#1]] nil, nil, nil, nil, nil, --[[#2]] true, nil, nil, nil, nil, nil)
            ZO_Scroll_SetMaxFadeDistance(MailHistory_ScrollListContents, PP.savedVars.ListStyle.list_fade_distance)
            PP:CreateBackground(MailHistory_PopupWindow_Backdrop, --[[#1]] nil, nil, nil, 0, 0, --[[#2]] nil, nil, nil, 0, 0)
            MailHistory_MainWindow_BackdropMungeOverlay:SetHidden(true)
        end

        -- ===============================================================================================--

        -- ==ITTsGhostwriter==--
        if ITTsGhostwriter then
            PP:CreateBackground(GW_NotePad, --[[#1]] nil, nil, nil, 0, 0, --[[#2]] nil, nil, nil, 0, 0)
            PP.ScrollBar(GW_NotePad_ComposeScrollContainerScrollBar)
            PP.Anchor(GW_NotePad_ComposeScrollContainerScrollBar, --[[#1]] nil, nil, nil, nil, nil, --[[#2]] true, nil, nil, nil, nil, nil)
            ZO_Scroll_SetMaxFadeDistance(GW_NotePad_ComposeScrollContainer, PP.savedVars.ListStyle.list_fade_distance)
            PP:CreateBackground(GW_NotePad_BG, --[[#1]] nil, nil, nil, 0, 0, --[[#2]] nil, nil, nil, 0, 0)
            ITTsGhostwriterWindowGlow:SetHidden(true)
            GW_NotePad_BGMungeOverlay:SetHidden(true)
        end

        -- ===============================================================================================--

        -- ==LuiExtended==--
        if LUIE then
            PP:CreateBackground(LUIE_Changelog_Background, --[[#1]] nil, nil, nil, 0, 0, --[[#2]] nil, nil, nil, 0, 0)
            PP.ScrollBar(LUIE_Changelog_ContainerScrollBar)
            PP.Anchor(LUIE_Changelog_ContainerScrollBar, --[[#1]] nil, nil, nil, nil, nil, --[[#2]] true, nil, nil, nil, nil, nil)
            ZO_Scroll_SetMaxFadeDistance(LUIE_Changelog_Container, PP.savedVars.ListStyle.list_fade_distance)
            LUIE_Changelog_BackgroundMungeOverlay:SetHidden(true)
        end

        -- ===============================================================================================--
        -- ==displayleads==--
        if RDL then
            PP:CreateBackground(RDLMainWindowBG, --[[#1]] nil, nil, nil, 6, 6, --[[#2]] nil, nil, nil, -6, -6)
            PP.ScrollBar(RDLMainWindowListScrollBar)
            PP.Anchor(RDLMainWindowListScrollBar, --[[#1]] nil, nil, nil, nil, nil, --[[#2]] true, nil, nil, nil, nil, nil)
            ZO_Scroll_SetMaxFadeDistance(RDLMainWindowListContents, PP.savedVars.ListStyle.list_fade_distance)
            RDLMainWindowBGMungeOverlay:SetHidden(true)
        end
        -- ===============================================================================================--

        -- ==DebugLogViewer==--
        if DebugLogViewer then
            PP:CreateBackground(DebugLogViewerMainWindowBG, --[[#1]] nil, nil, nil, 0, 0, --[[#2]] nil, nil, nil, 0, 0)
            DebugLogViewerMainWindowBGMungeOverlay:SetHidden(true)

            PP.ScrollBar(DebugLogViewerMainWindowListScrollBar)
            ZO_Scroll_SetMaxFadeDistance(DebugLogViewerMainWindowList, 10)
            DebugLogViewerMainWindowListScrollBar:ClearAnchors()
            DebugLogViewerMainWindowListScrollBar:SetAnchor(TOPLEFT, DebugLogViewerMainWindowList, TOPRIGHT, 10, 25)
            DebugLogViewerMainWindowListScrollBar:SetAnchor(BOTTOMLEFT, DebugLogViewerMainWindowList, BOTTOMRIGHT, -6, -25)

            DebugLogViewerMainWindowListScrollBarUp:SetHidden(false)
            DebugLogViewerMainWindowListScrollBarDown:SetHidden(false)
        end

        --DebugLogViewer - Quicklog window
        if DebugLogWindow then
            PP.ScrollBar(DebugLogWindowScrollbar)
            ZO_Scroll_SetMaxFadeDistance(DebugLogWindow, 10)
            DebugLogWindowScrollbar:ClearAnchors()
            DebugLogWindowScrollbar:SetAnchor(TOPRIGHT, DebugLogWindow, TOPRIGHT, -10, 40)
            DebugLogWindowScrollbar:SetAnchor(BOTTOMRIGHT, DebugLogWindow, BOTTOMRIGHT, -8, -40)

            DebugLogWindowScrollbarScrollUp:SetHidden(false)
            DebugLogWindowScrollbarScrollDown:SetHidden(false)
        end
        -- ===============================================================================================--

        -- ==WritWorthy==--
        if WritWorthy then
            PP.ScrollBar(WritWorthyUIInventoryListListContents)
            PP.ScrollBar(WritWorthyMatUIListContainerListContents)
            ZO_Scroll_SetMaxFadeDistance(WritWorthyMatUIListContainerListScrollBar, PP.savedVars.ListStyle.list_fade_distance)
            ZO_Scroll_SetMaxFadeDistance(WritWorthyUIInventoryListListScrollBar, PP.savedVars.ListStyle.list_fade_distance)

            PP:CreateBackground(WritWorthyUIBG, --[[#1]] nil, nil, nil, 0, 0, --[[#2]] nil, nil, nil, 0, 0)
            PP:CreateBackground(WritWorthyMatWindowBG, --[[#1]] nil, nil, nil, 0, 0, --[[#2]] nil, nil, nil, 0, 0)

            WritWorthyMatWindowBGMungeOverlay:SetHidden(true)
            WritWorthyMatUIListContainerListScrollBarThumbMunge:SetHidden(true)
            WritWorthyUIBGMungeOverlay:SetHidden(true)
            WritWorthyUIInventoryListListScrollBarThumbMunge:SetHidden(true)
            WritWorthyUIInventoryListListEmptyRowBG:SetHidden(true)
        end
        -- ==AwesomeGuildStore==--z
        if AwesomeGuildStore then
            local function AwesomeGuildStore_Compatibility()
                PP.Anchor(AwesomeGuildStoreFooter, nil, nil, nil, nil, 50)
                PP.Anchor(AwesomeGuildStoreActivityStatusLine, nil, nil, nil, nil, -2)
                PP.Anchor(AwesomeGuildStoreGuildSelector, LEFT, ZO_TradingHouseTitle, LEFT, 0, -2)
                PP.Anchor(AwesomeGuildStoreGuildSelectorComboBoxOpenDropdown, LEFT, AwesomeGuildStoreGuildSelectorComboBoxSelectedItemText, RIGHT, 3, 5)
                PP.Font(AwesomeGuildStoreGuildSelectorComboBoxSelectedItemText, PP.f.u67, 30, "outline", 0.9, nil, nil, nil, nil, 0, 0, 0, 0.8)
                PP.ScrollBar(AwesomeGuildStoreFilterArea)
                ZO_Scroll_SetMaxFadeDistance(AwesomeGuildStoreFilterArea, 10)
                PP.ScrollBar(AwesomeGuildStoreActivityWindowContainerListContents)
                ZO_Scroll_SetMaxFadeDistance(AwesomeGuildStoreActivityWindowContainerListScrollBar, 10)

                PP:CreateBackground(AwesomeGuildStoreActivityWindowBG, nil, nil, nil, 0, 0, nil, nil, nil, 0, 0)
                AwesomeGuildStoreActivityWindowBGMungeOverlay:SetHidden(true)


                local function OnUpdateFn(rowControl)
                    rowControl:GetNamedChild("SellerName"):SetHidden(true)
                end

                -- Add post hook setup callback to hide seller name
                local list = TRADING_HOUSE.searchResultsList
                PP.PostHooksSetupCallback(list, 1, 1, nil, OnUpdateFn)
                PP.PostHooksSetupCallback(list, 2, 1, nil, OnUpdateFn)
                PP.PostHooksSetupCallback(list, 1, 3, nil, OnUpdateFn)
                PP.PostHooksSetupCallback(list, 2, 3, nil, OnUpdateFn)
            end
            -- Add function to load callback table
            tinsert(PP.LoadFunc_TRADING_HOUSE, AwesomeGuildStore_Compatibility)
        end

        -- ===============================================================================================--

        -- == ArkadiusTradeTools == --
        if ArkadiusTradeTools then
            local att_tab =
            {
                bg =
                {
                    ArkadiusTradeToolsWindow,
                    ArkadiusTradeToolsWindowBackdrop,
                    ArkadiusTradeToolsExportsFrameFilterBarTimeBG,
                    ArkadiusTradeToolsExportsFrameToolBarGuildSelectorBG,
                },
                sb =
                {
                    ArkadiusTradeToolsExportsFrameListContents,
                    ArkadiusTradeToolsPurchasesFrameListContents,
                    ArkadiusTradeToolsSalesFrameListContents,
                    ArkadiusTradeToolsStatisticsFrameListContents,
                },
            }

            for i, bg in ipairs(att_tab.bg) do
                PP:CreateBackground(bg, nil, nil, nil, -6, 0, nil, nil, nil, 0, 6)
            end

            for i, sb in ipairs(att_tab.sb) do
                PP.ScrollBar(sb)
            end

            local overlays =
            {
                ArkadiusTradeToolsExportsFrameFilterBarTimeBGMungeOverlay,
                ArkadiusTradeToolsExportsFrameToolBarGuildSelectorBGMungeOverlay,
                ArkadiusTradeToolsExportsFrameToolBarTimeSelectorBGMungeOverlay,
                ArkadiusTradeToolsPurchasesFrameFilterBarTimeBGMungeOverlay,
                ArkadiusTradeToolsSalesFrameFilterBarTimeBGMungeOverlay,
                ArkadiusTradeToolsStatisticsFrameFilterBarTimeBGMungeOverlay,
                ArkadiusTradeToolsWindowBackdropMungeOverlay,
                ArkadiusTradeToolsWindowHeaderBackgroundTopLeft,
                ArkadiusTradeToolsWindowHeaderBackgroundBottomLeft,
                ArkadiusTradeToolsWindowHeaderBackgroundLeft,
                ArkadiusTradeToolsWindowHeaderBackgroundTopRight,
                ArkadiusTradeToolsWindowHeaderBackgroundBottomRight,
                ArkadiusTradeToolsWindowHeaderBackgroundRight,
                ArkadiusTradeToolsWindowHeaderBackgroundTop,
                ArkadiusTradeToolsWindowHeaderBackgroundBottom,
                ArkadiusTradeToolsWindowHeaderBackgroundCenter,
            }

            for i, overlay in ipairs(overlays) do
                overlay:SetHidden(true)
            end

            PP.Anchor(ZO_TradingHouseBrowseItemsLeftPane, nil, nil, nil, nil, nil, true, nil, nil, nil, nil, -80)
            PP.Anchor(ZO_TradingHouseBrowseItemsLeftPaneCategoryListContainer, nil, nil, nil, nil, nil, true, nil, nil, nil, nil, -10)

            local function OnCreateFn(rowControl, result)
                local name = rowControl:GetNamedChild("Name")
                local timeRemaining = rowControl:GetNamedChild("TimeRemaining")
                local sellPrice = rowControl:GetNamedChild("SellPriceText")
                local pricePerUnit = rowControl:GetNamedChild("SellPricePerUnitText")

                PP:SetLockFn(name, "SetWidth")
                PP:SetLockFn(timeRemaining, "SetAnchor")
                PP:SetLockFn(timeRemaining, "ClearAnchors")
                PP:SetLockFn(sellPrice, "SetAnchor")
                PP:SetLockFn(sellPrice, "ClearAnchors")
                PP:SetLockFn(pricePerUnit, "SetAnchor")
                PP:SetLockFn(pricePerUnit, "ClearAnchors")
            end

            local function OnUpdateFn(rowControl, result)
                if not rowControl.ATT_Fix then
                    local profitMargin = rowControl:GetNamedChild("ProfitMargin")
                    local averagePricePerUnit = rowControl:GetNamedChild("AveragePricePerUnit")
                    local averagePrice = rowControl:GetNamedChild("AveragePrice")

                    if profitMargin then
                        PP.Font(profitMargin, PP.f.u67, 15, "shadow", 0.8, nil, nil, nil, nil, 0, 0, 0, 0.5)
                        PP.Anchor(profitMargin, nil, nil, nil, 0, 0)
                        PP:SetLockFn(profitMargin, "SetFont")

                        if averagePrice then
                            PP.Font(averagePrice, PP.f.u67, 14, "shadow", 0.8, nil, nil, nil, nil, 0, 0, 0, 0.5)
                            PP.Anchor(averagePrice, TOPRIGHT, rowControl, TOPRIGHT, -145, 2)
                            PP:SetLockFn(averagePrice, "SetFont")
                            PP:SetLockFn(averagePrice, "SetAnchor")
                            PP:SetLockFn(averagePrice, "ClearAnchors")
                        end

                        if averagePricePerUnit then
                            PP.Font(averagePricePerUnit, PP.f.u67, 14, "shadow", 0.8, nil, nil, nil, nil, 0, 0, 0, 0.5)
                            PP.Anchor(averagePricePerUnit, TOPRIGHT, averagePrice, BOTTOMRIGHT, 0, -2)
                            PP:SetLockFn(averagePricePerUnit, "SetFont")
                            PP:SetLockFn(averagePricePerUnit, "SetAnchor")
                            PP:SetLockFn(averagePricePerUnit, "ClearAnchors")
                        end

                        rowControl.ATT_Fix = true
                    end
                end
            end

            local function ArkadiusTradeTools_Compatibility()
                local list = TRADING_HOUSE.searchResultsList
                PP.PostHooksSetupCallback(list, 1, 1, OnCreateFn, OnUpdateFn)
                PP.PostHooksSetupCallback(list, 2, 1, OnCreateFn, OnUpdateFn)
                PP.PostHooksSetupCallback(list, 1, 3, OnCreateFn, OnUpdateFn)
                PP.PostHooksSetupCallback(list, 2, 3, OnCreateFn, OnUpdateFn)

                if not AwesomeGuildStore then
                    PP.Anchor(ZO_TradingHouseBrowseItemsRightPaneSearchSortByTimeRemainingName, RIGHT, ZO_TradingHouseBrowseItemsRightPaneSearchSortByPricePerUnitName, LEFT, -180, 0)
                    ZO_TradingHouse:SetWidth(1000)
                end
            end

            tinsert(PP.LoadFunc_TRADING_HOUSE, ArkadiusTradeTools_Compatibility)
        end
        -- ===============================================================================================--

        -- ==MasterMerchant==--
        if MasterMerchant then
            local mm_tab =
            {
                bg = { MasterMerchantWindowBG, MasterMerchantReportsWindowBG, MasterMerchantListingWindowBG, MasterMerchantGuildWindowBG, MasterMerchantPurchaseWindowBG, MasterMerchantStatsWindowBG, MasterMerchantFeedbackBG },
                sb = { MasterMerchantWindowListScrollBar, MasterMerchantReportsWindowListScrollBar, MasterMerchantListingWindowListScrollBar, MasterMerchantGuildWindowListScrollBar, MasterMerchantPurchaseWindowListScrollBar },
            }
            for i = 1, #mm_tab.bg do
                PP:CreateBackground(mm_tab.bg[i], --[[#1]] nil, nil, nil, -6, 0, --[[#2]] nil, nil, nil, 0, 6)
            end
            for i = 1, #mm_tab.sb do
                PP.ScrollBar(mm_tab.sb[i])
            end

            local overlays =
            {
                MasterMerchantWindowBGMungeOverlay,
                MasterMerchantGuildWindowBGMungeOverlay,
                MasterMerchantPurchaseWindowBGMungeOverlay,
                MasterMerchantListingWindowBGMungeOverlay,
                MasterMerchantReportsWindowBGMungeOverlay,
                MasterMerchantFeedbackBGMungeOverlay,
                MasterMerchantStatsWindowBGMungeOverlay,
            }

            for i, overlay in ipairs(overlays) do
                overlay:SetHidden(true)
            end

            PP.Anchor(ZO_TradingHouseBrowseItemsLeftPane, --[[#1]] nil, nil, nil, nil, nil, --[[#2]] true, nil, nil, nil, nil, -50)

            local function OnCreateFn(rowControl, result)
                local timeRemaining = rowControl:GetNamedChild("TimeRemaining")
                local sellPrice = rowControl:GetNamedChild("SellPriceText")
                local pricePerUnit = rowControl:GetNamedChild("SellPricePerUnitText")

                PP:SetLockFn(timeRemaining, "SetAnchor")
                PP:SetLockFn(timeRemaining, "ClearAnchors")
                PP:SetLockFn(sellPrice, "SetAnchor")
                PP:SetLockFn(sellPrice, "ClearAnchors")
                PP:SetLockFn(pricePerUnit, "SetAnchor")
                PP:SetLockFn(pricePerUnit, "ClearAnchors")
            end

            local function OnUpdateFn(rowControl, result, ...)
                if not rowControl.MM_Fix then
                    local buyingAdvice = rowControl:GetNamedChild("BuyingAdvice")
                    if buyingAdvice then
                        PP.Font(buyingAdvice, --[[Font]] PP.f.u67, 14, "shadow", --[[Alpha]] 0.8, --[[Color]] nil, nil, nil, nil, --[[StyleColor]] 0, 0, 0, 0.5)
                        PP.Anchor(buyingAdvice, --[[#1]] LEFT, nil, RIGHT, 0, 0)
                        PP:SetLockFn(buyingAdvice, "SetFont")
                        PP:SetLockFn(buyingAdvice, "SetAnchor")
                        PP:SetLockFn(buyingAdvice, "ClearAnchors")
                        rowControl.MM_Fix = true
                    end
                end
            end

            local function MasterMerchant_Compatibility()
                local list = TRADING_HOUSE.searchResultsList
                PP.PostHooksSetupCallback(list, 1, 1, OnCreateFn)
                PP.PostHooksSetupCallback(list, 2, 1, OnCreateFn)
                PP.PostHooksSetupCallback(list, 1, 3, OnCreateFn)
                PP.PostHooksSetupCallback(list, 2, 3, OnCreateFn)
            end
            tinsert(PP.LoadFunc_TRADING_HOUSE, MasterMerchant_Compatibility)

            ZO_PostHook(MasterMerchant, "AddBuyingAdvice", function (rowControl, result, ...)
                OnUpdateFn(rowControl, result, ...)
            end)
        end
        -- ===============================================================================================--

        -- ==LibAddonMenu-2.0==--
        if LibAddonMenu2 then
            PP.ScrollBar(LAMAddonSettingsWindowAddonListScrollBar)
            PP.Anchor(LAMAddonSettingsWindowAddonListScrollBar, --[[#1]] nil, nil, nil, nil, nil, --[[#2]] true, nil, nil, nil, nil, nil)
            ZO_Scroll_SetMaxFadeDistance(LAMAddonSettingsWindowAddonListContents, PP.savedVars.ListStyle.list_fade_distance)

            LAMAddonSettingsWindowBackgroundLeft:SetHidden(true)
            LAMAddonSettingsWindowBackgroundRight:SetHidden(true)
            LAMAddonSettingsWindowUnderlayLeft:SetHidden(true)
            LAMAddonSettingsWindowUnderlayRight:SetHidden(true)
	        PP:CreateBackground(LAMAddonSettingsWindow,		--[[#1]] nil, nil, nil, 40, 60, --[[#2]] nil, nil, nil, 46, -50)

            --Use LAM2-.0 callback "panel opened" to know when a panel was created, and add the PP style scrollbar then "once"
            local panelsWithPPScrollbar = {}
            local function addPPScrollbarToLAM2Panel(panel, updateScrollBar)
                updateScrollBar = updateScrollBar or false
                local scrollBarCtrl = (panel and panel.container and panel.container.scrollbar) or nil
                if scrollBarCtrl  ~= nil then
                    if not updateScrollBar then
                        PP.ScrollBar(scrollBarCtrl)
                        local scrollBarParent = scrollBarCtrl:GetParent()
                        PP.Anchor(scrollBarCtrl, --[[#1]] TOPLEFT, scrollBarParent, TOPRIGHT, nil, nil, --[[#2]] true, BOTTOMLEFT, scrollBarParent, BOTTOMRIGHT, 10, 0)
                        panelsWithPPScrollbar[panel] = true
                    end
                    ZO_Scroll_SetMaxFadeDistance(scrollBarCtrl, PP.savedVars.ListStyle.list_fade_distance)
                end
            end

            CM:RegisterCallback("LAM-PanelOpened", function(panel)
                if panel and panelsWithPPScrollbar[panel] then return end
                addPPScrollbarToLAM2Panel(panel, false)
            end)
            CM:RegisterCallback("LAM-PanelControlsCreated", function(panel)
                if not panel then return end
                if panelsWithPPScrollbar[panel] then
                    --Just update the scrollbar bounds
                    addPPScrollbarToLAM2Panel(panel, true)
                else
                    addPPScrollbarToLAM2Panel(panel, false)
                end
            end)
        end

        -- ===============================================================================================--

        -- ==pChat==--
        if pChat then
            pChat.ChangeChatWindowDarkness = PP.Empty
            ZO_PostHook(pChat, "ApplyChatConfig", function (...)
                PP:UpdateBackgrounds("ChatWindow")
            end)
        end

        -- ===============================================================================================--

        -- ==rChat==--
        if rChat then
            rChat.ChangeChatWindowDarkness = PP.Empty
            ZO_PostHook(rChat, "ApplyChatConfig", function (...)
                PP:UpdateBackgrounds("ChatWindow")
            end)
        end
        -- ===============================================================================================--

        -- ==LibHistoire==--
        if LibHistoire then
            local wasHistyHooked = false
            SecurePostHook(ZO_GuildHistory_Keyboard, "OnDeferredInitialize", function ()
                if not wasHistyHooked then
                    local guildHistoryKeyboardTLCCtrl = ZO_GuildHistory_Keyboard_TL
                    local histyGuildHistoryTLC = LibHistoireGuildHistoryStatusWindow
                    local histyGuildHistoryTLCBG = histyGuildHistoryTLC:GetNamedChild("Bg") -- LibHistoireGuildHistoryStatusWindowBg
                    if histyGuildHistoryTLCBG ~= nil then
                        PP:CreateBackground(histyGuildHistoryTLCBG, --[[#1]] nil, nil, nil, -6, 0, --[[#2]] nil, nil, nil, 0, 6)
                    end

                    wasHistyHooked = true

                    local function updateHistyUIForPP()
                        local histyGuildHistoryTLCToggleButton = histyGuildHistoryTLC:GetNamedChild("ToggleButton") -- LibHistoireGuildHistoryStatusWindowToggleButton
                        if histyGuildHistoryTLCToggleButton ~= nil then
                            histyGuildHistoryTLCToggleButton:ClearAnchors()
                            histyGuildHistoryTLCToggleButton:SetAnchor(BOTTOMLEFT, guildHistoryKeyboardTLCCtrl, BOTTOMLEFT, 0, 5)
                        end

                        PP.Anchor(LibHistoireLinkedIcon, --[[#1]] BOTTOMRIGHT, guildHistoryKeyboardTLCCtrl, BOTTOMRIGHT, -20, 5)
                    end
                    updateHistyUIForPP()

                    --[[
                    GUILD_HISTORY_KEYBOARD_SCENE:RegisterCallback("StateChange", function(oldState, newState)
                        if newState == SCENE_SHOWN then
d("[PP]GUILD_HISTORY_KEYBOARD_SCENE:SHown")
                            updateHistyUIForPP()
                        end
                    end)
                    ]]
                end
            end)
        end
        -- ===============================================================================================--

        -- ==FCO ChangeStuff==--
        if FCOCS then
            MAIL_SEND_SCENE:RegisterCallback("StateChange", function (oldState, newState)
                if newState == SCENE_SHOWN then
                    local mailSettingsGearButton = ZO_MailSend_FCOChangeStuff_FCOCS_MailSettingsContextMenu
                    local mailReceiverTriangleButton = ZO_MailSendToLabel_FCOChangeStuff_FCOCS_MailRecipientsContextMenu
                    local mailSubjectTriangleButton = ZO_MailSendSubjectLabel_FCOChangeStuff_FCOCS_MailSubjectsContextMenu
                    local mailTextTriangleButton = ZO_MailSendBody_FCOChangeStuff_FCOCS_MailTextsContextMenu

                    if mailSettingsGearButton ~= nil then
                        mailSettingsGearButton:ClearAnchors()
                        mailSettingsGearButton:SetAnchor(TOPLEFT, ZO_MailSend, TOPLEFT, -10, -10)
                    end
                    if mailReceiverTriangleButton ~= nil then
                        mailReceiverTriangleButton:ClearAnchors()
                        mailReceiverTriangleButton:SetAnchor(LEFT, ZO_MailSendToLabel, RIGHT, 15, 0)
                    end
                    if mailSubjectTriangleButton ~= nil then
                        mailSubjectTriangleButton:ClearAnchors()
                        mailSubjectTriangleButton:SetAnchor(LEFT, ZO_MailSendSubjectLabel, RIGHT, 15, 0)
                    end
                    if mailTextTriangleButton ~= nil then
                        mailTextTriangleButton:ClearAnchors()
                        mailTextTriangleButton:SetAnchor(TOPLEFT, ZO_MailSendBody, TOPLEFT, -5, -19)
                    end
                end
            end)

            GUILD_HISTORY_KEYBOARD_SCENE:RegisterCallback("StateChange", function (oldState, newState)
                if newState == SCENE_SHOWN then
                    --[[ -- Change size of guild history first and last buttons ]]
                    if FCOChangeStuff_GuildHistory_Nav_FirstPageButton ~= nil then
                        FCOChangeStuff_GuildHistory_Nav_FirstPageButton:SetDimensions(44, 44)
                    end
                    if FCOChangeStuff_GuildHistory_Nav_LastPageButton ~= nil then
                        FCOChangeStuff_GuildHistory_Nav_LastPageButton:SetDimensions(44, 44)
                    end
                end
            end)
        end

        -- ===============================================================================================--

        -- ==FarmingParty==--
        if FarmingParty then
            PP:CreateBackground(FarmingPartyWindowBG, --[[#1]] nil, nil, nil, 0, 0, --[[#2]] nil, nil, nil, 0, 0)
            PP:CreateBackground(FarmingPartyMembersWindowBG, --[[#1]] nil, nil, nil, 0, 0, --[[#2]] nil, nil, nil, 0, 0)
            PP.Font(FarmingPartyMembersWindowHeadersFarmerName, --[[Font]] PP.f.u57, 16, "outline", --[[Alpha]] nil, --[[Color]] nil, nil, nil, nil, --[[StyleColor]] 0, 0, 0, 0.5)
            PP.Font(FarmingPartyMembersWindowHeadersBestItemNameName, --[[Font]] PP.f.u57, 16, "outline", --[[Alpha]] nil, --[[Color]] nil, nil, nil, nil, --[[StyleColor]] 0, 0, 0, 0.5)
            PP.Font(FarmingPartyMembersWindowTitle, --[[Font]] PP.f.u67, 18, "outline", --[[Alpha]] nil, --[[Color]] nil, nil, nil, nil, --[[StyleColor]] 0, 0, 0, 0.5)
            FarmingPartyWindowBGMungeOverlay:SetHidden(true)
            FarmingPartyMembersWindowBGMungeOverlay:SetHidden(true)
        end
        -- ===============================================================================================--

        -- ==ExtendedJournal==
        --Initial compatibility started by DakJaniels. Many thanks!
        -->Proper function SetAlternateMode added by code65536 -> Many thanks for adding this
        if LibExtendedJournal and LibExtendedJournal.SetAlternateMode then
            local callbackMain = function ()
                local frame = LibExtendedJournal.GetFrame()
                PP:CreateBackground(frame, --[[#1]] nil, nil, nil, 0, 0, --[[#2]] nil, nil, nil, 0, 10)
                PP.Anchor(frame, --[[#1]] TOPRIGHT, GuiRoot, TOPRIGHT, 0, 120, --[[#2]] true, BOTTOMRIGHT, GuiRoot, BOTTOMRIGHT, 0, -70)
                PP.Font(frame:GetNamedChild("MenuBar"):GetNamedChild("Label"), --[[Font]] PP.f.u67, 22, "outline", --[[Alpha]] 0.9, --[[Color]] nil, nil, nil, nil, --[[StyleColor]] 0, 0, 0, 0.5)
            end
            local callbackList = function (control)
                PP.ScrollBar(control)
            end
            LibExtendedJournal.SetAlternateMode(callbackMain, callbackList)
        end

        -- ===============================================================================================--


        -- ===============================================================================================--
        -- ==Misc ZO things==--
        -- ===============================================================================================--

        -- ==ZO_UIErrors==--
        if ZO_UIErrors then
            PP:CreateBackground(ZO_UIErrors, --[[#1]] nil, nil, nil, 0, 0, --[[#2]] nil, nil, nil, 0, 0)
            ZO_UIErrorsBG:SetHidden(false)
            ZO_UIErrorsBGMungeOverlay:SetHidden(true)
        end

        -- ==ZO_ComboBoxDropdown_Singleton_Keyboard==--
        if ZO_ComboBoxDropdown_Singleton_Keyboard then
            PP:CreateBackground(ZO_ComboBoxDropdown_Singleton_KeyboardScroll, --[[#1]] nil, nil, nil, 0, 0, --[[#2]] nil, nil, nil, 0, 0)
            PP:CreateBackground(ZO_ComboBoxDropdown_Singleton_KeyboardBG, --[[#1]] nil, nil, nil, 0, 0, --[[#2]] nil, nil, nil, 0, 0)
            PP.ScrollBar(ZO_ComboBoxDropdown_Singleton_KeyboardScrollScrollBar, --[[sb_c]] 180, 180, 180, 0.7, --[[bd_c]] 20, 20, 20, 0.7, true)
            PP.Anchor(ZO_ComboBoxDropdown_Singleton_KeyboardScrollScrollBar, --[[#1]] nil, nil, nil, nil, nil, --[[#2]] true, nil, nil, nil, -10, 0)
            ZO_Scroll_SetMaxFadeDistance(ZO_ComboBoxDropdown_Singleton_KeyboardScrollContents, PP.savedVars.ListStyle.list_fade_distance)
            ZO_ComboBoxDropdown_Singleton_KeyboardScrollScrollBarThumbMunge:SetHidden(true)
            ZO_ComboBoxDropdown_Singleton_KeyboardBGMungeOverlay:SetHidden(true)
        end


        -- ===============================================================================================--
        -- UnregisterForEvent--
        EVENT_MANAGER:UnregisterForEvent(PP.ADDON_NAME .. "Compatibility", EVENT_PLAYER_ACTIVATED)
    end

    EVENT_MANAGER:RegisterForEvent(PP.ADDON_NAME .. "Compatibility", EVENT_PLAYER_ACTIVATED, Compatibility)
end
