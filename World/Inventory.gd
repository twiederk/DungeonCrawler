class_name Inventory

signal item_added(index: int)

var bag: Array[ItemResource] = []
var weapon: WeaponResource


func _init():
	_initialize_bag()


func _initialize_bag():
	for i in range(16):
		bag.append(null)


func add_item(item: ItemResource):
	for index in bag.size():
		if bag[index] == null:
			bag[index] = item
			item_added.emit(index)
			break
