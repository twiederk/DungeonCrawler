class_name PlyStats
extends Node

var show_character_stats: bool = true
var show_message_screen: bool = true

var start_position: Vector2

var monsters: Array[MonsterResource] = []

var character_stats: Array[CreatureStats] = []


func load_characters():
	character_stats = [ get_leon(), get_linda(),]


func get_monster_stats() -> Array[CreatureStats]:
	var monster_stats: Array[CreatureStats] = []
	for monster in monsters:
		monster_stats.append(monster.to_creature_stats())
	return monster_stats


func get_leon() -> CreatureStats:
	var leon = CreatureStats.new()
	leon.name = "Leon"
	leon.max_hit_points = 20
	leon.hit_points = 20
	leon.damage = 2
	leon.weapon = ItemData.get_weapon(5)
	leon.armor = ItemData.get_armor(1)
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
	linda.weapon = ItemData.get_weapon(9)
	linda.armor = ItemData.get_armor(1)
	linda.max_movement = 4
	linda.movement = 0
	linda.sprite_frames = load("res://Assets/graphics/sprites/MageSpriteFrames.tres")
	return linda
