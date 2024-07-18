extends GutTest

var level_stats: LvlStats = null

func before_each():
	level_stats = LvlStats.new()


func after_each():
	level_stats.free()


func test_get_set_current_level():

	# assert
	assert_accessors(level_stats, "current_level", "HirschhornCastleMap", "Cave")


func test_visited_node():

	# arrange
	var node_path = NodePath("Village/YSort/Fixtures/SilverKey")

	# act
	level_stats.visited_node(node_path)

	# assert
	var visited_nodes = level_stats.get_visited_nodes()
	assert_eq(visited_nodes.size(), 1, "Should contain silver key")
	assert_eq(visited_nodes[0], "Village/YSort/Fixtures/SilverKey", "Should be path of silver_key")


func test_reset():

	# arrange
	level_stats._visited_nodes["Village"] = [ "Node1", "Node2"]
	level_stats._visited_nodes["Cave"] = [ "Node1", "Node2"]
	level_stats._cleared_cells["Cave"] = [ Vector2.ZERO]

	# act
	level_stats.reset()

	# assert
	assert_eq(level_stats._visited_nodes.size(), 0, "Should clear visited nodes when reseted")
	assert_eq(level_stats._cleared_cells.size(), 0, "Should clear cleard_cells when reseted")


func test_cleared_cell():

	# arrange
	var cell = Vector2(1, 2)

	# act
	level_stats.cleared_cell(cell)

	# assert
	var cleared_cells = level_stats.get_cleared_cells()
	assert_eq(cleared_cells.size(), 1, "Should contain cleared cell")
	assert_eq(cleared_cells[0], cell, "Should be vector of cleared cell")


func test_cleared_cell_called_twice():

	# arrange
	var cell = Vector2(1, 2)
	level_stats.cleared_cell(cell)

	# act
	level_stats.cleared_cell(cell)

	# assert
	var cleared_cells = level_stats.get_cleared_cells()
	assert_eq(cleared_cells.size(), 1, "Should contain cleared cell only once")
