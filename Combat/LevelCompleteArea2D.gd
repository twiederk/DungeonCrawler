class_name LevelCompleteArea2D
extends Area2D

signal level_completed

func _on_LevelComplete_body_entered(body: Character) -> void:
	var scene_to_load = str("res://World/Neckartal.tscn")
	get_tree().change_scene_to_file(scene_to_load)
	
	
#	#warning-ignore:RETURN_VALUE_DISCARDED
#	level_completed.connect(body._on_Level_Completed, CONNECT_ONE_SHOT)
#	level_completed.emit()
#	queue_free()
