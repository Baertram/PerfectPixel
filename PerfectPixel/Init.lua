---@class PP
PP = {
	media			= { textures = {}, edges = {}, fonts = {}, colors = {}, },
	modules			= {},
	savedVars		= {},
	localization	= {},

	layouts			= {},
	optionsData		= {},

	ADDON_NAME		= 'PerfectPixel',
	ADDON_AUTHOR	= '@KL1SK, Baertram, Dakjaniels',
	ADDON_WEBSITE	= 'https://www.esoui.com/downloads/info2103-PerfectPixel.html',
	ADDON_VERSION 	= '0.13.36',
}

local PP = PP ---@class PP

--====================================================================
-- PP Constants -v-
--====================================================================
PP.Constants = {}
local constants = PP.Constants

local defaultNormalWidthForTLCs = 930
local defaultWiderWidthForTLCs = 1100
local defaultExtraWiderWidthForTLCs = 1275
constants.TLCControlsWidthSupported = {
	--Colection books
	["ZO_CollectionsBook_TopLevel"] 					= { new = defaultWiderWidthForTLCs, default = defaultNormalWidthForTLCs },
	["ZO_DLCBook_Keyboard"] 							= { new = defaultExtraWiderWidthForTLCs, default = defaultNormalWidthForTLCs },
	["ZO_HousingBook_Keyboard"] 						= { new = defaultExtraWiderWidthForTLCs, default = defaultNormalWidthForTLCs },
	["ZO_OutfitStylesBook_Keyboard_TopLevel"] 			= { new = 950, 	default = defaultNormalWidthForTLCs },
	["ZO_OutfitStylesPanelTopLevel_Keyboard"] 			= { new = 675,	default = 595 },
	["ZO_ItemSetsBook_Keyboard_TopLevel"] 				= { new = defaultExtraWiderWidthForTLCs, default = defaultNormalWidthForTLCs },
	["ZO_TributePatronBook_Keyboard_TopLevel"] 			= { new = 1310, default = defaultNormalWidthForTLCs },
	--Outfit stattion (Restyle, Dye)
	--["ZO_RestyleStationTopLevel_Keyboard"] = --
}
constants.TLCControlsHeightSupported = {
	["ZO_PlayerEmote_Keyboard_TopLevelEmoteContainer"] 	= { new = 1100, default = 600 },
}
-- PP Constants -^-


--====================================================================
-- PP Functions
--====================================================================
function PP.loadAtEndOfOnAddOnLoaded()
	--Check if TLC width changes should be applied
	-- Debug functions to get the TLC's default width and height values:
		--PP.GetAllTopLevelResizeWidth()
		--PP.GetAllTopLevelResizeHeight
	PP.AllTopLevelResizeChecks()
end

EVENT_MANAGER:RegisterForEvent(PP.ADDON_NAME, EVENT_ADD_ON_LOADED, function(eventType, addonName)
	if addonName == PP.ADDON_NAME then
		--UnregisterForEvent--
		EVENT_MANAGER:UnregisterForEvent(PP.ADDON_NAME, EVENT_ADD_ON_LOADED)
		--
		PP.Core()
		--
		PP.tooltips()
		PP.contextMenus()
		PP.compass()
		PP.reticle()
		PP.tabs()
		PP.dialogsMenu()
		PP.chatWindow()
		PP.scrolling()
		--PP.playerProgressBar()
        PP.popupList()
		PP.keybindStrip()
		--
		PP.inventoryScene()
		PP.tradingHouseScene()
		PP.lootScene()
		PP.restyleStationKeyboardSceneGroup()
		PP.craftStationScenes()
		PP.statsScene()
        PP.challengeDifficultyScene()
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
		PP.gameMenuInGameScene()
		PP.performanceMeter()
		PP.companionsScene()
		PP.lockpickingScene()
		PP.tamrielTomesScene()
		--
		PP.compatibility()
		--
		if LibAddonMenu2 then
			PP.Settings()
			LibAddonMenu2:RegisterOptionControls("PerfectPixelOptions", PP.optionsData)
		end
		--
		PP.loadAtEndOfOnAddOnLoaded()
	end
end)