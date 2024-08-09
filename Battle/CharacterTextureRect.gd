extends TextureRect

signal item_dropped(item_resource: ItemResource)


func _can_drop_data(_at_position, data) -> bool:
	return data.item_resource is ItemResource


func _drop_data(_at_position, data):
	var slot = data as Slot
	item_dropped.emit(slot.item_resource)
	slot.set_item(null)
