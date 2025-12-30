Overloaded = {
    Config = {

    },
    Lists = {
        Hack                = {},
        RankManipulation    = {},
        ChipModKeys = {

        }
    },
    Funcs = {}
}

if togabalatro then
    Overloaded.Lists.ChipModKeys = togabalatro.chipmodkeys
    Overloaded.Lists.MultModKeys = togabalatro.multmodkeys 
else
    Overloaded.Lists.ChipModKeys = {
        ['chips'] = 'add', ['h_chips'] = 'add', ['chip_mod'] = 'add',
        ['x_chips'] = 'mult', ['xchips'] = 'mult', ['Xchip_mod'] = 'mult',
        ['e_chips'] = 'mult', ['echips'] = 'mult', ['Echip_mod'] = 'mult',
        ['ee_chips'] = 'mult', ['eechips'] = 'mult', ['EEchip_mod'] = 'mult',
        ['eee_chips'] = 'mult', ['eeechips'] = 'mult', ['EEEchip_mod'] = 'mult',
        ['hyperchips'] = 'mult', ['hyper_chips'] = 'mult', ['hyperchip_mod'] = 'mult',
        -- Other mods can add their custom operations to this table.
    }

    Overloaded.Lists.MultModKeys = {
        ['mult'] = 'add', ['h_mult'] = 'add', ['mult_mod'] = 'add',
        ['x_mult'] = 'mult', ['xmult'] = 'mult', ['Xmult'] = 'mult', ['x_mult_mod'] = 'mult', ['Xmult_mod'] = 'mult',
        ['e_mult'] = 'mult', ['emult'] = 'mult', ['Emult_mod'] = 'mult',
        ['ee_mult'] = 'mult', ['eemult'] = 'mult', ['EEmult_mod'] = 'mult',
        ['eee_mult'] = 'mult', ['eeemult'] = 'mult', ['EEEmult_mod'] = 'mult',
        ['hypermult'] = 'mult', ['hyper_mult'] = 'mult', ['hypermult_mod'] = 'mult',
        -- Other mods can add their custom operations to this table.
    }
end

Overloaded.Lists.ChipModUpgrades = {
    -- a -> x
    ['chips']       = 'x_chips',
    ['h_chips']     = 'x_chips',
    ['chip_mod']    = 'Xchip_mod',
    -- x -> e
    ['x_chips']     = 'e_chips',
    ['xchips']      = 'echips',
    ['Xchip_mod']   = 'Echip_mod',
    -- e -> ee
    ['e_chips']     = 'ee_chips',
    ['echips']      = 'eechips',
    ['Echip_mod']   = 'EEchip_mod',
}

Overloaded.Lists.ChipModDowngrades = {
    -- a -> x
    ['x_chips']     = 'chips',
    ['xchips']      = 'chips',
    ['Xchip_mod']   = 'chip_mod',
    -- x -> e
    ['e_chips']     = 'x_chips',
    ['echips']      = 'xchips',
    ['Echip_mod']   = 'Xchip_mod',
    -- e -> ee
    ['ee_chips']    = 'e_chips',
    ['eechips']     = 'echips',
    ['EEchip_mod']  = 'Echip_mod',
}

Overloaded.Lists.MultModUpgrades = {
    -- a -> x
    ['mult']       = 'x_mult',
    ['h_mult']     = 'x_mult',
    ['mult_mod']   = 'Xmult_mod',
    -- x -> e
    ['x_mult']     = 'e_mult',
    ['xmult']      = 'emult',
    ['Xmult_mod']  = 'Emult_mod',
    -- e -> ee
    ['e_mult']     = 'ee_mult',
    ['emult']      = 'eemult',
    ['Emult_mod']  = 'EEmult_mod',
}

Overloaded.Lists.MultModDowngrades = {
    -- a -> x
    ['x_mult']     = 'mult',
    ['xmult']      = 'mult',
    ['Xmult_mod']  = 'mult_mod',
    -- x -> e
    ['e_mult']     = 'x_mult',
    ['emult']      = 'xmult',
    ['Emult_mod']  = 'Xmult_mod',
    -- e -> ee
    ['ee_mult']    = 'e_mult',
    ['eemult']     = 'emult',
    ['EEmult_mod'] = 'Emult_mod',
}

MadLib.loop_table(SMODS.Ranks, function(k,v)
    if math.floor(v.nominal) <= 5 then table.insert(Overloaded.Lists.Hack, v.key) end
end)

SMODS.ConsumableType({
    key = "OverloadedElemental",
    primary_colour = HEX("659B00"),
    secondary_colour = HEX("486024"),
    collection_rows = { 3, 2 },
    shop_rate = 0.10,
    --loc_txt = {},
    default = "c_rgol_water",
    can_stack = true,
    can_divide = true,
})