return {
    categories = {
        'Unfinished Content'
    },
    data = {
        object_type = "Joker",
        key     = 'stairway_to_heaven',
        atlas   = 'placeholder',
        pos     = MLIB.coords(0,0),
        rarity  = 'rgol_strange',
        cost    = 9,
        config = { },
        loc_vars = function(self, info_queue, card)
        end,
        modify_playing_card_rank = function(self, card, scored_card, ranks)
            local old_ranks = MadLib.deep_copy(ranks)
            local new_ranks = {}
            for _,v in pairs(old_ranks) do
                new_ranks[#new_ranks+1] = Overloaded.Funcs.get_strength_effect(tostring(v), 1)
            end
            return { 
                remove_ranks = old_ranks,
                add_ranks = new_ranks
            }
        end,
        demicoloncompat = false,
    }
}
