
-- Lava Flan by Zeg9

mobs:register_mob("mobs:lava_flan", {
	-- animal, monster, npc, barbarian
	type = "monster",
	-- aggressive, deals 5 damage to player when hit
	passive = false,
	attack_type = "dogfight",
	damage = 5,
	-- health and armor
	hp_min = 20, hp_max = 35, armor = 80,
	-- textures and model
	collisionbox = {-0.5, -0.5, -0.5, 0.5, 1.5, 0.5},
	visual = "mesh",
	mesh = "zmobs_lava_flan.x",
	drawtype = "front",
	available_textures = {
		total = 1,
		texture_1 = {"zmobs_lava_flan.png"},
	},
	blood_texture = "fire_basic_flame.png",
	visual_size = {x=1, y=1},
	-- sounds
	makes_footstep_sound = true,
	sounds = {
		random = "mobs_lavaflan",
		war_cry = "mobs_lavaflan",
		death = nil,
	},
	-- speed and jump, sinks in water
	walk_velocity = 0.5,
	run_velocity = 2,
	jump = true,
	-- step = 2, (c'était pas mal, voir comment faire pour le remettre comme ça ?) 
	view_range = 16,
	floats = 0,
	-- chance of dropping lava orb when dead
	drops = {
		{name = "mobs:lava_orb",
		chance = 15, min = 1, max = 1,},
	},
	-- damaged by
	water_damage = 5,
	lava_damage = 0,
	light_damage = 0,
	-- model animation
	animation = {
		speed_normal = 15,		speed_run = 15,
		stand_start = 0,		stand_end = 8,
		walk_start = 10,		walk_end = 18,
		run_start = 20,			run_end = 28,
		punch_start = 20,		punch_end = 28,
	},
})
-- spawns in lava between -1 and 20 light, 1 in 2000 chance, 2 in area below 31000 in height
mobs:register_spawn("mobs:lava_flan", {"default:lava_source"}, 20, -1, 2000, 2, 31000)
-- register spawn egg
mobs:register_egg("mobs:lava_flan", "Lava Flan", "default_lava.png", 1)

-- Lava Orb
minetest.register_craftitem("mobs:lava_orb", {
	description = "Lava orb",
	inventory_image = "zmobs_lava_orb.png",
})
minetest.register_alias("zmobs:lava_orb", "mobs:lava_orb")
