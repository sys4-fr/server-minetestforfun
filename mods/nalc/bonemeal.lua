if minetest.get_modpath("bonemeal") then
	-- NALC : Remove dirt with bones to avoid infinite bones creation with the same dirt block
	minetest.override_item(
		"default:dirt",
		{
			drop = {
				max_items = 1,
				items = {
					{
						items = {"bonemeal:bone"}, -- NALC : Removed default:dirt
						rarity = 30,
					},
					{
						items = {"default:dirt"},
					}
				}
			},
		})
end
