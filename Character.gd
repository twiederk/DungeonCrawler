class_name Character
extends KinematicBody2D

const STEP: int = 64

func _process(_delta: float) -> void:
	var currentPosition = Vector2(position)
	var velocity = calculateVelocity()
	var collider = move_and_collide(velocity)
	position = snap_to_grid(collider, currentPosition)
	
func calculateVelocity() -> Vector2:
	var velocity = Vector2.ZERO
	if Input.is_action_just_pressed("ui_right"):
		velocity = Vector2(STEP, 0)
	if Input.is_action_just_pressed("ui_left"):
		velocity = Vector2(-STEP, 0)
	if Input.is_action_just_pressed("ui_up"):
		velocity = Vector2(0, -STEP)
	if Input.is_action_just_pressed("ui_down"):
		velocity = Vector2(0, STEP)
	return velocity
	
func snap_to_grid(collider: KinematicCollision2D, currentPosition: Vector2) -> Vector2:
	if collider:
		return currentPosition
	return position
	
