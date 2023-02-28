class_name LevelCompleteArea2D
extends Area2D

signal level_completed

func _on_LevelComplete_body_entered(_body: Character) -> void:
	var scene_to_load = str("res://World/Neckartal.tscn")
	get_tree().change_scene_to_file(scene_to_load)

