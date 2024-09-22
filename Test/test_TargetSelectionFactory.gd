extends GutTest
	
	
func test_create_selection():
	
	# act
	var target_selection = TargetSelectionFactory.create_target_selection()
	
	# assert
	assert_true(target_selection is RangedTargetSelection, "Should create RangedTargetSelection.")
	
	# tear down
	target_selection.free()
