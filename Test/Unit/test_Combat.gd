extends GutTest


var combat: Combat = null


func before_each():
	combat = Combat.new()


func after_each():
	combat.free()


func test_is_combat_end_monsters_killed():

	# arrange
	var character = Character.new()
	combat.characters = [character]
	combat.monsters = []

	# act
	var combat_end = combat.is_combat_end()

	# assert
	assert_true(combat_end, "Should end combat when monsters are killed")
	
	# tear down
	character.free()


func test_is_combat_end_characters_killed():

	# arrange
	combat.characters = []
	var monster = Monster.new()
	combat.monsters = [monster]

	# act
	var combat_end = combat.is_combat_end()

	# assert
	assert_true(combat_end, "Should end combat when characters are killed")
	
	# tear down
	monster.free()


func test_is_combat_end_monsters_alive():

	# arrange
	var character = Character.new()
	combat.characters = [character]
	var monster = Monster.new()
	combat.monsters = [monster]
	

	# act
	var combat_end = combat.is_combat_end()

	# assert
	assert_false(combat_end, "Should continue combat when monsters and characters are alive")

	# tear down
	character.free()
	monster.free()


func test_get_battlefield():
	# arrange
	var character = Character.new()
	character.position = Vector2(16, 16)
	combat.characters = [character]
	
	var monster = Monster.new()
	monster.position = Vector2(32, 32)
	combat.monsters = [monster]
	
	# act
	var battlefield = combat.get_battlefield()
	
	# assert
	assert_eq(battlefield.width, 20)
	assert_eq(battlefield.height, 12)
	assert_eq(battlefield.character_positions, [Vector2(1, 1)])
	assert_eq(battlefield.monster_positions, [Vector2(2, 2)])

	# tear down
	character.free()
	monster.free()
