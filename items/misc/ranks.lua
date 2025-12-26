-- Sum: Equals the sum of all played cards with the same suit
local sum = {
    object_type = "Rank",
    lc_atlas    = 'bs_nr_lc',
    hc_atlas    = 'bs_nr_lc',
    hidden      = true,
    key         = 'Sum',
    card_key    = 'Sum',
    pos         = { x = 4 },
    nominal     = 0,
    face        = false,
    face_nominal    = 50,
    shorthand       = '=',
    straight_edge   = false,
    in_pool     = function(self, args)
        if args and args.initial_deck then
            return false
        end
        return G.GAME and G.GAME.rank_unlocks and G.GAME.rank_unlocks[self.config.key]
    end,
}

-- Infinity: Counts as all ranks played and held in hand (Moved to Overclocked)
local infinity = {
    object_type = "Rank",
    lc_atlas    = 'bs_nr_lc',
    hc_atlas    = 'bs_nr_lc',
    hidden      = true,
    key         = 'Infinity',
    card_key    = 'Inf',
    pos         = { x = 5 },
    nominal     = 0,
    face        = false,
    face_nominal    = 70,
    shorthand       = '~',
    straight_edge   = false,
    in_pool     = function(self, args)
        if args and args.initial_deck then
            return false
        end
        return G.GAME and G.GAME.rank_unlocks and G.GAME.rank_unlocks[self.config.key]
    end,
}

-- Phi/Golden Ratio: 1.618. Counts as a Fibonacci number.
-- If UnStable is installed, can count as 1 or 2.
local phi = {
    object_type = "Rank",
    lc_atlas    = 'bs_nr_lc',
    hc_atlas    = 'bs_nr_lc',
    hidden      = true,
    key         = 'Phi',
    card_key    = 'Phi',
    pos         = { x = 2 },
    nominal     = 1.618,
    face_nominal    = 0,
    shorthand       = 'Ph',
    straight_edge   = false,
    in_pool     = function(self, args)
        if args and args.initial_deck then
            return false
        end
        return G.GAME and G.GAME.rank_unlocks and G.GAME.rank_unlocks[self.config.key]
    end,
}