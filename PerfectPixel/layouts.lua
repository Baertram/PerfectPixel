local PP = PP ---@class PP

PP:NewLayout('inventorySlot', {
		default = {
			onCreate = {
				['parent'] = function(c, sv)
					PP:CreateBgToSlot(c, nil, sv)
					c:SetHeight(sv.list_control_height)
				end,
				['SellPrice'] = function(c, sv)
					c:SetHidden(false)
				end,
				['SellPriceText'] = function(c, sv)
					PP.Font(c, --[[Font]] PP.f.u67, 15, "shadow", --[[Alpha]] nil, --[[Color]] nil, nil, nil, nil, --[[StyleColor]] 0, 0, 0, 0.5)
					PP:SetLockFn(c, 'SetFont')
				end,
				['Button'] = function(c, sv)
					c:SetDimensions(36, 36)
					PP.Anchor(c, --[[#1]] CENTER, c:GetParent(), LEFT, 60, 0)
					if GridList then
						c.customTooltipAnchor = nil
					end
				end,
				['ButtonStackCount'] = function(c, sv)
					PP.Font(c, --[[Font]] PP.f.u67, 15, "outline", --[[Alpha]] nil, --[[Color]] nil, nil, nil, nil, --[[StyleColor]] 0, 0, 0, 0.5)
					PP.Anchor(c, --[[#1]] LEFT, c:GetParent():GetNamedChild("ButtonIcon"), LEFT, 34, 8)
				end,
				['Status'] = function(c, sv)
					c:SetDimensions(26, 26)
					PP.Anchor(c, --[[#1]] CENTER, c:GetParent(), LEFT, 18, 0)
					c:SetAlpha(1)
					c:SetMouseEnabled(true)
					c:SetDrawLevel(1)

					c:GetNamedChild("Texture"):SetMouseEnabled(true)
					c:GetNamedChild("Texture"):SetDrawLevel(1)
				end,
				['Name'] = function(c, sv)
					PP.Font(c, --[[Font]] PP.f.u67, 15, "shadow", --[[Alpha]] nil, --[[Color]] nil, nil, nil, nil, --[[StyleColor]] 0, 0, 0, 0.5)
					PP.Anchor(c, --[[#1]] LEFT, c:GetParent(), LEFT, 110, -1)
					c:SetLineSpacing(0)
					c:SetVerticalAlignment(TEXT_ALIGN_CENTER)
					c:SetHidden(false)
				end,
				['SellInformation'] = function(c, sv)
					c:SetDimensions(32, 32)
					c:ClearAnchors()
					c:SetAnchor(RIGHT, c:GetParent():GetNamedChild("SellPrice"), LEFT, -5, 0)
					c:SetAlpha(1)
					c:SetMouseEnabled(true)
					c:SetDrawLayer(1)
					c:SetDrawLevel(1)
				end,
				['TraitInfo'] = function(c, sv)
					c:SetDimensions(32, 32)
					c:SetAnchorFill(c:GetParent():GetNamedChild("SellInformation"))
					c:SetAlpha(1)
					c:SetMouseEnabled(true)
					c:SetDrawLevel(1)
				end,
				['Bg'] = function(c, sv)
					c:SetTexture("PerfectPixel/tex/tex_clear.dds")
				end,
				['Highlight'] = function(c, sv)
					c:SetHidden(true)
					-- c:SetTexture("PerfectPixel/tex/tex_clear.dds")
				end,
			},
		}
	}
)

PP:NewLayout('inventory', {
		default = {
			tlc = {
				t_y	= 110,
				b_y	= -90
			},
			list = {
				w	= 565,
				t_y	= 130,
				b_y	= 0
			},
			infoBar = {
				y	= 6
			},
			sort = {
				w			= 565,
				name_w		= 241,
				name_t_x	= 88
			},
			fragments = {
				add				= { FRAME_TARGET_BLUR_STANDARD_RIGHT_PANEL_MEDIUM_LEFT_PANEL_FRAGMENT },
				remove			= { RIGHT_PANEL_BG_FRAGMENT, WIDE_LEFT_PANEL_BG_FRAGMENT },
				forceRemove		= {},
				hideBgForScene	= {}
			},
			options = {
				noTabs		= false,
				noSearch	= false,
				noFDivider	= false,
				menu		= false
			},
			childSuffixs = { -- PP.GetLinks()
				[1] = { 'List'			},	--1	list
				[2] = { 'SortBy'		},	--2	sortBy
				[3] = { 'Tabs'			},	--3	tabs
				[4] = { 'FilterDivider'	},	--4	filterDivider
				[5] = { 'SearchFilters'	},	--5	searchFilters
				[6] = { 'SearchDivider'	},	--6	searchDivider
				[7] = { 'InfoBar'		},	--7	infoBar
				[8] = { 'Menu'			}	--8	menu
			}
		},
		--extra
		[ZO_InventoryWallet] = {
			list = {
				t_y = 84
			},
			sort = {
				name_t_x = 112
			},
		},
		[ZO_QuestItems] = {
			list = {
				t_y = 32
			},
			sort = {
				name_t_x = 112
			},
			options = {
				noTabs		= true,
				noFDivider	= true
			}
		},
		[ZO_PlayerBank] = {
			childSuffixs = {
				[1] = {	'Backpack'	}
			}
		},
		[ZO_HouseBank] = {
			childSuffixs = {
				[1] = {	'Backpack'	}
			}
		},
		[ZO_GuildBank] = {
			childSuffixs = {
				[1] = {	'Backpack'	}
			}
		},
		[ZO_StablePanel] = {
			options = {
				menu = ZO_StableWindowMenu
			}
		},
		[ZO_Trade] = {
			fragments = {
				remove			= { TITLE_FRAGMENT, PLAYER_TRADE_TITLE_FRAGMENT, RIGHT_BG_FRAGMENT },
				hideBgForScene	= { ZO_PlayerInventory }
			},
			options = {
				menu = ZO_Fence_Keyboard_WindowMenu
			}
		},
		[ZO_SmithingTopLevelRefinementPanel] = {
			list = {
				t_y = 84
			},
			fragments = {
				remove		= { RIGHT_PANEL_BG_FRAGMENT },
				forceRemove	= { THIN_LEFT_PANEL_BG_FRAGMENT, MEDIUM_LEFT_PANEL_BG_FRAGMENT }
			}
		},
		[ZO_SmithingTopLevelImprovementPanel] = {
			list = {
				t_y	= 84,
				b_y	= -130
			},
			infoBar = {
				y = 136
			}
		},
		[ZO_UniversalDeconstructionTopLevel_KeyboardPanel] = {
			fragments = {
				remove		= { RIGHT_PANEL_BG_FRAGMENT },
				forceRemove	= { THIN_LEFT_PANEL_BG_FRAGMENT, MEDIUM_LEFT_PANEL_BG_FRAGMENT }
			}
		},
		[ZO_EnchantingTopLevelInventory] = {
			list = {
				t_y = { [ENCHANTING_MODE_CREATION] = 130, [ENCHANTING_MODE_EXTRACTION] = 84 }
			}
		},
		[ZO_ProvisionerTopLevel] = {
			list = {
				t_y = 110
			}
		},
		[ZO_RetraitStation_KeyboardTopLevelRetraitPanel] = {
			list = {
				t_y = 84
			},
			fragments = {
				add			= { FRAME_TARGET_BLUR_CENTERED_FRAGMENT },
				forceRemove	= { THIN_LEFT_PANEL_BG_FRAGMENT, RIGHT_PANEL_BG_FRAGMENT, RIGHT_BG_FRAGMENT, TREE_UNDERLAY_FRAGMENT }
			},
			-- options = {
				-- menu = ZO_RetraitStation_KeyboardTopLevelModeMenu
			-- }
		},
		[ZO_CompanionEquipment_Panel_Keyboard] = {
			infoBar = {
				y = 0
			},
			fragments = false
		}
	}
)

PP:NewLayout('menuBar', {
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
