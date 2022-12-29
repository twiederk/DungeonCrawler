class_name GameLogic
extends Node2D

const Character = preload("res://World/Character.tscn")
const texture1 = preload("res://World/Knight_01.png")
const texture2 = preload("res://World/Knight_02.png")

var creatures: Array = []
var current_creature: int = 0

onready var camera: Camera2D = $Camera2D


func _ready():
	creatures = create_characters([texture1, texture1])
	init_camera()


func _process(_delta: float) -> void:
	check_input()
	creatures[current_creature].action()


func create_characters(textures: Array) -> Array:
	var characters = []
	for i in range(textures.size()):
		var x = (i + 1) * 32
		var character = create_character(textures[i], Vector2(x, 32))
		add_child(character)
		characters.append(character)
	return characters
		

func create_character(texture: Texture, position: Vector2) -> Character:
	var character = Character.instance()
	character.get_node("Sprite").texture = texture
	character.position = position
	character.scale = Vector2(0.5, 0.5)
	return character
		
		
func check_input() -> void:
	if Input.is_action_just_pressed("next"):
		next_creature()
		
		
func next_creature() -> void:
	creatures[current_creature].remove_child(camera)
	current_creature = current_creature + 1
	if current_creature >= creatures.size():
		current_creature = 0
	creatures[current_creature].add_child(camera)
		
		
func init_camera() -> void:	
	remove_child(camera)
	creatures[current_creature].add_child(camera)


