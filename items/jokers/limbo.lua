return {
    categories = {
        'Unfinished Content'
    },
    data = {
        object_type = "Joker",
        key     = 'limbo',
        atlas   = 'placeholder',
        pos     = MLIB.coords(0,0),
        rarity  = 'rgol_strange',
        cost    = 9,
        config = { },
        add_to_deck = function(self, card, from_debuff)
            G.GAME.low_card_active = true
        end,
        remove_from_deck = function(self, card, from_debuff)
            G.GAME.low_card_active = (#SMODS.find_card('rgol_limbo', true) > 0)
        end,
        demicoloncompat = false,
    }
}
