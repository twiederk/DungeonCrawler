class_name Monster
extends Battler


func start_turn(battlefield: Battlefield):
	super.start_turn(battlefield)
	if get_target() != null:
		attack()
	else:
		move(battlefield)
		attack()


func move(battlefield: Battlefield):
	var attack_position = battlefield.find_nearest_attack_position(get_battlefield_position())
	var path = battlefield.bfs(get_battlefield_position(), attack_position)
	for movement in get_max_movement():
		if movement >= path.size():
			break
		position = path[movement] * Battlefield.TILE_SIZE
		await get_tree().create_timer(0.6).timeout


func get_target():
	for facing in Battler.Facing.values():
		var collider = _ray_casts[facing].get_collider()
		if collider != null and collider is Character:
			return collider
	return null
