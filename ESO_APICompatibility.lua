if not PP then PP = {} end

--Compatibility for API version < 101033 High Isle
local quickSlotbaseRefNew = QUICKSLOT_KEYBOARD
local quickSlotRef = 		(quickSlotbaseRefNew ~= nil and quickSlotbaseRefNew.control) or ZO_QuickSlot
PP.quickslotData = {
	quickSlotControl = 				quickSlotRef,
	quickslotListControl = 			(quickSlotbaseRefNew ~= nil and quickSlotbaseRefNew.list) or ZO_QuickSlotList,
	quickSlotTabsControl = 			(quickSlotbaseRefNew ~= nil and quickSlotbaseRefNew.tabs) or ZO_QuickSlotTabs,
	quickSlotInfoBarControl =		(quickSlotbaseRefNew ~= nil and GetControl(quickSlotRef, "InfoBar")) or ZO_QuickSlotInfoBar,
	quickSlotFilterDividerControl =	(quickSlotbaseRefNew ~= nil and GetControl(quickSlotRef, "FilterDivider")) or ZO_QuickSlotFilterDivider
}
