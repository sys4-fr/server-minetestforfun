minetest.register_tool(
	"nalc:pick_gold",
	{
		description = "Golden Pickaxe",
		inventory_image = "default_tool_goldpick.png",
		tool_capabilities = {
			full_punch_interval = 1.2,
			max_drop_level = 3,
			groupcaps = {
				cracky = {times = {[1] = 2.80, [2] = 1.15, [3] = 0.65}, uses = 15, maxlevel = 3},
				crumbly = {times = {[1] = 2.0, [2] = 0.9, [3] = 0.36}, uses = 5, maxlevel = 2},
			},
			damage_groups = {fleshy = 4},
		},
	})

minetest.register_tool(
	"nalc:shovel_gold",
	{
		description = "Golden Shovel",
		inventory_image = "default_tool_goldshovel.png",
		wield_image = "default_tool_goldshovel.png^[transformR90",
		tool_capabilities = {
			full_punch_interval = 1.2,
			max_drop_level = 1,
			groupcaps = {
				crumbly = {times = {[1] = 1.40, [2] = 0.60, [3] = 0.35}, uses = 15, maxlevel = 3},
			},
			damage_groups = {fleshy = 4},
		},
	})

minetest.register_tool(
	"nalc:axe_gold",
	{
		description = "Golden Axe",
		inventory_image = "default_tool_goldaxe.png",
		tool_capabilities = {
			full_punch_interval = 1.2,
			max_drop_level = 1,
			groupcaps = {
				choppy = {times = {[1] = 3.08, [2] = 1.27, [3] = 0.72}, uses = 15, maxlevel = 3},
				snappy = {times = {[3] = 0.125}, uses = 0, maxlevel = 1},
			},
			damage_groups = {fleshy = 4},
		},
	})

minetest.register_tool(
	"nalc:sword_gold",
	{
		description = "Golden Sword",
		inventory_image = "default_tool_goldsword.png",
		tool_capabilities = {
			full_punch_interval = 0.8,
			max_drop_level = 1,
			groupcaps = {
				snappy = {times = {[1] = 1.9, [2] = 0.85, [3] = 0.125}, uses = 10, maxlevel = 3},
			},
			damage_groups = {fleshy = 5},
		}
	})

minetest.register_tool(
	"nalc:dungeon_master_s_blood_sword",
	{  --Warrior Only
		description = "Dungeon Master's Blood Sword (Warrior)",
		inventory_image = "default_tool_dungeon_master_s_blood_sword.png",
		tool_capabilities = {
			full_punch_interval = 0.5,
			max_drop_level = 1,
			groupcaps = {
				snappy = {times = {[1] = 1.9, [2] = 0.85, [3] = 0.125}, uses = 250, maxlevel = 3},
			},
			damage_groups = {fleshy = 10},
		}
	})

-- Toolranks
if minetest.get_modpath("toolranks") then

	minetest.override_item(
		"nalc:pick_gold",
		{
			original_description = "Golden Pickaxe",
			description = toolranks.create_description("Golden Pickaxe", 0, 1),
			after_use = toolranks.new_afteruse
		})
	minetest.override_item(
		"nalc:axe_gold",
		{
			original_description = "Golden Axe",
			description = toolranks.create_description("Golden Axe", 0, 1),
			after_use = toolranks.new_afteruse
		})
	minetest.override_item(
		"nalc:shovel_gold",
		{
			original_description = "Golden Shovel",
			description = toolranks.create_description("Golden Shovel", 0, 1),
			after_use = toolranks.new_afteruse
		})
end
