local PP = PP ---@class PP

PP.challengeDifficultyScene = function()
	local tlc = ZO_ChallengeDifficultyScreen_KeyboardTL
	if not tlc then
		local keyboard = ZO_CHALLENGE_DIFFICULTY_KEYBOARD
		if keyboard and keyboard.control then
			tlc = keyboard.control
		end
	end
	if not tlc then
		return
	end

	-- PP backdrop only; do not use Claim/Upcoming bottom stretch (those panels re-anchor scroll lists).
	-- Stretching this TL separates top content from MainSectionDivider / effects anchored to the bottom.
	PP:CreateBackground(tlc, --[[#1]] nil, nil, nil, -1, 0, --[[#2]] nil, nil, nil, -10, 24 )
	PP.Anchor(tlc, --[[#1]] TOPLEFT, nil, TOPLEFT, 0, 90 )
	local width = ZO_CHALLENGE_DIFFICULTY_KEYBOARD_SCREEN_WIDTH or 500
	local baseHeight = ZO_CHALLENGE_DIFFICULTY_KEYBOARD_SCREEN_HEIGHT or 475
	local extraBottomPadding = 36
	tlc:SetDimensions(width, baseHeight + extraBottomPadding)

	if ZO_ChallengeDifficultyScreen_KeyboardTLBG then
		ZO_ChallengeDifficultyScreen_KeyboardTLBG:SetHidden(true)
	end
	if ZO_ChallengeDifficultyScreen_KeyboardTLTitleDivider then
		ZO_ChallengeDifficultyScreen_KeyboardTLTitleDivider:SetHidden(true)
	end
end
