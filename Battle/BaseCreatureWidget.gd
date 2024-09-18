class_name BaseCreatureWidget
extends Control

var _creature_stats: CreatureStats

@onready var name_label: Label = $Panel/NameLabel
@onready var image_texture_rect: TextureRect = $Panel/ImageTextureRect
@onready var health_bar: ProgressBar = $Panel/HealthBar
@onready var movement_bar: ProgressBar = $Panel/MovementBar
@onready var weapon: TextureRect = $Panel/Weapon
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D


func assign_creature_stats(creature_stats: CreatureStats):
	_creature_stats = creature_stats
	name_label.text = creature_stats.name
	health_bar.value = creature_stats.hit_points
	health_bar.max_value = creature_stats.max_hit_points
	movement_bar.value = creature_stats.movement
	movement_bar.max_value = creature_stats.max_movement
	weapon.texture = creature_stats.weapon.texture
	_on_state_changed(creature_stats.state)
	creature_stats.hit_points_changed.connect(_on_hit_points_changed)
	creature_stats.max_hit_points_changed.connect(_on_max_hit_points_changed)
	creature_stats.movement_changed.connect(_on_movement_changed)
	creature_stats.max_movement_changed.connect(_on_max_movement_changed)
	creature_stats.weapon_changed.connect(_on_weapon_changed)
	creature_stats.state_changed.connect(_on_state_changed)


func _set_texture(animation_name: String):
	var frame_texture = _creature_stats.sprite_frames.get_frame_texture(animation_name, 0)
	var atlas_texture: AtlasTexture = AtlasTexture.new()
	atlas_texture.atlas = frame_texture
	atlas_texture.region = Rect2(0, 0, 32, 32)
	image_texture_rect.texture = atlas_texture


func _on_hit_points_changed(hit_points: int):
	health_bar.value = hit_points


func _on_max_hit_points_changed(max_hit_points: int):
	health_bar.max_value = max_hit_points


func _on_movement_changed(movement: int):
	movement_bar.value = _creature_stats.max_movement - movement


func _on_max_movement_changed(max_movement: int):
	movement_bar.max_value = max_movement


func _on_weapon_changed(changed_weapon: WeaponResource):
	weapon.texture = changed_weapon.texture


@warning_ignore("unused_parameter")
func _on_state_changed(state: CreatureStats.State):
	pass


func _on_animated_sprite_2d_animation_finished():
	animated_sprite_2d.hide()


func _on_focus():
	weapon.show()
	movement_bar.show()


func _on_unfocus():
	weapon.hide()
	movement_bar.hide()


func play_animation(animation_name: String):
	animated_sprite_2d.show()
	animated_sprite_2d.play(animation_name)
