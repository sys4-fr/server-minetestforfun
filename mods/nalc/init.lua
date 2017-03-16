-- Change some craft recipe of Witchcraft
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

	-- Register craft recipe of bones:bones with bonemeal:bone
	if minetest.get_modpath("bones")
		and minetest.get_modpath("bonemeal") and bonemeal
	then
		minetest.register_craft(
			{
				output = "bones:bones",
				recipe = {
					{"bonemeal:bone", "bonemeal:bone", "bonemeal:bone"},
					{"bonemeal:bone", "bonemeal:bone", "bonemeal:bone"},
					{"bonemeal:bone", "bonemeal:bone", "bonemeal:bone"},
				}
			})
	end

	-- Override craft recipe of witchcraft:shelf
	if minetest.get_modpath("vessels") then
		minetest.clear_craft(
			{
				recipe = {
					{"group:wood", "group:wood", "group:wood"},
					{"group:potion", "group:potion", "group:potion"},
					{"group:wood", "group:wood", "group:wood"},
				}
			})

		minetest.register_craft(
			{
				output = "witchcraft:shelf",
				recipe = {
					{"", "group:potion", ""},
					{"group:potion", "vessels:shelf", "group:potion"},
				}
			})
	end
end
