class_name Avatar
extends CharacterBody2D

signal position_changed(position)

const TILE_SIZE = 16

@onready var ray_cast_left = $RayCastLeft
@onready var ray_cast_right = $RayCastRight
@onready var ray_cast_up = $RayCastUp
@onready var ray_cast_down = $RayCastDown
@onready var camera_2d = $Camera2D


func _ready():
	if PlayerStats.start_position != Vector2.ZERO:
		position = PlayerStats.start_position


func _physics_process(_delta):
	if Input.is_action_just_pressed("ui_right"):
		if not ray_cast_right.is_colliding():
			position += Vector2(TILE_SIZE, 0)
			position_changed.emit(position)
	if Input.is_action_just_pressed("ui_left"):
		if not ray_cast_left.is_colliding():
			position += Vector2(-TILE_SIZE, 0)
			position_changed.emit(position)
	if Input.is_action_just_pressed("ui_up"):
		if not ray_cast_up.is_colliding():
			position += Vector2(0, -TILE_SIZE)
			position_changed.emit(position)
	if Input.is_action_just_pressed("ui_down"):
		if not ray_cast_down.is_colliding():
			position += Vector2(0, TILE_SIZE)
			position_changed.emit(position)


func set_camera_limits(limits: Vector2) -> void:
	camera_2d.set_limit(SIDE_RIGHT, limits.x)
	camera_2d.set_limit(SIDE_BOTTOM, limits.y)
