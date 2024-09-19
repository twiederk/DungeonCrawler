class_name BattleGrid
extends Node2D


func _input(_event):
	if Input.is_action_just_pressed("battle_grid"):
		visible = !visible


func _draw():
	for col in range(0, Battlefield.width, Battlefield.TILE_SIZE):
		draw_line(Vector2(col, 0), Vector2(col, Battlefield.height), Color.WHITE)
	for row in range(0, Battlefield.height, Battlefield.TILE_SIZE):
		draw_line(Vector2(0, row), Vector2(Battlefield.width, row), Color.WHITE)
