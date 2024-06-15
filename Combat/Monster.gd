class_name Monster
extends Battler



func start_turn():
	super.start_turn()
	attack()


func get_target():
	for facing in Battler.Facing.values():
		var collider = _ray_casts[facing].get_collider()
		if collider != null and collider is Character:
			return collider
	return null
