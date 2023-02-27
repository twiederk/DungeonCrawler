extends GutTest

const LevelComplete = preload("res://Combat/LevelComplete.tscn")

var level_complete: LevelCompleteArea2D = null


func before_each():
	level_complete = LevelComplete.instantiate()


func after_each():
	level_complete.free()


func test_can_create_LevelComplete():
	# act
	var my_level_complete = LevelComplete.instantiate()

	# assert
	assert_not_null(my_level_complete)

	# tear down
	my_level_complete.free()


#func test_on_LevelComplete_body_entered():
#	# arrange
#	watch_signals(level_complete)
#	var character = Character.new()
#
#	# act
#	level_complete._on_LevelComplete_body_entered(character)
#
#	# assert
#	assert_signal_emitted(level_complete, "level_completed")
#
#	# tear down
#	character.free()
