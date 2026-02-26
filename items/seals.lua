SMODS.Seal {
    key = "modern",
    pos = {x=0,y=0},
    atlas = "fgc_modern",
    badge_colour = G.C.FILTER,
    config = {extra = {xchips = 0.95}},
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
        if context.check_enhancement then
            return {
                m_lucky = true
            }
        end
    end
}