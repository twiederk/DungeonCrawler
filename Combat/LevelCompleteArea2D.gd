class_name LevelCompleteArea2D
extends Area2D

signal level_completed

func _on_LevelComplete_body_entered(body: CharacterBody) -> void:
	#warning-ignore:RETURN_VALUE_DISCARDED
	level_completed.connect(body._on_Level_Completed, CONNECT_ONE_SHOT)
	level_completed.emit()
	queue_free()
