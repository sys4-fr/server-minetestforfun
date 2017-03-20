-- Change some craft recipe of Witchcraft
if minetest.get_modpath("witchcraft") then

	-- clear crafts with this particular recipe
	minetest.clear_craft(
		{
			recipe = { {"default:sand"} }
		})

	-- register default:desert_sand (by MFF)
	minetest.register_craft(
		{
			output = "default:desert_sand",
			recipe = {
				{"default:sand"},
			}
		})

	-- register witchcraft:tooth (by NALC)
	minetest.register_craft(
		{
			output = "witchcraft:tooth",
			recipe = {
				{"default:sand", "", "default:sand"},
				{"", "default:sand", ""},
			}
		})

	-- Register craft recipe of bones:bones with bonemeal:bone
	if minetest.get_modpath("bones")
		and minetest.get_modpath("bonemeal") and bonemeal
	then
		minetest.register_craft(
			{
				output = "bones:bones",
				recipe = {
					{"bonemeal:bone", "bonemeal:bone", "bonemeal:bone"},
					{"bonemeal:bone", "bonemeal:bone", "bonemeal:bone"},
					{"bonemeal:bone", "bonemeal:bone", "bonemeal:bone"},
				}
			})
	end

	-- Override craft recipe of witchcraft:shelf
	if minetest.get_modpath("vessels") then
		minetest.clear_craft(
			{
				recipe = {
					{"group:wood", "group:wood", "group:wood"},
					{"group:potion", "group:potion", "group:potion"},
					{"group:wood", "group:wood", "group:wood"},
				}
			})

		minetest.register_craft(
			{
				output = "witchcraft:shelf",
				recipe = {
					{"", "group:potion", ""},
					{"group:potion", "vessels:shelf", "group:potion"},
				}
			})

		-- Rewrite potion table which is buggy
		witchcraft.pot_new =
			{
				{"blue", "blue2", "default:leaves", "brown", "default:dirt", "red", "purple"}, -- replace waterlily by leaves (flowers_plus incompatibility i think...)
				{"blue2", "green", "default:papyrus", "", "", "gred", "magenta"},
				{"green", "green2", "default:sapling", "", "", "yellow", "yllwgrn"},
				{"green2", "yellow", "default:mese_crystal_fragment", "", "", "blue", "cyan"},
				{"yellow", "ggreen", "flowers:mushroom_brown", "", "", "green", "yllwgrn"},
				{"ggreen", "cyan", "witchcraft:slime_bottle", "", "", "gcyan", "aqua"},
				{"cyan", "gcyan", "witchcraft:bottle_medicine", "", "", "blue", "blue2"},
				{"gcyan", "orange", "default:torch", "", "", "ggreen", "aqua"},
				{"orange", "yllwgrn", "tnt:gunpowder", "", "", "red", "redbrown"},
				{"yllwgrn", "gold", "default:steel_ingot", "", "", "green", "green2"},
				{"gold", "aqua", "default:diamond", "", "", "", ""},
				{"aqua", "", "", "", "", "", ""},
				{"brown", "redbrown", "flowers:mushroom_red", "", "", "red", "redbrown"},
				{"redbrown", "gred", "default:apple", "", "", "", ""},
				{"gred", "red", "witchcraft:herb_bottle", "", "", "blue2", "magenta"}, -- replace witchcraft:herbs (inexistant) by herb_bottle
				{"red", "magenta", "witchcraft:tooth", "", "", "blue", "purple"},
				{"magenta", "gpurple", "witchcraft:slime_bottle", "", "", "cyan", "darkpurple"}, -- item name corrected (was inverted)
				{"gpurple", "purple", "witchcraft:bone_bottle", "", "", "yllwgrn", "green2"},
				{"purple", "darkpurple", "default:glass", "", "", "yellow", "green"},
				{"darkpurple", "silver", "default:steel_ingot", "", "", "", ""},
				{"silver", "grey", "witchcraft:bone", "", "", "", ""},
				{"grey", "aqua", "default:diamond", "", "", "", ""},
			}

		-- Override potion green effect if farming_redo is loaded (bad call in original mod)
		if farming.mod and farming.mod == "redo" then
			minetest.override_item(
				"witchcraft:potion_green",
				{
					description = "Melon Potion",
					on_use = function(item, user, pointed_thing)
						local player = user:get_player_name()
						if pointed_thing.type == "node" and
						minetest.get_node(pointed_thing.above).name == "air" then
							if not minetest.is_protected(pointed_thing.above, player) then
								minetest.set_node(pointed_thing.above, {name="farming:melon_8"})
							else
								minetest.chat_send_player(player, "This area is protected.")
							end
						end
						local playerpos = user:getpos();
						minetest.add_particlespawner(
							5, --amount
							0.1, --time
							{x=playerpos.x-1, y=playerpos.y+1, z=playerpos.z-1}, --minpos
							{x=playerpos.x+1, y=playerpos.y+1, z=playerpos.z+1}, --maxpos
							{x=-0, y=-0, z=-0}, --minvel
							{x=0, y=0, z=0}, --maxvel
							{x=-0.5,y=4,z=-0.5}, --minacc
							{x=0.5,y=4,z=0.5}, --maxacc
							0.5, --minexptime
							1, --maxexptime
							1, --minsize
							2, --maxsize
							false, --collisiondetection
							"witchcraft_effect.png" --texture
						)
						item:replace("vessels:glass_bottle")
						return item
					end
				})
		end
	end
end
