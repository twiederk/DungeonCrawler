class_name ItemPickupScreen
extends Control

@onready var item_list: ItemList = $CanvasLayer/Panel/ItemList
@onready var continue_button = $CanvasLayer/Panel/ContinueButton


func _ready():
	PlayerStats.display_item_pickup_screen = true
	continue_button.grab_focus()


func add_slot(item: Item):
	item_list.add_item(item.get_item_name(), item.get_texture())


func _on_continue_button_pressed():
	PlayerStats.display_item_pickup_screen = false
	queue_free()
