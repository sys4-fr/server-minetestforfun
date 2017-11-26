if minetest.get_modpath("doors") then
	-- Register MFF doors

	-- doors tin MFF
	doors.register("door_tin", {
							tiles = { "doors_door_tin.png" },
							description = "Tin Door",
							inventory_image = "doors_item_tin.png",
							groups = {snappy=1,bendy=2,cracky=1,melty=2,level=2,door=1},
							protected = true,
							sounds = default.node_sound_stone_defaults(),
							sunlight = false,
							recipe = {
								{"default:tin_ingot", "default:tin_ingot"},
								{"default:tin_ingot", "default:tin_ingot"},
								{"default:tin_ingot", "default:tin_ingot"}
							}
										})

	if minetest.get_modpath("darkage") then
		-- doors prison MFF
		doors.register("door_prison", {
								tiles = { "doors_door_prison.png" },
								description = "Prison Door",
								inventory_image = "doors_item_prison.png",
								groups = {snappy=1,bendy=2,cracky=1,melty=2,level=2,door=1},
								protected = true,
								sounds = default.node_sound_stone_defaults(),
								recipe = {
									{"darkage:iron_stick", "darkage:iron_stick"},
									{"darkage:iron_stick", "darkage:iron_stick"},
									{"darkage:iron_stick", "darkage:iron_stick"}
								}
												})
	end

	if minetest.get_modpath("dye") then
		-- MFF gardengate white
		doors.register("doors:door_gardengate_white", {
								tiles = { "doors_door_gardengate_white.png" },
								description = "Garden Gate White Door",
								inventory_image = "doors_item_gardengate_white.png",
								groups = {choppy=2,oddly_breakable_by_hand=2,flammable=2,door=1},
								sounds = default.node_sound_wood_defaults(),
								recipe = {
									{"dye:white", "group:stick", ""},
									{"group:stick", "group:stick", "group:stick"},
									{"group:wood", "group:wood", "group:wood"}
								}
																	 })
	end

	-- Redifinition of doors function to make the ability to register doors with 3 blocks height
	local _doors = {}
	_doors.registered_doors3 = {} --MFF doors3

	local function replace_old_owner_information(pos)
		local meta = minetest.get_meta(pos)
		local owner = meta:get_string("doors_owner")
		if owner and owner ~= "" then
			meta:set_string("owner", owner)
			meta:set_string("doors_owner", "")
		end
	end
	
	local doors_get = doors.get
	doors.get = function(pos)
		local node_name = minetest.get_node(pos).name
		if _doors.registered_doors3[node_name] then
			-- A normal upright door
			return {
				pos = pos,
				open = function(self, player)
					if self:state() then
						return false
					end
					return _doors.door_toggle(self.pos, nil, player)
				end,
				close = function(self, player)
					if not self:state() then
						return false
					end
					return _doors.door_toggle(self.pos, nil, player)
				end,
				toggle = function(self, player)
					return _doors.door_toggle(self.pos, nil, player)
				end,
				state = function(self)
					local state = minetest.get_meta(self.pos):get_int("state")
					return state %2 == 1
				end
			}
		else
			return doors_get(pos)
		end
	end

	-- table used to aid door opening/closing
	local transform = {
		{
			{v = "_a", param2 = 3},
			{v = "_a", param2 = 0},
			{v = "_a", param2 = 1},
			{v = "_a", param2 = 2},
		},
		{
			{v = "_b", param2 = 1},
			{v = "_b", param2 = 2},
			{v = "_b", param2 = 3},
			{v = "_b", param2 = 0},
		},
		{
			{v = "_b", param2 = 1},
			{v = "_b", param2 = 2},
			{v = "_b", param2 = 3},
			{v = "_b", param2 = 0},
		},
		{
			{v = "_a", param2 = 3},
			{v = "_a", param2 = 0},
			{v = "_a", param2 = 1},
			{v = "_a", param2 = 2},
		},
	}

	local function get_double_doors(pos, dir, p1, b)
		local pos2 = nil
		if b == "a" then
			if p1 == 0 then
				if dir == 1 then
					pos2 = {x=pos.x, y=pos.y, z=pos.z-1}
				elseif dir == 2 then
					pos2 = {x=pos.x-1, y=pos.y, z=pos.z}
				elseif dir == 3 then
					pos2 = {x=pos.x, y=pos.y, z=pos.z+1}
				else
					pos2 = {x=pos.x+1, y=pos.y, z=pos.z}
				end
			elseif p1 == 3 then
				if dir == 1 then
					pos2 = {x=pos.x+1, y=pos.y, z=pos.z}
				elseif dir == 2 then
					pos2 = {x=pos.x, y=pos.y, z=pos.z-1}
				elseif dir == 3 then
					pos2 = {x=pos.x-1, y=pos.y, z=pos.z}
				else
					pos2 = {x=pos.x, y=pos.y, z=pos.z+1}
				end
			end
		else
			if p1 == 1 then
				if dir == 1 then
					pos2 = {x=pos.x+1, y=pos.y, z=pos.z}
				elseif dir == 2 then
					pos2 = {x=pos.x, y=pos.y, z=pos.z-1}
				elseif dir == 3 then
					pos2 = {x=pos.x-1, y=pos.y, z=pos.z}
				else
					pos2 = {x=pos.x, y=pos.y, z=pos.z+1}
				end
			elseif p1 == 2 then
				if dir == 1 then
					pos2 = {x=pos.x, y=pos.y, z=pos.z+1}
				elseif dir == 2 then
					pos2 = {x=pos.x+1, y=pos.y, z=pos.z}
				elseif dir == 3 then
					pos2 = {x=pos.x, y=pos.y, z=pos.z-1}
				else
					pos2 = {x=pos.x-1, y=pos.y, z=pos.z}
				end
			end
		end
		return pos2
	end

	function _doors.door_toggle(pos, node, clicker)
		local meta = minetest.get_meta(pos)
		node = node or minetest.get_node(pos)
		local def = minetest.registered_nodes[node.name]
		local name = def.door.name

		local state = meta:get_string("state")
		if state == "" then
			-- fix up lvm-placed right-hinged doors, default closed
			if node.name:sub(-2) == "_b" then
				state = 2
			else
				state = 0
			end
		else
			state = tonumber(state)
		end

		replace_old_owner_information(pos)
		
		if clicker and not default.can_interact_with_node(clicker, pos) then
			return false
		end

		local old = state
		-- until Lua-5.2 we have no bitwise operators :(
		if state % 2 == 1 then
			state = state - 1
		else
			state = state + 1
		end

		local dir = node.param2
		minetest.swap_node(pos, {
									 name = name .. transform[state + 1][dir+1].v,
									 param2 = transform[state + 1][dir+1].param2
										})
		meta:set_int("state", state)

		--MFF double porte
		local b = string.sub(node.name, -1)
		local pos2 = get_double_doors(pos, dir, old, b)
		if pos2 then
			local node2 = minetest.get_node_or_nil(pos2)
			if node2 and string.sub(node2.name, 0, -3) == name then
				if b ~= string.sub(node2.name, -1) then
					local state2 = minetest.get_meta(pos2):get_int("state")
					if (old % 2) == (state2 % 2) then
						_doors.door_toggle(pos2, node2, clicker)
						return true
					end
				end
			end
		end
		-- /double porte

		if state % 2 == 0 then
			minetest.sound_play(def.door.sounds[1],
									  {pos = pos, gain = 0.3, max_hear_distance = 10})
		else
			minetest.sound_play(def.door.sounds[2],
									  {pos = pos, gain = 0.3, max_hear_distance = 10})
		end

		return true
	end

	local function on_place_node(place_to, newnode,
										  placer, oldnode, itemstack, pointed_thing)
		-- Run script hook
		for _, callback in ipairs(minetest.registered_on_placenodes) do
			-- Deepcopy pos, node and pointed_thing because callback can modify them
			local place_to_copy = {x = place_to.x, y = place_to.y, z = place_to.z}
			local newnode_copy =
				{name = newnode.name, param1 = newnode.param1, param2 = newnode.param2}
			local oldnode_copy =
				{name = oldnode.name, param1 = oldnode.param1, param2 = oldnode.param2}
			local pointed_thing_copy = {
				type  = pointed_thing.type,
				above = vector.new(pointed_thing.above),
				under = vector.new(pointed_thing.under),
				ref   = pointed_thing.ref,
			}
			callback(place_to_copy, newnode_copy, placer,
						oldnode_copy, itemstack, pointed_thing_copy)
		end
	end

	local function can_dig_door(pos, digger)
		replace_old_owner_information(pos)
		if default.can_interact_with_node(digger, pos) then
			return true
		else
			minetest.record_protection_violation(pos, digger:get_player_name())
			return false
		end
	end
	
	-- door 3 nodes
	function doors.register3(name, def)
		if not name:find(":") then
			name = "nalc:" .. name
		end

		-- replace old doors of this type automatically
		minetest.register_lbm({
										 name = ":doors:replace_" .. name:gsub(":", "_"),
										 nodenames = {name.."_b_1", name.."_b_2"},
										 action = function(pos, node)
											 local l = tonumber(node.name:sub(-1))
											 local meta = minetest.get_meta(pos)
											 local h = meta:get_int("right") + 1
											 local p2 = node.param2
											 local replace = {
												 {{type = "a", state = 0}, {type = "a", state = 3}},
												 {{type = "b", state = 1}, {type = "b", state = 2}}
											 }
											 local new = replace[l][h]
											 -- retain infotext and doors_owner fields
											 minetest.swap_node(pos, {name = name .. "_" .. new.type, param2 = p2})
											 meta:set_int("state", new.state)
											 -- properly place doors:hidden at the right spot
											 local p3 = p2
											 if new.state >= 2 then
												 p3 = (p3 + 3) % 4
											 end
											 if new.state % 2 == 1 then
												 if new.state >= 2 then
													 p3 = (p3 + 1) % 4
												 else
													 p3 = (p3 + 3) % 4
												 end
											 end
											 -- wipe meta on top node as it's unused
											 minetest.set_node({x = pos.x, y = pos.y + 1, z = pos.z},
																	 {name = "doors:hidden", param2 = p3})
											 minetest.set_node({x = pos.x, y = pos.y + 2, z = pos.z},
																	 {name = "doors:hidden", param2 = p3})
										 end
									 })

		minetest.register_craftitem(":" .. name, {
												 description = def.description,
												 inventory_image = def.inventory_image,
												 groups = table.copy(def.groups),

												 on_place = function(itemstack, placer, pointed_thing)
													 local pos

													 if not pointed_thing.type == "node" then
														 return itemstack
													 end

													 local node = minetest.get_node(pointed_thing.under)
													 local pdef = minetest.registered_nodes[node.name]
													 if pdef and pdef.on_rightclick and
													 not placer:get_player_control().sneak then
														 return pdef.on_rightclick(pointed_thing.under,
																							node, placer, itemstack, pointed_thing)
													 end

													 if pdef and pdef.buildable_to then
														 pos = pointed_thing.under
													 else
														 pos = pointed_thing.above
														 node = minetest.get_node(pos)
														 pdef = minetest.registered_nodes[node.name]
														 if not pdef or not pdef.buildable_to then
															 return itemstack
														 end
													 end

													 local above = {x = pos.x, y = pos.y + 1, z = pos.z}
													 local top_node = minetest.get_node_or_nil(above)
													 local topdef = top_node and minetest.registered_nodes[top_node.name]

													 if not topdef or not topdef.buildable_to then
														 return itemstack
													 end

													 local above2 = { x = pos.x, y = pos.y + 2, z = pos.z }
													 local top_node2 = minetest.get_node_or_nil(above2)
													 local topdef2 = top_node2 and minetest.registered_nodes[top_node2.name]
													 
													 if not topdef2 or not topdef2.buildable_to then
														 return itemstack
													 end

													 local pn = placer:get_player_name()
													 if minetest.is_protected(pos, pn) or minetest.is_protected(above, pn) or minetest.is_protected(above2, pn) then
														 return itemstack
													 end

													 local dir = minetest.dir_to_facedir(placer:get_look_dir())

													 local ref = {
														 {x = -1, y = 0, z = 0},
														 {x = 0, y = 0, z = 1},
														 {x = 1, y = 0, z = 0},
														 {x = 0, y = 0, z = -1},
													 }

													 local aside = {
														 x = pos.x + ref[dir + 1].x,
														 y = pos.y + ref[dir + 1].y,
														 z = pos.z + ref[dir + 1].z,
													 }

													 local state = 0
													 if minetest.get_item_group(minetest.get_node(aside).name, "door") == 1 then
														 state = state + 2
														 minetest.set_node(pos, {name = name .. "_b", param2 = dir})
														 minetest.set_node(above, {name = "doors:hidden", param2 = (dir + 3) % 4})
														 minetest.set_node(above2, {name = "doors:hidden", param2 = (dir + 3) % 4})
													 else
														 minetest.set_node(pos, {name = name .. "_a", param2 = dir})
														 minetest.set_node(above, {name = "doors:hidden", param2 = dir})
														 minetest.set_node(above2, {name = "doors:hidden", param2 = dir})
													 end

													 local meta = minetest.get_meta(pos)
													 meta:set_int("state", state)

													 if def.protected then
														 meta:set_string("owner", pn)
														 meta:set_string("infotext", "Owned by " .. pn)
													 end

													 if not (creative and creative.is_enabled_for and creative.is_enabled_for(pn)) then
														 itemstack:take_item()
													 end

													 minetest.sound_play(def.sounds.place, {pos = pos})

													 on_place_node(pos, minetest.get_node(pos),
																		placer, node, itemstack, pointed_thing)

													 return itemstack
												 end
															  })
		def.inventory_image = nil

		if def.recipe then
			minetest.register_craft({
												output = name,
												recipe = def.recipe,
											})
		end
		def.recipe = nil

		if not def.sounds then
			def.sounds = default.node_sound_wood_defaults()
		end

		if not def.sound_open then
			def.sound_open = "doors_door_open"
		end

		if not def.sound_close then
			def.sound_close = "doors_door_close"
		end

		def.groups.not_in_creative_inventory = 1
		def.groups.door = 1
		def.drop = name
		def.door = {
			name = name,
			sounds = { def.sound_close, def.sound_open },
		}

		def.on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
			_doors.door_toggle(pos, node, clicker)
			return itemstack
		end
		def.after_dig_node = function(pos, node, meta, digger)
			minetest.remove_node({x = pos.x, y = pos.y + 1, z = pos.z})
			minetest.remove_node({x = pos.x, y = pos.y + 2, z = pos.z})
			nodeupdate({x = pos.x, y = pos.y + 2, z = pos.z})
		end
		def.on_rotate = false

		if def.protected then
			def.can_dig = can_dig_door
			def.on_blast = function() end
			def.on_key_use = function(pos, player)
				local door = doors.get(pos)
				door:toggle(player)
			end
			def.on_skeleton_key_use = function(pos, player, newsecret)
				replace_old_owner_information(pos)
				local meta = minetest.get_meta(pos)
				local owner = meta:get_string("owner")
				local pname = player:get_player_name()
				
				-- verify placer is owner of lockable door
				if owner ~= pname then
					minetest.record_protection_violation(pos, pname)
					minetest.chat_send_player(pname, "You do not own this locked door.")
					return nil
				end
				
				local secret = meta:get_string("key_lock_secret")
				if secret == "" then
					secret = newsecret
					meta:set_string("key_lock_secret", secret)
				end
				
				return secret, "a locked door", owner
			end
		else
			def.on_blast = function(pos, intensity)
				minetest.remove_node(pos)
				-- hidden node doesn't get blasted away.
				minetest.remove_node({x = pos.x, y = pos.y + 1, z = pos.z})
				minetest.remove_node({x = pos.x, y = pos.y + 2, z = pos.z})
				return {name}
			end
		end

		def.on_destruct = function(pos)
			minetest.remove_node({x = pos.x, y = pos.y + 1, z = pos.z})
			minetest.remove_node({x = pos.x, y = pos.y + 2, z = pos.z})
		end

		def.drawtype = "mesh"
		def.paramtype = "light"
		def.paramtype2 = "facedir"
		def.sunlight_propagates = true
		def.walkable = true
		def.is_ground_content = false
		def.buildable_to = false
		def.selection_box = {type = "fixed", fixed = {-1/2,-1/2,-1/2,1/2,2.5,-6/16}}
		def.collision_box = {type = "fixed", fixed = {-1/2,-1/2,-1/2,1/2,2.5,-6/16}}

		def.mesh = "door3_a.obj"
		minetest.register_node(":" .. name .. "_a", def)

		def.mesh = "door3_b.obj"
		minetest.register_node(":" .. name .. "_b", def)

		_doors.registered_doors3[name .. "_a"] = true
		_doors.registered_doors3[name .. "_b"] = true
	end

	doors.register3("door3_wood", {
							 tiles = {{ name = "doors_door3_wood.png", backface_culling = true }},
							 description = "Wooden Door 3 Nodes",
							 inventory_image = "doors3_item_wood.png",
							 groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2 },
							 recipe = {
								 {"", "", ""},
								 {"", "doors:door_wood", ""},
								 {"", "doors:door_wood", ""},
							 }
											})
	minetest.register_alias("doors:door3_wood", "nalc:door3_wood")

	doors.register3("door3_steel", {
							 tiles = {{ name = "doors_door3_steel.png", backface_culling = true }},
							 description = "Steel Door 3 Nodes",
							 inventory_image = "doors3_item_steel.png",
							 protected = true,
							 groups = {cracky = 1, level = 2},
							 sounds = default.node_sound_metal_defaults(),
							 sound_open = "doors_steel_door_open",
							 sound_close = "doors_steel_door_close",
							 recipe = {
								 {"", "", ""},
								 {"", "doors:door_steel", ""},
								 {"", "doors:door_steel", ""},
							 }
											 })
	minetest.register_alias("doors:door3_steel", "nalc:door3_steel")

	doors.register3("door3_glass", {
							 tiles = { "doors_door3_glass.png"},
							 description = "Glass Door 3 Nodes",
							 inventory_image = "doors3_item_glass.png",
							 groups = {cracky=3, oddly_breakable_by_hand=3},
							 sounds = default.node_sound_glass_defaults(),
							 sound_open = "doors_glass_door_open",
							 sound_close = "doors_glass_door_close",
							 recipe = {
								 {"", "", ""},
								 {"", "doors:door_glass", ""},
								 {"", "doors:door_glass", ""},
							 }
											 })
	minetest.register_alias("doors:door3_glass", "nalc:door3_glass")
	
	doors.register3("door3_obsidian_glass", {
							 tiles = { "doors_door3_obsidian_glass.png" },
							 description = "Obsidian Glass Door 3 Nodes",
							 inventory_image = "doors3_item_obsidian_glass.png",
							 groups = {cracky=3},
							 sounds = default.node_sound_glass_defaults(),
							 sound_open = "doors_glass_door_open",
							 sound_close = "doors_glass_door_close",
							 recipe = {
								 {"", "", ""},
								 {"", "doors:door_obsidian_glass", ""},
								 {"", "doors:door_obsidian_glass", ""},
							 },
														 })
	minetest.register_alias("doors:door3_obsidian_glass", "nalc:door3_obsidian_glass")

	if minetest.get_modpath("cherry_tree") then
		-- From BFD: Cherry planks doors
		doors.register3("door3_cherry", {
								 tiles = { "doors_door3_cherry.png" },
								 description = "Cherry Door 3 Nodes",
								 inventory_image = "doors3_item_cherry.png",
								 groups = {choppy=2, oddly_breakable_by_hand=2, flammable=2, door=1},
								 sounds = default.node_sound_wood_defaults(),
								 recipe = {
									 {"", "", ""},
									 {"", "doors:door_cherry", ""},
									 {"", "doors:door_cherry", ""},
								 },
												  })
		minetest.register_alias("doors:door3_cherry", "nalc:door3_cherry")

		---fuels---
		minetest.register_craft({
											type = "fuel",
											recipe = "nalc:door3_cherry",
											burntime = 21,
										})
	end

	if minetest.get_modpath("darkage") then
		-- doors prison MFF
		doors.register3("door3_prison", {
								 tiles = { "doors_door3_prison.png" },
								 description = "Prison Door 3 Nodes",
								 inventory_image = "doors3_item_prison.png",
								 protected = true,
								 groups = {cracky = 1, level = 2},
								 sounds = default.node_sound_metal_defaults(),
								 sound_open = "doors_steel_door_open",
								 sound_close = "doors_steel_door_close",
								 recipe = {
									 {"", "", ""},
									 {"", "doors:door_prison", ""},
									 {"", "doors:door_prison", ""},
								 }
												  })
		minetest.register_alias("doors:door3_prison", "nalc:door3_prison")
	end

	---fuels---
	minetest.register_craft({
										type = "fuel",
										recipe = "nalc:door3_wood",
										burntime = 21,
									})
	
end
