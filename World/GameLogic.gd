class_name GameLogic
extends Node2D

const texture1 = preload("res://World/Knight_01.png")
const texture2 = preload("res://World/Knight_02.png")


var characters: Array = []
var current_character: int = 0

var monsters: Array = []

var game_system: GameSystem = GameSystem.new()

onready var camera: Camera2D = $Camera2D


func _ready():
	randomize()
	var game_init = GameInit.new()
	
	characters = game_init.create_characters([texture1, texture1])
	for character in characters:
		add_child(character)
	
	monsters = game_init.create_monsters()
	for monster in monsters:
		monster.connect("attacked", self, "_on_Monster_attacked")
		add_child(monster)

	init_camera()


func _process(_delta: float) -> void:
	check_input()
	characters[current_character].action()

		
		
func check_input() -> void:
	if Input.is_action_just_pressed("next"):
		next_creature()
		
		
func next_creature() -> void:
	characters[current_character].remove_child(camera)
	current_character = current_character + 1
	if current_character >= characters.size():
		current_character = 0
	characters[current_character].add_child(camera)
		
		
func init_camera() -> void:
	remove_child(camera)
	characters[current_character].add_child(camera)


func _on_Monster_attacked(monster: Monster) -> void:
	var attacker: Creature = characters[current_character].get_creature()
	var defender: Creature = monster.get_creature()
	
	game_system.attack(attacker, defender)
	
	if defender.get_hit_points() <= 0:
		print("...and kills ", defender.get_name()) 
		monster.queue_free()



