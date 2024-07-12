class_name WeaponData
extends RefCounted

var _weapon_dictionary = {}


func _parse_weapon(line: PackedStringArray) -> WeaponResource:
	var weapon = WeaponResource.new()
	weapon.id = line[0].to_int()
	weapon.name = line[1]
	
	var damage = Damage.new()
	damage.number_of_dice = line[2]
	damage.die = line[3]
	weapon.damage = damage
	
	weapon.texture = load("res://Assets/graphics/sprites/items/weapons/" + line[4])
	
	return weapon


func _load_weapons(file_name: String) -> Array[WeaponResource]:
	var weapons: Array[WeaponResource] = []
	var file: FileAccess = FileAccess.open(file_name, FileAccess.READ)
	file.get_csv_line(";")
	var line: PackedStringArray = file.get_csv_line(";")
	while line.size() > 1:
		weapons.append(_parse_weapon(line))
		line = file.get_csv_line(";")
	return weapons


func _create_weapon_dictionary(weapons: Array[WeaponResource]) -> Dictionary:
	var weapon_dictionary = {}
	for weapon in weapons:
		weapon_dictionary[weapon.id] = weapon
	return weapon_dictionary


func init():
	var weapons = _load_weapons("res://World/Items/Weapons/WeaponData.txt")
	_weapon_dictionary = _create_weapon_dictionary(weapons)


func get_weapon(id: int) -> WeaponResource:
	return _weapon_dictionary[id]

