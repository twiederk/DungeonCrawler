class_name Battle
extends Node

const CharacterScene = preload("res://Battle/Character.tscn")
const MonsterScene = preload("res://Battle/Monster.tscn")

var characters: Array[Battler] = []
var monsters: Array[Battler] = []
var all_battlers: Array[Battler] = []

var current_battler: Node2D
var current_battler_index: int

var game_system: GameSystem = GameSystem.new()

@onready var battlefield = $Battlefield
@onready var battle_end_panel = $CanvasLayer/BattleEndPanel
@onready var battle_end_label = $CanvasLayer/BattleEndPanel/BattleEndLabel
@onready var battle_end_timer = $BattleEndTimer


func _ready():
	randomize()

	var battle_init = BattleInit.new()

	characters = battle_init.create_battlers(CharacterScene, self, PlayerStats.character_stats)
	battlefield.place_characters(characters)
	all_battlers.append_array(characters)

	monsters = battle_init.create_battlers(MonsterScene, self, PlayerStats.get_monster_stats())
	battlefield.place_monsters(monsters)
	all_battlers.append_array(monsters)

	current_battler = all_battlers[current_battler_index]
	current_battler.start_turn(get_battlefield())


func next_battler() -> void:
	current_battler.stop_turn()
	if is_battle_end():
		end_battle()
	else:
		current_battler_index = (current_battler_index + 1) % all_battlers.size()
		current_battler = all_battlers[current_battler_index]
		current_battler.start_turn(get_battlefield())


func is_battle_end() -> bool:
	return monsters.is_empty() or characters.is_empty()


func end_battle() -> void:
	PlayerStats.character_stats.clear()
	for character in characters:
		PlayerStats.character_stats.append(character.get_creature())
	if monsters.is_empty():
		_show_battle_end_panel("You won!")
	else:
		_show_battle_end_panel("You lost")
	battle_end_timer.start()


func _on_battle_end_timer_timeout():
	var map = LevelStats.get_current_level()
	var scene_to_load = str("res://World/Maps/", map, ".tscn")
	get_tree().change_scene_to_file(scene_to_load)


func _on_battler_attacked(attacker, defender) -> void:
	game_system.attack(attacker, defender)


func _on_battler_died(battler: Battler) -> void:
	print("...and kills ", battler.get_creature_name())
	if battler is Character:
		characters.erase(battler)
	else:
		monsters.erase(battler)
		battler.queue_free()
	all_battlers.erase(battler)


func get_battlefield() -> Battlefield:
	battlefield.character_positions.clear()
	for character in characters:
		battlefield.character_positions.append(character.get_battlefield_position())

	battlefield.monster_positions.clear()
	for monster in monsters:
		battlefield.monster_positions.append(monster.get_battlefield_position())
	return battlefield


func _show_battle_end_panel(message: String) -> void:
	battle_end_label.set_text(message)
	battle_end_panel.show()

