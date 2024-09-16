extends GutTest


var battle: Battle = null


func before_each():
	battle = Battle.new()


func after_each():
	battle.free()


func test_is_battle_end_monsters_killed():

	# arrange
	battle.battlefield = Battlefield.new()
	var character = CharacterBattler.new()
	battle.battlefield.characters = [character]
	battle.battlefield.monsters = []

	# act
	var battle_end: bool = battle.is_battle_end()

	# assert
	assert_true(battle_end, "Should end battle when monsters are killed")
	
	# tear down
	battle.battlefield.free()
	character.free()


func test_is_battle_end_characters_killed():

	# arrange
	battle.battlefield = Battlefield.new()
	battle.battlefield.characters = []
	var monster = MonsterBattler.new()
	battle.battlefield.monsters = [monster]

	# act
	var battle_end: bool = battle.is_battle_end()

	# assert
	assert_true(battle_end, "Should end battle when characters are killed")
	
	# tear down
	battle.battlefield.free()
	monster.free()


func test_is_battle_end_monsters_alive():

	# arrange
	battle.battlefield = Battlefield.new()
	var character = CharacterBattler.new()
	battle.battlefield.characters = [character]
	var monster = MonsterBattler.new()
	battle.battlefield.monsters = [monster]
	

	# act
	var battle_end = battle.is_battle_end()

	# assert
	assert_false(battle_end, "Should continue battle when monsters and characters are alive")

	# tear down
	battle.battlefield.free()
	character.free()
	monster.free()
