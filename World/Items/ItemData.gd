class_name ItmData
extends Node

@export var items: Dictionary


func _ready():
	items = {
		"0": load("res://World/Items/Weapons/Sword.tres"),
		"1": load("res://World/Items/Weapons/Axe.tres"),
		"2": load("res://World/Items/Armor/Cloth.tres"),
	}

func get_item(id: String) -> ItemResource:
	return items[id]
