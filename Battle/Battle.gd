class_name Battle
extends Node

const CharacterScene: PackedScene = preload("res://Battle/CharacterBattler.tscn")
const MonsterScene: PackedScene = preload("res://Battle/MonsterBattler.tscn")
const ItemScene: PackedScene = preload("res://World/Items/Item.tscn")

var _logger = Logger.new()

var current_battler: Battler
var current_battler_index: int


@onready var battlefield: Battlefield = $Battlefield
@onready var party_screen: PartyScreen = $GUI/PartyScreen
@onready var battle_end_screen: BattleEndScreen = $GUI/BattleEndScreen
@onready var battlers_node: Node2D = $Battlers
@onready var items_node: Node2D = $Items
@onready var message_screen: MessageScreen = $GUI/MessageScreen
@onready var monster_screen: MonsterScreen = $GUI/MonsterScreen


func _ready():
	randomize()

	var battle_init = BattleInit.new()

	var characters = battle_init.create_battlers(CharacterScene, self, party_screen, PlayerStats.character_stats)
	battlefield.place_characters(characters)
	_remove_dead_characters()

	var monsters = battle_init.create_battlers(MonsterScene, self, monster_screen, PlayerStats.monster_stats)
	battlefield.place_monsters(monsters)
	_set_monsters_loot_table_name()

	current_battler = battlefield.battlers[current_battler_index]
	current_battler.start_turn()


func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("end_battle"):
		if battlefield.monsters.is_empty():
			battle_end_screen.show_message("SIEG!")
		else:
			MessageBus.message_send.emit("Zuerst alle Monster besiegen.")

func _remove_dead_characters():
	for character in battlefield.characters:
		if character.get_hit_points() == 0:
			character.dead()


func _set_monsters_loot_table_name():
	for i in PlayerStats.monster_resources.size():
		battlefield.monsters[i].loot_table_name = PlayerStats.monster_resources[i].loot_table_name
		battlefield.monsters[i].item_dropped.connect(_on_item_dropped)


func _on_next_battler() -> void:
	_logger.debug(str("Battle._on_next_battler()"))
	current_battler.stop_turn()
	if is_battle_end():
		end_battle()
	else:
		current_battler_index = (current_battler_index + 1) % battlefield.battlers.size()
		current_battler = battlefield.battlers[current_battler_index]
		current_battler.start_turn()


func is_battle_end() -> bool:
	return battlefield.characters.is_empty() or (battlefield.monsters.is_empty() and battlefield.items.is_empty())


func end_battle() -> void:
	if battlefield.monsters.is_empty():
		battle_end_screen.show_message("SIEG!")
	else:
		battle_end_screen.set_battle_lost(true)
		battle_end_screen.show_message("VERLOREN")


func _on_battler_died(battler: Battler) -> void:
	_logger.debug(str("Battle._on_battler_died()"))
	MessageBus.message_send.emit(str("...und tötet ", battler.get_creature_name()))
	var index = battlefield.battlers.find(battler)
	if index < current_battler_index:
		current_battler_index -= 1
	if battler is CharacterBattler:
		battlefield.characters.erase(battler)
	else:
		battlefield.monsters.erase(battler)
		battler.queue_free()
	battlefield.battlers.erase(battler)


func get_battlers_node():
	return battlers_node


func _on_item_dropped(item_resource: ItemResource, global_position: Vector2):
	var item: Item = ItemScene.instantiate()
	item.item_resource = item_resource
	item.global_position = global_position
	item.item_picked_up.connect(_on_item_picked_up)
	battlefield.items.append(item)
	items_node.add_child(item)


func _on_item_picked_up(item: Item, character_stats: CreatureStats):
	character_stats.inventory.add_item(item.item_resource)
	battlefield.items.erase(item)
	var message = character_stats.name + " hat " + item.get_item_name() + " aufgenommen."
	MessageBus.message_send.emit(message)
