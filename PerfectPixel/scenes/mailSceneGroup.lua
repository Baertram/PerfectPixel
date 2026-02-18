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

-- Helper function to edit Mail Inbox scene
-- MAIL_INBOX object uses navigationTree (ZO_Tree) for both categories and mail entries
local function Edit_MailInbox(SV)
    local navigationTree = MAIL_INBOX.navigationTree -- ZO_Tree
    local navigationContainer = navigationTree.scrollControl

    -- Remove default fragments for clean UI
    removeFragmentsFromScene(MAIL_INBOX_SCENE, FRAGMENTS_TO_REMOVE)

    -- Create custom background and anchoring for main inbox window
    PP:CreateBackground(ZO_MailInbox, --[[#1]] nil, nil, nil, -10, -10, --[[#2]] nil, nil, nil, 0, 10)
    PP.Anchor(ZO_MailInbox, --[[#1]] TOPRIGHT, GuiRoot, TOPRIGHT, 0, 120, --[[#2]] true, BOTTOMRIGHT, GuiRoot, BOTTOMRIGHT, 0, -70)

    -- Reposition inbox elements
    PP.Anchor(ZO_MailInboxDeleteOnClaim, --[[#1]] BOTTOMLEFT, ZO_MailInboxInventoryUsage, TOPLEFT, 0, -4)
    PP.Anchor(ZO_MailInboxInventoryUsage, --[[#1]] BOTTOMLEFT, ZO_MailInbox, BOTTOMLEFT, 0, 4)
    PP.Anchor(navigationContainer, --[[#1]] TOPLEFT, ZO_MailInbox, TOPLEFT, 0, 90, --[[#2]] true, BOTTOMLEFT, ZO_MailInboxDeleteOnClaim, TOPLEFT, 0, 0)

    -- Apply custom scrollbar styling
    PP.ScrollBar(navigationContainer, --[[sb_c]] 180, 180, 180, 0.7, --[[bd_c]] 20, 20, 20, 0.7, false)
    ZO_Scroll_SetMaxFadeDistance(navigationContainer, SV.list_fade_distance)

    -- Hook into tree template setup to customize mail row controls
    local mailRowTemplate = navigationTree.templateInfo["ZO_MailInboxRow"]
    if mailRowTemplate then
        local existingSetupCallback = mailRowTemplate.setupFunction
        mailRowTemplate.setupFunction = function (node, control, mailData, open)
            existingSetupCallback(node, control, mailData, open)
        end

        -- Hook the pool factory to apply styling when controls are created
        local pool = mailRowTemplate.objectPool
        if pool then
            local existingFactory = pool.m_Factory
            pool.m_Factory = function (objectPool)
                local control = existingFactory(objectPool)

                -- Style the mail row control on creation
                control:SetHeight(SV.list_control_height)

                -- Clear default background texture
                local bg = control:GetNamedChild("BG")
                if bg then
                    bg:SetTexture("PerfectPixel/tex/tex_clear.dds")
                end

                -- Reposition and resize icon
                local icon = control:GetNamedChild("Icon")
                if icon then
                    PP.Anchor(icon, --[[#1]] LEFT, control, LEFT, 5, 0)
                    icon:SetDimensions(26, 26)
                    icon:SetDrawLayer(1)
                end

                -- Style subject label
                local subject = control:GetNamedChild("TextContainer"):GetNamedChild("Subject")
                if subject then
                    PP.Font(subject, --[[Font]] PP.f.u57, 16, "outline", --[[Alpha]] nil, --[[Color]] nil, nil, nil, nil, --[[StyleColor]] 0, 0, 0, .5)
                end

                return control
            end
        end
    end

    -- Mail rows use the existing HighlightControl/UnhighlightControl system
    -- No need to hook EnterRow/ExitRow - the tree handles it via Row_OnMouseEnter/Exit

    -- Style the message pane scrollbar (right side where you read mail)
    local messagePane = ZO_MailInboxMessagePane
    if messagePane then
        PP.ScrollBar(messagePane, --[[sb_c]] 180, 180, 180, 0.7, --[[bd_c]] 20, 20, 20, 0.7, false)
        ZO_Scroll_SetMaxFadeDistance(messagePane, SV.list_fade_distance)
    end

    -- Hide default message background textures for cleaner look
    local messageBGLeft = ZO_MailInboxMessageBGLeft
    local messageBGRight = ZO_MailInboxMessageBGRight
    if messageBGLeft then messageBGLeft:SetHidden(true) end
    if messageBGRight then messageBGRight:SetHidden(true) end

    -- Style message labels with custom fonts
    local messageFrom = ZO_MailInboxMessageFrom
    local messageSubject = ZO_MailInboxMessageSubject
    local messageBody = ZO_MailInboxMessageBody

    if messageFrom then
        PP.Font(messageFrom, --[[Font]] PP.f.u67, 18, "outline", --[[Alpha]] nil, --[[Color]] nil, nil, nil, nil, --[[StyleColor]] 0, 0, 0, 0.5)
    end
    if messageSubject then
        PP.Font(messageSubject, --[[Font]] PP.f.u67, 20, "outline", --[[Alpha]] nil, --[[Color]] nil, nil, nil, nil, --[[StyleColor]] 0, 0, 0, 0.5)
    end
    if messageBody then
        PP.Font(messageBody, --[[Font]] PP.f.u67, 16, "soft-shadow-thin", --[[Alpha]] nil, --[[Color]] nil, nil, nil, nil, --[[StyleColor]] 0, 0, 0, 0.5)
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
