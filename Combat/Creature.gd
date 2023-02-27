class_name Creature
extends RefCounted

signal got_hurt

var _name: String = ""
var _hit_points: int = 0
var _armor_class: int
var _damage: int


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


func roll_attack() -> int:
	return randi() % 20 + 1


func hurt(damage: int) -> void:
	_hit_points = _hit_points - damage
	got_hurt.emit()


