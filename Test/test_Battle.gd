extends GutTest


var battle: Battle = null


func before_each():
	battle = Battle.new()


func after_each():
	battle.free()


func test_is_battle_end_monsters_killed():

	# arrange
	var character = CharacterBattler.new()
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
	var monster = MonsterBattler.new()
	battle.monsters = [monster]

	# act
	var battle_end = battle.is_battle_end()

	# assert
	assert_true(battle_end, "Should end battle when characters are killed")
	
	# tear down
	monster.free()


func test_is_battle_end_monsters_alive():

	# arrange
	var character = CharacterBattler.new()
	battle.characters = [character]
	var monster = MonsterBattler.new()
	battle.monsters = [monster]
	

	# act
	var battle_end = battle.is_battle_end()

	# assert
	assert_false(battle_end, "Should continue battle when monsters and characters are alive")

	# tear down
	character.free()
	monster.free()
