extends GutTest


func test_roll_single_d20():
	# arrange
	seed(1)
	
	# act
	var result = DiceBox.roll(DiceBox.Die.D20)
	
	# assert
	assert_eq(result, 18)


func test_roll_many_d20():
	# arrange
	seed(1)
	
	# act
	var result = DiceBox.roll(DiceBox.Die.D20, 2)
	
	# assert
	assert_eq(result, 27)
