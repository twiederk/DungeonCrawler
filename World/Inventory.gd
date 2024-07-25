class_name Inventory

var bag: Array[ItemResource] = []
var weapon: WeaponResource


func _init():
    _initialize_bag()


func _initialize_bag():
    for i in range(16):
        bag.append(null)
