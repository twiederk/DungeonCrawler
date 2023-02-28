class_name Combat
extends Node2D


var characters: Array = []
var character_pointer: int = 0
var character: Character = null

var monsters: Array = []

var items: Array = []

var game_system: GameSystem = GameSystem.new()

@onready var camera: Camera2D = $Camera2D
@onready var highlight = $Highlight


func _ready():
	randomize()

	var combat_init = CombatInit.new()

	combat_init.create_monster_manual()
	combat_init.create_level_complete(self, dungeon.level_complete)
	
	characters = combat_init.create_characters(self, dungeon.characters)
	monsters = combat_init.create_monsters(self, dungeon.monsters)
	items = combat_init.create_items(self, dungeon.items)

	character = characters[character_pointer]

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


func _on_Monster_attacked(monster: MonsterBody2D) -> void:
	var attacker: Creature = character.get_creature()
	var defender: Creature = monster.get_creature()

	game_system.attack(attacker, defender)

	if defender.get_hit_points() <= 0:
		print("...and kills ", defender.get_name())
		monster.queue_free()


func sum_gold() -> int:
	var gold = 0
	for myCharacter in characters:
		gold += myCharacter.get_inventory().get_gold()
	return gold


const dungeon = {
	level_complete = Vector2(1, 5),
	characters = [
		{ name = "Linda", texture_file = "res://Assets/graphics/sprites/Mage.png" },
		{ name = "Leon", texture_file = "res://Assets/graphics/sprites/Fighter.png" },
	],
	monsters = [
			{ monster = "Skeleton", position = Vector2(3, 3) },
			{ monster = "Skeleton Chief", position = Vector2(4, 3) },
#			{ monster = "Skeleton", position = Vector2(12, 4) },
#			{ monster = "Skeleton", position = Vector2(22, 6) },
#			{ monster = "Skeleton Chief", position = Vector2(22, 5) },
#			{ monster = "Skeleton", position = Vector2(13, 18) },
#			{ monster = "Skeleton Chief", position = Vector2(13, 19) },
#			{ monster = "Skeleton", position = Vector2(22, 18) },
#			{ monster = "Skeleton Chief", position = Vector2(22, 19) },
	],
	items = [
		{ frame_coords = Vector2(2, 30), position = Vector2(9, 4) },
#		{ frame_coords = Vector2(2, 30), position = Vector2(10, 11) },
	]
}
