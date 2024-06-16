class_name Combat
extends Node

const TILE_SIZE = 16

var characters: Array[Battler] = []
var monsters: Array[Battler] = []

var all_battlers: Array[Battler] = []

var current_battler: Node2D
var current_battler_index: int

var game_system: GameSystem = GameSystem.new()


func _ready():
	randomize()

	var combat_init = CombatInit.new()

	characters = combat_init.create_characters(self, PlayerStats.characters)
	monsters = combat_init.create_monsters(self, EncounterStats.monsters)
	all_battlers.append_array(characters)
	all_battlers.append_array(monsters)

	current_battler = all_battlers[current_battler_index]
	current_battler.start_turn(get_battlefield())


func next_battler() -> void:
	current_battler.stop_turn()
	if is_combat_end():
		end_combat()
	else:
		current_battler_index = (current_battler_index + 1) % all_battlers.size()
		current_battler = all_battlers[current_battler_index]
		current_battler.start_turn(get_battlefield())


func is_combat_end() -> bool:
	return monsters.is_empty() or characters.is_empty()


func end_combat() -> void:
	var map = LevelStats.get_current_level()
	var scene_to_load = str("res://World/", map, ".tscn")
	get_tree().change_scene_to_file(scene_to_load)


func _on_battler_attacked(attacker, defender) -> void:
	game_system.attack(attacker, defender)


func _on_battler_died(battler: Battler) -> void:
	print("...and kills ", battler.get_creature_name())
	if battler is Character:
		characters.erase(battler)
	else:
		monsters.erase(battler)
	all_battlers.erase(battler)
	battler.queue_free()


func get_battlefield() -> Battlefield:
	var battlefield = Battlefield.new()
	battlefield.width = 20
	battlefield.height = 12
	for character in characters:
		battlefield.character_positions.append(character.get_battlefield_position())
	for monster in monsters:
		battlefield.monster_positions.append(monster.get_battlefield_position())
	return battlefield
