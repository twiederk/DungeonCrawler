class_name PlyStats
extends Node

var start_position: Vector2

var monster_stats: Array[CreatureStats] = []
var monster_resources: Array[MonsterResource] = []

var character_stats: Array[CreatureStats] = []


func start_game():
	start_position = Vector2.ZERO
	load_characters()


func load_characters():
	character_stats = [ get_leon(), get_linda(),]


func get_leon() -> CreatureStats:
	var leon = CreatureStats.new()
	leon.name = "Leon"
	leon.max_hit_points = 20
	leon.hit_points = 20
	leon.damage = 2
	leon.action = ItemData.get_weapon(5) # dagger
	leon.armor = ItemData.get_armor(1) # cloth
	leon.inventory.add_item(ItemData.get_weapon(3)) # bow
	leon.max_movement = 3
	leon.movement = 0
	leon.sprite_frames = load("res://Assets/graphics/sprites/FighterSpriteFrames.tres")
	return leon


func get_linda() -> CreatureStats:
	var linda = CreatureStats.new()
	linda.name = "Linda"
	linda.hit_points = 4
	linda.max_hit_points = 4
	linda.damage = 1
	linda.action = ItemData.get_spell(1) # magic missile
	linda.armor = ItemData.get_armor(1) # cloth
	linda.inventory.add_item(ItemData.get_weapon(1)) # staff
	linda.inventory.add_item(ItemData.get_spell(2)) # acid splash
	linda.max_movement = 4
	linda.movement = 0
	linda.sprite_frames = load("res://Assets/graphics/sprites/MageSpriteFrames.tres")
	return linda
