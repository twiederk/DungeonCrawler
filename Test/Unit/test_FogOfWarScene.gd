extends GutTest

const FogOfWar = preload("res://World/FogOfWar.tscn")


func test_clear_fog_with_radius_0():

	# arrange
	var fog_of_war = FogOfWar.instantiate()

	# act
	var fog_to_clear = fog_of_war.clear_fog(Vector2(264, 472), 0)

	# assert
	assert_eq(fog_to_clear, [Vector2(16, 29)], "Should clear cell of avatar" )

	# tear down
	fog_of_war.free()


func test_clear_fog_with_radius_1():

	# arrange
	var fog_of_war = FogOfWar.instantiate()

	# act
	var fog_to_clear = fog_of_war.clear_fog(Vector2(0, 0), 1)

	# assert
	assert_eq(fog_to_clear,
		[Vector2(0, 0), Vector2(1, 0), Vector2(-1, 0), Vector2(0, 1), Vector2(0, -1)],
		"Should center and clear all neighbor cells when radius is one" )

	# tear down
	fog_of_war.free()


func test_clear_fog_with_radius_2():

	# arrange
	var fog_of_war = FogOfWar.instantiate()

	# act
	var fog_to_clear = fog_of_war.clear_fog(Vector2(0, 0), 2)

	# assert
	assert_eq(fog_to_clear,
		[Vector2(0, 0), Vector2(1, 0), Vector2(-1, 0), Vector2(2, 0), Vector2(-2, 0),
		Vector2(0, 1), Vector2(0, -1), Vector2(1, 1), Vector2(-1 ,1), Vector2(1, -1), Vector2(-1, -1),
		Vector2(0, 2), Vector2 (0, -2)],
		"Should clear cells in all quadrants when radius is two" )

	# tear down
	fog_of_war.free()
