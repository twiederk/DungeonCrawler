class_name Battler
extends Area2D

signal battler_attacked(attacker, defender)
signal battler_died(battler)
signal turn_ended

enum CombatState {READY, DONE}
enum Facing { RIGHT = 0, DOWN = 90, LEFT = 180, UP = 270 }

const HitEffectScene = preload("res://Combat/HitEffect.tscn")

var _creature_stats = CreatureStats.new()
var _combat_state: CombatState = CombatState.DONE
var _ray_casts: Dictionary = {}

@onready var turn_indicator = $TurnIndicator
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var health_bar = $HealthBar
@onready var animationPlayer = $AnimationPlayer
@onready var ray_cast_left = $RayCastLeft
@onready var ray_cast_right = $RayCastRight
@onready var ray_cast_up = $RayCastUp
@onready var ray_cast_down = $RayCastDown


func _ready():
	health_bar.max_value = _creature_stats.hit_points
	health_bar.value = _creature_stats.hit_points
	_ray_casts[Facing.RIGHT] = ray_cast_right
	_ray_casts[Facing.DOWN] = ray_cast_down
	_ray_casts[Facing.LEFT] = ray_cast_left
	_ray_casts[Facing.UP] = ray_cast_up


func start_turn(battlefield: Battlefield):
	#print(get_creature_name(), ".start_turn()")
	turn_indicator.show()
	set_movement(get_max_movement())
	_combat_state = CombatState.READY


func stop_turn():
	#print(get_creature_name(), ".stop_turn()")
	turn_indicator.hide()
	_combat_state = CombatState.DONE


func step() -> void:
	#print(get_creature_name(), ".step()")
	set_movement(get_movement() - 1)


func attack() -> void:
	#print(get_creature_name(), ".attack()")
	var target = get_target()
	if target != null:
		animationPlayer.play("Attack")
		battler_attacked.emit(self, target)
	turn_ended.emit()


func get_target():
	pass


func roll_attack() -> int:
	return randi_range(1, 20)


func hurt(damage: int) -> void:
	set_hit_points(get_hit_points() - damage)
	update_health_bar()
	display_hit_effect()
	if get_hit_points() <= 0:
		set_hit_points(0)
		battler_died.emit(self)


func display_hit_effect() -> void:
	var hit_effect = HitEffectScene.instantiate()
	hit_effect.position = position
	get_parent().add_child(hit_effect)


func set_sprite_frames(sprite_frames: SpriteFrames) -> void:
	animated_sprite_2d.sprite_frames = sprite_frames
	animated_sprite_2d.play("default")


func update_health_bar() -> void:
	health_bar.value = _creature_stats.hit_points


func get_creature() -> CreatureStats:
	return _creature_stats


func set_creature(creature_stats: CreatureStats) -> void:
	_creature_stats = creature_stats


func get_creature_name() -> String:
	return _creature_stats.name


func set_creature_name(new_name: String) -> void:
	_creature_stats.name = new_name


func get_armor_class() -> int:
	return _creature_stats.armor_class


func set_armor_class(armor_class: int) -> void:
	_creature_stats.armor_class = armor_class


func get_damage() -> int:
	return _creature_stats.damage


func set_damage(damage: int) -> void:
	_creature_stats.damage = damage


func get_hit_points() -> int:
	return _creature_stats.hit_points


func set_hit_points(hit_points: int) -> void:
	_creature_stats.hit_points = hit_points


func get_movement() -> int:
	return _creature_stats.movement


func set_movement(movement: int) -> void:
	_creature_stats.movement = movement


func get_max_movement() -> int:
	return _creature_stats.max_movement


func set_max_movement(max_movement: int) -> void:
	_creature_stats.max_movement = max_movement


func degree_to_facing(degree: int) -> Facing:
	match degree:
		0:
			return Battler.Facing.RIGHT
		90:
			return Battler.Facing.DOWN
		180:
			return Battler.Facing.LEFT
		270:
			return Battler.Facing.UP
		_:
			return Battler.Facing.RIGHT


func get_battlefield_position() -> Vector2:
	return position / Battlefield.TILE_SIZE
