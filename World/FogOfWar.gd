class_name FogOfWar
extends TileMap

const LIGHT_RADIUS: int = 2
const FOG_OF_WAR_LAYER: int = 0

func _ready():
	visible = true
	var player = get_tree().get_nodes_in_group("player")[0]
	restore_cleared_cells(LevelStats)
	clear_fog(player.position, LIGHT_RADIUS)


func clear_fog(center: Vector2, radius: int) -> Array[Vector2]:
	var map_position = local_to_map(center)
	var cells_to_clear = _cells_to_clear(map_position, radius)
	for cell in cells_to_clear:
		LevelStats.cell_cleared.emit(cell)
		erase_cell(FOG_OF_WAR_LAYER, cell)
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
			append_light_vectors(light_matrix, radius, x, y)
	return light_matrix


func append_light_vectors(light_matrix: Array[Vector2], radius: int, x: int, y: int) -> void:
	if x + y <= radius:
		var light_vector = Vector2(x, y)
		light_matrix.append(light_vector)
		var mirrors = _mirror_vector(light_vector)
		for mirror in mirrors:
			light_matrix.append(mirror)


func _mirror_vector(vector: Vector2) -> Array[Vector2]:
	if vector == Vector2.ZERO:
		return []
	elif vector.y == 0:
		return [Vector2(-vector.x, 0)]
	elif vector.x == 0:
		return [Vector2(0, -vector.y)]
	else:
		return [Vector2(-vector.x, vector.y), Vector2(vector.x, -vector.y), Vector2(-vector.x, -vector.y)]


func _on_avatar_position_changed(avatar_position) -> void:
	clear_fog(avatar_position, LIGHT_RADIUS)


func restore_cleared_cells(level_stats: LvlStats) -> void:
	var cleared_cells = level_stats.get_cleared_cells()
	for cell in cleared_cells:
		erase_cell(FOG_OF_WAR_LAYER, cell)
