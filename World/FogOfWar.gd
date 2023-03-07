class_name FogOfWar
extends TileMap

const LIGHT_RADIUS: int = 2

func _ready():
	visible = true
	var player = get_tree().get_nodes_in_group("player")[0]
	clear_fog(player.position, LIGHT_RADIUS)


func clear_fog(center: Vector2, radius: int) -> Array[Vector2]:
	var map_position = local_to_map(center)
	var cells_to_clear = _cells_to_clear(map_position, radius)
	for cell in cells_to_clear:
		erase_cell(0, cell)
	return cells_to_clear


func _cells_to_clear(map_position: Vector2, radius: int) -> Array[Vector2]:
	var cells_to_clear: Array[Vector2] = []
	var light_matrix = _create_light_matrix(radius)
	for light_vector in light_matrix:
		cells_to_clear.append(map_position + light_vector)
	return cells_to_clear


func _create_light_matrix(radius: int) -> Array[Vector2]:
	var light_matrix: Array[Vector2] = []
	for y in range(radius + 1):
		for x in range(radius + 1):
			if x + y <= radius:
				var light_vector = Vector2(x, y)
				light_matrix.append(light_vector)
				var mirrors = _mirror_vector(light_vector)
				for mirror in mirrors:
					light_matrix.append(mirror)
	return light_matrix


func _mirror_vector(vector: Vector2) -> Array[Vector2]:
	if vector == Vector2.ZERO:
		return []
	elif vector.y == 0:
		return [Vector2(-vector.x, 0)]
	elif vector.x == 0:
		return [Vector2(0, -vector.y)]
	else:
		return [Vector2(-vector.x, vector.y), Vector2(vector.x, -vector.y), Vector2(-vector.x, -vector.y)]


func _on_avatar_position_changed(position):
	clear_fog(position, LIGHT_RADIUS)
