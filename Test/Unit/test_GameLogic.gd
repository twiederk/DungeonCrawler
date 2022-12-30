extends GutTest


var _sender = InputSender.new(Input)
var game_logic: GameLogic = null


func before_each():
	game_logic = GameLogic.new()
	
	
func after_each():
	game_logic.free()
	_sender.release_all()
	_sender.clear()


func test_check_input_nothing():
	## arrange
	Input.flush_buffered_events()
	
	# act
	game_logic.check_input()
	
	# assert
	assert_eq(game_logic.current_character, 0, "Should stay with current creature when no input occurred")


func test_check_input_next():
	## arrange
	game_logic.characters = [Character.new(), Character.new()]
	game_logic.current_character = 0

	_sender.action_down("next")
	Input.flush_buffered_events()
	
	# act
	game_logic.check_input()
	
	# assert
	assert_eq(game_logic.current_character, 1, "Should move to next creature when input next occurred")
	
	
func test_check_input_next_on_last_creature():
	# arrange
	game_logic.characters = [Character.new(), Character.new()]
	game_logic.current_character = 1
	
	_sender.action_down("next")
	Input.flush_buffered_events()	
	
	# act
	game_logic.check_input()
	
	# assert
	assert_eq(game_logic.current_character, 0, "Should move to first creature when end of creature array is reached")


