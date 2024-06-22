class_name Monster
extends Battler

var path : Array[Vector2] = []

@onready var movement_timer = $MovementTimer


func start_turn(battlefield: Battlefield):
	super.start_turn(battlefield)
	if get_target() != null:
		attack()
	else:
		move(battlefield)


func move(battlefield: Battlefield):
	var attack_position = battlefield.find_nearest_attack_position(get_battlefield_position())
	path = battlefield.bfs(get_battlefield_position(), attack_position)
	move_animation()
	#for movement in get_max_movement():
		#if movement >= path.size():
			#break
		#position = path[movement] * Battlefield.TILE_SIZE
		#await get_tree().create_timer(0.6).timeout

func move_animation():
	if get_movement() < get_max_movement() && get_movement() < path.size():
		position = path[get_movement()] * Battlefield.TILE_SIZE
		step()
		movement_timer.start()
	else:
		attack()
	

func get_target():
	for facing in Battler.Facing.values():
		var collider = _ray_casts[facing].get_collider()
		if collider != null and collider is Character:
			return collider
	return null


