-- credits to SMG9000 and Yahimice for the code
function create_UIBox_custom_video1(name, buttonname)

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

    ----------------------------------------------------------------
    -- Show frame 2 on open
    ----------------------------------------------------------------
    local initialized_frame = false
    video_file:play()

    local old_update = love.update
    function love.update(dt)
        if old_update then old_update(dt) end
        if not initialized_frame and video_file:tell() > 0 then
            video_file:pause()
            initialized_frame = true
        end
    end

    ----------------------------------------------------------------
    -- Single-use button logic
    ----------------------------------------------------------------
    local video_started = false

    function G.FUNCS.play_video(e)
        if video_started then return end
        video_started = true

        video_file:play()
    end

    ----------------------------------------------------------------
    -- UI
    ----------------------------------------------------------------
    local t = create_UIBox_generic_options({
        back_delay = 2,
        back_label = buttonname,
        colour = G.C.BLACK,
        padding = 0,
        contents = {{
            n = G.UIT.R,
            config = {align="cm"},
            nodes = {

                -- VIDEO
                {
                    n = G.UIT.C,
                    config = {align="cm"},
                    nodes = {{
                        n = G.UIT.O,
                        config = {object = vid_sprite}
                    }}
                },

                -- BUTTON AREA
                {
                    n = G.UIT.C,
                    config = {align="cm"},
                    nodes = {

                        -- YES BUTTON
                        {
                            n = G.UIT.R,
                            config = {align="cm"},
                            nodes = {{
                                n = G.UIT.C,
                                config = {
                                    minw=1,minh=1,
                                    colour=G.C.GREEN,
                                    padding=0.15,
                                    button="play_video"
                                },
                                nodes = {{
                                    n = G.UIT.T,
                                    config = {
                                        text="yes",
                                        scale=0.5,
                                        colour=G.C.WHITE
                                    }
                                }}
                            }}
                        },

                        -- NO BUTTON
                        {
                            n = G.UIT.R,
                            config = {align="cm"},
                            nodes = {{
                                n = G.UIT.C,
                                config = {
                                    minw=1,minh=1,
                                    colour=G.C.RED,
                                    padding=0.15,
                                    button="play_video"
                                },
                                nodes = {{
                                    n = G.UIT.T,
                                    config = {
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

    return t
end
