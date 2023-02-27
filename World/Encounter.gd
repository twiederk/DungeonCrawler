class_name Encounter
extends Area2D


func _on_body_entered(body):
	PlayerStats.start_position = body.position + Vector2(-16, 0)
	get_tree().change_scene_to_file("res://Combat/Combat.tscn")
