return {
    categories = {
        'Elemental'
    },
    data = {
        object_type = 'Consumable',
        set     = "OverloadedElemental",
        key     = "fire",
        atlas   = "placeholder",
        pos     = MLIB.get_coords(0,0),
        cost    = 8,
        config  = { max_jokers = 1 },
        can_use = function(self, card)
            local selection =  MadLib.get_list_matches(MadLib.get_highlighted_cards(G.jokers), function(v)
                return v.ability.suit or v.ability.suits
            end)
            return #selection > 0 and #selection <= card.ability.max_jokers
        end,
        use = function(self, card, area, copier)
            local used_tarot = copier or card
            local selection =  MadLib.get_list_matches(MadLib.get_highlighted_cards(G.jokers), function(v)
                return v.ability.suit or v.ability.suits
            end)
            local suit = MadLib.get_random_suit_from_cards(G.playing_cards)

            MadLib.loop_func(selection, function(joker)
                if joker.ability.suit then -- TODO: check if compatible?
                    MadLib.event({
                        func = function()
                            joker.ability.override_suit = suit
                            print(joker.ability.override_suits)
                            used_tarot:juice_up(0.3, 0.5)
                            play_sound('rgol_modify_value')
                            return true
                        end
                    })
                elseif joker.ability.suits then
                    
                    MadLib.event({
                        func = function()
                            joker.ability.override_suits = { rank, nil }
                            for i=2,#joker.ability.ranks do
                                joker.ability.override_suits[i] = MadLib.get_random_suit_from_cards(G.playing_cards)
                            end
                            print(joker.ability.override_suits)
                            used_tarot:juice_up(0.3, 0.5)
                            play_sound('rgol_modify_value')
                            return true
                        end
                    })
                end
            end)
            used_tarot:juice_up(0.3, 0.5)
            delay(0.2)
        end
    }
}
