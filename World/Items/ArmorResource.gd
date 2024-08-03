class_name ArmorResource
extends ItemResource

@export var armor_class: int


func _to_string():
	return str("RK: ", armor_class)
