class_name CharacterWidget
extends Control

@onready var name_label = $Panel/NameLabel
@onready var health_bar = $Panel/HealthBar
@onready var texture_rect = $Panel/TextureRect


func set_character_name(character_name: String):
	name_label.text = character_name


func set_texture(sprite_frames: SpriteFrames):
	var frame_texture = sprite_frames.get_frame_texture("default", 0)
	var atlas_texture: AtlasTexture = AtlasTexture.new()
	atlas_texture.atlas = frame_texture
	atlas_texture.region = Rect2(0, 0, 16, 16)
	texture_rect.texture = atlas_texture


func set_hit_points(hit_points: int):
	health_bar.value = hit_points


func set_max_hit_points(max_hit_points: int):
	health_bar.max_value = max_hit_points


func update_health_bar(hit_points: int):
	health_bar.value = hit_points
