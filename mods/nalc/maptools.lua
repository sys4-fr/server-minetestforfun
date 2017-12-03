-- Nodes
minetest.register_node(
	"nalc:stone_with_coin",
	{ description = "Stone with Coin",
	  tiles = {"default_stone.png^maptools_gold_coin.png"},
	  is_ground_content = true,
	  groups = {cracky = 3},
	  drop = {
		  items = {
			  {items = {"maptools:gold_coin"}},
		  },
	  },
	  sounds = default.node_sound_stone_defaults(),
	})
minetest.register_alias("default:stone_with_coin", "nalc:stone_with_coins")

-- Ores
minetest.register_ore(
	{ ore_type       = "scatter",
	  ore            = "nalc:stone_with_coin",
	  wherein        = "default:stone",
	  clust_scarcity = 26 * 26 * 26,
	  clust_num_ores = 1,
	  clust_size     = 1,
	  y_min          = -30000,
	  y_max          = 0,
	  flags          = "absheight",
	})

-- Super Apples
minetest.register_ore({
								 ore_type       = "scatter",
								 ore            = "maptools:superapple",
								 wherein        = "default:apple",
								 clust_scarcity = 6 * 6 * 6,
								 clust_num_ores = 5,
								 clust_size     = 2,
								 y_min          = 0,
								 y_max          = 64,
							 })

minetest.register_ore({
								 ore_type       = "scatter",
								 ore            = "maptools:superapple",
								 wherein        = "default:jungleleaves",
								 clust_scarcity = 16 * 16 * 16,
								 clust_num_ores = 5,
								 clust_size     = 2,
								 y_min          = 0,
								 y_max          = 64,
							 })

-- Override items
minetest.override_item(
	"default:desert_stone",
	{
		drop = {
			items = {
				{items = {"default:desert_cobble"}},
				{items = {"maptools:copper_coin"}, rarity = 20}
			}
		}
	})

minetest.override_item(
	"default:dirt",
	{
		drop = {
			items = {
				{items = {"default:dirt"}},
				{items = {"maptools:copper_coin"}, rarity = 32}
			}
		}
	})

minetest.override_item(
	"default:stone_with_coal",
	{
		drop = {
			items = {
				{items = {"default:coal_lump"}},
				{items = {"maptools:copper_coin"}}
			}
		}
	})
minetest.override_item(
	"nalc:desert_stone_with_coal",
	{
		drop = {
			items = {
				{items = {"default:coal_lump"}},
				{items = {"maptools:copper_coin"}}
			}
		}
	})

minetest.override_item(
	"default:stone_with_iron",
	{
		drop = {
			items = {
				{items = {"default:iron_lump"}},
				{items = {"maptools:copper_coin 3"}}
			}
		}
	})
minetest.override_item(
	"nalc:desert_stone_with_iron",
	{
		drop = {
			items = {
				{items = {"default:iron_lump"}},
				{items = {"maptools:copper_coin 3"}}
			}
		}
	})

minetest.override_item(
	"default:stone_with_copper",
	{
		drop = {
			items = {
				{items = {"default:copper_lump"}},
				{items = {"maptools:copper_coin 3"}}
			}
		}
	})
minetest.override_item(
	"nalc:desert_stone_with_copper",
	{
		drop = {
			items = {
				{items = {"default:copper_lump"}},
				{items = {"maptools:copper_coin 3"}}
			}
		}
	})

minetest.override_item(
	"default:stone_with_tin",
	{
		drop = {
			items = {
				{items = {"default:tin_lump"}},
				{items = {"maptools:copper_coin 3"}}
			}
		}
	})
minetest.override_item(
	"nalc:desert_stone_with_tin",
	{
		drop = {
			items = {
				{items = {"default:tin_lump"}},
				{items = {"maptools:copper_coin 3"}}
			}
		}
	})

minetest.override_item(
	"moreores:mineral_silver",
	{
		drop = {
			items = {
				{items = {"moreores:silver_lump"}},
				{items = {"maptools:copper_coin 3"}}
			}
		}
	})
minetest.override_item(
	"nalc:desert_stone_with_silver",
	{
		drop = {
			items = {
				{items = {"moreores:silver_lump"}},
				{items = {"maptools:copper_coin 3"}}
			}
		}
	})

minetest.override_item(
	"default:stone_with_mese",
	{
		drop = {
			items = {
				{items = {"default:mese_crystal"}},
				{items = {"maptools:silver_coin 2", rarity = 75}},
			}
		}
	})

minetest.override_item(
	"default:stone_with_gold",
	{
		drop = {
			items = {
				{items = {"default:gold_lump"}},
				{items = {"maptools:silver_coin", rarity = 80}},
			}
		}
	})

minetest.override_item(
	"moreores:mineral_mithril",
	{
		drop = {
			items = {
				{items = {"moreores:mithril_lump"}},
				{items = {"maptools:silver_coin 3"}},
			}
		}
	})

minetest.override_item(
	"default:stone_with_diamond",
	{
		drop = {
			items = {
				{items = {"default:diamond"}},
				{items = {"maptools:silver_coin"}},
			}
		}
	})
