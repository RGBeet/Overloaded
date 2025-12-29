return {
    categories = {
        'Unfinished Content'
    },
    data = {
        object_type = "Joker",
        key     = 'blockchain',
        atlas   = 'placeholder',
        pos     = MLIB.coords(0,0),
        rarity  = 'rgol_overclocked',
	    blueprint_compat = false,
        cost    = 9,
        config = { extra = { xchip_mod = 0.05, dollars = 7 } },
        loc_vars = function(self, info_queue, card)
            return MadLib.collect_vars(number_format(card.ability.extra.xchip_mod),
                number_format(card.ability.extra.dollars),
                number_format(Overloaded.Funcs.get_bootstrap_calc(card.ability.extra.xchip_mod, card.ability.extra.dollars)))
        end,
        modify_individual_effect = function(self, card, key, scored_card)
            if Overloaded.Lists.ChipModKeys[key] then -- is a chip value
                return {
                    x_mod   = Overloaded.Funcs.get_bootstrap_calc(card.ability.extra.xchip_mod, card.ability.extra.dollars),
                    type    = 'chips',
                    card    = card,
                    colour  = G.C.CHIPS
                }
            end
        end,
        demicoloncompat = false,
    }
}
