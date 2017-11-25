minetest.register_ore(
	{
		ore_type       = "scatter",
		ore            = "nalc:desert_stone_with_coal",
		wherein        = "default:desert_stone",
		clust_scarcity = 9 * 9 * 9,
		clust_num_ores = 10,
		clust_size     = 3,
		y_min          = -113,
		y_max          = 64,
	})

minetest.register_ore(
	{
		ore_type       = "scatter",
		ore            = "nalc:desert_stone_with_iron",
		wherein        = "default:desert_stone",
		clust_scarcity = 9 * 9 * 9,
		clust_num_ores = 10,
		clust_size     = 3,
		y_min          = -113,
		y_max          = 64,
	})

minetest.register_ore(
	{
		ore_type       = "scatter",
		ore            = "nalc:desert_stone_with_copper",
		wherein        = "default:desert_stone",
		clust_scarcity = 11 * 11 * 11,
		clust_num_ores = 6,
		clust_size     = 3,
		y_min          = -113,
		y_max          = 64,
	})

minetest.register_ore(
	{
		ore_type       = "scatter",
		ore            = "nalc:desert_stone_with_tin",
		wherein        = "default:desert_stone",
		clust_scarcity = 7 * 7 * 7,
		clust_num_ores = 3,
		clust_size     = 7,
		y_min          = -113,
		y_max          = 12,
	})

	-- Beware of Meze
minetest.register_ore(
	{
		ore_type       = "scatter",
		ore            = "nalc:meze",
		wherein        = "default:stone",
		clust_scarcity = 40 * 40 * 40,
		clust_num_ores = 3,
		clust_size     = 2,
		y_min          = 0,
		y_max          = 64,
		flags          = "absheight",
	})

minetest.register_ore(
	{
		ore_type       = "scatter",
		ore            = "nalc:meze",
		wherein        = "default:desert_stone",
		clust_scarcity = 40 * 40 * 40,
		clust_num_ores = 3,
		clust_size     = 2,
		y_min          = -113,
		y_max          = 64,
		flags          = "absheight",
	})

-- Acid lakes in gravel:

	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "nalc:acid_source",
		wherein        = "default:gravel",
		clust_scarcity = 26 * 26 * 26,
		clust_num_ores = 64,
		clust_size     = 5,
		y_min          = -30000,
		y_max          = 64,
								 })
	
