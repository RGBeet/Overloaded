return {
    categories = {
        'Unfinished Content'
    },
    data = {
        object_type = "Joker",
        key     = 'tiebreaker',
        atlas   = 'placeholder',
        pos     = MLIB.coords(0,0),
        rarity  = 'rgol_strange',
        cost    = 9,
        config = { extra = 1 },
        loc_vars = function(self, info_queue, card)
            return MadLib.collect_vars(card.ability.extra)
        end,
        demicoloncompat = false,
    }
}
