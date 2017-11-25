minetest.register_craft(
	{ output = 'nalc:pick_gold',
	  recipe = {
		  {'default:gold_ingot', 'default:gold_ingot', 'default:gold_ingot'},
		  {'', 'group:stick', ''},
		  {'', 'group:stick', ''},
	  }
	})
minetest.register_alias("default:pick_gold", "nalc:pick_gold")

minetest.register_craft(
	{ output = 'nalc:shovel_gold',
	  recipe = {
		  {'default:gold_ingot'},
		  {'group:stick'},
		  {'group:stick'},
	  }
	})
minetest.register_alias("default:shovel_gold", "nalc:shovel_gold")

minetest.register_craft(
	{ output = "nalc:axe_gold",
	  recipe = {
		  {"default:gold_ingot", "default:gold_ingot"},
		  {"default:gold_ingot", "group:stick"},
		  {"", "group:stick"},
	  }
	})
minetest.register_alias("default:axe_gold", "nalc:axe_gold")

minetest.register_craft(
	{ output = "nalc:sword_gold",
	  recipe = {
		  {"default:gold_ingot"},
		  {"default:gold_ingot"},
		  {"group:stick"},
	  }
	})
minetest.register_alias("default:sword_gold", "nalc:sword_gold")

minetest.register_craft(
	{  -- Ultimate Warrior weapon
		output = 'nalc:dungeon_master_s_blood_sword',
		recipe = {
			{"mobs_monster:dungeon_master_blood", "nether:white", "mobs_monster:dungeon_master_blood"},
			{"mobs_monster:dungeon_master_blood", "mobs_monster:dungeon_master_diamond", "mobs_monster:dungeon_master_blood"},
			{"moreores:mithril_block", "zombie:zombie_tibia", "moreores:mithril_block"},
		}
	})
minetest.register_alias("default:dungeon_master_s_blood_sword", "nalc:dungeon_master_s_blood_sword")

minetest.register_craft(
	{ output = "default:cactus 2",
	  recipe = {
		  {"nalc:cactus_spiky", "nalc:cactus_spiky"},
	  },
	})

minetest.register_craft(
	{ output = "nalc:cactus_spiky 2",
	  recipe = {
		  {"default:cactus", "default:cactus"},
	  },
	})
minetest.register_alias("default:cactus_spiky", "nalc:cactus_spiky")

minetest.register_craft(
	{ output = "nalc:ladder_obsidian 4",
	  recipe = {
		  {"default:obsidianbrick", "", "default:obsidianbrick"},
		  {"default:obsidianbrick", "default:obsidianbrick", "default:obsidianbrick"},
		  {"default:obsidianbrick", "", "default:obsidianbrick"}
	  }
	})
minetest.register_alias("default:ladder_obsidian", "nalc:ladder_obsidian")

