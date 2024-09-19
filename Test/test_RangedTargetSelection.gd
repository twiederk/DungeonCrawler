extends GutTest

var ranged_target_selection = null


func before_each():
	ranged_target_selection = RangedTargetSelection.new()


func after_each():
	ranged_target_selection.free()


func test_get_selectable_targets():
	# arrange
	var monster1 = MonsterBattler.new()
	monster1.position = Vector2(64, 32)
	var monster2 = MonsterBattler.new()
	monster2.position = Vector2(160, 160)
	var monsters = [monster1, monster2] as Array[Battler]

	var character_position: Vector2 = Vector2(32, 32)

	# act
	var selectable_targets = ranged_target_selection.get_selectable_targets(character_position, monsters)
	
	# assert
	assert_eq(selectable_targets.size(), 2, "Should return two selectable targets")

	# tear down
	monster1.free()
	monster2.free()
