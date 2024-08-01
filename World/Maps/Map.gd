class_name Map
extends Node2D

@onready var avatar: Avatar = $Avatar
@onready var tile_map: TileMap = $TileMap
@onready var map_borders: MapBorders = $MapBorders
@onready var items_node: Node2D = $Items


func _ready():
	Dialogic.signal_event.connect(_on_dialogic_signal)
	remove_visited_nodes()
	set_camera_limits()
	set_map_borders()


	for item in items_node.get_children():
		item.item_picked_up.connect(_on_item_picked_up)


func remove_visited_nodes():
	var visited_nodes = LevelStats.get_visited_nodes()
	for node_path in visited_nodes:
		var visited_node = get_node_or_null(node_path)
		visited_node.queue_free()


func set_camera_limits():
	var tile_map_used_rect: Rect2 = tile_map.get_used_rect()
	var limits: Vector2 = tile_map_used_rect.size * tile_map.cell_quadrant_size
	avatar.set_camera_limits(limits)


func set_map_borders():
	var tile_map_used_rect = tile_map.get_used_rect()
	var limits: Vector2 = tile_map_used_rect.size * tile_map.cell_quadrant_size
	map_borders.configure_borders(limits)


func unpause():
	get_tree().paused = false


func _on_dialogic_signal(argument: String):
	pass


func _on_item_picked_up(item: Item, character_stats: CreatureStats):
	character_stats.inventory.add_item(item.item_resource)
	var message = character_stats.name + " hat " + item.get_item_name() + " aufgenommen."
	MessageBus.message_send.emit(message)
