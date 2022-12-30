class_name Character
extends KinematicBody2D

const STEP: int = 32

onready var animationPlayer = $AnimationPlayer
onready var hitboxCollisionShape = $HitboxPivot/Hitbox/CollisionShape2D
onready var hitboxPivot = $HitboxPivot

var _creature = Creature.new()


func _ready():
	hitboxCollisionShape.disabled = true


func get_creature() -> Creature:
	return _creature


func action():
	if Input.is_action_just_pressed("attack"):
		attack()
	else:
		 move()


func move() -> void:
	var currentPosition = Vector2(position)
	var velocity = calculateVelocity()
	var collider = move_and_collide(velocity)
	position = snap_to_grid(collider, currentPosition)
	


func calculateVelocity() -> Vector2:
	var velocity = Vector2.ZERO
	if Input.is_action_just_pressed("ui_right"):
		velocity = Vector2(STEP, 0)
		hitboxPivot.rotation_degrees = 0
	if Input.is_action_just_pressed("ui_left"):
		velocity = Vector2(-STEP, 0)
		hitboxPivot.rotation_degrees = 180
	if Input.is_action_just_pressed("ui_up"):
		velocity = Vector2(0, -STEP)
		hitboxPivot.rotation_degrees = 270
	if Input.is_action_just_pressed("ui_down"):
		velocity = Vector2(0, STEP)
		hitboxPivot.rotation_degrees = 90
	return velocity

	
func snap_to_grid(collider: KinematicCollision2D, currentPosition: Vector2) -> Vector2:
	if collider:
		return currentPosition
	return position


func attack() -> void:
	animationPlayer.play("Attack")

