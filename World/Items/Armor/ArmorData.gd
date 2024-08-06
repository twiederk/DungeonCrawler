class_name ArmorData
extends RefCounted

var _armor_dictionary = {}


func _parse_armor(line: PackedStringArray) -> ArmorResource:
	var armor = ArmorResource.new()
	armor.id = line[0].to_int()
	armor.name = line[1]
	armor.armor_class = line[2].to_int()
	armor.texture = load("res://Assets/graphics/sprites/items/armor/" + line[3])
	return armor


func _load_armor(file_name: String) -> Array[ArmorResource]:
	var armor: Array[ArmorResource] = []
	var file: FileAccess = FileAccess.open(file_name, FileAccess.READ)
	file.get_csv_line()
	var line: PackedStringArray = file.get_csv_line()
	while line.size() > 1:
		armor.append(_parse_armor(line))
		line = file.get_csv_line()
	return armor


func _create_armor_dictionary(all_armor: Array[ArmorResource]) -> Dictionary:
	var armor_dictionary = {}
	for armor in all_armor:
		armor_dictionary[armor.id] = armor
	return armor_dictionary


func init():
	var all_armor = _load_armor("res://World/Items/Armor/ArmorData.csv")
	_armor_dictionary = _create_armor_dictionary(all_armor)


func get_armor(id: int) -> ArmorResource:
	return _armor_dictionary[id]
