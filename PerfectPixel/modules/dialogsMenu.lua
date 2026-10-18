local PP = PP ---@class PP

PP.dialogsMenu = function()
	local MAX_NUM_DIALOGS	= 1					--zo_dialog.lua -> local MAX_NUM_DIALOGS = 1, _G['ESO_Dialogs']
	local tinsert			= table.insert

	local function GetDialogControls()
		local dialogControls = {}
		for name, dialogInfo in pairs(ESO_Dialogs) do
			local dialog
			if not dialogInfo.gamepadInfo and dialogInfo.customControl then
				if type(dialogInfo.customControl) == "function" then
					dialog = dialogInfo.customControl()
				else
					dialog = dialogInfo.customControl
				end
			end
			tinsert(dialogControls, dialog)
		end
		for i = 1, MAX_NUM_DIALOGS do
			local dialog = GetControl("ZO_Dialog" .. i)
			tinsert(dialogControls, dialog)
		end
		return dialogControls
	end

	-- ZO_RumorRewards_Keyboard_RewardRow copies ZO_PopupListItemSlot (Icon, StackCount, Name).
	-- RefreshStyle_InventoryList anchors Name to ButtonIcon, which this row does not have.
	local function StyleRumorRewardsDialog(dialogControl, rewardList)
		local divider = dialogControl:GetNamedChild("Divider")
		if divider then
			divider:SetHidden(true)
		end

		local confirmButton = dialogControl:GetNamedChild("ConfirmButton")
		local closeButton = dialogControl:GetNamedChild("CloseButton")
		if confirmButton and confirmButton.keyLabel then
			PP.Font(confirmButton.keyLabel, --[[Font]] PP.f.u57, 16, "outline")
		end
		if closeButton and closeButton.keyLabel then
			PP.Font(closeButton.keyLabel, --[[Font]] PP.f.u57, 16, "outline")
		end

		if rewardList.PP_RumorRewardsStyled then
			return
		end
		rewardList.PP_RumorRewardsStyled = true

		local listStyleSavedVars = PP.savedVars.ListStyle

		local function OnCreateRumorRewardRow(rewardRowControl)
			local rowBackground = rewardRowControl:GetNamedChild("Bg")
			local rowHighlight = rewardRowControl:GetNamedChild("Highlight")
			if rowBackground then
				rowBackground:SetHidden(true)
			end
			if rowHighlight then
				rowHighlight:SetHidden(true)
			end

			local rewardIcon = rewardRowControl:GetNamedChild("Icon")
			if rewardIcon then
				-- ZO_PromotionalEventClaimChoice_RewardRow sets Icon level="2" so the highlight stays behind it.
				rewardIcon:SetDrawLevel(2)
				local stackCountLabel = rewardIcon:GetNamedChild("StackCount")
				if stackCountLabel then
					PP.Font(stackCountLabel, --[[Font]] PP.f.u67, 15, "shadow")
				end
			end

			local rewardNameLabel = rewardRowControl:GetNamedChild("Name")
			if rewardNameLabel then
				rewardNameLabel:SetDrawLevel(2)
				PP.Font(rewardNameLabel, --[[Font]] PP.f.u67, 16, "shadow")
				rewardNameLabel:SetVerticalAlignment(TEXT_ALIGN_CENTER)
				rewardNameLabel:SetLineSpacing(-2)
				PP:SetLockFn(rewardNameLabel, "SetLineSpacing")
			end

			-- CreateBgToSlot adds Backdrop as the last child, which paints over Icon and Name.
			local rewardRowBackdrop = PP:CreateBgToSlot(rewardRowControl)
			rewardRowBackdrop:SetDrawLayer(DL_BACKGROUND)
			rewardRowBackdrop:SetDrawLevel(0)
			rewardRowBackdrop:SetDrawTier(DT_LOW)
			if rowHighlight then
				rowHighlight:SetDrawLayer(DL_BACKGROUND)
				rowHighlight:SetDrawLevel(0)
			end

			if rewardRowControl.PP_RumorRewardMouseStyled then
				return
			end
			rewardRowControl.PP_RumorRewardMouseStyled = true

			ZO_PostHookHandler(rewardRowControl, "OnMouseEnter", function(self)
				local highlight = self:GetNamedChild("Highlight")
				if highlight then
					highlight:SetHidden(true)
				end
				if self.backdrop then
					self.backdrop:SetCenterColor(unpack(listStyleSavedVars.list_skin_backdrop_hl_col))
				end
			end)
			ZO_PostHookHandler(rewardRowControl, "OnMouseExit", function(self)
				local highlight = self:GetNamedChild("Highlight")
				if highlight then
					highlight:SetHidden(true)
				end
				if self.backdrop then
					self.backdrop:SetCenterColor(unpack(listStyleSavedVars.list_skin_backdrop_col))
				end
			end)
		end

		-- SetupRewardEntry sets the name color. Re-hide Highlight after that setup.
		local function OnUpdateRumorRewardRow(rewardRowControl)
			local rowHighlight = rewardRowControl:GetNamedChild("Highlight")
			if rowHighlight then
				rowHighlight:SetHidden(true)
			end
		end

		-- SCROLL_LIST_UNIFORM is 1. Reward rows are data type 1 (REWARDS_LIST_DATA_TYPE).
		PP.PostHooksSetupCallback(rewardList, 1, 1, OnCreateRumorRewardRow, OnUpdateRumorRewardRow)

		local rewardDataType = ZO_ScrollList_GetDataTypeTable(rewardList, 1)
		if rewardDataType and rewardDataType.pool then
			for _, rewardRowControl in pairs(rewardDataType.pool.m_Free) do
				OnCreateRumorRewardRow(rewardRowControl)
			end
			for _, rewardRowControl in pairs(rewardDataType.pool.m_Active) do
				OnCreateRumorRewardRow(rewardRowControl)
			end
		end
	end

	local function RestyleDialogControl(dialogControl)
		if not dialogControl then return end

		local bg				= dialogControl:GetNamedChild("BG")
		local bgMungeOverlay	= dialogControl:GetNamedChild("BGMungeOverlay")
		local modalUnderlay		= dialogControl:GetNamedChild("ModalUnderlay")
		local button1KeyLabel	= dialogControl:GetNamedChild("Button1KeyLabel")	or dialogControl:GetNamedChild("ConfirmKeyLabel")	or dialogControl:GetNamedChild("AcceptKeyLabel")
		local button1NameLabel	= dialogControl:GetNamedChild("Button1NameLabel")	or dialogControl:GetNamedChild("ConfirmNameLabel")	or dialogControl:GetNamedChild("AcceptNameLabel")
		local button2KeyLabel	= dialogControl:GetNamedChild("Button2KeyLabel")	or dialogControl:GetNamedChild("CancelKeyLabel")	or dialogControl:GetNamedChild("ExitKeyLabel")
		local button2NameLabel	= dialogControl:GetNamedChild("Button2NameLabel")	or dialogControl:GetNamedChild("CancelNameLabel")	or dialogControl:GetNamedChild("ExitNameLabel")
		local list				= dialogControl:GetNamedChild("List")
		local pane				= dialogControl:GetNamedChild("Pane")
		local listBgLeft		= dialogControl:GetNamedChild("ListBgLeft")
		local listBgRight		= dialogControl:GetNamedChild("ListBgRight")
		local title				= dialogControl:GetNamedChild("Title")

		-- Promotional Events Dialog Controls
		local nextCampaignButton	= dialogControl:GetNamedChild("NextCampaignButton")
		local viewInCollectionsButton = dialogControl:GetNamedChild("ViewInCollectionsButton")
		local closeButton			= dialogControl:GetNamedChild("CloseButton")
		local confirmButton			= dialogControl:GetNamedChild("ConfirmButton")
		local overlayGlow			= dialogControl:GetNamedChild("OverlayGlow")

		--ANIMATION******************
		-- local anim = CreateSimpleAnimation(ANIMATION_ALPHA, hl)
		-- anim:SetEndAlpha(.8)
		-- anim:SetStartAlpha(0)
		-- anim:SetDuration(200)
		-- check.anim = anim:GetTimeline()

		-- if not dialogControl.animation then																		--zo_dialog.xml -> OnEffectivelyShown
			-- dialogControl.animation = ANIMATION_MANAGER:CreateTimelineFromVirtual("DialogModalUnderlay", dialogControl)
		-- end

		if bg:GetType() == CT_BACKDROP then
			bg:SetCenterTexture("PerfectPixel/tex/tex_white.dds", 8, 0)
			bg:SetCenterColor(10/255, 10/255, 10/255, 0.9)
			bg:SetEdgeTexture("PerfectPixel/tex/edge_outer_shadow_128x16.dds", 128, 16, 16, 0)
			bg:SetEdgeColor(60/255, 60/255, 60/255, 1)
			bg:SetInsets(5, 5, -5, -5)
		end
		if bgMungeOverlay then
			bgMungeOverlay:SetHidden(true)
		end
		if modalUnderlay then
			modalUnderlay:SetAlpha(0.3)
		end
		if button1KeyLabel then
			button1KeyLabel:SetFont(PP.f.u57 .. "|16")
			button1NameLabel:SetFont(PP.f.u67 .. "|18|outline")
		end
		if button2KeyLabel then
			button2KeyLabel:SetFont(PP.f.u57 .. "|16")
			button2NameLabel:SetFont(PP.f.u67 .. "|18|outline")
		end
		if title then
			PP.Font(title,	--[[Font]] PP.f.u67, 22, "outline", --[[Alpha]] 0.9, --[[Color]] nil, nil, nil, nil, --[[StyleColor]] 0, 0, 0, 0.5)
		end
		if list then
			-- Inventory slots use Button/ButtonIcon. Promotional claim rows and rumor reward rows do not.
			local dialogName = dialogControl:GetName()
			local skipInventoryListStyle = dialogName:find("PromotionalEvent") or dialogName:find("ClaimChoice") or dialogName:find("RumorRewards")
			if not skipInventoryListStyle then
				PP:RefreshStyle_InventoryList(list)
				list:SetWidth(dialogControl:GetWidth() - 30)
				PP.Anchor(list, --[[#1]] nil, nil, nil, 2, nil)
			end

			PP.ScrollBar(list)
			if listBgLeft and listBgRight then
				listBgLeft:SetHidden(true)
				listBgRight:SetHidden(true)
			end
			if dialogName:find("RumorRewards") then
				StyleRumorRewardsDialog(dialogControl, list)
			end
		end
		if pane then
			pane:SetWidth(dialogControl:GetWidth() - 30)
			PP.Anchor(pane, --[[#1]] nil, nil, nil, 2, nil)
			PP.ScrollBar(pane)
		end

		-- Style Promotional Events Dialog specific controls
		if nextCampaignButton then
			PP.Font(nextCampaignButton:GetNamedChild("NameLabel"), PP.f.u67, 18, "outline")
		end
		if viewInCollectionsButton then
			PP.Font(viewInCollectionsButton:GetNamedChild("NameLabel"), PP.f.u67, 18, "outline")
		end
		if closeButton then
			PP.Font(closeButton:GetNamedChild("NameLabel"), PP.f.u67, 18, "outline")
		end
		if confirmButton then
			PP.Font(confirmButton:GetNamedChild("NameLabel"), PP.f.u67, 18, "outline")
		end
		if overlayGlow then
			overlayGlow:SetHidden(true) -- Hide the promotional glow effect for cleaner look
		end
	end

	for _, dialogControl in ipairs(GetDialogControls()) do
		RestyleDialogControl(dialogControl)
	end

	SecurePostHook("ZO_Dialogs_RegisterCustomDialog", function(dialogName, dialogInfo)
		RestyleDialogControl(dialogInfo.customControl)
	end)
end
