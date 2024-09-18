class_name Battlefield
extends Node2D

const TILE_SIZE: int = 32
const width: int = 20 * TILE_SIZE
const height: int = 12 * TILE_SIZE
const directions: Array[Vector2] = [
	Vector2.RIGHT * TILE_SIZE,
	Vector2.DOWN * TILE_SIZE,
	Vector2.LEFT * TILE_SIZE,
	Vector2.UP *TILE_SIZE
]

var characters: Array[Battler] = []
var monsters: Array[Battler] = []
var battlers: Array[Battler] = []

var items: Array[Item] = []

@onready var character_start_markers = $CharacterStartMarkers
@onready var monster_start_markers = $MonsterStartMarkers


func as_string() -> Array[String]:
	var output: Array[String] = []
	@warning_ignore("integer_division")
	for i in height / TILE_SIZE:
		@warning_ignore("integer_division")
		output.append("".rpad(width / TILE_SIZE, "-"))
	for character in characters:
		var character_position: Vector2 = character.position / TILE_SIZE
		output[character_position.y][character_position.x] = "c"
	for monster in monsters:
		var monster_position: Vector2 = monster.position / TILE_SIZE
		output[monster_position.y][monster_position.x] = "m"
	return output


func place_characters(some_characters: Array[Battler]) -> void:
	characters = some_characters
	battlers.append_array(some_characters)
	var character_start_positions = character_start_markers.get_children()
	for index in characters.size():
		characters[index].position = character_start_positions[index].position


func place_monsters(some_monsters: Array[Battler]) -> void:
	monsters = some_monsters
	battlers.append_array(some_monsters)
	var monster_start_positions = monster_start_markers.get_children()
	for index in monsters.size():
		monsters[index].position = monster_start_positions[index].position


func find_neighbors(pos: Vector2) -> Array[Vector2]:
	var neighbors: Array[Vector2] = []
	for direction in directions:
		var neighbor = pos + direction
		if is_on_battlefield(neighbor) and is_free(neighbor):
			neighbors.append(neighbor)
	return neighbors


func is_on_battlefield(pos: Vector2) -> bool:
	return pos.x >= 0 and pos.x < width and pos.y >= 0 and pos.y < height


func is_free(pos: Vector2) -> bool:
	var map_position = func(battler: Battler): return battler.position
	var character_positions = characters.map(map_position)
	var monster_positions = monsters.map(map_position)
	return not character_positions.has(pos) and not monster_positions.has(pos)


func manhatten_distance(vector1: Vector2, vector2: Vector2) -> int:
	return abs(vector1.x - vector2.x) + abs (vector1.y - vector2.y)


func find_attack_positions() -> Array[Vector2]:
	var attack_positions: Array[Vector2] = []
	var character_positions = characters.map(func(battler: Battler): return battler.position)
	for character_position in character_positions:
		var free_neighbors = find_neighbors(character_position)
		attack_positions += free_neighbors
	return attack_positions


func find_nearest_attack_position(pos: Vector2) -> Vector2:
	var attack_positions = find_attack_positions()
	attack_positions.sort_custom(func (pos1, pos2): return manhatten_distance(pos, pos1) < manhatten_distance(pos, pos2))
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
