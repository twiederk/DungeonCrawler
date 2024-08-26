extends GutTest

const BattleScene = preload("res://Battle/Battle.tscn")

var battle: Battle = null


func before_each():
	battle = BattleScene.instantiate()
	add_child(battle)


func after_each():
	battle.free()


func test_get_battlefield():
	# arrange
	var character = CharacterBattler.new()
	character.position = Vector2(32, 32)
	battle.characters = [character]
	
	var monster = MonsterBattler.new()
	monster.position = Vector2(64, 64)
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
