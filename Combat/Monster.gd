class_name Monster
extends CharacterBody2D

signal attacked

var _creature = Creature.new()

@onready var audioStreamPlayer = $AudioStreamPlayer
@onready var health_bar = $HealthBar


func _ready():
	health_bar.max_value = _creature.get_hit_points()
	health_bar.value = _creature.get_hit_points()


func get_creature() -> Creature:
	return _creature


func _on_Hurtbox_area_entered(_area) -> void:
	attacked.emit(self)


func _on_Creature_got_hurt() -> void:
	health_bar.value = _creature.get_hit_points()
	audioStreamPlayer.play()


func set_texture(texture: Texture2D) -> void:
	get_node("Sprite2D").texture = texture
