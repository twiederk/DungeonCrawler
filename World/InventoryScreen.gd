class_name InventoryScreen
extends Control

@onready var bag: GridContainer = $Bag
@onready var character_name_label: Label = $CharacterNameLabel
@onready var weapon_slot: WeaponSlot = $Character/WeaponSlot

var _inventory: Inventory

func _ready():
	for index in PlayerStats.character_stats.size():
		PlayerStats.character_stats[index].inventory.item_added.connect(_on_item_added)

	var slots = bag.get_children()
	for index in slots.size():
		var slot: Slot = bag.get_child(index)
		slot.index = index
		slot.item_changed.connect(_on_item_changed)


func _input(_event):
	if Input.is_action_just_pressed("Inventory_1"):
		var character_stats = PlayerStats.character_stats[0]
		init(character_stats, character_stats.inventory)
	if Input.is_action_just_pressed("Inventory_2"):
		var character_stats = PlayerStats.character_stats[1]
		init(character_stats, character_stats.inventory)


func init(character_stats: CreatureStats, inventory: Inventory):
	_inventory = inventory
	character_name_label.text = character_stats.name
	weapon_slot.set_property(character_stats.weapon)
	for index in _inventory.bag.size():
		var slot: Slot = bag.get_child(index)
		slot.set_property(_inventory.bag[index])


func _on_item_changed(index: int, item: ItemResource):
	_inventory.bag[index] = item


func _on_item_added(index: int):
	var slot: Slot = bag.get_child(index)
	slot.set_property(_inventory.bag[index])
