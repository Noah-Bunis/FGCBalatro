SMODS.Seal {
    key = "modern",
    pos = {x=0,y=0},
    atlas = "fgc_modern",
    badge_colour = G.C.FILTER,
    config = {extra = {mult = 20, dollars = 20, mult_odds = 5, dollars_odds = 15, xchips = 0.92}},
    unlocked = true,
    discovered = true,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_lucky
        return {
            vars = {(1 - card.ability.seal.extra.xchips)* 100}
        }
    end,
    calculate = function(self, card, context)
        if context.final_scoring_step and context.cardarea == G.play then
            return {
                xchips = card.ability.seal.extra.xchips,
            }
        end
        if context.main_scoring and context.cardarea == G.play then
            local ret = {}
            if SMODS.pseudorandom_probability(card, 'lucky_mult', 1, card.ability.seal.extra.mult_odds) then
                card.lucky_trigger = true
                ret.mult = card.ability.seal.extra.mult
            end
            if SMODS.pseudorandom_probability(card, 'lucky_money', 1, card.ability.seal.extra.dollars_odds) then
                card.lucky_trigger = true
                ret.dollars = card.ability.seal.extra.dollars
            end
            G.E_MANAGER:add_event(Event {
               func = function()
                   card.lucky_trigger = nil
                   return true
               end
            })
            return ret
        end
    end
}