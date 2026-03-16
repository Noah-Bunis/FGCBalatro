return {
    descriptions = {
        Joker = {
            j_fgc_Yipes = {
                name = "IFC Yipes",
                text = {'If played hand contains', "a {C:attention}#1#,", '{B:1,C:edition}call an assist{}'}
            },
            j_fgc_Yipes_mag = {
                name = "IFC Yipes",
                text = {'If played hand contains', "a {C:attention}#1#,", "{B:1,C:edition}WHERE YO' CURLY MUSTACHE AT?!","each played card gives",
                    "{X:chips,C:white} X#2#{} Chips when scored"}
            },
            j_fgc_Yipes_storm = {
                name = "IFC Yipes",
                text = {'If played hand contains', "a {C:attention}#1#,", 
                "{B:1,C:edition}MAKE IT RAIN!{}","played cards earn {C:money}$#3#{} when scored"}
            },
            j_fgc_Yipes_sent = {
                name = "IFC Yipes",
                text = {'If played hand contains', "a {C:attention}#1#,", 
                "{B:1,C:edition}OH HE GOT THE MANGO SENTINEL!{}","gain {C:blue}+#4#{} hand"}
            },
        },
        Planet = {
            c_fgc_thelocals = {
                name = "The Locals",
                text = {"({V:1}lvl.#1#{}) Level up", "{C:attention}#2#", "{C:mult}+#3#{} Mult and",
                        "{C:chips}+#4#{} chips"}
            }
        },
        Tarot = {
            c_fgc_leverless = {
                name = "The Leverless",
                text = {
                    "Add a {C:attention}Modern Seal{}",
                    "to {C:attention}#1#{} selected",
                    "cards in your hand",
                },
            }
        },
        Tag = {
            tag_fgc_activetag = {
                name = "Active Tag",
                text = {"Retriggers the next activated {C:attention}Joker{}"}
            },
            tag_fgc_willitkill_tag = {
                name = "WILL IT KILL...?",
                text = {"Alrighty then chatroom..."}
            }
        },
        Blind = {
            bl_fgc_beast = {
                name = "The Beast",
                text = {"UMEHARA GA!", "TSUKAMAETE!","UMEHARA GA!","GAMEN HASHI!","BAASUTO YONDE!","MADA HAIRU!","UMEHARA GA!","...CHIKAZUITE!","UMEHARA GA KIMETAAAA!!!!!!!"}
            },
            bl_fgc_bull = {
                name = "The Bull",
                text = {"Using your last discard","puts you in {C:attention}burnout{}"}
            }
        },
        Other = {
            fgc_modern_seal = {
                name = "Modern Seal",
                text = {"Card is treated as {C:attention}Lucky{}", "Score {C:red,E:2}#1#% less{} {C:blue}Chips"}
            }
        }  
    },
    misc = {
        poker_hand_descriptions = {
            ["fgc_HalfCircle"] = {"A hand containing 41236 (its numpad notation)"}
        },
        poker_hands = {
            ["fgc_HalfCircle"] = "Half Circle"
        },
        labels = {
            fgc_modern_seal = "Modern Seal"
        }
    }
}
