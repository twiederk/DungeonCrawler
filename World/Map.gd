class_name Map
extends Node2D


func _ready():
	var visited_nodes = LevelStats.get_visited_nodes()
	for node_path in visited_nodes:
		var visited_node = get_node_or_null(node_path)
		visited_node.queue_free()

