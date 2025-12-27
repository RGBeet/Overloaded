-- Allows modifying the planet chips upon creation
local create_card_ref = create_card
function create_card(_type, area, legendary, _rarity, skip_materialize, soulable, forced_key, key_append)
    local card = create_card_ref(_type, area, legendary, _rarity, skip_materialize, soulable, forced_key, key_append)
    --rint("CREATE CARD!")
    if (_type == 'Joker') then
        local modify_joker = SMODS.calculate_context({ ol_modifying_joker = true, other_card = card })
        if modify_joker then
        end
    elseif (_type == 'Planet') then
        local modify_planet = SMODS.calculate_context({ ol_modifying_planet = true, other_card = card })
        if modify_planet then
        end
    end

    return card
end

-- Override rarity
local is_rarity_ref = Card.is_rarity
function Card:is_rarity(rarity)
    if self.config.override_rarity ~= nil then
        local rarities = {"Common", "Uncommon", "Rare", "Legendary"}
        rarity = rarities[rarity] or rarity
        local own_rarity = rarities[self.config.override_rarity] or self.config.override_rarity
        return own_rarity == rarity or SMODS.Rarities[own_rarity] == rarity
    end
    return is_rarity_ref(self, rarity)
end

function MadLib.get_rarity(rarity)
    local rarities = {"Common", "Uncommon", "Rare", "Legendary"}
    local ret = rarities[rarity] or rarity
    return ret
end

function Card:get_rarity()
    return self.config.override_rarity or (self.config.center and self.config.center.rarity)
end

local get_vals = function(c, s)
    return c and (c.ability and (type(c.ability.extra) == 'table' and c.ability.extra[s]) or c.ability[s]) or nil
end

local set_joker_ui_ref = MadLib.set_joker_ui
function MadLib.set_joker_ui(card, info_queue, specific_vars, desc_nodes)
    local t = set_joker_ui_ref(card, info_queue, specific_vars, desc_nodes)
    if card then
        if card.config.center and card.config.center.rarity and card.ability.override_rarity then
            info_queue[#info_queue + 1] = {
                set = 'Other',
                key = 'rgol_modified_rarity',
                vars = {
                    MadLib.get_rarity(Overloaded.Funcs.get_rarity_localization(card.config.center.rarity)),
                    MadLib.get_rarity(Overloaded.Funcs.get_rarity_localization(card.ability.override_rarity)),
                }
            }
        end
        if card.ability.override_rank then
            info_queue[#info_queue + 1] = {
                set = 'Other',
                key = 'rgol_modified_rank',
                vars = {
                    localize(Overloaded.Funcs.get_original_rank(card), 'ranks'),
                    localize(card.ability.override_rank, 'ranks'),
                }
            }
        end
        if card.ability.override_suit then
            info_queue[#info_queue + 1] = {
                set = 'Other',
                key = 'rgol_modified_suit',
                vars = {
                    localize(Overloaded.Funcs.get_original_suit(card), 'suits_plural'), 
                    localize(card.ability.override_suit, 'suits_plural'),
                    colours = { G.C.SUITS[card.ability.suit], G.C.SUITS[card.ability.override_suit] }
                }
            }
        end
        if card.ability.override_poker_hand then
            info_queue[#info_queue + 1] = {
                set = 'Other',
                key = 'rgol_modified_poker_hand',
                vars = {
                    localize(Overloaded.Funcs.get_original_poker_hand(card), 'poker_hands'),
                    localize(card.ability.override_poker_hand, 'poker_hands')
                }
            }
        end
    end
    return t
end

local joker_check_rank_ref = MadLib.joker_check_rank
function MadLib.joker_check_rank(card, joker, default)
    if joker.ability.override_rank then return MadLib.is_rank(card, SMODS.Ranks[joker.ability.override_rank].id) end
    return joker_check_rank_ref(card, joker, default)
end

Overloaded.Config.AllowCalcSFX = true

function Overloaded.Funcs.get_stat_sound(type)
    return type == 'chips' and 'rgol_mod_chips'
        or type == 'mult' and 'rgol_mod_mult'
        or 'rgol_mod_stat'
end

local calculate_effect_ref = SMODS.calculate_individual_effect
SMODS.calculate_individual_effect = function(effect, scored_card, key, amount, from_edition)
    G.GAME.modifiers.overloaded_chips_mod   = G.GAME.modifiers.overloaded_chips_mod or 1
    G.GAME.modifiers.overloaded_mult_mod    = G.GAME.modifiers.overloaded_mult_mod or 1
    local modded_value = nil
    if G.jokers then
        for _, v in pairs(G.jokers.cards) do
            if v.config.center.modify_individual_effect then
                local data = v.config.center:modify_individual_effect(v, key, scored_card)
                if data then
                    if data.a_mod then
                        modded_value = MadLib.add(modded_value or amount, data.a_mod)
                        Overloaded.temp.pitches['mod'] = Overloaded.temp.pitches['mod'] + 0.08
				        card_eval_status_text(v, 'extra', nil, nil, nil, {
                            message = '+' .. data.a_mod .. " Values", 
                            sound   = Overloaded.Funcs.get_stat_sound(data.type),
                            pitch   = Overloaded.temp.pitches['mod'],
                            colour  = data.colour
                        })
                    end
                    if data.x_mod then
                        modded_value = MadLib.multiply(modded_value or amount, data.x_mod)
                        Overloaded.temp.pitches['mod'] = Overloaded.temp.pitches['mod'] + 0.08
				        card_eval_status_text(v, 'extra', nil, nil, nil, {
                            message = 'X' .. data.x_mod .. " Values", 
                            sound   = Overloaded.Funcs.get_stat_sound(data.type),
                            pitch   = Overloaded.temp.pitches['mod'],
                            colour  = data.colour
                        })
                    end
                    if data.e_mod then
                        modded_value = MadLib.exponent(modded_value or amount, data.e_mod)
                        Overloaded.temp.pitches['mod'] = Overloaded.temp.pitches['mod'] + 0.08
				        card_eval_status_text(v, 'extra', nil, nil, nil, {
                            message = '^' .. data.e_mod .. " Values", 
                            sound   = Overloaded.Funcs.get_stat_sound(data.type),
                            pitch   = Overloaded.temp.pitches['mod'],
                            colour  = data.colour
                        })
                    end
                end
            end
        end
    end
    if modded_value then
        print('New amount is ' .. number_format(modded_value) .. '.')
        return calculate_effect_ref(effect, scored_card, key, modded_value, from_edition)
    end
	return calculate_effect_ref(effect, scored_card, key, amount, from_edition)
end

local evaluate_play_ref = G.FUNCS.evaluate_play
Overloaded.temp = {}
G.FUNCS.evaluate_play = function(e)
    Overloaded.temp.pitches = { mod = 0 }
    evaluate_play_ref(e)
end

local get_rank_values_ref = MadLib.get_rank_values
function MadLib.get_rank_values(card)
    local values = get_rank_values_ref(card)
    -- Check Jokers first
    MadLib.loop_func(G.jokers.cards, function(joker)
        if not joker.modify_card_rank then return end -- cannot modify ranks
        local ret = joker:modify_card_rank(joker, card, values)
        if ret.rank then -- string
            values[#values+1] = ret.rank
        elseif ret.ranks then -- table
            MadLib.loop_func(ret.ranks, function(v2) values[#values+1] = v2; end)
        end
    end)
    return values
end

local highest_ref = get_highest
function get_highest(hand)
	if G.GAME.low_card_active then
		return Overloaded.Funcs.get_lowest(hand)
	end
	return highest_ref(hand)
end