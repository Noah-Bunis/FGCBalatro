-- credits to SMG9000 and Yahimice for the code
function create_UIBox_willitkill(name, buttonname, pausetime, totaltime, kills)

    local file_path = SMODS.Mods["FGCBalatro"].path .. "/assets/videos/" .. name .. ".ogv"
    local file = NFS.read(file_path)
    love.filesystem.write("temp.ogv", file)

    local video_file = love.graphics.newVideo('temp.ogv')

    local vid_sprite = Sprite(
        0, 0,
        11 * 16 / 9, 11,
        G.ASSET_ATLAS["ui_" .. (G.SETTINGS.colourblind_option and 2 or 1)],
        {x=0,y=0}
    )

    vid_sprite.video = video_file

    local initialized_frame = false
    local has_voted = false
    video_file:play()

    local t = create_UIBox_generic_options({
        no_back = true,
        colour = G.C.BLACK,
        padding = 0,
        contents = {{
            n = G.UIT.R,
            config = {align="cm"},
            nodes = {

                {
                    n = G.UIT.C,
                    config = {align="cm"},
                    nodes = {{
                        n = G.UIT.O,
                        config = {object = vid_sprite}
                    }}
                },

                {
                    n = G.UIT.C,
                    config = {align="cm"},
                    nodes = {

                        {
                            n = G.UIT.R,
                            config = {align="cm"},
                            nodes = {{
                                n = G.UIT.C,
                                config = {
                                    minw=1,
                                    minh=1,
                                    colour=G.C.GREEN,
                                    padding=0.15,
                                    button="play_video",
                                    button_delay = pausetime,
                                    one_press = true,
                                    hover = true,
                                    shadow = true
                                },
                                nodes = {{
                                    n = G.UIT.T,
                                    config={
                                        text="yes",
                                        scale=0.5,
                                        colour=G.C.WHITE
                                    }
                                }}
                            }}
                        },

                        {
                            n = G.UIT.R,
                            config = {align="cm"},
                            nodes = {{
                                n = G.UIT.C,
                                config = {
                                    minw=1,
                                    minh=1,
                                    colour=G.C.RED,
                                    padding=0.15,
                                    button="play_video",
                                    button_delay = pausetime,
                                    one_press = true,
                                    hover = true,
                                    shadow = true
                                },
                                nodes = {{
                                    n = G.UIT.T,
                                    config={
                                        text="no",
                                        scale=0.5,
                                        colour=G.C.WHITE
                                    }
                                }}
                            }}
                        }
                    }
                }

            }
        }}
    })

    function G.FUNCS.play_video(e)
        if initialized_frame and not has_voted then
            video_file:play()
            has_voted = true
        end
    end

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
        end

        if has_voted and time_elapsed >= totaltime then
            G.FUNCS.exit_overlay_menu()
        end
    end

    return t
end