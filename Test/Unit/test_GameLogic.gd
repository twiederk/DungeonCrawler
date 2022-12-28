extends GutTest

const texture1 = preload("res://World/Knight_01.png")
const texture2 = preload("res://World/Knight_02.png")

var _sender = InputSender.new(Input)
var game_logic: GameLogic = null


func before_each():
	game_logic = GameLogic.new()
	
	
func after_each():
	game_logic.free()
	_sender.release_all()
	_sender.clear()


func test_create_character():
	# act
	var character = game_logic.create_character(texture1, Vector2(64, 64))

	# assert
	assert_not_null(character, "Should create one character")
	assert_eq(character.get_node("Sprite").texture, texture1, "Should have given texture")
	assert_eq(character.position, Vector2(64, 64), "Should have correct position")

	
func test_create_characters():
	# act
	var characters = game_logic.create_characters([texture1, texture2])
	
	# assert
	assert_eq(characters.size(), 2, "Should create two characters when two textures are given")
	assert_eq(characters[0].position, Vector2(32, 32), "Should place 1st charater at (32, 32)")
	assert_eq(characters[1].position, Vector2(64, 32), "Should place 1st charater at (32, 32)")


func test_check_input_nothing():
	## arrange
	Input.flush_buffered_events()
	
	# act
	game_logic.check_input()
	
	# assert
	assert_eq(game_logic.current_creature, 0, "Should stay with current creature when no input occurred")


func test_check_input_next():
	## arrange
	game_logic.creatures = [Character.new(), Character.new()]
	game_logic.current_creature = 0

	_sender.action_down('next')
	Input.flush_buffered_events()	
	
	# act
	game_logic.check_input()
	
	# assert
	assert_eq(game_logic.current_creature, 1, "Should move to next creature when input next occurred")
	
	
func test_check_input_next_on_last_creature():
	## arrange
	game_logic.creatures = [Character.new(), Character.new()]
	game_logic.current_creature = 1
	
	_sender.action_down('next')
	Input.flush_buffered_events()	
	
	# act
	game_logic.check_input()
	
	# assert
	assert_eq(game_logic.current_creature, 0, "Should move to first creature when end of creature array is reached")
	


