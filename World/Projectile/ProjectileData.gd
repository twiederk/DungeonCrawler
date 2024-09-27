class_name ProjectileData
extends RefCounted

const stone_sprite_frames = preload("res://World/Projectile/Stone_SpriteFrames.tres")
const magic_missile_sprite_frames = preload("res://World/Projectile/MagicMissile_SpriteFrames.tres")

var _projectile_dictionary: Dictionary


func init():
	_projectile_dictionary = {
		1: stone_sprite_frames,
		2: stone_sprite_frames,
		3: stone_sprite_frames,
		4: magic_missile_sprite_frames,
		5: magic_missile_sprite_frames,
	}


func get_projectile(id: int) -> SpriteFrames:
	if id == 0:
		return null
	return _projectile_dictionary[id]
