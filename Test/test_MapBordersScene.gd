extends GutTest

const MapBordersScene = preload("res://World/MapBorders.tscn")

var map_borders: MapBorders = null


func before_each():
	map_borders = MapBordersScene.instantiate()
	add_child(map_borders)


func after_each():
	map_borders.free()


func test_configure_borders():

	# act
	map_borders.configure_borders(Vector2(10, 20))

	# assert
	assert_eq(map_borders.north_border.position, Vector2(0, 0))
	assert_eq(map_borders.west_border.position, Vector2(0, 0))
	assert_eq(map_borders.south_border.position, Vector2(0, 20))
	assert_eq(map_borders.east_border.position, Vector2(10, 20))


