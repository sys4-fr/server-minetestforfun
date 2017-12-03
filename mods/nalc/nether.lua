-- Nether Toolranks
if minetest.get_modpath("nether") and minetest.get_modpath("toolranks") then

	-- Nether Pickaxes
	minetest.override_item(
		"nether:pick_mushroom",
		{
			original_description = "Nether Mushroom Pickaxe",
			description = toolranks.create_description("Nether Mushroom Pickaxe", 0, 1),
			after_use = toolranks.new_afteruse
		})

	minetest.override_item(
		"nether:pick_wood",
		{
			original_description = "Nether Wood Pickaxe",
			description = toolranks.create_description("Nether Wood Pickaxe", 0, 1),
			after_use = toolranks.new_afteruse
		})

	minetest.override_item(
		"nether:pick_netherrack",
		{
			original_description = "Netherrack Pickaxe",
			description = toolranks.create_description("Netherrack Pickaxe", 0, 1),
			after_use = toolranks.new_afteruse
		})

	minetest.override_item(
		"nether:pick_netherrack_blue",
		{
			original_description = "Blue Netherrack Pickaxe",
			description = toolranks.create_description("Blue Netherrack Pickaxe", 0, 1),
			after_use = toolranks.new_afteruse
		})

	minetest.override_item(
		"nether:pick_white",
		{
			original_description = "Siwtonic Pickaxe",
			description = toolranks.create_description("Siwtonic Pickaxe", 0, 1),
			after_use = toolranks.new_afteruse
		})

	-- Nether Axes
	minetest.override_item(
		"nether:axe_netherrack",
		{
			original_description = "Netherrack Axe",
			description = toolranks.create_description("Netherrack Axe", 0, 1),
			after_use = toolranks.new_afteruse
		})

	minetest.override_item(
		"nether:axe_netherrack_blue",
		{
			original_description = "Blue Netherrack Axe",
			description = toolranks.create_description("Blue Netherrack Axe", 0, 1),
			after_use = toolranks.new_afteruse
		})

	minetest.override_item(
		"nether:axe_white",
		{
			original_description = "Siwtonic Axe",
			description = toolranks.create_description("Siwtonic Axe", 0, 1),
			after_use = toolranks.new_afteruse
		})

	-- Nether Shovels
	minetest.override_item(
		"nether:shovel_netherrack",
		{
			original_description = "Netherrack Shovel",
			description = toolranks.create_description("Netherrack Shovel", 0, 1),
			after_use = toolranks.new_afteruse
		})

	minetest.override_item(
		"nether:shovel_netherrack_blue",
		{
			original_description = "Blue Netherrack Shovel",
			description = toolranks.create_description("Blue Netherrack Shovel", 0, 1),
			after_use = toolranks.new_afteruse
		})

	minetest.override_item(
		"nether:shovel_white",
		{
			original_description = "Siwtonic Shovel",
			description = toolranks.create_description("Siwtonic Shovel", 0, 1),
			after_use = toolranks.new_afteruse
		})
end
