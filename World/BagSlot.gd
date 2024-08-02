class_name BagSlot
extends Slot

signal bag_changed(index: int, item: ItemResource)

var index: int


func _item_changed():
	bag_changed.emit(index, item_resource)
