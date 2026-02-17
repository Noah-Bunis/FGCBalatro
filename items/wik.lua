-- credits to SMG9000 and Yahimice for the code
function create_UIBox_willitkill(filename, title, pausetime, totaltime, kills)

    local file_path = SMODS.Mods["FGCBalatro"].path .. "/assets/videos/" .. filename .. ".ogv"
    local file = NFS.read(file_path)
    love.filesystem.write("temp.ogv", file)

    local video_file = love.graphics.newVideo('temp.ogv')

    local vid_sprite = Sprite(
        0, 0,
        8 * 16 / 9, 8,
        G.ASSET_ATLAS["ui_" .. (G.SETTINGS.colourblind_option and 2 or 1)],
        {x=0,y=0}
    )

    vid_sprite.video = video_file

    local initialized_frame = false
    local has_voted = false
    video_file:play()

    local vote = -1
    function G.FUNCS.vote_yes(e)
        if not has_voted then
            vote = 1
            play_video()
            local uibox = e.parent
            uibox:remove()
        end
    end

    function G.FUNCS.vote_no(e)
        if not has_voted then
            vote = 0
            play_video()
            local uibox = e.parent
            uibox:remove()
        end
    end

    function play_video()
        if initialized_frame and not has_voted then
            video_file:play()
            has_voted = true
        end
    end
    
    local wager = {dollars = math.abs(G.GAME.dollars)}

    local wager_slider = create_slider({
        id = "slider",
        colour = HEX("f5a92c"),
        min = (math.abs(G.GAME.dollars)/2),
        max = math.abs(G.GAME.dollars),
        step = 1,
        w = 5,
        minw = 6,
        minh = 1,
        scale = 0.25,
        ref_table = wager,
        ref_value = 'dollars',
        r = 0.1
    })

    local t = create_UIBox_generic_options({
        no_back = true,
        colour = G.C.BLACK,
        padding = 0,
        contents = {{
            n = G.UIT.C,
            config = {align="cm"},
            nodes = {
                {
                    n = G.UIT.R,
                    config = {align="tm", padding=0.1},
                    nodes = {{
                        n = G.UIT.C,
                            config = {
                                minw=4,
                                minh=1,
                                colour=HEX("e22829"),
                                padding=0.05,
                                outline = 1,
                                outline_colour = HEX("590a0a"),
                                r = 0.1
                            },
                            nodes = {{
                                n = G.UIT.T,
                                config={
                                    align="cm",
                                    text="WILL IT KILL...? - "..title,
                                    padding = 0.1,
                                    scale=0.5,
                                    colour=G.C.WHITE,
                                }
                            }}
                    }}
                },
                {
                    n = G.UIT.R,
                    config = {align="cm"},
                    nodes = {{
                        n = G.UIT.O,
                        config = {
                            object = vid_sprite
                        }
                    }}
                },
                {
                    n = G.UIT.R,
                    config = {align="bm", minh = 1, padding = 0.2},
                    nodes = {
                        {
                            n = G.UIT.C,
                            config = {
                                minw=4,
                                minh=1,
                                colour=G.C.BLUE,
                                button="vote_yes",
                                button_delay = pausetime,
                                one_press = true,
                                hover = true,
                                shadow = true,
                                r = 0.1,
                                emboss = 0.25
                            },
                            nodes = {{
                                n = G.UIT.T,
                                config={
                                    align="cm",
                                    text="YES",
                                    scale=1,
                                    padding = 0.15,
                                    colour=G.C.WHITE,
                                }
                            }}
                        },
                        {
                            n = G.UIT.C,
                            config = {
                                minw=4,
                                minh=1,
                                colour=G.C.RED,
                                button="vote_no",
                                button_delay = pausetime,
                                one_press = true,
                                hover = true,
                                shadow = true,
                                r = 0.1,
                                emboss = 0.25
                            },
                            nodes = {{
                                n = G.UIT.T,
                                config={
                                    align="cm",
                                    text="NO",
                                    scale=1,
                                    padding = 0.15,
                                    colour=G.C.WHITE,
                                }
                            }}
                        },
                        {
                            n = G.UIT.C,
                            config = {
                                minh=1,
                                colour = G.C.MONEY,
                                emboss = 0.25
                            },
                            nodes = {
                                {
                                    n = G.UIT.T,
                                    config={
                                        align="cm",
                                        text="BETS",
                                        vert = true,
                                        scale=1,
                                        padding = 0.15,
                                        colour=G.C.WHITE,
                                    }
                                },
                                wager_slider
                            }
                        }
                    }
                }

            }
        }}
    })

    local old_update = love.update
    local time_elapsed = 0
    function love.update(dt)
        if old_update then old_update(dt) end

        if not initialized_frame or has_voted then
            time_elapsed = time_elapsed + dt
        end
            
        if not initialized_frame and video_file:tell() >= pausetime then
            video_file:pause()
            initialized_frame = true
            play_sound("fgc_wik_alrightythenchatroom", 1,1)
        end

        if has_voted and time_elapsed >= totaltime then
            has_voted = false
            if (kills == true and vote == 1) then
                ease_dollars(math.floor(wager.dollars + 0.5))
                play_sound("fgc_wik_kills_correct", 1,1)
            elseif  (kills == false and vote == 0) then
                play_sound("fgc_wik_lives_correct", 1,1)
                ease_dollars(math.floor(wager.dollars + 0.5))
            elseif (kills == true and vote == 0) then
                play_sound("fgc_wik_lives_wrong", 1,1)
                ease_dollars(- math.floor(wager.dollars + 0.5))
            elseif (kills == false and vote == 1) then
                play_sound("fgc_wik_kills_wrong", 1,1)
                ease_dollars(- math.floor(wager.dollars + 0.5))
            end
            G.FUNCS.exit_overlay_menu()
        end
    end

    return t
end