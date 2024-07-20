class_name InventoryScreen
extends Control

@onready var bag: GridContainer = $Bag
@onready var character_name_label: Label = $CharacterNameLabel
@onready var weapon_slot: WeaponSlot = $Character/WeaponSlot
@onready var character_image = $CharacterImage

var _character_stats: CreatureStats

func _ready():
	for index in PlayerStats.character_stats.size():
		PlayerStats.character_stats[index].inventory.item_added.connect(_on_item_added)
	
	weapon_slot.item_changed.connect(_on_weapon_changed)

	var slots = bag.get_children()
	for index in slots.size():
		var slot: Slot = bag.get_child(index)
		slot.index = index
		slot.item_changed.connect(_on_item_changed)
	init(PlayerStats.character_stats[0])


func _input(event):
	if event.is_action_pressed("InventoryScreen"):
		PlayerStats.show_inventory_screen = !PlayerStats.show_inventory_screen
		visible = PlayerStats.show_inventory_screen
	if is_inventory_action_just_pressed():
		var index = keycode_to_index(event)
		var character_stats = PlayerStats.character_stats[index]
		init(character_stats)


func is_inventory_action_just_pressed() -> bool:
	return Input.is_action_just_pressed("Inventory_1") or Input.is_action_just_pressed("Inventory_2")


func keycode_to_index(event: InputEvent) -> int:
	var key_event = event as InputEventKey
	return key_event.keycode - KEY_1


func init(character_stats: CreatureStats):
	_character_stats = character_stats
	character_name_label.text = character_stats.name
	_set_character_texture()
	weapon_slot.set_property(character_stats.weapon)
	for index in _character_stats.inventory.bag.size():
		var slot: Slot = bag.get_child(index)
		slot.set_property(_character_stats.inventory.bag[index])


func _set_character_texture():
	var frame_texture = _character_stats.sprite_frames.get_frame_texture("idle", 0)
	var atlas_texture: AtlasTexture = AtlasTexture.new()
	atlas_texture.atlas = frame_texture
	atlas_texture.region = Rect2(0, 0, 16, 16)
	character_image.texture = atlas_texture


func _on_item_changed(index: int, item: ItemResource):
	_character_stats.inventory.bag[index] = item


func _on_item_added(index: int):
	var slot: Slot = bag.get_child(index)
	slot.set_property(_character_stats.inventory.bag[index])


func _on_weapon_changed(_index: int, item: ItemResource):
	_character_stats.weapon = item
