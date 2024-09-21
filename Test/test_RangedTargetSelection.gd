extends GutTest

var ranged_target_selection = null


func before_each():
	ranged_target_selection = RangedTargetSelection.new()


func after_each():
	ranged_target_selection.free()

# -----
# -cm--
# ----m
func test_get_selectable_targets():
	# arrange
	var monster1 = MonsterBattler.new()
	monster1.position = Vector2(64, 32)
	var monster2 = MonsterBattler.new()
	monster2.position = Vector2(96, 160)
	var monsters = [monster1, monster2] as Array[Battler]

	var weapon = WeaponResource.new()
	weapon.range = 100

	var character = CharacterBattler.new()
	character.position = Vector2(32, 32)
	character.set_weapon(weapon)

	# act
	var selectable_targets = ranged_target_selection.get_selectable_targets(character, monsters)
	
	# assert
	assert_eq(selectable_targets.size(), 2, "Should return two selectable targets")

	# tear down
	monster1.free()
	monster2.free()
	character.free()


# c--
# -m-
func test_get_selectable_targets_in_range():
	# arrange
	var monster = MonsterBattler.new()
	monster.position = Vector2(32, 32)
	var monsters = [monster] as Array[Battler]

	var weapon = WeaponResource.new()
	weapon.range = 2

	var character = CharacterBattler.new()
	character.position = Vector2(0, 0)
	character.set_weapon(weapon)

	# act
	var selectable_targets = ranged_target_selection.get_selectable_targets(character, monsters)
	
	# assert
	assert_eq(selectable_targets.size(), 1, "Should return one selectable targets in range")

	# tear down
	monster.free()
	character.free()


# c--
# ---
# --m
func test_get_selectable_targets_out_of_range():
	# arrange
	var monster = MonsterBattler.new()
	monster.position = Vector2(64, 64)
	var monsters = [monster] as Array[Battler]

	var weapon = WeaponResource.new()
	weapon.range = 2

	var character = CharacterBattler.new()
	character.position = Vector2(0, 0)
	character.set_weapon(weapon)
	

	# act
	var selectable_targets = ranged_target_selection.get_selectable_targets(character, monsters)
	
	# assert
	assert_eq(selectable_targets.size(), 0, "Should return zero selectable targets, because target is out of range")

	# tear down
	monster.free()
	character.free()
