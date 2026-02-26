SMODS.Tag {
    key = "activetag",
    atlas = "fgc_t_activetag",
    unlocked = true,
    discovered = true,
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

SMODS.Tag {
    key = "willitkill_tag",
    atlas = "fgc_t_sajam",
    unlocked = true,
    discovered = true,
    pos = {
        x = 0,
        y = 0
    },
    apply = function(self, tag, context)
        if context.type == 'new_blind_choice' then
            tag:yep('?', G.C.RED, function()
                return true
            end)
            local video = pseudorandom_element(WIK_CLIPS, "fgc_seed")
            --local video = WIK_CLIPS[1] --DEBUG FUNCTION
            G.FUNCS.overlay_menu{
                definition = create_UIBox_willitkill(video.filename, video.title, video.pausetime, video.totaltime, video.kills),
                config = {no_esc = true}
            }
            tag.triggered = true
            return true
        end
    end
}