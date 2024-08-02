class_name BagSlot
extends Slot

signal bag_changed(index: int, item: ItemResource)

var index: int


func _emit_changed_signal():
	bag_changed.emit(index, item_resource)
