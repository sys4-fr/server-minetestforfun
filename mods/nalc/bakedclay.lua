-- If bakedclay loaded then remove "dye:grey 3" craft recipe
-- in order to avoid unifieddyes conflict

if minetest.get_modpath("unifieddyes") then
	minetest.clear_craft(
		{
			output = "dye:grey"
		})
	minetest.register_craft(
		{
			type = "shapeless",
			output = "dye:grey 2",
			recipe = {"dye:black", "dye:white"}
		})
end
