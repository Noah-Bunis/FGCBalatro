local activeviewers = 0
local activegame_name = "[RANDOM FIGHTING GAME]"
local activegame_players = 0

SMODS.Joker {
    key = "SageHam",
    loc_txt = {
        ['name'] = 'SageHam',
        ['text'] = {
            [1] = 'Gives a free {C:spectral}Spectral Card{}',
            [2] = 'upon winning {C:attention}"WILL IT KILL...?"'
        }
    },
    rarity = 2,
    cost = 8,
    pos = {x=0,y=0},
    unlocked = true,
    discovered = true,
    fgc_sajam = true,
    atlas = 'fgc_sageham',
    calculate = function(self, card, context)
        if context.selling_self then
            return {
                sound = "fgc_stevemyarm",
                pitch = 1,
                message = "STEVE MY ARM!!!"
            }
        end
    end
}

SMODS.Joker {
    key = "KBrad",
    loc_txt = {
        ['name'] = 'K-Brad',
        ['text'] = {
            [1] = '{C:chips}+#1#{} Chips and {C:money}+#2#{} dollars',
            [2] = 'when playing a hand that has not been played before'
        }
    },
    rarity = 1,
    cost = 5,
    pos = {x=0,y=1},
    unlocked = true,
    discovered = true,
    atlas = 'fgc_kbrad_mixed',
    config = { extra = {chips = 30, dollars = 5} },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips, card.ability.extra.dollars } }
    end,
    calculate = function (self, card, context)
        if context.setting_blind then
            play_sound("fgc_kbrad", 1, 1.2)
        end
        if context.joker_main then
            if G.GAME.hands[context.scoring_name].played == 1 then
                play_sound("fgc_kbrad_mixed", 1, 0.5)
                card.children.center:set_sprite_pos({x = 0, y = 0})
                G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) + card.ability.extra.dollars
                return {
                    chips = card.ability.extra.chips,
                    dollars = card.ability.extra.dollars,
                        func = function()
                            G.E_MANAGER:add_event(Event({
                                func = function()
                                    card.children.center:set_sprite_pos({x = 0, y = 1})
                                    G.GAME.dollar_buffer = 0
                                    return true
                                end
                            }))
                        end
                }
            end
        end
    end
}

SMODS.Joker {
    key = "Jaytsu",
    loc_txt = {
        ['name'] = {
            [1] = "{C:edition,s:0.6}SSR{}{s:0.6} [Don't Call Her Mambo Bro]",
            [2] = "Jaytsu",
        },
        ['text'] = {
            [1] = "{X:mult,C:white} X#1#{} mult after {C:attention}#2#{} rounds",
            [2] = "{C:inactive}(Currently {C:attention}#3#{C:inactive}/#2#)",
        },
    },
    rarity = 3,
    cost = 8,
    pos = {x=0,y=0},
    unlocked = true,
    discovered = true,
    atlas = 'fgc_jaytsu',
    config = { extra = {Xmult = 3, train_rounds = 0, total_rounds = 4 } },
    loc_vars = function(self, info_queue, card)
        return { vars = {card.ability.extra.Xmult, card.ability.extra.total_rounds, card.ability.extra.train_rounds }}
    end,
    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint 
        and (card.ability.extra.train_rounds < card.ability.extra.total_rounds) then
            card.ability.extra.train_rounds = card.ability.extra.train_rounds + 1
            return {
                message = (card.ability.extra.train_rounds < card.ability.extra.total_rounds) and
                    (card.ability.extra.train_rounds .. '/' .. card.ability.extra.total_rounds) or
                    "Active!",
                colour = HEX("f27cfb")
            }
        end
        if context.before and (card.ability.extra.train_rounds >= card.ability.extra.total_rounds) then
            return {
                colour = HEX("f27cfb"),
                sound = "fgc_beatrix",
                pitch = 1,
                volume = 0.7,
                message = "FRIENDSHIP TRAINING!",
            }
        end
        if context.joker_main and (card.ability.extra.train_rounds >= card.ability.extra.total_rounds) then
            return {
                colour = G.C.DARK_EDITION,
                xmult = card.ability.extra.Xmult,
            }
        end
    end
}
SMODS.Joker {
    key = "Dustloop",
    loc_txt = {
        ['name'] = 'Dustloop',
        ['text'] = {
            [1] = "This Joker gains {C:mult}+#1#{} Mult",
            [2] = "per {C:attention}consecutive{}",
            [3] = "scoring {C:attention}Ace{}",
            [4] = "{C:inactive}(Currently {C:mult}+#2#{C:inactive} Mult)",
                },
        },
    rarity = 1,
    cost = 6,
    pos = {x=0,y=0},
    unlocked = true,
    discovered = true,
    atlas = 'fgc_dustloop',
    config = { extra = { mult_gain = 3, mult = 0 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult_gain, card.ability.extra.mult } }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and not context.blueprint then
            if context.other_card.base.value == "Ace" then
                card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_gain
                return {
                        message = "j.D",
                        sound = "fgc_dustloop_hit",
                        pitch = 1
                    }
            else
                local last_mult = card.ability.extra.mult
                card.ability.extra.mult = 0
                if last_mult > 0 then
                    return {
                        colour = G.C.RED,
                        message = "Dropped!",
                        sound = "fgc_dustloop_dropped",
                        pitch = 1
                    }
                end
            end
        end
        if context.joker_main then
            return {
                mult = card.ability.extra.mult
            }
        end
        if context.selling_self then
            return {
                colour = G.C.RED,
                message = "Dropped!",
                sound = "fgc_dustloop_dropped",
                pitch = 1
            }
        end
    end
    
}

SMODS.Joker {
    key = "TheDumpster",
    loc_txt = {
        ['name'] = 'The Dumpster from {C:attention}Injustice{}',
        ['text'] = {
            [1] = "{C:red,E:1}...people played this game for money?"
        }
    },
    pos = {x=0,y=0},
    cost = 1,
    rarity = 1,
    unlocked = true,
    discovered = true,
    atlas = 'fgc_thedumpster',
    config = {extra = {chips = -50} },
    calculate = function(self, card, context)
        if context.final_scoring_step then
            return {
                chips = card.ability.extra.chips,
                colour = G.C.RED,
                message = "Dumpstered!"
            }
        end
        if context.selling_self then
            return { add_tag(Tag(("tag_garbage"))) }
        end
    end
}

SMODS.Joker {
    key = "Woshige",
    loc_txt = {
        ['name'] = 'Woshige',
        ['text'] = {
            [1] = "{X:mult,C:white} X#1# {} Mult",
            [2] = "{C:attention}During scoring,{} {C:green}#2# in #3#{} chance that",
            [3] = "{C:red,E:2}Woshige stands up too early"
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {x=0,y=0},
    cost = 5,
    rarity = 2,
    unlocked = true,
    discovered = true,
    atlas = 'fgc_woshige',
    config = { extra = { odds = 7, Xmult = 4 } },
    loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'fgc_Woshige')
        return { vars = { card.ability.extra.Xmult, numerator, denominator } }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and not context.blueprint then
            if SMODS.pseudorandom_probability(card, 'fgc_Woshige', 1, card.ability.extra.odds) then
                SMODS.destroy_cards(card, nil, nil, true)
                return {
                    colour = G.C.RED,
                    message = "WHAT ARE YOU STANDING UP FOR!!!",
                    sound = "fgc_woshige2015",
                    pitch = 1,
                    volume = 0.7
                }
            end
        end
        if context.joker_main then
            return {
                xmult = card.ability.extra.Xmult
            }
        end
    end
}
SMODS.Joker {
    key = "BrianF",
    loc_txt = {
        ['name'] = 'Brian_F',
        ['text'] = {
            [1] = "Retrigger all played {C:attention}Stone{} cards",
            [2] = "All {C:attention}Stone{} cards are {C:attention}Gold{} cards"
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {x=0,y=0},
    cost = 10,
    rarity = 2,
    unlocked = true,
    discovered = true,
    atlas = 'fgc_brian_f',
    config = { extra = { repetitions = 2} },
    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play and context.other_card.config.center.key == "m_stone" then
            return {
                repetitions = card.ability.extra.repetitions
            }
        end
        if context.check_enhancement and context.other_card.config.center.key == "m_stone" then
            return {
                m_gold = true
            }
        end
        if context.selling_self then
            return {
                message = "...And the rage quit, let's go!",
                sound = "fgc_andtheragequit",
                pitch = 1,
            }
        end
    end
}

SMODS.Joker { -- Sajam
    key = "Sajam",
    loc_txt = {
        ['name'] = 'Sajam',
        ['text'] = {
            [1] = '{C:rare}Sajam{} Jokers',
            [2] = 'each give {X:mult,C:white} X2 {} Mult'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {x=0,y=0},
    cost = 6,
    rarity = 3,
    unlocked = true,
    discovered = true,
    atlas = 'fgc_sajam',
    fgc_sajam = true,
    config = {
        extra = {
            xmult = 2
        }
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {card.ability.extra.xmult}
        }
    end,
    calculate = function(self, card, context)
        if context.other_joker and (context.other_joker.config.center.fgc_sajam == true) then
            return {
                xmult = card.ability.extra.xmult
            }
        end
        if context.selling_self then
            return {
                sound = "fgc_stevemyarm",
                pitch = 1,
                message = "STEVE MY ARM!!!"
            }
        end
    end
}

SMODS.Joker { -- Sajam (Twitch)
    key = "SajamTwitch",
    loc_txt = {
        ['name'] = 'Sajam {C:dark_edition}(Twitch)',
        ['text'] = {
            [1] = '{X:mult,C:white} +1 {} Mult for every',
            [2] = '{C:attention}10 viewers{} on {C:dark_edition}Twitch',
            [3] = '{C:inactive}Currently {C:red}+#2#{C:inactive} Mult'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {x=0,y=0},
    cost = 7,
    rarity = 3,
    unlocked = true,
    discovered = true,
    atlas = 'fgc_sajamtwitch',
    fgc_sajam = true,
    config = {
        extra = {
            perviewer = 1,
            viewercount = activeviewers / 10
        }
    },
    loc_vars = function(self, info_queue, center)
        return {
            vars = {center.ability.extra.perviewer, center.ability.extra.viewercount}
        }
    end,
    update = function(self,card,dt)
        recheckTwitch()
    end,
    calculate = function(self, card, context)
        card.ability.extra.viewercount = activeviewers * card.ability.extra.perviewer / 10
        if context.joker_main then
            return {
                colour = G.C.RED,
                message = "+" .. card.ability.extra.viewercount,
                mult_mod = card.ability.extra.viewercount
            }
        end
        if context.selling_self then
            return {
                sound = "fgc_stevemyarm",
                pitch = 1,
                message = "STEVE MY ARM!!!"
            }
        end
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
            recheckTwitch(true)
        end
    end
}

SMODS.Joker {
    key = "Arcade Cabinet",
    loc_txt = {
        ['name'] = 'Arcade Cabinet',
        ['text'] = {
            [1] = '{X:chips,C:white} +1 {} Chip for each person playing',
            [2] = '{X:default,C:edition}#1#{} on {C:dark_edition}Steam',
            [3] = '{C:inactive}(resets every blind)',
            [4] = '{C:inactive}Currently {C:blue}+#2#{C:inactive} Chips'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    cost = 4,
    rarity = 2,
    unlocked = true,
    discovered = true,
    atlas = 'fgc_arcadecabinet',
    config = {
        extra = {
            name = activegame_name,
            activegame_players = activegame_players
        }
    },
    update = function(self,card,dt)
        recheckSteam()
    end,
    loc_vars = function(self, info_queue, center)
        return {
            vars = {center.ability.extra.name, center.ability.extra.activegame_players}
        }
    end,
    calculate = function(self, card, context)
        card.ability.extra.activegame_players = activegame_players
        card.ability.extra.name = activegame_name
        if context.joker_main then
            return {
                colour = G.C.BLUE,
                message = "+" .. card.ability.extra.activegame_players,
                chip_mod = card.ability.extra.activegame_players
            }
        end
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
            recheckSteam(true)
            return {
                message = localize('k_reset')
            }
        end
    end
}

SMODS.Joker {
    key = "Active Tag",
    loc_txt = {
        ['name'] = 'Active Tag',
        ['text'] = {
            [1] = 'Retriggers the next activated {C:attention}Joker{}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    unlocked = true,
    discovered = true,
    config = { extra = { repetitions = 1 } },
    atlas = 'fgc_activetag',
    in_pool = function(self,args)
        return false
    end,
    calculate = function(self, card, context)
        if context.retrigger_joker_check then
            return { 
                repetitions = 1,
                colour = G.C.GREEN,
                message = "Tag!",
                SMODS.destroy_cards(card, nil, nil, true),
            }
        end
    end
}

G.last_update_time_twitch = 0
function recheckTwitch(forceRecheck) -- THANK YOU YAHIAMICE FOR THIS DOCUMENTATION GO SUBSCRIBE TO HIM
    if ((os.time() - G.last_update_time_twitch) >= 90) or forceRecheck then
        G.last_update_time_twitch = os.time()
        local json = require "json"
        local succ, https = pcall(require, "SMODS.https")
        local url = "https://gql.twitch.tv/gql"
        local options = {
            method = "POST",

            data = '[{"operationName":"VideoMetadata","variables":{"channelLogin":"Sajam","videoID":"0"},"extensions":{"persistedQuery":{"version":1,"sha256Hash":"45111672eea2e507f8ba44d101a61862f9c56b11dee09a15634cb75cb9b9084d"}}}]',
            headers = {
                ["Client-ID"] = "kimne78kx3ncx6brgo4mv6wki5h1ko",
                ["user-agent"] = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36",
                ["Content-Type"] = "application/json"
            }
        }

        local status, body, headers = https.request(url, options)

        local ok, parsed = pcall(json.decode, body or "")
        if not ok or type(parsed) ~= "table" then
            G.activefollowers = 67000
            activeviewers = 0
            print("Couldn't JSON decode for some reason. Check your VPN?")
            return
        end

        G.twitchbodyjson = json.decode(body)
        G.activefollowers = G.twitchbodyjson[1].data.user.followers.totalCount
        activeviewers = 0
        if G.twitchbodyjson[1].data.user.stream then
            activeviewers = G.twitchbodyjson[1].data.user.stream.viewersCount
        else
            print("Failed to parse viewer count! Maybe offline?")
        end
    end
end

G.last_update_time_steam = 0
function recheckSteam(forceRecheck)
    if ((os.time() - G.last_update_time_steam) >= 90) or forceRecheck then
        G.last_update_time_steam = os.time()

        local json = require "json"
        local succ, https = pcall(require, "SMODS.https")
        if not succ then
            return
        end
        local game = FGC_GAMES[math.random(#FGC_GAMES)]
        activegame_name = game.name
        activegame_players = 0

        local url = "https://api.steampowered.com/ISteamUserStats/GetNumberOfCurrentPlayers/v1/?appid=" .. game.appid
        local status, body = https.request(url)

        if not body then
            return
        end

        local ok, parsed = pcall(json.decode, body)
        if ok and parsed.response then
            activegame_players = parsed.response.player_count or 0
        end
    end
end