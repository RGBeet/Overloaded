return {
    categories = {
        'Unfinished Content'
    },
    data = {
        object_type = "Joker",
        key     = 'road_work_ahead',
        atlas   = 'placeholder',
        pos     = MLIB.coords(0,0),
        rarity  = 'rgol_strange',
        cost    = 9,
        config = { suit = 'Spades' },
        loc_vars = function(self, info_queue, card)
            local suit = Madcap.Funcs.get_joker_suit(card, 'Spades')
            return MadLib.collect_vars_colours(
                localize(suit, 'suits_plural'),
                { G.C.SUITS[suit] })
        end,
        modify_joker_suit = function(self, card, target, cards)
            if 
                cards[1] ~= target
                or card.area ~= target.area 
            then
                return nil
            end
            return { 
                set_override = Overloaded.Funcs.get_vals(card, nil, 'suit', 'override_suit')
            }
        end,
        demicoloncompat = false,
    }
}
