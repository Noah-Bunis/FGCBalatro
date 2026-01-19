SMODS.PokerHand {
    key = "HalfCircle",
    mult = 5,
    chips = 35,
    l_mult = 3,
    l_chips = 30,
    example = {
        {'C_4'}, {'D_A'}, {'H_2'}, {'C_3'}, {'C_6'}
    },
    evaluate = function(parts, hand)
        local bools = {false, false, false, false, false}
        for i = 1, #hand do
                    local rank = SMODS.Ranks[hand[i].base.value]
                    if rank.key == "Ace" then
                        bools[0] = true
                    elseif rank.key == "2" then
                        bools[1] = true
                    elseif rank.key == "3" then
                        bools[2] = true
                    elseif rank.key == "4" then
                        bools[3] = true
                    elseif rank.key == "6" then
                        bools[4] = true
                    end
        end
            local count = 0
            for j = 0, 4 do
                if bools[j] then
                    count = count + 1
                end
            end
            if count == 5 then
                return {hand}
            end
        return {}
    end
}