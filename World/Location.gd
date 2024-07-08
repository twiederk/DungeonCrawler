class_name Location
extends Area2D

@export var scene_name: String
@export var start_position: Vector2 = Vector2.ZERO


func _on_area_entered(_area):
	call_deferred("_change_scene")


func _change_scene():
	var scene_to_load = str("res://World/Maps/", scene_name, ".tscn")
	PlayerStats.start_position = start_position
	get_tree().change_scene_to_file(scene_to_load)
	LevelStats.set_current_level(scene_name)
