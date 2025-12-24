
local files = {
    'pre',
    'hooks',
    'misc_functions',
    'vanilla_override',
    'rarity',
    'joker_display'
}

for i=1,#files do
    assert(SMODS.load_file("lib/" .. files[i] .. ".lua"))()
end




