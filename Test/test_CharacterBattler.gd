extends GutTest

var character: CharacterBattler = null


func before_each():
	character = CharacterBattler.new()


func after_each():
	character.free()


func test_move_step():

	# arrange
	character.set_movement(0)

	# act
	character.move_step(Vector2.RIGHT)

	# assert
	var creature = character.get_creature()
	assert_eq(creature.movement, 1, "Should make a step when character moves")


func test_can_move_movement_left():

	# arrange
	var ray_cast = RayCast2D.new()
	character.set_movement(1)
	character.set_max_movement(4)

	# act
	var can_move = character.can_move(ray_cast)

	# assert
	assert_true(can_move, "Should allow move when movement left")
	
	# tear down
	ray_cast.free()


func test_can_move_movement_gone():

	# arrange
	var ray_cast = RayCast2D.new()
	character.set_movement(0)

	# act
	var can_move = character.can_move(ray_cast)

	# assert
	assert_false(can_move, "Should deny move when movement gone")
	
	# tear down
	ray_cast.free()
