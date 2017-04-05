local players = {}
player_physics = {}


function player_physics.check(playername)
	if players[playername] == nil then
		players[playername] = {speed = {}, jump = {}, gravity={}, temp={}}
	end
end


minetest.register_on_joinplayer(function(player)
	local playername = player:get_player_name()
	player_physics.check(playername)
end)


minetest.register_on_leaveplayer(function(player)
	local playername = player:get_player_name()
	players[playername] = nil
end)


function player_physics.add(player, physicsname , name, value)
	if physicsname ~= "speed" and physicsname ~= "jump" and physicsname ~= "gravity" then
		return
	end
	local playername = player:get_player_name()
	player_physics.check(playername)
	players[playername][physicsname][name] = value
end


function player_physics.remove(player, physicsname, name)
	if physicsname ~= "speed" and physicsname ~= "jump" and physicsname ~= "gravity" then
		return
	end
	local playername = player:get_player_name()
	player_physics.check(playername)
	players[playername][physicsname][name] = nil
end


function player_physics.add_effect(player, physicsname, name, value, time)
	if physicsname ~= "speed" and physicsname ~= "jump" and physicsname ~= "gravity" then
		return
	end
	if type(value) ~= "number" or type(time) ~= "number" then
		return
	end
	local playername = player:get_player_name()
	player_physics.check(playername)
	players[playername]["temp"][name] = {n=physicsname, v=value, t=time}
end


function player_physics.remove_effect(player, name)
	local playername = player:get_player_name()
	player_physics.check(playername)
	players[playername]["temp"][name] = nil
end





minetest.register_globalstep(function(dtime)
	for _,player in ipairs(minetest.get_connected_players()) do
		local playername = player:get_player_name()
		if playername ~= "" then
			player_physics.check(playername)
			local speed = 1
			local jump = 1
			local gravity = 1

			for _, v in pairs(players[playername]["speed"]) do
				speed = speed + v
			end
			for _, v in pairs(players[playername]["jump"]) do
				jump = jump + v
			end
			for _, v in pairs(players[playername]["gravity"]) do
				gravity = gravity + v
			end

			--temporary effect
			for n, k in pairs(players[playername]["temp"]) do
				if k.n == "speed" then
					speed = speed + k.v
				elseif k.n == "jump" then
					jump = jump + k.v
				elseif k.n == "gravity" then
					gravity = gravity + k.v
				end

				t = k.t-dtime
				if t > 0 then
					players[playername]["temp"][n]["t"] = t
				else
					players[playername]["temp"][n] = nil
				end
			end

			if speed > 4 then
				speed = 4
			elseif speed < 0 then
				speed = 0
			end

			if jump > 3 then
				jump = 3
			elseif jump < 0 then
				jump = 0
			end

			if gravity > 2 then
				gravity = 2
			elseif gravity < -2 then
				gravity = -2
			end

			player:set_physics_override({speed=speed,jump=jump, gravity=gravity})
		end
	end
end)

