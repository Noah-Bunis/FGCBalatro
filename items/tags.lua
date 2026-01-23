SMODS.Tag {
    key = "activetag",
    atlas = "fgc_t_activetag",
    pos = {
        x = 0,
        y = 0
    },
    config = {
        extra = {
            repetitions = 1
        }
    },
    apply = function(self, tag, context)
        if context.type == 'round_start_bonus' then
            tag:yep('+', G.C.GREEN, function()
                return true
            end)
            SMODS.add_card{ key = "j_fgc_Active Tag" }
            tag.triggered = true
            return true
        end
    end
}

SMODS.Atlas {
    key = "fgc_t_activetag",
    path = "fgc_t_activetag.png",
    px = 32,
    py = 32
}