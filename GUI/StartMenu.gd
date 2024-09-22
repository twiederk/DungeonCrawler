class_name StartMenu
extends Control

@onready var start_game_button: Button = $CenterContainer/VBoxContainer/StartGameButton


func _ready() -> void:
	if not OS.has_feature("editor"):
		get_window().mode = Window.MODE_EXCLUSIVE_FULLSCREEN	
	start_game_button.grab_focus()


func _on_start_game_button_pressed() -> void:
	PlayerStats.start_game()
	LevelStats.reset()
	get_tree().change_scene_to_file("res://World/Maps/HirschhornCastleMap.tscn")


func _on_quit_button_pressed() -> void:
	get_tree().quit()
