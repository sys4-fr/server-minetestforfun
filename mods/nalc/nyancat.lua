minetest.register_craft({
	type = "fuel",
	recipe = "nyancat:nyancat",
	burntime = 7200,
})

minetest.register_craft({
	type = "fuel",
	recipe = "nyancat:nyancat_rainbow",
	burntime = 1200,
})

minetest.register_craft(
	{ output = 'nalc:pick_nyan',
	  recipe = {
		  {'nyancat:nyancat', 'nyancat:nyancat', 'nyancat:nyancat'},
		  {'', 'group:stick', ''},
		  {'', 'group:stick', ''},
	  }
	})
minetest.register_alias("default:pick_nyan", "nalc:pick_nyan")

minetest.register_craft(
	{
		output = "nalc:shovel_nyan",
		recipe = {
			{"nyancat:nyancat"},
			{"group:stick"},
			{"group:stick"},
		}
	})
minetest.register_alias("default:shovel_nyan", "nalc:shovel_nyan")

minetest.register_craft(
	{
		output = "nalc:axe_nyan",
		recipe = {
			{"nyancat:nyancat", "nyancat:nyancat"},
			{"nyancat:nyancat", "group:stick"},
			{"", "group:stick"},
		}
	})
minetest.register_alias("default:axe_nyan", "nalc:axe_nyan")

minetest.register_craft(
	{
		output = "nalc:sword_nyan",
		recipe = {
			{"nyancat:nyancat"},
			{"nyancat:nyancat"},
			{"group:stick"},
		}
	})
minetest.register_alias("default:sword_nyan", "nalc:sword_nyan")

--
-- Register Tools
--

minetest.register_tool(
	"nalc:pick_nyan",
	{
		description = "Nyan Pickaxe",
		inventory_image = "default_tool_nyanpick.png",
		tool_capabilities = {
			full_punch_interval = 0.9,
			max_drop_level = 3,
			groupcaps = {
				cracky = {times = {[1] = 2.60, [2] = 1.10, [3] = 0.60}, uses = 60, maxlevel = 3},
				crumbly = {times = {[1] = 2.0, [2] = 0.9, [3] = 0.36}, uses = 75, maxlevel = 2},
			},
			damage_groups = {fleshy = 4},
		},
	})

minetest.register_tool(
	"nalc:shovel_nyan",
	{
		description = "Nyan Shovel",
		inventory_image = "default_tool_nyanshovel.png",
		wield_image = "default_tool_nyanshovel.png^[transformR90",
		tool_capabilities = {
			full_punch_interval = 1.2,
			max_drop_level = 1,
			groupcaps = {
				crumbly = {times = {[1] = 1.30, [2] = 0.55, [3] = 0.30}, uses = 60, maxlevel = 3},
			},
			damage_groups = {fleshy = 4},
		},
	})

minetest.register_tool(
	"nalc:axe_nyan",
	{
		description = "Nyan Axe",
		inventory_image = "default_tool_nyanaxe.png",
		tool_capabilities = {
			full_punch_interval = 1.2,
			max_drop_level = 1,
			groupcaps = {
				choppy = {times = {[1] = 2.86, [2] = 1.21, [3] = 0.66}, uses = 60, maxlevel = 3},
				snappy = {times = {[3] = 0.125}, uses = 0, maxlevel = 1},
			},
			damage_groups = {fleshy = 4},
		},
	})

minetest.register_tool(
	"nalc:sword_nyan",
	{
		description = "Nyan Sword",
		inventory_image = "default_tool_nyansword.png",
		tool_capabilities = {
			full_punch_interval = 0.7,
			max_drop_level = 1,
			groupcaps = {
				snappy = {times = {[1] = 1.9, [2] = 0.85, [3] = 0.125}, uses = 40, maxlevel = 3},
			},
			damage_groups = {fleshy = 6},
		}
	})

minetest.register_alias("default:pick_nyan", "nalc:pick_nyan")
minetest.register_alias("default:axe_nyan", "nalc:axe_nyan")
minetest.register_alias("default:shovel_nyan", "nalc:shovel_nyan")
minetest.register_alias("default:sword_nyan", "nalc:sword_nyan")
