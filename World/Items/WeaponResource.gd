class_name WeaponResource
extends ItemResource

enum WeaponType { MELEE_WEAPON, RANGED_WEAPON }

@export var damage: Damage
@export var weapon_type: WeaponType
@warning_ignore("shadowed_global_identifier")
@export var range: int
@export var projectile: SpriteFrames


func has_projectile() -> bool:
	return projectile != null
