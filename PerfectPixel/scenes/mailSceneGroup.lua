local PP = PP ---@class PP

PP.mailSceneGroup = function()

	local SV = PP.savedVars.ListStyle

--MAIL_INBOX--MAIL_INBOX_SCENE----------------------------------------------------------------------
	local navigationTree		= MAIL_INBOX.navigationTree --ZO_Tree
	local navigationContainer	= navigationTree.scrollControl

	MAIL_INBOX_SCENE:RemoveFragment(FRAME_PLAYER_FRAGMENT)
	MAIL_INBOX_SCENE:RemoveFragment(RIGHT_BG_FRAGMENT)
	MAIL_INBOX_SCENE:RemoveFragment(TITLE_FRAGMENT)
	MAIL_INBOX_SCENE:RemoveFragment(MAIL_TITLE_FRAGMENT)

	PP:CreateBackground(ZO_MailInbox, --[[#1]] nil, nil, nil, -10, -10, --[[#2]] nil, nil, nil, 0, 10)

	PP.Anchor(ZO_MailInbox,		--[[#1]] TOPRIGHT,	GuiRoot,		TOPRIGHT,	0, 120,	--[[#2]] true, BOTTOMRIGHT,		GuiRoot,		BOTTOMRIGHT,	0, -70)

	PP.Anchor(ZO_MailInboxDeleteOnClaim, --[[#1]] BOTTOMLEFT,	ZO_MailInboxInventoryUsage,	TOPLEFT,	0, -4	--[[#2]])
	PP.Anchor(ZO_MailInboxInventoryUsage, --[[#1]] BOTTOMLEFT,	ZO_MailInbox,	BOTTOMLEFT,	0, 4	--[[#2]])
	PP.Anchor(navigationContainer,	--[[#1]] TOPLEFT,	ZO_MailInbox,	TOPLEFT,	0, 90,	--[[#2]] true, BOTTOMLEFT,		ZO_MailInboxDeleteOnClaim,	TOPLEFT,	0, 0)
	PP.ScrollBar(navigationContainer,	--[[sb_c]] 180, 180, 180, 0.7, --[[bd_c]] 20, 20, 20, 0.7, false)
	ZO_Scroll_SetMaxFadeDistance(navigationContainer, SV.list_fade_distance)

------------------------------------------------------------------------------------------
    --local function HighlightControl(control, animateInstantly)
--		control.backdrop:SetEdgeColor(SV.list_skin_edge_sel_col[1], SV.list_skin_edge_sel_col[2], SV.list_skin_edge_sel_col[3], SV.list_skin_edge_sel_col[4])
--    end

    --local function UnhighlightControl(control, animateInstantly)
--		control.backdrop:SetEdgeColor(SV.list_skin_edge_col[1], SV.list_skin_edge_col[2], SV.list_skin_edge_col[3], SV.list_skin_edge_col[4])
--    end

	-- self, self.control, self.data, self.open, userRequested, self.tree:IsEnabled()

	-- local mailEntry = tree["templateInfo"]["ZO_MailInboxRow"]
	-- local existingSetupCallback = mailEntry.setupFunction
	-- mailEntry.setupFunction = function(node, control, mailData, open)
		-- existingSetupCallback(node, control, data, open)

		-- control.HighlightControl		= HighlightControl
		-- control.UnhighlightControl		= UnhighlightControl
	-- end


    -- navigationTree:AddTemplate("ZO_MailInboxHeader", TreeHeaderSetup, NO_SELECTED_CALLBACK, CategoryEqualityFunction, TREE_CHILD_INDENT, CHILD_SPACING)
    -- navigationTree:AddTemplate("ZO_MailInboxRow", MailEntrySetup, MailEntryOnSelected, MailEqualityFunction)
    -- navigationTree:AddTemplate("ZO_MailInboxEmptyRow", MailEmptyEntrySetup, NO_SELECTED_CALLBACK)

    -- self.templateInfo[template] =
    -- {
        -- template = template,
        -- childIndent = childIndent,
        -- childSpacing = childSpacing,
        -- setupFunction = setupFunction,
        -- selectionFunction = selectionFunction,
        -- equalityFunction = equalityFunction or DefaultEqualityFunction,
        -- objectPool = ZO_ControlPool:New(template, self.control)
    -- }



	-- local function RefreshControlMode_1(control, typeId)
		-- control:SetHeight(SV.list_control_height)
		-- control:GetNamedChild("BG"):SetTexture("PerfectPixel/tex/tex_clear.dds")

		-- if typeId == 1 then
			-- local backdrop = PP.CreateBackdrop(control)
			-- backdrop:SetCenterColor(SV.list_skin_backdrop_col[1], SV.list_skin_backdrop_col[2], SV.list_skin_backdrop_col[3], SV.list_skin_backdrop_col[4])
			-- backdrop:SetCenterTexture(SV.list_skin_backdrop, SV.list_skin_backdrop_tile_size, SV.list_skin_backdrop_tile and 1 or 0)
			-- backdrop:SetEdgeColor(SV.list_skin_edge_col[1], SV.list_skin_edge_col[2], SV.list_skin_edge_col[3], SV.list_skin_edge_col[4])
			-- backdrop:SetEdgeTexture(SV.list_skin_edge, SV.list_skin_edge_file_width, SV.list_skin_edge_file_height, SV.list_skin_edge_thickness, 0)
			-- backdrop:SetInsets(SV.list_skin_backdrop_insets, SV.list_skin_backdrop_insets, -SV.list_skin_backdrop_insets, -SV.list_skin_backdrop_insets)
			-- backdrop:SetIntegralWrapping(SV.list_skin_edge_integral_wrapping)

			-- local icon = control:GetNamedChild("Icon")
			-- PP.Anchor(icon, --[[#1]] LEFT, control, LEFT, 5, 0)
			-- icon:SetDimensions(26, 26)
			-- icon:SetDrawLayer(1)

			-- local subject = control:GetNamedChild("Subject")
			-- PP.Font(subject, --[[Font]] PP.f.u57, 16, "outline", --[[Alpha]] nil, --[[Color]] nil, nil, nil, nil, --[[StyleColor]] 0, 0, 0, .5)
			-- PP.Anchor(subject, --[[#1]] LEFT, control:GetNamedChild("Icon"), RIGHT, 5, 0)
		-- end
	-- end

	-- local function RefreshControlMode_1_Dynamic(control, data, typeId)
		-- if data.sortIndex == mailList.selectedDataIndex then
			-- control.backdrop:SetEdgeColor(SV.list_skin_edge_sel_col[1], SV.list_skin_edge_sel_col[2], SV.list_skin_edge_sel_col[3], SV.list_skin_edge_sel_col[4])
		-- else
			-- control.backdrop:SetEdgeColor(SV.list_skin_edge_col[1], SV.list_skin_edge_col[2], SV.list_skin_edge_col[3], SV.list_skin_edge_col[4])
		-- end
	-- end

	-- ZO_Scroll_SetMaxFadeDistance(mailList, SV.list_fade_distance)

	-- mailList.refreshControlMode_1			= RefreshControlMode_1
	-- mailList.refreshControlMode_1_dynamic	= RefreshControlMode_1_Dynamic
	-- mailList.uniformControlHeight			= SV.list_uniform_control_height
	-- mailList.highlightTemplate				= nil
	-- mailList.selectionTemplate				= nil

	-- for typeId in pairs(mailList.dataTypes) do
		-- if typeId == 1 or typeId == 2 then
			-- local dataType = ZO_ScrollList_GetDataTypeTable(mailList, typeId)
			-- local pool = dataType.pool

			-- if dataType.height then
				-- dataType.height = SV.list_control_height
			-- end

			-- PP.Hook_m_Factory(dataType, function(control)
				-- mailList.refreshControlMode_1(control, typeId)
			-- end)

			-- if typeId == 1 then
				-- PP.Hook_SetupCallback(dataType, function(control, data)
					-- mailList.refreshControlMode_1_dynamic(control, data, typeId)
				-- end)
			-- end
		-- end
	-- end

	-- ZO_PreHook(MAIL_INBOX, "EnterRow", function(self, control)
		-- control.backdrop:SetCenterColor(SV.list_skin_backdrop_hl_col[1], SV.list_skin_backdrop_hl_col[2], SV.list_skin_backdrop_hl_col[3], SV.list_skin_backdrop_hl_col[4])
	-- end)
	-- ZO_PreHook(MAIL_INBOX, "ExitRow", function(self, control)
		-- control.backdrop:SetCenterColor(SV.list_skin_backdrop_col[1], SV.list_skin_backdrop_col[2], SV.list_skin_backdrop_col[3], SV.list_skin_backdrop_col[4])
	-- end)

--mailSend--MAIL_SEND_SCENE------------------------------------------------------------------------
	MAIL_SEND_SCENE:RemoveFragment(FRAME_PLAYER_FRAGMENT)
	MAIL_SEND_SCENE:RemoveFragment(RIGHT_BG_FRAGMENT)
	MAIL_SEND_SCENE:RemoveFragment(TITLE_FRAGMENT)
	MAIL_SEND_SCENE:RemoveFragment(MAIL_TITLE_FRAGMENT)

	PP:CreateBackground(ZO_MailSend, --[[#1]] nil, nil, nil, -10, -10, --[[#2]] nil, nil, nil, 0, 6)
	PP:HideBackgroundForScene(MAIL_SEND_SCENE, ZO_PlayerInventory.PP_BG)

	PP.Anchor(ZO_MailSend, --[[#1]] TOPRIGHT,	GuiRoot, TOPRIGHT, 0, 120, --[[#2]] true, BOTTOMRIGHT, GuiRoot, BOTTOMRIGHT, 0, -90)
end
