class_name LvlStats
extends Node

const START_LEVEL: String = "HirschhornCastleMap"

signal node_visited(path)
signal cell_cleared(vector)

var _visited_nodes = {}
var _cleared_cells = {}
var _current_level = START_LEVEL


func _ready():
	node_visited.connect(visited_node)
	cell_cleared.connect(cleared_cell)


func get_current_level() -> String:
	return _current_level


func set_current_level(level_name: String) -> void:
	_current_level = level_name


func visited_node(path: NodePath) -> void:
	var visited_nodes = get_visited_nodes()
	visited_nodes.append(str(path))


func get_visited_nodes(level_name: String = _current_level) -> Array:
	if not level_name in _visited_nodes:
		_visited_nodes[_current_level] = []
	return _visited_nodes[level_name]


func reset() -> void:
	_current_level = START_LEVEL
	_visited_nodes = {}
	_cleared_cells = {}


func cleared_cell(cell: Vector2) -> void:
	var cleared_cells = get_cleared_cells()
	if not cleared_cells.has(cell):
		cleared_cells.append(cell)


func get_cleared_cells(level_name: String = _current_level) -> Array[Vector2]:
	if not level_name in _cleared_cells:
		var cleared_cells_of_level: Array[Vector2] = []
		_cleared_cells[_current_level] = cleared_cells_of_level
	return _cleared_cells[level_name]
