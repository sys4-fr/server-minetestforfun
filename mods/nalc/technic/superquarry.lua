
local S = technic.getter

local tube_entry = "^pipeworks_tube_connection_metallic.png"
local cable_entry = "^technic_cable_connection_overlay.png"

minetest.register_craft({
	recipe = {
		{"default:mithrilblock",       "pipeworks:filter",       "default:mithrilblock"},
		{"technic:motor",              "technic:quarry", "technic:diamond_drill_head"},
		{"technic:quarry", "technic:hv_cable",       "technic:quarry"}},
	output = "technic:superquarry",
})

local superquarry_dig_above_nodes = 3 -- How far above the superquarry we will dig nodes
local superquarry_max_depth       = 2500
local superquarry_demand = 20000
local superquarry_eject_dir = vector.new(0, 1, 0)

local function set_superquarry_formspec(meta)
	local radius = meta:get_int("size")
	local formspec = "size[6,4.3]"..
		"list[context;cache;0,1;4,3;]"..
		"item_image[4.8,0;1,1;technic:superquarry]"..
		"label[0,0.2;"..S("%s superquarry"):format("HV").."]"..
		"field[4.3,3.5;2,1;size;"..S("Radius:")..";"..radius.."]"
	if meta:get_int("enabled") == 0 then
		formspec = formspec.."button[4,1;2,1;enable;"..S("Disabled").."]"
	else
		formspec = formspec.."button[4,1;2,1;disable;"..S("Enabled").."]"
	end
	local diameter = radius*2 + 1
	local nd = meta:get_int("dug")
	local rel_y = superquarry_dig_above_nodes - math.floor(nd / (diameter*diameter))
	formspec = formspec.."label[0,4;"..minetest.formspec_escape(
			nd == 0 and S("Digging not started") or
			(rel_y < -superquarry_max_depth and S("Digging finished") or
				(meta:get_int("purge_on") == 1 and S("Purging cache") or
				S("Digging %d m "..(rel_y > 0 and "above" or "below").." machine")
					:format(math.abs(rel_y))))
			).."]"
	formspec = formspec.."button[4,2;2,1;restart;"..S("Restart").."]"
	meta:set_string("formspec", formspec)
end

local function set_superquarry_demand(meta)
	local radius = meta:get_int("size")
	local diameter = radius*2 + 1
	local machine_name = S("%s superquarry"):format("HV")
	if meta:get_int("enabled") == 0 or meta:get_int("purge_on") == 1 then
		meta:set_string("infotext", S(meta:get_int("purge_on") == 1 and "%s purging cache" or "%s Disabled"):format(machine_name))
		meta:set_int("HV_EU_demand", 0)
	elseif meta:get_int("dug") == diameter*diameter * (superquarry_dig_above_nodes+1+superquarry_max_depth) then
		meta:set_string("infotext", S("%s Finished"):format(machine_name))
		meta:set_int("HV_EU_demand", 0)
	else
		meta:set_string("infotext", S(meta:get_int("HV_EU_input") >= superquarry_demand and "%s Active" or "%s Unpowered"):format(machine_name))
		meta:set_int("HV_EU_demand", superquarry_demand)
	end
end

local function superquarry_receive_fields(pos, formname, fields, sender)
	local meta = minetest.get_meta(pos)
	if fields.size and string.find(fields.size, "^[0-17]+$") then
		local size = tonumber(fields.size)
		if size >= 2 and size <= 16 and size ~= meta:get_int("size") then
			meta:set_int("size", size)
			meta:set_int("dug", 0)
		end
	end
	if fields.enable then meta:set_int("enabled", 1) end
	if fields.disable then meta:set_int("enabled", 0) end
	if fields.restart then
		meta:set_int("dug", 0)
		meta:set_int("purge_on", 1)
	end
	set_superquarry_formspec(meta)
	set_superquarry_demand(meta)
end

local function superquarry_handle_purge(pos)
	local meta = minetest.get_meta(pos)
	local inv = meta:get_inventory()
	local i = 0
	for _,stack in ipairs(inv:get_list("cache")) do
		i = i + 1
		if stack then
			local item = stack:to_table()
			if item then
				technic.tube_inject_item(pos, pos, superquarry_eject_dir, item)
				stack:clear()
				inv:set_stack("cache", i, stack)
				break
			end
		end
	end
	if inv:is_empty("cache") then
		meta:set_int("purge_on", 0)
	end
end

local function superquarry_run(pos, node)
	local meta = minetest.get_meta(pos)
	local inv = meta:get_inventory()
	-- initialize cache for the case we load an older world
	inv:set_size("cache", 12)
	-- toss a coin whether we do an automatic purge. Chance 1:100
	local purge_rand = math.random()
	if purge_rand <= 0.01 then
		meta:set_int("purge_on", 1)
	end

	if meta:get_int("enabled") and meta:get_int("HV_EU_input") >= superquarry_demand and meta:get_int("purge_on") == 0 then
		local pdir = minetest.facedir_to_dir(node.param2)
		local qdir = pdir.x == 1 and vector.new(0,0,-1) or
			(pdir.z == -1 and vector.new(-1,0,0) or
			(pdir.x == -1 and vector.new(0,0,1) or
			vector.new(1,0,0)))
		local radius = meta:get_int("size")
		local diameter = radius*2 + 1
		local startpos = vector.add(vector.add(vector.add(pos,
			vector.new(0, superquarry_dig_above_nodes, 0)),
			pdir),
			vector.multiply(qdir, -radius))
		local endpos = vector.add(vector.add(vector.add(startpos,
			vector.new(0, -superquarry_dig_above_nodes-superquarry_max_depth, 0)),
			vector.multiply(pdir, diameter-1)),
			vector.multiply(qdir, diameter-1))
		local vm = VoxelManip()
		local minpos, maxpos = vm:read_from_map(startpos, endpos)
		local area = VoxelArea:new({MinEdge=minpos, MaxEdge=maxpos})
		local data = vm:get_data()
		local c_air = minetest.get_content_id("air")
		local owner = meta:get_string("owner")
		local nd = meta:get_int("dug")
		while nd ~= diameter*diameter * (superquarry_dig_above_nodes+1+superquarry_max_depth) do
			local ry = math.floor(nd / (diameter*diameter))
			local ndl = nd % (diameter*diameter)
			if ry % 2 == 1 then
				ndl = diameter*diameter - 1 - ndl
			end
			local rq = math.floor(ndl / diameter)
			local rp = ndl % diameter
			if rq % 2 == 1 then rp = diameter - 1 - rp end
			local digpos = vector.add(vector.add(vector.add(startpos,
				vector.new(0, -ry, 0)),
				vector.multiply(pdir, rp)),
				vector.multiply(qdir, rq))
			local can_dig = true
			if can_dig and minetest.is_protected and minetest.is_protected(digpos, owner) then
				can_dig = false
			end
			local dignode
			if can_dig then
				dignode = technic.get_or_load_node(digpos) or minetest.get_node(digpos)
				local dignodedef = minetest.registered_nodes[dignode.name] or {diggable=false}
				if not dignodedef.diggable or (dignodedef.can_dig and not dignodedef.can_dig(digpos, nil)) then
					can_dig = false
				end
			end

			if can_dig then
				for ay = startpos.y, digpos.y+1, -1 do
					local checkpos = {x=digpos.x, y=ay, z=digpos.z}
					local checknode = technic.get_or_load_node(checkpos) or minetest.get_node(checkpos)
					if checknode.name ~= "air" then
						can_dig = false
						break
					end
				end
			end
			nd = nd + 1
			if can_dig then
				minetest.remove_node(digpos)
				local drops = minetest.get_node_drops(dignode.name, "")
				for _, dropped_item in ipairs(drops) do
					local left = inv:add_item("cache", dropped_item)
					while not left:is_empty() do
						meta:set_int("purge_on", 1)
						superquarry_handle_purge(pos)
						left = inv:add_item("cache", left)
					end
				end
				break
			end
		end
		if nd == diameter*diameter * (superquarry_dig_above_nodes+1+superquarry_max_depth) then
			-- if a superquarry is finished, we enable purge mode
			meta:set_int("purge_on", 1)
		end
		meta:set_int("dug", nd)
	else
		-- if a superquarry is disabled or has no power, we enable purge mode
		meta:set_int("purge_on", 1)
	end
	-- if something triggered a purge, we handle it
	if meta:get_int("purge_on") == 1 then
		superquarry_handle_purge(pos)
	end
	set_superquarry_formspec(meta)
	set_superquarry_demand(meta)
end

local function send_move_error(player)
	minetest.chat_send_player(player:get_player_name(),
		S("Manually taking/removing from cache by hand is not possible. "..
		"If you can't wait, restart or disable the superquarry to start automatic purge."))
	return 0
end

minetest.register_node("technic:superquarry", {
	description = S("%s superquarry"):format("HV"),
	tiles = {
		"default_obsidian_block.png"..tube_entry,
		"default_obsidian_block.png"..cable_entry,
		"default_obsidian_block.png"..cable_entry,
		"default_obsidian_block.png"..cable_entry,
		"default_obsidian_block.png^default_tool_mesepick.png",
		"default_obsidian_block.png"..cable_entry
	},
	paramtype2 = "facedir",
	groups = {cracky=2, tubedevice=1, technic_machine=1, technic_hv=1},
	connect_sides = {"bottom", "front", "left", "right"},
	tube = {
		connect_sides = {top = 1},
		-- lower priority than other tubes, so that quarries will prefer any
		-- other tube to another superquarry, which could lead to server freezes
		-- in certain superquarry placements (2x2 for example would never eject)
		priority = 10,
		can_go = function(pos, node, velocity, stack)
			-- always eject the same, even if items came in another way
			-- this further mitigates loops and generally avoids random sideway movement
			-- that can be expected in certain superquarry placements
			return { superquarry_eject_dir }
		end
	},
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("infotext", S("%s superquarry"):format("HV"))
		meta:set_int("size", 4)
		set_superquarry_formspec(meta)
		set_superquarry_demand(meta)
	end,
	after_place_node = function(pos, placer, itemstack)
		local meta = minetest.get_meta(pos)
		meta:set_string("owner", placer:get_player_name())
		pipeworks.scan_for_tube_objects(pos)
	end,
	can_dig = function(pos,player)
		local meta = minetest.get_meta(pos);
		local inv = meta:get_inventory()
		return inv:is_empty("cache")
	end,
	after_dig_node = pipeworks.scan_for_tube_objects,
	on_receive_fields = superquarry_receive_fields,
	technic_run = superquarry_run,
	allow_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
		return send_move_error(player)
	end,
	allow_metadata_inventory_put = function(pos, listname, index, stack, player)
		return send_move_error(player)
	end,
	allow_metadata_inventory_take = function(pos, listname, index, stack, player)
		return send_move_error(player)
	end
})

technic.register_machine("HV", "technic:superquarry", technic.receiver)

