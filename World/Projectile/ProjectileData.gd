class_name ProjectileData
extends RefCounted

const stone_sprite_frames = preload("res://World/Projectile/Stone_SpriteFrames.tres")
const magic_missile_sprite_frames = preload("res://World/Projectile/MagicMissile_SpriteFrames.tres")

var _projectile_data: Dictionary


func _init():
	_projectile_data = {
		1: stone_sprite_frames,
		2: magic_missile_sprite_frames,
	}


func get_sprite_frames(id: int) -> SpriteFrames:
	return _projectile_data[id]
