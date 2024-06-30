class_name BattleEndScreen
extends Panel

@onready var battle_end_label = $BattleEndLabel
@onready var continue_button = $ContinueButton


func show_message(message: String):
	battle_end_label.text = message
	continue_button.grab_focus()
	show()


func _on_continue_button_pressed():
	var map = LevelStats.get_current_level()
	var scene_to_load = str("res://World/Maps/", map, ".tscn")
	get_tree().change_scene_to_file(scene_to_load)
