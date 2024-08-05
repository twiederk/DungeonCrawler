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
	file.get_csv_line(";")
	var line: PackedStringArray = file.get_csv_line(";")
	while line.size() > 1:
		armor.append(_parse_armor(line))
		line = file.get_csv_line(";")
	return armor

func init():
	var cloth = ArmorResource.new()
	cloth.id = 1
	cloth.name = "Kleidung"
	cloth.texture = load("res://Assets/graphics/sprites/items/armor/armor_001.png")
	cloth.armor_class = 10
	
	var chain_mail = ArmorResource.new()
	chain_mail.id = 2
	chain_mail.name = "Kleidung"
	chain_mail.texture = load("res://Assets/graphics/sprites/items/armor/armor_002.png")
	chain_mail.armor_class = 16
	
	_armor_dictionary[cloth.id] = cloth
	_armor_dictionary[chain_mail.id] = chain_mail


func get_armor(id: int) -> ArmorResource:
	return _armor_dictionary[id]
