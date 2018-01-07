
-- Zombie by BlockMen

local drop_coin = nil -- NALC : Drop silver coin if maptools mod
local drop_napple = nil -- NALC : Drop nether apple if nether

if minetest.get_modpath("maptools") then
	drop_coin = {
		name = "maptools:silver_coin",
		chance = 1,	min = 1,	max = 1
	}
end

if minetest.get_modpath("nether") then
	drop_napple = {
		name = "nether:apple",
		chance = 8, min = 1, max = 1
	}
end	

mobs:register_mob(
	"zombie:zombie",
	{
		-- animal, monster, npc, barbarian
		type = "monster",
		-- aggressive, deals 6 damage to player when hit
		passive = false,
		attack_type = "dogfight",
		pathfinding = false,
		damage = 3,
		-- health & armor
		hp_min = 12,
		hp_max = 35,
		armor = 150,
		-- textures and model
		collisionbox = {-0.25, -1, -0.3, 0.25, 0.75, 0.3},
		visual = "mesh",
		mesh = "mobs_zombie.x",
		textures = {
			{"mobs_zombie.png"},
		},
		visual_size = {x=1, y=1},
		blood_texture = "mobs_blood.png",
		-- sounds
		makes_footstep_sound = true,
		sounds = {
			random = "mobs_zombie",
			damage = "mobs_zombie_hit",
			attack = "mobs_zombie_attack",
			death = "mobs_zombie_death",
		},
		-- speed and jump
		view_range = 10,
		walk_velocity = 1,
		run_velocity = 3,
		jump = true,
		floats = 0,
		-- drops nether fruit and silver coin when dead
		drops = {
			{name = "zombie:rotten_flesh",
			 chance = 2, min = 3, max = 5,},
			{name = "zombie:zombie_tibia",
			 chance = 10, min = 1, max = 1,},
			drop_napple, -- NALC
			drop_coin -- NALC
		},
		-- damaged by
		water_damage = 1,
		lava_damage = 5,
		light_damage = 2,
		-- model animation
		animation = {
			speed_normal = 10,		speed_run = 15,
			stand_start = 0,		stand_end = 79,
			walk_start = 168,		walk_end = 188,
			run_start = 168,		run_end = 188,
			--		punch_start = 168,		punch_end = 188,
		},
	})
mobs:alias_mob("mobs:zombie", "zombie:zombie")

-- spawn in nether forest between -1 and 5 light, 1 in 7000 chance, 1 zombie in area up to 31000 in height
mobs:spawn_specific("zombie:zombie", {"nether:dirt_top", "default:dirt_with_grass", "default:dirt", "default:stone"}, {"air"}, -1, 5, 30, 7000, 1, -31000, 31000, false)
-- register spawn egg
mobs:register_egg("zombie:zombie", "Zombie", "mobs_zombie_inv.png", 1)

minetest.register_craftitem(
	"zombie:zombie_tibia",
	{
		description = "Zombie Tibia",
		inventory_image = "mobs_zombie_tibia.png",
		groups = {magic = 1},
	})
minetest.register_alias("mobs:zombie_tibia", "zombie:zombie_tibia")

minetest.register_craftitem(
	"zombie:rotten_flesh",
	{
		description = "Rotten Flesh",
		inventory_image = "mobs_rotten_flesh.png",
		
		on_use = function(itemstack, user) -- NALC : Augmente la faim de 5 points mais augmente la vie de 1 point
			local inv = user:get_inventory()
			if not inv then return end
			itemstack:take_item()
			
			-- Augmente la vie de 1 point
			user:set_hp(user:get_hp() + 1)
			
			-- Si hbhunger alors augmente la faim de 5 points (Réduction de la barre de faim)
			if minetest.get_modpath("hbhunger") then
				local p_hunger = tonumber(hbhunger.hunger[user:get_player_name()])
				if not p_hunger then return end
				p_hunger = p_hunger - 5
				if p_hunger < 0 then p_hunger = 0 end
				hbhunger.hunger[user:get_player_name()] = p_hunger
				local save_hunger = hbhunger.save_hunger
				if not save_hunger then save_hunger = hbhunger.set_hunger end
				save_hunger(user)
			end
			
			return itemstack
		end
	})

minetest.register_craft({
	type = "cooking",
	output = "mobs:meat",
	recipe = "zombie:rotten_flesh",
	cooktime = 5,
})
