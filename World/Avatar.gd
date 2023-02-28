class_name Avatar
extends CharacterBody2D


const TILE_SIZE = 16

@onready var ray_cast_left = $RayCastLeft
@onready var ray_cast_right = $RayCastRight
@onready var ray_cast_up = $RayCastUp
@onready var ray_cast_down = $RayCastDown


func _ready():
	if PlayerStats.start_position != Vector2.ZERO:
		position = PlayerStats.start_position


func _physics_process(_delta):
	if Input.is_action_just_pressed("ui_right"):
		if not ray_cast_right.is_colliding():
			position += Vector2(TILE_SIZE, 0)
	if Input.is_action_just_pressed("ui_left"):
		if not ray_cast_left.is_colliding():
			position += Vector2(-TILE_SIZE, 0)
	if Input.is_action_just_pressed("ui_up"):
		if not ray_cast_up.is_colliding():
			position += Vector2(0, -TILE_SIZE)
	if Input.is_action_just_pressed("ui_down"):
		if not ray_cast_down.is_colliding():
			position += Vector2(0, TILE_SIZE)
			
