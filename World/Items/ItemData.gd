class_name ItmData
extends Node

@export var items: Dictionary

var _weapon_data: WeaponData = WeaponData.new()
var _armor_data: ArmorData = ArmorData.new()
var _spell_data: SpellData = SpellData.new()


func _ready():
	_weapon_data.init()
	_armor_data.init()
	_spell_data.init()


func get_weapon(id: int) -> WeaponResource:
	return _weapon_data.get_weapon(id)


func get_armor(id: int) -> ArmorResource:
	return _armor_data.get_armor(id)


func get_spell(id: int) -> SpellResource:
	return _spell_data.get_spell((id))
