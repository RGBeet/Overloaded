local factor = 5

local function add_to_mult(v)
    return 1 + v / factor
end

local function mult_to_add(v)
    return (v - 1) * factor
end

local function mult_to_exp(v)
    return 1 + (v - 1) / factor
end

local function exp_to_mult(v)
    return 1 + (v - 1) * factor
end

local function exp_to_hyper(v)
    return 1 + (v - 1) / factor
end

local function hyper_to_exp(v)
    return 1 + (v - 1) * factor
end

function Overloaded.Funcs.get_chip_operator_upgrade(op, value)
    local next_op = Overloaded.Lists.ChipModUpgrades[op]
    if not next_op then return op, value end

    if op == 'chips' or op == 'h_chips' or op == 'chip_mod' then
        return next_op, add_to_mult(value)

    elseif op == 'x_chips' or op == 'xchips' or op == 'Xchip_mod' then
        return next_op, mult_to_exp(value)

    elseif op == 'e_chips' or op == 'echips' or op == 'Echip_mod' then
        return next_op, exp_to_hyper(value)
    end

    return next_op, value
end

function Overloaded.Funcs.get_mult_operator_upgrade(op, value)
    local next_op = Overloaded.Lists.MultModUpgrades[op]
    if not next_op then return op, value end

    if op == 'mult' or op == 'h_mult' or op == 'mult_mod' then
        return next_op, add_to_mult(value)

    elseif op == 'x_mult' or op == 'xmult' or op == 'Xmult_mod' then
        return next_op, mult_to_exp(value)

    elseif op == 'e_mult' or op == 'emult' or op == 'Emult_mod' then
        return next_op, exp_to_hyper(value)
    end

    return next_op, value
end

function Overloaded.Funcs.get_chips_operator_downgrade(op, value)
    local next_op = Overloaded.Lists.ChipModDowngrades[op]
    if not next_op then return op, value end

    if op == 'x_chips' or op == 'xchips' or op == 'Xchip_mod' then
        return next_op, mult_to_add(value)

    elseif op == 'e_chips' or op == 'echips' or op == 'Echip_mod' then
        return next_op, exp_to_mult(value)

    elseif op == 'ee_chips' or op == 'eechips' or op == 'EEchip_mod' then
        return next_op, hyper_to_exp(value)
    end

    return next_op, value
end

function Overloaded.Funcs.get_mult_operator_downgrade(op, value)
    local next_op = Overloaded.Lists.MultModDowngrades[op]
    if not next_op then return op, value end

    if op == 'x_mult' or op == 'xmult' or op == 'Xmult_mod' then
        return next_op, mult_to_add(value)

    elseif op == 'e_mult' or op == 'emult' or op == 'Emult_mod' then
        return next_op, exp_to_mult(value)

    elseif op == 'ee_mult' or op == 'eemult' or op == 'EEmult_mod' then
        return next_op, hyper_to_exp(value)
    end

    return next_op, value
end

local calculate_effect_ref = SMODS.calculate_individual_effect
SMODS.calculate_individual_effect = function(effect, scored_card, key, amount, from_edition)
    local ret = calculate_effect_ref(effect, scored_card, key, amount, from_edition)

    return ret
end