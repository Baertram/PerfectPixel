local PP = PP ---@class PP

PP:NewLayout('inventorySlot', {
		default = {
			modes	= { [1] = true, [2] = true, [3] = false },
			typeIds	= { [1] = true, [2] = true, [3] = true },
			onCreate = {
				['parent'] = function(c, sv)
					PP:CreateBgToSlot(c, nil, sv)
					c:SetHeight(sv.list_control_height)
				end,
				['SellPrice'] = function(c, sv)
					c:SetHidden(false)
				end,
				['SellPriceText'] = function(c, sv)
					PP.Font(c, --[[Font]] PP.f.u67, 15, "shadow")
					PP:SetLockFn(c, 'SetFont')
				end,
				['Button'] = function(c, sv)
					c:SetDimensions(36, 36)
					PP.Anchor(c, --[[#1]] CENTER, c.parent, LEFT, 60, 0)
					if GridList then
						c.customTooltipAnchor = nil
					end
				end,
				['ButtonStackCount'] = function(c, sv)
					PP.Font(c, --[[Font]] PP.f.u67, 15, "shadow")
					PP.Anchor(c, --[[#1]] LEFT, c.parent:GetNamedChild("ButtonIcon"), LEFT, 34, 8)
				end,
				['Status'] = function(c, sv)
					c:SetDimensions(26, 26)
					PP.Anchor(c, --[[#1]] CENTER, c.parent, LEFT, 18, 0)
					c:SetAlpha(1)
					c:SetMouseEnabled(true)
					c:SetDrawLevel(1)

					c:GetNamedChild("Texture"):SetMouseEnabled(true)
					c:GetNamedChild("Texture"):SetDrawLevel(1)
				end,
				['Name'] = function(c, sv)
					PP.Font(c, --[[Font]] PP.f.u67, 15, "shadow")
					PP.Anchor(c, --[[#1]] LEFT, c.parent:GetNamedChild("ButtonIcon"), RIGHT, 30, 0)
					c:SetVerticalAlignment(TEXT_ALIGN_CENTER)
					c:SetHidden(false)
					c:SetLineSpacing(-2)
					PP:SetLockFn(c, 'SetLineSpacing')
				end,
				['SellInformation'] = function(c, sv)
					c:SetDimensions(32, 32)
					c:ClearAnchors()
					c:SetAnchor(RIGHT, c.parent:GetNamedChild("SellPrice"), LEFT, -5, 0)
					c:SetAlpha(1)
					c:SetMouseEnabled(true)
					c:SetDrawLayer(1)
					c:SetDrawLevel(1)
				end,
				['TraitInfo'] = function(c, sv)
					c:SetDimensions(32, 32)
					c:SetAnchorFill(c.parent:GetNamedChild("SellInformation"))
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
				end
			},
			onUpdate = {}
		},
		[ZO_LootAlphaContainerList] = {
			modes	= { [1] = true },
			typeIds	= { [1] = true, [2] = true },
			onCreate = {
				['parent'] = function(c, sv)
					PP:CreateBgToSlot(c, nil, sv)
					c:SetHeight(sv.list_control_height)

					local sp = CreateControl("$(parent)SellPrice", c, CT_LABEL)
					PP.Font(sp, --[[Font]] PP.f.u67, 15, "shadow")
					PP.Anchor(sp, --[[#1]] RIGHT, c, RIGHT, -10, 0)
					sp:SetDimensionConstraints(40, 0, 0, 0)
					sp:SetHorizontalAlignment(TEXT_ALIGN_RIGHT)
				end,
				['MultiIcon'] = function(c, sv)
					c:SetHidden(true)
				end,
				['Button'] = function(c, sv)
					c:SetDimensions(36, 36)
					PP.Anchor(c, --[[#1]] LEFT, c.parent, LEFT, 10, 0)
				end,
				['Name'] = function(c, sv)
					PP.Font(c, --[[Font]] PP.f.u67, 15, "shadow")
					PP.Anchor(c, --[[#1]] LEFT, c.parent:GetNamedChild("ButtonIcon"), RIGHT, 24, 0, --[[#2]] true, RIGHT, c.parent:GetNamedChild("SellPrice"), LEFT, -10, 0)
					c:SetVerticalAlignment(TEXT_ALIGN_CENTER)
					c:SetMaxLineCount(2)
					c:SetLineSpacing(-2)
					PP:SetLockFn(c, 'SetLineSpacing')
				end
			},
			onUpdate = {
				['Backdrop'] = function(c, sv, data)
					local col =  data.isStolen and sv.list_skin_edge_col_stolen or data.isQuest and sv.list_skin_edge_col_quest or sv.list_skin_edge_col
					c:SetEdgeColor(col[1], col[2], col[3], col[4])
				end,
				['MultiIcon'] = function(c, sv)
					c:SetHidden(true)
				end,
				['ButtonIcon'] = function(c, sv, data)
					c:SetHidden(false)
					c:SetTexture(data.icon)
				end,
				['SellPrice'] = function(c, sv, data)
					c:SetText("|u0:4:currency:" .. (data.value or '0') .. "|u|t14:14:/esoui/art/currency/gold_mipmap.dds|t")
				end,
			}
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
