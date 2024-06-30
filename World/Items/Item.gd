class_name Item
extends Area2D

const ItemPickupScene = preload("res://World/Items/ItemPickup.tscn")

@export var item_resource: Resource

@onready var sprite_2d = $Sprite2D


func _ready():
	sprite_2d.texture = item_resource.texture


func _on_body_entered(_body):
	var item_pickup_scene = ItemPickupScene.instantiate()
	get_tree().current_scene.add_child(item_pickup_scene)
	item_pickup_scene.add_slot(self)
	queue_free()


func get_item_name() -> String:
	return item_resource.name


func get_texture() -> Texture2D:
	return item_resource.texture
