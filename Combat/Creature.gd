class_name Creature
extends RefCounted

enum CombatState {READY, DONE}

signal got_hurt

var _name: String = ""
var _hit_points: int = 0
var _armor_class: int
var _damage: int
var _max_movement: int = 4
var _movement: int = _max_movement
var _combat_state: CombatState = CombatState.READY


func get_name() -> String:
	return _name


func set_name(name: String) -> void:
	_name = name


func get_hit_points() -> int:
	return _hit_points


func set_hit_points(hit_points: int) -> void:
	_hit_points = hit_points


func get_armor_class() -> int:
	return _armor_class


func set_armor_class(armor_class: int) -> void:
	_armor_class = armor_class


func get_damage() -> int:
	return _damage


func set_damage(damage: int) -> void:
	_damage = damage


func get_movement() -> int:
	return _movement


func set_movement(movement: int) -> void:
	_movement = movement


func get_max_movement() -> int:
	return _max_movement


func set_max_movement(max_movement: int) -> void:
	_max_movement = max_movement


func get_combat_state() -> CombatState:
	return _combat_state


func set_combat_state(combat_state: CombatState) -> void:
	_combat_state = combat_state


func roll_attack() -> int:
	return randi() % 20 + 1


func hurt(damage: int) -> void:
	_hit_points = _hit_points - damage
	got_hurt.emit()


func step() -> void:
	set_movement(get_movement() - 1)


func can_move() -> bool:
	return _movement > 0


func is_done() -> bool:
	return _combat_state == CombatState.DONE


func start_combat_round() -> void:
	_movement = _max_movement
	_combat_state = CombatState.READY


func attack() -> void:
	_combat_state = CombatState.DONE
