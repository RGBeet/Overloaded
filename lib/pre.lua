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

Overloaded.Lists.MoneyModKeys = {
    ['dollars'] = 'add', ['money'] = 'add', ['x_money'] = 'mult'
}

MadLib.loop_table(SMODS.Ranks, function(k,v)
    if math.floor(v.nominal) <= 5 then table.insert(Overloaded.Lists.Hack, v.key) end
end)