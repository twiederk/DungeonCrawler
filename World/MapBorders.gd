class_name MapBorders
extends Node2D

@onready var north_border = $NorthBorder
@onready var south_border = $SouthBorder
@onready var west_border = $WestBorder
@onready var east_border = $EastBorder


func configure_borders(limits: Vector2):
	north_border.position = Vector2(0, 0)
	west_border.position = Vector2(0, 0)
	south_border.position = Vector2(0, limits.y)
	east_border.position = Vector2(limits.x, limits.y)
