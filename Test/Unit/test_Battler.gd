extends GutTest

var battler: Battler = null

func before_each():
	battler = Battler.new()


func after_each():
	battler.free()


func test_get_creature():
	# act
	var creature = battler.get_creature()

	# assert
	assert_not_null(creature)


func test_get_set_name():

	# assert
	assert_accessors(battler, "creature_name", "", "myName")


func test_get_set_hit_points():

	# assert
	assert_accessors(battler, "hit_points", 0, 10)


func test_get_set_armor_class():

	# assert
	assert_accessors(battler, "armor_class", 0, 10)


func test_get_set_damage():

	# assert
	assert_accessors(battler, "damage", 0, 1)


func test_get_set_movement():

	# assert
	assert_accessors(battler, "movement", 4, 1)


func test_get_set_max_movement():

	# assert
	assert_accessors(battler, "max_movement", 4, 1)


func test_roll_attack():

	# arrange
	seed(1)

	# act
	var result = battler.roll_attack()

	# assert
	assert_eq(result, 18, "Should roll attack of 10 when no bonus applied")




func test_step():

	# arrange
	battler.set_movement(4)

	# act
	battler.step()

	# assert
	assert_eq(battler.get_movement(), 3, "Should decrease movement by 1 when creature does a step")


func test_start_turn():

	# arrange
	battler._combat_state = Battler.CombatState.DONE
	battler.set_movement(0)
	battler.turn_indicator = Node2D.new()

	# act
	battler.start_turn(Battlefield.new())

	# assert
	assert_eq(battler.get_movement(), 4, "Should set movement to max movement when combat round starts")
	assert_eq(battler._combat_state, Battler.CombatState.READY, "Should set combat state to READY when combat round starts")

	# tear down
	battler.turn_indicator.free()
