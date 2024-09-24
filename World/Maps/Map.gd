class_name Map
extends Node2D

@onready var avatar: Avatar = $Avatar
@onready var tile_map: TileMapLayer = $TileMapLayer
@onready var map_borders: MapBorders = $MapBorders
@onready var items_node: Node2D = $Items


func _ready():
	Dialogic.signal_event.connect(_on_dialogic_signal)
	_remove_visited_nodes()
	_set_camera_limits()
	_set_map_borders()
	_register_key_controls()

	for item in items_node.get_children():
		item.item_picked_up.connect(_on_item_picked_up)


func _remove_visited_nodes():
	var visited_nodes = LevelStats.get_visited_nodes()
	for node_path in visited_nodes:
		var visited_node = get_node_or_null(node_path)
		visited_node.queue_free()


func _set_camera_limits():
	var tile_map_used_rect: Rect2 = tile_map.get_used_rect()
	var limits: Vector2 = tile_map_used_rect.size * tile_map.rendering_quadrant_size
	avatar.set_camera_limits(limits)


func _set_map_borders():
	var tile_map_used_rect = tile_map.get_used_rect()
	var limits: Vector2 = tile_map_used_rect.size * tile_map.rendering_quadrant_size
	map_borders.configure_borders(limits)


func _register_key_controls():
	var key_controls: Array[KeyControl] = [
		KeyControl.new("Pfeiltasten", "Bewegung"),
		KeyControl.new("1-2", "Characterbogen"),
		KeyControl.new("r", "Reden"),
		KeyControl.new("h", "Hilfe")
	]
	MessageBus.key_control_registerd.emit(key_controls)


func unpause():
	get_tree().paused = false


@warning_ignore("unused_parameter")
func _on_dialogic_signal(argument: String):
	pass


func _on_item_picked_up(item: Item, character_stats: CreatureStats):
	character_stats.inventory.add_item(item.item_resource)
	var message = character_stats.name + " hat " + item.get_item_name() + " aufgenommen."
	MessageBus.message_send.emit(message)
