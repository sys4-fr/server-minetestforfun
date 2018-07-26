armor.config.material_reinforcedleather = true
armor.config.material_hardenedleather = true
armor.config.material_blackmithril = true

armor.materials.reinforcedleather = "3d_armor:reinforcedleather"
armor.materials.hardenedleather = "3d_armor:hardenedleather"
armor.materials.blackmithril = "3d_armor:blackmithril_ingot"

-- Load Configuration

for name, config in pairs(armor.config) do
	local setting = minetest.settings:get("armor_"..name)
	if type(config) == "number" then
		setting = tonumber(setting)
	elseif type(config) == "boolean" then
		setting = minetest.settings:get_bool("armor_"..name)
	end
	if setting ~= nil then
		armor.config[name] = setting
	end
end
for material, _ in pairs(armor.materials) do
	local key = "material_"..material
	if armor.config[key] == false then
		armor.materials[material] = nil
	end
end


-- Reinforced Leather
minetest.register_craftitem(":3d_armor:reinforcedleather", {
	description = "Reinforced Leather",
	inventory_image = "3d_armor_reinforcedleather.png",
	stack_max = 99,
})

minetest.register_craft({
	output = "3d_armor:reinforcedleather",
	recipe = {
		{"default:mithril_ingot",	"technic:brass_ingot",	""},
		{"darkage:chain", 					"mobs:minotaur_eye",		""},
		{"", 												"", 										""}
	}
})

if armor.materials.reinforcedleather then
	-- Register helmets :
	armor:register_armor(":3d_armor:helmet_reinforcedleather", {
			description = "Reinforced Leather Helmet (Hunter)",
			inventory_image = "3d_armor_inv_helmet_reinforcedleather.png",
			groups = {armor_head=1, armor_use=40, physics_speed=0.02, physics_gravity=-0.02},
			armor_groups = {fleshy=6},
			damage_groups = {cracky=2, snappy=1, choppy=1, level=2}
	})
	
	-- Register chestplates :
	armor:register_armor(":3d_armor:chestplate_reinforcedleather", {
		description = "Reinforced Leather Chestplate (Hunter)",
		inventory_image = "3d_armor_inv_chestplate_reinforcedleather.png",
		groups = {armor_torso = 1, armor_use = 40, physics_speed=0.08, physics_gravity=-0.08},
		armor_groups = {fleshy=11},
		damage_groups = {cracky=2, snappy=1, choppy=1, level=2}
	})

	-- Register leggings :
	armor:register_armor(":3d_armor:leggings_reinforcedleather", {
		description = "Reinforced Leather Leggings (Hunter)",
		inventory_image = "3d_armor_inv_leggings_reinforcedleather.png",
		groups = {armor_legs = 1, armor_use = 40, physics_speed=0.06, physics_gravity=-0.06},
		armor_groups = {fleshy=11},
		damage_groups = {cracky=2, snappy=1, choppy=1, level=2}
	})

	-- Register boots :
		armor:register_armor(":3d_armor:boots_reinforcedleather", {
		description = "Reinforced Leather Boots (Hunter)",
		inventory_image = "3d_armor_inv_boots_reinforcedleather.png",
		groups = {armor_feet = 1, armor_use = 40, physics_speed=0.02, physics_gravity=-0.02},
		armor_groups = {fleshy=6},
		damage_groups = {cracky=2, snappy=1, choppy=1, level=3}
	})
end


-- Hardened Leather
minetest.register_craftitem(":3d_armor:hardenedleather", {
	description = "Hardened Leather",
	inventory_image = "3d_armor_hardenedleather.png",
	stack_max = 99,
})

minetest.register_craft({
	output = "3d_armor:hardenedleather",
	recipe = {
		{"default:steel_ingot",		"mobs:leather", 	"default:bronze_ingot"},
		{"mobs:leather", 					"mobs:leather", 	"mobs:leather"				},
		{"default:bronze_ingot", 	"mobs:leather", 	"default:steel_ingot"	}
	}
})

if armor.materials.hardenedleather then
	-- Register helmets :
	armor:register_armor(":3d_armor:helmet_hardenedleather", {
		description = "Hardened Leather Helmet (Hunter)",
		inventory_image = "3d_armor_inv_helmet_hardenedleather.png",
		groups = {armor_head = 1, armor_use = 250, physics_speed=0.01, physics_gravity=-0.01},
		armor_groups = {fleshy=5},
		damage_groups = {cracky=2, snappy=3, choppy=2, crumbly=1, level=2}
	})

	-- Register chestplates :
	armor:register_armor(":3d_armor:chestplate_hardenedleather", {
		description = "Hardened Leather Chestplate (Hunter)",
		inventory_image = "3d_armor_inv_chestplate_hardenedleather.png",
		groups = {armor_torso = 1, armor_use = 250, physics_speed=0.04, physics_gravity=-0.04},
		armor_groups = {fleshy=8},
		damage_groups = {cracky=2, snappy=3, choppy=2, crumbly=1, level=2}
	})

	-- Register leggings :
	armor:register_armor(":3d_armor:leggings_hardenedleather", {
		description = "Hardened Leather Leggings (Hunter)",
		inventory_image = "3d_armor_inv_leggings_hardenedleather.png",
		groups = {armor_legs = 1, armor_use = 250, physics_speed=0.03, physics_gravity=-0.03},
		armor_groups = {fleshy=8},
		damage_groups = {cracky=2, snappy=3, choppy=2, crumbly=1, level=2}
	})

	-- Register boots :
		armor:register_armor(":3d_armor:boots_hardenedleather", {
		description = "Hardened Leather Boots (Hunter)",
		inventory_image = "3d_armor_inv_boots_hardenedleather.png",
		groups = {armor_feet = 1, armor_use = 250, physics_speed=0.01, physics_gravity=-0.01},
		armor_groups = {fleshy=5},
		damage_groups = {cracky=2, snappy=3, choppy=2, crumbly=1, level=2}
	})
end

-- Black Mithril
minetest.register_craftitem(":3d_armor:blackmithril_ingot", {
	description = "Black Mithril Ingot",
	inventory_image = "3d_armor_blackmithril_ingot.png",
	stack_max = 99,
	groups = {ingot = 1}
})

minetest.register_craft({
	output = "3d_armor:blackmithril_ingot",
	recipe = {
		{"default:mithril_ingot", "mobs:dungeon_master_blood", ""},
		{"mobs:dungeon_master_diamond", "default:obsidian", ""},
		{"", "", ""}
	}
})

if armor.materials.blackmithril then
	-- Register helmets :
	armor:register_armor(":3d_armor:helmet_blackmithril", {
		description = "Black Mithril Helmet (Warrior)",
		inventory_image = "3d_armor_inv_helmet_blackmithril.png",
		groups = {armor_head = 1, armor_heal = 15, armor_use = 40},
		armor_groups = {fleshy=16},
		damage_groups = {cracky=2, snappy=1, level=3}
	})

	-- Register chestplates :
	armor:register_armor(":3d_armor:chestplate_blackmithril", {
		description = "Black Mithril Chestplate (Warrior)",
		inventory_image = "3d_armor_inv_chestplate_blackmithril.png",
		groups = {armor_torso = 1, armor_heal = 15, armor_use = 40},
		armor_groups = {fleshy=22},
		damage_groups = {cracky=2, snappy=1, level=3}
	})

	-- Register leggings :
	armor:register_armor(":3d_armor:leggings_blackmithril", {
		description = "Black Mithril Leggings (Warrior)",
		inventory_image = "3d_armor_inv_leggings_blackmithril.png",
		groups = {armor_legs = 1, armor_heal = 15, armor_use = 40},
		armor_groups = {fleshy=22},
		damage_groups = {cracky=2, snappy=1, level=3}
	})

	-- Register boots :
		armor:register_armor(":3d_armor:boots_blackmithril", {
		description = "Black Mithril Boots (Warrior)",
		inventory_image = "3d_armor_inv_boots_blackmithril.png",
		groups = {armor_feet = 1, armor_heal = 15, armor_use = 40},
		armor_groups = {fleshy=16},
		damage_groups = {cracky=2, snappy=1, level=3}
	})	

		-- Register shield :
		armor:register_armor(":shields:shield_blackmithril", {
		description = "Black Mithril Shield (warrior)",
		inventory_image = "shields_inv_shield_black_mithril_warrior.png",
		groups = {armor_shield=15, armor_heal=0, armor_use=50},
		armor_groups = {fleshy=16},
		damage_groups = {cracky=2, snappy=1, level=3},
		reciprocate_damage = true,
})
end

for k, v in pairs(armor.materials) do
	if k == "blackmithril" then
		minetest.register_craft({
			output = "shields:shield_"..k,
			recipe = {
				{v, v, v},
				{v, v, v},
				{"", v, ""},
			},
		})
	end
	minetest.register_craft({
		output = "3d_armor:helmet_"..k,
		recipe = {
			{v, v, v},
			{v, "", v},
			{"", "", ""},
		},
	})
	minetest.register_craft({
		output = "3d_armor:chestplate_"..k,
		recipe = {
			{v, "", v},
			{v, v, v},
			{v, v, v},
		},
	})
	minetest.register_craft({
		output = "3d_armor:leggings_"..k,
		recipe = {
			{v, v, v},
			{v, "", v},
			{v, "", v},
		},
	})
	minetest.register_craft({
		output = "3d_armor:boots_"..k,
		recipe = {
			{v, "", v},
			{v, "", v},
		},
	})
end
