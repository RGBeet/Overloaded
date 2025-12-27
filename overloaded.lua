
local files = {
    'pre',
    'atlas',
    'hooks',
    'misc_functions',
    'vanilla_override',
    'rarity',
    'joker_display',
    'load_content',
}

for i=1,#files do
    assert(SMODS.load_file("lib/" .. files[i] .. ".lua"))()
end




