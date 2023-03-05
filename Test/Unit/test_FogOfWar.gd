extends GutTest

var fog_of_war: FogOfWar = null

func before_each():
	fog_of_war = FogOfWar.new()


func after_each():
	fog_of_war.free()


func test_create_light_matrix_radius_0():

	# act
	var light_matrix = fog_of_war._create_light_matrix(0)

	# assert
	assert_eq(light_matrix, [Vector2(0, 0)], "Should light only center when radius is zero")


func test_create_light_matrix_radius_1():

	# act
	var light_matrix = fog_of_war._create_light_matrix(1)

	# assert
	assert_eq(light_matrix, [
		Vector2(0, 0), Vector2(1,0), Vector2(-1, 0), Vector2(0, 1), Vector2(0, -1),  ],
		"Should light only neighbors when radius is one")


func test_create_light_matrix_radius_2():

	# act
	var light_matrix = fog_of_war._create_light_matrix(2)

	# assert
	assert_eq(light_matrix, [
		Vector2(0,0), Vector2(1,0), Vector2(-1, 0), Vector2(2, 0), Vector2(-2, 0),
		Vector2(0,1), Vector2(0,-1), Vector2(1, 1), Vector2(-1, 1), Vector2(1, -1), Vector2(-1, -1),
		Vector2(0,2), Vector2(0,-2), ],
		"Should light cells in all four quadrants when radius is 2")


func test_create_light_matrix_radius_3():

	# act
	var light_matrix = fog_of_war._create_light_matrix(3)

	# assert
	assert_eq(light_matrix, [
		Vector2(0,0), Vector2(1,0), Vector2(-1, 0), Vector2(2,0), Vector2(-2,0), Vector2(3,0), Vector2(-3,0),
		Vector2(0,1), Vector2(0,-1), Vector2(1, 1), Vector2(-1, 1), Vector2(1, -1), Vector2(-1, -1), Vector2(2,1), Vector2(-2,1), Vector2(2, -1), Vector2(-2,-1),
		Vector2(0,2), Vector2(0,-2), Vector2(1,2), Vector2(-1,2), Vector2(1,-2), Vector2(-1,-2),
		Vector2(0,3), Vector2(0,-3), ],
		"Should create proper light matrix")


func test_mirror_vector_center_vector():
	
	# act
	var mirror = fog_of_war._mirror_vector(Vector2.ZERO)

	# assert
	assert_eq(mirror, [], "Should not mirror vector when vector is center (Vector2.ZERO)")


func test_mirror_vector_x_axis_vector():

	# act
	var mirror = fog_of_war._mirror_vector(Vector2.RIGHT)

	# assert
	assert_eq(mirror, [Vector2.LEFT], "Should mirror vector only once when vector is on x-axis")


func test_mirror_vector_y_axis_vector():

	# act
	var mirror = fog_of_war._mirror_vector(Vector2.DOWN)

	# assert
	assert_eq(mirror, [Vector2.UP], "Should mirror vector only once when vector is on y-axis")


func test_mirror_vector_quadrant_IV():

	# act
	var mirror = fog_of_war._mirror_vector(Vector2(1,1))

	# assert
	assert_eq(mirror, [Vector2(-1, 1), Vector2(1, -1), Vector2(-1, -1)],
		"Should mirror vector three times when vector is in quadrant IV")
