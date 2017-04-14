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
		local pot_new =
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

		-- Override pots on_rightclick
		for _, row in ipairs(pot_new) do
			local color = row[1]
			local newcolor = row[2]
			local newcolor2 = row[4]
			local ingredient = row[3]
			local ingredient2 = row[5]
			local combine = row[6]
			local cresult = row[7]

			minetest.override_item(
				"witchcraft:pot_"..color,
				{
					on_rightclick = function(pos, node, clicker, item, _)
						local wield_item = clicker:get_wielded_item():get_name()
						if wield_item == "vessels:glass_bottle" and clicker:get_wielded_item():get_count() == 3 then
							item:replace("witchcraft:potion_"..color)
							minetest.env:add_item({x=pos.x, y=pos.y+1.5, z=pos.z}, "witchcraft:potion_"..color)
							minetest.env:add_item({x=pos.x, y=pos.y+1.5, z=pos.z}, "witchcraft:potion_"..color)
							minetest.set_node(pos, {name="witchcraft:pot", param2=node.param2})
						elseif wield_item == "vessels:glass_bottle" and clicker:get_wielded_item():get_count() ~= 3 then
							item:replace("witchcraft:potion_"..color)
							minetest.set_node(pos, {name="witchcraft:pot", param2=node.param2})
						else
							if wield_item == ingredient then
								minetest.set_node(pos, {name="witchcraft:pot_"..newcolor, param2=node.param2})
								item:take_item()
							elseif wield_item == ingredient2 then
								minetest.set_node(pos, {name="witchcraft:pot_"..newcolor2, param2=node.param2})
								item:take_item()
							elseif wield_item == "bucket:bucket_water" then
								minetest.set_node(pos, {name="witchcraft:pot_blue", param2=node.param2})
								item:replace("bucket:bucket_empty")
							elseif wield_item == "witchcraft:potion_"..combine then
								minetest.set_node(pos, {name="witchcraft:pot_"..cresult, param2=node.param2})
								item:replace("vessels:glass_bottle")
							end
						end
					end
				})
		end

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

-- Make compatible cotton mod
if minetest.get_modpath("cotton") then
	-- clear existing craft recipes for white wool and cotton
	minetest.clear_craft(
		{
			recipe = {
				{"farming:cotton", "farming:cotton"},
				{"farming:cotton", "farming:cotton"},
			}
		})

	-- register wool:white craft recipe
	minetest.register_craft(
		{
			output = "wool:white",
			recipe = {
				{"farming:cotton", "farming:cotton"},
				{"farming:cotton", "farming:cotton"},
			}
		})

	-- register cotton:white craft recipe
	minetest.register_craft(
		{
			output = "cotton:white 4",
			recipe = {
				{"wool:white", "wool:white"},
				{"wool:white", "wool:white"},
			}
		})
end

-- Technic

if minetest.get_modpath("technic") then
	-- make silver, tin, mithril to be grinded
	local recipes = {
		-- Dusts
		{"default:tin_lump", "technic:tin_dust 2"},
		{"default:silver_lump", "technic:silver_dust 2"},
		{"default:mithril_lump", "technic:mithril_dust 2"},
	}

	for _, data in pairs(recipes) do
		technic.register_grinder_recipe({input = {data[1]}, output = data[2]})
	end

	-- dusts
	local function register_dust(name, ingot)
		local lname = string.lower(name)
		lname = string.gsub(lname, ' ', '_')
		if ingot then
			minetest.register_craft(
				{
					type = "cooking",
					recipe = "technic:"..lname.."_dust",
					output = ingot,
				})
			technic.register_grinder_recipe({ input = {ingot}, output = "technic:"..lname.."_dust 1" })
		end
	end

	register_dust("Mithril", "default:mithril_ingot")
	register_dust("Silver", "default:silver_ingot")
	register_dust("Tin", "default:tin_ingot")

	-- Add superquarry machine
	dofile(minetest.get_modpath(minetest.get_current_modname()).."/technic/superquarry.lua")
end
