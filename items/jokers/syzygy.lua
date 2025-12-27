return {
    categories = {
        'Unfinished Content'
    },
    data = {
        object_type = "Joker",
        key     = 'syzygy',
        atlas   = 'placeholder',
        pos     = MLIB.coords(0,0),
        rarity  = 'rgol_strange',
        cost    = 9,
        config = { extra = { odds = 4, x_mult = 2 } },
        loc_vars = function(self, info_queue, card)
            local _numer, _denom = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'syzygy')
            return MadLib.collect_vars(math.max(0,number_format(_numer)), number_format(_denom), card.ability.extra.x_mult)
        end,
        calculate = function(self, card, context)
            if 
                MadLib.has_contexts(context, 'other_card', 'ol_modifying_planet')
                and SMODS.pseudorandom_probability(card, 'syzygy', 1, card.ability.extra.odds)
            then
                local planet    = context.other_card 
                local hand      = planet.ability.hand_type
                planet.ability.planet_chips   = MadLib.multiply(G.GAME.hands[hand].l_chips, card.ability.extra.x_mult)
                planet.ability.planet_mult    = MadLib.multiply(G.GAME.hands[hand].l_mult, card.ability.extra.x_mult)
                return {
                    message = "!",
                    card    = planet,
                    sound   = 'rgol_modify_value'
                }
            end
        end,
    }
}
