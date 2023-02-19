class_name Cove
extends Node2D

onready var tile_map = $TileMap

const TOWNS = [
	"BRITAIN.ULT",
	"COVE.ULT",
	"DEN.ULT",
	"EMPATH.ULT",
	"JHELOM.ULT",
	"LCB_1.ULT",
	"LCB_2.ULT",
	"LYCAEUM.ULT",
	"MAGINCIA.ULT",
	"MINOC.ULT",
	"MOONGLOW.ULT",
	"PAWS.ULT",
	"SERPENT.ULT",
	"SKARA.ULT",
	"TRINSIC.ULT",
	"VESPER.ULT",
	"YEW.ULT",
]

func _ready():
#	load_town()
	load_world()


func load_town():
	var file = File.new()
	file.open("res://Assets/ult/LCB_2.ULT", File.READ)
	for index in range(1024):
		var tile_id = file.get_8()
		var tile_vector = Vector2(tile_id % 16, tile_id / 16)
		tile_map.set_cellv(Vector2(index % 32, index / 32), 0, false, false, false, tile_vector)
	file.close()


func load_world():
	var file = File.new()
	file.open("res://Assets/ult/WORLD.MAP", File.READ)
	for chunk_col in range(8):
		for chunk_row in range(8):
			for index in range(1024):
				var tile_id = file.get_8()
				var tile_vector = Vector2(tile_id % 16, tile_id / 16)
				tile_map.set_cellv(Vector2(
					(chunk_row * 32) + (index % 32),
					(chunk_col * 32) + (index / 32)),
					 0, false, false, false, tile_vector)
	file.close()

