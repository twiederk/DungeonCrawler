extends GutTest

const BattlefieldScene = preload("res://Battle/Battlefield.tscn")

var battlefield: Battlefield = null


func before_each():
	battlefield = BattlefieldScene.instantiate()
	add_child(battlefield)


func after_each():
	battlefield.free()


func test_place_characters():
	# arrange
	var character1 = CharacterBattler.new()
	var character2 = CharacterBattler.new()
	var characters: Array[Battler] = [ character1, character2 ]
	
	# act
	battlefield.place_characters(characters)
	
	# assert
	assert_eq(character1.position,  Vector2(240, 176))
	assert_eq(character2.position,  Vector2(240, 208))
	
	# tear down
	character1.free()
	character2.free()


func test_place_monsters():
	# arrange
	var monster1 = MonsterBattler.new()
	var monster2 = MonsterBattler.new()
	var monsters: Array[Battler] = [ monster1, monster2 ]
	
	# act
	battlefield.place_monsters(monsters)
	
	# assert
	assert_eq(monster1.position,  Vector2(336, 176))
	assert_eq(monster2.position,  Vector2(336, 208))
	
	# tear down
	monster1.free()
	monster2.free()

