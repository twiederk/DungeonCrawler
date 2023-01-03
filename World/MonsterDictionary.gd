class_name MonsterDictionary
extends Reference

var _dictionary: Dictionary = {}

func get_monster(name: String) -> Dictionary:
	return _dictionary[name]


func add_monster(monster: Dictionary) -> void:
	_dictionary[monster.name] = monster


func size() -> int:
	return _dictionary.size()

