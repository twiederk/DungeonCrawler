extends GutTest

var knight: Knight = null

func before_each():
	knight = Knight.new()
	
func after_each():
	knight.free()

func test_should_move_distance_in_positive_x_direction():
	# act
	knight.move(knight.STEP, 0)
	
	# assert
	assert_eq(knight.position.x, 64)

func test_should_move_distance_in_negative_x_direction():
	# act
	knight.move(-knight.STEP, 0)
	
	# assert
	assert_eq(knight.position.x, -64)

func test_should_move_distance_in_positive_y_direction():
	# act
	knight.move(0, knight.STEP)
	
	# assert
	assert_eq(knight.position.y, 64)
	
func test_should_move_distance_in_negative_y_direction():
	# act
	knight.move(0, -knight.STEP)
	
	# assert
	assert_eq(knight.position.y, -64)
	
