return {
    categories = {
        'Boosters',
    },
    data = {
        object_type = 'Booster',
        key     = "strange_mk1",
        weight  = 0.12,
        kind    = 'Variety',
        cost    = 12,
        atlas   = 'placeholder',
        pos     = MLIB.coords(0,0),
        config      = { extra = 3, choose = 1 },
        group_key   = 'k_rgol_strange_pack',
        draw_hand   = false,
        loc_vars = function(self, info_queue, card)
            local cfg = (card and card.ability) or self.config
            return MadLib.collect_vars(cfg.choose, cfg.extra)
        end,
        ease_background_colour = function(self)
            local c1 = darken(G.C.RARITY.rgol_strange,0.5)
            local c2 = darken(G.C.RARITY.rgol_overclocked,0.7)
            ease_colour(G.C.DYN_UI.MAIN, c1)
            ease_background_colour{new_colour = c1, special_colour = c2, contrast = 2}
        end,
        particles = function(self)
            local c1 = G.C.RARITY.rgol_strange
            local c2 = G.C.RARITY.rgol_overclocked
            G.booster_pack_sparkles = Particles(1, 1, 0, 0, {
                timer = 0.015,
                scale = 0.2,
                initialize = true,
                lifespan = 1,
                speed = 1.1,
                padding = -1,
                attach = G.ROOM_ATTACH,
                colours = { G.C.WHITE, lighten(c1, 0.4), lighten(c2, 0.2), lighten(c1, 0.2) },
                fill = true
            })
            G.booster_pack_sparkles.fade_alpha = 1
            G.booster_pack_sparkles:fade(1, 0)
        end,
		create_card = function(self, card, i)
            return Overloaded.Funcs.create_joker_strange(G.pack_cards)
		end,
    }
}
