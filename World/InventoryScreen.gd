class_name InventoryScreen
extends Control

@onready var bag: GridContainer = $Bag


func _input(event):
	if Input.is_action_just_pressed("Inventory_1"):
		var character_stats = PlayerStats.character_stats[0]
		init(character_stats.name, character_stats.inventory)
	if Input.is_action_just_pressed("Inventory_2"):
		var character_stats = PlayerStats.character_stats[1]
		init(character_stats.name, character_stats.inventory)


func init(character_name: String, inventory: Inventory):
	
	for index in inventory.bag.size():
		bag.get_child(index).set_property(inventory.bag[index])
		
