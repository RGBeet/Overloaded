return {
    categories = {
        'Unfinished Content'
    },
    data = {
        object_type = "Joker",
        key     = 'card_shark',
        atlas   = 'placeholder',
        pos     = MLIB.coords(0,0),
        rarity  = 'rgol_strange',
        cost    = 8,
        config = { x_mod = 0.01 },
        demicoloncompat = false,
        loc_vars = function(self, info_queue, card)
            return MadLib.collect_vars(number_format(card.ability.x_mod),
                number_format(MadLib.multiply(#(G.playing_cards or {}), card.ability.x_mod)))
        end,
        modify_individual_effect = function(self, card, key, scored_card)
            if Overloaded.Lists.ChipModKeys[key] then -- is a chip value
                local cards = #(G.playing_cards or {})
                if cards > 0 then
                    return {
                        a_mod   = MadLib.multiply(card.ability.x_mod, cards),
                        type    = 'chips',
                        card    = card,
                        colour  = G.C.CHIPS
                    }
                end
            end
        end,
    }
}
