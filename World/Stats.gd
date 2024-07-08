class_name Stats
extends Node

var start_position: Vector2

var monsters: Array[MonsterResource] = []

var character_stats: Array[CreatureStats] = [
	get_leon(),
	get_linda(),
]


func get_monster_stats() -> Array[CreatureStats]:
	var monster_stats: Array[CreatureStats] = []
	for monster in monsters:
		monster_stats.append(monster.to_creature_stats())
	return monster_stats


func get_linda() -> CreatureStats:
	var linda = CreatureStats.new()
	linda.name = "Linda"
	linda.hit_points = 4
	linda.max_hit_points = 4
	linda.damage = 1
	linda.armor_class = 10
	linda.max_movement = 4
	linda.movement = 0
	linda.texture = load("res://Assets/graphics/sprites/Mage.tres")
	return linda


func get_leon() -> CreatureStats:
	var leon = CreatureStats.new()
	leon.name = "Leon"
	leon.max_hit_points = 20
	leon.hit_points = 20
	leon.damage = 2
	leon.armor_class = 15
	leon.max_movement = 3
	leon.movement = 0
	leon.texture = load("res://Assets/graphics/sprites/Fighter.tres")
	return leon
