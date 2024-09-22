class_name CharacterWidgetTextureRect
extends TextureRect

signal item_dropped(item_resource: ItemResource)


func _can_drop_data(_at_position, data) -> bool:
	return data.item_resource is ArmorResource or data.item_resource is WeaponResource


func _drop_data(_at_position, data):
	var bag_slot = data as BagSlot
	item_dropped.emit(bag_slot.item_resource)
	bag_slot.set_item(null)
