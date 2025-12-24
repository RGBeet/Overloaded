-- Allows modifying the planet chips upon creation
local create_card_ref = create_card
function create_card(_type, area, legendary, _rarity, skip_materialize, soulable, forced_key, key_append)
    local card = create_card_ref(_type, area, legendary, _rarity, skip_materialize, soulable, forced_key, key_append)
    --rint("CREATE CARD!")
    if (_type == 'Joker') then
        print('Modify Joker')
        Overloaded.Funcs.set_joker_rarity(card, 3)
        if card.ability.rank then
            card.ability.override_rank = '2'
        end
    elseif (_type == 'Planet') then
        print('Modify Planet')
        --card.ability.planet_chips = 100
        --card.ability.planet_mult  = 20
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

local set_joker_ui_ref = MadLib.set_joker_ui
function MadLib.set_joker_ui(card, info_queue, specific_vars, desc_nodes)
    local t = set_joker_ui_ref(card, info_queue, specific_vars, desc_nodes)
    if card then
        if card.config.center and card.config.center.rarity and card.ability.override_rarity then
            info_queue[#info_queue + 1] = {
                set = 'Other',
                key = 'rgol_modified_rarity',
                vars = { 
                    MadLib.get_rarity(card.config.center.rarity),
                    MadLib.get_rarity(card.ability.override_rarity),
                }
            }
        end
        if card.ability.rank and card.ability.override_rank then
            info_queue[#info_queue + 1] = {
                set = 'Other',
                key = 'rgol_modified_rank',
                vars = { 
                    localize(card.ability.rank, 'ranks'),
                    localize(card.ability.override_rank, 'ranks'),
                }
            }
        end
        if card.ability.suit and card.ability.override_suit then
            info_queue[#info_queue + 1] = {
                set = 'Other',
                key = 'rgol_modified_suit',
                vars = { 
                    localize(card.ability.suit, 'suits_plural'), 
                    localize(card.ability.override_suit, 'suits_plural'),
                    colours = { G.C.SUITS[card.ability.suit], G.C.SUITS[card.ability.override_suit] }
                }
            }
        end
    end
    return t
end

local is_rank_ref = MadLib.is_rank
function MadLib.is_rank(card, id, bypass_rankless, base_id)
    return is_rank_ref(card, id, bypass_rankless, base_id)
end

local joker_check_rank_ref = MadLib.joker_check_rank
function MadLib.joker_check_rank(card, joker, default)
    if joker.ability.override_rank then return MadLib.is_rank(card, SMODS.Ranks[joker.ability.override_rank].id) end
    return joker_check_rank_ref(card, joker, default)
end