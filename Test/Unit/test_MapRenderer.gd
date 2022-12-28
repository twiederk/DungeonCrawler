extends GutTest

var map_renderer: MapRenderer = null

func before_each():
	map_renderer = MapRenderer.new()
	
func after_each():
	map_renderer.free()


func test_load_file():
	# act
	var map = map_renderer.load_file("res://Test/Unit/test_map.tres")
	
	# assert
	assert_eq(map.size(), 16, "Map should contain 16 lines")
	

func test_char_to_tile_id_with_0():
	# act
	var tile_id = map_renderer.char_to_tile_id("0")
	
	# assert
	assert_eq(tile_id, 0, "Number '0' should be tile id 0")


func test_char_to_tile_id_with_9():
	# act
	var tile_id = map_renderer.char_to_tile_id("9")
	
	# assert
	assert_eq(tile_id, 9, "Number '9' should be tile id 9")


func test_char_to_tile_id_with_a():
	# act
	var tile_id = map_renderer.char_to_tile_id("a")
	
	# assert
	assert_eq(tile_id, 10, "Letter 'a' should be tile id 10")
