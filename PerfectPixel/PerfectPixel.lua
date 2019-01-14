if not PP then PP = {} end
PP.VAR = {}
PP.ADDON_NAME		= "PerfectPixel"
-- PP.ADDON_VERSION	= ""
PP.ADDON_AUTHOR		= "@KL1SK"
PP.ADDON_WEBSITE	= "https://www.esoui.com/downloads/info2103-PerfectPixel.html"

-- ZO_CreateStringId("SI_BINDING_NAME_PP_QUICKSLOT_1", "")

local function Settings()
	PP.optionsData = {}
	local panelData = {
		type					= "panel",
		name					= PP.ADDON_NAME,
		-- version					= PP.ADDON_VERSION,
		author					= PP.ADDON_AUTHOR .. ", with support from the ESOUI community.",
		website					= PP.ADDON_WEBSITE,
		slashCommand			= "/pp",
		registerForRefresh		= true,
		registerForDefaults		= true,
	}
	LibStub("LibAddonMenu-2.0"):RegisterAddonPanel("PerfectPixelOptions", panelData)
end

local function Core()
--===============================================================================================--
	local SV_VER				= 0.1
	local DEF = {
		DoNotInterrupt_toggle	= true,
	}
	local SV = ZO_SavedVars:NewAccountWide(PP.ADDON_NAME, SV_VER, "Others", DEF, GetWorldName())
	---------------------------------------------
	table.insert(PP.optionsData,
	{	type				= "header",
		name				= GetString(PP_LAM_OTHERS),
	})
	table.insert(PP.optionsData,
	{	type				= "checkbox",
		name				= GetString(PP_LAM_DONOTINTERRUPT),
		getFunc				= function() return SV.DoNotInterrupt_toggle end,
		setFunc				= function(value) SV.DoNotInterrupt_toggle = value end,
		default				= DEF.DoNotInterrupt_toggle,
		requiresReload		= true,
	})
--===============================================================================================--
	for _, v in ipairs( PP.TabList ) do
		for i=1, 2 do
			if ZO_ScrollList_GetDataTypeTable(v, i) then
				local dataType = ZO_ScrollList_GetDataTypeTable(v, i)
				local originalSetupCallback = dataType.setupCallback
				dataType.setupCallback = function(rowControl, result)
					originalSetupCallback(rowControl, result)
				--"SellPrice"--------------------
					if rowControl:GetNamedChild("SellPrice") then
						local sp = rowControl:GetNamedChild("SellPrice")
						PP.Font(sp, --[[Font]] PP.f.u67, 15, "outline", --[[Alpha]] nil, --[[Color]] nil, nil, nil, nil, --[[StyleColor]] 0, 0, 0, .5)
					end
				--"ButtonStackCount"-------------
					if rowControl:GetNamedChild("ButtonStackCount") then
						local stack = rowControl:GetNamedChild("ButtonStackCount")
						PP.Font(stack, --[[Font]] PP.f.u67, 15, "outline", --[[Alpha]] nil, --[[Color]] nil, nil, nil, nil, --[[StyleColor]] 0, 0, 0, .5)
						--InventoryGridView compatibility
						if InventoryGridView then
							if	((v == ZO_PlayerInventoryList)	and InventoryGridView.settings.vars.isGrid[1]) or
								((v == ZO_PlayerBankBackpack)	and InventoryGridView.settings.vars.isGrid[2]) or
								((v == ZO_GuildBankBackpack)	and InventoryGridView.settings.vars.isGrid[3]) or
								((v == ZO_CraftBagList)			and InventoryGridView.settings.vars.isGrid[4]) or
								((v == ZO_QuickSlotList)		and InventoryGridView.settings.vars.isGrid[5]) or
								((v == ZO_StoreWindowList)		and InventoryGridView.settings.vars.isGrid[6]) or
								((v == ZO_BuyBackList)			and InventoryGridView.settings.vars.isGrid[7])
							then
								PP.Anchor(stack, --[[#1]] BOTTOMRIGHT, rowControl:GetNamedChild("ButtonIcon"), BOTTOMRIGHT, -3, 3)
							else
								PP.Anchor(stack, --[[#1]] LEFT, rowControl:GetNamedChild("ButtonIcon"), LEFT, 34, 8)
							end
						else
							PP.Anchor(stack, --[[#1]] LEFT, rowControl:GetNamedChild("ButtonIcon"), LEFT, 34, 8)
						end
					end
				---------------------------------
				end
			end
		end
	end
	---------------------------------------------
	for _, v in ipairs(PP.TabList) do
		v.uniformControlHeight = 42
		v.useFadeGradient = nil
	end

	for _, v in ipairs( PP.TabList ) do
		for i=1, 2 do
			if v.dataTypes[i] then
				local v = v.dataTypes[i]
				v.height = 40
				v.pool:SetCustomAcquireBehavior( function(control)
					control:SetHeight(40)
					if control:GetNamedChild("Button") then
						local button = control:GetNamedChild("Button")
						button:SetDimensions(36, 36)
						PP.Anchor(button, --[[#1]] CENTER, control, LEFT, 60, 0)
					end
					if control:GetNamedChild("MultiIcon") then
						local multiIcon = control:GetNamedChild("MultiIcon")
						multiIcon:SetDimensions(36, 36)
						PP.Anchor(multiIcon, --[[#1]] CENTER, control, LEFT, 60, 0)
					end
					if control:GetNamedChild("Status") then
						local status = control:GetNamedChild("Status")
						status:SetDimensions(26, 26)
						PP.Anchor(status, --[[#1]] CENTER, control, LEFT, 18, 0)
					end
					if control:GetNamedChild("Name") then
						local name = control:GetNamedChild("Name")
						PP.Font(name, --[[Font]] PP.f.u67, 15, "outline", --[[Alpha]] nil, --[[Color]] nil, nil, nil, nil, --[[StyleColor]] 0, 0, 0, .5)
						PP.Anchor(name, --[[#1]] LEFT, control, LEFT, 110, -1)
						name:SetLineSpacing(0)
						name:SetVerticalAlignment(0)
					end
					-- if control:GetNamedChild("ButtonStackCount") then
						-- local stack = control:GetNamedChild("ButtonStackCount")
						-- PP.Font(stack, --[[Font]] PP.f.u67, 15, "outline", --[[Alpha]] nil, --[[Color]] nil, nil, nil, nil, --[[StyleColor]] 0, 0, 0, .5)
						--InventoryGridView compatibility -------------------------------------------------------------------------
						-- if InventoryGridView then
							-- if	((not ZO_PlayerInventoryList:IsHidden())	and InventoryGridView.settings.vars.isGrid[1]) or
								-- ((not ZO_PlayerBankBackpack:IsHidden())		and InventoryGridView.settings.vars.isGrid[2]) or
								-- ((not ZO_GuildBankBackpack:IsHidden())		and InventoryGridView.settings.vars.isGrid[3]) or
								-- ((not ZO_CraftBagList:IsHidden())			and InventoryGridView.settings.vars.isGrid[4]) or
								-- ((not ZO_QuickSlotList:IsHidden())			and InventoryGridView.settings.vars.isGrid[5]) or
								-- ((not ZO_StoreWindowList:IsHidden())		and InventoryGridView.settings.vars.isGrid[6]) or
								-- ((not ZO_BuyBackList:IsHidden())			and InventoryGridView.settings.vars.isGrid[7])
							-- then
								-- PP.Anchor(stack, --[[#1]] BOTTOMRIGHT, control:GetNamedChild("ButtonIcon"), BOTTOMRIGHT, -3, 3)
							-- else
								-- PP.Anchor(stack, --[[#1]] LEFT, control:GetNamedChild("ButtonIcon"), LEFT, 34, 8)
							-- end
						-- else
							-- PP.Anchor(stack, --[[#1]] LEFT, control:GetNamedChild("ButtonIcon"), LEFT, 34, 8)
						-- end
					-- end
					if control:GetNamedChild("Bg") then
						local bg = control:GetNamedChild("Bg")
						bg:SetTexture(PP.t.clear)
					end
					if not control:GetNamedChild("Backdrop") then
						CreateControl(control:GetName() .. "Backdrop", control, CT_BACKDROP)
						local backdrop = control:GetNamedChild("Backdrop")
						PP.Anchor(backdrop, --[[#1]] TOPLEFT, control, TOPLEFT, 0, 0, --[[#2]] true, BOTTOMRIGHT, control, BOTTOMRIGHT, 0, 0)
						backdrop:SetCenterColor(20/255, 20/255, 20/255, .7)
						backdrop:SetCenterTexture(nil, 4, 0)
						backdrop:SetEdgeColor(40/255, 40/255, 40/255, .9)
						backdrop:SetEdgeTexture(nil, 1, 1, 1, 0)
						backdrop:SetInsets(1, 1, -1, -1)
						backdrop:SetDrawLayer(0)
						backdrop:SetDrawLevel(0)
						backdrop:SetDrawTier(0)
						backdrop:SetPixelRoundingEnabled(false)
						backdrop:SetInheritAlpha(false)
						backdrop:SetInheritScale(false)
					end
					if control:GetNamedChild("Highlight") then
						local highlight = control:GetNamedChild("Highlight")
						highlight:SetTexture(PP.t.clear)
					end
				end )
			end
		end
	end


---------------------------------------------------------------------------------------------------
	ZO_KeybindStripControl:SetHeight(31)

-- ZO_Dialogs
	local tabDialogs = {ZO_Dialog1, ZO_ListDialog1, ZO_SkillsMorphDialog, ZO_SkillsConfirmDialog, ZO_SkillsUpgradeDialog, ZO_QuitDialog_Keyboard, ZO_LogoutDialog_Keyboard, ZO_TutorialDialog, ZO_TradingHousePurchaseItemDialog}
	for _, v in ipairs(tabDialogs) do
		local flag				= nil
		local bg				= v:GetNamedChild("BG")
		local bgMungeOverlay	= v:GetNamedChild("BGMungeOverlay")
		local modalUnderlay		= v:GetNamedChild("ModalUnderlay")
		local button1KeyLabel	= v:GetNamedChild("Button1KeyLabel")	or v:GetNamedChild("ConfirmKeyLabel")	or v:GetNamedChild("AcceptKeyLabel")
		local button1NameLabel	= v:GetNamedChild("Button1NameLabel")	or v:GetNamedChild("ConfirmNameLabel")	or v:GetNamedChild("AcceptNameLabel")
		local button2KeyLabel	= v:GetNamedChild("Button2KeyLabel")	or v:GetNamedChild("CancelKeyLabel")
		local button2NameLabel	= v:GetNamedChild("Button2NameLabel")	or v:GetNamedChild("CancelNameLabel")

		local flag = nil
		ZO_PreHookHandler(v, "OnShow",	function()
			if flag then return end
			v.animation:GetFirstAnimation():SetStartAlpha((v.animation:GetFirstAnimation():GetEndAlpha()))
			v.animation:GetLastAnimation():SetStartScale((v.animation:GetLastAnimation():GetEndScale()))
			v.animation:GetAnimation():SetDuration(1)
			v.animation:GetFirstAnimation():SetDuration(1)
			v.animation:GetLastAnimation():SetDuration(1)
			bg:SetDrawTier(1)
			flag = true
			-- d(v:GetName())
		end)

		bg:SetCenterTexture(PP.t.bg1, 4, 1)
		bg:SetCenterColor(10/255, 10/255, 10/255, .9)
		bg:SetEdgeTexture(nil, 1, 1, 1, 0)
		bg:SetEdgeColor(60/255, 60/255, 60/255, 1)
		bg:SetInsets(-1, -1, 1, 1)
		bg:SetDrawTier(0)

		bgMungeOverlay:SetHidden(true)

		modalUnderlay:SetAlpha(0.4)
		modalUnderlay:SetDrawTier(0)

		if button1KeyLabel then
			button1KeyLabel:SetFont("PerfectPixel/fonts/univers57.otf|16")
			button1NameLabel:SetFont("PerfectPixel/fonts/univers67.otf|18|outline")
		end
		if button2KeyLabel then
			button2KeyLabel:SetFont("PerfectPixel/fonts/univers57.otf|16")
			button2NameLabel:SetFont("PerfectPixel/fonts/univers67.otf|18|outline")
		end
	end
	
--ZO_ListDialog1
	ZO_ListDialog1ListBgLeft:SetHidden(true)
	ZO_ListDialog1ListBgRight:SetHidden(true)
	PP.ListBackdrop(ZO_ListDialog1List, -3, -3, -1, 3, --[[tex]] nil, 8, 0, --[[bd]] 5, 5, 5, .6, --[[edge]] 30, 30, 30, .6)
	ZO_ListDialog1ListBackdrop:SetDrawTier(1)
	PP.ScrollBar(ZO_ListDialog1List, --[[sb_c]] 180, 180, 180, .7, --[[bd_c]] 20, 20, 20, .7, --[[edge]] 40, 40, 40, .9)
	ZO_ListDialog1ListScrollBar_BG:SetDrawTier(1)

--ZO_TutorialDialog

--crownCrateKeyboard-------------------------------------------------------------------------------
	SCENE_MANAGER:GetScene('crownCrateKeyboard'):AddFragment(PLAYER_PROGRESS_BAR_FRAGMENT)

	-- treasureMapQuickSlot
	-- treasureMapInventory
--animations---------------------------------------------------------------------------------------
	DEFAULT_SCENE_TRANSITION_TIME = 1
	ZO_CONVEYOR_TRANSITION_TIME = 1
	DEFAULT_HUD_DURATION = 1

	PLAYER_PROGRESS_BAR.fadeTimeline:GetAnimation():SetDuration(1)
	PLAYER_PROGRESS_BAR.fadeTimeline:GetFirstAnimation():SetDuration(1)
	PLAYER_PROGRESS_BAR.fadeTimeline:GetLastAnimation():SetDuration(1)

	for _, v in pairs(PP.FadeSceneFragment) do
		v.duration = 1
	end
	--
	for _, fragment in pairs(HUD_SCENE.fragments) do
		if fragment.showDuration then
			fragment.showDuration = 1
		end
	end
	--
	for _, scene in pairs(SCENE_MANAGER.scenes) do
		for _, fragment in pairs(scene.fragments) do
			if fragment.duration then
				fragment.duration = 1
			end
		end
	end

---------------------------------------------------------------------------------------------------
	ZO_PreHook("SetFullscreenEffect", function() return true end)
	--
	if SV.DoNotInterrupt_toggle then
		ZO_PreHook(END_IN_WORLD_INTERACTIONS_FRAGMENT, "Show", function(self)
			self:OnShown()
			return true
		end)
	end
---------------------------------------------------------------------------------------------------
	ZO_PreHook("ZO_VerticalScrollbarBase_OnMouseEnter", function(self)
		self:SetAlpha(.9)
		return true
	end)
	ZO_PreHook("ZO_VerticalScrollbarBase_OnMouseExit", function(self)
		self:SetAlpha(.7)
		return true
	end)
	ZO_PreHook("ZO_VerticalScrollbarBase_OnMouseDown", function(self)
		return true
	end)
	ZO_PreHook("ZO_VerticalScrollbarBase_OnMouseUp", function(self)
		return true
	end)
	ZO_PreHook("ZO_VerticalScrollbarBase_OnScrollAreaEnter", function(self)
		return true
	end)
	ZO_PreHook("ZO_VerticalScrollbarBase_OnScrollAreaExit", function(self)
		return true
	end)
	ZO_PreHook("ZO_VerticalScrollbarBase_OnEffectivelyHidden", function(self)
		self:SetAlpha(.7)
		return true
	end)
end

--ZO_KeybindStrip
KEYBIND_STRIP_STANDARD_STYLE = {
	nameFont = "PerfectPixel/fonts/univers67.otf|18|outline",
	nameFontColor = ZO_NORMAL_TEXT,
	keyFont = "PerfectPixel/fonts/univers57.otf|16",
	modifyTextType = MODIFY_TEXT_TYPE_NONE,
	alwaysPreferGamepadMode = false,
	resizeToFitPadding = 20,
	leftAnchorOffset = 10,
	centerAnchorOffset = 0,
	rightAnchorOffset = -10,
	drawTier = DT_MEDIUM,
	drawLevel = 1,
	backgroundDrawTier = DT_MEDIUM,
	backgroundDrawLevel = 0,
}
--RedirectTextures---------------------------------------------------------------------------------
RedirectTexture("EsoUI/Art/Miscellaneous/interactKeyFrame_edge.dds", "PerfectPixel/textures/RedirectTextures/EsoUI/Art/Miscellaneous/interactKeyFrame_edge.dds")
RedirectTexture("EsoUI/Art/Miscellaneous/interactkeyframe_center.dds", "PerfectPixel/textures/RedirectTextures/EsoUI/Art/Miscellaneous/interactkeyframe_center.dds")

---------------------------------------------------------------------------------------------------
local function OnAddonLoaded(eventType, addonName)
	if addonName == PP.ADDON_NAME then
		--hooks
		Settings()
		Core()
		--
		PP.tooltips()
		PP.compass()
		PP.reticle()
		PP.tabs()
		--
		PP.inventoryScene()
		PP.bankScene()
		PP.houseBankScene()
		PP.guildBankScene()
		PP.tradingHouseScene()
		PP.storeScene()

		PP.lootScene()

		PP.provisionerScene()
		PP.enchantingScene()
		PP.smithingScene()

		PP.statsScene()
		PP.skillsScene()
		PP.journalSceneGroup()
		PP.collectionsSceneGroup()
		PP.worldMapScene()
		PP.groupMenuKeyboardScene()
		PP.friendsListGroup()
		PP.guildSceneGroup()
		PP.allianceWarSceneGroup()
		PP.mailSceneGroup()
		PP.notificationsScene()
		PP.helpSceneGroup()
		--
		PP.gameMenuInGameScene()
		--
		EVENT_MANAGER:RegisterForEvent(PP.ADDON_NAME, EVENT_PLAYER_ACTIVATED, PP.searchBox)
		EVENT_MANAGER:UnregisterForEvent(PP.ADDON_NAME, EVENT_ADD_ON_LOADED)
		--
		LibStub("LibAddonMenu-2.0"):RegisterOptionControls("PerfectPixelOptions", PP.optionsData)
	end
end
EVENT_MANAGER:RegisterForEvent(PP.ADDON_NAME, EVENT_ADD_ON_LOADED, OnAddonLoaded)