class_name CharacterWidget
extends Control

var _creature_stats: CreatureStats

@onready var name_label: Label = $Panel/NameLabel
@onready var health_bar: ProgressBar = $Panel/HealthBar
@onready var texture_rect: TextureRect = $Panel/TextureRect
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var weapon: TextureRect = $Panel/Weapon


func assign_creature_stats(creature_stats: CreatureStats):
	_creature_stats = creature_stats
	name_label.text = creature_stats.name
	health_bar.value = creature_stats.hit_points
	health_bar.max_value = creature_stats.max_hit_points
	weapon.texture = creature_stats.weapon.texture
	_on_state_changed(creature_stats.state)
	creature_stats.hit_points_changed.connect(_on_hit_points_changed)
	creature_stats.max_hit_points_changed.connect(_on_max_hit_points_changed)
	creature_stats.state_changed.connect(_on_state_changed)


func _set_texture(animation_name: String):
	var frame_texture = _creature_stats.texture.get_frame_texture(animation_name, 0)
	var atlas_texture: AtlasTexture = AtlasTexture.new()
	atlas_texture.atlas = frame_texture
	atlas_texture.region = Rect2(0, 0, 16, 16)
	texture_rect.texture = atlas_texture


func _on_hit_points_changed(hit_points: int):
	health_bar.value = hit_points


func _on_max_hit_points_changed(max_hit_points: int):
	health_bar.max_value = max_hit_points


func _on_state_changed(state: CreatureStats.State):
	match state:
		CreatureStats.State.UNCONSCIOUS:
			_set_texture("dead")
		_:
			_set_texture("default")


func _on_animated_sprite_2d_animation_finished():
	animated_sprite_2d.hide()


func _on_focus():
	weapon.show()


func _on_unfocus():
	weapon.hide()


func play_animation(animation_name: String):
	animated_sprite_2d.show()
	animated_sprite_2d.play(animation_name)
