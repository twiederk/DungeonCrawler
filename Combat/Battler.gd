class_name Battler
extends Area2D

signal battler_attacked(attacker, defender)
signal battler_died(battler)
signal turn_ended

enum CombatState {READY, DONE}

var _creature_stats = CreatureStats.new()
var _combat_state: CombatState = CombatState.DONE

@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var turn_indicator = $TurnIndicator


func start_turn():
	print(get_creature_name(), ".start_turn()")
	turn_indicator.show()
	_creature_stats.movement = _creature_stats.max_movement	
	_combat_state = CombatState.READY


func stop_turn():
	print(get_creature_name(), ".stop_turn()")
	turn_indicator.hide()
	_combat_state = CombatState.DONE


func step() -> void:
	_creature_stats.movement = _creature_stats.movement - 1


func roll_attack() -> int:
	return randi_range(1, 20)


func hurt(damage: int) -> void:
	_creature_stats.hit_points = _creature_stats.hit_points - damage
	if get_hit_points() <= 0:
		_creature_stats.hit_points = 0
		battler_died.emit(self)


func set_sprite_frames(sprite_frames: SpriteFrames) -> void:
	animated_sprite_2d.sprite_frames = sprite_frames
	animated_sprite_2d.play("default")


func get_creature() -> CreatureStats:
	return _creature_stats


func get_creature_name() -> String:
	return _creature_stats.name


func get_armor_class() -> int:
	return _creature_stats.armor_class


func get_damage() -> int:
	return _creature_stats.damage


func get_hit_points() -> int:
	return _creature_stats.hit_points
