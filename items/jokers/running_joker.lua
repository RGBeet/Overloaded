return {
    categories = {
        'Unfinished Content'
    },
    data = {
        object_type = "Joker",
        key     = 'running_joker',
        atlas   = 'placeholder',
        pos     = MLIB.coords(0,0),
        rarity  = 'rgol_strange',
        cost    = 6,
        config = { extra = { rarity = 1, a_mod = 4 } },
        demicoloncompat = false,
        loc_vars = function(self, info_queue, card)
            local matches = MadLib.loop_func((card.area or G.jokers).cards, function(v)
                return Overloaded.Funcs.get_rarity(v) == card.ability.extra.rarity
            end)
            return MadLib.collect_vars_colours(card.ability.extra.a_mod,
                Overloaded.Funcs.get_rarity_localization(card.ability.extra.rarity or 1),
                number_format(MadLib.multiply(card.ability.extra.a_mod, matches)),
                { G.C.RARITY[card.ability.extra.rarity or 1] })
        end,
        modify_individual_effect = function(self, card, key, scored_card)
            if Overloaded.Lists.MultModKeys[key] then -- is a mult value
                if not (key == 'mult' or key == 'h_mult' or key == 'mult_mod') then return {} end -- don't do x_mult
                local matches = MadLib.loop_func((card.area or G.jokers).cards, function(v)
                    return Overloaded.Funcs.get_rarity(v) == card.ability.extra.rarity
                end)
                if matches > 0 then
                    return {
                        a_mod   = MadLib.multiply(card.ability.extra.a_mod, matches),
                        type    = 'mult',
                        card    = card,
                        colour  = G.C.MULT
                    }
                end
            end
        end,
    }
}
