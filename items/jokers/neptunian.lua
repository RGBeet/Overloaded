return {
    categories = {
        'Unfinished Content'
    },
    data = {
        object_type = "Joker",
        key     = 'neptunian',
        atlas   = 'placeholder',
        pos     = MLIB.coords(0,0),
        rarity  = 'rgol_overclocked',
        cost    = 9,
        config = { type = 'Straight Flush' },
        loc_vars = function(self, info_queue, card)
            local poker_hand = Overloaded.Funcs.get_joker_hand(card, 'Straight Flush')
            local mult = MadLib.divide(G and G.GAME.hands['Straight Flush'].mult or 8, 2)
            local chips  = MadLib.divide(G and G.GAME.hands['Straight Flush'].chips or 100, 2.5)
            return MadLib.collect_vars(number_format(mult), number_format(chips), localize(Overloaded.Funcs.get_joker_hand(card, poker_hand), 'poker_hands'))
        end,
        calculate = function(self, card, context)
            if MadLib.has_contexts(context, 'other_card', 'ol_modifying_planet') then
                local planet    = context.other_card 
                local hand      = Overloaded.Funcs.get_joker_hand(card, 'Straight Flush')
                local mult      = MadLib.divide(G and G.GAME.hands[hand].mult or 8, 2)
                local chips     = MadLib.divide(G and G.GAME.hands[hand].chips or 100, 2.5)
                local level     = (G and G.GAME.hands[hand].level or 1)
                planet.ability.planet_chips   = MadLib.add(planet.ability.planet_chips or 0, MadLib.add(G.GAME.hands[hand].l_chips, chips))
                planet.ability.planet_mult    = MadLib.add(planet.ability.planet_mult or 0, MadLib.add(G.GAME.hands[hand].l_mult, mult))
                planet.overclock_cost         = MadLib.add(planet.overclock_cost, math.ceil(MadLib.multiply(level, 0.25)))
                planet:set_cost()
                return {
                    message = "!",
                    card    = planet,
                    sound   = 'rgol_modify_value'
                }
            end
        end,
        demicoloncompat = false,
    }
}
