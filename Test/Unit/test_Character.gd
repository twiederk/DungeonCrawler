extends GutTest

var _sender = InputSender.new(Input)
var character: Character = null


func before_each():
	character = Character.new()

	
func after_each():
	character.free()
	_sender.release_all()

	_sender.clear()


func test_should_have_zero_velocity_when_no_input_is_given():

	# assert
	Input.flush_buffered_events()

	# act
	var result = character.calculateVelocity()

	# assert
	assert_eq(result, Vector2.ZERO)


func test_calculateVelocity_right():

	# arrange
	_sender.action_down('ui_right')
	Input.flush_buffered_events()
	var hitboxPivot = Position2D.new()
	character.hitboxPivot = hitboxPivot
	
	# act
	var velocity = character.calculateVelocity()
	
	# assert
	assert_eq(velocity, Vector2(Character.STEP, 0), "Should step right when right is pressed")
	assert_eq(hitboxPivot.rotation_degrees, 0, "Should rotate hitbox by 0 degrees")
	
	
func test_calculateVelocity_left():
	# arrange
	_sender.action_down('ui_left')
	Input.flush_buffered_events()
	var hitboxPivot = Position2D.new()
	character.hitboxPivot = hitboxPivot

	# act
	var result = character.calculateVelocity()

	# assert
	assert_eq(result, Vector2(-Character.STEP, 0), "Should step left when left is pressed")
	assert_eq(hitboxPivot.rotation_degrees, 180, "Should rotate hitbox by 180 degrees")


func test_calculateVelocity_up():
	# arrange
	_sender.action_down('ui_up')
	Input.flush_buffered_events()
	var hitboxPivot = Position2D.new()
	character.hitboxPivot = hitboxPivot

	# act
	var result = character.calculateVelocity()

	# assert
	assert_eq(result, Vector2(0, -Character.STEP), "Should step up when up is pressed")
	assert_eq(hitboxPivot.rotation_degrees, 270, "Should rotate hitbox by 270 degrees")


func test_calculateVelocity_down():
	# arrange
	_sender.action_down('ui_down')
	Input.flush_buffered_events()
	var hitboxPivot = Position2D.new()
	character.hitboxPivot = hitboxPivot

	# act
	var result = character.calculateVelocity()

	# assert
	assert_eq(result, Vector2(0, Character.STEP), "Should step down when down is pressed")
	assert_eq(hitboxPivot.rotation_degrees, 90, "Should rotate hitbox by 90 degrees")


func test_snap_to_grid_no_collision():
	# act
	var result = character.snap_to_grid(null, Vector2(64, 64))

	# assert
	assert_eq(result, Vector2.ZERO, "Should move to new position when no collision occurs")


func test_should_stay_at_current_position_when_collision_occurs():
	
	# arrange
	var currentPosition = Vector2(64, 64)
	
	# act
	var result = character.snap_to_grid(KinematicCollision2D.new(), currentPosition)

	# assert
	assert_eq(result, currentPosition, "Should_stay at current position when collision occurs")

