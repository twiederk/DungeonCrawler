class_name Monster
extends KinematicBody2D

signal attacked

var _creature = Creature.new()

onready var audioStreamPlayer = $AudioStreamPlayer


func get_creature() -> Creature:
	return _creature


func _on_Hurtbox_area_entered(_area) -> void:
	emit_signal("attacked", self)


func _on_Creature_got_hurt() -> void:
	audioStreamPlayer.play()
