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

-- Add recipes for extractor

if minetest.get_modpath("dye") then
	local unifieddyes = minetest.get_modpath("unifieddyes")
	local dye_recipes =
		{
			{"bakedclay:delphinium", "dye:cyan 4"},
			{"bakedclay:lazarus", "dye:pink 4"},
			{"bakedclay:mannagrass", "dye:dark_green 4"},
			{"bakedclay:thistle", "dye:magenta 4"},
			{"nalc:scorched_stuff", "dye:black 4"},
			{"moreflowers:wild_carrot", "dye:white 2"},
			{"moreflowers:teosinte", unifieddyes and "unifieddyes:lime 2"},
			{"morefarming:wildcarrot", "dye:white 4"},
			{"morefarming:teosinte", unifieddyes and "unifieddyes:lime 4"}
		}

	for _, data in ipairs(dye_recipes) do
		technic.register_extractor_recipe({input = {data[1]}, output = data[2]})
	end

	-- overwrite the existing crafting recipes
	minetest.register_craft(
		{
			type = "shapeless",
			output = "dye:cyan 1",
			recipe = {"bakedclay:delphinium"}
		})

	minetest.register_craft(
		{
			type = "shapeless",
			output = "dye:pink 1",
			recipe = {"bakedclay:lazarus"}
		})

	minetest.register_craft(
		{
			type = "shapeless",
			output = "dye:dark_green 1",
			recipe = {"bakedclay:mannagrass"}
		})

	minetest.register_craft(
		{
			type = "shapeless",
			output = "dye:magenta 1",
			recipe = {"bakedclay:thistle"}
		})
end
