class_name Inventory

var _gold: int = 0

func get_gold() -> int:
	return _gold


func set_gold(gold: int) -> void:
	_gold = gold


func add_gold(gold: int) -> void:
	_gold += gold

