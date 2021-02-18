
digibuilder = {
  max_radius = tonumber(minetest.settings:get("digibuilder.max_radius")) or 15,
  setnode_delay = tonumber(minetest.settings:get("digibuilder.setnode_delay")) or 0.5,
}

local MP = minetest.get_modpath("digibuilder")

dofile(MP.."/marker.lua")
dofile(MP.."/create_fake_player.lua")
dofile(MP.."/formspec.lua")
dofile(MP.."/digiline_rules.lua")
dofile(MP.."/digiline_validate_pos.lua")
dofile(MP.."/digiline.lua")
dofile(MP.."/node.lua")
dofile(MP.."/recipe.lua")
