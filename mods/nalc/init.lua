-- Change craft recipe of Witchcraft:tooth
if minetest.get_modpath("witchcraft") then

	-- clear crafts with this particular recipe
	minetest.clear_craft(
		{
			recipe = { {"default:sand"} }
		})

	-- register default:desert_sand (by MFF)
	minetest.register_craft(
		{
			output = "default:desert_sand",
			recipe = {
				{"default:sand"},
			}
		})

	-- register witchcraft:tooth (by NALC)
	minetest.register_craft(
		{
			output = "witchcraft:tooth",
			recipe = {
				{"default:sand", "", "default:sand"},
				{"", "default:sand", ""},
			}
		})	
end
