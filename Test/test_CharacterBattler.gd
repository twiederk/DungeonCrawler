extends GutTest

var character: CharacterBattler = null


func before_each():
	character = CharacterBattler.new()


func after_each():
	character.free()


func test_move_step_during_battle():

	# arrange
	var monster = MonsterBattler.new()
	var battlefield = Battlefield.new()
	battlefield.monsters = [monster] as Array[Battler]
	character.set_battlefield(battlefield)
	character.set_movement(0)

	# act
	character.move_step(Vector2.RIGHT)

	# assert
	var creature = character.get_creature()
	assert_eq(creature.movement, 1, "Should increase movement when character moves during battle")
	
	# tear down
	monster.free()
	battlefield.free()


func test_move_step_after_battle():

	# arrange
	var battlefield = Battlefield.new()
	character.set_battlefield(battlefield)
	character.set_movement(0)

	# act
	character.move_step(Vector2.RIGHT)

	# assert
	var creature = character.get_creature()
	assert_eq(creature.movement, 0, "Should leave movement untouched when character moves after battle")
	
	# tear down
	battlefield.free()


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
