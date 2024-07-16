class_name CharacterWidget
extends Control

@onready var name_label: Label = $Panel/NameLabel
@onready var health_bar: ProgressBar = $Panel/HealthBar
@onready var texture_rect: TextureRect = $Panel/TextureRect
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var weapon: TextureRect = $Panel/Weapon


func assign_character_stats(character_stats: CreatureStats):
	name_label.text = character_stats.name
	_set_texture(character_stats.texture)
	health_bar.value = character_stats.hit_points
	health_bar.max_value = character_stats.max_hit_points
	weapon.texture = character_stats.weapon.texture
	character_stats.hit_points_changed.connect(_on_hit_points_changed)


func _set_texture(sprite_frames: SpriteFrames):
	var frame_texture = sprite_frames.get_frame_texture("default", 0)
	var atlas_texture: AtlasTexture = AtlasTexture.new()
	atlas_texture.atlas = frame_texture
	atlas_texture.region = Rect2(0, 0, 16, 16)
	texture_rect.texture = atlas_texture


func _on_hit_points_changed(hit_points: int):
	health_bar.value = hit_points


func _on_animated_sprite_2d_animation_finished():
	animated_sprite_2d.hide()


func _on_focus():
	weapon.show()


func _on_unfocus():
	weapon.hide()


func play_animation(animation_name: String):
	animated_sprite_2d.show()
	animated_sprite_2d.play(animation_name)
