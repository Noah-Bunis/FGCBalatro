SMODS.Voucher {
    key = 'chipotlecard',
    loc_txt = {
        ['name'] = 'Chipotle Card',
        ['text'] = {
            [1] = 'Gives you a {C:attention,T:tag_investment}Investment Tag{} and a random consumeable.',
            [2] = "Don't drown in pools!"
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    unlocked = true,
    discovered = true,
    dollars = 15,
    atlas = 'fgc_chipotlecard',
    pos = {
        x = 0,
        y = 0
    },
    redeem = function(self, card)
        SMODS.add_card {
            set = "Consumeables",
            key_append = "fgc_chipotlecard"
        }
        add_tag(Tag(("tag_investment")))
    end
}

SMODS.Atlas {
    key = "fgc_chipotlecard",
    path = "fgc_v_chipotlecard.png",
    px = 71,
    py = 95
}
