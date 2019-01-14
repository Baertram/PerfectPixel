PP.mailSceneGroup = function()

--mailInbox--MAIL_INBOX_SCENE----------------------------------------------------------------------
	MAIL_INBOX_SCENE:RemoveFragmentGroup(FRAGMENT_GROUP.FRAME_TARGET_STANDARD_RIGHT_PANEL)
	MAIL_INBOX_SCENE:RemoveFragment(TITLE_FRAGMENT)
	MAIL_INBOX_SCENE:RemoveFragment(MAIL_TITLE_FRAGMENT)
	MAIL_INBOX_SCENE:RemoveFragment(RIGHT_BG_FRAGMENT)
	MAIL_INBOX_SCENE:RemoveFragment(FRAME_EMOTE_FRAGMENT_SOCIAL)
	MAIL_INBOX_SCENE:RemoveFragment(KEYBIND_STRIP_MUNGE_BACKDROP_FRAGMENT)

	MAIL_INBOX_SCENE:RegisterCallback("StateChange", function(oldState, newState)
		if newState == SCENE_SHOWING then
			PP.Anchor(ZO_MainMenuSceneGroupBar, --[[#1]] TOPRIGHT, GuiRoot, TOPRIGHT, -30, 64, --[[#2]] false, point_2, nil, relativePoint_2, x_2, y_2)
			ZO_MailInboxList:SetAnchor(BOTTOMLEFT, ZO_MailInbox, BOTTOMLEFT, 0, 0)
			ZO_ScrollList_Commit(ZO_MailInboxList)
		elseif newState == SCENE_HIDDEN then
			PP.Anchor(ZO_MainMenuSceneGroupBar, --[[#1]] RIGHT, GuiRoot, RIGHT, -40, -340, --[[#2]] false, point_2, nil, relativePoint_2, x_2, y_2)
		end
	end)

	PP.mainBackdrop(ZO_MailInbox,			'mailInbox', --[[backdrop]] TOPLEFT, BOTTOMRIGHT, -10, -10, 0, 10, --[[tex]] PP.t.bg1, 8, 1, --[[bd]] 10, 10, 10, .8, --[[edge]] 0, 0, 0, 1, --[[texture]] true, .5)
	PP.mainBackdrop(ZO_KeybindStripControl,	'mailInbox', --[[backdrop]] TOPLEFT, BOTTOMRIGHT, -6, 0, 2, 6, --[[tex]] PP.t.bg1, 8, 1, --[[bd]] 10, 10, 10, .6, --[[edge]] 0, 0, 0, 1, --[[texture]] false, 0)

	PP.Anchor(ZO_MailInbox,		--[[#1]] TOPRIGHT,	GuiRoot,		TOPRIGHT,	0, 120,	--[[#2]] true, BOTTOMRIGHT,		GuiRoot,		BOTTOMRIGHT,	1, -70)
	PP.Anchor(ZO_MailInboxList,	--[[#1]] TOPLEFT,	ZO_MailInbox,	TOPLEFT,	0, 90,	--[[#2]] false, BOTTOMRIGHT,	ZO_MailInbox,	BOTTOMRIGHT,	0, 0)

	PP.ListBackdrop(ZO_MailInboxList, -3, -3, -1, 3, --[[tex]] nil, 8, 0, --[[bd]] 5, 5, 5, .6, --[[edge]] 30, 30, 30, .6)
	PP.ScrollBar(ZO_MailInboxList,	--[[sb_c]] 180, 180, 180, .7, --[[bd_c]] 20, 20, 20, .7, --[[edge]] 40, 40, 40, .9)
---------ZO_MailInboxList
	ZO_MailInboxList.useFadeGradient = false
	ZO_MailInboxList.uniformControlHeight = 40

    local function SceneStateChange(oldState, newState)
        if newState == SCENE_SHOWING then
			for i=1, 2 do
				if ZO_ScrollList_GetDataTypeTable(ZO_MailInboxList, i) then
					ZO_MailInboxList.dataTypes[i].height = 38
					local dataType = ZO_ScrollList_GetDataTypeTable(ZO_MailInboxList, i)
					local originalSetupCallback = dataType.setupCallback
					dataType.setupCallback = function(rowControl, result)
						originalSetupCallback(rowControl, result)
						rowControl:SetHeight(38)
					--"Bg"-------------------------------------------------------------------------
						if rowControl:GetNamedChild("BG") then
							local bg = rowControl:GetNamedChild("BG")
							bg:SetTexture(PP.t.clear)
							if not rowControl:GetNamedChild("Backdrop") and (i == 1) then
								CreateControl( rowControl:GetName() .. "Backdrop", rowControl, CT_BACKDROP)
								local backdrop = rowControl:GetNamedChild("Backdrop")
								PP.Anchor(backdrop, --[[#1]] TOPLEFT, rowControl, TOPLEFT, 0, 0, --[[#2]] true, BOTTOMRIGHT, rowControl, BOTTOMRIGHT, 0, 0)
								backdrop:SetCenterColor(20/255, 20/255, 20/255, .7)
								backdrop:SetCenterTexture(nil, 4, 0)
								backdrop:SetEdgeColor(40/255, 40/255, 40/255, .9)
								backdrop:SetEdgeTexture(nil, 1, 1, 1, 0)
								backdrop:SetInsets(1, 1, -1, -1)
								backdrop:SetPixelRoundingEnabled(false)
								backdrop:SetInheritAlpha(false)
							end
						end
					--ScrollHighlightAnimation
						if rowControl:GetNamedChild("ScrollHighlightAnimation") then
							local selection = rowControl:GetNamedChild("ScrollHighlightAnimation")
								selection:SetTexture(PP.t.clear)
								-- PP.Anchor(selection, --[[#1]] TOPLEFT, rowControl, TOPLEFT, 0, 0, --[[#2]] true, BOTTOMRIGHT, rowControl, BOTTOMRIGHT, 0, 0)
							if not rowControl:GetNamedChild("BackdropHL") and (i == 1) then
								CreateControl( rowControl:GetName() .. "BackdropHL", rowControl:GetNamedChild("ScrollHighlightAnimation"), CT_BACKDROP)
								local backdropHL = rowControl:GetNamedChild("BackdropHL")
								PP.Anchor(backdropHL, --[[#1]] TOPLEFT, rowControl, TOPLEFT, 0, 0, --[[#2]] true, BOTTOMRIGHT, rowControl, BOTTOMRIGHT, 0, 0)
								backdropHL:SetCenterColor( 96/255, 125/255, 139/255, .1 )
								backdropHL:SetEdgeColor( 96/255, 125/255, 139/255, .4 )
								backdropHL:SetEdgeTexture( nil, 1, 1, 1, 0 )
								backdropHL:SetInsets( 1, 1, -1, -1 )
								backdropHL:SetPixelRoundingEnabled(false)
							end
							if rowControl["HighlightAnimation"]:GetAnimation():GetDuration() ~= 1 then
								rowControl["HighlightAnimation"]:GetAnimation():SetDuration(1)
								rowControl["HighlightAnimation"]:GetFirstAnimation():SetDuration(1)
								rowControl["HighlightAnimation"]:GetLastAnimation():SetDuration(1)
							end
						end
					--ScrollSelectionAnimation
						if rowControl:GetNamedChild("ScrollSelectionAnimation") then
							local selection = rowControl:GetNamedChild("ScrollSelectionAnimation")
								selection:SetTexture(PP.t.clear)
								-- PP.Anchor(selection, --[[#1]] TOPLEFT, rowControl, TOPLEFT, 0, 0, --[[#2]] true, BOTTOMRIGHT, rowControl, BOTTOMRIGHT, 0, 0)
							if not rowControl:GetNamedChild("BackdropSHL") and (i == 1) then
								CreateControl( rowControl:GetName() .. "BackdropSHL", rowControl:GetNamedChild("ScrollSelectionAnimation"), CT_BACKDROP)
								local backdropSHL = rowControl:GetNamedChild("BackdropSHL")
								PP.Anchor(backdropSHL, --[[#1]] TOPLEFT, rowControl, TOPLEFT, 0, 0, --[[#2]] true, BOTTOMRIGHT, rowControl, BOTTOMRIGHT, 0, 0)
								backdropSHL:SetCenterColor( 96/255, 125/255, 139/255, .2 )
								backdropSHL:SetEdgeColor( 96/255, 125/255, 139/255, .5 )
								backdropSHL:SetEdgeTexture( nil, 1, 1, 1, 0 )
								backdropSHL:SetInsets( 1, 1, -1, -1 )
								backdropSHL:SetPixelRoundingEnabled(false)
							end
							if rowControl["SelectionAnimation"]:GetAnimation():GetDuration() ~= 1 then
								rowControl["SelectionAnimation"]:GetAnimation():SetDuration(1)
								rowControl["SelectionAnimation"]:GetFirstAnimation():SetDuration(1)
								rowControl["SelectionAnimation"]:GetLastAnimation():SetDuration(1)
							end
						end
					--Icon
						if rowControl:GetNamedChild("Icon") then
							local icon = rowControl:GetNamedChild("Icon")
								icon:SetDimensions(26, 26)
								PP.Anchor(icon, --[[#1]] LEFT, rowControl, LEFT, 5, 0)
								icon:SetDrawLayer(1)
						end
					--Subject
						if rowControl:GetNamedChild("Subject") then
							local subject = rowControl:GetNamedChild("Subject")
								PP.Font(subject, --[[Font]] PP.f.u57, 16, "outline", --[[Alpha]] nil, --[[Color]] nil, nil, nil, nil, --[[StyleColor]] 0, 0, 0, .5)
								PP.Anchor(subject, --[[#1]] LEFT, rowControl:GetNamedChild("Icon"), RIGHT, 5, 0)
						end
					-------------------------------------------------------------------------------
					end
				end
			end
			MAIL_INBOX_SCENE:UnregisterCallback("StateChange",  SceneStateChange)
        end
    end
    MAIL_INBOX_SCENE:RegisterCallback("StateChange",  SceneStateChange)

	ZO_PreHook("ZO_MailInboxRow_OnMouseEnter", function(control)
		if control:GetNamedChild("BackdropHL") then return end
		
		ZO_ScrollList_RefreshVisible(ZO_MailInboxList)
		-- d("update")
	end)

--mailSend--MAIL_SEND_SCENE------------------------------------------------------------------------

	MAIL_SEND_SCENE:RemoveFragmentGroup(FRAGMENT_GROUP.FRAME_TARGET_STANDARD_RIGHT_PANEL)
	MAIL_SEND_SCENE:RemoveFragment(TITLE_FRAGMENT)
	MAIL_SEND_SCENE:RemoveFragment(MAIL_TITLE_FRAGMENT)
	MAIL_SEND_SCENE:RemoveFragment(RIGHT_BG_FRAGMENT)
	MAIL_SEND_SCENE:RemoveFragment(FRAME_EMOTE_FRAGMENT_SOCIAL)
	MAIL_SEND_SCENE:RemoveFragment(KEYBIND_STRIP_MUNGE_BACKDROP_FRAGMENT)

	MAIL_SEND_SCENE:RegisterCallback("StateChange", function(oldState, newState)
		if newState == SCENE_SHOWING then
			PP.Anchor(ZO_SharedRightPanelBackground, --[[#1]] TOPRIGHT,	nil, TOPRIGHT, 0, 62,	--[[#2]] true, BOTTOMLEFT, nil, BOTTOMRIGHT, -564, -32)
			PP.Anchor(ZO_MainMenuSceneGroupBar, --[[#1]] TOPRIGHT, GuiRoot, TOPRIGHT, -30, 64, --[[#2]] false, point_2, nil, relativePoint_2, x_2, y_2)
		elseif newState == SCENE_HIDDEN then
			PP.Anchor(ZO_SharedRightPanelBackground, --[[#1]] RIGHT, nil, RIGHT, 0, 20,			--[[#2]] false, BOTTOMLEFT, nil, BOTTOMRIGHT, 0, 0)
			PP.Anchor(ZO_MainMenuSceneGroupBar, --[[#1]] RIGHT, GuiRoot, RIGHT, -40, -340, --[[#2]] false, point_2, nil, relativePoint_2, x_2, y_2)
		end
	end)

	PP.mainBackdrop(ZO_MailSend,			'mailSend', --[[backdrop]] TOPLEFT, BOTTOMRIGHT, -10, -10, 0, 10, --[[tex]] PP.t.bg1, 8, 1, --[[bd]] 10, 10, 10, .8, --[[edge]] 0, 0, 0, 1, --[[texture]] true, .5)
	PP.mainBackdrop(ZO_KeybindStripControl,	'mailSend', --[[backdrop]] TOPLEFT, BOTTOMRIGHT, -6, 0, 2, 6, --[[tex]] PP.t.bg1, 8, 1, --[[bd]] 10, 10, 10, .6, --[[edge]] 0, 0, 0, 1, --[[texture]] false, 0)

	PP.Anchor(ZO_MailSend,		--[[#1]] TOPRIGHT,	GuiRoot,		TOPRIGHT,	0, 120,	--[[#2]] true, BOTTOMRIGHT,	GuiRoot,		BOTTOMRIGHT,	1, -70)

--MailLooter--mailLooter--compatibility------------------------------------------------------------
	if not MailLooter then return end

	MAIL_LOOTER_SCENE:AddFragment(PLAYER_PROGRESS_BAR_FRAGMENT)
	MAIL_LOOTER_SCENE:RemoveFragment(TITLE_FRAGMENT)
	MAIL_LOOTER_SCENE:RemoveFragment(MAIL_TITLE_FRAGMENT)
	MAIL_LOOTER_SCENE:RemoveFragment(FRAME_PLAYER_FRAGMENT)
	MAIL_LOOTER_SCENE:RemoveFragment(KEYBIND_STRIP_MUNGE_BACKDROP_FRAGMENT)
	MAIL_LOOTER_SCENE:RegisterCallback("StateChange", function(oldState, newState)
		if newState == SCENE_SHOWING then
			PP.Anchor(ZO_SharedRightPanelBackground, --[[#1]] TOPRIGHT, nil, TOPRIGHT, 0, 62,   --[[#2]] true, BOTTOMLEFT, nil, BOTTOMRIGHT, -564, -32)
			PP.Anchor(ZO_MainMenuSceneGroupBar, --[[#1]] TOPRIGHT, GuiRoot, TOPRIGHT, -30, 64)
		elseif newState == SCENE_HIDDEN then
			PP.Anchor(ZO_SharedRightPanelBackground, --[[#1]] RIGHT, nil, RIGHT, 0, 20)
			PP.Anchor(ZO_MainMenuSceneGroupBar, --[[#1]] RIGHT, GuiRoot, RIGHT, -40, -340)
		end
	end)
	PP.mainBackdrop(ZO_KeybindStripControl, 'mailLooter', --[[backdrop]] TOPLEFT, BOTTOMRIGHT, -6, 0, 2, 6, --[[tex]] PP.t.bg1, 8, 1, --[[bd]] 10, 10, 10, .6, --[[edge]] 0, 0, 0, 1, --[[texture]] false, 0)
	PP.Anchor(MailLooterLootList, --[[#1]] TOP, MailLooterLootHeaders, BOTTOM, 0, 0, --[[#2]] true, BOTTOMRIGHT, ZO_MailInbox, BOTTOMRIGHT,	0, -100)
end