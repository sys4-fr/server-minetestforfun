-- Redefine some crafts
minetest.clear_craft({output = "carts:rail"})
minetest.clear_craft({output = "default:rail"})

minetest.register_craft(
	{
		output = "carts:rail 24",
		recipe = {
			{"default:steel_ingot", "group:wood", "default:steel_ingot"},
			{"default:steel_ingot", "", "default:steel_ingot"},
			{"default:steel_ingot", "group:wood", "default:steel_ingot"}
		}
	})

-- Aliases
minetest.register_alias("carts:rail_copper", "moreores:copper_rail")
