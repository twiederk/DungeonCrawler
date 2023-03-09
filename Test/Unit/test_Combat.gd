extends GutTest


var combat: Combat = null


func before_each():
	combat = Combat.new()


func after_each():
	combat.free()


func test_check_input_nothing():
	# arrange
	Input.flush_buffered_events()

	# act
	combat.check_input()

	# assert
	assert_eq(combat.character_pointer, 0, "Should stay with current creature when no input occurred")


func test_is_combat_end_monsters_killed():

	# arrange
	combat.monsters = []

	# act
	var combat_end = combat.is_combat_end()

	# assert
	assert_true(combat_end, "Should end combat when monsters are killed")


func test_is_combat_end_monsters_alive():

	# arrange
	var monster = Monster.new()
	combat.monsters = [monster]

	# act
	var combat_end = combat.is_combat_end()

	# assert
	assert_false(combat_end, "Should continue combat when monsters are alive")

	# tear down
	monster.free()


func test_check_combat_round_continue_round():

	# arrange
	var character1 = _create_Character_with_creature_and_movement_zero()
	var character2 = _create_Character_with_creature_and_movement_zero()

	combat.characters = [character1, character2]
	combat.character_pointer = 0

	# act
	combat.check_combat_round()

	# assert
	assert_eq(character1.get_creature().get_movement(), 0, "Should leave movement untouched when combat round continues")
	assert_eq(character2.get_creature().get_movement(), 0, "Should leave movement untouched when combat round continues")

	# tear down
	character1.free()
	character2.free()


func test_check_combat_round_new_round():

	# arrange
	var character1 = _create_Character_with_creature_and_movement_zero()
	var character2 = _create_Character_with_creature_and_movement_zero()

	combat.characters = [character1, character2]
	combat.character_pointer = 1

	# act
	combat.check_combat_round()

	# assert
	assert_eq(character1.get_creature().get_movement(), 4, "Should set movement to max_movement when new combat round starts")
	assert_eq(character2.get_creature().get_movement(), 4, "Should set movement to max_movement when new combat round starts")

	# tear down
	character1.free()
	character2.free()


func _create_Character_with_creature_and_movement_zero() -> Character:
	var creature = Creature.new()
	creature.set_movement(0)
	var character = Character.new()
	character._creature = creature
	return character


func test_is_new_combat_round_true():

	# arrange
	var character1 = Character.new()
	var character2 = Character.new()
	combat.characters = [character1, character2]
	combat.character_pointer = 1

	# act
	var new_combat_round = combat.is_new_combat_round()

	# assert
	assert_true(new_combat_round, "Should be new combat round when is last character")

	# tear down
	character1.free()
	character2.free()


func test_is_new_combat_round_false():

	# arrange
	var character1 = Character.new()
	var character2 = Character.new()
	combat.characters = [character1, character2]
	combat.character_pointer = 0

	# act
	var new_combat_round = combat.is_new_combat_round()

	# assert
	assert_false(new_combat_round, "Should not be new combat round when it is not the last character")

	# tear down
	character1.free()
	character2.free()


func test_process_combat_state_ready():

	# arrange
	var character1 = Character.new()
	var character2 = Character.new()
	combat.characters = [character1, character2]
	combat.character_pointer = 0
	combat.character = combat.characters[combat.character_pointer]

	# act
	combat._process(1.0)

	# assert
	assert_eq(combat.character_pointer, 0, "Should stay at current character when character is not done")

	# tear down
	character1.free()
	character2.free()


func test_process_combat_state_done():

	# arrange
	var character1 = Character.new()
	character1.get_creature().set_combat_state(Creature.CombatState.DONE)
	var character2 = Character.new()
	combat.characters = [character1, character2]
	combat.character_pointer = 0
	combat.character = combat.characters[combat.character_pointer]
	var monster = Monster.new()
	combat.monsters = [monster]

	# act
	combat._process(1.0)

	# assert
	assert_eq(combat.character_pointer, 1, "Should continue with next character when character is done")

	# tear down
	character1.free()
	character2.free()
	monster.free()


func test_start_combat_round():

	# arrange
	var character1 = _create_Character_with_creature_and_movement_zero()
	character1.get_creature().set_combat_state(Creature.CombatState.DONE)
	var character2 = _create_Character_with_creature_and_movement_zero()
	character1.get_creature().set_combat_state(Creature.CombatState.DONE)
	combat.characters = [character1, character2]

	# act
	combat.start_combat_round()

	# assert
	var creature1 = character1.get_creature()
	assert_eq(creature1.get_movement(), 4, "Should reset movement of creature1")
	assert_eq(creature1.get_combat_state(), Creature.CombatState.READY, "Should reset combat state of creature1")
	var creature2 = character2.get_creature()
	assert_eq(creature2.get_movement(), 4, "Should reset movement of creature2")
	assert_eq(creature2.get_combat_state(), Creature.CombatState.READY, "Should reset combat state of creature2")

	# tear down
	character1.free()
	character2.free()

