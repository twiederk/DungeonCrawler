class_name WeaponResource
extends ItemResource

enum WeaponType { MELEE_WEAPON, RANGED_WEAPON }

@export var damage: Damage
@export var weapon_type: WeaponType
