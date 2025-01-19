---@class PP
PP = {
	media			= { textures = {}, edges = {}, fonts = {}, colors = {}, },
	modules			= {},
	savedVars		= {},
	localization	= {},

	layouts			= {},
	optionsData		= {},

	ADDON_NAME		= 'PerfectPixel',
	ADDON_AUTHOR	= '@KL1SK, Baertram',
	ADDON_WEBSITE	= 'https://www.esoui.com/downloads/info2103-PerfectPixel.html',
	ADDON_VERSION 	= '0.13.16',
}

local PP = PP ---@class PP

EVENT_MANAGER:RegisterForEvent(PP.ADDON_NAME, EVENT_ADD_ON_LOADED, function(eventType, addonName)
	if addonName == PP.ADDON_NAME then
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
		PP.keybindStrip()
		--
		PP.inventoryScene()
		PP.tradingHouseScene()
		PP.lootScene()
		PP.restyleStationKeyboardSceneGroup()
		PP.craftStationScenes()
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
		PP.gameMenuInGameScene()
		PP.performanceMeter()
		PP.companionsScene()

		PP.compatibility()

		if LibAddonMenu2 then
			PP.Settings()
			LibAddonMenu2:RegisterOptionControls("PerfectPixelOptions", PP.optionsData)
		end
	--UnregisterForEvent--
		EVENT_MANAGER:UnregisterForEvent(PP.ADDON_NAME, EVENT_ADD_ON_LOADED)
	end
end)