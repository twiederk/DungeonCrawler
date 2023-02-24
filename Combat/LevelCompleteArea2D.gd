class_name LevelCompleteArea2D
extends Area2D

signal level_completed

func _on_LevelComplete_body_entered(body: CharacterBody) -> void:
	#warning-ignore:RETURN_VALUE_DISCARDED
	connect("level_completed",Callable(body,"_on_Level_Completed").bind(),CONNECT_ONE_SHOT)
	emit_signal("level_completed")
	queue_free()
