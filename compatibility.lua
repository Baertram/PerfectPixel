PP.compatibility = function()
	local PP = PP

	local function Compatibility()
		--==LibCustomMenu==--
		if LibCustomMenu then
			local lcmSM = LibCustomMenuSubmenu
			local lcmSMBG             = GetControl(lcmSM, "BG")
			local lcmSMBGMungeOverlay = GetControl(lcmSMBG, "MungeOverlay")
			local lcmSMHighlight   = GetControl(lcmSM, "Highlight")

			ZO_PreHookHandler(LibCustomMenuSubmenu, 'OnShow', function()
				lcmSMBG:SetCenterTexture(nil, 4, 0)
				lcmSMBG:SetCenterColor(10/255, 10/255, 10/255, .96)
				lcmSMBG:SetEdgeTexture(nil, 1, 1, 1, 0)
				lcmSMBG:SetEdgeColor(60/255, 60/255, 60/255, 1)
				lcmSMBG:SetInsets(-1, -1, 1, 1)
				if lcmSMBGMungeOverlay then lcmSMBGMungeOverlay:SetHidden(true) end
			end)

			PP.Anchor(lcmSMBG, --[[#1]] TOPLEFT, nil, TOPLEFT, -2, 4, --[[#2]] true, BOTTOMRIGHT, nil, BOTTOMRIGHT, -2, -4)
			-- lcmSMBG:SetInheritAlpha(false)

			if lcmSMHighlight then
				lcmSMHighlight:SetCenterTexture(nil, 4, 0)
				lcmSMHighlight:SetCenterColor(96/255*.3, 125/255*.3, 139/255*.3, 1)
				lcmSMHighlight:SetEdgeTexture(nil, 1, 1, 1, 0)
				lcmSMHighlight:SetEdgeColor(96/255*.5, 125/255*.5, 139/255*.5, 0)
				lcmSMHighlight:SetInsets(0, 0, 0, 0)
				-- lcmSMHighlight:SetInheritAlpha(false)
			end
		end

		--==CraftBagExtended==--
			if CraftBagExtended then
				CraftBagExtendedVendorMenu:SetParent(ZO_StoreWindowMenu)
				PP.Anchor(CraftBagExtendedVendorMenu,		--[[#1]] TOPLEFT, ZO_StoreWindowMenu,	TOPLEFT, 80, 0)

				CraftBagExtendedHouseBankMenu:SetParent(ZO_HouseBankMenu)
				PP.Anchor(CraftBagExtendedHouseBankMenu,	--[[#1]] TOPLEFT, ZO_HouseBankMenu,		TOPLEFT, 80, 0)

				CraftBagExtendedBankMenu:SetParent(ZO_PlayerBankMenu)
				PP.Anchor(CraftBagExtendedBankMenu,			--[[#1]] TOPLEFT, ZO_PlayerBankMenu,	TOPLEFT, 80, 0)

				CraftBagExtendedGuildBankMenu:SetParent(ZO_GuildBankMenu)
				PP.Anchor(CraftBagExtendedGuildBankMenu,	--[[#1]] TOPLEFT, ZO_GuildBankMenu,		TOPLEFT, 80, 0)

				CraftBagExtendedMailMenu:SetParent(ZO_MailSend)
				PP.Anchor(CraftBagExtendedMailMenu,			--[[#1]] TOPLEFT, ZO_MailSend,			TOPLEFT, 420, -55)

				-- CraftBagExtendedTradeMenu:SetParent(parent)
				-- PP.Anchor(CraftBagExtendedTradeMenu,		--[[#1]] TOPLEFT, parent,		TOPLEFT, 80, 0)
			end
		--===============================================================================================--

		--==AddonSelector==--
		if AddonSelector then
			PP.Anchor(ZO_AddOnsList,					--[[#1]] TOPLEFT,	AddonSelector,					BOTTOMLEFT, 0, 5, --[[#2]] true, BOTTOMRIGHT, ZO_AddOns, BOTTOMRIGHT, 0, -10)
			PP.Anchor(AddonSelectorBottomDivider,		--[[#1]] BOTTOM,	AddonSelector,					BOTTOM, 40, 0)
			PP.Anchor(AddonSelectorSearchBox,			--[[#1]] TOPRIGHT,	ZO_AddOns,						TOPRIGHT, -6, 6)
			if AddonSelectorAutoReloadUI and AddonSelectorAutoReloadUILabel then
				PP.Anchor(AddonSelectorAutoReloadUILabel,	--[[#1]] TOPRIGHT,	AddonSelectorSearchBox,			BOTTOMRIGHT, 0, 6)
				PP.Anchor(AddonSelectorAutoReloadUI,		--[[#1]] RIGHT,		AddonSelectorAutoReloadUILabel,	LEFT, -6, 0)
			end
			PP.Font(AddonSelectorDeselectAddonsButtonKeyLabel,	--[[Font]] PP.f.u57, 16, "outline", --[[Alpha]] nil, --[[Color]] nil, nil, nil, nil, --[[StyleColor]] 0, 0, 0, .5)
			PP.Font(AddonSelectorDeselectAddonsButtonNameLabel,	--[[Font]] PP.f.u67, 18, "outline", --[[Alpha]] nil, --[[Color]] nil, nil, nil, nil, --[[StyleColor]] 0, 0, 0, .5)
			PP.Font(AddonSelectorSelectAddonsButtonKeyLabel,	--[[Font]] PP.f.u57, 16, "outline", --[[Alpha]] nil, --[[Color]] nil, nil, nil, nil, --[[StyleColor]] 0, 0, 0, .5)
			PP.Font(AddonSelectorSelectAddonsButtonNameLabel,	--[[Font]] PP.f.u67, 18, "outline", --[[Alpha]] nil, --[[Color]] nil, nil, nil, nil, --[[StyleColor]] 0, 0, 0, .5)

			--AddonSelector
			PP.fixDrawZ(AddonSelector)
		end
		--===============================================================================================--

		--==MailLooter==--
			if MailLooter then
				MAIL_LOOTER_SCENE:RemoveFragment(TITLE_FRAGMENT)
				MAIL_LOOTER_SCENE:RemoveFragment(MAIL_TITLE_FRAGMENT)
				MAIL_LOOTER_SCENE:RemoveFragment(FRAME_PLAYER_FRAGMENT)
				PP.Anchor(MailLooterLootList, --[[#1]] TOP, MailLooterLootHeaders, BOTTOM, 0, 0, --[[#2]] true, BOTTOMRIGHT, ZO_MailInbox, BOTTOMRIGHT,	0, -100)
			end
		--===============================================================================================--

		--==ESO Master Recipe List==--
			if ESOMRL then
				local resultTooltip	= PROVISIONER.resultTooltip
				PP:SetLockedFn(resultTooltip, 'SetAnchor')
				PP:SetLockedFn(resultTooltip, 'ClearAnchors')
			end
		--===============================================================================================--

		--==Potion Maker==--
		if PotMaker then
			PP.Anchor(ZO_AlchemyTopLevelContent,				--[[#1]] TOPRIGHT, ZO_AlchemyTopLevel, TOPRIGHT, 0, 100, --[[#2]] true, BOTTOMRIGHT, ZO_AlchemyTopLevel, BOTTOMRIGHT, 0, -80)
			ZO_AlchemyTopLevelContent:SetWidth(565)
			PP:CreateBackground(ZO_AlchemyTopLevelPotionMaker,	--[[#1]] nil, nil, nil, -6, 0, --[[#2]] nil, nil, nil, 0, 6)
			PP:CreateBackground(ZO_AlchemyTopLevelPoisonMaker,	--[[#1]] nil, nil, nil, -6, 0, --[[#2]] nil, nil, nil, 0, 6)
		end
		--===============================================================================================--
		
		--==AwesomeGuildStore==--
		if AwesomeGuildStore then
			local function func()
				PP.Anchor(AwesomeGuildStoreFooter, --[[#1]] nil, nil, nil, nil, 50)
				PP.Anchor(AwesomeGuildStoreActivityStatusLine, --[[#1]] nil, nil, nil, nil, -2)
				PP.Anchor(AwesomeGuildStoreGuildSelector, --[[#1]] LEFT, ZO_TradingHouseTitle, LEFT, 0, -2)
				PP.Anchor(AwesomeGuildStoreGuildSelectorComboBoxOpenDropdown, --[[#1]] LEFT, AwesomeGuildStoreGuildSelectorComboBoxSelectedItemText, RIGHT, 3, 5)
				PP.Font(AwesomeGuildStoreGuildSelectorComboBoxSelectedItemText, --[[Font]] PP.f.u67, 30, "outline", --[[Alpha]] .9, --[[Color]] nil, nil, nil, nil, --[[StyleColor]] 0, 0, 0, .8)

				PP.ScrollBar(AwesomeGuildStoreFilterArea, --[[sb_c]] 180, 180, 180, .7, --[[bd_c]] 20, 20, 20, .7, false)
				-- PP.Anchor(AwesomeGuildStoreFilterArea, --[[#1]] TOPLEFT, ZO_TradingHouseBrowseItemsLeftPane, TOPLEFT, 0, 0 , --[[#2]] true, BOTTOMRIGHT, ZO_TradingHouseBrowseItemsLeftPane, BOTTOMRIGHT, 23, -1)
				ZO_Scroll_SetMaxFadeDistance(AwesomeGuildStoreFilterArea, 10)

				--AwesomeGuildStoreSearchCategorySelector
				PP.fixDrawZ(AwesomeGuildStoreSearchCategorySelector)


				EVENT_MANAGER:UnregisterForEvent(PP.ADDON_NAME .. 'AwesomeGuildStore' .. 'tradingHouseScene', EVENT_OPEN_TRADING_HOUSE, func)
			end
			EVENT_MANAGER:RegisterForEvent(PP.ADDON_NAME .. 'AwesomeGuildStore' .. 'tradingHouseScene', EVENT_OPEN_TRADING_HOUSE, func)
		end
		--===============================================================================================--

		--==MasterMerchant==--
		if MasterMerchant then
			PP.Anchor(ZO_TradingHouseBrowseItemsLeftPane, --[[#1]] nil, nil, nil, nil, nil, --[[#2]] true, nil, nil, nil, nil, -50)

			--By Troodon80, 2022-06-25, PerfectPixel comments at www.esoui.com
            PP:CreateBackground(MasterMerchantWindow,			--[[#1]] nil, nil, nil, -6, 0, --[[#2]] nil, nil, nil, 0, 6)
            MasterMerchantWindowBG:SetHidden(true)
            PP.ScrollBar(MasterMerchantWindowListScrollBar,		--[[sb_c]] 180, 180, 180, .7, --[[bd_c]] 20, 20, 20, .7, false)
            MasterMerchantWindowMenuHeader:SetDrawTier(DT_MEDIUM)
            MasterMerchantWindowMenuDivider:SetDrawTier(DT_MEDIUM)

            PP:CreateBackground(MasterMerchantReportsWindow,		--[[#1]] nil, nil, nil, -6, 0, --[[#2]] nil, nil, nil, 0, 6)
            MasterMerchantReportsWindowBG:SetHidden(true)
            PP.ScrollBar(MasterMerchantReportsWindowListScrollBar,	--[[sb_c]] 180, 180, 180, .7, --[[bd_c]] 20, 20, 20, .7, false)
            MasterMerchantReportsWindowMenuHeader:SetDrawTier(DT_MEDIUM)
            MasterMerchantReportsWindowMenuDivider:SetDrawTier(DT_MEDIUM)

            PP:CreateBackground(MasterMerchantListingWindow,		--[[#1]] nil, nil, nil, -6, 0, --[[#2]] nil, nil, nil, 0, 6)
            MasterMerchantListingWindowBG:SetHidden(true)
            PP.ScrollBar(MasterMerchantListingWindowListScrollBar,	--[[sb_c]] 180, 180, 180, .7, --[[bd_c]] 20, 20, 20, .7, false)
            MasterMerchantListingWindowMenuHeader:SetDrawTier(DT_MEDIUM)
            MasterMerchantListingWindowMenuDivider:SetDrawTier(DT_MEDIUM)

            PP:CreateBackground(MasterMerchantGuildWindow,		--[[#1]] nil, nil, nil, -6, 0, --[[#2]] nil, nil, nil, 0, 6)
            MasterMerchantGuildWindowBG:SetHidden(true)
            PP.ScrollBar(MasterMerchantGuildWindowListScrollBar,	--[[sb_c]] 180, 180, 180, .7, --[[bd_c]] 20, 20, 20, .7, false)
            MasterMerchantGuildWindowMenuHeader:SetDrawTier(DT_MEDIUM)
            MasterMerchantGuildWindowMenuDivider:SetDrawTier(DT_MEDIUM)

            PP:CreateBackground(MasterMerchantPurchaseWindow,		--[[#1]] nil, nil, nil, -6, 0, --[[#2]] nil, nil, nil, 0, 6)
            MasterMerchantPurchaseWindowBG:SetHidden(true)
            PP.ScrollBar(MasterMerchantPurchaseWindowListScrollBar,	--[[sb_c]] 180, 180, 180, .7, --[[bd_c]] 20, 20, 20, .7, false)
            MasterMerchantPurchaseWindowMenuHeader:SetDrawTier(DT_MEDIUM)
            MasterMerchantPurchaseWindowMenuDivider:SetDrawTier(DT_MEDIUM)
            -- Smaller Master Merchant dialog windows
            -- Stats
            PP:CreateBackground(MasterMerchantStatsWindow,		--[[#1]] nil, nil, nil, -6, 0, --[[#2]] nil, nil, nil, 0, 6)
            MasterMerchantStatsWindowBG:SetHidden(true)
            MasterMerchantStatsGuildChooser:SetDrawTier(DT_MEDIUM)
            MasterMerchantStatsWindowSlider:SetDrawTier(DT_MEDIUM)
            -- Feedback/donations
            PP:CreateBackground(MasterMerchantFeedback,			--[[#1]] nil, nil, nil, -6, 0, --[[#2]] nil, nil, nil, 0, 6)
            MasterMerchantFeedbackBG:SetHidden(true)
		end
		--===============================================================================================--

		--==ArkadiusTradeTools==--
		if ArkadiusTradeTools then
			PP.Anchor(ZO_TradingHouseBrowseItemsLeftPane, --[[#1]] nil, nil, nil, nil, nil, --[[#2]] true, nil, nil, nil, nil, -80)
		end
		--===============================================================================================--

		--==VotansMiniMap==--
		if VOTANS_MINIMAP then
			if not PP.toggles["compass"] then return end

			ZO_CompassFrameLeft:SetHidden(true)
			ZO_CompassFrameRight:SetHidden(true)
			ZO_CompassFrameCenter:SetHidden(true)
			PP:SetLockedFn(ZO_CompassFrameLeft, 'SetHidden')
			PP:SetLockedFn(ZO_CompassFrameRight, 'SetHidden')
			PP:SetLockedFn(ZO_CompassFrameCenter, 'SetHidden')
		end
		--===============================================================================================--

		--==InventoryInsightFromAshes==--
		if IIFA_GUI ~= nil then
			PP:CreateBackground(IIFA_GUI,	--[[#1]] nil, nil, nil, -6, 0, --[[#2]] nil, nil, nil, 0, 6)
			IIFA_GUI_BG:SetHidden(true)
			--IIFA_GUI_BG
			--IIFA_GUI_Header
			--IIFA_GUI_ListHolder
			--IIFA_GUI_Search
			--IIFA_GUI_ListHolder_Slider

			PP.ScrollBar(IIFA_GUI_ListHolder, --[[sb_c]] 180, 180, 180, .7, --[[bd_c]] 20, 20, 20, .7, false, "_Slider", 30)
			ZO_Scroll_SetMaxFadeDistance(IIFA_GUI_ListHolder, 10)

			PP.fixDrawZ(IIFA_GUI_Header)
			PP.fixDrawZ(IIFA_GUI_SearchBackdrop, DT_LOW, DL_TEXT, 1)
		end
		--===============================================================================================--

		--==WizardsWardrobe==-- by Troodon80 (2022-06-19 5:27pm, PerfectPixel comments at www.esoui.com -> Post #161481)
		if WizardsWardrobe ~= nil then
			PP:CreateBackground(WizardsWardrobeWindow,			--[[#1]] nil, nil, nil, -6, 0, --[[#2]] nil, nil, nil, 0, 6)
			PP:CreateBackground(WizardsWardrobeCodeDialog,		--[[#1]] nil, nil, nil, -6, 0, --[[#2]] nil, nil, nil, 0, 6)
			PP:CreateBackground(WizardsWardrobeTransferDialog,	--[[#1]] nil, nil, nil, -6, 0, --[[#2]] nil, nil, nil, 0, 6)
			PP:CreateBackground(WizardsWardrobeArrangeDialog,	--[[#1]] nil, nil, nil, -6, 0, --[[#2]] nil, nil, nil, 0, 6)
			PP:CreateBackground(WizardsWardrobePrebuff,			--[[#1]] nil, nil, nil, -6, 0, --[[#2]] nil, nil, nil, 0, 6)
			PP:CreateBackground(WizardsWardrobePreviewPreview,	--[[#1]] nil, nil, nil, -6, 0, --[[#2]] nil, nil, nil, 0, 6)

			PP.ScrollBar(WizardsWardrobeArrangeDialogListScrollBar,	--[[sb_c]] 180, 180, 180, .7, --[[bd_c]] 20, 20, 20, .7, false)
			ZO_Scroll_SetMaxFadeDistance(WizardsWardrobeArrangeDialogList, 10)
			PP.ScrollBar(WizardsWardrobeWindowSetupListScrollBar,	--[[sb_c]] 180, 180, 180, .7, --[[bd_c]] 20, 20, 20, .7, false)
			ZO_Scroll_SetMaxFadeDistance(WizardsWardrobeWindowSetupList, 10)

			WizardsWardrobeCodeDialogBG:SetHidden(true)
			WizardsWardrobeWindowBG:SetHidden(true)
			WizardsWardrobePrebuffBG:SetHidden(true)
			WizardsWardrobeTransferDialogBG:SetHidden(true)
			WizardsWardrobeArrangeDialogBG:SetHidden(true)
			WizardsWardrobePreviewPreviewBG:SetHidden(true)

			-- Blotchy grunge texture; I've set to hidden here because it doesn't mesh well with the clean look I have for Perfect Pixel - feel free to remove these three lines if you want to keep it:
			WizardsWardrobeTransferBGMungeOverlay:SetHidden(true)
			WizardsWardrobeArrangeBGMungeOverlay:SetHidden(true)
			WizardsWardrobeCodeBGMungeOverlay:SetHidden(true)

			-- Fix for objects appearing under the background layer
			WizardsWardrobeWindowSelection:SetDrawTier(DT_MEDIUM)
			WizardsWardrobeWindowSelection:SetDrawLayer(DL_CONTROLS)
			WizardsWardrobeWindowTitleIcon:SetDrawTier(DT_MEDIUM)
			WizardsWardrobeWindowTitleIcon:SetDrawLayer(DL_CONTROLS)
			WizardsWardrobeWindowTopDivider:SetDrawTier(DT_MEDIUM)
			WizardsWardrobeWindowTopDivider:SetDrawLayer(DL_CONTROLS)
			WizardsWardrobeWindowBottomDivider:SetDrawTier(DT_MEDIUM)
			WizardsWardrobeWindowBottomDivider:SetDrawLayer(DL_CONTROLS)

			WizardsWardrobePrebuff:SetDrawTier(DT_MEDIUM)
			WizardsWardrobePrebuff:SetDrawLayer(DL_CONTROLS)
			WizardsWardrobePrebuffBox1:SetDrawTier(DT_MEDIUM)
			WizardsWardrobePrebuffBox1:SetDrawLayer(DL_CONTROLS)
			WizardsWardrobePrebuffBox2:SetDrawTier(DT_MEDIUM)
			WizardsWardrobePrebuffBox2:SetDrawLayer(DL_CONTROLS)
			WizardsWardrobePrebuffBox3:SetDrawTier(DT_MEDIUM)
			WizardsWardrobePrebuffBox3:SetDrawLayer(DL_CONTROLS)
			WizardsWardrobePrebuffBox4:SetDrawTier(DT_MEDIUM)
			WizardsWardrobePrebuffBox4:SetDrawLayer(DL_CONTROLS)
			WizardsWardrobePrebuffBox5:SetDrawTier(DT_MEDIUM)
			WizardsWardrobePrebuffBox5:SetDrawLayer(DL_CONTROLS)

			WizardsWardrobePreview:SetDrawTier(DT_MEDIUM)
			WizardsWardrobePreview:SetDrawLayer(DL_CONTROLS)
			WizardsWardrobePreviewGear:SetDrawTier(DT_MEDIUM)
			WizardsWardrobePreviewGear:SetDrawLayer(DL_CONTROLS)
			WizardsWardrobePreviewSkills:SetDrawTier(DT_MEDIUM)
			WizardsWardrobePreviewSkills:SetDrawLayer(DL_CONTROLS)
			WizardsWardrobePreviewFood:SetDrawTier(DT_MEDIUM)
			WizardsWardrobePreviewFood:SetDrawLayer(DL_CONTROLS)
			WizardsWardrobePreviewCP:SetDrawTier(DT_MEDIUM)
			WizardsWardrobePreviewCP:SetDrawLayer(DL_CONTROLS)
			WizardsWardrobePreviewIcon:SetDrawTier(DT_MEDIUM)
			WizardsWardrobePreviewIcon:SetDrawLayer(DL_CONTROLS)
		end
		--===============================================================================================--


		--==ArkadiusTradeTools==--
		-->See file /scenes/tradingHouseScene, function UpdateSetupCallback() for the "Sell" panel at guild trader (Trading House sell)
		--===============================================================================================--

		--UnregisterForEvent--
		EVENT_MANAGER:UnregisterForEvent(PP.ADDON_NAME .. "Compatibility", EVENT_PLAYER_ACTIVATED)
	end
	
	EVENT_MANAGER:RegisterForEvent(PP.ADDON_NAME .. "Compatibility", EVENT_PLAYER_ACTIVATED, Compatibility)

end