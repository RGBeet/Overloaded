-- Hack: Takes any rank with a nominal <= 5.
SMODS.Joker:take_ownership('hack', {
	calculate = function(self, card, context)
		if 
            context.cardarea == G.play
            and context.repetition 
            and not context.repetition_only
        then
		    if MadLib.list_matches_one(Overloaded.Lists.Hack, function(v)
                return MadLib.is_rank(context.other_card,v)
            end) then
				return {
				    message = localize('k_again_ex'),
				    repetitions = card.ability.extra,
				    card = context.blueprint_card or card
				}
		    end
		end
	end,
}, true)

-- Fibonacci: Takes any rank with a nominal equal to the Fibonacci sequence.
SMODS.Joker:take_ownership('fibonacci', {
	calculate = function(self, card, context)
		if
            context.individual 
            and context.cardarea == G.play 
        then
		    if MadLib.has_fib_rank(context.other_card) then
				return { mult = card.ability.extra, card = card }
		    end
		end
	end,
}, true)

-- Fibonacci: Takes any odd numbered rank.
SMODS.Joker:take_ownership('odd_todd', {
	config = { extra = 25 },
	calculate = function(self, card, context)
		if
            context.individual 
            and context.cardarea == G.play 
        then
		    if MadLib.has_odd_rank(context.other_card) then
				return { chips = card.ability.extra, card = card }
		    end
		end
	end,
}, true)

-- Fibonacci: Takes any even numbered rank.
SMODS.Joker:take_ownership('even_steven', {
	calculate = function(self, card, context)
		if
            context.individual 
            and context.cardarea == G.play 
        then
		    if MadLib.has_even_rank(context.other_card) then
				return { mult = card.ability.extra, card = card }
		    end
		end
	end,
}, true)

SMODS.Joker:take_ownership('8_ball', {
    config = { extra = 4, rank = '8' },
    loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra, '8_ball')
        return { vars = { numerator, denominator, localize(Overloaded.Funcs.get_joker_rank(card, '8'), 'ranks') } }
    end,
    calculate = function(self, card, context)
        if 
            context.individual and context.cardarea == G.play
            and (#G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit)
        then
            if
                MadLib.joker_check_rank(context.other_card, card, card.ability.rank or '8')
                and SMODS.pseudorandom_probability(card, '8_ball', 1, card.ability.extra)
            then
                G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                return {
                    extra = {
                        message = localize('k_plus_tarot'),
                        message_card = card,
                        func = function()
                            MadLib.event({
                                func = (function()
                                    SMODS.add_card { set = 'Tarot', key_append = '8_ball' }
                                    G.GAME.consumeable_buffer = 0
                                    return true
                                end)
                            })
                        end
                    }
                }
            end
        end
    end
}, true)

-- Scholar
SMODS.Joker:take_ownership('scholar', {
	config = { extra = { mult = 4, chips = 20 }, rank = 'Ace' },
	loc_vars = function(self, info_queue, card)
        return MadLib.collect_vars(card.ability.extra.chips, card.ability.extra.mult, localize(Overloaded.Funcs.get_joker_rank(card, 'Ace'), 'ranks'))
    end,
    calculate = function(self, card, context)
        if 
            context.individual 
            and context.cardarea == G.play
            and MadLib.joker_check_rank(context.other_card, card, 'Ace')
        then
            return { mult = card.ability.extra.mult, chips = card.ability.extra.chips }
        end
    end
}, true)

-- Sixth Sense
SMODS.Joker:take_ownership('sixth_sense', {
    config = { rank = '6' },
    loc_vars = function(self, info_queue, card)
        return MadLib.collect_vars(localize(Overloaded.Funcs.get_joker_rank(card, '6'), 'ranks'))
    end,
    calculate = function(self, card, context)
        if context.destroy_card and not context.blueprint then
            if 
                #context.full_hand == 1 
                and context.destroy_card == context.full_hand[1] 
                and MadLib.joker_check_rank(context.destroy_card, card, '6')
                and G.GAME.current_round.hands_played == 0 
            then
                if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                    G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                    MadLib.event({
                        func = function()
                            SMODS.add_card { set = 'Spectral', key_append = 'sixth_sense' }
                            G.GAME.consumeable_buffer = 0
                            return true
                        end
                    })
                    return {
                        message = localize('k_plus_spectral'),
                        colour = G.C.SECONDARY_SET.Spectral,
                        remove = true
                    }
                end
                return { remove = true }
            end
        end
    end
}, true)

-- Baron
SMODS.Joker:take_ownership('baron', {
    config = { extra = 1.5, rank = 'King' },
    loc_vars = function(self, info_queue, card)
        return MadLib.collect_vars(card.ability.extra, localize(Overloaded.Funcs.get_joker_rank(card, 'King'), 'ranks'))
    end,
    calculate = function(self, card, context)
        if 
            context.individual
            and context.cardarea == G.hand 
            and not context.end_of_round 
            and MadLib.joker_check_rank(context.other_card, card, 'King')
            and context.other_card:get_quantity_value() > 0
        then
            return { x_mult = card.ability.extra }
        end
    end
}, true)

SMODS.Joker:take_ownership('cloud_9', {
    config = { extra = 1, rank = '9' },
    loc_vars = function(self, info_queue, card)
        local nines = MadLib.get_card_count(G.playing_cards, function(v) return MadLib.joker_check_rank(v, card, '9') end)
        return MadLib.collect_vars(card.ability.extra, localize(Overloaded.Funcs.get_joker_rank(card, '9'), 'ranks'), MadLib.multiply(card.ability.extra, nines))
    end,
    calc_dollar_bonus = function(self, card)
        local nines = MadLib.get_card_count(G.playing_cards, function(v) return MadLib.joker_check_rank(v, card, '9') end)
        return nines > 0 and MadLib.multiply(card.ability.extra, nines) or nil
    end
}, true)

SMODS.Joker:take_ownership('mail', {
    calculate = function(self, card, context)
        if 
            context.discard 
            and not (context.other_card.debuff or not context.other_card:get_quantity_value() > 0)
            and MadLib.is_rank(context.other_card, G.GAME.current_round.mail_card.id)
        then
            return {
                dollars = MadLib.multiply(card.ability.extra, v:get_quantity_value()),
                func = function()
                    MadLib.simple_event(function()
                        G.GAME.dollar_buffer = 0
                        return true
                    end, 0.0, 'immediate')
                end
            }
        end
    end
}, true)

-- Walkie Talkie
SMODS.Joker:take_ownership('walkie_talkie', {
    config = { extra = { chips = 10, mult = 4 }, ranks = { '10', '4' } },
    loc_vars = function(self, info_queue, card)
        local ranks = Overloaded.Funcs.get_joker_ranks(card, { '10', '4' })
        return MadLib.collect_vars(card.ability.extra.chips, card.ability.extra.mult, localize(ranks[1], 'ranks'), localize(ranks[2], 'ranks'))
    end,
    calculate = function(self, card, context)
        if 
            context.individual 
            and context.cardarea == G.play
        then
            if MadLib.list_matches_one(card.ability.ranks, function(v)
                return MadLib.is_rank(context.other_card, SMODS.Ranks[v].id)
            end) then
                return {
                    chips   = card.ability.extra.chips,
                    mult    = card.ability.extra.mult
                }
            end
        end
    end
}, true)

SMODS.Joker:take_ownership('wee', {
    config = { extra = { chips = 0, chip_mod = 8 }, rank = '2' },
    loc_vars = function(self, info_queue, card)
        return MadLib.collect_vars(card.ability.extra.chips, card.ability.extra.chip_mod, localize(Overloaded.Funcs.get_joker_rank(card, '2'), 'ranks'))
    end,
    calculate = function(self, card, context)
        if 
            context.individual 
            and context.cardarea == G.play
            and not context.blueprint 
        then
            if MadLib.joker_check_rank(context.other_card, card, '2') then
                card.ability.extra.chips = MadLib.add(card.ability.extra.chips, card.ability.extra.chip_mod)
                return {
                    message = localize('k_upgrade_ex'),
                    colour = G.C.CHIPS,
                    message_card = card
                }
            end
        end
        if context.joker_main then
            return { chips = card.ability.extra.chips }
        end
    end
}, true)

function Overloaded.Funcs.is_rank_and_suit(card,rank,suit)
    return card and MadLib.is_rank(card,rank) and card:is_suit(suit)
end

-- The Idol
SMODS.Joker:take_ownership('idol', {
    calculate = function(self, card, context)
        if 
            context.individual
            and context.cardarea == G.play
        then
            if Overloaded.Funcs.is_rank_and_suit(context.other_card, G.GAME.current_round.idol_card.id, G.GAME.current_round.idol_card.suit) then
                return {
                    xmult = card.ability.extra,
                    target_card = context.other_card,
                }
            end
        end
    end
}, true)

-- Hit the Road
SMODS.Joker:take_ownership('hit_the_road', {
    config = { extra = 0.5, rank = 'Jack' },
    loc_vars = function(self, info_queue, card)
        return MadLib.collect_vars(card.ability.extra.Xmult, card.ability.extra, localize(Overloaded.Funcs.get_joker_rank(card, 'Jack'), 'ranks'))
    end,
    calculate = function(self, card, context)
        if 
            context.discard 
            and not context.blueprint
            and MadLib.joker_check_rank(context.other_card, card, 'Jack') 
        then
            local amt = context.other_card:get_quantity_value()
            if amt > 0 then
                card.ability.extra.Xmult = MadLib.add(card.ability.extra.Xmult, MadLib.multiply(card.ability.extra.xmult_gain, amt))
                return {
                    message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.x_mult } },
                    colour = G.C.RED
                }
            end
        end

        if 
            context.end_of_round
            and context.game_over == false 
            and context.main_eval
            and not context.blueprint
        then
            card.ability.extra.Xmult = 1
            return { message = localize('k_reset'), colour = G.C.RED }
        end

        if context.joker_main then
            return { xmult = card.ability.extra.Xmult }
        end
    end
}, true)

SMODS.Joker:take_ownership('invisible', {
    calculate = function(self, card, context)
        if 
            context.selling_self 
            and (card.ability.invis_rounds >= card.ability.extra)
            and not context.blueprint 
        then
            local jokers = MadLib.get_list_matches(G.jokers.cards, function(v)
                return v:get_quantity_value() > 0
            end)
            if #jokers > 0 then
                if #G.jokers.cards <= G.jokers.config.card_limit then
                    local chosen_joker = pseudorandom_element(jokers, 'invisible')
                    local copied_joker = copy_card(chosen_joker, nil, nil, nil,
                        chosen_joker.edition and chosen_joker.edition.negative)
                    copied_joker:add_to_deck()
                    G.jokers:emplace(copied_joker)
                    return { message = localize('k_duplicated_ex') }
                else
                    return { message = localize('k_no_room_ex') }
                end
            else
                return { message = localize('k_no_other_jokers') }
            end
        end
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
            card.ability.invis_rounds = card.ability.invis_rounds + 1
            if card.ability.invis_rounds == card.ability.extra then
                local eval = function(card) return not card.REMOVED end
                juice_card_until(card, eval, true)
            end
            return {
                message = (card.ability.invis_rounds < card.ability.extra) and
                    (card.ability.invis_rounds .. '/' .. card.ability.extra) or
                    localize('k_active_ex'),
                colour = G.C.FILTER
            }
        end
    end,
}, true)

-- Shoot the Moon: Implements Quantum Rank Logic
SMODS.Joker:take_ownership('shoot_the_moon', {
    config = { extra = 13, rank = 'Queen' },
    loc_vars = function(self, info_queue, card)
        return MadLib.collect_vars(card.ability.extra, localize(Overloaded.Funcs.get_joker_rank(card, 'Queen'), 'ranks'))
    end,
    calculate = function(self, card, context)
        if
            context.individual
            and context.cardarea == G.hand
            and (not context.end_of_round)
            and MadLib.joker_check_rank(context.other_card, card, 'Queen')
        then
            local amt = context.other_card:get_quantity_value()
            if amt > 0 then
                return { mult = MadLib.multiply(card.ability.extra, amt) }
            end
        end
    end
}, true)

-- Triboulet: Implements Quantum Rank Logic
SMODS.Joker:take_ownership('triboulet', {
    config = { extra = 2, ranks = { 'Queen', 'King' } },
    loc_vars = function(self, info_queue, card)
        local ranks = Overloaded.Funcs.get_joker_ranks(card, { 'Queen', 'King' })
        return MadLib.collect_vars(card.ability.extra, localize(ranks[1], 'ranks'), localize(ranks[2], 'ranks'))
    end,
    calculate = function(self, card, context)
        if 
            context.individual 
            and context.cardarea == G.play
        then
            if MadLib.list_matches_one(Overloaded.Funcs.get_joker_ranks(card, { 'Queen', 'King' }), function(v) return MadLib.is_rank(context.other_card, v) end) then
                return { xmult = card.ability.extra }
            end
        end
    end
}, true)

-- Canio: Implements Quantity Logic
SMODS.Joker:take_ownership('caino', {
    loc_vars = function(self, info_queue, card)
        return MadLib.collect_vars(card.ability.extra, card.ability.Xmult)
    end,
    calculate = function(self, card, context)
        if 
            context.remove_playing_cards 
            and not context.blueprint 
        then
            local points = 0
            MadLib.loop_func(context.removed, function(v)
                if v:is_face() then points = points + v:get_quantity_value() end
            end)
            if points > 0 then
                -- See note about SMODS Scaling Manipulation on the wiki
                card.ability.Xmult = MadLib.add(card.ability.Xmult, MadLib.multiply(points, card.ability.extra))
                return { message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.Xmult } } }
            end
        end
        if context.joker_main then
            return { xmult = card.ability.Xmult }
        end
    end,
}, true)

-- Yorick: Implements Quantity Logic
SMODS.Joker:take_ownership('yorick', {
    config = { extra = { xmult = 1, discards = 23 } },
    loc_vars = function(self, info_queue, card)
        return MadLib.collect_vars(card.ability.extra.xmult_gain, card.ability.extra.discards, card.ability.extra.discards_remaining, card.ability.extra.xmult)
    end,
    calculate = function(self, card, context)
        if
            context.discard
            and not context.blueprint
        then
            local points = context.other_card:get_quantity_value()
            if points > 0 then
                if card.ability.extra.discards <= points then
                    card.ability.extra.discards = 23
                    card.ability.extra.Xmult = MadLib.add(card.ability.Xmult, card.ability.extra.xmult)
                    return {
                        message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.Xmult } },
                        colour = G.C.RED
                    }
                else
                    card.ability.extra.discards = card.ability.extra.discards - points
                    return nil, true -- This is for Joker retrigger purposes
                end
            end
        end
        if context.joker_main then
            return { xmult = card.ability.Xmult }
        end
    end,
}, true)

-- Perkeo: Ignores Invisible cards, twice as likely to duplicate Stereo cards
SMODS.Joker:take_ownership('perkeo', {
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { key = 'e_negative_consumable', set = 'Edition', config = { extra = 1 } }
    end,
    calculate = function(self, card, context)
        if context.ending_shop then
            local items = {}
            MadLib.loop_func(G.consumeables.cards, function(v)
                for i=0, v:get_quantity_value() do
                   items[#items+1] = v
                end
            end)
            G.E_MANAGER:add_event(Event({
                func = function()
                    local card_to_copy, _ = pseudorandom_element(items, 'perkeo')
                    local copied_card = copy_card(card_to_copy)
                    copied_card:set_edition("e_negative", true)
                    copied_card:add_to_deck()
                    G.consumeables:emplace(copied_card)
                    return true
                end
            }))
            return { message = localize('k_duplicated_ex') }
        end
    end,
}, true)

-- Erosion
SMODS.Joker:take_ownership('erosion', {
    loc_vars = function(self, info_queue, card)
        local points = G.GAME and G.GAME.starting_deck_size or 0
        MadLib.loop_func(G.playing_cards or {}, function(v)
            points = points - v:get_quantity_value()
        end)
        return MadLib.collect_vars(card.ability.extra, math.max(0, MadLib.multiply(card.ability.extra, points)), G.GAME and G.GAME.starting_deck_size or 52)
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local points = G.GAME.starting_deck_size
            MadLib.loop_func(G.playing_cards or {}, function(v)
                points = points - v:get_quantity_value()
            end)
            return {
                mult = math.max(0, MadLib.multiply(card.ability.extra, points))
            }
        end
    end
}, true)

-- Driver's License
SMODS.Joker:take_ownership('drivers_license', {
    calculate = function(self, card, context)
        if context.joker_main then
            if MadLib.get_card_count(G.playing_cards, function(v)
                return next(SMODS.get_enhancements(v))
            end) >= 18 then
                return { xmult = card.ability.extra }
            end
        end
    end,
}, true)

-- Runner
SMODS.Joker:take_ownership('runner', {
    config = { extra = { chips = 0, chip_mod = 15 }, type = "Straight" },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips, card.ability.extra.chip_mod, localize(Overloaded.Funcs.get_joker_hand(card, 'Straight'), 'poker_hands') } }
    end,
    calculate = function(self, card, context)
        if context.before and not context.blueprint and next(context.poker_hands[Overloaded.Funcs.get_joker_hand(card, 'Straight')]) then
            card.ability.extra.chips = MadLib.add(card.ability.extra.chips, card.ability.extra.chip_mod)
            return {
                message = localize('k_upgrade_ex'),
                colour = G.C.CHIPS,
            }
        end
        if context.joker_main then
            return {
                chips = card.ability.extra.chips
            }
        end
    end
}, true)

-- Half Joker - now quantity compatile!
SMODS.Joker:take_ownership('half', {
    config = { extra = { mult = 20, size = 3 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult, card.ability.extra.size } }
    end,
    calculate = function(self, card, context)
        if context.joker_main and Overloaded.Funcs.get_modified_card_quantity(context.full_hand) <= card.ability.extra.size then
            return { mult = card.ability.extra.mult }
        end
    end
}, true)

-- Joker Stencil - now quantity compatible!
local joker_stencil_get = function(a)
    return math.min(math.max(1, MadLib.get_empty_slots(a)), a.config.card_limit)
end

SMODS.Joker:take_ownership('stencil', {
    loc_vars = function(self, info_queue, card)
        return MadLib.collect_vars(joker_stencil_get(card.area))
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return { xmult = math.max(1, joker_stencil_get(card.area)) }
        end
    end
}, true)

-- Swashbuckler - now quantity compatible!
SMODS.Joker:take_ownership('swashbuckler', {
    loc_vars = function(self, info_queue, card)
        local sell_cost = 0
        MadLib.loop_func(G.jokers and G.jokers.cards or {}, function(v)
            sell_cost = MadLib.add(sell_cost, MadLib.multiply(v.sell_cost, v:get_quantity_value()))
        end)
        return MadLib.collect_vars(MadLib.multiply(card.ability.mult, sell_cost))
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local sell_cost = 0
            MadLib.loop_func(G.jokers and G.jokers.cards or {}, function(v)
                sell_cost = MadLib.add(sell_cost, MadLib.multiply(v.sell_cost, v:get_quantity_value()))
            end)
            if MadLib.is_positive_number(sell_cost) then
                return {
                    mult = MadLib.multiply(card.ability.mult, sell_cost)
                }
            end
        end
    end,
}, true)

SMODS.Joker:take_ownership('glass', {
    calculate = function(self, card, context)
        if context.remove_playing_cards and not context.blueprint then
            local points = 0
            MadLib.loop_func(context.removed, function(v)
                if not v.shattered then return end
                points = MadLib.add(points, v:get_quantity_value())
            end)
            if MadLib.is_positive_number(points) then
                local new_value = MadLib.add(card.ability.Xmult, MadLib.multiply(card.ability.extra, points))
                MadLib.event({
                    func = function()
                        MadLib.event({
                            func = function()
                                card.ability.Xmult = new_value
                                return true
                            end
                        })
                        SMODS.calculate_effect({ message = localize { type = 'variable', key = 'a_xmult', vars = { new_value } } }, card)
                        return true
                    end
                })
                return nil, true -- This is for Joker retrigger purposes
            end
        end
        if
            context.using_consumeable
            and not context.blueprint
            and context.consumeable.config.center.key == 'c_hanged_man'
        then
            local points = 0
            MadLib.loop_func(G.hand.highlighted, function(v)
                if SMODS.has_enhancement(v, 'm_glass') then return end
                points = MadLib.add(points, v:get_quantity_value())
            end)
            if MadLib.is_positive_number(points) then
                local new_value = MadLib.add(card.ability.Xmult, MadLib.multiply(card.ability.extra, points))
                card.ability.Xmult = new_value
                return {
                    message = localize { type = 'variable', key = 'a_xmult', vars = { points } }
                }
            end
        end
        if context.joker_main then
            return { xmult = card.ability.Xmult }
        end
    end,
}, true)

-- Raised Fist - does not count Invisible cards. Also adopts UnStable's code because
-- it helps with modded ranks.
SMODS.Joker:take_ownership('raised_fist', {
    config = { extra = 2 },
    loc_vars = function(self, info_queue, card)
        return MadLib.collect_vars(card.ability.extra)
    end,
	calculate = function(self, card, context)
		if
            context.individual
            and context.cardarea == G.hand
            and not context.end_of_round
        then
			local temp_mult = 99999
			local raised_card = nil
			-- Which card is it?
			MadLib.loop_func(G.hand.cards, function(v)
                if
                    SMODS.has_no_rank(v)
                    or temp_mult < SMODS.Ranks[v.base.value].sort_nominal
                    or not v:get_quantity_value() > 0
                then
                    return
                end
                temp_mult = v:get_nominal()
                raised_card = v
            end)
            -- Does the scoring
			if raised_card == context.other_card then
				if context.other_card.debuff then
					return {
						message = localize('k_debuffed'),
						colour = G.C.RED,
						card = card,
					}
				else
					return {
                        mult = MadLib.multiply(card.ability.extra, temp_mult),
                        card = card
                    }
				end
            end
		end
	end,
}, true)

-- Steel Joker - now quantity compatible!
SMODS.Joker:take_ownership('steel_joker', {
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_steel
        local steel_tally = MadLib.loop_func(G.playing_cards, function(v)
            return SMODS.has_enhancement(v, 'm_steel') and v:get_quantity_value() or 0
        end)
        return MadLib.collect_vars(card.ability.extra, MadLib.multiply(card.ability.extra, steel_tally))
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local steel_tally = MadLib.loop_func(G.playing_cards, function(v)
                return SMODS.has_enhancement(v, 'm_steel') and v:get_quantity_value() or 0
            end)
            return {
                xmult = MadLib.add(1, MadLib.multiply(card.ability.extra, steel_tally)),
            }
        end
    end,
}, true)

-- Stone Joker - now quantity compatible!
SMODS.Joker:take_ownership('stone', {
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_stone
        local stone_tally = MadLib.loop_func(G.playing_cards, function(v)
            return SMODS.has_enhancement(v, 'm_stone') and v:get_quantity_value() or 0
        end)
        return MadLib.collect_vars(card.ability.extra, MadLib.multiply(card.ability.extra, stone_tally))
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local stone_tally = MadLib.loop_func(G.playing_cards, function(v)
                return SMODS.has_enhancement(v, 'm_stone') and v:get_quantity_value() or 0
            end)
            return {
                chips = MadLib.multiply(card.ability.extra, stone_tally)
            }
        end
    end,
}, true)

-- Abstract Joker - now quantity compatible!
SMODS.Joker:take_ownership('abstract', {
    loc_vars = function(self, info_queue, card)
        local amt = 0
        MadLib.loop_func(G.jokers and G.jokers.cards or {}, function(v) 
            amt = amt + (v:get_quantity_value() or 0)
        end)
        return MadLib.collect_vars(card.ability.extra, MadLib.multiply(card.ability.extra, amt))
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local amt = 0
            MadLib.loop_func(G.jokers.cards, function(v)
                amt = amt + (v:get_quantity_value() or 0) 
            end)
            return {  mult = MadLid.multiply(card.ability.extra, amt) }
        end
    end,
}, true)

-- Madness
SMODS.Joker:take_ownership('madness', {
    calculate = function(self, card, context)
        if
            context.setting_blind
            and not context.blueprint
            and not context.blind.boss
        then
            card.ability.Xmult = card.ability.Xmult + card.ability.extra
            local destructable_jokers = {}
            MadLib.loop_func(G.jokers.cards, function(v)
                if
                    v ~= card
                    or SMODS.is_eternal(v, card)
                    or v.getting_sliced
                    or not v:get_quantity_value() > 0 -- invisible cannot be sliced
                then
                    return
                end
                destructable_jokers[#destructable_jokers + 1] = v
            end)
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
            return { message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.Xmult } } }
        end
        if context.joker_main then
            return {
                xmult = card.ability.Xmult
            }
        end
    end,
}, true)

-- Square Joker - now quantity compatible!
SMODS.Joker:take_ownership('square', {
    calculate = function(self, card, context)
        if
            context.before
            and not context.blueprint
            and Overloaded.Funcs.get_modified_card_quantity(context.full_hand) == 4
        then
            -- See note about SMODS Scaling Manipulation on the wiki
            card.ability.extra.chips = MadLib.add(card.ability.extra.chips, card.ability.extra.chip_mod)
            return {
                message = localize('k_upgrade_ex'),
                colour = G.C.CHIPS
            }
        end
        if context.joker_main then
            return {
                chips = card.ability.extra.chips
            }
        end
    end,
}, true)

-- Vampire does not view Invisible cards
SMODS.Joker:take_ownership('vampire', {
    calculate = function(self, card, context)
        if
            context.before
            and not context.blueprint
        then
            local points = 0
            MadLib.loop_func(context.scoring_hand, function(v)
                if
                    not (next(SMODS.get_enhancements(v)))
                    or v.debuff
                    or v.vampired
                    or MadLib.is_positive_number(v:get_quantity_value())
                then
                    return
                end
                points = v:get_quantity_value()
                v.vampired = true
                v:set_ability('c_base', nil, true)

                MadLib.event({
                    func = function()
                        v:juice_up()
                        v.vampired = nil
                        return true
                    end
                })
            end)
            if MadLib.is_positive_number(points) then
                card.ability.Xmult = MadLib.add(card.ability.Xmult, MadLib.multiply(card.ability.extra, points))
                return {
                    message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.Xmult } },
                    colour = G.C.MULT
                }
            end
        end
        if context.joker_main then
            return {
                x_mult = card.ability.Xmult
            }
        end
    end,
}, true)

-- Hologram
SMODS.Joker:take_ownership('hologram', {
    calculate = function(self, card, context)
        if
            context.playing_card_added
            and not context.blueprint
        then
            local points = 0
            MadLib.loop_func(context.cards, function(v)
                points = points + v:get_quantity_value()
            end)
            if MadLib.is_positive_number(points) then
                card.ability.Xmult = MadLib.add(card.ability.Xmult, MadLib.multiply(card.ability.extra, points))
                return {
                    message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.Xmult } },
                }
            end
        end
        if context.joker_main then
            return {
                Xmult = card.ability.Xmult
            }
        end
    end,
}, true)

-- Baseball Joker - now quantity compatible
SMODS.Joker:take_ownership('baseball', {
    calculate = function(self, card, context)
        if
            context.other_joker
            and (context.other_joker.config.center.rarity == 2 or context.other_joker.config.center.rarity == "Uncommon")
        then
            local amt = v:get_quantity_value()
            if amt > 0 then
                return {
                    xmult = MadLib.exponent(card.ability.extra.xmult, amt)
                }
            end
        end
    end,
}, true)

-- Trading Card - now quantity compatible
SMODS.Joker:take_ownership('trading', {
    calculate = function(self, card, context)
        if context.first_hand_drawn then
            local eval = function() return G.GAME.current_round.discards_used == 0 and not G.RESET_JIGGLES end
            juice_card_until(card, eval, true)
        end
        if
            context.discard
            and not context.blueprint
            and G.GAME.current_round.discards_used <= 0
            and #context.full_hand == 1
        then
            local amt = context.full_hand[1]:get_quantity_value()
            if MadLib.is_positive_number(amt) then return { dollars = MadLib.multiply(card.ability.extra, amt), remove = true } end
        end
    end
}, true)

-- Ramen - now quantity compatible
SMODS.Joker:take_ownership('ramen', {
    calculate = function(self, card, context)
        if 
            context.discard 
            and context.other_card
            and not context.blueprint 
        then
            if not MadLib.compare_numbers(MadLib.subtract(card.ability.Xmult, card.ability.extra), 1) < 1 then
                SMODS.destroy_cards(card, nil, nil, true)
                return {
                    message = localize('k_eaten_ex'),
                    colour = G.C.FILTER
                }
            else
                local amt       = context.other_card:get_quantity_value()
                local new_value = MadLib.subtract(card.ability.Xmult, MadLib.multiply(card.ability.extra, context.other:get_quantity_value()))
                if MadLib.is_positive_number(amt) then
                    card.ability.Xmult = new_value
                    return {
                        message = localize { type = 'variable', key = 'a_xmult_minus', vars = { new_value } },
                        colour = G.C.RED
                    }
                end
            end
        end
        if context.joker_main then
            return {
                xmult = card.ability.extra.Xmult
            }
        end
    end
}, true)

-- Castle - now quantity compatible
SMODS.Joker:take_ownership('castle', {
    config = { extra = { chips = 0, chip_mod = 3 } },
    loc_vars = function(self, info_queue, card)
        local suit = (G.GAME.current_round.castle_card or {}).suit or 'Spades'
        return { vars = { card.ability.extra.chip_mod, localize(suit, 'suits_singular'), card.ability.extra.chips, colours = { G.C.SUITS[suit] } } }
    end,
    calculate = function(self, card, context)
        if
            context.discard
            and not context.blueprint
            and not context.other_card.debuff
            and context.other_card:is_suit(G.GAME.current_round.castle_card.suit)
        then
            local amt = v:get_quantity_value()
            if amt > 0 then
                card.ability.extra.chips = MadLib.add(card.ability.extra.chips, MadLib.multiply(card.ability.extra.chip_mod * amt))
                return {
                    message = localize('k_upgrade_ex'),
                    colour = G.C.CHIPS
                }
            end
        end
        if context.joker_main then
            return {
                chips = card.ability.extra.chips
            }
        end
    end
}, true)

-- Arrowhead - Override Suit
SMODS.Joker:take_ownership('arrowhead', {
    config = { extra = 50, suit = 'Spades' },
    loc_vars = function(self, info_queue, card)
        local suit = Overloaded.Funcs.get_joker_suit(card, 'Spades')
        return { 
            vars = { card.ability.extra, localize(suit, 'suits_singular'),
            colours = { G.C.SUITS[suit] } },
        }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and context.other_card:is_suit(Overloaded.Funcs.get_joker_suit(card, 'Clubs')) then
            return { chips = card.ability.extra }
        end
    end,
}, true)

-- Onyx Agate - Override Suit
SMODS.Joker:take_ownership('onyx_agate', {
    config = { extra = 7, suit = 'Clubs' },
    loc_vars = function(self, info_queue, card)
        local suit = Overloaded.Funcs.get_joker_suit(card, 'Clubs')
        return { 
            vars = { card.ability.extra, localize(suit, 'suits_singular'),
            colours = { G.C.SUITS[suit] } },
        }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and context.other_card:is_suit(Overloaded.Funcs.get_joker_suit(card, 'Clubs')) then
            return { mult = card.ability.extra }
        end
    end,
}, true)

-- Bloodstone - Override Suit
SMODS.Joker:take_ownership('bloodstone', {
    config = { extra = { odds = 2, Xmult = 1.5}, suit = 'Hearts' },
    loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'bloodstone')
        local suit = Overloaded.Funcs.get_joker_suit(card, 'Hearts')
        return { 
            vars = { numerator, denominator, card.ability.extra.Xmult, localize(suit, 'suits_singular'),
            colours = { G.C.SUITS[suit] } },
        }
    end,
    calculate = function(self, card, context)
        if
            context.individual and context.cardarea == G.play 
            and context.other_card:is_suit(Overloaded.Funcs.get_joker_suit(card, 'Hearts')) 
            and SMODS.pseudorandom_probability(card, 'bloodstone', 1, card.ability.extra.odds) 
        then
            return { xmult = card.ability.extra.Xmult }
        end
    end,
}, true)

-- Rough Diamond - Override Suit
SMODS.Joker:take_ownership('rough_diamond', {
    config = { extra = 1, suit = 'Diamonds' },
    loc_vars = function(self, info_queue, card)
        local suit = Overloaded.Funcs.get_joker_suit(card, 'Diamonds')
        return { 
            vars = { card.ability.extra, localize(suit, 'suits_singular'),
            colours = { G.C.SUITS[suit] } },
        }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and context.other_card:is_suit(Overloaded.Funcs.get_joker_suit(card, 'Diamonds')) then
            G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) + card.ability.extra.dollars
            return {
                dollars = card.ability.extra.dollars,
                func = function() -- This is for timing purposes, it runs after the dollar manipulation
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            G.GAME.dollar_buffer = 0
                            return true
                        end
                    }))
                end
            }
        end
    end,
}, true)

-- Seeing Double - Override Suit
SMODS.Joker:take_ownership('seeing_double', {
    config = { extra = 2, suit = 'Clubs' },
    loc_vars = function(self, info_queue, card)
        local suit = Overloaded.Funcs.get_joker_suit(card, 'Clubs')
        return { 
            vars = { card.ability.extra, localize(suit, 'suits_singular'),
            colours = { G.C.SUITS[suit] } },
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local suit = Overloaded.Funcs.get_joker_suit(card, 'Clubs')
            if SMODS.seeing_double_check(context.scoring_hand, suit) then
                return { xmult = card.ability.extra }
            end
        end
    end,
}, true)

-- Sin Jokers
MadLib.loop_func({{'greedy', 'Diamonds'}, {'lusty', 'Hearts'}, {'wrathful', 'Spades'}, {'gluttenous', 'Clubs'}}, function (sinful)
    SMODS.Joker:take_ownership(sinful[1] .. '_joker', {
    config = { extra = { s_mult = 3, suit = sinful[2] } },
    loc_vars = function(self, info_queue, card)
        local suit = Overloaded.Funcs.get_joker_suit(card, sinful[2])
        return { 
            vars = { card.ability.extra.s_mult, localize(suit, 'suits_singular'), 
            colours = { G.C.SUITS[suit] } } 
        }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and
            context.other_card:is_suit(Overloaded.Funcs.get_joker_suit(card, sinful[2])) then
            return { mult = card.ability.extra.s_mult }
        end
    end,
    }, true)
end)

-- Mult Poker Hand cards
MadLib.loop_func({
    {'jolly', 'Pair'},
    {'zany', 'Three of a Kind'},
    {'mad', 'Two Pair'},
    {'crazy', 'Straight'},
    {'droll', 'Flush'},
}, function (joker)
    SMODS.Joker:take_ownership(joker[1], {
        loc_vars = function(self, info_queue, card)
            return { vars = { card.ability.t_mult, localize(Overloaded.Funcs.get_joker_hand(card, joker[2]), 'poker_hands') } }
        end,
        calculate = function(self, card, context)
            if context.joker_main and next(context.poker_hands[Overloaded.Funcs.get_joker_hand(card, joker[2])]) then
                return {
                    mult = card.ability.t_mult
                }
            end
        end
    })
end)

-- Chips Poker Hand cards
MadLib.loop_func({
    {'sly', 'Pair'},
    {'wily', 'Three of a Kind'},
    {'clever', 'Two Pair'},
    {'devious', 'Straight'},
    {'crafty', 'Flush'},
}, function (joker)
    SMODS.Joker:take_ownership(joker[1], {
        loc_vars = function(self, info_queue, card)
            return { vars = { card.ability.t_chips, localize(Overloaded.Funcs.get_joker_hand(card, joker[2]), 'poker_hands') } }
        end,
        calculate = function(self, card, context)
            if context.joker_main and next(context.poker_hands[Overloaded.Funcs.get_joker_hand(card, joker[2])]) then
                return {
                    chips = card.ability.t_chips
                }
            end
        end
    })
end)

-- XMult Poker Hand cards
MadLib.loop_func({
    {'duo', 'Pair'},
    {'trio', 'Three of a Kind'},
    {'family', 'Four of a Kind'},
    {'order', 'Straight'},
    {'tribe', 'Flush'},
}, function (joker)
    SMODS.Joker:take_ownership(joker[1], {
        loc_vars = function(self, info_queue, card)
            return { vars = { card.ability.Xmult, localize(Overloaded.Funcs.get_joker_hand(card, joker[2]), 'poker_hands') } }
        end,
        calculate = function(self, card, context)
            if context.joker_main and next(context.poker_hands[Overloaded.Funcs.get_joker_hand(card, joker[2])]) then
                return {
                    x_mult = card.ability.Xmult
                }
            end
        end
    })
end)



-- Superposition
SMODS.Joker:take_ownership('superposition', {
    config = { rank = 'Ace', type = 'Straight' },
    loc_vars = function(self, info_queue, card)
        return MadLib.collect_vars(localize(Overloaded.Funcs.get_joker_rank(card, 'Ace'), 'ranks'), localize(Overloaded.Funcs.get_joker_hand(card, 'Straight'), 'poker_hands'))
    end,
    calculate = function(self, card, context)
        if 
            context.joker_main
            and next(context.poker_hands[Overloaded.Funcs.get_joker_hand(card, 'Straight')])
            and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit
        then
            if MadLib.list_matches_one(context.scoring_hand, function(v)
                return MadLib.joker_check_rank(v, card, 'Ace')
            end) then
                MadLib.event({
                    func = (function()
                        SMODS.add_card { set = 'Tarot', key_append = 'superposition' }
                        G.GAME.consumeable_buffer = 0
                        return true
                    end)
                })
                return {
                    message = localize('k_plus_tarot'),
                    colour = G.C.SECONDARY_SET.Tarot,
                }
            end
        end
    end
}, true)


-- High Priestess uses config.planets for generation
-- Emperor uses config.tarots for generation
-- Temperance and Hermit uses config.extra for $$$

-- Tarots (enhancements)
MadLib.loop_func({
   'c_magician',
   'c_empress',
   'c_heirophant', -- what the fuck
   'c_chariot',
   'c_devil',
   'c_tower',
   'c_justice',
}, function(v)
    SMODS.Consumable:take_ownership(v, {
        loc_vars = function(self, info_queue, card)
            info_queue[#info_queue + 1] = G.P_CENTERS[card.ability.mod_conv]
            return MadLib.collect_vars( card.ability.max_highlighted, localize { type = 'name_text', set = 'Enhanced', key = card.ability.mod_conv })
        end,
        can_use = function(self, card)
            return MadLib.can_use_transform_tarot(card)
        end
    })
end)

-- Lovers: Can select up to 2 cards
SMODS.Consumable:take_ownership('c_lovers', {
    config = { mod_conv = 'm_wild', max_highlighted = 2 },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS[card.ability.mod_conv]
        return MadLib.collect_vars( card.ability.max_highlighted, localize { type = 'name_text', set = 'Enhanced', key = card.ability.mod_conv })
    end,
    can_use = function(self, card)
        return MadLib.can_use_transform_tarot(card)
    end
})

MadLib.loop_func({
   'c_star',
   'c_moon',
   'c_sun',
   'c_world',
}, function(v)
    SMODS.Consumable:take_ownership(v, {
        loc_vars = function(self, info_queue, card)
            return { vars = { card.ability.max_highlighted, localize(card.ability.suit_conv, 'suits_plural'), colours = { G.C.SUITS[card.ability.suit_conv] } } }
        end,
        can_use = function(self, card)
            return MadLib.can_use_transform_tarot(card)
        end
    })
end)

-- Tarots (max selections, not enhancements)
MadLib.loop_func({
   'c_strength',
   'c_hanged_man',
   'c_death',
}, function(v)
    SMODS.Consumable:take_ownership(v, {
        loc_vars = function(self, info_queue, card)
            return MadLib.collect_vars( card.ability.max_highlighted)
        end,
        can_use = function(self, card)
            return MadLib.can_use_transform_tarot(card)
        end
    })
end)

-- Spectral Seals
MadLib.loop_func({
   'c_talisman',
   'c_deja_vu',
   'c_trance',
   'c_medium',
}, function(v)
    SMODS.Consumable:take_ownership(v, {
        loc_vars = function(self, info_queue, card)
            info_queue[#info_queue + 1] = G.P_SEALS[card.ability.mod_conv]
            return MadLib.collect_vars( card.ability.max_highlighted, localize { type = 'name_text', set = 'Enhanced', key = card.ability.extra })
        end,
        can_use = function(self, card)
            return MadLib.can_use_transform_tarot(card)
        end
    })
end)

MadLib.loop_func({
   'c_mercury',
   'c_venus',
   'c_earth',
   'c_mars',
   'c_jupiter',
   'c_saturn',
   'c_uranus',
   'c_neptune',
   'c_pluto',
}, function(v)
    SMODS.Consumable:take_ownership(v, {
        use = function(self, card, area, copier)
            update_hand_text({sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3}, {
                    handname    = localize(card.ability.consumeable.hand_type, 'poker_hands'),
                    chips       = G.GAME.hands[card.ability.consumeable.hand_type].chips,
                    mult        = G.GAME.hands[card.ability.consumeable.hand_type].mult, 
                    level       = G.GAME.hands[card.ability.consumeable.hand_type].level
            })
            level_up_hand(card, card.ability.consumeable.hand_type)
            update_hand_text({sound = 'button', volume = 0.7, pitch = 1.1, delay = 0}, {mult = 0, chips = 0, handname = '', level = ''})
        end
    })
end)

        