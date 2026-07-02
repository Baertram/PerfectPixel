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
	ADDON_VERSION 	= '0.13.34',
}

local PP = PP ---@class PP

function PP.loadAtEndOfOnAddOnLoaded()
	--Check if TLC width changes should be applied
	--PP.GetAllTopLevelResizeWidth() -- Debug function to get the TLC's default width values
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