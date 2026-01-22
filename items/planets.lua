SMODS.Consumable {
    key = "thelocals",
    set = "Planet",
    unlocked = true,
    discovered = true,
    cost = 3,
    pos = { x = 2, y = 3 },
    config = { hand_type = 'fgc_HalfCircle' },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                G.GAME.hands[card.ability.hand_type].level,
                localize(card.ability.hand_type, 'poker_hands'),
                G.GAME.hands[card.ability.hand_type].l_mult,
                G.GAME.hands[card.ability.hand_type].l_chips,
                colours = { (G.GAME.hands[card.ability.hand_type].level == 1 and G.C.UI.TEXT_DARK or G.C.HAND_LEVELS[math.min(7, G.GAME.hands[card.ability.hand_type].level)]) }
            }
        }
    end
}
