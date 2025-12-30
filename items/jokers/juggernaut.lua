return {
    categories = {
        'Unfinished Content'
    },
    data = {
        object_type = "Joker",
        key     = 'juggernaut',
        atlas   = 'placeholder',
        pos     = MLIB.coords(0,0),
        rarity  = 'rgol_strange',
        cost    = 9,
        config = { },
        demicoloncompat = false,
        modify_individual_effect = function(self, card, key, scored_card)
            if Overloaded.Lists.MultModKeys[key] then -- is a chip value
                return {
                    upgrade = 'mult',
                    card    = card,
                    colour  = G.C.MULT
                }
            end
        end,
    }
}
