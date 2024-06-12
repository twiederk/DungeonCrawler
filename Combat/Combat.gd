class_name Combat
extends Node


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
	current_battler.start_turn()


func next_battler() -> void:
	current_battler.stop_turn()
	if is_combat_end():
		end_combat()
	else:
		current_battler_index = (current_battler_index + 1) % all_battlers.size()
		current_battler = all_battlers[current_battler_index]
		current_battler.start_turn()


func is_combat_end() -> bool:
	return monsters.is_empty()


func end_combat() -> void:
	var map = LevelStats.get_current_level()
	var scene_to_load = str("res://World/", map, ".tscn")
	get_tree().change_scene_to_file(scene_to_load)


func _on_monster_attacked(attacker, defender) -> void:
	game_system.attack(attacker, defender)


func _on_monster_died(monster: Battler) -> void:
	print("...and kills ", monster.get_creature_name())
	monsters.erase(monster)
	all_battlers.erase(monster)
	monster.queue_free()
