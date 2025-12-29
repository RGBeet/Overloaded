return {
    categories = {
        'Unfinished Content'
    },
    data = {
        object_type = "Joker",
        key     = 'quasicolon',
        atlas   = 'placeholder',
        pos     = MLIB.coords(0,0),
        rarity  = 'rgol_overclocked',
        cost    = 20,
        config = { },
	    blueprint_compat = true,
        loc_vars = function(self, info_queue, card)
            card.ability.quasi_compat_ui = card.ability.quasi_compat_ui or ""
            card.ability.quasi_compat_check = nil
            --local check = card.ability.check
            return {
                main_end = (card.area and card.area == G.jokers)
                        and {
                            {
                                n = G.UIT.C,
                                config = { align = "bm", minh = 0.4 },
                                nodes = {
                                    {
                                        n = G.UIT.C,
                                        config = {
                                            ref_table = card,
                                            align = "m",
                                            -- colour = (check and G.C.cry_epic or G.C.JOKER_GREY),
                                            colour = card.ability.colour,
                                            r = 0.05,
                                            padding = 0.08,
                                            func = "blueprint_compat",
                                        },
                                        nodes = {
                                            {
                                                n = G.UIT.T,
                                                config = {
                                                    ref_table = card.ability,
                                                    ref_value = "quasi_text",
                                                    colour = G.C.UI.TEXT_LIGHT,
                                                    scale = 0.32 * 0.8,
                                                },
                                            },
                                        },
                                    },
                                },
                            },
                        }
                    or nil,
            }
        end,
        update = function(self, card, front)
            local other_joker = nil
            local jokers = card.area or G.jokers
            if G.STAGE == G.STAGES.RUN then
                for i = 1, #jokers.cards do
                    if jokers.cards[i] == card then
                        other_joker = Overloaded.Funcs.quasi_handle_blueprint(jokers.cards[i+1], jokers.cards)
                    end
                end
                if
                    other_joker
                    and (other_joker.config.center.quasicolon_compat
                    or MadLib.list_matches_one(Overloaded.Lists.QuasicolonVanilla, function(v) return other_joker.config.center.key == 'j_'..v end))
                then
				    card.ability.quasi_text = "YES"
				    card.ability.check      = true
				    card.ability.colour = G.C.GREEN
                else
				    card.ability.quasi_text = "NO"
				    card.ability.check      = false
				    card.ability.colour = G.C.RED
                end
            end
        end,
        calculate = function(self, card, context)
            if not context.blueprint then
                local pass = false
                local index = 0
                local jokers = card.area or G.jokers
                for i = 2, (#jokers.cards)-1 do
                    if jokers.cards[i] == card then
                        index = i+1
                        local left_card = Overloaded.Funcs.quasi_handle_blueprint(jokers.cards[i-1], jokers.cards)
                        pass = Overloaded.Funcs.quasi_check(left_card, jokers.cards, context)
                    end
                end
                if pass and index ~= 0 then
                    local right_card = Overloaded.Funcs.quasi_handle_blueprint(jokers.cards[index], jokers.cards, nil, true)
                    local result = Overloaded.Funcs.quasi_trigger(right_card, jokers.cards, context)
                    return result
                end
            end
        end,
        demicoloncompat = false,
    }
}
