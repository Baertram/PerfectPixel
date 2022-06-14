PP.dialogsMenu = function()
	local MAX_NUM_DIALOGS	= 1																		--zo_dialog.lua -> local MAX_NUM_DIALOGS = 1, _G['ESO_Dialogs']
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
			local isGamepad = false
			ZO_Dialogs_InitializeDialog(dialog, isGamepad)
			tinsert(dialogControls, dialog)
		end
		return dialogControls
	end

	for _, v in ipairs(GetDialogControls()) do
		local bg				= v:GetNamedChild("BG")
		local bgMungeOverlay	= v:GetNamedChild("BGMungeOverlay")
		local modalUnderlay		= v:GetNamedChild("ModalUnderlay")
		local button1KeyLabel	= v:GetNamedChild("Button1KeyLabel")	or v:GetNamedChild("ConfirmKeyLabel")	or v:GetNamedChild("AcceptKeyLabel")
		local button1NameLabel	= v:GetNamedChild("Button1NameLabel")	or v:GetNamedChild("ConfirmNameLabel")	or v:GetNamedChild("AcceptNameLabel")
		local button2KeyLabel	= v:GetNamedChild("Button2KeyLabel")	or v:GetNamedChild("CancelKeyLabel")	or v:GetNamedChild("ExitKeyLabel")
		local button2NameLabel	= v:GetNamedChild("Button2NameLabel")	or v:GetNamedChild("CancelNameLabel")	or v:GetNamedChild("ExitNameLabel")
		local list				= v:GetNamedChild("List")
		local pane				= v:GetNamedChild("Pane")
		local listBgLeft		= v:GetNamedChild("ListBgLeft")
		local listBgRight		= v:GetNamedChild("ListBgRight")
		local title				= v:GetNamedChild("Title")

		--ANIMATION******************
		-- local anim = CreateSimpleAnimation(ANIMATION_ALPHA, hl)
		-- anim:SetEndAlpha(.8)
		-- anim:SetStartAlpha(0)
		-- anim:SetDuration(200)
		-- check.anim = anim:GetTimeline()

		if not v.animation then																		--zo_dialog.xml -> OnEffectivelyShown
			v.animation = ANIMATION_MANAGER:CreateTimelineFromVirtual("DialogModalUnderlay", v)
		end

		if bg:GetType() == CT_BACKDROP then
			bg:SetCenterTexture(PP.t.bg1, 4, 1)
			bg:SetCenterColor(10/255, 10/255, 10/255, .9)
			bg:SetEdgeTexture(nil, 1, 1, 1, 0)
			bg:SetEdgeColor(60/255, 60/255, 60/255, 1)
			bg:SetInsets(-1, -1, 1, 1)
		end
		if bgMungeOverlay then
			bgMungeOverlay:SetHidden(true)
		end
		if modalUnderlay then
			modalUnderlay:SetAlpha(0.4)
			modalUnderlay:SetDrawTier(DT_LOW)
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
			PP.Font(title,	--[[Font]] PP.f.u67, 22, "outline", --[[Alpha]] .9, --[[Color]] nil, nil, nil, nil, --[[StyleColor]] 0, 0, 0, .5)
		end
		if list then
			list:SetWidth(v:GetWidth() - 30)
			PP.Anchor(list, --[[#1]] nil, nil, nil, 2, nil)
			
			PP.ScrollBar(list, --[[sb_c]] 180, 180, 180, .7, --[[bd_c]] 20, 20, 20, .7, true)

			if listBgLeft and listBgRight then
				listBgLeft:SetHidden(true)
				listBgRight:SetHidden(true)
			end
		end
		if pane then
			pane:SetWidth(v:GetWidth() - 30)
			PP.Anchor(pane, --[[#1]] nil, nil, nil, 2, nil)
			PP.ScrollBar(pane, --[[sb_c]] 180, 180, 180, .7, --[[bd_c]] 20, 20, 20, .7, true)
		end
	end
end