Overloaded = {
    Lists = {
        Hack                = {},
        RankManipulation    = {},
    },
    Funcs = {}
}

MadLib.loop_table(SMODS.Ranks, function(k,v)
    if math.floor(v.nominal) <= 5 then table.insert(Overloaded.Lists.Hack, v.key) end
end)