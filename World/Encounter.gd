class_name Encounter
extends Area2D


func _on_body_entered(body):
	PlayerStats.start_position = body.position
	LevelStats.node_visited.emit(get_path())
	queue_free()
	get_tree().change_scene_to_file("res://Combat/Combat.tscn")
