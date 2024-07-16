class_name Battle
extends Node

const CharacterScene: PackedScene = preload("res://Battle/Character.tscn")
const MonsterScene: PackedScene = preload("res://Battle/Monster.tscn")
const ItemScene: PackedScene = preload("res://World/Items/Item.tscn")

var characters: Array[Battler] = []
var monsters: Array[Battler] = []
var battlers: Array[Battler] = []

var items: Array[Item] = []

var current_battler: Node2D
var current_battler_index: int

var game_system: GameSystem = GameSystem.new()

@onready var battlefield = $Battlefield
@onready var character_screen = $GUI/CharacterScreen
@onready var battle_end_screen = $GUI/BattleEndScreen
@onready var battlers_node = $Battlers
@onready var items_node = $Items


func _ready():
	randomize()

	var battle_init = BattleInit.new()

	characters = battle_init.create_battlers(CharacterScene, self, character_screen, PlayerStats.character_stats)
	battlefield.place_characters(characters)
	battlers.append_array(characters)
	_remove_dead_characters()

	monsters = battle_init.create_battlers(MonsterScene, self, null, PlayerStats.get_monster_stats())
	_set_monsters_loot_table_name()
	battlefield.place_monsters(monsters)
	battlers.append_array(monsters)

	current_battler = battlers[current_battler_index]
	current_battler.start_turn(get_battlefield())


func _remove_dead_characters():
	for character in characters:
		if character.get_hit_points() == 0:
			character.dead()


func _set_monsters_loot_table_name():
	for i in PlayerStats.monsters.size():
		monsters[i].loot_table_name = PlayerStats.monsters[i].loot_table_name
		monsters[i].item_dropped.connect(_on_item_dropped)


func _on_next_battler() -> void:
	#print("Battle._on_next_battler()")
	current_battler.stop_turn()
	if is_battle_end():
		end_battle()
	else:
		current_battler_index = (current_battler_index + 1) % battlers.size()
		current_battler = battlers[current_battler_index]
		current_battler.start_turn(get_battlefield())


func is_battle_end() -> bool:
	return characters.is_empty() or (monsters.is_empty() and items.is_empty())


func end_battle() -> void:
	if monsters.is_empty():
		battle_end_screen.show_message("SIEG!")
	else:
		battle_end_screen.show_message("VERLOREN")


func _on_battler_attacked(attacker, defender) -> void:
	game_system.attack(attacker, defender)


func _on_battler_died(battler: Battler) -> void:
	#print("Battle._on_battler_died()")
	print("...and kills ", battler.get_creature_name())
	var index = battlers.find(battler)
	if index < current_battler_index:
		current_battler_index -= 1
	if battler is Character:
		characters.erase(battler)
	else:
		monsters.erase(battler)
		battler.queue_free()
	battlers.erase(battler)


func get_battlefield() -> Battlefield:
	battlefield.character_positions.clear()
	for character in characters:
		battlefield.character_positions.append(character.get_battlefield_position())

	battlefield.monster_positions.clear()
	for monster in monsters:
		battlefield.monster_positions.append(monster.get_battlefield_position())
	return battlefield


func get_battlers_node():
	return battlers_node


func _on_item_dropped(item_resource: ItemResource, global_position: Vector2):
	var item: Item = ItemScene.instantiate()
	item.item_resource = item_resource
	item.global_position = global_position
	item.item_picked_up.connect(_on_item_picked_up)
	items.append(item)
	items_node.add_child(item)


func _on_item_picked_up(item: Item):
	items.erase(item)
