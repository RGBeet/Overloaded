G.C.RGOL_OVERCLOCKED    = HEX('CFFF04')
G.C.RGOL_STRANGE        = HEX('DB810B')

-- Rarities
SMODS.Rarity{
    key = "strange",
    badge_colour = G.C.RGOL_STRANGE,
    polls = { ["Joker"] = { rate = (1/8) } },
}

SMODS.Rarity{
    key = "overclocked",
    badge_colour = G.C.RGOL_OVERCLOCKED,
	badge_text_colour = HEX('1E2729'),
    polls = { ["Joker"] = { rate = (1/32) } },
}