extends GutTest

var character: Character = null

func before_each():
	character = Character.new()
	
func after_each():
	character.free()

func test_should_move_to_new_position_when_no_collision_occurs():
	# act
	var result = character.snap_to_grid(null, Vector2(64, 64))

	# assert
	assert_eq(result, Vector2.ZERO)

func test_should_stay_at_current_position_when_collision_occurs():
	# arrange
	var currentPosition = Vector2(64, 64)
	
	# act
	var result = character.snap_to_grid(KinematicCollision2D.new(), currentPosition)

	# assert
	assert_eq(result, currentPosition)
