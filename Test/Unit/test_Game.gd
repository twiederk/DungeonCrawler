extends GutTest


var _sender = InputSender.new(Input)
var game: Game = null


func before_each():
	game = Game.new()


func after_each():
	game.free()
	_sender.release_all()
	_sender.clear()


func test_check_input_nothing():
	## arrange
	Input.flush_buffered_events()

	# act
	game.check_input()

	# assert
	assert_eq(game.character_pointer, 0, "Should stay with current creature when no input occurred")


func test_check_input_next():
	## arrange
	var nextCharacter = Character.new()
	game.characters = [Character.new(), nextCharacter]
	game.character_pointer = 0
	game.character = game.characters[game.character_pointer]

	_sender.action_down("next")
	Input.flush_buffered_events()

	# act
	game.check_input()

	# assert
	assert_eq(game.character_pointer, 1, "Should move to next creature when input next occurred")
	assert_eq(game.character, nextCharacter, "Should set next character to current when input next occurred")

	# tear down
	for character in game.characters:
		character.free()


func test_check_input_next_on_last_creature():
	# arrange
	var nextCharacter = Character.new()
	game.characters = [nextCharacter, Character.new()]
	game.character_pointer = 1
	game.character = game.characters[game.character_pointer]

	_sender.action_down("next")
	Input.flush_buffered_events()

	# act
	game.check_input()

	# assert
	assert_eq(game.character_pointer, 0, "Should move to first creature when end of creature array is reached")
	assert_eq(game.character, nextCharacter, "Should set first character to current when input next occurred")

	# tear down
	for character in game.characters:
		character.free()

