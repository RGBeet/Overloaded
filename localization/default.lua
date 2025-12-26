
return {
	descriptions = {
        Joker = {
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
                    "Played {C:attention}#2#{} and",
                    "{C:attention}#3#{} each give",
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
                title = { 'Modified Rarity' },
                text = {
                    "This card has a",
                    "{C:attention}modified{} rarity",
                    "{C:inactive}({C:attention}#1#{C:inactive} -> {C:attention}#2#{C:inactive})"
                }
            },
            rgol_modified_rank = {
                title = { 'Modified Rank' },
                text = {
                    "This card has a",
                    "{C:attention}modified{} rank value",
                    "{C:inactive}({C:attention}#1#{C:inactive} -> {C:attention}#2#{C:inactive})"
                }
            },
            rgol_modified_suit = {
                title = { 'Modified Suit' },
                text = {
                    "This card has a",
                    "{C:attention}modified{} suit value",
                    "{C:inactive}({V:1}#1#{C:inactive} -> {V:2}#2#{C:inactive})"
                }
            },
        },
    }
}