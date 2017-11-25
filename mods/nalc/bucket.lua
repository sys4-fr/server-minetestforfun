minetest.register_alias("bucket_acid", "nalc:bucket_acid")

bucket.register_liquid(
	"nalc:acid_source",
	"nalc:acid_flowing",
	"nalc:bucket_acid",
	"bucket_acid.png",
	"Acid Bucket",
	{not_in_creative_inventory = 1}
)

bucket.register_liquid(
	"nalc:sand_source",
	"nalc:sand_flowing",
	"nalc:bucket_sand",
	"bucket_sand.png",
	"Sand Bucket",
	{not_in_creative_inventory = 1}
)

minetest.register_craft(
	{ output = "nalc:bucket_sand",
	  recipe = {
		  {"group:sand"},
		  {"group:sand"},
		  {"bucket:bucket_water"},
	  },
	})

minetest.register_alias("bucket:acid_source", "nalc:acid_source")
minetest.register_alias("bucket:acid_flowing", "nalc:acid_flowing")
minetest.register_alias("bucket:bucket_acid", "nalc:bucket_acid")

minetest.register_alias("bucket:sand_source", "nalc:sand_source")
minetest.register_alias("bucket:sand_flowing", "nalc:sand_flowing")
minetest.register_alias("bucket:bucket_sand", "nalc:bucket_sand")
