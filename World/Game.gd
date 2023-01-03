class_name Game
extends Node2D


var characters: Array = []
var character_pointer: int = 0
var character: Character = null

var monsters: Array = []

var game_system: GameSystem = GameSystem.new()

onready var camera: Camera2D = $Camera2D
onready var highlight = $Highlight


func _ready():
	randomize()
	var game_init = GameInit.new()

	game_init.create_monster_dictionary()

	characters = game_init.create_characters([
			{ name = "Linda", texture_file = "res://World/Knight_01.png" },
			{ name = "Leon", texture_file = "res://World/Knight_02.png" },
		])
	for tempCharacter in characters:
		add_child(tempCharacter)
	character = characters[character_pointer]

	monsters = game_init.create_monsters([
			{ monster = "Goblin", position = Vector2(3, 3) },
			{ monster = "Goblin Chief", position = Vector2(4, 3) },
			{ monster = "Goblin", position = Vector2(12, 4) },
			{ monster = "Goblin", position = Vector2(22, 6) },
			{ monster = "Goblin Chief", position = Vector2(22, 5) },
			{ monster = "Goblin", position = Vector2(13, 18) },
			{ monster = "Goblin Chief", position = Vector2(13, 19) },
			{ monster = "Goblin", position = Vector2(22, 18) },
			{ monster = "Goblin Chief", position = Vector2(22, 19) },
		])
	for monster in monsters:
		monster.connect("attacked", self, "_on_Monster_attacked")
		add_child(monster)
		
	var items = game_init.create_items()
	for item in items:
		add_child(item)

	init_camera()


func _process(_delta: float) -> void:
	check_input()
	character.action()



func check_input() -> void:
	if Input.is_action_just_pressed("next"):
		next_creature()


func next_creature() -> void:
	character.remove_child(camera)
	character.remove_child(highlight)
	next_character()
	add_highlight_and_camera()


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
		monster.queue_free()



