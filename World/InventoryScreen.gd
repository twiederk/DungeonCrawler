class_name InventoryScreen
extends Control

const NO_CHARACTER: int = -1

static var _show_inventory_screen: bool = false

var _character_stats: CreatureStats
var _displayed_character_index = NO_CHARACTER

@onready var character_image: TextureRect = $CharacterImage
@onready var character_name: Label = $CharacterName
@onready var bag: GridContainer = $Bag
@onready var weapon_slot: WeaponSlot = $Character/WeaponSlot
@onready var armor_slot: ArmorSlot = $Character/ArmorSlot


func _ready():
	for index in PlayerStats.character_stats.size():
		PlayerStats.character_stats[index].inventory.item_added.connect(_on_item_added)
	
	weapon_slot.weapon_changed.connect(_on_weapon_changed)
	armor_slot.armor_changed.connect(_on_armor_changed)

	var slots = bag.get_children()
	for index in slots.size():
		var slot: BagSlot = bag.get_child(index)
		slot.index = index
		slot.bag_changed.connect(_on_bag_changed)
	init(PlayerStats.character_stats[0])


func _input(event):
	if is_inventory_action_just_pressed():
		var index = keycode_to_index(event)
		if index != _displayed_character_index:
			_displayed_character_index = index
			var character_stats = PlayerStats.character_stats[index]
			init(character_stats)
			visible = true
		else:
			_displayed_character_index = NO_CHARACTER
			visible = false


func is_inventory_action_just_pressed() -> bool:
	return Input.is_action_just_pressed("Inventory_1") or Input.is_action_just_pressed("Inventory_2")


func keycode_to_index(event: InputEvent) -> int:
	var key_event = event as InputEventKey
	return key_event.keycode - KEY_1


func init(character_stats: CreatureStats):
	_character_stats = character_stats
	character_name.text = character_stats.name
	_set_character_texture()
	weapon_slot.set_item(character_stats.weapon)
	armor_slot.set_item(character_stats.armor)
	
	for index in _character_stats.inventory.bag.size():
		var slot: BagSlot = bag.get_child(index)
		slot.set_item(_character_stats.inventory.bag[index])


func _set_character_texture():
	var frame_texture = _character_stats.sprite_frames.get_frame_texture("idle", 0)
	var atlas_texture: AtlasTexture = AtlasTexture.new()
	atlas_texture.atlas = frame_texture
	atlas_texture.region = Rect2(0, 0, 16, 16)
	character_image.texture = atlas_texture


func _on_item_added(index: int):
	var slot: BagSlot = bag.get_child(index)
	slot.set_item(_character_stats.inventory.bag[index])


func _on_bag_changed(index: int, item: ItemResource):
	_character_stats.inventory.bag[index] = item


func _on_weapon_changed(weapon: WeaponResource):
	_character_stats.weapon = weapon


func _on_armor_changed(armor: ArmorResource):
	_character_stats.armor = armor
