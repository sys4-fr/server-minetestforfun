--
-- Ores
--

minetest.register_node(
	"nalc:desert_stone_with_coal",
	{
		description = "Coal Ore",
		tiles = {"default_desert_stone.png^default_mineral_coal.png"},
		is_ground_content = true,
		groups = {crumbly = 1, cracky = 3},
		drop = {
			items = {
				{items = {"default:coal_lump"}},
			},
		},
		sounds = default.node_sound_stone_defaults(),
	})
minetest.register_alias("default:desert_stone_with_coal", "nalc:desert_stone_with_coal")

minetest.register_node(
	"nalc:desert_stone_with_iron",
	{
		description = "Iron Ore",
		tiles = {"default_desert_stone.png^default_mineral_iron.png"},
		is_ground_content = true,
		groups = {cracky = 2},
		drop = {
			items = {
				{items = {"default:iron_lump"}},
			},
		},
		sounds = default.node_sound_stone_defaults(),
	})
minetest.register_alias("default:desert_stone_with_iron", "nalc:desert_stone_with_iron")

minetest.register_node(
	"nalc:desert_stone_with_copper",
	{
		description = "Copper Ore",
		tiles = {"default_desert_stone.png^default_mineral_copper.png"},
		is_ground_content = true,
		groups = {crumbly = 1, cracky = 3},
		drop = {
			items = {
				{items = {"default:copper_lump"}},
			},
		},
		sounds = default.node_sound_stone_defaults(),
	})
minetest.register_alias("default:desert_stone_with_copper", "nalc:desert_stone_with_copper")

minetest.register_node(
	"nalc:desert_stone_with_tin",
	{
		description = "Tin Ore",
		tiles = {"default_desert_stone.png^default_mineral_tin.png"},
		is_ground_content = true,
		groups = {crumbly = 1, cracky = 3},
		drop = {
			items = {
				{items = {"default:tin_lump"}},
			},
		},
		sounds = default.node_sound_stone_defaults(),
	})
minetest.register_alias("default:desert_stone_with_tin", "nalc:desert_stone_with_tin")

local function die_later(digger)
	digger:set_hp(0)
end

minetest.register_node(
	"nalc:meze",
	{
		description = "Meze Block",
		tiles = {"default_meze_block.png"},
		is_ground_content = true,
		drop = "",
		groups = {cracky = 1, level = 2, fall_damage_add_percent = -75},
		sounds = default.node_sound_wood_defaults(), -- Intended.
		
		on_dig = function(pos, node, digger)
			if digger and minetest.setting_getbool("enable_damage") and not minetest.setting_getbool("creative_mode") then
				minetest.after(3, die_later, digger)
				minetest.chat_send_player(digger:get_player_name(), "You feel like you did a mistake.")
				minetest.node_dig(pos, node, digger)
			elseif digger then
				minetest.node_dig(pos, node, digger)
			end
		end,
	})
minetest.register_alias("default:meze_block", "nalc:meze")
minetest.register_alias("default:meze", "nalc:meze")

--
-- Plantlife (non-cubic)
--

minetest.override_item(
	"default:cactus",
	{
		after_dig_node = function(pos, node, metadata, digger)
			default.dig_up(pos, node, digger)
		end
	})

minetest.register_node(
	"nalc:cactus_spiky",
	{
		description = "Spiky Cactus",
		tiles = {"default_cactus_top.png", "default_cactus_top.png",
					"default_cactus_spiky.png"},
		paramtype2 = "facedir",
		groups = {snappy = 1, choppy = 3, flammable = 2},
		drop = {
			items = {
				{items = {"nalc:cactus_spiky"}},
			},
		},
		sounds = default.node_sound_wood_defaults(),
		on_place = minetest.rotate_node,
		
		after_dig_node = function(pos, node, metadata, digger)
			default.dig_up(pos, node, digger)
		end,
	})
minetest.register_alias("default:cactus_spiky", "nalc:cactus_spiky")

minetest.register_node(
	"nalc:acid_source",
	{
		description = "Acid Source",
		inventory_image = minetest.inventorycube("default_acid.png"),
		drawtype = "liquid",
		tiles = {
			{name = "default_acid_source_animated.png", animation={type = "vertical_frames", aspect_w = 16, aspect_h = 16, length = 1.5}}
		},
		special_tiles = {
			-- New-style acid source material (mostly unused)
			{
				name = "default_acid_source_animated.png",
				animation = {type = "vertical_frames", aspect_w= 16, aspect_h = 16, length = 1.5},
				backface_culling = false,
			}
		},
		alpha = 160,
		paramtype = "light",
		walkable = false,
		pointable = false,
		diggable = false,
		buildable_to = true,
		drop = "",
		drowning = 2,
		liquidtype = "source",
		liquid_alternative_flowing = "nalc:acid_flowing",
		liquid_alternative_source = "nalc:acid_source",
		liquid_viscosity = 1,
		liquid_range = 4,
		damage_per_second = 3,
		post_effect_color = {a = 120, r = 50, g = 90, b = 30},
		groups = {water = 3, acid = 3, liquid = 3, puts_out_fire = 1},
	})
minetest.register_alias("default:acid_source", "nalc:acid_source")

minetest.register_node(
	"nalc:acid_flowing",
	{
		description = "Flowing Acid",
		inventory_image = minetest.inventorycube("default_acid.png"),
		drawtype = "flowingliquid",
		tiles = {"default_acid.png"},
		special_tiles = {
			{
				image = "default_acid_flowing_animated.png",
				backface_culling=false,
				animation={type = "vertical_frames", aspect_w= 16, aspect_h = 16, length = 0.6}
			},
			{
				image = "default_acid_flowing_animated.png",
				backface_culling=true,
				animation={type = "vertical_frames", aspect_w= 16, aspect_h = 16, length = 0.6}
			},
		},
		alpha = 160,
		paramtype = "light",
		paramtype2 = "flowingliquid",
		walkable = false,
		pointable = false,
		diggable = false,
		buildable_to = true,
		drop = "",
		drowning = 2,
		liquidtype = "flowing",
		liquid_alternative_flowing = "nalc:acid_flowing",
		liquid_alternative_source = "nalc:acid_source",
		liquid_viscosity = 1,
		liquid_range = 4,
		damage_per_second = 3,
		post_effect_color = {a = 120, r = 50, g = 90, b = 30},
		groups = {water = 3, acid = 3, liquid = 3, puts_out_fire = 1, not_in_creative_inventory = 1},
	})
minetest.register_alias("default:acid_flowing", "nalc:acid_flowing")

minetest.register_node(
	"nalc:sand_source",
	{
		description = "Sand Source",
		inventory_image = minetest.inventorycube("default_sand.png"),
		drawtype = "liquid",
		tiles = {"default_sand.png"},
		alpha = 255,
		paramtype = "light",
		walkable = false,
		pointable = false,
		diggable = false,
		buildable_to = true,
		drop = "",
		drowning = 4,
		liquidtype = "source",
		liquid_alternative_flowing = "nalc:sand_flowing",
		liquid_alternative_source = "nalc:sand_source",
		liquid_viscosity = 20,
		liquid_renewable = false,
		post_effect_color = {a = 250, r = 0, g = 0, b = 0},
		groups = {liquid = 3},
	})
minetest.register_alias("default:sand_source", "nalc:sand_source")

minetest.register_node(
	"nalc:sand_flowing",
	{
		description = "Flowing Sand",
		inventory_image = minetest.inventorycube("default_sand.png"),
		drawtype = "flowingliquid",
		tiles = {"default_sand.png"},
		special_tiles = {
			{
				image = "default_sand_flowing_animated.png",
				backface_culling=false,
				animation={type = "vertical_frames", aspect_w= 16, aspect_h = 16, length = 0.6}
			},
			{
				image = "default_sand_flowing_animated.png",
				backface_culling=true,
				animation={type = "vertical_frames", aspect_w= 16, aspect_h = 16, length = 0.6}
			},
		},
		alpha = 255,
		paramtype = "light",
		paramtype2 = "flowingliquid",
		walkable = false,
		pointable = false,
		diggable = false,
		buildable_to = true,
		drop = "",
		drowning = 4,
		liquidtype = "flowing",
		liquid_alternative_flowing = "nalc:sand_flowing",
		liquid_alternative_source = "nalc:sand_source",
		liquid_viscosity = 20,
		post_effect_color = {a = 250, r = 0, g = 0, b = 0},
		groups = {liquid = 3, not_in_creative_inventory = 1},
	})
minetest.register_alias("default:sand_flowing", "nalc:sand_flowing")

--
-- Tools / "Advanced" crafting / Non-"natural"
--

minetest.register_node(
	"nalc:ladder_obsidian",
	{
		description = "Obsidian Ladder",
		drawtype = "signlike",
		tiles = {"default_ladder_obsidian.png"},
		inventory_image = "default_ladder_obsidian.png",
		wield_image = "default_ladder_obsidian.png",
		paramtype = "light",
		paramtype2 = "wallmounted",
		sunlight_propagates = true,
		walkable = false,
		climbable = true,
		is_ground_content = false,
		selection_box = {
			type = "wallmounted",
			--wall_top = = <default>
			--wall_bottom = = <default>
			--wall_side = = <default>
		},
		groups = {cracky = 2},
		sounds = default.node_sound_stone_defaults(),
	})
minetest.register_alias("default:ladder_obsidian", "nalc:ladder_obsidian")

default.register_fence(
	"nalc:fence_cobble",
	{
		description = "Cobble Fence",
		texture = "default_fence_cobble.png",
		material = "default:cobble",
		groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
		sounds = default.node_sound_wood_defaults()
	})

default.register_fence(
	"nalc:fence_desert_cobble",
	{
		description = "Desert Cobble Fence",
		texture = "default_fence_desert_cobble.png",
		material = "default:desert_cobble",
		groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
		sounds = default.node_sound_wood_defaults()
	})

default.register_fence(
	"nalc:fence_steelblock",
	{
		description = "Steel Block Fence",
		texture = "default_fence_steelblock.png",
		material = "default:steelblock",
		groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
		sounds = default.node_sound_wood_defaults()
	})

default.register_fence(
	"nalc:fence_brick",
	{
		description = "Brick Fence",
		texture = "default_fence_brick.png",
		material = "default:brick",
		groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
		sounds = default.node_sound_wood_defaults()
	})
minetest.register_alias("default:fence_cobble", "nalc:fence_cobble")
minetest.register_alias("default:fence_desert_cobble", "nalc:fence_desert_cobble")
minetest.register_alias("default:fence_steelblock", "nalc:fence_steelblock")
minetest.register_alias("default:fence_brick", "nalc:fence_brick")

-- Override items
minetest.override_item(
	"default:clay",
	{
		stack_max = 200
	})
