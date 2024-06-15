extends GutTest

const FogOfWar = preload("res://World/FogOfWar.tscn")

var fog_of_war: FogOfWar = null


func before_each():
	fog_of_war = FogOfWar.instantiate()


func after_each():
	fog_of_war.free()


func test_clear_fog_with_radius_0():

	# arrange
	watch_signals(LevelStats)

	# act
	var fog_to_clear = fog_of_war.clear_fog(Vector2(264, 472), 0)

	# assert
	assert_eq(fog_to_clear, [Vector2(16, 29)], "Should clear cell of avatar" )
	assert_signal_emitted(LevelStats, "cell_cleared")


func test_clear_fog_with_radius_1():

	# act
	var fog_to_clear = fog_of_war.clear_fog(Vector2(0, 0), 1)

	# assert
	assert_eq(fog_to_clear,
		[Vector2(0, 0), Vector2(1, 0), Vector2(-1, 0), Vector2(0, 1), Vector2(0, -1)],
		"Should center and clear all neighbor cells when radius is one" )


func test_clear_fog_with_radius_2():

	# act
	var fog_to_clear = fog_of_war.clear_fog(Vector2(0, 0), 2)

	# assert
	assert_eq(fog_to_clear,
		[Vector2(0, 0), Vector2(1, 0), Vector2(-1, 0), Vector2(2, 0), Vector2(-2, 0),
		Vector2(0, 1), Vector2(0, -1), Vector2(1, 1), Vector2(-1 ,1), Vector2(1, -1), Vector2(-1, -1),
		Vector2(0, 2), Vector2 (0, -2)],
		"Should clear cells in all quadrants when radius is two" )


func test_restore_cleared_cells():

	# arrange
	var cell = Vector2i(1, 2)
	fog_of_war.set_cell(0, cell, 0, Vector2.ZERO)
	var level_stats = LvlStats.new()
	level_stats.cleared_cell(cell)

	# act
	fog_of_war.restore_cleared_cells(level_stats)

	# assert
	var used_cells = fog_of_war.get_used_cells(0)
	assert_false(used_cells.has(cell), "Should contain no cells when the only set cell is cleared")

	# tear down
	level_stats.free()
