if minetest.get_modpath("diet") then

	local function overwrite(name, hunger_change, replace_with_item, poisen, heal)
		local tab = minetest.registered_items[name]
		if not tab then
			return
		end
		tab.on_use = diet.item_eat(hunger_change, replace_with_item, poisen, heal)
	end

	if minetest.get_modpath("farming") and farming.mod == "redo" then
		-- Strawberries fix
		overwrite("ethereal:strawberry", 1)
		overwrite("farming_plus:strawberry_item", 1)

		-- Banana
		overwrite("ethereal:banana", 2)
		overwrite("ethereal:orange", 4)

		-- Support with farming_redo >= 1.29
		if tonumber(farming.version) >= 1.29 then
			overwrite("farming:chili_pepper", 2)
			overwrite("farming:chili_bowl", 8)
			overwrite("farming:porridge", 6)
		end
	end

	if minetest.get_modpath("mtfoods") then
		overwrite("mtfoods:boston_cream", 5)
	end
end
