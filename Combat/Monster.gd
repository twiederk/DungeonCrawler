class_name Monster
extends Battler

const HitEffectScene = preload("res://Combat/HitEffect.tscn")

@onready var health_bar = $HealthBar


func _ready():
	health_bar.max_value = _creature_stats.hit_points
	health_bar.value = _creature_stats.hit_points


func start_turn():
	super.start_turn()
	turn_ended.emit()


func hurt(damage: int) -> void:
	super.hurt(damage)
	update_health_bar()
	display_hit_effect()


func update_health_bar() -> void:
	health_bar.value = _creature_stats.hit_points


func display_hit_effect() -> void:
	var hit_effect = HitEffectScene.instantiate()
	hit_effect.position = position
	get_parent().add_child(hit_effect)
