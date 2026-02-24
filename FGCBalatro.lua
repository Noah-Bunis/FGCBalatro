FGCBalatro = {}
SMODS.current_mod.optional_features = {
    retrigger_joker = true,
post_trigger = true, quantum_enhancements = true}

local items_src = NFS.getDirectoryItems(SMODS.current_mod.path .. "items")
for _, file in ipairs(items_src) do
    assert(SMODS.load_file("items/" .. file))()
end