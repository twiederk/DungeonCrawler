extends GutTest


var battleEndScreen: BattleEndScreen = null


func before_each():
	battleEndScreen = BattleEndScreen.new()


func after_each():
	battleEndScreen.free()


func test_get_battle_end_scene_with_battle_is_won():
	
	# act
	var scene_to_load = battleEndScreen._get_scene_to_load()
	
	# assert
	assert_eq(scene_to_load, "res://World/Maps/HirschhornCastleMap.tscn", "Should load map, when battle is won")


func test_get_battle_end_scene_with_battle_is_lost():
	# arrange
	battleEndScreen.set_battle_lost(true)
	
	# act
	var scene_to_load = battleEndScreen._get_scene_to_load()
	
	# assert
	assert_eq(scene_to_load, "res://GUI/StartGUI.tscn", "Should load start menu, when battle is lost")
