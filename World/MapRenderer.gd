class_name MapRenderer
extends Node2D

onready var TileMap = $TileMap


func _ready() -> void:
	var map = load_file("res://Level/level_0.tres")
	make_map(map)


func make_map(map) -> void:
	TileMap.clear()
	for row in range(map.size()):
		for col in range(map[0].length()):
			var tileId: int = char_to_tile_id(map[row][col])
			TileMap.set_cellv(Vector2(col, row), tileId)


func load_file(fileName):
	var height_map = []
	var file = File.new()
	file.open(fileName, File.READ)
	while not file.eof_reached():
		height_map.append(file.get_line())
	file.close()
	return height_map


func char_to_tile_id(c: String) -> int:
	if (c.is_valid_integer()):
		return c.to_int()
	return ord(c) - 87

	
