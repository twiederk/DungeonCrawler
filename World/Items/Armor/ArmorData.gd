class_name ArmorData
extends RefCounted

var _armor_dictionary = {}


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
