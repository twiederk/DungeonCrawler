class_name InventoryScreen
extends Control

@onready var bag: GridContainer = $Bag


func init(character_name: String, inventory: Inventory):
	for index in inventory.bag.size():
		bag.get_child(index).set_property(inventory.bag[index])
		
