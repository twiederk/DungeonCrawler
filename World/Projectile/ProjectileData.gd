class_name ProjectileData
extends RefCounted

const stone_sprite_frames = preload("res://World/Projectile/Stone_SpriteFrames.tres")
const arrow_sprite_frames = preload("res://World/Projectile/Arrow_SpriteFrames.tres")
const bolt_sprite_frames = preload("res://World/Projectile/Bolt_SpriteFrames.tres")
const magic_missile_sprite_frames = preload("res://World/Projectile/MagicMissile_SpriteFrames.tres")
const acid_splash_sprite_frames = preload("res://World/Projectile/AcidSplash_SpriteFrames.tres")

var _projectile_dictionary: Dictionary


func init():
	_projectile_dictionary = {
		1: stone_sprite_frames,
		2: arrow_sprite_frames,
		3: bolt_sprite_frames,
		4: magic_missile_sprite_frames,
		5: acid_splash_sprite_frames,
	}


func get_projectile(id: int) -> SpriteFrames:
	if id == 0:
		return null
	return _projectile_dictionary[id]
