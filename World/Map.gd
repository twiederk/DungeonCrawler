class_name Map
extends Node2D

@onready var avatar = $Avatar
@onready var tile_map = $TileMap


func _ready():
	remove_visited_nodes()
	set_camera_limits()


func remove_visited_nodes():
	var visited_nodes = LevelStats.get_visited_nodes()
	for node_path in visited_nodes:
		var visited_node = get_node_or_null(node_path)
		visited_node.queue_free()


func set_camera_limits():
	var tile_map_used_rect = tile_map.get_used_rect()
	var limits = tile_map_used_rect.size * tile_map.cell_quadrant_size
	avatar.set_camera_limits(limits)


func unpause():
	get_tree().paused = false

