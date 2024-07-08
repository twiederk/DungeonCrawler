class_name Item
extends Area2D

signal item_picked_up

const ItemPickupScreenScene = preload("res://World/Items/ItemPickupScreen.tscn")

@export var item_resource: ItemResource

@onready var sprite_2d = $Sprite2D


func _ready():
	sprite_2d.texture = item_resource.texture


func _on_area_entered(area):
	if area is Character or area is Avatar:
		if not get_tree().current_scene is Battle:
			LevelStats.node_visited.emit(get_path())
		var item_pickup_screen = ItemPickupScreenScene.instantiate()
		get_tree().current_scene.add_child(item_pickup_screen)
		item_pickup_screen.add_slot(self)
		item_picked_up.emit(self)
		queue_free()


func get_item_name() -> String:
	return item_resource.name


func get_texture() -> Texture2D:
	return item_resource.texture


