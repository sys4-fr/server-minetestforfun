-- Scorched_stuff from cooking rat cooked

-- mobs redo bug !!!
minetest.clear_craft({output="mobs:rat_cooked"})
minetest.register_craft({
		type = "cooking",
		output = "mobs:rat_cooked",
		recipe = "mobs_animal:rat",
		cooktime = 15
	})

minetest.register_craft({
	type = "cooking",
	output = "nalc:scorched_stuff",
	recipe = "mobs:rat_cooked",
	cooktime = 10
})

minetest.register_craft({
	type = "shapeless",
	output = "dye:black",
	recipe = {"nalc:scorched_stuff"},
})

minetest.register_craft({
	type = "fuel",
	recipe = "nalc:scorched_stuff",
	burntime = 20,
})
