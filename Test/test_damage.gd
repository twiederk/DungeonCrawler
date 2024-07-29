extends GutTest

var damage: Damage = Damage.new()


func test_roll():
	# arrange
	seed(1)
	damage.number_of_dice = 2
	damage.die = DiceBox.Die.D6
	
	# act
	var result = damage.roll()
	
	# assert
	assert_eq(result, 5)


func test_to_String():
	# arrange
	damage.number_of_dice = 2
	damage.die = DiceBox.Die.D6

	# act
	var result = damage.to_string()
	
	# assert
	assert_eq(result, "2W6")
