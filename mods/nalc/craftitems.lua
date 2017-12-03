minetest.override_item(
	"default:stick",
	{
		stack_max = 1000
	})

minetest.override_item(
	"default:clay_lump",
	{
		stack_max = 200
	})

minetest.register_craftitem(
	"nalc:scorched_stuff",
	{
		description = "Scorched Stuff",
		inventory_image = "default_scorched_stuff.png",
	})
minetest.register_alias("default:scorched_stuff", "nalc:scorched_stuff")
