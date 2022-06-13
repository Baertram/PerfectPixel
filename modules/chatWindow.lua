PP.chatWindow = function()
	--===============================================================================================--
	local SV_VER			= 0.1
	local DEF = {
		toggle = false,
	}
	local SV = ZO_SavedVars:NewAccountWide(PP.ADDON_NAME, SV_VER, "ChatWindow", DEF, GetWorldName())
	---------------------------------------------
	table.insert(PP.optionsData,
			{
				type				= "submenu",
				name				= GetString(PP_LAM_SCENE_CHAT),
				controls = {
					{
						type				= "checkbox",
						name				= GetString(PP_LAM_ACTIVATE),
						tooltip				= GetString(PP_LAM_ACTIVATE),
						getFunc				= function() return SV.toggle end,
						setFunc				= function(value) SV.toggle = value end,
						default				= DEF.toggle,
						requiresReload		= true,
					},
				},
			})

	--d("[PP]ChatActivated: " ..tostring(SV.toggle))
	if not SV.toggle == true then return end

	local ppSV = PP.SV

	--ZO_ChatWindow -- <TopLevelControl name="ZO_ChatWindow" inherits="ZO_ChatWindowTopLevelTemplate">
	--<TopLevelControl name="ZO_ChatContainerTemplate" resizeHandleSize="8" mouseEnabled="true" clampedToScreen="true" virtual="true">
	--[[
<Controls>
                <Backdrop name="$(parent)Bg" integralWrapping="true">
                    <Anchor point="TOPLEFT" offsetX="-8" offsetY="-6"/>
                    <Anchor point="BOTTOMRIGHT" offsetX="4" offsetY="4"/>

                    <Edge file="EsoUI/Art/ChatWindow/chat_BG_edge.dds" edgeFileWidth="256" edgeFileHeight="256" edgeSize="32"/>
                    <Center file="EsoUI/Art/ChatWindow/chat_BG_center.dds" />
                    <Insets left="32" top="32" right="-32" bottom="-32" />
                </Backdrop>

                <Slider name="$(parent)Scrollbar" mouseEnabled="true">
	]]
	local chatWindow = 		KEYBOARD_CHAT_SYSTEM.control --ZO_ChatWindow
	--local chatTextEdit = 	chatWindow:GetNamedChild("TextEntryEdit")

	--ZO_ChatWindowTextEntryEdit
	--chatTextEdit:SetPixelRoundingEnabled(false)

	PP.ScrollBar(chatWindow,	--[[sb_c]] 180, 180, 180, .7, --[[bd_c]] 20, 20, 20, .7, true)

	--ZO_ChatWindow KEYBOARD_CHAT_SYSTEM

	-- ZO_ChatWindowTextEntryEdit:SetPixelRoundingEnabled(false)


	local function changeChatBG()
		local bg	= chatWindow:GetNamedChild("Bg")

		bg:ClearAnchors()
		bg:SetAnchor(TOPLEFT,		chatWindow,	TOPLEFT,		0, 0)
		bg:SetAnchor(BOTTOMRIGHT,	chatWindow,	BOTTOMRIGHT,	0, 0)

		bg:SetDrawLayer(DL_BACKGROUND)
		bg:SetDrawLevel(0)
		bg:SetDrawTier(DT_LOW)

		bg:SetCenterTexture(ppSV.skin_backdrop, ppSV.skin_backdrop_tile_size, ppSV.skin_backdrop_tile and 1 or 0)
		bg:SetCenterColor(unpack(PP.SV.skin_backdrop_col))
		bg:SetInsets(ppSV.skin_backdrop_insets, ppSV.skin_backdrop_insets, -ppSV.skin_backdrop_insets, -ppSV.skin_backdrop_insets)
		bg:SetEdgeTexture(ppSV.skin_edge, ppSV.skin_edge_file_width, ppSV.skin_edge_file_height, ppSV.skin_edge_thickness, 0)
		bg:SetEdgeColor(unpack(ppSV.skin_edge_col))
		bg:SetIntegralWrapping(ppSV.skin_edge_integral_wrapping)
	end


	--Fix for pChat chat BG texture darkness update
	if pChat then
		ZO_PreHook(pChat, "ChangeChatWindowDarkness", function()
			--d("[PerfectPixel]pChat setting to change the chat background darkness is disabled while PP is enabled!")
			--Set default texture again
			changeChatBG()
			--Only chnage the opacity just like within default/vanilla chat opacity settings
			--todo

			--Prevent pChat's function
			return true --do not call original function at pChat
		end)
	end

	--Change the background of the chat npw
	changeChatBG()

	--[[
        local container	= ZO_ChatWindowWindowContainer --KEYBOARD_CHAT_SYSTEM.containers[1].windowContainer
        local tex = PP.t.w8x8

        local sb	= ZO_ChatWindowScrollbar
        local up	= ZO_ChatWindowScrollbarScrollUp
        local down	= ZO_ChatWindowScrollbarScrollDown
        -- local scrollEnd	= ZO_ChatWindowScrollbarScrollEnd
        local thumb	= sb:GetThumbTextureControl()

        up:SetHidden(true)
        down:SetHidden(true)
        up:ClearAnchors()
        down:ClearAnchors()

        sb:SetBackgroundMiddleTexture(tex)
        sb:SetBackgroundTopTexture(nil)
        sb:SetBackgroundBottomTexture(nil)
        sb:SetColor(50/255, 50/255, 50/255, .6)
        sb:SetHitInsets(-3, 0, 3, 0)
        sb:SetWidth(4)
        sb:SetDrawLayer(DL_CONTROLS)
        sb.thumb = thumb

        thumb:SetWidth(4)
        thumb:SetTexture(nil)
        thumb:SetColor(120/255, 120/255, 120/255, .6)
        thumb:SetHitInsets(-3, 0, 3, 0)

        sb:ClearAnchors()
        sb:SetAnchor(TOPLEFT,		container, TOPRIGHT,		6, 0)
        sb:SetAnchor(BOTTOMLEFT,	container, BOTTOMRIGHT,		6, 0)

        container:ClearAnchors()
        container:SetAnchor(TOPLEFT, ZO_ChatWindowDivider, BOTTOMLEFT, 0, 3)
        container:SetAnchor(BOTTOMRIGHT, ZO_ChatWindowTextEntry, TOPRIGHT, -10, -3)

        ZO_ChatWindowDivider:SetTexture(tex)
        ZO_ChatWindowDivider:SetHeight(2)
        ZO_ChatWindowDivider:SetColor(50/255, 50/255, 50/255, 1)



        ZO_ChatWindowTextEntry:ClearAnchors()
        ZO_ChatWindowTextEntry:SetAnchor(BOTTOMLEFT,	tlc,	BOTTOMLEFT,		26, 0)
        ZO_ChatWindowTextEntry:SetAnchor(BOTTOMRIGHT,	tlc,	BOTTOMRIGHT,	-10, -10)
    ]]
end