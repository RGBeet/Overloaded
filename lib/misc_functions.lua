local is_rank_ref = MadLib.is_rank_full
function MadLib.is_rank_full(playing_card, key, values)
    values = values or { playing_card:get_id() }
	local ret = is_rank_ref(playing_card, key, values)
	return ret
end

-- Gets the # of empty slots - useful for editing.
function MadLib.get_empty_slots(area)
    if not area then return 0 end
    local num = area.config.card_limit + #SMODS.find_card("stencil", true)
    MadLib.loop_func(area.cards, function(v)
        num = num - (v:get_quantity_value() or 0)
    end)
    return num
end

function Overloaded.Funcs.get_modified_card_quantity(cards)
    local num = 0
    MadLib.loop_func(cards, function(v)
        num = num - (v:get_quantity_value() or 0)
    end)
    return num
end

function Overloaded.Funcs.level_up_parameters(card, hand, amount)
    local parameter_table = {}
    for name, parameter in pairs(SMODS.Scoring_Parameters) do parameter_table[name] = parameter end
    
    if card then
        if card.ability.planet_chips then 
            print('Manipulating chips mod - ' .. tostring(hand.chips) .. ' -> ' .. tostring(MadLib.add(hand.chips, card.ability.planet_chips)))
            parameter_table['chips'] = nil
            hand.chips = MadLib.add(hand.chips, card.ability.planet_chips)
        end
        
        if card.ability.planet_mult then 
            print('Manipulating mult mod - ' .. tostring(hand.mult) .. ' -> ' .. tostring(MadLib.add(hand.mult, card.ability.planet_mult)))
            parameter_table['mult'] = nil
            hand.mult = MadLib.add(hand.mult, card.ability.planet_mult)
        end
    end

    for name, parameter in pairs(parameter_table) do
        if hand[name] then parameter:level_up_hand(amount, hand) end
    end
end

function Overloaded.Funcs.get_planet_chips(cfg)
    local chips = G.GAME.hands[cfg.hand_type].l_chips
    if cfg.planet_chips then
        chips = cfg.planet_chips
    end
    return chips
end

function Overloaded.Funcs.get_planet_mult(cfg)
    local mult = G.GAME.hands[cfg.hand_type].l_mult
    if cfg.planet_mult then
        mult = cfg.planet_mult
    end
    return mult
end

--[[
    Edit edition stats
    self.edition.mult, self.edition.chips, self.edition.x_mult
]]

function Overloaded.Funcs.get_rarity(self, card)
    local ret = (card and card.ability.override_rarity) or (self and self.config.center.rarity)
    return ret
end

Overloaded.ValueAlter = {}

Overloaded.ValueAlter.Values = {
	['AddMult'] 		= { factor = 1, round = true, a_val = true, mult = true},
	['AddChips'] 		= { factor = 1, round = true, a_val = true, chips = true },
	['AddScore'] 		= { factor = 1, round = true, a_val = true, score = true },
	['MultiMult'] 		= { factor = 1, level = 1, x_val = true, mult = true, multiply = true },
	['MultiChips'] 		= { factor = 0.8, level = 1, x_val = true, chips = true, multiply = true },
	['MultiScore'] 		= { factor = 0.8, level = 1, x_val = true, score = true, multiply = true },
	['ExpMult'] 		= { factor = 0.5, level = 2, e_val = true, mult = true, multiply = true },
	['ExpChips'] 		= { factor = 0.5, level = 2, e_val = true, chips = true, multiply = true },
	['ExpScore'] 		= { factor = 0.5, level = 2, e_val = true, score = true, multiply = true },
	['AddMoney'] 		= { factor = 1.5, round = true, a_val = true, money = true },
	['HandSize']		= { factor = 0.5, level = 1, round = true, type = 'hand_size'},
	['PlayHands']		= { factor = 0.5, round = true },
	['PlayDiscards'] 	= { factor = 0.5, round = true },
	['Retriggers'] 		= { factor = 0.25, round = true },
	['AddLuxury'] 		= { factor = 0.8, round = true },
	['AddCards'] 		= { factor = 0.8, level = 2, round = true },
	['JokerSlots']		= { factor = 0.5, level = 1, round = true, type = 'joker_slots' },
	['VoucherLimit']	= { factor = 0.5, level = 2, round = true, type = 'voucher_limit' },
	['BoosterLimit']	= { factor = 0.5, level = 2, round = true, type = 'booster_limit' },
	['Probability']		= { factor = 1, },
	['Choose']			= { factor = 0.5, round = true },
	['Misc']			= { factor = 1, }
}

local ovav = Overloaded.ValueAlter.Values
Overloaded.ValueAlter.Conversions = {
	['cry_prob']		= ovav['Probability'],
	['odds']			= ovav['Probability'],

	['h_size']			= ovav['HandSize'],
	['h_mod']			= ovav['HandSize'],
	['handsize']		= ovav['HandSize'],

	['hand']			= ovav['PlayHands'],
	['hands']			= ovav['PlayHands'],
	['hand_mod']		= ovav['PlayHands'],
	['adds_hands']		= ovav['PlayHands'],

	['discard']			= ovav['PlayDiscards'],
	['discards']		= ovav['PlayDiscards'],
	['discard_mod']		= ovav['PlayDiscards'],
	['discard_size']	= ovav['PlayDiscards'],

	['jokerslots']		= ovav['JokerSlots'],
	['joker_slots']		= ovav['JokerSlots'],
	['voucher_limit']	= ovav['VoucherLimit'],
	['booster_limit']	= ovav['BoosterLimit'],
	['extra_choices']	= ovav['ExtraChoices'],
	['retriggers']		= ovav['Retriggers'],
	['repetitions']		= ovav['Retriggers'],

	['perma_repetitions'] = ovav['Retriggers'],

	['mult']			= ovav['AddMult'],
	['mult_mod']		= ovav['AddMult'],
	['h_mult']			= ovav['AddMult'],
	['perma_mult']		= ovav['AddMult'],
	['s_mult']	        = ovav['AddMult'],
	['t_mult']	        = ovav['AddMult'],
	['a_mult']			= ovav['AddMult'],
	['phmult']			= ovav['AddMult'],

	['perma_chips']		= ovav['AddChips'],
	['chips']			= ovav['AddChips'],
	['h_chips']			= ovav['AddChips'],
	['chip_mod']		= ovav['AddChips'],
	['t_chips']			= ovav['AddChips'],
	['a_chips']			= ovav['AddChips'],
	['chip_gain']		= ovav['AddChips'],
	['chip_loss']		= ovav['AddChips'],
	['perma_h_chips']	= ovav['AddChips'],
	['phchips']			= ovav['AddChips'],

	['curchips']		= ovav['AddMoney'],
	['bonuschips']		= ovav['AddMoney'],

	['dollars']		    = ovav['AddMoney'],
	['money']		    = ovav['AddMoney'],
	['h_dollars']		= ovav['AddMoney'],
	['p_dollars']		= ovav['AddMoney'],

	['x_mult']			= ovav['MultiMult'],
	['h_x_mult']		= ovav['MultiMult'],
	['xmult']			= ovav['MultiMult'],
	['Xmult']			= ovav['MultiMult'],
	['Xmult_gain']		= ovav['MultiMult'],
	['itemmult']		= ovav['MultiMult'],
	['my_x_mult']		= ovav['MultiMult'],

	['xchips']			= ovav['MultiChips'],
	['x_chips']			= ovav['MultiChips'],
	['h_x_chips']		= ovav['MultiChips'],
	['perma_x_mult']		= ovav['MultiMult'],
	['perma_h_x_mult']		= ovav['MultiMult'],
	['perma_x_chips']		= ovav['MultiChips'],
	['perma_h_x_chips']		= ovav['MultiChips'],
	['max_highlighted']	    = ovav['Choose'],
	['choose']			    = ovav['Choose'],
}

-- Blacklisted because there would be no effect
Overloaded.ValueAlter.Blacklist = {
	'j_four_fingers',
	'j_splash',
	'j_pareidolia',
	'j_riff_raff',
	'j_diet_cola',
	'j_luchador',
	'j_shortcut',
	'j_mr_bones',
	'j_chicot',
	'j_blueprint',
	'j_brainstorm',
	'j_smeared',
	'j_midas_mask',
	'j_ring_master'
}

-- used to define what extra means for the vanilla jokers (which work differently?)
-- also works with any joker that has undefined variables.
Overloaded.ValueAlter.Extras = {
	['j_loyalty_card'] 		= { ['every'] = ovav['Misc'] }, -- every ? rounds
	['j_8_ball'] 			= { ['extra'] = ovav['Probability'] }, -- 1 in ? chance
	['j_misprint'] 			= { ['max'] = ovav['AddMult'], ['min'] = ovav['AddMult'] }, -- min and max mult
	['j_chaos'] 			= { ['extra'] = ovav['Misc'] }, -- reroll
	['j_fibonacci'] 		= { ['extra'] = ovav['AddMult'] },
	['j_steel_joker'] 		= { ['extra'] = ovav['MultiMult'] },
	['j_scary_face'] 		= { ['extra'] = ovav['AddChips'] },
	['j_abstract'] 			= { ['extra'] = ovav['AddMult'] },
	['j_delayed_grat'] 		= { ['extra'] = ovav['AddMoney'] },
	['j_hack'] 				= { ['extra'] = ovav['Retriggers'] },
	['j_even_steven'] 		= { ['extra'] = ovav['AddMult'] },
	['j_odd_todd'] 			= { ['extra'] = ovav['AddChips'] },
	['j_business'] 			= { ['extra'] = ovav['Probability'] },
	['j_egg'] 				= { ['extra'] = ovav['AddMoney'] },
	['j_burglar'] 			= { ['extra'] = ovav['PlayHands'] },
	['j_blackboard'] 		= { ['extra'] = ovav['MultiMult'] },
	['j_supernova'] 		= { ['extra'] = ovav['AddMult'] },
	['j_ride_the_bus'] 		= { ['extra'] = ovav['AddMult'] },
	['j_space'] 			= { ['extra'] = ovav['Probability'] },
	['j_blue_joker']	 	= { ['extra'] = ovav['AddChips'] },
	['j_constellation']		= { ['extra'] = ovav['AddChips'] },
	['j_red_card']			= { ['extra'] = ovav['AddMult'] },
	['j_madness']			= { ['extra'] = ovav['MultiMult'] },
	['j_riff_raff']			= { ['extra'] = ovav['JokerSlots'] },
	['j_vagabond'] 			= { ['extra'] = ovav['AddMoney'] },
	['j_baron'] 			= { ['extra'] = ovav['MultiMult'] },
	['j_cloud_9'] 			= { ['extra'] = ovav['AddMoney'] },
	['j_obelisk'] 			= { ['extra'] = ovav['MultiMult'] },
	['j_photograph'] 		= { ['extra'] = ovav['MultiMult'] },
	['j_gift'] 				= { ['extra'] = ovav['AddMoney'] },
	['j_erosion'] 			= { ['extra'] = ovav['AddMult'] },
	['j_mail'] 				= { ['extra'] = ovav['AddMoney'] },
	['j_to_the_moon'] 		= { ['extra'] = ovav['AddMoney'] },
	['j_hallucination'] 	= { ['extra'] = ovav['Probability'] },
	['j_fortune_teller'] 	= { ['extra'] = ovav['AddMult'] },
	['j_stone'] 			= { ['extra'] = ovav['AddChips'] },
	['j_golden'] 			= { ['extra'] = ovav['AddMoney'] },
	['j_lucky_cat'] 		= { ['extra'] = ovav['MultiMult'] },
	['j_baseball'] 			= { ['extra'] = ovav['MultiMult'] },
	['j_bull'] 				= { ['extra'] = ovav['AddChips'] },
	['j_trading'] 			= { ['extra'] = ovav['AddMoney'] },
	['j_flash'] 			= { ['extra'] = ovav['AddMult'] },
	['j_popcorn'] 			= { ['extra'] = ovav['AddMult'] },
	['j_trousers'] 			= { ['extra'] = ovav['AddMult'] },
	['j_ancient'] 			= { ['extra'] = ovav['MultiMult'] },
	['j_ramen'] 			= { ['extra'] = ovav['MultiMult'] },
	['j_seltzer'] 			= { ['extra'] = ovav['Retriggers'] },
	['j_smiley'] 			= { ['extra'] = ovav['AddMult'] },
	['j_campfire'] 			= { ['extra'] = ovav['MultiMult'] },
	['j_ticket'] 			= { ['extra'] = ovav['AddMoney'] },
	['j_acrobat'] 			= { ['extra'] = ovav['MultiMult'] },
	['j_sock_and_buskin'] 	= { ['extra'] = ovav['Retriggers'] },
	['j_throwback'] 		= { ['extra'] = ovav['MultiMult'] },
	['j_hanging_chad'] 		= { ['extra'] = ovav['Retriggers'] },
	['j_rough_gem'] 		= { ['extra'] = ovav['AddMoney'] },
	['j_arrowhead'] 		= { ['extra'] = ovav['AddChips'] },
	['j_onyx_agate'] 		= { ['extra'] = ovav['AddMult'] },
	['j_glass'] 			= { ['extra'] = ovav['MultiMult'] },
	['j_flower_pot'] 		= { ['extra'] = ovav['MultiMult'] },
	['j_idol'] 				= { ['extra'] = ovav['MultiMult'] },
	['j_seeing_double'] 	= { ['extra'] = ovav['MultiMult'] },
	['j_matador'] 			= { ['extra'] = ovav['AddMoney'] },
	['j_hit_the_road'] 		= { ['extra'] = ovav['MultiMult'] },
	['j_invisible'] 		= { ['extra'] = ovav['Misc'] }, -- rounds
	['j_satellite'] 		= { ['extra'] = ovav['AddMoney'] },
	['j_shoot_the_moon'] 	= { ['extra'] = ovav['AddMult'] },
	['j_drivers_license'] 	= { ['extra'] = ovav['MultiMult'] },
	['j_caino'] 			= { ['extra'] = ovav['MultiMult'] },
	['j_triboulet'] 		= { ['extra'] = ovav['MultiMult'] },
	['j_cry_soccer'] 		= { ['holygrail'] = ovav['Misc'] }, -- One For All
	['c_emperor'] 			= { ['tarots'] = ovav['Misc'] },
	['c_hermit'] 			= { ['extra'] = ovav['AddMoney'] },
	['c_temperance'] 		= { ['extra'] = ovav['AddMoney'] },
	['j_vampire']           = { ['extra'] = ovav['MultiMult'] },
	['j_banner']            = { ['extra'] = ovav['AddChips'] },

	['j_mf_mspaint']        = { ['extra'] = ovav['HandSize'] },
}

Overloaded.ValueAlter.SetValues = {
}

function Overloaded.Funcs.apply_percentage(base, percent)
    return MadLib.add(base, MadLib.multiply(MadLib.subtract(base, 1), MadLib.subtract(percent, 1)))
end

function Overloaded.Funcs.loop_thru(card, t, div, prefix, whitelist, blacklist, did_something)
	did_something = did_something or false
    prefix = prefix or ''
	if prefix == 'extra' then
		print('LOOKING THROUGH EXTRA TABLE!')
	end
    local data = nil
    for k, v in pairs(t) do
        if type(v) == 'table' then
            prefix = prefix .. '/' .. k
            did_something = did_something or Overloaded.Funcs.loop_thru(card, t[k], div, prefix, whitelist, blacklist)
        elseif type(v) == 'number' then
            local valid = nil
            local amt   = MadLib.deep_copy(t[k])
			local pass 	= true

            if 
                Overloaded.ValueAlter.Extras[card.config.center.key] 
                and Overloaded.ValueAlter.Extras[card.config.center.key][k]
            then
                data = Overloaded.ValueAlter.Extras[card.config.center.key][k]
            elseif 
                Overloaded.ValueAlter.SetValues[card.config.center.key] 
                and Overloaded.ValueAlter.SetValues[card.config.center.key][k]
            then
                data = Overloaded.ValueAlter.SetValues[card.config.center.key][k]
            else
                data = Overloaded.ValueAlter.Conversions[k]
            end

			if data then
				if whitelist then
					MadLib.loop_func(whitelist, function(v1)
						if not pass then return end
						pass = (data[v1] ~= nil)
					end)
				end

				if blacklist then
					MadLib.loop_func(blacklist, function(v1)
						if not pass then return end
						pass = (data[v1] == nil)
					end)
				end

				if pass then
					if data.multiply then
						pass = pass and MadLib.compare_numbers(t[k], 1) ~= 0 and MadLib.compare_numbers(t[k], 0) ~= 0 -- X1 means nothing
					else
						pass = pass and MadLib.compare_numbers(t[k], 0) ~= 0 -- +0 means nothing
					end
				end
			end

            if data and pass then
				local factor = data.factor or 1
                valid = (data.multiply == true and amt ~= 1) or (not data.multiply and amt ~= 0)
				did_something = true

                if valid then
                    local mult = MadLib.multiply(factor, (div or 1))

                    if data.multiply then
                        t[k] = Overloaded.Funcs.apply_percentage(amt, mult)
                    else
                        t[k] = MadLib.multiply(amt, mult)
                    end

                    if data.multiply and MadLib.compare_numbers(t[k], 0.5) < 0 then
						t[k] = 0.5
					end
                    
                    if data.round then t[k] = math.ceil(t[k]) end
				else
                end
            end
        end
    end
	return did_something
end

Overloaded.Lists.WhitelistRarities = {
	1,
	2,
	3,
	4,
	'rgmc_unusual'
}

function Overloaded.Funcs.set_joker_rarity(card, new_rarity)
    local old_rarity = card.ability.override_rarity or card.config.center.rarity

	if not
		MadLib.list_matches_one(Overloaded.Lists.WhitelistRarities, function(v) return old_rarity == v end)
		and MadLib.list_matches_one(Overloaded.Lists.WhitelistRarities, function(v) return new_rarity == v end)
	then
		return false
	end

    card.ability.override_rarity = new_rarity
    local new_value = MadLib.get_rarity_value(new_rarity)
    local old_value = MadLib.get_rarity_value(old_rarity)
    
    local difference = MadLib.subtract(new_value, old_value)

    local get_value = function(n)
        return 0.25 * (n^2) - 0.25 * n + 0.5
        --return 2 ^ (a - 2)
    end

    if difference ~= 0 and new_value ~= old_value then
        Overloaded.Funcs.loop_thru(card, card.ability, MadLib.divide(get_value(new_value), get_value(old_value)))
		card.sell_cost = MadLib.multiply(card.sell_cost, MadLib.divide(get_value(new_value), get_value(old_value)))
    end

    -- value * (newX/oldX)

    if tostring(card.ability.override_rarity) == tostring(card.config.center.rarity) then -- same rarity?
        card.ability.override_rarity = nil
    end

	return true
end

--[[
    0.75, 1.00, 1.25, 1.50

    75, 100, 125, 150
]]

function Overloaded.Funcs.get_vals(card,default,x1,x2)
	return card.ability[x2] 
		or (type(card.ability.extra) == 'table' and card.ability.extra[x1]) 
		or card.ability[x1] 
		or default
end

function Overloaded.Funcs.get_joker_rank(card, default)
	return Overloaded.Funcs.get_vals(card, default, 'rank', 'override_rank')
end


function Overloaded.Funcs.get_joker_ranks(card, default)
	return Overloaded.Funcs.get_vals(card, default, 'ranks', 'override_ranks')
end

function Overloaded.Funcs.get_joker_suit(card, default)
	local joker_override = nil
	local jokers = G.jokers.cards
	for i=1, #jokers do
		local d = jokers[i].config.center.modify_joker_suit and jokers[i].config.center:modify_joker_suit(jokers[i], card, jokers)
		joker_override = joker_override or (d ~= nil and d.set_override)
	end
	return joker_override or Overloaded.Funcs.get_vals(card, default, 'suit', 'override_suit')
end

if Madcap and Madcap.Funcs then
	Madcap.Funcs.get_joker_suit = Overloaded.Funcs.get_joker_suit
	print('Replaced!')
end

function Overloaded.Funcs.get_joker_suits(card, default)
	return Overloaded.Funcs.get_vals(card, default, 'suits', 'override_suits')
end

function Overloaded.Funcs.get_joker_hand(card, default)
	return card.ability.override_poker_hand
		or card.ability.type
		or card.ability.poker_hand
		or (type(card.ability.extra) == 'table' and card.ability.extra.poker_hand)
		or default
end

function Overloaded.Funcs.get_joker_hands(card, default)
	return card.ability.override_poker_hands
		or card.ability.type
		or card.ability.poker_hands
		or (type(card.ability.extra) == 'table' and card.ability.extra.poker_hands)
		or default
end

function Overloaded.Funcs.get_original_rank(card)
    return Overloaded.Funcs.get_vals(card, '???', 'rank')
end

function Overloaded.Funcs.get_original_ranks(card)
    return Overloaded.Funcs.get_vals(card, 'ranks', 'ranks')
end

function Overloaded.Funcs.get_original_suit(card)
    return Overloaded.Funcs.get_vals(card, 'suit', 'suit')
end

function Overloaded.Funcs.get_original_suits(card)
    return Overloaded.Funcs.get_vals(card, 'suits', 'suits')
end

function Overloaded.Funcs.get_original_poker_hand(card)
    if not card then return nil end
    if card.ability.type then
        return card.ability.type
    elseif type(card.ability.extra) == 'table' then
        return card.ability.extra.poker_hand
    elseif card.ability.poker_hand then
        return card.ability.poker_hand
    end
    return nil
end

function Overloaded.Funcs.get_original_poker_hands(card)
    if not card then return nil end
    if type(card.ability.extra) == 'table' then
        return card.ability.extra.poker_hands
    elseif card.ability.poker_hands then
        return card.ability.poker_hands
    end
    return nil
end

function Overloaded.Funcs.get_rarity_localization(rarity)
    local rarities 		= {"common", "uncommon", "rare", "legendary"}
    local final_value 	= rarities[rarity] or rarity
	return localize('k_' .. final_value)
end

function Overloaded.Funcs.get_bootstrap_calc(value1, value2)
	return MadLib.multiply(value1, math.floor(MadLib.divide(MadLib.add((G.GAME.dollars or 0), (G.GAME.dollar_buffer or 0)), value2)))
end

local modifyable = function(str)
	return card.ability['override_'..str] or card.ability['override_'..str..'s']
		or card.ability[str] or card.ability[str..'s'] or card.ability.extra[str] or card.ability.extra[str..'s']
end

function Overloaded.Funcs.can_modify_ranks(card)
	return card and modifyable('rank')
end

function Overloaded.Funcs.can_modify_suits(card)
	return card and modifyable('suits')
end

function Overloaded.Funcs.can_modify_poker_hand(card)
	return card and (card.ability.type or card.ability.extra.type or card.ability.extra.poker_hand)
end

function Overloaded.Funcs.get_lowest(hand)
  	local lowest = nil
	for k, v in ipairs(hand) do
		if (not lowest) or (v:get_nominal() < lowest:get_nominal()) then
			lowest = v
		end
  	end
  	return #hand > 0 and {{ lowest }} or {}
end

function Overloaded.Funcs.modify_repetitions(eval, effect_card, _type)
	local repetitions = eval.repetitions
	MadLib.loop_func(G.jokers.cards, function(v)
		if MadLib.is_joker(v, 'j_rgol_tiebreaker') then repetitions = repetitions + v.ability.extra end
	end)
	return repetitions
end

function Overloaded.Funcs.override_rank_singular(used_card, target, new_value)
	if joker.ability.rank or (joker.ability.extra and joker.ability.extra.rank) then -- TODO: check if compatible?
		MadLib.event({
			func = function()
				joker.ability.override_rank = new_value
				used_card:juice_up(0.3, 0.5)
				play_sound('rgol_modify_value')
				return true
			end
		})
	elseif target.ability.ranks or (joker.ability.extra and joker.ability.extra.ranks) then
		MadLib.event({
			func = function()
				target.ability.override_suits = { new_value, nil }
				for i=2,#target.ability.ranks do
					target.ability.override_suits[i] = MadLib.get_random_suit_from_cards(G.playing_cards)
				end
                used_card:juice_up(0.3, 0.5)
				play_sound('rgol_modify_value')
				return true
			end
		})
	end
end

function Overloaded.Funcs.override_suit_singular(used_card, target, new_value)
	if joker.ability.suit then -- TODO: check if compatible?
		MadLib.event({
			func = function()
				joker.ability.override_suit = new_value
				used_card:juice_up(0.3, 0.5)
				play_sound('rgol_modify_value')
				return true
			end
		})
	elseif target.ability.suits then
		MadLib.event({
			func = function()
				target.ability.override_suits = { new_value, nil }
				for i=2,#target.ability.ranks do
					target.ability.override_suits[i] = MadLib.get_random_suit_from_cards(G.playing_cards)
				end
                used_card:juice_up(0.3, 0.5)
				play_sound('rgol_modify_value')
				return true
			end
		})
	end
end

function Overloaded.Funcs.override_hand_singular(used_card, target, new_value)
	if target.ability.type or target.ability.poker_hand or target.ability.extra.poker_hand then
		MadLib.event({
			func = function()
				target.ability.override_poker_hand = new_value
				used_card:juice_up(0.3, 0.5)
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


function Overloaded.Funcs.get_strength_effect(v, amount, enable_random)
    local rank_key = v
    local rank_data = SMODS.Ranks[v]
	if rank_data then
		if amount > 0 then
			for _ = 1, amount do
				local behavior = rank_data.strength_effect or { fixed = 1, ignore = false, random = false }
				if behavior.ignore or not next(rank_data.next) then
					break
				elseif enable_random and behavior.random then
					rank_key = pseudorandom_element(
						rank_data.next,
						pseudoseed('strength'),
						{ in_pool = function(key) return SMODS.add_to_pool(SMODS.Ranks[key], { suit = card.base.suit }) end }
					)
				else
					local i = (behavior.fixed and rank_data.next[behavior.fixed]) and behavior.fixed or 1
					rank_key = rank_data.next[i]
				end
				rank_data = SMODS.Ranks[rank_key]
			end
		else
			for _ = 1, -amount do
				local behavior = rank_data.prev_behavior or { fixed = 1, ignore = false, random = false }
				if not next(rank_data.prev) or behavior.ignore then
					break
				elseif enable_random and behavior.random then
					rank_key = pseudorandom_element(
						rank_data.prev,
						pseudoseed('weakness'),
						{ in_pool = function(key) return SMODS.add_to_pool(SMODS.Ranks[key], { suit = card.base.suit }) end }
					)
				else
					local i = (behavior.fixed and rank_data.prev[behavior.fixed]) and behavior.fixed or 1
					rank_key = rank_data.prev[i]
				end
				rank_data = SMODS.Ranks[rank_key]
			end
		end
	end
	return rank_key
end

function Overloaded.Funcs.create_joker_strange(_area)
    local overclocked_pass = pseudorandom('overclocked', 1, 5) < 2
    local card = SMODS.create_card {
        set = "Joker",
        rarity = overclocked_pass and "rgol_overclocked" or "rgol_strange",
        area = _area,
        key_append = "rgol"
    }
	return card
end