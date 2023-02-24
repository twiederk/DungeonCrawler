class_name MonsterBody2D
extends CharacterBody2D

signal attacked

var _creature = Creature.new()

@onready var audioStreamPlayer = $AudioStreamPlayer


func get_creature() -> Creature:
	return _creature


func _on_Hurtbox_area_entered(_area) -> void:
	attacked.emit(self)


func _on_Creature_got_hurt() -> void:
	audioStreamPlayer.play()


func set_texture(texture: Texture2D) -> void:
	get_node("Sprite2D").texture = texture
