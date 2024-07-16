class_name CreatureStats
extends Resource

signal hit_points_changed(hit_points: int)
signal max_hit_points_changed(max_hit_points: int)
signal state_changed(state_hit_points: State)

enum State { ALIVE, UNCONSCIOUS }

@export var name: String
@export var hit_points: int:
	set(value):
		hit_points = value
		hit_points_changed.emit(hit_points)


@export var max_hit_points: int:
	set(value):
		max_hit_points = value
		max_hit_points_changed.emit(max_hit_points)


@export var armor_class: int
@export var damage: int
@export var weapon: WeaponResource
@export var max_movement: int
@export var movement: int
@export var sprite_frames: Resource
@export var state: State = State.ALIVE:
	set(value):
		state = value
		state_changed.emit(state)
