extends GutTest

var creature: Creature = null

func before_each():
	creature = Creature.new()


func test_get_set_name():

	# assert
	assert_accessors(creature, "name", "", "myName")


func test_get_set_hit_points():

	# assert
	assert_accessors(creature, "hit_points", 0, 10)


func test_get_set_armor_class():

	# assert
	assert_accessors(creature, "armor_class", 0, 10)


func test_get_set_damage():

	# assert
	assert_accessors(creature, "damage", 0, 1)


func test_get_set_movement():

	# assert
	assert_accessors(creature, "movement", 4, 1)


func test_get_set_max_movement():

	# assert
	assert_accessors(creature, "max_movement", 4, 1)


func test_get_set_combat_state():

	#assert
	assert_accessors(creature, "combat_state", Creature.CombatState.READY, Creature.CombatState.DONE)

func test_roll_attack():

	# arrange
	seed(1)

	# act
	var result = creature.roll_attack()

	# assert
	assert_eq(result, 18, "Should roll attack of 10 when no bonus applied")


func test_hurt():
	# arrange
	creature.set_hit_points(10)
	watch_signals(creature)

	# act
	creature.hurt(3)

	# assert
	assert_eq(creature.get_hit_points(), 7, "Should reduce damage from hit point when got hurt")
	assert_signal_emitted(creature, "got_hurt")


func test_step():

	# arrange
	creature.set_movement(4)

	# act
	creature.step()

	# assert
	assert_eq(creature.get_movement(), 3, "Should decrease movement by 1 when creature does a step")


func test_can_move_movement_left():

	# arrange
	creature.set_movement(1)

	# act
	var can_move = creature.can_move()

	# assert
	assert_true(can_move, "Should allow move when movement left")


func test_can_move_movement_gone():

	# arrange
	creature.set_movement(0)

	# act
	var can_move = creature.can_move()

	# assert
	assert_false(can_move, "Should deny move when movement gone")


func test_is_done_false():

	# arrange
	creature.set_combat_state(Creature.CombatState.READY)

	# act
	var done = creature.is_done()

	# assert
	assert_false(done, "Should not be done in CombatState.READY")


func test_is_done_true():

	# arrange
	creature.set_combat_state(Creature.CombatState.DONE)

	# act
	var done = creature.is_done()

	# assert
	assert_true(done, "Should be done in CombatState.DONE")


func test_attack():

	# act
	creature.attack()

	# assert
	assert_true(creature.is_done(), "Should be done when creature attacked")


func test_start_combat_round():

	# arrange
	creature.set_combat_state(Creature.CombatState.DONE)
	creature.set_movement(0)

	# act
	creature.start_combat_round()

	# assert
	assert_eq(creature.get_movement(), 4, "Should set movement to max movement when combat round starts")
	assert_eq(creature.get_combat_state(), Creature.CombatState.READY, "Should set combat state to READY when combat round starts")


