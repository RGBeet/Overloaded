Overloaded.Lists.QuasicolonVanilla = {
    'joker',
    'jolly',
    'zany',
    'mad',
    'crazy',
    'droll',
    'sly',
    'wily',
    'clever',
    'devious',
    'crafty',
    'half',
    'fortune_teller',
    'juggler',
    'drunkard',
    'stone',
    'golden',
    'stencil',
    --'four_fingers',
    'mime',
    'credit_card',
    'greedy_joker',
    'lusty_joker',
    'wrathful_joker',
    'gluttonous_joker',
    'ceremonial',
    'banner',
    'mystic_summit',
    'marble',
    'loyalty_card',
    '8_ball',
    'dusk',
    'chaos',
    'misprint',
    'raised_fist',
    'fibonacci',
    'steel_joker',
    'scary_face',
    'abstract',
    'delayed_grat',
    --'pareidolia',
    'hack',
    'gros_michel',
    'even_steven',
    'odd_todd',
    'scholar',
    'business_card',
    'supernova',
    'superposition',
    'ride_the_bus',
    'space',
    'egg',
    'burglar',
    'blackboard',
    'runner',
    'ice_cream',
    'dna',
    --'splash',
    'blue_joker',
    'sixth_sense',
    'constellation',
    'hiker',
    'faceless',
    'todo_list',
    'ticket',
    'mr_bones',
    'acrobat',
    'sock_and_buskin',
    'green_joker',
    'swashbuckler',
    'troubadour',
    'certificate',
    'smeared',
    'throwback',
    --'hanging_chad',
    'rough_gem',
    'bloodstone',
    'arrowhead',
    'onyx_agate',
    'glass',
    --'ring_master',
    'flower_pot',
    --'blueprint',
    'wee',
    'merry_andy',
    --'oops',
    'idol',
    'seeing_double',
    'matador',
    'hit_the_road',
    'duo',
    'trio',
    'family',
    'order',
    'tribe',
    'cavendish',
    'card_sharp',
    'red_card',
    'madness',
    'square',
    'seance',
    'riff_raff',
    'vampire',
    --'shortcut',
    'hologram',
    'vagabond',
    'baron',
    'cloud_9',
    'rocket',
    'obelisk',
    'midas_mask',
    'luchador',
    'photograph',
    'gift',
    'turtle_bean',
    'erosion',
    'reserved_parking',
    'mail',
    --'to_the_moon',
    'hallucination',
    'lucky_cat',
    'baseball',
    'bull',
    'diet_cola',
    'trading',
    'flash',
    'pocporn',
    'ramen',
    'trousers',
    'ancient',
    'walkie_talkie',
    --'selzer',
    'castle',
    'smiley',
    'campfire',
    'stuntman',
    'invisible',
    --'brainstorm',
    'satellite',
    'shoot_the_moon',
    'drivers_license',
    'cartomancer',
    --'astronomer',
    'burnt',
    'bootstraps',
    'caino',
    'triboulet',
    'yorick',
    'chicot',
    'perkeo',
}

local get_joker_value = function(card, val)
    return type(card.ability.extra) == 'table' and card.ability.extra[val] or card.ability[val]
end

local get_joker_values = function(card, ...)
    local list = ...
    for i=1,#list do
        local ret = type(card.ability.extra) == 'table' and card.ability.extra[list[i]] or card.ability[list[i]]
        if ret ~= nil then return ret end
    end
    return nil
end

function Overloaded.Funcs.quasi_check_vanilla_joker(card, context, do_secondary_check)
    if (not card) or context.blueprint then return nil end
    local key = card.config.center.key
    if not MadLib.list_matches_one(Overloaded.Lists.QuasicolonVanilla, function(v)
        return card.config.center.key == 'j_'..v
    end) then return nil end

    if 
        key == 'j_joker'
        or key == 'j_stencil'
        or key == 'j_banner'
        or key == 'j_loyalty_card'
        or key == 'j_misprint'
        or key == 'j_raised_fist'
        or key == 'j_steel_joker'
        or key == 'j_abstract'
        or key == 'j_supernova'
        or key == 'j_ride_the_bus'
        or key == 'j_ice_cream'
        or key == 'j_blue_joker'
        or key == 'j_green_joker'
        or key == 'j_erosion'
        or key == 'j_popcorn'
        or key == 'j_stuntman'
    then -- activate upon joker_main
        return context.joker_main
    elseif key == 'j_greedy_joker' or key == 'j_rough_gem' then
        return (context.individual and context.cardarea == G.play) and Overloaded.Funcs.get_joker_suit(card, 'Diamonds')
    elseif key == 'j_lusty_joker' then
        return (context.individual and context.cardarea == G.play) and Overloaded.Funcs.get_joker_suit(card, 'Hearts')
    elseif key == 'j_bloodstone' then
        return (context.individual and context.cardarea == G.play) 
            and Overloaded.Funcs.get_joker_suit(card, 'Hearts')
            and SMODS.pseudorandom_probability(card, 'bloodstone', 1, card.ability.extra.odds)
    elseif key == 'j_wrathful_joker' or key == 'j_arrowhead' then
        return (context.individual and context.cardarea == G.play) and Overloaded.Funcs.get_joker_suit(card, 'Spades')
    elseif key == 'j_gluttenous_joker' or key == 'j_onyx_agate' then
        return (context.individual and context.cardarea == G.play) and Overloaded.Funcs.get_joker_suit(card, 'Clubs')
    elseif key == 'j_jolly' or key == 'j_sly' or key == 'j_duo' then
        return context.joker_main and context.poker_hands and next(context.poker_hands[Overloaded.Funcs.get_joker_hand(card, 'Pair')])
    elseif key == 'j_zany' or key == 'j_wily' or key == 'j_trio' then
        return context.joker_main and context.poker_hands and next(context.poker_hands[Overloaded.Funcs.get_joker_hand(card, 'Three of a Kind')])
    elseif key == 'j_mad' or key == 'j_clever' then
        return context.joker_main and context.poker_hands and next(context.poker_hands[Overloaded.Funcs.get_joker_hand(card, 'Two Pair')])
    elseif key == 'j_crazy' or key == 'j_devious' or key == 'j_runner' or key == 'j_order' then
        return context.joker_main and context.poker_hands and next(context.poker_hands[Overloaded.Funcs.get_joker_hand(card, 'Straight')])
    elseif key == 'j_droll' or key == 'j_crafty' or key == 'j_tribe' then
        return context.joker_main and context.poker_hands and next(context.poker_hands[Overloaded.Funcs.get_joker_hand(card, 'Flush')])
    elseif key == 'j_family' then
        return context.joker_main and context.poker_hands and next(context.poker_hands[Overloaded.Funcs.get_joker_hand(card, 'Four of a Kind')])
    elseif key == 'j_greedy_joker' then
        return (context.individual and context.cardarea == G.play) and Overloaded.Funcs.get_joker_suit(card, 'Diamonds')
    elseif key == 'j_half' then
        return context.joker_main and Overloaded.Funcs.get_modified_card_quantity(context.full_hand) <= card.ability.extra.size
    elseif 
        key == 'j_ceremonial'
        or key == 'j_marble'
        or key == 'j_burglar'
    then
        return context.setting_blind
    elseif key == 'j_mystic_summit' then
        return context.joker_main and G.GAME.current_round.discards_left == card.ability.extra.d_remaining
    elseif key == 'j_8_ball' then
        return context.full_hand
            and #context.full_hand == 1 and context.destroy_card == context.full_hand[1]
            and MadLib.joker_check_rank(context.full_hand[1], card, Overloaded.Funcs.get_joker_rank(card, '6'))
    elseif key == 'j_sixth_sense' then
        return context.individual and context.cardarea == G.play
            and MadLib.joker_check_rank(context.other_card, card, Overloaded.Funcs.get_joker_rank(card, '8'))
            and SMODS.pseudorandom_probability(card, '8_ball', 1, card.ability.extra)
            and G.GAME.current_round.hands_played == 0
    elseif key == 'j_dusk' then
        return context.joker_main and G.GAME.current_round.hands_left == 0
    elseif key == 'j_fibonacci' then
        return context.individual and context.cardarea == G.play and MadLib.has_fib_rank(context.other_card)
    elseif key == 'j_even_steven' then
        return context.individual and context.cardarea == G.play and MadLib.has_odd_rank(context.other_card)
    elseif key == 'j_odd_todd' then
        return context.individual and context.cardarea == G.play and MadLib.has_even_rank(context.other_card)
    elseif 
        key == 'j_scary_face'
        or key == 'j_smiley'
        or key == 'j_midas_mask'
    then
        return context.individual and context.individual and context.cardarea == G.play and context.other_card:is_face()
    elseif key == 'j_delayed_grat' then
        return G.GAME.current_round.discards_used == 0 and G.GAME.current_round.discards_left > 0
    elseif key == 'j_hack' then
        return context.cardarea == G.play and context.repetition and not context.repetition_only and MadLib.list_matches_one(Overloaded.Lists.Hack, function(v)
            return MadLib.is_rank(context.other_card, v)
        end)
    elseif key == 'j_scholar' then
        return context.individual and context.cardarea == G.play and MadLib.joker_check_rank(context.other_card, card, 'Ace')
    elseif key == 'j_business' then
        return context.individual and context.cardarea == G.play and
            context.other_card:is_face() and
            SMODS.pseudorandom_probability(card, 'business', 1, card.ability.extra)
    elseif key == 'j_space' then
        return context.before and SMODS.pseudorandom_probability(card, 'space', 1, card.ability.extra)
    elseif key == 'j_egg' then
        return context.end_of_round and context.game_over == false
    elseif key == 'j_blackboard' then
        return context.joker_main and MadLib.list_matches_all(G.hand.cards, function(v)
            local suits = Overloaded.Funcs.get_joker_suits(card, {'Clubs', 'Spades'})
            for i=1,2 do if v:is_suit(suits[i], nil, true) then return true end; end
            return false
        end)
    elseif key == 'j_dna' then
        return context.before and G.GAME.current_round.hands_played == 0 and #context.full_hand == 1
    elseif key == 'j_constellation' then
        if do_secondary_check then 
            return context.joker_main
        elseif context.before then
            local reset = true
            local play_more_than = (G.GAME.hands[context.scoring_name].played or 0)
            for handname, values in pairs(G.GAME.hands) do
                if handname ~= context.scoring_name and values.played >= play_more_than and SMODS.is_poker_hand_visible(handname) then
                    reset = false
                    break
                end
            end
            return (reset == true) or nil
        else
            return nil
        end
    elseif key == 'j_hologram' then
        return do_secondary_check and (context.joker_main) or (context.playing_card_added)
    elseif key == 'j_obelisk' then
        return do_secondary_check and (context.joker_main) or (context.using_consumeable and context.consumeable.ability.set == 'Planet')
    elseif key == 'j_hiker' then
        return context.individual and context.cardarea == G.play -- too op?
    elseif key == 'j_faceless' then
        return context.discard and context.other_card == context.full_hand[#context.full_hand]
    elseif key == 'j_superposition' then
        return context.joker_main
            and context.poker_hands and next(context.poker_hands[Overloaded.Funcs.get_joker_hand(card, 'Straight')])
            and  MadLib.list_matches_one(context.scoring_hand, function(v)
                return MadLib.joker_check_rank(v, card, 'Ace')
            end)
    elseif key == 'j_todo_list' then
        return context.before and context.scoring_name == Overloaded.Funcs.get_joker_hand(card, 'High Card')
    elseif 
        key == 'j_gros_michel'
        or key == 'j_cavendish'
    then
        return do_secondary_check and (context.end_of_round 
                and context.game_over == false
                and context.main_eval
                and SMODS.pseudorandom_probability(card, key, 1, card.ability.extra.odds))
            or (context.joker_main)
    elseif key == 'j_card_sharp' then
        return context.joker_main and G.GAME.hands[context.scoring_name] and G.GAME.hands[context.scoring_name].played_this_round > 1
    elseif key == 'j_red_card' then
        return context.skipping_booster
    elseif key == 'j_madness' then
        return context.setting_blind and not context.blind.boss
    elseif key == 'j_square' then
        return context.joker_main and #context.full_hand == 4
    elseif key == 'j_riff_raff' then
        return context.setting_blind and #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit -- must have room, haha
    elseif key == 'j_vampire' then
        return context.before and MadLib.list_matches_one(context.scoring_hand, function(v) -- a little tricky i suppose
             return next(SMODS.get_enhancements(v)) and not v.debuff
        end)
    elseif key == 'j_photograph' then
        return context.before and MadLib.list_matches_one(context.scoring_hand, function(v) -- a little tricky i suppose
             return v:is_face()
        end)
    elseif key == 'j_vagabond' then
        return context.joker_main and
            #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit
            and MadLib.compare_numbers(G.GAME.dollar, card.ability.extra)
    elseif key == 'j_baron' then -- TODO: add functions for each specific check?
        return context.individual
            and context.cardarea == G.hand 
            and not context.end_of_round 
            and MadLib.joker_check_rank(context.other_card, card, 'King')
            and context.other_card:quantity_exists()
    elseif 
        key == 'j_cloud_9'
        or key == 'j_to_the_moon'
        or key == 'j_gift_card'
        or key == 'j_golden'
        or key == 'j_constellation'
    then
        return context.end_of_round and context.game_over == false and context.main_eval
    elseif key == 'j_rocket' then
        return context.end_of_round and context.game_over == false and context.main_eval and context.beat_boss
    elseif key == 'j_reserved_parking' then
        return context.individual and context.cardarea == G.hand and not context.end_of_round and context.other_card:is_face() 
            and not (context.other_card.debuff or not context.other_card:quantity_exists())
    elseif key == 'j_mail' then
        return context.discard 
            and not (context.other_card.debuff or not context.other_card:quantity_exists())
            and MadLib.is_rank(context.other_card, G.GAME.current_round.mail_card.id)
    elseif key == 'j_hallucination' then
        return context.open_booster and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit
            and SMODS.pseudorandom_probability(card, 'hallucination' .. G.GAME.round_resets.ante, 1, card.ability.extra)
    elseif key == 'j_fortune_teller' then
        return do_secondary_check 
            and (context.using_consumeable and context.consumeable.ability.set == "Tarot")
            or (context.joker_main and G.GAME.consumeable_usage_total and G.GAME.consumeable_usage_total.tarot > 0)
    elseif key == 'j_fortune_teller' then
        return do_secondary_check 
            and (context.joker_main)
            or (context.individual and context.cardarea == G.play and context.other_card.lucky_trigger)
    elseif key == 'j_stone' then
        return context.joker_main and MadLib.list_matches_one(G.playing_cards, function(v)
            return SMODS.has_enhancement(v, 'm_stone') and v:get_quantity_value() or 0
        end)
    elseif key == 'j_baseball' then
        return context.other_joker and (context.other_joker.config.center.rarity == 2 or context.other_joker.config.center.rarity == "Uncommon")
    elseif key == 'j_bull' or key == 'j_bootstraps' then
        return context.joker_main and MadLib.is_positive_number(MadLib.add(G.GAME.dollars, G.GAME.dollar_buffer or 0))
    elseif key == 'j_trading' then
        return context.discard and G.GAME.current_round.discards_used <= 0 and #context.full_hand == 1
    elseif key == 'j_flash' then
        return context.reroll_shop
    elseif key == 'j_trousers' then
        return do_secondary_check 
            and context.joker_main
            or context.joker_main and next(context.poker_hands[Overloaded.Funcs.get_joker_hand(card, 'Two Pair')])
    elseif key == 'j_ancient' then
        return context.individual 
            and context.cardarea == G.play
            and context.other_card:is_suit(Overloaded.Funcs.get_joker_suit(card, (G.GAME.current_round.ancient_card or {}).suit or 'Spades'))
    elseif key == 'j_ramen' then
        return do_secondary_check 
            and context.discard
            or context.joker_main
    elseif key == 'j_walkie_talkie' then
        return context.individual 
            and context.cardarea == G.play
            and MadLib.list_matches_one(card.ability.ranks, function(v)
                return MadLib.is_rank(context.other_card, v)
            end)
    elseif key == 'j_castle' then
        return do_secondary_check 
            and (context.discard
                and not context.other_card.debuff
                and context.other_card:is_suit(G.GAME.current_round.castle_card.suit))
            or context.joker_main
    elseif key == 'j_campfire' then
        return do_secondary_check 
            and context.selling_card
            or context.joker_main
    elseif key == 'j_ticket' then
        return context.individual and context.cardarea == G.play and SMODS.has_enhancement(context.other_card, 'm_gold')
    elseif key == 'j_mr_bones' then
        return context.end_of_round and context.game_over and context.main_eval
            and MadLib.compare_numbers(MadLib.divide(G.GAME.chips, G.GAME.blind.chips), 0.25) >= 0
    elseif key == 'j_acrobat' then
        return context.joker_main and G.GAME.current_round.hands_left == 0
    elseif key == 'j_swashbuckler' then
        if context.joker_main then
            local sell_cost = 0
            for _, joker in ipairs(G.jokers.cards) do
                if joker ~= card then
                    sell_cost = sell_cost + joker.sell_cost
                end
            end
            return MadLib.is_positive_number(sell_cost)
        end
    elseif key == 'j_certificate' then
        return context.first_hand_drawn
    elseif key == 'j_throwback' then
        return do_secondary_check and (context.joker_main and G.GAME.skips > 0)
            or context.skip_blind
    elseif key == 'j_throwback' then
        return context.cardarea == G.play and context.other_card == context.scoring_hand[1]
    elseif key == 'j_glass' then
        return do_secondary_check and context.joker_main
           or ((context.remove_playing_cards and MadLib.list_matches_one(context.removed, function(v) return v.shattered end))
            or context.using_consumeable and not context.blueprint and context.consumeable.config.center.key == 'c_hanged_man' and MadLib.list_matches_one(G.hand.highlighted, function(v) return SMODS.has_enhancement(v, 'm_glass') end))
    elseif key == 'j_flower_pot' then
        return context.joker_main and MadLib.get_flower_pot(context.scoring_hand) > 3
    elseif key == 'j_wee' then
        return do_secondary_check and context.joker_main 
            or (context.individual 
            and context.cardarea == G.play
            and MadLib.joker_check_rank(context.other_card, card, '2'))
    elseif key == 'j_idol' then
        return context.individual
            and context.cardarea == G.play 
            and Overloaded.Funcs.is_rank_and_suit(context.other_card, G.GAME.current_round.idol_card.id, G.GAME.current_round.idol_card.suit)
    elseif key == 'j_seeing_double' then
        return context.joker_main and SMODS.seeing_double_check(context.scoring_hand, Overloaded.Funcs.get_joker_suit(card, 'Clubs'))
    elseif key == 'j_matador' then
        return (context.debuffed_hand or context.joker_main) and G.GAME.blind.triggered
    elseif key == 'j_hit_the_road' then
        return context.discard 
            and not context.blueprint
            and MadLib.joker_check_rank(context.other_card, card, 'Jack') 
            and context.other_card:quantity_exists()
    elseif key == 'j_shoot_the_moon' then
        return context.individual
            and context.cardarea == G.hand
            and (not context.end_of_round)
            and MadLib.joker_check_rank(context.other_card, card, 'Queen')
            and context.other_card:quantity_exists()
    elseif key == 'j_drivers_license' then
        return context.joker_main and MadLib.get_card_count(G.playing_cards, function(v)
            return next(SMODS.get_enhancements(v))
        end) >= 18
    elseif key == 'j_cartomancer' then
        return context.setting_blind and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit
    elseif key == 'j_burnt' then
        return context.pre_discard and G.GAME.current_round.discards_used <= 0 and not context.hook
    elseif key == 'j_caino' then
        return do_secondary_check and context.joker_main
            or (context.remove_playing_card and
                MadLib.list_matches_one(context.removed, function(v)
                    return v:is_face() and v:quantity_exists()
                end))
    elseif key == 'j_triboulet' then
        return context.individual 
            and context.cardarea == G.play
            and MadLib.list_matches_one(Overloaded.Funcs.get_joker_ranks(card, { 'Queen', 'King' }), function(v) return MadLib.is_rank(context.other_card, v) end)
    elseif key == 'j_yorick' then
        return do_secondary_check and context.joker_main or context.discard and context.other_card:quantity_exists()
    elseif key == 'j_perkeo' then
        return context.ending_shop
    end
end

function Overloaded.Funcs.quasi_check(card, cards, context, do_secondary_check)
    if (not card) or context.blueprint then return nil end
    local results
    if card.ability.set == 'Joker' then
        --if context.forcetrigger then return true end -- force trigger chain reaction?
		local quasi_context = MadLib.deep_copy(context)
        card = Overloaded.Funcs.quasi_handle_blueprint(card, cards)
        quasi_context.checktrigger = true
        results = Overloaded.Funcs.quasi_check_vanilla_joker(card, context, do_secondary_check)
        if results == nil then
            results = card.config.center.calculate and card.config.center:calculate(card, context)
        end
        quasi_context = nil
    end
    return results or false
end

function Overloaded.Funcs.quasi_trigger_vanilla_joker(card, context, do_extra_actions)
    local key = card.config.center.key
    if not MadLib.list_matches_one(Overloaded.Lists.QuasicolonVanilla, function(v)
        return card.config.center.key == 'j_'..v
    end) then return nil end
    local results = {}
    if
        key == 'j_joker'
        or key == 'j_half'
        or key == 'j_mystic_summit'
        or key == 'j_fibonacci'
        or key == 'j_abstract'
        or key == 'j_even_steven'
        or key == 'j_supernova'
        or key == 'j_even_steven'
        or key == 'j_green_joker'
        or key == 'j_spare_trousers'
        or key == 'j_swashbuckler'
        or key == 'j_smiley'
        or key == 'j_onyx_agate'
    then -- mult w/ no scale
        results = { mult = get_joker_values(card, 'extra', 'mult') }
    elseif key == 'j_shoot_the_moon' then
        results = { mult = 13 }
    elseif
        key == 'j_ride_the_bus'
        or key == 'j_flash'
    then -- mult w/ scale up
        if do_extra_actions then
			SMODS.scale_card(card, {
				ref_table = card.ability,
				ref_value = "mult",
				scalar_value = "extra",
				no_message = true,
			})
        end
        results = { mult = get_joker_values(card, 'extra', 'mult') }
    elseif
        key == 'j_banner'
        or key == 'j_scary_face'
        or key == 'j_odd_todd'
        or key == 'j_blue_joker'
        or key == 'j_arrowhead'
    then -- chips w/ no scale
        results = { chips = get_joker_values(card, 'extra', 'chips') }
    elseif key == 'j_stone' then -- stone joker
        results = { chips = MadLib.multiply(card.ability.extra, card.ability.stone_tally) }
    elseif key == 'j_stuntman' then -- stuntman
        if do_extra_actions then
			G.hand:change_size(-card.ability.extra.h_size)
        end
        results = { chips = card.ability.extra.chip_mod }
    elseif
        key == 'j_runner'
        or key == 'j_square'
        or key == 'j_castle'
        or key == 'j_wee'
    then -- chips w/ scale up
        if do_extra_actions then
            SMODS.scale_card(card, {
                ref_table = card.ability,
                ref_value = "chips",
                scalar_value = "chip_mod",
                no_message = true,
            })
        end
        results = { chips = get_joker_values(card, 'extra', 'chips') }
    elseif
        key == 'j_ice_cream'
    then -- chips w/ scale down
        if do_extra_actions then
            SMODS.scale_card(card, {
                ref_table = card.ability,
                ref_value = "chips",
                scalar_value = "chip_mod",
                operation = "-",
                no_message = true,
            })
            if not MadLib.is_positive_number(MadLib.subtract(card.ability.extra.chips, card.ability.extra.chip_mod)) then
				SMODS.destroy_cards(card, nil, nil, true)
			end
        end
        results = { chips = get_joker_values(card, 'extra', 'chips') }
    elseif
        key == 'j_popcorn'
    then -- chips w/ scale down
        if do_extra_actions then
			SMODS.scale_card(card, {
				ref_table = card.ability,
				ref_value = "mult",
				scalar_value = "extra",
				operation = "-",
				no_message = true,
			})
            if not MadLib.is_positive_number(MadLib.subtract(card.ability.extra.chips, card.ability.extra.chip_mod)) then
				SMODS.destroy_cards(card, nil, nil, true)
			end
        end
        results = { chips = get_joker_values(card, 'extra', 'chips') }
    elseif
        key == 'j_greedy_joker'
        or key == 'j_lusty_joker'
        or key == 'j_wrathful_joker'
        or key == 'j_gluttenous_joker'
    then -- suit mult
        results = { mult = get_joker_value(card, 's_mult') }
    elseif 
        key == 'j_jolly'
        or key == 'j_zany'
        or key == 'j_mad'
        or key == 'j_crazy'
        or key == 'j_droll'
    then -- poker hand mult
        results = { mult = get_joker_value(card, 't_mult') }
    elseif
        key == 'j_sly'
        or key == 'j_wily'
        or key == 'j_clever'
        or key == 'j_devious'
        or key == 'j_crafty'
    then -- poker hand chips
        results = { chips = get_joker_value(card, 't_chips') }
    elseif
        key == 'j_stencil'
        or key == 'j_flower_pot'
        or key == 'j_steel_joker'
        or key == 'j_glass'
        or key == 'j_blackboard'
        or key == 'j_baron'
        or key == 'j_obelisk'
        or key == 'j_photograph'
        or key == 'j_ancient'
        or key == 'j_throwback'
        or key == 'j_bloodstone'
        or key == 'j_idol'
        or key == 'j_seeing_double'
        or key == 'j_duo'
        or key == 'j_trio'
        or key == 'j_family'
        or key == 'j_order'
        or key == 'j_tribe'
        or key == 'j_drivers_license'
        or key == 'j_triboulet'
        or key == 'j_card_sharp'
        or key == 'j_card_acrobat'
    then -- x mult w/ no scale
        results = { x_mult = card.ability.extra }
    elseif
        key == 'j_loyalty_card'
    then -- x mult w/ no scale, uses extra table
        results = { x_mult = card.ability.extra.Xmult }
    elseif key == 'j_lucky_cat' then -- lucky cat
        if do_extra_actions then
			card.ability.x_mult = MadLib.add(card.ability.x_mult, card.ability.extra)
        end
        results = { x_mult = get_joker_values(card, 'extra', 'x_mult', 'Xmult') }
    elseif
        key == 'j_constellation'
        or key == 'j_vampire'
        or key == 'j_hologram'
        or key == 'j_obelisk'
        or key == 'j_glass'
        or key == 'j_hit_the_road'
        or key == 'j_caino'
        or key == 'j_yorick'
    then -- x mult w/ no scale
        if do_extra_actions then
			SMODS.scale_card(card, {
				ref_table = card.ability,
				ref_value = "x_mult",
				scalar_value = "extra",
				no_message = true,
			})
        end
        results = { x_mult = get_joker_values(card, 'extra', 'x_mult', 'Xmult') }
    elseif key == 'j_cavendish' then
        if do_extra_actions then
			SMODS.destroy_cards(card, nil, nil, true)
        end
        results = { x_mult = get_joker_values(card, 'extra', 'x_mult', 'Xmult') }
    elseif key == 'j_midas_mask' then
			if context.scoring_hand then
				for _, v in ipairs(context.scoring_hand) do
					if v:is_face() then
                        v:set_ability('m_gold', nil, true)
						MadLib.event({
							trigger = "after",
							delay = 0.4,
							func = function()
								v:juice_up()
								return true
							end,
						})
					end
				end
			elseif G and G.hand and #G.hand.highlighted > 0 then
				for _, v in ipairs(G.hand.highlighted) do
					if v:is_face() then
                        v:set_ability('m_gold', nil, true)
						MadLib.event({
							trigger = "after",
							delay = 0.4,
							func = function()
								v:juice_up()
								return true
							end,
						})
					end
				end
			end
    elseif 
        key == 'j_luchador'
        or key == 'j_chicot'
    then
			if G.GAME.blind and ((not G.GAME.blind.disabled) and (G.GAME.blind:get_type() == "Boss")) then
				G.GAME.blind:disable()
			end
    elseif key == 'j_madness' then
        if do_extra_actions then
			local destructable_jokers = {}
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i] ~= card and not SMODS.is_eternal(G.jokers.cards[i], card) and not G.jokers.cards[i].getting_sliced then
                    destructable_jokers[#destructable_jokers + 1] =
                        G.jokers.cards[i]
                end
            end
            local joker_to_destroy = pseudorandom_element(destructable_jokers, 'madness')
            if joker_to_destroy then
                joker_to_destroy.getting_sliced = true
                G.E_MANAGER:add_event(Event({
                    func = function()
                        (context.blueprint_card or card):juice_up(0.8, 0.8)
                        joker_to_destroy:start_dissolve({ G.C.RED }, nil, 1.6)
                        return true
                    end
                }))
            end
        end
        results = { x_mult = get_joker_value(card, 'x_mult') }
    elseif key == 'j_ceremonial' then -- ceremonial dagger
        if do_extra_actions then
			local my_pos = nil
			for i = 1, #G.jokers.cards do
				if G.jokers.cards[i] == card then my_pos = i; break; end
			end
			if
				my_pos
				and G.jokers.cards[my_pos + 1]
				and not card.getting_sliced
				and not SMODS.is_eternal(G.jokers.cards[my_pos + 1])
				and not G.jokers.cards[my_pos + 1].getting_sliced
			then
				local sliced_card = G.jokers.cards[my_pos + 1]
				sliced_card.getting_sliced = true
				G.GAME.joker_buffer = G.GAME.joker_buffer - 1
				G.E_MANAGER:add_event(Event({
					func = function()
						G.GAME.joker_buffer = 0
						card:juice_up(0.8, 0.8)
						sliced_card:start_dissolve({ HEX("57ecab") }, nil, 1.6)
						play_sound("slice1", 0.96 + math.random() * 0.08)
						return true
					end,
				}))
				SMODS.scale_card(card, {
					ref_table = card.ability,
					ref_value = "mult",
					scalar_table = { cost = sliced_card.sell_cost * 2 },
					scalar_value = "cost",
					no_message = true,
				})
            end
        end
        results = { mult = get_joker_values(card, 'mult') }
    elseif key == 'j_marble' then -- marble joker
        MadLib.event({
			trigger = "after",
			delay = 0.4,
			func = function()
				local front = pseudorandom_element(G.P_CARDS, pseudoseed("marb_fr"))
				G.playing_card = (G.playing_card and G.playing_card + 1) or 1
				local card = Card(
					G.play.T.x + G.play.T.w / 2,
					G.play.T.y,
					G.CARD_W,
					G.CARD_H,
					front,
					G.P_CENTERS.m_stone,
					{ playing_card = G.playing_card }
				)
				card:start_materialize({ G.C.SECONDARY_SET.Enhanced })
				G.deck:emplace(card)
				table.insert(G.playing_cards, card)
				return true
			end
		})
    elseif 
        key == 'j_8_ball'
        or key == 'j_superposition'
        or key == 'j_vagabond'
        or key == 'j_hallucination'
        or key == 'j_cartomancer'
    then
		MadLib.event({
			trigger = "after",
			delay = 0.4,
			func = function()
				SMODS.add_card { set = 'Tarot', key_append = key }
				G.GAME.consumeable_buffer = 0
				return true
			end,
		})
    elseif key == 'j_misprint' then
        results = { mult = card.ability.extra.max }
    elseif key == 'j_raised_fist' then
        results = { mult = MadLib.multiply(22, 1) } -- TODO: 22 x extra
    elseif key == 'j_fortune_teller' then
        results = { mult = G.GAME.consumeable_usage_total.tarot or 1 } -- TODO: 22 x extra
    elseif
        key == 'j_delayed_grat'
        or key == 'j_business'
        or key == 'j_faceless'
        or key == 'j_todo_list'
        or key == 'j_reserved_parking'
        or key == 'j_mail'
        or key == 'j_golden'
        or key == 'j_trading'
        or key == 'j_ticket'
        or key == 'j_rough_gem'
        or key == 'j_matador'
    then
        results = { dollars = get_joker_values(card, 'dollars', 'extra') }
    elseif
        key == 'j_satellite'
    then
		local planets_used = 0
		for _, v in pairs(G.GAME.consumeable_usage) do if v.set == "Planet" then planets_used = planets_used + 1 end end
        results = { dollars = MadLib.multiply(card.ability.extra, planets_used or 1) }
    elseif key == 'j_cloud_9' then
        results = { dollars = card.ability.nine_tally and MadLib.multiply(get_joker_values(card, 'dollars', 'extra'), card.ability.nine_tally) }
    elseif key == 'j_rocket' then
        SMODS.scale_card(card, {
			ref_table = card.ability.extra,
			ref_value = "dollars",
			scalar_value = "increase",
			no_message = true,
		})
        results = { dollars = get_joker_values(card, 'dollars', 'extra') }
    elseif key == 'j_gros_michel' then
        if do_extra_actions then
			SMODS.destroy_cards(card, nil, nil, true)
			G.GAME.pool_flags.gros_michel_extinct = true
        end
        results = { mult = card.ability.extra.mult }
    elseif key == 'j_erosion' then
        if do_extra_actions then
			SMODS.destroy_cards(card, nil, nil, true)
			G.GAME.pool_flags.gros_michel_extinct = true
        end
        results = { mult = MadLib.multiply(card.ability.extra, MadLib.subtract(G.GAME.starting_deck_size, #G.playing_cards)), card = card }
    elseif 
        key == 'j_scholar'
        or key == 'j_walkie_talkie'
    then -- mult AND chips
        results = { chip_mod = card.ability.extra.chips, mult = card.ability.extra.mult }
    elseif 
        key == 'j_space'
        or key == 'j_burnt' 
    then --space joker
		if #G.hand.highlighted > 0 then
			local text, disp_text = G.FUNCS.get_poker_hand_info(G.hand.highlighted)
            SMODS.smart_level_up_hand(card, text, nil, 1)
		elseif context.scoring_name then
            SMODS.smart_level_up_hand(card, context.scoring_name, nil, 1)
		end
    elseif key == 'j_egg' then --egg
		SMODS.scale_card(card, {
			ref_table = card.ability,
			ref_value = "extra_value",
			scalar_value = "extra",
			no_message = true,
		})
		card:set_cost()
    elseif key == 'j_burglar' then --burglar
		MadLib.event({
			func = function()
				ease_discard(-G.GAME.current_round.discards_left, nil, true)
				ease_hands_played(card.ability.extra)
				return true
			end
		})
    elseif key == 'j_dna' then -- dna
        if context.full_hand and #context.full_hand == 1 then
            G.playing_card = (G.playing_card and G.playing_card + 1) or 1
            local copy_card = copy_card(context.full_hand[1], nil, nil, G.playing_card)
            copy_card:add_to_deck()
            G.deck.config.card_limit = G.deck.config.card_limit + 1
            table.insert(G.playing_cards, copy_card)
            G.hand:emplace(copy_card)
            copy_card.states.visible = nil
            MadLib.event({
                func = function()
                    copy_card:start_materialize()
                    return true
                end
            })
        end
    elseif key == 'j_sixth_sense' then -- sixth sense
		G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
		G.E_MANAGER:add_event(Event({
            func = (function()
                SMODS.add_card { set = 'Spectral', key_append = 'sixth_sense' }
                G.GAME.consumeable_buffer = 0
                return true
            end)
        }))
    elseif key == 'j_riff_raff' then -- riff raff
        local jokers_to_create = math.min(card.ability.extra.creates, G.jokers.config.card_limit - (#G.jokers.cards + G.GAME.joker_buffer))
        G.GAME.joker_buffer = G.GAME.joker_buffer + jokers_to_create
        MadLib.event({
            func = function()
                for _ = 1, jokers_to_create do
                    SMODS.add_card {
                        set = 'Joker',
                        rarity = 'Common',
                        key_append = 'riff_raff'
                    }
                    G.GAME.joker_buffer = 0
                end
                return true
            end
        })
    elseif key == 'j_gift' then
		for _, area in ipairs({ G.jokers, G.consumeables }) do
            for _, other_card in ipairs(area.cards) do
                if other_card.set_cost then
                    other_card.ability.extra_value = (other_card.ability.extra_value or 0) +
                        card.ability.extra.sell_value
                    other_card:set_cost()
                end
            end
        end
    elseif key == 'j_turtle_bean' then
        if do_extra_actions then
			SMODS.scale_card(card, {
				ref_table = card.ability.extra,
				ref_value = "h_size",
				scalar_value = "h_mod",
				operation = "-",
				no_message = true,
			})
        end
		G.hand:change_size(card.ability.extra.h_size)
    elseif key == 'j_juggler' then
		G.hand:change_size(card.ability.h_size)
    elseif key == 'j_drunkard' then
		ease_discard(card.ability.d_size)
    elseif key == 'j_troubadour' then
		G.hand:change_size(card.ability.extra.h_size)
		G.GAME.round_resets.hands = G.GAME.round_resets.hands + card.ability.extra.h_plays
    elseif key == 'j_certificate' then
		local _card = create_playing_card({
			front = pseudorandom_element(G.P_CARDS, pseudoseed("cert_fr")),
			center = G.P_CENTERS.c_base,
		}, G.discard, true, nil, { G.C.SECONDARY_SET.Enhanced }, true)
		_card:set_seal(SMODS.poll_seal({ guaranteed = true, type_key = "certsl" }))
		MadLib.event({
			func = function()
				G.hand:emplace(_card)
				_card:start_materialize()
				G.GAME.blind:debuff_card(_card)
				G.hand:sort()
				return true
			end,
		})
    elseif key == 'j_diet_cola' then
		MadLib.event({
			func = function()
				add_tag(Tag("tag_double"))
				play_sound("generic1", 0.9 + math.random() * 0.1, 0.8)
				play_sound("holo1", 1.2 + math.random() * 0.1, 0.4)
				return true
			end,
		})
    elseif key == 'j_perkeo' then
		local eligibleJokers = {}
		for i = 1, #G.consumeables.cards do
			if G.consumeables.cards[i].ability.consumeable then
				eligibleJokers[#eligibleJokers + 1] = G.consumeables.cards[i]
			end
		end
		if #eligibleJokers > 0 then
			MadLib.event({
				func = function()
                    local card_to_copy, _ = pseudorandom_element(G.consumeables.cards, 'perkeo')
                    local copied_card = copy_card(card_to_copy)
                    copied_card:set_edition("e_negative", true)
                    copied_card:add_to_deck()
                    G.consumeables:emplace(copied_card)
					return true
				end,
			})
		end
    end
    results.card = results.card or card
    key = nil
    return results
end

function Overloaded.Funcs.quasi_handle_blueprint(card, cards)
    if not (card and cards) then return nil end
    local index = 0
    for i=1, #cards do
        if cards[i] == card then index = i end
    end
    local key = card.config.center.key
    if 
        key == 'j_blueprint' 
        or key == 'j_rgol_quasicolon' 
    then
        if index < #cards then
            index = index + 1
            card = cards[index]
        else
            return nil
        end
    elseif key == 'j_brainstorm' then
        if index ~= 1 then
            index = 1
            card = cards[index]
        else
            return nil
        end
    end
    return card
end

function Overloaded.Funcs.quasi_trigger(card, cards, context, do_extra_actions)
    if (not card) or context.checktrigger then return {} end
    local results
    if card.ability.set == 'Joker' then
        card = Overloaded.Funcs.quasi_handle_blueprint(card, cards)
        results = Overloaded.Funcs.quasi_trigger_vanilla_joker(card, context, do_extra_actions)
        if results == nil then
            local quasi_context = MadLib.deep_copy(context)
            quasi_context.forcetrigger = true
            results = eval_card(card, quasi_context)
            quasi_context = nil
        end
    end
    return results or {}
end