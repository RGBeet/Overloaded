return {
    categories = {
        'Unfinished Content'
    },
    data = {
        object_type = "Joker",
        key     = 'crazy_eights',
        atlas   = 'placeholder',
        pos     = MLIB.coords(0,0),
        rarity  = 'rgol_strange',
	    blueprint_compat = false,
        cost    = 9,
        config = { rank = '8', enhancement = 'm_wild' },
        loc_vars = function(self, info_queue, card)
            return MadLib.collect_vars(
                G.localization.descriptions['Enhanced'][card.ability.enhancement or 'm_wild'].name .. 's', -- name
                MadLib.get_rank_locvar(card, card.ability.rank or '8'))
        end,
        modify_playing_card_rank = function(self, card, scored_card, ranks)
            if SMODS.has_enhancement(scored_card, card.ability.enhancement or 'm_wild') then
                return { add_rank = card.ability.rank or '8' }
            end
        end,
        demicoloncompat = false,
    }
}
