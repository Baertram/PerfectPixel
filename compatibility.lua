PP.compatibility = function()
	local PP = PP

	local function Compatibility()
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

				EVENT_MANAGER:UnregisterForEvent(PP.ADDON_NAME .. 'AwesomeGuildStore' .. 'tradingHouseScene', EVENT_OPEN_TRADING_HOUSE, func)
			end
			EVENT_MANAGER:RegisterForEvent(PP.ADDON_NAME .. 'AwesomeGuildStore' .. 'tradingHouseScene', EVENT_OPEN_TRADING_HOUSE, func)
		end
		--===============================================================================================--

		--==MasterMerchant==--
		if MasterMerchant then
			PP.Anchor(ZO_TradingHouseBrowseItemsLeftPane, --[[#1]] nil, nil, nil, nil, nil, --[[#2]] true, nil, nil, nil, nil, -50)
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

		--UnregisterForEvent--
		EVENT_MANAGER:UnregisterForEvent(PP.ADDON_NAME .. "Compatibility", EVENT_PLAYER_ACTIVATED)
	end
	
	EVENT_MANAGER:RegisterForEvent(PP.ADDON_NAME .. "Compatibility", EVENT_PLAYER_ACTIVATED, Compatibility)

end