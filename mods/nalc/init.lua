local modpath = minetest.get_modpath(minetest.get_current_modname())

-- Custom craftings
dofile(modpath.."/crafting.lua")

-- Custom craftitems
dofile(modpath.."/craftitems.lua")

-- Custom mapgen ore generation
dofile(modpath.."/mapgen.lua")

-- Custom nodes
dofile(modpath.."/nodes.lua")

-- Custom tools
dofile(modpath.."/tools.lua")

local mods = {"witchcraft", "cotton", "technic",
				  "beds", "boats", "bucket",
				  "nyancat", "moreores", "moreblocks",
				  "maptools"
}

for _,mod in ipairs(mods) do
	if minetest.get_modpath(mod) then
		dofile(modpath.."/"..mod..".lua")
	end
end

