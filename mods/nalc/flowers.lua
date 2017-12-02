minetest.register_node("nalc:lily_pad", {
	description = "Lily Pad",
	drawtype = "nodebox",
	tiles = { "flowers_lily_pad.png" },
	inventory_image = "flowers_lily_pad.png",
	wield_image = "flowers_lily_pad.png",
	wield_scale = {x = 1, y = 1, z = 0.001},
	is_ground_content = true,
	sunlight_propagates = true,
	paramtype = "light",
	walkable = false,
	buildable_to = true,
	groups = {snappy = 3, flammable = 2, flower = 1, flora = 1},
	sounds = default.node_sound_leaves_defaults(),
	node_box = {
		type = "fixed",
		fixed = {-0.5, -0.45, -0.5, 0.5, -0.4375, 0.5},
	},
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, -0.4375, 0.5},
	},
})

minetest.register_decoration({
	deco_type = "simple",
	place_on = {"default:water_source"},
	sidelen = 16,
	noise_params = {
		offset = 0,
		scale = 0.006,
		spread = {x=100, y=100, z=100},
		seed = 436,
		octaves = 3,
		persist = 0.6
	},
	y_min = -10,
	y_max = 30,
	decoration = "nalc:lily_pad",
})

minetest.register_alias("flowers:lily_pad", "nalc:lily_pad")
