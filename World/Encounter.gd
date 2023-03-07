class_name Encounter
extends Area2D

@export var monsters: Array[MonsterResource] = []

func _on_body_entered(body):
	PlayerStats.start_position = body.position
	EncounterStats.monsters = monsters
	LevelStats.node_visited.emit(get_path())
	queue_free()
	get_tree().change_scene_to_file("res://Combat/Combat.tscn")
