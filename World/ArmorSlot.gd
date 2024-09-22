class_name ArmorSlot
extends Slot

signal armor_changed(armor: ArmorResource)

@onready var armor_class_label: Label = $ArmorClassLabel


func _can_drop_data(_at_position, data):
	return data.item_resource is ArmorResource


func _item_changed():
	var armor_resource = item_resource as ArmorResource
	armor_class_label.text = armor_resource.to_string()
	armor_changed.emit(armor_resource)
