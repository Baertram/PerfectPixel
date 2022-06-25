if not PP then PP = {} end

--Addon data
PP.SV = {}
PP.ADDON_NAME		= "PerfectPixel"
PP.ADDON_AUTHOR		= "@KL1SK, Baertram"
PP.ADDON_WEBSITE	= "https://www.esoui.com/downloads/info2103-PerfectPixel.html"
PP.ADDON_VERSION 	= "0.11.31"

--[[ Known bugs

--2022-06-14
--#3 Dropdowns of AdvancedFilters and other Group finder etc. do not show like PP dropdowns

--#5 Guild bank/guild store selection popup is not in PP style

]]

--[[colors
def2 = ( 197, 194, 158 )
def = ( 173, 166, 132 )
red = ( 222, 36, 33 )
over = ( 232, 232, 184 )
96/255, 125/255, 139/255
]]

PP.t = {			--[[	Textures	]]
	bg1		=	"PerfectPixel/textures/line.dds",
	bg2		=	"PerfectPixel/textures/dots.dds",
	bg3		=	"PerfectPixel/textures/gray50.dds",
	gU		=	"PerfectPixel/textures/GradientUp.dds",
	gD		=	"PerfectPixel/textures/GradientDown.dds",
	gL		=	"PerfectPixel/textures/GradientLeft.dds",
	gR		=	"PerfectPixel/textures/GradientRight.dds",
	clear	=	"PerfectPixel/textures/clear.dds",
	div		=	"PerfectPixel/textures/divider.dds",
	divU	=	"PerfectPixel/textures/dividerUp.dds",
	divD	=	"PerfectPixel/textures/dividerDown.dds",
	def1	=	"esoui/art/tooltips/munge_overlay.dds",
	def2	=	"EsoUI/Art/Miscellaneous/centerscreen_left.dds",

	white	=	"PerfectPixel/textures/white.dds",
	w8x8	=	"PerfectPixel/textures/w8x8.dds",
	edge_8x8_outer_shadow	=	"PerfectPixel/textures/edge_8x8_outer_shadow.dds",
}

PP.f = {			--[[	Fonts		]]
	univers57	=	"EsoUI/Common/Fonts/Univers57.otf|15",
	univers67	=	"EsoUI/Common/Fonts/Univers67.otf|15",
	u57			=	"EsoUI/Common/Fonts/Univers57.otf",
	u67			=	"EsoUI/Common/Fonts/Univers67.otf",
}


--[[	Quickslots		]]
local quickSlotbaseRefNew = QUICKSLOT_KEYBOARD
local quickSlotRef = 		quickSlotbaseRefNew.control
PP.quickslotData = {
	quickSlotControl = 				quickSlotRef,
	quickslotListControl = 			quickSlotbaseRefNew.list,
	quickSlotTabsControl = 			quickSlotbaseRefNew.tabs,
	quickSlotInfoBarControl =		GetControl(quickSlotRef, "InfoBar"),
	quickSlotFilterDividerControl =	GetControl(quickSlotRef, "FilterDivider"),
}


--[[ Controls which DrawTier needs to be adjusted to show them above the new created PP background backdrops ]]
--Many thanks to Troodon80 for collecting these controls, see spreadsheet here: https://docs.google.com/spreadsheets/d/1LRvPoK7wEgrN2GdIxybC5cRNevtTFcOV1bubH0kAdqM/edit#gid=0
PP.zAxisFixes = {
	ZO_LeaderboardsTopDivider,
	ZO_LeaderboardsBottomDivider,
	ZO_LeaderboardsFilter,
	ZO_CampaignBrowserHeaders,
	ZO_PlayerInventorySortBy,
	ZO_StatsPanelTitleSection,
	ZO_KeyboardFriendsListHeaders,
	ZO_PlayerInventoryFilterDivider,
	ZO_PlayerInventorySearchDivider,
	ZO_CharacterEquipmentSlotsMainHand,
	ZO_CharacterEquipmentSlotsOffHand,
	ZO_CharacterEquipmentSlotsPoison,
	ZO_CharacterEquipmentSlotsBackupMain,
	ZO_CharacterEquipmentSlotsBackupOff,
	ZO_CharacterEquipmentSlotsBackupPoison,
	ZO_CharacterPaperDoll,
	ZO_CharacterEquipmentSlotsChest,
	ZO_CharacterEquipmentSlotsBelt,
	ZO_CharacterEquipmentSlotsHead,
	ZO_CharacterEquipmentSlotsShoulder,
	ZO_CharacterEquipmentSlotsGlove,
	ZO_CharacterEquipmentSlotsLeg,
	ZO_CharacterEquipmentSlotsFoot,
	ZO_CharacterEquipmentSlotsNeck,
	ZO_CharacterEquipmentSlotsRing1,
	ZO_CharacterEquipmentSlotsRing2,
	ZO_CharacterHeaderSection,
	ZO_GuildRanksRankIcon,
	ZO_GuildRanksList,
	ZO_StoreWindowSortBy,
	ZO_StoreWindowFilterDivider,
	ZO_GuildRosterHeaders,
	ZO_CharacterAccessoriesSection,
	ZO_CharacterWeaponsSection,
	ZO_QuestJournalRepeatableIcon,
	ZO_BuyBackFilterDivider,
	ZO_BuyBackSearchDivider,
	ZO_BuyBackSearchFilters,
	ZO_RepairWindowFilterDivider,
	ZO_RepairWindowSearchDivider,
	ZO_RepairWindowSearchFilters,
	ZO_SmithingTopLevelRefinementPanelInventory,
	ZO_SmithingTopLevelCreationPanelTabsDivider,
	ZO_SmithingTopLevelCreationPanelPatternListDivider,
	ZO_SmithingTopLevelCreationPanelMaterialListDivider,
	ZO_SmithingTopLevelCreationPanelTraitListDivider,
	ZO_SmithingTopLevelDeconstructionPanelInventoryFilterDivider,
	ZO_SmithingTopLevelDeconstructionPanelInventorySortBy,
	ZO_SmithingTopLevelImprovementPanelBoosterContainer,
	ZO_SmithingTopLevelImprovementPanelInventoryFilterDivider,
	ZO_SmithingTopLevelImprovementPanelInventorySortBy,
	ZO_SmithingTopLevelResearchPanelTimerIcon,
	ZO_SmithingTopLevelResearchPanelButtonDivider,
	ZO_SmithingTopLevelResearchPanelContainerDivider,
	ZO_ProvisionerTopLevelNavigationDivider,
	ZO_ProvisionerTopLevelMenuBarDivider,
	ZO_AlchemyTopLevelInventoryFilterDivider,
	ZO_AlchemyTopLevelInventoryButtonDivider,
	ZO_GuildBankFilterDivider,
	ZO_GuildBankSortBy,
	ZO_GuildBankSearchDivider,
	ZO_CraftBagFilterDivider,
	ZO_CraftBagSearchFilters,
	ZO_CraftBagSearchDivider,
	ZO_CraftBagSortBy,
	ZO_UniversalDeconstructionTopLevel_KeyboardPanelInventorySortBy,
	ZO_UniversalDeconstructionTopLevel_KeyboardPanelInventoryFilterDivider,
	ZO_UniversalDeconstructionTopLevel_KeyboardPanelInventoryButtonDivider,
	ZO_UniversalDeconstructionTopLevel_KeyboardPanelInventoryCraftingTypes,
	ZO_SmithingTopLevelDeconstructionPanelInventoryButtonDivider,
	ZO_PlayerBankFilterDivider,
	ZO_PlayerBankSearchFilters,
	ZO_PlayerBankSearchDivider,
	ZO_PlayerBankSortBy,
	ZO_GuildBrowser_GuildInfo_Keyboard_TopLevelBack,
	ZO_GuildHeraldryTopDivider,
	ZO_GuildRanksAddRank,
	ZO_CampaignOverviewTopDivider,
	ZO_CampaignBrowserRulesDivider,
	ZO_CampaignBrowserListDividerLeft,
	ZO_CampaignBrowserListDividerRight,
	ZO_InventoryWalletFilterDivider,
	ZO_InventoryWalletSearchDivider,
	ZO_InventoryWalletSearchFilters,
	ZO_QuestItemsFilterDivider,
	ZO_QuickSlot_Keyboard_TopLevelFilterDivider,
	ZO_QuickSlot_Keyboard_TopLevelSearchDivider,
	ZO_QuickSlot_Keyboard_TopLevelSearchFilters,
	ZO_QuickSlot_Keyboard_TopLevelSortBy,
	ZO_SmithingTopLevelCreationPanelStyleListDivider,
	ZO_SmithingTopLevelResearchPanelResearchLineListDivider,
	ZO_CharacterEquipmentSlotsCostume,
	ZO_MailSendTo,
	ZO_MailSendSubject,
	ZO_MailSendBody,
	ZO_MailSendPostageHelp,
	ZO_TradingHousePostItemPaneFormInvoice,
	ZO_TradeMyControlsAcceptOverlay,
	ZO_TradeMyControlsMoney,
	ZO_TradeTheirControlsAcceptOverlay,
	TheirTradeWindowSlot1,
	TheirTradeWindowSlot2,
	TheirTradeWindowSlot3,
	TheirTradeWindowSlot4,
	TheirTradeWindowSlot5,
	ZO_TradeTheirControlsMoney,
	ZO_WritAdvisor_Keyboard_TopLevelHeaderContainer,
}

PP.zAxisChildFixes = {
	ZO_CampaignBrowserHeaders,
}

