class_name Avatar
extends CharacterBody2D

signal position_changed(position)

const TILE_SIZE: int = 16
const UP = Vector2(0, -TILE_SIZE)
const DOWN = Vector2(0, TILE_SIZE)
const LEFT = Vector2(-TILE_SIZE, 0)
const RIGHT = Vector2(TILE_SIZE, 0)

@export var KEY_LOCKED_THRESHOLD: float
@export var KEY_PRESSED_THRESHOLD: float

var key_locked_mode: bool = false
var key_locked_time: float = 0.0
var key_pressed_time: float = KEY_PRESSED_THRESHOLD

@onready var ray_cast_left = $RayCastLeft
@onready var ray_cast_right = $RayCastRight
@onready var ray_cast_up = $RayCastUp
@onready var ray_cast_down = $RayCastDown
@onready var camera_2d = $Camera2D


func _ready():
	if PlayerStats.start_position != Vector2.ZERO:
		position = PlayerStats.start_position


func _physics_process(delta):
	key_movement()
	lock_key_movement(delta)


func key_movement():
	if Input.is_action_just_pressed("ui_right"):
		move(ray_cast_right, RIGHT)
	if Input.is_action_just_pressed("ui_left"):
		move(ray_cast_left, LEFT)
	if Input.is_action_just_pressed("ui_up"):
		move(ray_cast_up, UP)
	if Input.is_action_just_pressed("ui_down"):
		move(ray_cast_down, DOWN)


func lock_key_movement(delta: float):
	lock_key_mode(delta)
	lock_key_move(delta)


func lock_key_mode(delta: float):
	if Input.is_action_pressed("ui_right") or Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_up") or Input.is_action_pressed("ui_down"):
		key_locked_time += delta
		if key_locked_time >= KEY_LOCKED_THRESHOLD:
			key_locked_mode = true
	if Input.is_action_just_released("ui_right") or Input.is_action_just_released("ui_left") or Input.is_action_just_released("ui_up") or Input.is_action_just_released("ui_down"):
		key_locked_mode = false
		key_locked_time = 0.0


func lock_key_move(delta: float):
	if key_locked_mode:
		key_pressed_time += delta
		if key_pressed_time >= KEY_PRESSED_THRESHOLD:
			key_pressed_time = 0.0
			if Input.is_action_pressed("ui_right"):
				move(ray_cast_right, RIGHT)
			if Input.is_action_pressed("ui_left"):
				move(ray_cast_left, LEFT)
			if Input.is_action_pressed("ui_up"):
				move(ray_cast_up, UP)
			if Input.is_action_pressed("ui_down"):
				move(ray_cast_down, DOWN)


func move(ray_cast: RayCast2D, direction: Vector2):
	if not ray_cast.is_colliding():
		position += direction
		position_changed.emit(position)


func set_camera_limits(limits: Vector2) -> void:
	camera_2d.set_limit(SIDE_RIGHT, limits.x)
	camera_2d.set_limit(SIDE_BOTTOM, limits.y)
