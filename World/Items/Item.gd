class_name Item
extends Area2D

signal item_picked_up(item: Item, character_stats: CreatureStats)


@export var item_resource: ItemResource

@onready var sprite_2d = $Sprite2D


func _ready():
	sprite_2d.texture = item_resource.texture


func _on_area_entered(area):
	if area is CharacterBattler or area is Avatar:
		if not get_tree().current_scene is Battle:
			LevelStats.node_visited.emit(get_path())
		var character_stats = PlayerStats.character_stats[0]
		if area is CharacterBattler:
			var character = area as CharacterBattler
			character_stats = character.get_creature()
		item_picked_up.emit(self, character_stats)
		queue_free()


func get_item_name() -> String:
	return item_resource.name


func get_texture() -> Texture2D:
	return item_resource.texture
