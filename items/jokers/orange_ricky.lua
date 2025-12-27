return {
    categories = {
        'Unfinished Content'
    },
    data = {
        object_type = "Joker",
        key     = 'orange_ricky',
        atlas   = 'placeholder',
        pos     = MLIB.coords(0,0),
        rarity  = 'rgol_strange',
        cost    = 9,
        config = { rank = '4', suit = 'Diamonds' },
        loc_vars = function(self, info_queue, card)
            local suit = Madcap.Funcs.get_joker_suit(card, 'Diamonds')
            return MadLib.collect_vars_colours(
                localize(suit, 'suits_plural'),
                MadLib.get_rank_locvar(card, card.ability.rank or '4'),
                { G.C.SUITS[suit] })
        end,
        modify_playing_card_rank = function(self, card, scored_card, ranks)
            if scored_card:is_suit(Madcap.Funcs.get_joker_suit(card, 'Diamonds')) then
                return { add_rank = card.ability.rank or '4' }
            end
        end,
    }
}
