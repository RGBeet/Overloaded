return {
    categories = {
        'Unfinished Content'
    },
    data = {
        object_type = "Joker",
        key     = 'ladybird',
        atlas   = 'placeholder',
        pos     = MLIB.coords(0,0),
        rarity  = 'rgol_overclocked',
        cost    = 9,
        config = { extra = { odds = 2, x_mod = 2 } },
        loc_vars = function(self, info_queue, card)
            local name = "Lucky" -- add actual localization
            return MadLib.collect_vars(name, card.ability.extra.x_mod)
        end,
        modify_individual_effect = function(self, card, key, scored_card)
            if SMODS.has_enhancement(scored_card, 'm_lucky') then
                if Overloaded.Lists.ChipModKeys[key] then
                    return {
                        x_mod   = card.ability.extra.x_mod,
                        type    = 'chips',
                        card    = card,
                        colour  = G.C.CHIPS
                    }
                elseif Overloaded.Lists.MultModKeys[key] then
                    return {
                        x_mod   = card.ability.extra.x_mod,
                        type    = 'mult',
                        card    = card,
                        colour  = G.C.MULT
                    }
                elseif Overloaded.Lists.MoneyModKeys[key] then
                    return {
                        x_mod   = card.ability.extra.x_mod,
                        type    = 'money',
                        card    = card,
                        colour  = G.C.MONEY
                    }
                end
            end
        end,
    }
}
