extends GutTest
	
	
func test_create_melee_target_selection():
	
	# act
	var target_selection = TargetSelectionFactory.create_target_selection(WeaponResource.WeaponType.MELEE_WEAPON)
	
	# assert
	assert_true(target_selection is MeleeTargetSelection, "Should create MeleeTargetSelection for melee weapons.")
	
	# tear down
	target_selection.free()
	
	
func test_create_ranged_target_selection():
	
	# act
	var target_selection = TargetSelectionFactory.create_target_selection(WeaponResource.WeaponType.RANGED_WEAPON)
	
	# assert
	assert_true(target_selection is RangedTargetSelection, "Should create RangedTargetSelection for ranged weapons.")

	# tear down
	target_selection.free()
