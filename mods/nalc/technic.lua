-- Add superquarry machine
dofile(minetest.get_modpath(minetest.get_current_modname()).."/technic/superquarry.lua")

-- Add uranium to below levels
local uranium_params = {offset = 0, scale = 1, spread = {x = 100, y = 100, z = 100}, seed = 420, octaves = 3, persist = 0.7}
local uranium_threshold = 0.55

minetest.register_ore({
	ore_type         = "scatter",
	ore              = "technic:mineral_uranium",
	wherein          = "default:stone",
	clust_scarcity   = 7*7*7,
	clust_num_ores   = 4,
	clust_size       = 3,
	y_min       = -1000,
	y_max       = -301,
	noise_params     = uranium_params,
	noise_threshold = uranium_threshold,
})

minetest.register_ore({
	ore_type         = "scatter",
	ore              = "technic:mineral_uranium",
	wherein          = "default:stone",
	clust_scarcity   = 6*6*6,
	clust_num_ores   = 4,
	clust_size       = 3,
	y_min       = -28000,
	y_max       = -1001,
	noise_params     = uranium_params,
	noise_threshold = uranium_threshold,
})
