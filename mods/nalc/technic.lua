-- make silver, tin, mithril to be grinded
--[[local recipes = {
	-- Dusts
	{"default:tin_lump", "technic:tin_dust 2"},
	{"moreores:silver_lump", "technic:silver_dust 2"},
	{"moreores:mithril_lump", "technic:mithril_dust 2"},
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
--]]
-- Add superquarry machine
dofile(minetest.get_modpath(minetest.get_current_modname()).."/technic/superquarry.lua")
