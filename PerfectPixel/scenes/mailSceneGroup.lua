local PP = PP --- @class PP
local removeFragmentsFromScene = PP.removeFragmentsFromScene

-- Constants for fragment removal
local FRAGMENTS_TO_REMOVE =
{
    FRAME_PLAYER_FRAGMENT,
    RIGHT_BG_FRAGMENT,
    TITLE_FRAGMENT,
    MAIL_TITLE_FRAGMENT,
}

-- Stock navigation container starts at this Y so the unread header and full-mailbox warning stay clear of the tree.
local MAIL_NAVIGATION_TOP_OFFSET = 90
local MAIL_MESSAGE_TOP_OFFSET = 8
local MAIL_COLUMN_GAP = 12
local MAIL_MESSAGE_EDGE_PAD = 8
local MAIL_SUBJECT_GAP_Y = 12
-- Two header lines plus the gap, used until the received label has a real bottom.
local MAIL_SUBJECT_FALLBACK_OFFSET_Y = 56

-- ZO_MailInboxAttachmentSlot is 48. Footer is divider + header row + slot row.
local MAIL_ATTACHMENT_SLOT_SIZE = 48
local MAIL_ATTACHMENT_HEADER_HEIGHT = 24
local MAIL_ATTACHMENT_HEADER_GAP = 8
local MAIL_ATTACHMENT_DIVIDER_GAP = 6
local MAIL_ATTACHMENT_DIVIDER_HEIGHT = 4
local MAIL_PANE_TO_DIVIDER_GAP = 8
local MAIL_DIVIDER_BOTTOM_OFFSET = -(MAIL_MESSAGE_EDGE_PAD + MAIL_ATTACHMENT_SLOT_SIZE + MAIL_ATTACHMENT_HEADER_GAP + MAIL_ATTACHMENT_HEADER_HEIGHT + MAIL_ATTACHMENT_DIVIDER_GAP)
local MAIL_ATTACHMENT_FOOTER_HEIGHT = -MAIL_DIVIDER_BOTTOM_OFFSET + MAIL_ATTACHMENT_DIVIDER_HEIGHT + MAIL_PANE_TO_DIVIDER_GAP

local function StyleMailMessageLabel(label, size, outline)
    if not label then
        return
    end
    PP.Font(label, --[[Font]] PP.f.u67, size, outline, --[[Alpha]] nil, --[[Color]] nil, nil, nil, nil, --[[StyleColor]] 0, 0, 0, 0.5)
end

local function GetMessageSubjectOffsetY(messageControl, receivedLabel)
    local receivedBottom = receivedLabel:GetBottom()
    local messageTop = messageControl:GetTop()
    if receivedBottom <= messageTop then
        return MAIL_SUBJECT_FALLBACK_OFFSET_Y
    end
    return (receivedBottom - messageTop) + MAIL_SUBJECT_GAP_Y
end

-- Stock pane bottom is offsetY 536 from the message top (MailInbox_Keyboard.xml). That stays put when the inbox is stretched.
local function LayoutMessageSubjectAndPane()
    local messageControl = ZO_MailInboxMessage
    local receivedLabel = ZO_MailInboxMessageReceivedLabel
    local subjectLabel = ZO_MailInboxMessageSubject
    local messagePane = ZO_MailInboxMessagePane
    local attachmentsDivider = ZO_MailInboxMessageAttachmentsDivider
    if not messageControl or not subjectLabel or not messagePane then
        return
    end

    local subjectOffsetY = MAIL_SUBJECT_FALLBACK_OFFSET_Y
    if receivedLabel then
        subjectOffsetY = GetMessageSubjectOffsetY(messageControl, receivedLabel)
    end
    PP.Anchor(subjectLabel, --[[#1]] TOPLEFT, messageControl, TOPLEFT, 0, subjectOffsetY, --[[#2]] true, TOPRIGHT, messageControl, TOPRIGHT, -16, subjectOffsetY)

    local showAttachmentFooter = attachmentsDivider and not attachmentsDivider:IsHidden()
    local paneBottomOffset = showAttachmentFooter and -MAIL_ATTACHMENT_FOOTER_HEIGHT or -MAIL_MESSAGE_EDGE_PAD
    PP.Anchor(messagePane, --[[#1]] TOPLEFT, subjectLabel, BOTTOMLEFT, 0, MAIL_MESSAGE_EDGE_PAD, --[[#2]] true, BOTTOMRIGHT, messageControl, BOTTOMRIGHT, -4, paneBottomOffset)
end

-- Row highlight stays ZO_ThinListHighlight from ZO_MailInboxRow_OnInitialized.
-- Alternating row bands are ZO_MailInboxRowBg, built in MailInbox:RefreshData.
local function StyleMailRow(rowControl)
    local iconTexture = rowControl.iconTexture or rowControl:GetNamedChild("Icon")
    if iconTexture then
        PP.Anchor(iconTexture, --[[#1]] LEFT, rowControl, LEFT, 5, 0)
        iconTexture:SetDimensions(26, 26)
        iconTexture:SetDrawLayer(1)
    end

    local textContainer = rowControl:GetNamedChild("TextContainer")
    local subjectLabel = rowControl.subjectLabel
    if not subjectLabel and textContainer then
        subjectLabel = textContainer:GetNamedChild("Subject")
    end
    local expirationLabel = rowControl.expirationLabel
    if not expirationLabel and textContainer then
        expirationLabel = textContainer:GetNamedChild("Expiration")
    end
    if subjectLabel then
        PP.Font(subjectLabel, --[[Font]] PP.f.u67, 16, "outline", --[[Alpha]] nil, --[[Color]] nil, nil, nil, nil, --[[StyleColor]] 0, 0, 0, 0.5)
    end
    if expirationLabel then
        PP.Font(expirationLabel, --[[Font]] PP.f.u67, 14, "outline", --[[Alpha]] nil, --[[Color]] nil, nil, nil, nil, --[[StyleColor]] 0, 0, 0, 0.5)
    end
end

-- Helper function to edit Mail Inbox scene
-- MAIL_INBOX.navigationTree is a ZO_Tree. scrollControl is ZO_MailInboxNavigationContainer.
local function Edit_MailInbox(SV)
    local mailInbox = MAIL_INBOX
    local navigationTree = mailInbox.navigationTree
    local navigationContainer = navigationTree.scrollControl
    local messageControl = ZO_MailInboxMessage
    local messagePane = ZO_MailInboxMessagePane

    removeFragmentsFromScene(MAIL_INBOX_SCENE, FRAGMENTS_TO_REMOVE)

    PP:CreateBackground(ZO_MailInbox, --[[#1]] nil, nil, nil, -10, -10, --[[#2]] nil, nil, nil, 0, 10)
    PP.Anchor(ZO_MailInbox, --[[#1]] TOPRIGHT, GuiRoot, TOPRIGHT, 0, 120, --[[#2]] true, BOTTOMRIGHT, GuiRoot, BOTTOMRIGHT, 0, -70)

    PP.Anchor(ZO_MailInboxDeleteOnClaim, --[[#1]] BOTTOMLEFT, ZO_MailInboxInventoryUsage, TOPLEFT, 0, -4)
    PP.Anchor(ZO_MailInboxInventoryUsage, --[[#1]] BOTTOMLEFT, ZO_MailInbox, BOTTOMLEFT, 0, 4)
    PP.Anchor(navigationContainer, --[[#1]] TOPLEFT, ZO_MailInbox, TOPLEFT, 0, MAIL_NAVIGATION_TOP_OFFSET, --[[#2]] true, BOTTOMLEFT, ZO_MailInboxDeleteOnClaim, TOPLEFT, 0, 0)

    PP.ScrollBar(navigationContainer, --[[sb_c]] 180, 180, 180, 0.7, --[[bd_c]] 20, 20, 20, 0.7, false)
    ZO_Scroll_SetMaxFadeDistance(navigationContainer, SV.list_fade_distance)

    -- Reading column fills the stretched inbox. Width stays the stock footprint; height follows GuiRoot.
    PP.Anchor(messageControl, --[[#1]] TOPLEFT, navigationContainer, TOPRIGHT, MAIL_COLUMN_GAP, MAIL_MESSAGE_TOP_OFFSET - MAIL_NAVIGATION_TOP_OFFSET, --[[#2]] true, BOTTOMRIGHT, ZO_MailInbox, BOTTOMRIGHT, -MAIL_COLUMN_GAP, -MAIL_MESSAGE_EDGE_PAD)

    local attachmentsDivider = ZO_MailInboxMessageAttachmentsDivider
    local attachmentsHeader = ZO_MailInboxMessageAttachmentsHeader
    local attachments = ZO_MailInboxMessageAttachments
    local sentMoney = ZO_MailInboxMessageSentMoney
    local cod = ZO_MailInboxMessageCOD
    if attachmentsDivider then
        attachmentsDivider:SetHeight(MAIL_ATTACHMENT_DIVIDER_HEIGHT)
        PP.Anchor(attachmentsDivider, --[[#1]] BOTTOMLEFT, messageControl, BOTTOMLEFT, 0, MAIL_DIVIDER_BOTTOM_OFFSET, --[[#2]] true, BOTTOMRIGHT, messageControl, BOTTOMRIGHT, -16, MAIL_DIVIDER_BOTTOM_OFFSET)
    end
    if attachmentsHeader and attachmentsDivider then
        PP.Anchor(attachmentsHeader, --[[#1]] TOPLEFT, attachmentsDivider, BOTTOMLEFT, 0, MAIL_ATTACHMENT_DIVIDER_GAP)
    end
    if attachments and attachmentsHeader then
        PP.Anchor(attachments, --[[#1]] TOPLEFT, attachmentsHeader, BOTTOMLEFT, 24, MAIL_ATTACHMENT_HEADER_GAP)
    end
    -- Sent gold and COD share the header row. Currency is anchored TOPRIGHT inside each control.
    if sentMoney and attachmentsDivider then
        PP.Anchor(sentMoney, --[[#1]] TOPRIGHT, attachmentsDivider, BOTTOMRIGHT, 0, MAIL_ATTACHMENT_DIVIDER_GAP)
    end
    if cod and attachmentsDivider then
        PP.Anchor(cod, --[[#1]] TOPRIGHT, attachmentsDivider, BOTTOMRIGHT, 0, MAIL_ATTACHMENT_DIVIDER_GAP)
    end

    -- Body stays on PaneScrollChild. AGS anchors MailInvoice to this label, so a wider body widens the invoice.
    local messageBody = ZO_MailInboxMessageBody
    local scrollChild = ZO_MailInboxMessagePaneScrollChild
    if messageBody and scrollChild and messagePane then
        -- Left+right anchors replace the stock Dimensions x="480". Width 0 would collapse the label.
        PP.Anchor(messageBody, --[[#1]] TOPLEFT, scrollChild, TOPLEFT, 0, 0, --[[#2]] true, TOPRIGHT, messagePane, TOPRIGHT, -ZO_SCROLL_BAR_WIDTH, 0)
    end

    if messagePane then
        PP.ScrollBar(messagePane, --[[sb_c]] 180, 180, 180, 0.7, --[[bd_c]] 20, 20, 20, 0.7, false)
        ZO_Scroll_SetMaxFadeDistance(messagePane, SV.list_fade_distance)
    end

    local messageBGLeft = ZO_MailInboxMessageBGLeft
    local messageBGRight = ZO_MailInboxMessageBGRight
    if messageBGLeft then messageBGLeft:SetHidden(true) end
    if messageBGRight then messageBGRight:SetHidden(true) end

    StyleMailMessageLabel(ZO_MailInboxMessageFromLabel, 18, "outline")
    StyleMailMessageLabel(ZO_MailInboxMessageFrom, 18, "outline")
    StyleMailMessageLabel(ZO_MailInboxMessageReceivedLabel, 18, "outline")
    StyleMailMessageLabel(ZO_MailInboxMessageReceived, 18, "outline")
    StyleMailMessageLabel(ZO_MailInboxMessageExpiresLabel, 18, "outline")
    StyleMailMessageLabel(ZO_MailInboxMessageExpires, 18, "outline")
    StyleMailMessageLabel(ZO_MailInboxMessageSubject, 20, "outline")
    StyleMailMessageLabel(messageBody, 16, "soft-shadow-thin")
    StyleMailMessageLabel(attachmentsHeader, 18, "outline")

    LayoutMessageSubjectAndPane()
    ZO_PostHookHandler(messageControl, "OnRectHeightChanged", LayoutMessageSubjectAndPane)
    ZO_PostHookHandler(messageControl, "OnRectWidthChanged", LayoutMessageSubjectAndPane)
    MAIL_INBOX_SCENE:RegisterCallback("StateChange", function (oldState, newState)
        if newState == SCENE_SHOWN then
            LayoutMessageSubjectAndPane()
        end
    end)
    -- RefreshAttachmentsHeaderShown hides the divider when there are no items and no gold.
    SecurePostHook(mailInbox, "RefreshAttachmentsHeaderShown", LayoutMessageSubjectAndPane)

    -- Row height stays ZO_MAIL_INBOX_KEYBOARD_NODE_HEIGHT. UpdateSize and the stripe pool both use it.
    local mailRowTemplate = navigationTree.templateInfo["ZO_MailInboxRow"]
    if mailRowTemplate then
        local pool = mailRowTemplate.objectPool
        if pool then
            local existingFactory = pool.m_Factory
            pool.m_Factory = function (objectPool, objectKey)
                local rowControl = existingFactory(objectPool, objectKey)
                StyleMailRow(rowControl)
                return rowControl
            end
            for _, rowControl in pairs(pool.m_Free) do
                StyleMailRow(rowControl)
            end
            for _, rowControl in pairs(pool.m_Active) do
                StyleMailRow(rowControl)
            end
        end
    end

    local headerTemplate = navigationTree.templateInfo["ZO_MailInboxHeader"]
    if headerTemplate then
        local existingHeaderSetup = headerTemplate.setupFunction
        headerTemplate.setupFunction = function (node, control, headerData, open, userRequested)
            existingHeaderSetup(node, control, headerData, open, userRequested)

            local headerText = control.text
            if headerText then
                -- ZO_MailInboxHeader installs ZO_FontAdjustingWrapLabel (ZoFontHeader3, then Header2, then Header).
                -- SetText marks it dirty, and opening the node runs that ladder, so the open header shrinks.
                headerText.fonts = {
                    {
                        font = ZO_CreateFontString(PP.f.u67, 22, FONT_STYLE_OUTLINE),
                        lineLimit = 1,
                    },
                }
                headerText:SetDimensionConstraints(0, 0, 0, 0)
                headerText:SetModifyTextType(MODIFY_TEXT_TYPE_UPPERCASE)
                if headerData and headerData.text then
                    headerText:SetText(headerData.text)
                end
                headerText:SetVerticalAlignment(TEXT_ALIGN_CENTER)
                -- Leave the label color alone. ZO_IconHeader_Setup already called SetSelected(open):
                -- closed stays ZO_NORMAL_TEXT (tan), open becomes INTERFACE_TEXT_COLOR_SELECTED (white).
                PP.Font(headerText, --[[Font]] PP.f.u67, 22, "outline", --[[Alpha]] nil, --[[Color]] nil, nil, nil, nil, --[[StyleColor]] 0, 0, 0, 0.8)
                headerText:RefreshTextColor()
            end

            -- Stock category headers have no bar. Highlight stays on ZO_MailInboxRow only.
            local headerBackground = control:GetNamedChild("Bg")
            if headerBackground then
                headerBackground:SetHidden(true)
            end
        end
    end

    local emptyRowTemplate = navigationTree.templateInfo["ZO_MailInboxEmptyRow"]
    if emptyRowTemplate then
        local existingEmptySetup = emptyRowTemplate.setupFunction
        emptyRowTemplate.setupFunction = function (node, control, nodeData, open)
            existingEmptySetup(node, control, nodeData, open)
            local textLabel = control.textLabel or control:GetNamedChild("Text")
            if textLabel then
                PP.Font(textLabel, --[[Font]] PP.f.u67, 16, "outline", --[[Alpha]] nil, --[[Color]] nil, nil, nil, nil, --[[StyleColor]] 0, 0, 0, 0.5)
            end
        end
    end

end

-- Helper function to edit Mail Send scene
local function Edit_MailSend()
    -- Remove default fragments for clean UI
    removeFragmentsFromScene(MAIL_SEND_SCENE, FRAGMENTS_TO_REMOVE)

    -- Create custom background and anchoring for send mail window
    PP:CreateBackground(ZO_MailSend, --[[#1]] nil, nil, nil, -10, -10, --[[#2]] nil, nil, nil, 0, 6)

    -- Hide inventory background when mail send is open
    PP:HideBackgroundForScene(MAIL_SEND_SCENE, ZO_PlayerInventory.PP_BG)

    -- Position the send mail window
    PP.Anchor(ZO_MailSend, --[[#1]] TOPRIGHT, GuiRoot, TOPRIGHT, 0, 120, --[[#2]] true, BOTTOMRIGHT, GuiRoot, BOTTOMRIGHT, 0, -90)

    -- Style input field labels
    local toLabel = ZO_MailSendToLabel
    local subjectLabel = ZO_MailSendSubjectLabel
    local attachLabel = ZO_MailSendAttachMoneyLabel
    local codLabel = ZO_MailSendCoDLabel
    local postageLabel = ZO_MailSendPostageLabel
    local attachmentsHeader = ZO_MailSendAttachmentsHeader

    if toLabel then
        PP.Font(toLabel, --[[Font]] PP.f.u67, 20, "outline", --[[Alpha]] nil, --[[Color]] nil, nil, nil, nil, --[[StyleColor]] 0, 0, 0, 0.5)
    end
    if subjectLabel then
        PP.Font(subjectLabel, --[[Font]] PP.f.u67, 20, "outline", --[[Alpha]] nil, --[[Color]] nil, nil, nil, nil, --[[StyleColor]] 0, 0, 0, 0.5)
    end
    if attachLabel then
        PP.Font(attachLabel, --[[Font]] PP.f.u67, 16, "outline", --[[Alpha]] nil, --[[Color]] nil, nil, nil, nil, --[[StyleColor]] 0, 0, 0, 0.5)
    end
    if codLabel then
        PP.Font(codLabel, --[[Font]] PP.f.u67, 16, "outline", --[[Alpha]] nil, --[[Color]] nil, nil, nil, nil, --[[StyleColor]] 0, 0, 0, 0.5)
    end
    if postageLabel then
        PP.Font(postageLabel, --[[Font]] PP.f.u67, 16, "outline", --[[Alpha]] nil, --[[Color]] nil, nil, nil, nil, --[[StyleColor]] 0, 0, 0, 0.5)
    end
    if attachmentsHeader then
        PP.Font(attachmentsHeader, --[[Font]] PP.f.u67, 18, "outline", --[[Alpha]] nil, --[[Color]] nil, nil, nil, nil, --[[StyleColor]] 0, 0, 0, 0.5)
    end
end

-- Main mail scene group function
PP.mailSceneGroup = function ()
    local SV = PP.savedVars.ListStyle

    -- Edit Mail Inbox Scene
    Edit_MailInbox(SV)

    -- Edit Mail Send Scene
    Edit_MailSend()
end
