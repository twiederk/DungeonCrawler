class_name Monster
extends KinematicBody2D

var _creature = Creature.new()

signal attacked


func get_creature() -> Creature:
	return _creature


func _on_Hurtbox_area_entered(_area):
	emit_signal("attacked", self)

