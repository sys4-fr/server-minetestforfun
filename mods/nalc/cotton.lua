
-- clear existing craft recipes for white wool and cotton
minetest.clear_craft(
	{
		recipe = {
			{"farming:cotton", "farming:cotton"},
			{"farming:cotton", "farming:cotton"},
		}
	})

-- register wool:white craft recipe
minetest.register_craft(
	{
		output = "wool:white",
		recipe = {
			{"farming:cotton", "farming:cotton"},
			{"farming:cotton", "farming:cotton"},
		}
	})

-- register cotton:white craft recipe
minetest.register_craft(
	{
		output = "cotton:white 4",
		recipe = {
			{"wool:white", "wool:white"},
			{"wool:white", "wool:white"},
		}
	})
