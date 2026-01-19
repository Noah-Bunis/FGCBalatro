SMODS.Joker{ --Sajam
    key = "Sajam",
    loc_txt = {
        ['name'] = 'Sajam',
        ['text'] = {
            [1] = '{C:rare}Sajam{} Jokers',
            [2] = 'each give {X:mult,C:white} X2 {} Mult'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 0,
        y = 0
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 6,
    rarity = 3,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'fgc_sajam',
    fgc_sajam = true,
    config = { extra = { xmult = 2 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult } }
    end,
    calculate = function(self, card, context)
        if context.other_joker and (context.other_joker.config.center.fgc_sajam == true) then
            return {
                xmult = card.ability.extra.xmult
            }
        end
    end,
}

SMODS.Atlas {
    key = "fgc_sajam",
    path = "fgc_j_sajam.png",
    px = 71,
    py = 95
}
