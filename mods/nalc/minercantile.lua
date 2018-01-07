if minetest.get_modpath("minercantile") then
	-- Register crafts for minercantile items

	-- Barter shop
	minetest.register_craft(
		{ output = "minercantile:shop",
		  recipe = {
			  {"default:steel_ingot","default:steel_ingot","default:steel_ingot"},
			  {"default:skeleton_key","maptools:silver_coin","default:steel_ingot"},
			  {"default:steel_ingot","default:mese_crystal","default:steel_ingot"}
		  }
		})

	-- Bancomatic
	minetest.register_craft(
		{ output = "minercantile:bancomatic_bottom",
		  recipe = {
			  {"default:steel_ingot","default:mese_crystal","default:steel_ingot"},
			  {"maptools:copper_coin","maptools:silver_coin","maptools:gold_coin"},
			  {"default:steel_ingot","default:steel_ingot","default:steel_ingot"}
		  }
		})

	-- Fix bancomatic duplication item bug
	local on_place = minetest.registered_items["minercantile:bancomatic_bottom"].on_place
	minetest.override_item(
		"minercantile:bancomatic_bottom",
		{
			on_place = function(itemstack, placer, pointed_thing)
				if not on_place(itemstack, placer, pointed_thing) then
					
					itemstack:take_item()
					return itemstack
				end
			end
		})
end


