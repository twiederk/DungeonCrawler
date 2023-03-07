class_name Combat
extends Node2D


var characters: Array = []
var character_pointer: int = 0
var character: Character = null

var monsters: Array = []

var game_system: GameSystem = GameSystem.new()

@onready var camera: Camera2D = $Camera2D
@onready var highlight = $Highlight


func _ready():
	randomize()

	var combat_init = CombatInit.new()

	characters = combat_init.create_characters(self, PlayerStats.characters)
	monsters = combat_init.create_monsters(self, EncounterStats.monsters)

	character = characters[character_pointer]

	init_camera()


func _process(_delta: float) -> void:
	check_input()
	character.action()
	if character.is_done():
		next_creature()


func check_input() -> void:
	if Input.is_action_just_pressed("next"):
		next_creature()


func next_creature() -> void:
	check_combat_end()
	check_combat_round()
	character.remove_child(camera)
	character.remove_child(highlight)
	next_character()
	add_highlight_and_camera()


func check_combat_end() -> void:
	if is_combat_end():
		end_combat()


func is_combat_end() -> bool:
	return monsters.is_empty()


func end_combat() -> void:
	var map = LevelStats.get_current_level()
	var scene_to_load = str("res://World/", map, ".tscn")
	get_tree().change_scene_to_file(scene_to_load)


func check_combat_round() -> void:
	if is_new_combat_round():
		start_combat_round()


func start_combat_round() -> void:
	for temp_character in characters:
		temp_character.start_combat_round()


func is_new_combat_round() -> bool:
	return character_pointer + 1 == characters.size()


func next_character() -> void:
	character_pointer = character_pointer + 1
	if character_pointer >= characters.size():
		character_pointer = 0
	character = characters[character_pointer]


func init_camera() -> void:
	remove_child(camera)
	remove_child(highlight)
	add_highlight_and_camera()


func add_highlight_and_camera() -> void:
	character.add_child(camera)
	character.add_child(highlight)
	character.move_child(highlight, 0)


func _on_Monster_attacked(monster: Monster) -> void:
	var attacker: Creature = character.get_creature()
	var defender: Creature = monster.get_creature()

	game_system.attack(attacker, defender)

	if defender.get_hit_points() <= 0:
		print("...and kills ", defender.get_name())
		monsters.remove_at(monsters.find(monster))
		monster.queue_free()


func sum_gold() -> int:
	var gold = 0
	for myCharacter in characters:
		gold += myCharacter.get_inventory().get_gold()
	return gold
