-- mapgen
minetest.register_ore(
	{
		ore_type       = "scatter",
		ore            = "nalc:desert_stone_with_silver",
		wherein       = "default:desert_stone",
		clust_scarcity = 11 * 11 * 11,
		clust_num_ores = 4,
		clust_size     = 11,
		y_min       = -113,
		y_max          = -12,
	})

-- nodes
minetest.register_node(
	"nalc:desert_stone_with_silver",
	{
		description = "Silver Ore",
		tiles = {"default_desert_stone.png^default_mineral_silver.png"},
		is_ground_content = true,
		groups = {crumbly = 1, cracky = 3},
		drop = {
			items = {
				{items = {"moreores:silver_lump"}},
			},
		},
		sounds = default.node_sound_stone_defaults(),
	})

-- Overrides items
minetest.clear_craft({output = "moreores:copper_rail"})
minetest.register_craft(
	{
		output = "moreores:copper_rail 24",
		recipe = {
			{"default:copper_ingot", "group:wood", "default:copper_ingot"},
			{"default:copper_ingot", "", "default:copper_ingot"},
			{"default:copper_ingot", "group:wood", "default:copper_ingot"}
		}
	})


-- Aliases
--- Silver
minetest.register_alias("default:pick_silver", "moreores:pick_silver")
minetest.register_alias("default:axe_silver", "moreores:axe_silver")
minetest.register_alias("default:shovel_silver", "moreores:shovel_silver")
minetest.register_alias("default:sword_silver", "moreores:sword_silver")

minetest.register_alias("default:desert_stone_with_silver", "nalc:desert_stone_with_silver")
minetest.register_alias("default:stone_with_silver", "moreores:mineral_silver")
minetest.register_alias("default:silver_lump", "moreores:silver_lump")
minetest.register_alias("default:silver_ingot", "moreores:silver_ingot")
minetest.register_alias("default:silverblock", "moreores:silver_block")

--- Mythril
minetest.register_alias("default:pick_mithril", "moreores:pick_mithril")
minetest.register_alias("default:axe_mithril", "moreores:axe_mithril")
minetest.register_alias("default:shovel_mithril", "moreores:shovel_mithril")
minetest.register_alias("default:sword_mithril", "moreores:sword_mithril")

minetest.register_alias("default:stone_with_mithril", "moreores:mineral_mithril")
minetest.register_alias("default:mithril_lump", "moreores:mithril_lump")
minetest.register_alias("default:mithril_ingot", "moreores:mithril_ingot")
minetest.register_alias("default:mithrilblock", "moreores:mithril_block")
