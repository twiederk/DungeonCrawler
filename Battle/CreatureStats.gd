class_name CreatureStats
extends Resource

signal hit_points_changed(hit_points: int)
signal max_hit_points_changed(max_hit_points: int)
signal movement_changed(movement: int)
signal max_movement_changed(max_movement: int)
signal weapon_changed(weapon: WeaponResource)
signal armor_changed(armor: ArmorResource)
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


@export var armor: ArmorResource:
	set(value):
		armor = value
		armor_changed.emit(armor)
		
@export var armor_class: int
@export var damage: int
@export var weapon: WeaponResource:
	set(value):
		weapon = value
		weapon_changed.emit(weapon)

@export var max_movement: int:
	set(value):
		max_movement = value
		max_movement_changed.emit(max_movement)

@export var movement: int:
	set(value):
		movement = value
		movement_changed.emit(movement)

@export var sprite_frames: Resource
@export var state: State = State.ALIVE:
	set(value):
		state = value
		state_changed.emit(state)

#
var inventory: Inventory = Inventory.new()
