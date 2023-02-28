extends GutTest


#var _sender = InputSender.new(Input)
var combat: Combat = null


func before_each():
	combat = Combat.new()


func after_each():
	combat.free()
#	_sender.release_all()
#	_sender.clear()


func test_check_input_nothing():
	## arrange
	Input.flush_buffered_events()

	# act
	combat.check_input()

	# assert
	assert_eq(combat.character_pointer, 0, "Should stay with current creature when no input occurred")


#func test_check_input_next():
#	## arrange
#	var nextCharacter = Character.new()
#	combat.characters = [Character.new(), nextCharacter]
#	combat.character_pointer = 0
#	combat.character = combat.characters[combat.character_pointer]
#
#	_sender.action_down("next")
#	Input.flush_buffered_events()
#
#	# act
#	combat.check_input()
#
#	# assert
#	assert_eq(combat.character_pointer, 1, "Should move to next creature when input next occurred")
#	assert_eq(combat.character, nextCharacter, "Should set next character to current when input next occurred")
#
#	# tear down
#	for character in combat.characters:
#		character.free()


#func test_check_input_next_on_last_creature():
#	# arrange
#	var nextCharacter = Character.new()
#	combat.characters = [nextCharacter, Character.new()]
#	combat.character_pointer = 1
#	combat.character = combat.characters[combat.character_pointer]
#
#	_sender.action_down("next")
#	Input.flush_buffered_events()
#
#	# act
#	combat.check_input()
#
#	# assert
#	assert_eq(combat.character_pointer, 0, "Should move to first creature when end of creature array is reached")
#	assert_eq(combat.character, nextCharacter, "Should set first character to current when input next occurred")
#
#	# tear down
#	for character in combat.characters:
#		character.free()


func test_sum_gold():
	var character1 = Character.new()
	character1._inventory.set_gold(5)

	var character2 = Character.new()
	character2._inventory.set_gold(7)

	combat.characters = [character1, character2]

	# act
	var sum_gold = combat.sum_gold()

	# assert
	assert_eq(sum_gold, 12, "Should sum up gold of characters to 12")

	# tear down
	for character in combat.characters:
		character.free()
