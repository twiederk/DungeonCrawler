class_name Knight
extends Area2D

const STEP: int = 64

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_right"):
		move(STEP, 0)
	if Input.is_action_just_pressed("ui_left"):
		move(-STEP, 0)
	if Input.is_action_just_pressed("ui_up"):
		move(0, -STEP)
	if Input.is_action_just_pressed("ui_down"):
		move(0, STEP)
	
func move(x: int, y: int) -> void:
	position.x += x
	position.y += y
