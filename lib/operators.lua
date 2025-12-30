local function add_to_mult(v)
    return 1 + v / 100
end

local function mult_to_add(v)
    return (v - 1) * 100
end

local function mult_to_exp(v)
    return 1 + (v - 1) / 10
end

local function exp_to_mult(v)
    return 1 + (v - 1) * 10
end

local function exp_to_hyper(v)
    return 1 + (v - 1) / 100
end

local function hyper_to_exp(v)
    return 1 + (v - 1) * 100
end

function Overloaded.Funcs.get_chip_operator_upgrade(op, value)
    local next_op = Overloaded.Lists.ChipModUpgrades[op]
    if not next_op then return op, value end

    if op == 'chips' or op == 'h_chips' then
        return next_op, add_to_mult(value)

    elseif op == 'x_chips' or op == 'xchips' then
        return next_op, mult_to_exp(value)

    elseif op == 'e_chips' or op == 'echips' then
        return next_op, exp_to_hyper(value)
    end

    return next_op, value
end

function Overloaded.Funcs.get_mult_operator_upgrade(op, value)
    local next_op = Overloaded.Lists.MultModUpgrades[op]
    if not next_op then return op, value end

    if op == 'mult' or op == 'h_mult' then
        return next_op, add_to_mult(value)

    elseif op == 'x_mult' or op == 'xmult' then
        return next_op, mult_to_exp(value)

    elseif op == 'e_mult' or op == 'emult' then
        return next_op, exp_to_hyper(value)
    end

    return next_op, value
end

function Overloaded.Funcs.get_chip_operator_downgrade(op, value)
    local next_op = Overloaded.Lists.ChipModDowngrades[op]
    if not next_op then return op, value end

    if op == 'x_chips' or op == 'xchips' then
        return next_op, mult_to_add(value)

    elseif op == 'e_chips' or op == 'echips' then
        return next_op, exp_to_mult(value)

    elseif op == 'ee_chips' or op == 'eechips' then
        return next_op, hyper_to_exp(value)
    end

    return next_op, value
end

function Overloaded.Funcs.get_mult_operator_downgrade(op, value)
    local next_op = Overloaded.Lists.MultModDowngrades[op]
    if not next_op then return op, value end

    if op == 'x_mult' or op == 'xmult' then
        return next_op, mult_to_add(value)

    elseif op == 'e_mult' or op == 'emult' then
        return next_op, exp_to_mult(value)

    elseif op == 'ee_mult' or op == 'eemult' then
        return next_op, hyper_to_exp(value)
    end

    return next_op, value
end

local calculate_effect_ref = SMODS.calculate_individual_effect
SMODS.calculate_individual_effect = function(effect, scored_card, key, amount, from_edition)
    local ret = calculate_effect_ref(effect, scored_card, key, amount, from_edition)

    return ret
end