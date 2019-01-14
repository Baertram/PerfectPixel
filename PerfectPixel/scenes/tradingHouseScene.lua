PP.tradingHouseScene = function()
	
	local tradingHouseScene = SCENE_MANAGER:GetScene("tradinghouse")
	tradingHouseScene:RemoveFragment(RIGHT_BG_FRAGMENT)
	tradingHouseScene:RemoveFragment(TREE_UNDERLAY_FRAGMENT)
	tradingHouseScene:RemoveFragment(KEYBIND_STRIP_MUNGE_BACKDROP_FRAGMENT)

	tradingHouseScene:RegisterCallback("StateChange", function(oldState, newState)
		if newState == SCENE_SHOWING then
			PP.Anchor(ZO_SharedRightPanelBackground, --[[#1]] TOPRIGHT,	nil, TOPRIGHT, 0, 53,	--[[#2]] true, BOTTOMLEFT, ZO_TradingHouseItemPane, BOTTOMRIGHT, -573, 43)
		elseif newState == SCENE_HIDDEN then
			PP.Anchor(ZO_SharedRightPanelBackground, --[[#1]] RIGHT, nil, RIGHT, 0, 20,			--[[#2]] false, BOTTOMLEFT, nil, BOTTOMRIGHT, 0, 0)
		end
	end)	
	
	PP.mainBackdrop(ZO_TradingHouse,		'tradinghouse', --[[backdrop]] TOPLEFT, BOTTOMRIGHT, -20, 0, 0, 50, --[[tex]] PP.t.bg1, 8, 1, --[[bd]] 10, 10, 10, .7, --[[edge]] 0, 0, 0, 1, --[[texture]] true, .5)
	PP.mainBackdrop(ZO_KeybindStripControl,	'tradinghouse', --[[backdrop]] TOPLEFT, BOTTOMRIGHT, -6, 0, 2, 6, --[[tex]] PP.t.bg1, 8, 1, --[[bd]] 10, 10, 10, .6, --[[edge]] 0, 0, 0, 1, --[[texture]] false, 0)
	
	PP.Anchor(ZO_TradingHouse,							--[[#1]] TOPLEFT,		GuiRoot,								TOPRIGHT,	-930, 100,	--[[#2]] true,	BOTTOMRIGHT,	GuiRoot,								BOTTOMRIGHT,	9, -120)
	PP.Anchor(ZO_TradingHouseTitle,						--[[#1]] BOTTOMLEFT,	ZO_SharedRightPanelBackground,			TOPLEFT,	-420, 50,	--[[#2]] false,	BOTTOMRIGHT,	GuiRoot,								BOTTOMRIGHT,	0, 0)
	PP.Anchor(ZO_TradingHouseItemPaneSearchResults,		--[[#1]] TOPLEFT,		ZO_TradingHouseItemPane,				TOPLEFT,	0, 9,		--[[#2]] true,	BOTTOMRIGHT,	ZO_TradingHouseItemPane,				BOTTOMRIGHT,	-8, 13)
	PP.Anchor(ZO_TradingHouseItemPaneSearchControls,	--[[#1]] TOPLEFT,		ZO_TradingHouseItemPaneSearchResults,	BOTTOMLEFT,	0, 0,		--[[#2]] true,	TOPRIGHT,		ZO_TradingHouseItemPaneSearchResults,	BOTTOMRIGHT,	0, 3)

	PP.ListBackdrop(ZO_TradingHouseItemPaneSearchResults, -3, -3, -1, 3, --[[tex]] nil, 8, 0, --[[bd]] 5, 5, 5, .6, --[[edge]] 30, 30, 30, .6)
	PP.ScrollBar(ZO_TradingHouseItemPaneSearchResults,	--[[sb_c]] 180, 180, 180, .7, --[[bd_c]] 20, 20, 20, .7, --[[edge]] 40, 40, 40, .9)

	
--	PP.BTexture(ZO_TradingHouseLeftPaneBrowseItems, nil, nil, nil, -17, -54, nil, ZO_TradingHouseItemPaneSearchResults, BOTTOMLEFT, -5, 34,	--[[tex]] nil, 8, 0, --[[bd]] 40, 40, 40, .6, --[[edge]] 0, 0, 0, 1, --[[t_tex]] true, PP.t.def1, 512, 1, --[[ct]] 255, 255, 255, .9)
	PP.Backdrop(ZO_TradingHouse,ZO_TradingHouseLeftPaneBrowseItems,--[[#1]]nil,nil,nil,-17,-54,--[[#2]]nil,ZO_TradingHouseItemPaneSearchResults,BOTTOMLEFT,-5,34,--[[tex_1]]nil,8,0,--[[bd]]40,40,40,.6,--[[edge]]0,0,0,1,--[[tex_2]]true,PP.t.def1,512,1,--[[bd]]255,255,255,.9)
	PP.Backdrop(ZO_TradingHouse,ZO_TradingHouseLeftPanePostItem,--[[#1]]nil,nil,nil,-17,-54,--[[#2]]nil,ZO_PlayerInventoryList,BOTTOMLEFT,-5,34,--[[tex_1]]nil,8,0,--[[bd]]40,40,40,.6,--[[edge]]0,0,0,1,--[[tex_2]]true,PP.t.def1,512,1,--[[bd]]255,255,255,.9)

	ZO_TradingHouseTitleDivider:SetHidden(true)
----------------------------------------
    local function SceneStateChange(oldState, newState)
        if newState == SCENE_SHOWING then
		
			ZO_TradingHouseLeftPaneBrowseItems_BG:SetHidden(false)
			
			ZO_TradingHouseItemPaneSearchResults.useFadeGradient = false
			ZO_TradingHouseItemPaneSearchResults.uniformControlHeight = 44

			for i=1, 5 do
				if ZO_ScrollList_GetDataTypeTable(TRADING_HOUSE.m_searchResultsList, i) then

					ZO_TradingHouseItemPaneSearchResults.dataTypes[i].height = 44

					local dataType = ZO_ScrollList_GetDataTypeTable(TRADING_HOUSE.m_searchResultsList, i)
					local originalSetupCallback = dataType.setupCallback
					dataType.setupCallback = function(rowControl, result)
						originalSetupCallback(rowControl, result)
						rowControl:SetHeight(42)
					--"Bg"-------------------------------------------------------------------------
						if rowControl:GetNamedChild("Bg") then
							local bg = rowControl:GetNamedChild("Bg")
							bg:SetTexture(PP.t.clear)
							if not rowControl:GetNamedChild("Backdrop") then
								CreateControl( rowControl:GetName() .. "Backdrop", rowControl, CT_BACKDROP)
								local backdrop = rowControl:GetNamedChild("Backdrop")
									PP.Anchor(backdrop, --[[#1]] TOPLEFT, rowControl, TOPLEFT, 0, 0, --[[#2]] true, BOTTOMRIGHT, rowControl, BOTTOMRIGHT, 0, 0)
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
							end
						end
					--"SellPrice"------------------------------------------------------------------
						if rowControl:GetNamedChild("SellPrice") then
							local sp = rowControl:GetNamedChild("SellPrice")
							PP.Font(sp, --[[Font]] PP.f.u67, 15, "outline", --[[Alpha]] nil, --[[Color]] nil, nil, nil, nil, --[[StyleColor]] 0, 0, 0, .5)
						end
						
					--Compatibility
						--AwesomeGuildStore
						if rowControl:GetNamedChild("SellPricePerItem") then
							local sppi = rowControl:GetNamedChild("SellPricePerItem")
							PP.Font(sppi, --[[Font]] PP.f.u67, 14, "outline", --[[Alpha]] .9, --[[Color]] nil, nil, nil, nil, --[[StyleColor]] 0, 0, 0, .5)
							PP.Anchor(sppi, --[[#1]] TOPRIGHT, rowControl:GetNamedChild("SellPrice"), BOTTOMRIGHT, 0, -2)
						end
					--MasterMerchant
						if rowControl:GetNamedChild("BuyingAdvice") then
							local advice = rowControl:GetNamedChild("BuyingAdvice")
							PP.Font(advice, --[[Font]] PP.f.u67, 14, "outline", --[[Alpha]] .9, --[[Color]] nil, nil, nil, nil, --[[StyleColor]] 0, 0, 0, .5)
							PP.Anchor(advice, --[[#1]] RIGHT, rowControl:GetNamedChild("TimeRemaining"), LEFT, -20, 8)
						end
					-------------------------------------------------------------------------------
					end
				end
			end

			PP.Anchor(ZO_TradingHouseLeftPanePostItemPendingBG,	--[[#1]] TOPRIGHT,	ZO_TradingHouseLeftPanePostItem_BG,	TOPRIGHT,	-2, 130,	--[[#2]] false,	nil, nil, nil, 0, 0)

			for i=1, 5 do
				if ZO_TradingHouseItemPaneSearchResults.dataTypes[i] then
					ZO_TradingHouseItemPaneSearchResults.dataTypes[i].pool:SetCustomAcquireBehavior( function(control)
						if control:GetNamedChild("Button") then
							local button = control:GetNamedChild("Button")
							button:SetDimensions(36, 36)
							PP.Anchor(button, --[[#1]] CENTER, control, LEFT, 30, 0)
						end
						if control:GetNamedChild("ButtonStackCount") then
							local stack = control:GetNamedChild("ButtonStackCount")
							PP.Font(stack, --[[Font]] PP.f.u67, 15, "outline", --[[Alpha]] nil, --[[Color]] nil, nil, nil, nil, --[[StyleColor]] 0, 0, 0, .5)
							PP.Anchor(stack, --[[#1]] BOTTOMLEFT, control, BOTTOMLEFT, 46, 0)
						end
						if control:GetNamedChild("Name") then
							local name = control:GetNamedChild("Name")
							PP.Font(name, --[[Font]] PP.f.u67, 15, "outline", --[[Alpha]] nil, --[[Color]] nil, nil, nil, nil, --[[StyleColor]] 0, 0, 0, .5)
							PP.Anchor(name, --[[#1]] TOPLEFT, control, TOPLEFT, 70, 0)
						end
						if control:GetNamedChild("SellerName") then
							local seller = control:GetNamedChild("SellerName")
							PP.Font(seller, --[[Font]] PP.f.u67, 15, "outline", --[[Alpha]] .7, --[[Color]] nil, nil, nil, nil, --[[StyleColor]] 0, 0, 0, .5)
							PP.Anchor(seller, --[[#1]] BOTTOMLEFT, control, BOTTOMLEFT, 70, -2)
						end
						if control:GetNamedChild("TimeRemaining") then
							local remaining = control:GetNamedChild("TimeRemaining")
							PP.Font(remaining, --[[Font]] PP.f.u67, 15, "outline", --[[Alpha]] nil, --[[Color]] nil, nil, nil, nil, --[[StyleColor]] 0, 0, 0, .5)
							PP.Anchor(remaining, --[[#1]] CENTER, control, RIGHT, -160, 0)
						end
						if control:GetNamedChild("TraitInfo") then
							local trait = control:GetNamedChild("TraitInfo")
							trait:SetDimensions(26, 26)
							PP.Anchor(trait, --[[#1]] CENTER, control, RIGHT, -120, 0)
						end
						if control:GetNamedChild("Highlight") then
							local highlight = control:GetNamedChild("Highlight")
							highlight:ClearAnchors()
							if not control:GetNamedChild("BackdropHL") and (i == 4) then
								CreateControl( control:GetName() .. "BackdropHL", control:GetNamedChild("Highlight"), CT_BACKDROP)
								local backdropHL = control:GetNamedChild("BackdropHL")
								PP.Anchor(backdropHL, --[[#1]] TOPLEFT, control, TOPLEFT, 0, 0, --[[#2]] true, BOTTOMRIGHT, control, BOTTOMRIGHT, 0, 0)
								backdropHL:SetCenterColor( 96/255, 125/255, 139/255, .1 )
								backdropHL:SetEdgeColor( 96/255, 125/255, 139/255, .4 )
								backdropHL:SetEdgeTexture( nil, 1, 1, 1, 0 )
								backdropHL:SetInsets( 1, 1, -1, -1 )
							end
						end
					end )
				end
			end

			if AwesomeGuildStore then
				local sb = AwesomeGuildStoreFilterAreaScrollBar
				AwesomeGuildStoreFilterAreaScrollBarUp:SetHidden(true)
				AwesomeGuildStoreFilterAreaScrollBarDown:SetHidden(true)
				sb:SetBackgroundTopTexture(nil)
				sb:SetBackgroundMiddleTexture(nil)
				sb:SetBackgroundBottomTexture(nil)
				sb:SetThumbTexture(nil, nil, nil, 4)
				sb:SetColor( .8, .8, .8, .8)
				sb:SetWidth(14)
				sb["alphaAnimation"]:SetDuration(nil)
				sb["targetAlpha"] = 0.8
				PP.Anchor(sb, --[[#1]] point_1, nil, TOPRIGHT, 0, 0, --[[#2]] true, BOTTOMLEFT, nil, relativePoint_2, -13, 0)
				PP.BTexture(AwesomeGuildStoreFilterAreaScrollBarThumbMunge, --[[#1]] nil, sb, nil, 2, -3, --[[#2]] nil, sb, nil, -2, 3, --[[tex]] nil, 8, 1, --[[bd]] 0, 0, 0, .6, --[[edge]] 50, 50, 50, 1, --[[t_tex]] true, nil, 8, 0, --[[ct]] 255, 255, 255, 0)

				AwesomeGuildStoreFilterArea.useFadeGradient = false

				PP.ListBackdrop(AwesomeGuildStoreFilterArea, -14, -3, -13, 3, --[[tex]] nil, 8, 0, --[[bd]] 0, 0, 0, .6, --[[edge]] 50, 50, 50, 1)

				PP.Anchor(ZO_TradingHouseLeftPaneBrowseItemsCommon,	--[[#1]] TOPLEFT,		ZO_TradingHouseLeftPane,					TOPLEFT,	0, -10,	--[[#2]] true,	BOTTOMRIGHT,	ZO_TradingHouseLeftPane,					BOTTOMRIGHT,	0, 40)
				PP.Anchor(AwesomeGuildStoreFilterArea,				--[[#1]] TOPLEFT,		ZO_TradingHouseLeftPaneBrowseItemsCommon,	TOPLEFT,	10, 0,	--[[#2]] true,	BOTTOMRIGHT,	AwesomeGuildStoreButtonArea,				TOPRIGHT,		21, -10)
				PP.Anchor(AwesomeGuildStoreLoadingIndicator,		--[[#1]] BOTTOMLEFT,	ZO_TradingHouse,							BOTTOMLEFT, 6, 23,	--[[#2]] false, BOTTOMRIGHT,	AwesomeGuildStoreButtonArea,				TOPRIGHT,		21, -10)
				PP.Anchor(AwesomeGuildStoreButtonArea,				--[[#1]] BOTTOMLEFT,	ZO_TradingHouseLeftPaneBrowseItemsCommon,	BOTTOMLEFT, 16, 0,	--[[#2]] true,	BOTTOMRIGHT,	ZO_TradingHouseLeftPaneBrowseItemsCommon,	BOTTOMRIGHT,	0, 0)
				
				PP.ListBackdrop(AwesomeGuildStoreSearchLibrary, 0, 0, 0, 0, --[[tex]] PP.t.bg1, 8, 1, --[[bd]] 10, 10, 10, .6, --[[edge]] 0, 0, 0, 1)
				AwesomeGuildStoreSearchLibraryBg:SetHidden(true)

			end

			tradingHouseScene:UnregisterCallback("StateChange",  SceneStateChange)
			-- d('update: TRADING_HOUSE_SCENE')
        end
    end
    tradingHouseScene:RegisterCallback("StateChange",  SceneStateChange)
------------------------------------------

end