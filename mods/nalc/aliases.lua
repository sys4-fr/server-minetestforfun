-- Remove homedecor:cobweb_corner and make it as alias of mobs:cobweb
if minetest.get_modpath("mobs_monster") and minetest.get_modpath("homedecor") then
	minetest.register_alias_force("homedecor:cobweb_corner", "mobs:cobweb")
end

-- Add moretrees:acacia_sapling_ongen alias
if minetest.get_modpath("moretrees") then
	minetest.register_alias("moretrees:acacia_sapling_ongen", "default:acacia_sapling")
end
