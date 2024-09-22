class_name BattleEndScreen
extends Control

@onready var battle_end_label: Label = $BattleEndPanel/BattleEndLabel
@onready var continue_button: Button = $BattleEndPanel/ContinueButton

var _battle_lost: bool = false


func show_message(message: String):
	battle_end_label.text = message
	continue_button.grab_focus()
	show()


func set_battle_lost(battle_lost: bool):
	_battle_lost = battle_lost


func _on_continue_button_pressed():
	var scene_to_load = _get_scene_to_load()
	get_tree().change_scene_to_file(scene_to_load)


func _get_scene_to_load():
	if _battle_lost:
		return "res://GUI/StartGUI.tscn"
	var map = LevelStats.get_current_level()
	return str("res://World/Maps/", map, ".tscn")
