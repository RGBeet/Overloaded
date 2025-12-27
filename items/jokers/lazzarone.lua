return {
    categories = {
        'Unfinished Content'
    },
    data = {
        object_type = "Joker",
        key     = 'lazzarone',
        atlas   = 'placeholder',
        pos     = MLIB.coords(0,0),
        rarity  = 'rgol_strange',
        cost    = 12,
        config = { extra = { odds = 5, rarity = 3 } },
        loc_vars = function(self, info_queue, card)
            local _numer, _denom = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'lazzarone')
            return MadLib.collect_vars_colours(math.max(0,number_format(_numer)),
                number_format(_denom), 
                Overloaded.Funcs.get_rarity_localization(card.ability.extra.rarity or 3),
                { G.C.RARITY[card.ability.extra.rarity or 3] })
        end,
        calculate = function(self, card, context)
            if 
                MadLib.has_contexts(context, 'other_card', 'ol_modifying_joker')
                and SMODS.pseudorandom_probability(card, 'lazzarone', 1, card.ability.extra.odds)
                and context.other_card:get_rarity() ~= (card.ability.extra.rarity or 3)
            then
                local joker    = context.other_card
                if Overloaded.Funcs.set_joker_rarity(context.other_card, 3) then
                    return {
                        message = "!",
                        card    = joker,
                        sound   = 'rgol_modify_value'
                    }
                else
                    return {
                        message = 'X',
                        colour = G.C.RED
                    }
                end
            end
        end,
    }
}
