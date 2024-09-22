class_name BagSlot
extends Slot

signal bag_changed(index: int, item: ItemResource)

var index: int


func _can_drop_data(_at_position, data):
	if data is ActionSlot:
		return item_resource is WeaponResource or item_resource is SpellResource
	if data is ArmorSlot:
		return item_resource is ArmorResource
	return data.item_resource is ItemResource


func _item_changed():
	bag_changed.emit(index, item_resource)
