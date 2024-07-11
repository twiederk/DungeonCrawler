class_name CreatureStats
extends Resource

signal hit_points_changed(hit_points: int)

@export var name: String
@export var hit_points: int:
	set(value):
		hit_points = value
		hit_points_changed.emit(hit_points)
@export var max_hit_points: int
@export var armor_class: int
@export var damage: int
@export var weapon: WeaponResource
@export var max_movement: int
@export var movement: int
@export var texture: Resource
