class_name Battlefield

const TILE_SIZE = 16
const directions: Array[Vector2] = [Vector2(1, 0), Vector2(0, 1), Vector2(-1, 0), Vector2(0, -1)]

var width: int = 20
var height: int = 12

var character_positions = []
var monster_positions = []


func as_string() -> Array[String]:
	var output: Array[String] = []
	for i in height:
		var line = "".rpad(width, "-")
		output.append(line)
	for character_position in character_positions:
		output[character_position.y][character_position.x] = "c"
	for monster_position in monster_positions:
		output[monster_position.y][monster_position.x] = "m"
	return output


func place_characters(characters: Array[Battler]) -> void:
	for x in characters.size():
		characters[x].position = Vector2((x + 1) * TILE_SIZE, 16)


func place_monsters(monsters: Array[Battler]) -> void:
	for x in monsters.size():
		monsters[x].position = Vector2((x + 3) * TILE_SIZE, 160)


func find_neighbors(position: Vector2) -> Array[Vector2]:
	var neighbors: Array[Vector2] = []
	for direction in directions:
		var neighbor = position + direction
		if is_on_battlefield(neighbor) and is_free(neighbor):
			neighbors.append(neighbor)
	return neighbors


func is_on_battlefield(position: Vector2) -> bool:
	return position.x >= 0 and position.x < width and position.y >= 0 and position.y < height


func is_free(position: Vector2) -> bool:
	return not character_positions.has(position) and not monster_positions.has(position)


func manhatten_distance(vector1: Vector2, vector2: Vector2) -> int:
	return abs(vector1.x - vector2.x) + abs (vector1.y - vector2.y)


func find_attack_positions() -> Array[Vector2]:
	var attack_positions: Array[Vector2] = []
	for character_position in character_positions:
		var free_neighbors = find_neighbors(character_position)
		attack_positions += free_neighbors
	return attack_positions


func find_nearest_attack_position(position: Vector2) -> Vector2:
	var attack_positions = find_attack_positions()
	attack_positions.sort_custom(func (pos1, pos2): return manhatten_distance(position, pos1) < manhatten_distance(position, pos2))
	return attack_positions[0]


func bfs(start: Vector2, target: Vector2):
	var seen: Array[Vector2] = []
	var queue: Array[Work] = [Work.new(null, start, 0)]

	while not queue.is_empty():
		var current = queue.pop_front()
		seen.append(current.position)
		if current.position == target:
			return current.to_path()

		for neighbor in find_neighbors(current.position):
			if not seen.has(neighbor):
				queue.append(Work.new(current, neighbor, current.steps + 1))
	return null


class Work:
	var parent: Work
	var position: Vector2
	var steps: int

	func _init(new_parent: Work, new_position: Vector2, new_steps: int):
		parent = new_parent
		position = new_position
		steps = new_steps

	func to_path() -> Array[Vector2]:
		var path: Array[Vector2] = [position]
		var current = parent
		while (current.parent != null):
			path.push_front(current.position)
			current = current.parent
		return path
