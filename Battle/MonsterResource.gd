class_name MonsterResource
extends Resource

@export var name: String
@export var hit_points: int
@export var armor_class: int
@export var damage: int
@export var texture: Resource
@export var max_movement: int

func to_creature_stats() -> CreatureStats:
	var creature_stats = CreatureStats.new()
	creature_stats.name = name
	creature_stats.hit_points = hit_points
	creature_stats.max_hit_points = hit_points
	creature_stats.armor_class = armor_class
	creature_stats.damage = damage
	creature_stats.texture = texture
	creature_stats.max_movement = max_movement
	return creature_stats
