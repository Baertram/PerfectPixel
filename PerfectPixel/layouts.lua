local PP = PP

PP:AddNewLayout('inventory', {
		default = {
			tl_t_y				= 110,
			tl_b_y				= -90,
			list_w				= 565,
			list_t_y			= 130,
			list_b_y			= 0,
			infoBar_y			= 6,
			sort_w				= 565,
			sort_name_w			= 241,
			sort_name_t_x		= 88,
			noTabs				= false,
			noSearch			= false,
			noFDivider			= false,
			addFragments		= { FRAME_TARGET_BLUR_STANDARD_RIGHT_PANEL_MEDIUM_LEFT_PANEL_FRAGMENT },
			removeFragments		= { RIGHT_PANEL_BG_FRAGMENT, WIDE_LEFT_PANEL_BG_FRAGMENT },
			forceRemoveFragment	= {},
			hideBgForScene		= {},
			menu				= false
		},
		--extra
		[ZO_InventoryWallet] = {
			list_t_y			= 84,
			sort_name_t_x		= 112
		},
		[ZO_QuestItems] = {
			list_t_y			= 32,
			sort_name_t_x		= 112,
			noTabs				= true,
			noFDivider			= true
		},
		[ZO_StablePanel] = {
			menu				= ZO_StableWindowMenu,
		},
		[ZO_Trade] = {
			menu				= ZO_Fence_Keyboard_WindowMenu,
			removeFragments		= { TITLE_FRAGMENT, PLAYER_TRADE_TITLE_FRAGMENT, RIGHT_BG_FRAGMENT },
			hideBgForScene		= { ZO_PlayerInventory }
		},
		[ZO_SmithingTopLevelRefinementPanel] = {
			list_t_y			= 84,
			removeFragments		= { RIGHT_PANEL_BG_FRAGMENT },
			forceRemoveFragment	= { THIN_LEFT_PANEL_BG_FRAGMENT, MEDIUM_LEFT_PANEL_BG_FRAGMENT }
		},
		[ZO_SmithingTopLevelImprovementPanel] = {
			list_t_y			= 84,
			list_b_y			= -130,
			infoBar_y			= 136
		},
		[ZO_UniversalDeconstructionTopLevel_KeyboardPanel] = {
			removeFragments		= { RIGHT_PANEL_BG_FRAGMENT },
			forceRemoveFragment	= { THIN_LEFT_PANEL_BG_FRAGMENT, MEDIUM_LEFT_PANEL_BG_FRAGMENT }
		},
		[ZO_EnchantingTopLevelInventory] = {
			list_t_y			= { [ENCHANTING_MODE_CREATION] = 130, [ENCHANTING_MODE_EXTRACTION] = 84 }
		},
		[ZO_ProvisionerTopLevel] = {
			list_t_y			= 110
		},
		[ZO_RetraitStation_KeyboardTopLevelRetraitPanel] = {
			list_t_y			= 84,
			addFragments		= { FRAME_TARGET_BLUR_CENTERED_FRAGMENT },
			forceRemoveFragment	= { THIN_LEFT_PANEL_BG_FRAGMENT, RIGHT_PANEL_BG_FRAGMENT, RIGHT_BG_FRAGMENT, TREE_UNDERLAY_FRAGMENT },
			-- menu				= ZO_RetraitStation_KeyboardTopLevelModeMenu
		},
	}
)

PP:AddNewLayout('companionInventory', {
		default = {
			tl_t_y				= 110,
			tl_b_y				= -90,
			list_w				= 565,
			list_t_y			= 130,
			list_b_y			= 0,
			infoBar_y			= 0,
			sort_w				= 565,
			sort_name_w			= 241,
			sort_name_t_x		= 88,
			noTabs				= false,
			noSearch			= false,
			noFDivider			= false,
			menu				= false
		},
	}
)

PP:AddNewLayout('menuBar', {
		default = {
			duration	= 50,
			defSize		= 64,
			nSize		= 50,
			dSize		= 60,
			noLabel		= false,
			label_f_s	= 22,
			fontOutline	= "outline",
			-- m_bPadding	= 20,
			-- m_point		= 2,
			-- m_rPoint	= 8
		},
		--extra
		tabs = {
			duration	= 50,
			defSize		= 51,
			nSize		= 40,
			dSize		= 46,
			noLabel		= false,
			label_f_s	= 16,
			fontOutline	= "shadow",
			-- m_bPadding	= -5,
			-- m_point		= 8,
			-- m_rPoint	= 2
		},
		menu = {
			duration	= 50,
			defSize		= 64,
			nSize		= 50,
			dSize		= 60,
			noLabel		= true,
			label_f_s	= 22
		}
	}
)

