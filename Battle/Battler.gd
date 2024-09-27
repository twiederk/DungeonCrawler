class_name Battler
extends Area2D

const ProjectileScene = preload("res://Battle/Projectile.tscn")
const MagicBulletSpriteFrames = preload("res://World/Projectile/MagicMissile_SpriteFrames.tres")

signal battler_hurt(hit_points)
signal battler_died(battler)
signal turn_started
signal turn_ended

enum BattleState { READY, TARGETING, DONE, DEAD }

const HitEffectScene: PackedScene = preload("res://Battle/HitEffect.tscn")
const DamagePopupScene: PackedScene = preload("res://Battle/DamagePopup.tscn")

var _logger = Logger.new()
var _creature_stats = CreatureStats.new()
var _battle_state: BattleState = BattleState.DONE
var _ray_casts: Dictionary = {}
var _target: Battler
var _battlefield: Battlefield

@onready var turn_indicator = $TurnIndicator
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var health_bar: ProgressBar = $HealthBar
@onready var audio_stream_player = $AudioStreamPlayer
@onready var ray_cast_left: RayCast2D = $RayCastLeft
@onready var ray_cast_right: RayCast2D = $RayCastRight
@onready var ray_cast_up: RayCast2D = $RayCastUp
@onready var ray_cast_down: RayCast2D = $RayCastDown


func _ready():
	init_hit_points()
	init_animated_sprite()
	init_ray_casts_dictionary()
	animated_sprite_2d.animation_finished.connect(_on_animation_finished)


func init_hit_points():
	health_bar.max_value = _creature_stats.max_hit_points
	health_bar.value = _creature_stats.hit_points


func init_animated_sprite():
	set_sprite_frames(_creature_stats.sprite_frames)
	var number_of_frames = animated_sprite_2d.sprite_frames.get_frame_count("idle")
	animated_sprite_2d.frame = randi_range(0, number_of_frames)
	animated_sprite_2d.play("idle")


func init_ray_casts_dictionary():
	_ray_casts[Vector2.RIGHT] = ray_cast_right
	_ray_casts[Vector2.DOWN] = ray_cast_down
	_ray_casts[Vector2.LEFT] = ray_cast_left
	_ray_casts[Vector2.UP] = ray_cast_up


func start_turn():
	_logger.debug(str(get_creature_name(), ".start_turn()"))
	MessageBus.message_send.emit(str("[color=green]", get_creature_name().to_upper(), "[/color]", " ist am Zug."))
	turn_indicator.show()
	set_movement(0)
	_battle_state = BattleState.READY
	turn_started.emit()


func stop_turn():
	_logger.debug(str(get_creature_name(), ".stop_turn()"))
	turn_indicator.hide()
	_battle_state = BattleState.DONE


func step():
	_logger.debug(str(get_creature_name(), ".step()"))
	set_movement(get_movement() + 1)


func _on_animation_finished():
	_logger.debug(str("Battler._on_animation_finished()"))
	audio_stream_player.play()
	GameSystem.attack(self, _target)
	animated_sprite_2d.play("idle")
	turn_ended.emit()


func roll_attack() -> int:
	return randi_range(1, 20)


func hurt(damage: int):
	_logger.debug(str("Battler.hurt()"))
	set_hit_points(get_hit_points() - damage)
	battler_hurt.emit(get_hit_points())
	update_health_bar()
	display_hit_effect()
	display_damage_popup(damage)
	if get_hit_points() <= 0:
		dead()


func dead():
	_logger.debug(str("Battler.dead()"))
	animated_sprite_2d.animation_finished.disconnect(_on_animation_finished)
	set_hit_points(0)
	_battle_state = BattleState.DEAD
	set_state(CreatureStats.State.UNCONSCIOUS)
	battler_died.emit(self)


func display_hit_effect():
	var hit_effect = HitEffectScene.instantiate()
	hit_effect.position = position
	get_parent().add_child(hit_effect)


func display_damage_popup(damage: int):
	var damage_popup: DamagePopup = DamagePopupScene.instantiate()
	damage_popup.set_damage_text(damage)
	damage_popup.position = global_position
	get_tree().current_scene.add_child(damage_popup)


func update_health_bar():
	health_bar.value = _creature_stats.hit_points


func is_melee_weapon() -> bool:
	return get_action() is WeaponResource and get_action().weapon_type == WeaponResource.WeaponType.MELEE_WEAPON


func attack_animation(target: Battler):
	if is_melee_weapon():
		animated_sprite_2d.play("attack")
	else:
		create_projectile(target.position)


func create_projectile(target: Vector2):
	var projectile : Projectile = ProjectileScene.instantiate()
	projectile.position = position
	projectile.set_destination(target)
	projectile.destination_reached.connect(_on_animation_finished)
	_battlefield.add_child(projectile)
	if get_action() is SpellResource:
		projectile.set_sprite_frames(MagicBulletSpriteFrames)


func set_sprite_frames(sprite_frames: SpriteFrames):
	animated_sprite_2d.sprite_frames = sprite_frames
	animated_sprite_2d.play("idle")


func set_battlefield(battlefield: Battlefield):
	_battlefield = battlefield


func get_creature() -> CreatureStats:
	return _creature_stats


func set_creature(creature_stats: CreatureStats):
	_creature_stats = creature_stats


func get_creature_name() -> String:
	return _creature_stats.name


func set_creature_name(new_name: String):
	_creature_stats.name = new_name


func get_armor_class() -> int:
	return _creature_stats.armor_class


func set_armor_class(armor_class: int):
	_creature_stats.armor_class = armor_class


func get_damage() -> int:
	return _creature_stats.action.damage.roll()


func get_action() -> ItemResource:
	return _creature_stats.action


func set_action(action: ItemResource):
	_creature_stats.action = action


func get_hit_points() -> int:
	return _creature_stats.hit_points


func set_hit_points(hit_points: int):
	_creature_stats.hit_points = hit_points


func get_movement() -> int:
	return _creature_stats.movement


func set_movement(movement: int):
	_creature_stats.movement = movement


func get_max_movement() -> int:
	return _creature_stats.max_movement


func set_max_movement(max_movement: int):
	_creature_stats.max_movement = max_movement


func set_state(state: CreatureStats.State):
	_creature_stats.state = state
