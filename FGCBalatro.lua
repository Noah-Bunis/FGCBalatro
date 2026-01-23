FGCBalatro = {}
SMODS.current_mod.optional_features = {
    retrigger_joker = true,
post_trigger = true}
assert(SMODS.load_file("globals.lua"))()

--[[
-- Jokers
local joker_src = NFS.getDirectoryItems(SMODS.current_mod.path .. "jokers")
for _, file in ipairs(joker_src) do
    assert(SMODS.load_file("jokers/" .. file))()
end ]]


local items_src = NFS.getDirectoryItems(SMODS.current_mod.path .. "items")
for _, file in ipairs(items_src) do
    assert(SMODS.load_file("items/" .. file))()
end