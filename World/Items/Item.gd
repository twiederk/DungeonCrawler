class_name Item
extends Area2D

signal item_picked_up(item: Item, character_name: String)


@export var item_resource: ItemResource

@onready var sprite_2d = $Sprite2D


func _ready():
	sprite_2d.texture = item_resource.texture


func _on_area_entered(area):
	if area is Character or area is Avatar:
		if not get_tree().current_scene is Battle:
			LevelStats.node_visited.emit(get_path())
		var character_name = PlayerStats.character_stats[0].name
		if area is Character:
			var character = area as Character
			character_name = character.get_creature_name()
		item_picked_up.emit(self, character_name)
		queue_free()


func get_item_name() -> String:
	return item_resource.name


func get_texture() -> Texture2D:
	return item_resource.texture


