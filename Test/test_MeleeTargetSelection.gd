extends GutTest

var melee_target_selection = null


func before_each():
	melee_target_selection = MeleeTargetSelection.new()


func after_each():
	melee_target_selection.free()


func test_get_selectable_targets():
	# arrange
	var monster1 = MonsterBattler.new()
	monster1.position = Vector2(64, 32)
	var monster2 = MonsterBattler.new()
	monster2.position = Vector2(160, 160)
	var monsters = [monster1, monster2] as Array[Battler]

	var character = CharacterBattler.new()
	character.position = Vector2(32, 32)

	# act
	var selectable_targets = melee_target_selection.get_selectable_targets(character, monsters)
	
	# assert
	assert_eq(selectable_targets.size(), 1, "Should return one selectable target")

	# tear down
	monster1.free()
	monster2.free()
	character.free()
