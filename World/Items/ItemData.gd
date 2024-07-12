class_name ItmData
extends Node

@export var items: Dictionary

var _weapon_data = WeaponData.new()


func _ready():
	_weapon_data.init()
	PlayerStats.load_characters()


func get_weapon(id: int) -> WeaponResource:
	return _weapon_data.get_weapon(id)
