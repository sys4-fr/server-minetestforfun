
-- Wolf by KrupnoPavel

local drop_coin = nil -- NALC : Drop silver coin by chance if maptools mod loaded
if minetest.get_modpath("maptools") then
	drop_coin = {
		name = "maptools:silver_coin",
		chance = 4, min = 1, max = 1,
	}
end

mobs:register_mob(
	"pmobs:wolf",
	{
		type = "monster",
		docile_by_day = true,
		passive = false,
		pathfinding = false,
		reach = 2,
		hp_min = 15,
		hp_max = 20,
		armor = 200,
		passive = false,
		collisionbox = {-0.4, -0.01, -0.4, 0.4, 1, 0.4},
		visual = "mesh",
		mesh = "mobs_wolf.x",
		textures = {
			{"mobs_wolf.png"},
		},
		makes_footstep_sound = true,
		sounds = {
			random = "mobs_wolf",
			war_cry = "mobs_wolf_attack",
		},
		view_range = 7,
		walk_velocity = 2,
		run_velocity = 3,
		stepheight = 1.1,
		damage = 3,
		attack_type = "dogfight",
		drops = {
			{
				name = "mobs:meat_raw",
				chance = 1,
				min = 2,
				max = 3,
			},
			drop_coin -- NALC
		},
		drawtype = "front",
		water_damage = 0,
		lava_damage = 5,
		light_damage = 0,
		on_rightclick = function(self, clicker)
			local tool = clicker:get_wielded_item():get_name()
			if tool == "mobs:meat_raw" or
			(minetest.get_modpath("zombie") and tool == "zombie:rotten_flesh") then
				clicker:get_inventory():remove_item("main", tool)
				minetest.add_entity(self.object:getpos(), "pmobs:dog")
				self.object:remove()
			end
		end,
		animation = {
			speed_normal = 20,
			speed_run = 30,
			stand_start = 10,
			stand_end = 20,
			walk_start = 75,
			walk_end = 100,
			run_start = 100,
			run_end = 130,
			punch_start = 135,
			punch_end = 155,
		},
		jump = true,
		step = 0.5,
		blood_texture = "mobs_blood.png",
	})
mobs:register_spawn("pmobs:wolf", {"default:dirt_with_grass","default:dirt","default:snow", "default:snowblock"}, 20, -1, 100000, 1, 31000)
mobs:register_egg("pmobs:wolf", "Wolf", "wool_grey.png", 1)

mobs:alias_mob("mobs:wolf", "pmobs:wolf")
