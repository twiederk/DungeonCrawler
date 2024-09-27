class_name SpellResource
extends ItemResource

@warning_ignore("shadowed_global_identifier")
@export var range: int
@export var damage: Damage
@export var projectile: SpriteFrames


func has_projectile() -> bool:
	return projectile != null
