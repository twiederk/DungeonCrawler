class_name Encounter
extends Area2D

@export var monsters: Array[MonsterResource] = []


func _on_area_entered(area):
	PlayerStats.start_position = area.position
	PlayerStats.monsters = monsters
	LevelStats.node_visited.emit(get_path())
	queue_free()
	call_deferred("_change_scene")


func _change_scene():
	get_tree().change_scene_to_file("res://Battle/Battle.tscn")
