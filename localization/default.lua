return {
	descriptions = {
        OverloadedElemental = {
            -- Three Primes
            c_rgol_sulfur = {
                name = "Sulfur",
                text = {
                    "???"
                }
            },
            c_rgol_mercury = {
                name = "Mercury",
                text = {
                    "???"
                }
            },
            c_rgol_salt = {
                name = "Salt",
                text = {
                    "{C:attention}Resets{} a selected {C:attention}Joker{},",
                    "removing all {C:attention}overrides",
                }
            },
            -- Basic Elements
            c_rgol_air = {
                name = "Air",
                text = {
                    "Select a Joker,",
                    "then multiply its {C:chips}chip{} values",
                    "by {X:chips, C:white} X#1# {}"
                }
            },
            c_rgol_fire = {
                name = "Fire",
                text = {
                    "Select a Joker,",
                    "then randomize its",
                    "target {C:attention}suit{C:inactive}(s)"
                }
            },
            c_rgol_water = {
                name = "Water",
                text = {
                    "Select a Joker,",
                    "then randomize its",
                    "target {C:attention}rank{C:inactive}(s)"
                }
            },
            c_rgol_earth = {
                name = "Earth",
                text = {
                    "Select a Joker,",
                    "then multiply its {C:mult}mult{} values",
                    "by {X:mult, C:white} X#1# {}"
                }
            },
            -- Basic Elements
            c_rgol_silver = {
                name = "Silver",
                text = {
                    "???"
                }
            },
            c_rgol_gold = {
                name = "Gold",
                text = {
                    "???"
                }
            },
            c_rgol_quicksilver = {
                name = "Quicksilver",
                text = {
                    "???"
                }
            },
            c_rgol_copper = {
                name = "Copper",
                text = {
                    "???"
                }
            },
            c_rgol_iron = {
                name = "Iron",
                text = {
                    "???"
                }
            },
            c_rgol_tin = {
                name = "Tin",
                text = {
                    "???"
                }
            },
            c_rgol_lead = {
                name = "Lead",
                text = {
                    "???"
                }
            },
        },     
        Joker = {
            j_rgol_syzygy = {
                name = "Syzygy",
                text = {
                    "{C:planet}Planet{} cards have",
                    "a {C:green}#1# in #2#{} chance",
                    "of spawning with",
                    "{C:attention}X#3#{} values"
                }
            },
            j_rgol_lazzarone = {
                name = "Lazzarone",
                text = {
                    "{C:attention}Jokers{} have",
                    "a {C:green}#1# in #2#{} chance",
                    "of spawning with",
                    "the {V:1}#3#{} rarity"
                    
                }
            },
            j_rgol_blockchain = {
                name = "Blockchain",
                text = {
                    "Apply {C:chips}+X#1#{} to",
                    "all {C:attention}chip values{}",
                    "for every {C:money}$#2#{} held",
                    "{C:inactive}(Currently {C:chips}+X#3#{C:inactive})"
                }
            },
            j_rgol_ladybird = {
                name = "Ladybird",
                text = {
                    "Scoring {C:attention}#1#{} cards",
                    "give {C:attention}X#2#{} values"
                }
            },
            j_rgol_orange_ricky = {
                name = "Orange Ricky",
                text = {
                    "All {V:1}#1#{}",
                    "count as {C:attention}#2#s{}"
                }
            },
            j_rgol_crazy_eights = {
                name = "Crazy Eights",
                text = {
                    "All {C:attention}#1#{}",
                    "count as {C:attention}#2#s{}"
                }
            },
            j_rgol_limbo = {
                name = "Limbo",
                text = {
                    "{C:attention}High Card{} now scores",
                    "the {C:attention}lowest{} ranking card"
                }
            },
            j_rgol_quasicolon = {
                name = "Quasicolon",
                text = {
                    "Forcefully triggers",
                    "a random card"
                }
            },
            -- fixes
            j_greedy_joker = {
                name = "Greedy Joker",
                text = {
                    "Played cards with",
                    "{V:1}#2#{} suit give",
                    "{C:mult}+#1#{} Mult when scored", 
                }
            },
            j_lusty_joker = {
                name = "Lusty Joker",
                text = {
                    "Played cards with",
                    "{V:1}#2#{} suit give",
                    "{C:mult}+#1#{} Mult when scored", 
                }
            },
            j_wrathful_joker = {
                name = "Wrathful Joker",
                text = {
                    "Played cards with",
                    "{V:1}#2#{} suit give",
                    "{C:mult}+#1#{} Mult when scored", 
                }
            },
            j_gluttenous_joker = {
                name = "Gluttonous Joker",
                text = {
                    "Played cards with",
                    "{V:1}#2#{} suit give",
                    "{C:mult}+#1#{} Mult when scored", 
                }
            },
            j_rough_gem = {
                name = "Rough Gem",
                text = {
                    "Played cards with",
                    "{V:1}#2#{} suit earn",
                    "{C:money}$#1#{} when scored", 
                },
                unlock = {
                    "Have at least {E:1,C:attention}#1#",
                    "cards with {E:1,C:attention}#2#",
                    "suit in your deck"
                }
            },
            j_bloodstone = {
                name = "Bloodstone",
                text = {
                    "{C:green}#1# in #2#{} chance for",
                    "played cards with",
                    "{V:1}#4#{} suit to give",
                    "{X:mult,C:white} X#3# {} Mult when scored", 
                },
                unlock = {
                    "Have at least {E:1,C:attention}#1#",
                    "cards with {E:1,C:attention}#2#",
                    "suit in your deck"
                }
            },
            j_arrowhead = {
                name = "Arrowhead",
                text = {
                    "Played cards with",
                    "{V:1}#2#{} suit give",
                    "{C:chips}+#1#{} Chips when scored",
                },
                unlock = {
                    "Have at least {E:1,C:attention}#1#",
                    "cards with {E:1,C:attention}#2#",
                    "suit in your deck"
                }
            },
            j_onyx_agate = {
                name = "Onyx Agate",
                text = {
                    "Played cards with",
                    "{V:1}#2#{} suit give",
                    "{C:mult}+#1#{} Mult when scored", 
                },
                unlock = {
                    "Have at least {E:1,C:attention}#1#",
                    "cards with {E:1,C:attention}#2#",
                    "suit in your deck"
                }
            },
            -- Override Rank compat
            j_scholar = {
                name = "Scholar",
                text = {
                    "Played {C:attention}#3#s{}",
                    "give {C:chips}+#2#{} Chips",
                    "and {C:mult}+#2#{} Mult",
                    "when scored"
                }
            },
            j_seeing_double = {
                name = "Seeing Double",
                text = {
                    "{X:mult,C:white} X#1# {} Mult if played",
                    "hand has a scoring",
                    "{V:1}#2#{} card and a scoring",
                    "card of any other {C:attention}suit",
                },
                unlock = {
                    "Play a hand",
                    "that contains",
                    "{E:1,C:attention}#1#"
                }
            },
            j_blackboard = {
                name = "Blackboard",
                text = {
                    "{X:red,C:white} X#1# {} Mult if all",
                    "cards held in hand",
                    "are {V:1}#2#{} or {V:2}#3#{}"
                }
            },
            -- Shows +Mult for current hand played.
            j_supernova = {
                name = "Supernova",
                text = {
                    "Adds the number of times",
                    "{C:attention}poker hand{} has been",
                    "played this run to Mult",
                    "{C:inactive}(Currently {C:mult}+#1#{C:inactive} Mult)"
                }
            },
            -- Shows current money value
            j_egg = {
                name = "Egg",
                text = {
                    "Gains {C:money}$#1#{} of",
                    "{C:attention}sell value{} at",
                    "end of round",
                    "{C:inactive}(Currently worth {C:money}$#1#{C:inactive})"
                }
            },
            -- Override Poker Hand compat
            j_runner = {
                name = "Runner",
                text = {
                    "Gains {C:chips}+#2#{} Chips",
                    "if played hand",
                    "contains a {C:attention}#3#{}",
                    "{C:inactive}(Currently {C:chips}+#1#{C:inactive} Chips)"
                }
            },
            -- Override Rank compat
            j_sixth_sense = {
                name = "Sixth Sense",
                text = {
                    "If {C:attention}first hand{} of round is",
                    "a single {C:attention}#1#{}, destroy it and",
                    "create a {C:spectral}Spectral{} card",
                    "{C:inactive}(Must have room)"
                }
            },
            -- Override Rank compat
            j_8_ball = {
                name = "8 Ball",
                text = {
                    "{C:green}#1# in #2#{} chance for each",
                    "played {C:attention}#3#{} to create a",
                    "{C:tarot}Tarot{} card when scored",
                    "{C:inactive}(Must have room)"
                }
            },
            -- Override Rank compat
            j_wee = {
                name = "Wee Joker",
                text = {
                    "This Joker gains",
                    "{C:chips}+#2#{} Chips when each",
                    "played {C:attention}#3#{} is scored",
                    "{C:inactive}(Currently {C:chips}+#1#{C:inactive} Chips)"
                },
                unlock = {
                    "Win a run in {E:1,C:attention}#1#",
                    "or fewer rounds"
                }
            },
            -- Override Rank compat
            j_hit_the_road = {
                name = "Hit the Road",
                text = {
                    "This Joker gains {X:mult,C:white} X#1# {} Mult",
                    "for every {C:attention}#3#{}",
                    "discarded this round",
                    "{C:inactive}(Currently {X:mult,C:white} X#2# {C:inactive} Mult)"
                },
                unlock = {
                    "Discard {E:1,C:attention}5",
                    "{E:1,C:attention}Jacks{} at the",
                    "same time"
                }
            },
            -- Override Rank compat
            j_baron = {
                name = "Baron",
                text = {
                    "Each {C:attention}#1#{}",
                    "held in hand",
                    "gives {X:mult,C:white} X#2# {} Mult",

                }
            },
            -- Override Rank compat
            j_cloud_9 = {
                name = "Cloud 9",
                text = {
                    "Earn {C:money}$#1#{} for each",
                    "{C:attention}#3#{} in your {C:attention}full deck",
                    "at end of round",
                    "{C:inactive}(Currently {C:money}$#2#{}{C:inactive})"
                }
            },
            -- Override Ranks compat
            j_walkie_talkie = {
                name = "Walkie Talkie",
                text = {
                    "Each played {C:attention}#3#{} or {C:attention}#4#",
                    "gives {C:chips}+#1#{} Chips and", 
                    "{C:mult}+#2#{} Mult when scored"
                },
            },
            -- Override Rank compat
            j_shoot_the_moon = {
                name = "Shoot the Moon",
                text = {
                    "Each {C:attention}#2#{}",
                    "held in hand",
                    "gives {C:mult}+#1#{} Mult",
                },
                unlock = {
                    "Play every {E:1,C:attention}Heart",
                    "in your deck in",
                    "a single round"
                }
            },
            -- Override Ranks compat
            j_triboulet = {
                name = "Triboulet",
                text = {
                    "Played {C:attention}#2#s{} and",
                    "{C:attention}#3#s{} each give",
                    "{X:mult,C:white} X#1# {} Mult when scored"
                },
                unlock = {
                    "{E:1,s:1.3}?????"
                }
            },
            -- Override Rank and Poker Hand
            j_superposition = {
                name = "Superposition",
                text = {
                    "Create a {C:tarot}Tarot{} card if",
                    "poker hand contains an",
                    "{C:attention}#1#{} and a {C:attention}#2#{}",
                    "{C:inactive}(Must have room)"
                }
            },
        },
        Other = {
            rgol_modified_rarity = {
                name = { 'Modified Rarity' },
                text = {
                    "This card has a",
                    "{C:attention}modified{} rarity",
                    "{C:inactive}({C:attention}#1#{C:inactive} -> {C:attention}#2#{C:inactive})"
                }
            },
            rgol_modified_rank = {
                name = { 'Modified Rank' },
                text = {
                    "This card has a",
                    "{C:attention}modified{} rank value",
                    "{C:inactive}({C:attention}#1#{C:inactive} -> {C:attention}#2#{C:inactive})"
                }
            },
            rgol_modified_ranks_2 = {
                name = { 'Modified Ranks (2)' },
                text = {
                    "This card has {C:attention}2{}",
                    "{C:attention}modified{} rank values",
                    "1. {C:inactive}({C:attention}#1#{C:inactive} -> {C:attention}#2#{C:inactive})",
                    "2. {C:inactive}({C:attention}#3#{C:inactive} -> {C:attention}#4#{C:inactive})"
                }
            },
            rgol_modified_ranks_3 = {
                name = { 'Modified Ranks (3)' },
                text = {
                    "This card has {C:attention}3{}",
                    "{C:attention}modified{} rank values",
                    "1. {C:inactive}({C:attention}#1#{C:inactive} -> {C:attention}#2#{C:inactive})",
                    "2. {C:inactive}({C:attention}#3#{C:inactive} -> {C:attention}#4#{C:inactive})",
                    "2. {C:inactive}({C:attention}#5#{C:inactive} -> {C:attention}#6#{C:inactive})"
                }
            },
            rgol_modified_ranks_4 = {
                name = { 'Modified Ranks (4)' },
                text = {
                    "This card has {C:attention}4{}",
                    "{C:attention}modified{} rank values",
                    "1. {C:inactive}({C:attention}#1#{C:inactive} -> {C:attention}#2#{C:inactive})",
                    "2. {C:inactive}({C:attention}#3#{C:inactive} -> {C:attention}#4#{C:inactive})",
                    "2. {C:inactive}({C:attention}#5#{C:inactive} -> {C:attention}#6#{C:inactive})",
                    "2. {C:inactive}({C:attention}#7#{C:inactive} -> {C:attention}#8#{C:inactive})",
                }
            },
            rgol_modified_suit = {
                name = { 'Modified Suit' },
                text = {
                    "This card has a",
                    "{C:attention}modified{} suit value",
                    "{C:inactive}({V:1}#1#{C:inactive} -> {V:2}#2#{C:inactive})"
                }
            },
            rgol_modified_suits_2 = {
                name = { 'Modified Suits (2)' },
                text = {
                    "This card has {C:attention}2{}",
                    "{C:attention}modified{} suit values",
                    "{C:inactive}({V:1}#1#{C:inactive} -> {V:2}#2#{C:inactive})",
                    "{C:inactive}({V:3}#3#{C:inactive} -> {V:4}#4#{C:inactive})",
                }
            },
            rgol_modified_suits_3 = {
                name = { 'Modified Suits (3)' },
                text = {
                    "This card has {C:attention}3{}",
                    "{C:attention}modified{} suit values",
                    "{C:inactive}({V:1}#1#{C:inactive} -> {V:2}#2#{C:inactive})",
                    "{C:inactive}({V:3}#3#{C:inactive} -> {V:4}#4#{C:inactive})",
                    "{C:inactive}({V:5}#5#{C:inactive} -> {V:6}#6#{C:inactive})",
                }
            },
            rgol_modified_suits_4 = {
                name = { 'Modified Suits (4)' },
                text = {
                    "This card has {C:attention}4{}",
                    "{C:attention}modified{} suit values",
                    "{C:inactive}({V:1}#1#{C:inactive} -> {V:2}#2#{C:inactive})",
                    "{C:inactive}({V:3}#3#{C:inactive} -> {V:4}#4#{C:inactive})",
                    "{C:inactive}({V:5}#5#{C:inactive} -> {V:6}#6#{C:inactive})",
                    "{C:inactive}({V:7}#7#{C:inactive} -> {V:8}#8#{C:inactive})",
                }
            },
            rgol_modified_poker_hand = {
                name = { 'Modified Poker Hand' },
                text = {
                    "This card has a",
                    "{C:attention}modified{} suit value",
                    "{C:inactive}({C:attention}#1#{C:inactive} -> {C:attention}#2#{C:inactive})"
                }
            },
        },
    },
    misc = {
        poker_hand_descriptions = {
            rgol_infoak = {
                "5 Infinity cards"
            },
            rgol_infinity_flush = {
                "5 Infinity cards",
                "of the same suit"
            },
            rgol_infinity_spectrum = {
                "5 Infinity cards",
                "of different suits"
            },
            rgol_nohand = {
                "Oops, no possible hand!"
            },
            rgol_straight_house = {
                "... How."
            },
            rgol_straight_flush_house = {
                "... How."
            },
        },
        poker_hands = {
            rgol_infinity               = "Infinitum",
            rgol_infinity_flush         = "Infinitus Fluxus",
            rgol_infinity_spectrum      = "Infinitus Iris",
            rgol_straight_house         = "Straight House",
            rgol_straight_flush_house   = "Straight Flush House",
            rgol_nohand                 = "No Hand",
        },
        dictionary = {
			k_rgol_strange          = "Strange",
			k_rgol_overclocked      = "Overclocked",

			k_overloadedelemental        = "Elemental Card",
			b_overloadedelemental_cards  = "Elemental Cards",
        },
    }
}