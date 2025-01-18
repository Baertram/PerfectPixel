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
			list:SetWidth(dialogControl:GetWidth() - 30)
			PP.Anchor(list, --[[#1]] nil, nil, nil, 2, nil)
			PP.ScrollBar(list)
			if listBgLeft and listBgRight then
				listBgLeft:SetHidden(true)
				listBgRight:SetHidden(true)
			end
		end
		if pane then
			pane:SetWidth(dialogControl:GetWidth() - 30)
			PP.Anchor(pane, --[[#1]] nil, nil, nil, 2, nil)
			PP.ScrollBar(pane)
		end
	end

	for _, dialogControl in ipairs(GetDialogControls()) do
		RestyleDialogControl(dialogControl)
	end
	
	SecurePostHook("ZO_Dialogs_RegisterCustomDialog", function(dialogName, dialogInfo)
		RestyleDialogControl(dialogInfo.customControl)
	end)
end