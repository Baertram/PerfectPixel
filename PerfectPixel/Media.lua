local PP = PP ---@class PP
local media		= PP.media
local tinsert	= table.insert

--media.textures
local textures = media.textures

tinsert(textures, { name = "Clear",						item = "PerfectPixel/tex/tex_clear.dds"		})
tinsert(textures, { name = "Clean",						item = "PerfectPixel/tex/tex_white.dds"		})
tinsert(textures, { name = "Oblique line \n 8x8",		item = "PerfectPixel/tex/bg_line.dds"		})
tinsert(textures, { name = "Dots \n 8x8",				item = "PerfectPixel/tex/bg_dots.dds"		})
--

--media.edges
local edges = media.edges

tinsert(edges, { name = "Clear",					item = "PerfectPixel/tex/tex_clear.dds"					})
tinsert(edges, { name = "Clean",					item = "PerfectPixel/tex/tex_white.dds"					})
tinsert(edges, { name = "Outer shadow \n 64x8",		item = "PerfectPixel/tex/edge_outer_shadow_64x8.dds"	})
tinsert(edges, { name = "Outer shadow\n 128x16",	item = "PerfectPixel/tex/edge_outer_shadow_128x16.dds"	})
tinsert(edges, { name = "Soft shadow \n 128x16",	item = "PerfectPixel/tex/edge_soft_shadow_128x16.dds"	})
tinsert(edges, { name = "Px1 shadow \n 128x16",		item = "PerfectPixel/tex/edge_p1_shadow_128x16.dds"		})
tinsert(edges, { name = "Px2 shadow \n 128x16",		item = "PerfectPixel/tex/edge_p2_shadow_128x16.dds"		})
--

--media.fonts
local fonts = media.fonts

tinsert(fonts, { name = "Univers 57",			item = "$(PP_MEDIUM_FONT)"			})
tinsert(fonts, { name = "Univers 67",			item = "$(PP_BOLD_FONT)"			})
tinsert(fonts, { name = "Prose Antique PSMT",	item = "$(PP_ANTIQUE_FONT)"		})
tinsert(fonts, { name = "Trajanpro Regular",	item = "$(PP_STONE_TABLET_FONT)"	})
tinsert(fonts, { name = "Handwritten Bold",		item = "$(PP_HANDWRITTEN_FONT)"	})
tinsert(fonts, { name = "Gamepad Light",		item = "$(PP_GAMEPAD_LIGHT_FONT)"	})
tinsert(fonts, { name = "Gamepad Medium",		item = "$(PP_GAMEPAD_MEDIUM_FONT)"	})
tinsert(fonts, { name = "Gamepad Bold",			item = "$(PP_GAMEPAD_BOLD_FONT)"	})
--

PP.f = {			--[[	Fonts		]]
	u57			=	"$(PP_MEDIUM_FONT)",
	u67			=	"$(PP_BOLD_FONT)",
}
