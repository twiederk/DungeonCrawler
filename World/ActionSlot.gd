class_name ActionSlot
extends Slot

signal action_changed(item_resource: ItemResource)

@onready var damage_label: Label = $DamageLabel


func _can_drop_data(_at_position, data):
	return data.item_resource is WeaponResource or data.item_resource is SpellResource


func _item_changed():
	damage_label.text = item_resource.damage.to_string()
	action_changed.emit(item_resource)
