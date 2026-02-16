local wik_videos = {
    {filename = "sf3", title = "Street Fighter 3: Third Strike (credit: Spiraler)", pausetime = 8.5, totaltime = 20, kills = false},
    {filename = "gbvsr", title = "Granblue Fantasy Versus: Rising (credit: Light)", pausetime = 2.5, totaltime = 21, kills = true},
}

SMODS.Blind {
    key = "beast",
    dollars = 5,
    mult = 2,
    unlocked = true,
    discovered = true,
    pos = {x=0,y=0},
    boss = { min = 1 },
    boss_colour = HEX("f19e2e"),
    atlas = 'fgc_daigo',
    calculate = function(self, blind, context)
        if context.setting_blind then
            play_sound("fgc_daigo", 1, 1)
        end
        if not blind.disabled then
            if context.individual and context.cardarea == G.play and not context.blueprint then
            if SMODS.pseudorandom_probability(blind, 'fgc_beast', 1, 4) then
                SMODS.destroy_cards(context.other_card, nil, nil, true)
                return {
                    colour = G.C.RED,
                    message = "UMESHORYU!",
                    sound = "fgc_umeshoryu",
                    pitch = 1,
                }
            end
            end
        end
    end
}

SMODS.Blind {
    key = "willitkill",
    dollars = 5,
    mult = 2,
    loc_txt = {
        name = 'WILL IT KILL...?',
        text = {
            'Alrighty then chatroom...',
        }
    },
    boss = {  min = 1 },
    boss_colour = HEX("590a0a"),
    atlas = "fgc_sajam",
    set_blind= function(self)
        local video = wik_videos[math.random(#wik_videos)]
        G.FUNCS.overlay_menu{
                definition = create_UIBox_willitkill(video.filename, video.title, video.pausetime, video.totaltime, video.kills),
                config = {no_esc = true}
            }
    end,
}