class_name ItmData
extends Node

@export var items: Dictionary

var _weapon_data: WeaponData = WeaponData.new()
var _armor_data: ArmorData = ArmorData.new()


func _ready():
	_weapon_data.init()
	_armor_data.init()


func get_weapon(id: int) -> WeaponResource:
	return _weapon_data.get_weapon(id)


func get_armor(id: int) -> ArmorResource:
	return _armor_data.get_armor(id)
