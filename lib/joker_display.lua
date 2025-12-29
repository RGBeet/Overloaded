if JokerDisplay then
    local jod = JokerDisplay.Definitions
    
    -- Hack
    jod['j_hack'].reminder_text = { { text = "(<=5)" } }
    jod['j_hack'].retrigger_function = function(playing_card, scoring_hand, held_in_hand, joker_card)
        if held_in_hand then return 0 end
        return MadLib.list_matches_one(Overloaded.Lists.Hack, function(v) return MadLib.is_rank(playing_card, v) end)
            and MadLib.multiply(joker_card.ability.extra, JokerDisplay.calculate_joker_triggers(joker_card)) or 0
    end

    -- Fibonacci
    jod['j_fibonacci'].calc_function = function(card)
        local mult = 0
        local text, _, scoring_hand = JokerDisplay.evaluate_hand()
        if text ~= 'Unknown' then
            for _, scoring_card in pairs(scoring_hand) do
                mult = MadLib.has_fib_rank(scoring_card)
                    and MadLib.add(mult, MadLib.multiply(MadLib.is_base_rank(card) 
                        and card.ability.extra.mult 
                        or card.ability.extra.mult2, JokerDisplay.calculate_card_triggers(scoring_card, scoring_hand)))
                    or mult
            end
        end
        card.joker_display_values.mult = mult
        card.joker_display_values.localized_text = "(" .. localize("Ace", "ranks") .. ",2,3,5,8)"
    end

    -- Odd Todd
    jod['j_odd_todd'].calc_function = function(card)
        local chips = 0
        local text, _, scoring_hand = JokerDisplay.evaluate_hand()
        if text ~= 'Unknown' then
            for _, scoring_card in pairs(scoring_hand) do
                chips = MadLib.has_odd_rank(scoring_card)
                    and MadLib.add(chips, MadLib.multiply(card.ability.extra, JokerDisplay.calculate_card_triggers(scoring_card, scoring_hand)))
                    or chips
            end
        end
        card.joker_display_values.chips = chips
        card.joker_display_values.localized_text = "(" .. localize("Ace", "ranks") .. ",9,7,5,3)"
    end

    -- Even Steven
    jod['j_even_steven'].reminder_text = { ref_table = "card.joker_display_values", ref_value = "localized_text" }
    jod['j_even_steven'].calc_function = function(card)
        local mult = 0
        local text, _, scoring_hand = JokerDisplay.evaluate_hand()
        if text ~= 'Unknown' then
            for _, scoring_card in pairs(scoring_hand) do
                mult = MadLib.has_even_rank(scoring_card)
                    and MadLib.add(mult, MadLib.multiply(card.ability.extra, JokerDisplay.calculate_card_triggers(scoring_card, scoring_hand)))
                    or mult
            end
        end
        card.joker_display_values.mult = mult
        card.joker_display_values.localized_text = "(10,8,6,4,2)"
    end

    -- 8-Ball
    jod['j_8_ball'].calc_function = function(card)
        local count = 0
        local text, _, scoring_hand = JokerDisplay.evaluate_hand()
        
        if text ~= 'Unknown' then
            for _, scoring_card in pairs(scoring_hand) do
                if MadLib.joker_check_rank(scoring_card, card, '8') then
                    count = MadLib.add(count, JokerDisplay.calculate_card_triggers(scoring_card, scoring_hand))
                end
            end
        end
        card.joker_display_values.count = count
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra, '8_ball')
        card.joker_display_values.odds = localize { type = 'variable', key = "jdis_odds", vars = { numerator, denominator } }
    end

    -- Scholar
    jod['j_scholar'].calc_function = function(card)
        local chips, mult = 0, 0
        local text, _, scoring_hand = JokerDisplay.evaluate_hand()
        if text ~= 'Unknown' then
            for _, scoring_card in pairs(scoring_hand) do
                if MadLib.joker_check_rank(scoring_card, card, 'Ace') then
                    local retriggers = JokerDisplay.calculate_card_triggers(scoring_card, scoring_hand)
                    chips   = MadLib.add(chips, MadLib.multiply(card.ability.extra.chips, retriggers))
                    mult    = MadLib.add(mult, MadLib.multiply(card.ability.extra.mult, retriggers))
                end
            end
        end
        card.joker_display_values.mult  = mult
        card.joker_display_values.chips = chips
        card.joker_display_values.localized_text = "(" .. localize(card.ability.rank or "Ace", "ranks") .. ")"
    end

    -- Sixth Sense
    jod['j_sixth_sense'].calc_function = function(card)
        local _, _, scoring_hand = JokerDisplay.evaluate_hand()
        local sixth_sense_eval = #scoring_hand == 1 and MadLib.joker_check_rank(scoring_hand[1], card, '6')
        card.joker_display_values.active = G.GAME and G.GAME.current_round.hands_played == 0
        card.joker_display_values.count = sixth_sense_eval and 1 or 0
    end

    -- Superposition
    jod['j_superposition'].calc_function = function(card)
        local is_superposition = false
        local _, poker_hands, scoring_hand = JokerDisplay.evaluate_hand()
        if 
            poker_hands[card.ability.type or 'Straight']
            and next(poker_hands[card.ability.type or 'Straight'])
        then
            for _, scoring_card in pairs(scoring_hand) do
                if MadLib.joker_check_rank(scoring_card, card, card.ability.rank or 'Ace') then
                    is_superposition = true
                end
            end
        end
        card.joker_display_values.count = is_superposition and 1 or 0
        card.joker_display_values.localized_text_straight = localize(card.ability.type or 'Straight', "poker_hands")
        card.joker_display_values.localized_text_ace = localize(card.ability.rank or "Ace", "ranks")
    end

    -- Baron
    jod['j_baron'].calc_function = function(card)
        local playing_hand = next(G.play.cards)
        local count = 0
        for _, playing_card in ipairs(G.hand.cards) do
            if playing_hand or not playing_card.highlighted then
                if 
                    MadLib.JokerDisplay.valid_card(playing_card)
                    and MadLib.joker_check_rank(playing_card, card, card.ability.rank or 'King')
                then
                    count = MadLib.add(count, JokerDisplay.calculate_card_triggers(playing_card, nil, true))
                end
            end
        end
        card.joker_display_values.x_mult = MadLib.exponent(card.ability.extra, count)
    end

    -- Cloud 9
    jod['j_cloud_9'].calc_function = function(card)
        local nines = MadLib.get_card_count(G.playing_cards, function(v)
            return MadLib.joker_check_rank(v, card, card.ability.rank or '9')
        end)
        card.joker_display_values.dollars = MadLib.multiply(card.ability.extra, nines)
        card.joker_display_values.localized_text = "(" .. localize("k_round") .. ")"
    end

    -- Mail-In Rebate
    jod['j_mail'].calc_function = function(card)
        local dollars = 0
        local hand = G.hand.highlighted
        for _, playing_card in pairs(hand) do
            if 
                MadLib.JokerDisplay.valid_card(playing_card)
                and G.GAME.current_round.mail_card.id
            then
                dollars = MadLib.add(dollars, card.ability.extra)
            end
        end
        card.joker_display_values.dollars           = G.GAME.current_round.discards_left > 0 and dollars or 0
        card.joker_display_values.mail_card_rank    = localize(G.GAME.current_round.mail_card.rank, 'ranks')
    end

    -- Walkie Talkie
    jod['j_walkie_talkie'].reminder_text = { ref_table = "card.joker_display_values", ref_value = "localized_text" }
    jod['j_walkie_talkie'].calc_function = function(card)
        local chips, mult = 0, 0
        local text, _, scoring_hand = JokerDisplay.evaluate_hand()
        if text ~= 'Unknown' then
            for _, scoring_card in pairs(scoring_hand) do
                 if MadLib.list_matches_one(card.ability.ranks, function(v)
                    return MadLib.is_rank(scoring_card, v)
                end) then
                    local retriggers = JokerDisplay.calculate_card_triggers(scoring_card, scoring_hand)
                    chips   = MadLib.add(chips, MadLib.multiply(card.ability.extra.chips, retriggers))
                    mult    = MadLib.add(mult, MadLib.multiply(card.ability.extra.mult, retriggers))
                end
            end
        end
        card.joker_display_values.chips             = chips
        card.joker_display_values.mult              = mult
        card.joker_display_values.localized_text    = '(' .. localize(card.ability.ranks[1], 'ranks') .. ', ' .. localize(card.ability.ranks[1], 'ranks') .. ')'
    end

    --[[ The Idol
    jod['j_idol'].calc_function = function(card)
        local count = 0
        local text, _, scoring_hand = JokerDisplay.evaluate_hand()
        if text ~= 'Unknown' then
            for _, scoring_card in pairs(scoring_hand) do
                if MadLib.is_rank_and_suit(scoring_card, G.GAME.current_round.vremade_idol_card.id, G.GAME.current_round.idol_card.suit) then
                    count = count + JokerDisplay.calculate_card_triggers(scoring_card, scoring_hand)
                end
            end
        end
        card.joker_display_values.x_mult = MadLib.exponent(card.ability.extra, count)
        card.joker_display_values.idol_card = localize { type = 'variable', key = "jdis_rank_of_suit", vars = { localize(G.GAME.current_round.idol_card.rank, 'ranks'), localize(G.GAME.current_round.idol_card.suit, 'suits_plural') } }
    end]]

    -- Shoot the Moon
     jod['j_shoot_the_moon'].calc_function = function(card)
        local playing_hand = next(G.play.cards)
        local mult = 0
        
        for _, playing_card in ipairs(G.hand.cards) do
            if playing_hand or not playing_card.highlighted then
                if 
                    MadLib.JokerDisplay.valid_card(playing_card) 
                    and Overloaded.Funcs.joker_check_rank(playing_card, card, 'Queen')
                then
                    mult = MadLib.add(mult, MadLib.multiply(card.ability.extra, JokerDisplay.calculate_card_triggers(playing_card, nil, true)))
                end
            end
        end
        card.joker_display_values.mult = mult
    end

    -- Triboulet
    jod['j_triboulet'].calc_function = function(card)
        local count = 0
        local text, _, scoring_hand = JokerDisplay.evaluate_hand()
        if text ~= 'Unknown' then
            for _, scoring_card in pairs(scoring_hand) do
                if MadLib.list_matches_one(card.ability.ranks, function(v)
                    return MadLib.is_rank(scoring_card, v)
                end) then
                    count = count + JokerDisplay.calculate_card_triggers(scoring_card, scoring_hand)
                end
            end
        end
        card.joker_display_values.x_mult = MadLib.exponent(card.ability.extra, count)
        card.joker_display_values.localized_text_king   = localize(card.ability.ranks[1], "ranks")
        card.joker_display_values.localized_text_queen  = localize(card.ability.ranks[2], "ranks")
    end
end