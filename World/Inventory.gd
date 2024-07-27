class_name Inventory

var bag: Array[ItemResource] = []
var weapon: WeaponResource


func _init():
	_initialize_bag()


func _initialize_bag():
	for i in range(16):
		bag.append(null)


func add_item(item: ItemResource):
	print("add_item(): ", item.name)
	for index in bag.size():
		if bag[index] == null:
			bag[index] = item
			break
