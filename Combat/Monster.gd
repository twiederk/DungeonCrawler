class_name Monster
extends CharacterBody2D

signal attacked

const HitEffect = preload("res://Combat/HitEffect.tscn")

var _creature = Creature.new()

@onready var health_bar = $HealthBar


func _ready():
	health_bar.max_value = _creature.get_hit_points()
	health_bar.value = _creature.get_hit_points()


func get_creature() -> Creature:
	return _creature


func _on_Hurtbox_area_entered(_area) -> void:
	attacked.emit(self)


func _on_Creature_got_hurt() -> void:
	update_health_bar()
	display_hit_effect()


func update_health_bar() -> void:
	health_bar.value = _creature.get_hit_points()


func display_hit_effect() -> void:
	var hit_effect = HitEffect.instantiate()
	hit_effect.position = position
	get_parent().add_child(hit_effect)


func set_texture(texture: Texture2D) -> void:
	get_node("Sprite2D").texture = texture
