extends GutTest


var battle: Battle = null


func before_each():
	battle = Battle.new()


func after_each():
	battle.free()


func test_is_battle_end_monsters_killed():

	# arrange
	var character = Character.new()
	battle.characters = [character]
	battle.monsters = []

	# act
	var battle_end = battle.is_battle_end()

	# assert
	assert_true(battle_end, "Should end battle when monsters are killed")
	
	# tear down
	character.free()


func test_is_battle_end_characters_killed():

	# arrange
	battle.characters = []
	var monster = Monster.new()
	battle.monsters = [monster]

	# act
	var battle_end = battle.is_battle_end()

	# assert
	assert_true(battle_end, "Should end battle when characters are killed")
	
	# tear down
	monster.free()


func test_is_battle_end_monsters_alive():

	# arrange
	var character = Character.new()
	battle.characters = [character]
	var monster = Monster.new()
	battle.monsters = [monster]
	

	# act
	var battle_end = battle.is_battle_end()

	# assert
	assert_false(battle_end, "Should continue battle when monsters and characters are alive")

	# tear down
	character.free()
	monster.free()


func test_get_battlefield():
	# arrange
	var character = Character.new()
	character.position = Vector2(16, 16)
	battle.characters = [character]
	
	var monster = Monster.new()
	monster.position = Vector2(32, 32)
	battle.monsters = [monster]
	
	# act
	var battlefield = battle.get_battlefield()
	
	# assert
	assert_eq(battlefield.width, 20)
	assert_eq(battlefield.height, 12)
	assert_eq(battlefield.character_positions, [Vector2(1, 1)])
	assert_eq(battlefield.monster_positions, [Vector2(2, 2)])

	# tear down
	character.free()
	monster.free()
