return {
    categories = {
        'Unfinished Content'
    },
    data = {
        object_type = "Joker",
        key     = 'bonfire',
        atlas   = 'placeholder',
        pos     = MLIB.coords(0,0),
        rarity  = 'rgol_strange',
        cost    = 9,
        config = { },
        loc_vars = function(self, info_queue, card)
            local active = MadLib.list_matches_one(G.jokers.cards, function(v)
                return Overloaded.Funcs.can_modify_poker_hand(v)
            end)
            print(active and "ACTIVE!" or "INACTIVE")
            return nil
        end,
        calculate = function(self, card, context)

            if
                context.setting_blind
                and MadLib.list_matches_one(G.jokers.cards, function(v)
                    return Overloaded.Funcs.can_modify_poker_hand(v)
                end)
            then
                local eval = function(card) return G.GAME.current_round.discards_used > 0 and not G.RESET_JIGGLES end
                juice_card_until(card, eval, true)
            end

            if
                context.pre_discard
                and G.GAME.current_round.discards_used <= 0
                and not context.hook
            then
                local text, _ = G.FUNCS.get_poker_hand_info(G.hand.highlighted)
                local matches = MadLib.get_list_matches(G.jokers.cards, function(v)
                    return v ~= card and Overloaded.Funcs.can_modify_poker_hand(v)
                end)
                if #matches == 0 then return end
                local target = pseudorandom_element(matches, pseudoseed('bonfire'))
                if target.ability.type or target.ability.poker_hand or target.ability.extra.poker_hand then
                    MadLib.event({
                        func = function()
                            target.ability.override_poker_hand = text
                            target:juice_up(0.3, 0.5)
                            play_sound('rgol_modify_value')
                            return true
                        end
                    })
                elseif target.ability.poker_hands or target.ability.extra.poker_hands then
                    MadLib.event({
                        func = function()
                            target.ability.override_poker_hands[1] = text
                            target:juice_up(0.3, 0.5)
                            play_sound('rgol_modify_value')
                            return true
                        end
                    })
                end
            end
        end,
        demicoloncompat = false,
    }
}
