class_name BattleEndScreen
extends Control

@onready var battle_end_label = $BattleEndPanel/BattleEndLabel
@onready var continue_button = $BattleEndPanel/ContinueButton


func show_message(message: String):
	battle_end_label.text = message
	continue_button.grab_focus()
	show()


func _on_continue_button_pressed():
	var map = LevelStats.get_current_level()
	var scene_to_load = str("res://World/Maps/", map, ".tscn")
	get_tree().change_scene_to_file(scene_to_load)
