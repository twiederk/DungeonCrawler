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

func test_should_step_right_when_right_is_pressed():
	# arrange
	_sender.action_down('ui_right')
	Input.flush_buffered_events()
	
	# act
	var result = character.calculateVelocity()
	
	# assert
	assert_eq(result, Vector2(Character.STEP, 0))
	
func test_should_step_left_when_left_is_pressed():
	# arrange
	_sender.action_down('ui_left')
	Input.flush_buffered_events()
	
	# act
	var result = character.calculateVelocity()
	
	# assert
	assert_eq(result, Vector2(-Character.STEP, 0))
	
func test_should_step_up_when_up_is_pressed():
	# arrange
	_sender.action_down('ui_up')
	Input.flush_buffered_events()
	
	# act
	var result = character.calculateVelocity()
	
	# assert
	assert_eq(result, Vector2(0, -Character.STEP))
	
	
func test_should_step_down_when_down_is_pressed():
	# arrange
	_sender.action_down('ui_down')
	Input.flush_buffered_events()
	
	# act
	var result = character.calculateVelocity()
	
	# assert
	assert_eq(result, Vector2(0, Character.STEP))
	
