local activeviewers = 0
local activegame_name = "[RANDOM FIGHTING GAME]"
local activegame_players = 0

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
    pos = {
        x = 0,
        y = 0
    },
    display_size = {
        w = 71 * 1,
        h = 95 * 1
    },
    cost = 6,
    rarity = 3,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
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
    pos = {
        x = 0,
        y = 0
    },
    display_size = {
        w = 71 * 1,
        h = 95 * 1
    },
    cost = 7,
    rarity = 3,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
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

    calculate = function(self, card, context)
        recheckTwitch()
        card.ability.extra.viewercount = activeviewers * card.ability.extra.perviewer / 10
        if context.joker_main then
            return {
                colour = G.C.RED,
                sound = "fgc_stevemyarm",
                pitch = 1,
                message = "+" .. card.ability.extra.viewercount,
                mult_mod = card.ability.extra.viewercount
            }
        end
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
            recheckTwitch("please")
        end
    end
}

SMODS.Joker {
    key = "Dusty Cabinet",
    loc_txt = {
        ['name'] = 'Dusty Cabinet',
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
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'fgc_sajam',
    config = {
        extra = {
            name = activegame_name,
            activegame_players = activegame_players
        }
    },
    loc_vars = function(self, info_queue, center)
        return {
            vars = {center.ability.extra.name, center.ability.extra.activegame_players}
        }
    end,

    calculate = function(self, card, context)
        recheckSteam()
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
            recheckSteam("please")
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
    activated = false,
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
    

SMODS.Atlas {
    key = "fgc_sajam",
    path = "fgc_j_sajam.png",
    px = 71,
    py = 95
}

SMODS.Atlas {
    key = "fgc_sajamtwitch",
    path = "fgc_j_sajamtwitch.png",
    px = 71,
    py = 95
}

SMODS.Atlas {
    key = "fgc_activetag",
    path = "fgc_j_activetag.png",
    px = 71,
    py = 95
}

G.last_update_time = 0
function recheckTwitch(please) -- THANK YOU YAHIAMICE FOR THIS DOCUMENTATION GO SUBSCRIBE TO HIM

    if ((os.time() - G.last_update_time) >= 90) or please == "please" then
        G.last_update_time = os.time()
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

function recheckSteam(please)
    if ((os.time() - G.last_update_time) >= 90) or please == "please" then
        G.last_update_time = os.time()

        local json = require "json"
        local succ, https = pcall(require, "SMODS.https")
        if not succ then
            return
        end

        local games = { -- No I will not make a seperate file to store these in
            {appid=1364780,name="Street Fighter 6"}, {appid=310950,name="Street Fighter V"}, {appid=45760,name="Ultra Street Fighter IV"},
            {appid=1778820,name="TEKKEN 8"}, {appid=389730,name="TEKKEN 7"},
            {appid=1971870,name="Mortal Kombat 1"}, {appid=976310,name="Mortal Kombat 11"}, {appid=307780,name="Mortal Kombat X"},
            {appid=1384160,name="GUILTY GEAR -STRIVE-"}, {appid=520440,name="GUILTY GEAR Xrd -REVELATOR-"}, {appid=348550,name="GUILTY GEAR XX ACCENT CORE PLUS R"},
            {appid=586140,name="BlazBlue Centralfiction"}, {appid=702890,name="BlazBlue Cross Tag Battle"}, {appid=388750,name="BlazBlue Chronophantasma Extend"}, {appid=678950,name="DRAGON BALL FighterZ"},
            {appid=1498570,name="The King of Fighters XV"}, {appid=571260,name="The King of Fighters XIV"}, {appid=222440,name="The King of Fighters 2002 Unlimited Match"}, {appid=222940,name="The King of Fighters XIII"},
            {appid=1342260,name="Samurai Shodown"}, {appid=1076550,name="Samurai Shodown V Special"}, {appid=544750,name="Soulcalibur VI"},
            {appid=1372280,name="Melty Blood: Type Lumina"}, {appid=411370,name="Melty Blood Actress Again Current Code"},
            {appid=2076010,name="UNDER NIGHT IN-BIRTH II Sys:Celes"}, {appid=801630,name="UNDER NIGHT IN-BIRTH Exe:Late[cl-r]"},
            {appid=2157560,name="Granblue Fantasy Versus: Rising"}, {appid=245170,name="Skullgirls 2nd Encore"}, {appid=383980,name="Rivals of Aether"}, {appid=2217000,name="Rivals of Aether II"},
            {appid=291550,name="Brawlhalla"}, {appid=1818750,name="MultiVersus"}, {appid=2017080,name="Nickelodeon All-Star Brawl 2"},
            {appid=1372110,name="JoJo's Bizarre Adventure: All-Star Battle R"}, {appid=577940,name="Killer Instinct"},
            {appid=838380,name="Dead or Alive 6"}, {appid=311730,name="Dead or Alive 5 Last Round"}, {appid=1687950,name="Virtua Fighter 5 Ultimate Showdown"},
            {appid=390560,name="Fantasy Strike"}, {appid=553310,name="Lethal League Blaze"}, {appid=1344740,name="FOOTSIES"}, {appid=574980,name="Them's Fightin' Herds"},
            {appid=1110100,name="Power Rangers: Battle for the Grid"}, {appid=432800,name="Dengeki Bunko: Fighting Climax Ignition"}, {appid=2157100,name="Iron Saga VS"},
            {appid=2634890,name="MARVEL vs. CAPCOM Fighting Collection: Arcade Classics"}, {appid=1685750,name="Capcom Fighting Collection"}, {appid=2400430,name="Capcom Fighting Collection 2"},
            {appid=357190,name="Ultimate Marvel vs. Capcom 3"}, {appid=493840,name="Marvel vs. Capcom: Infinite"},
            {appid=1742020,name="Idol Showdown"}, {appid=1999500,name="Blazing Strike"}, {appid=2456420,name="HUNTER×HUNTER NEN×IMPACT"}, {appid=1420350,name="Fraymakers"},
            {appid=586200,name="Street Fighter 30th Anniversary Collection"}, {appid=2313020,name="Umamusume: Pretty Derby - Party Dash"}, {appid=1719690, name="MerFight"}, {appid=3041800, name="Scramble Heart City"},
            {appid=627270,name="Injustice™ 2"}, {appid=242700,name="Injustice: Gods Among Us Ultimate Edition"}, {appid=237110,name="Mortal Kombat Komplete Edition"}, {appid=2212330,name="Your Only Move Is HUSTLE"},
            {appid=2492040,name="FATAL FURY: City of the Wolves"},{appid=366240,name="GAROU: MARK OF THE WOLVES"},{appid=3454980,name="Mortal Kombat: Legacy Kollection"},
            {appid=222420,name="THE KING OF FIGHTERS '98 ULTIMATE MATCH FINAL EDITION"},{appid=661990,name="Arcana Heart 3 LOVEMAX SIXSTARS!!!!!! XTEND"},{appid=244730,name="Divekick"}
        }
        local game = games[math.random(#games)]
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