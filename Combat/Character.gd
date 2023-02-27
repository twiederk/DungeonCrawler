class_name Character
extends CharacterBody2D

@export var STEP: int = 32

@onready var animationPlayer = $AnimationPlayer
@onready var hitboxCollisionShape = $HitboxPivot/Hitbox/CollisionShape2D
@onready var hitboxPivot = $HitboxPivot

var _creature = Creature.new()
var _inventory = Inventory.new()

func _ready():
	hitboxCollisionShape.disabled = true


func get_creature() -> Creature:
	return _creature


func action():
	if Input.is_action_just_pressed("attack"):
		attack()
	else:
		move()


func set_texture(texture: Texture2D) -> void:
	get_node("Sprite2D").texture = texture


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


func _on_Item_picked(dict: Dictionary) -> void:
	_inventory.add_gold(dict["gold"])
	print(str(_creature.get_name(), " picked up ", dict["gold"], " gold."))


func get_inventory() -> Inventory:
	return _inventory


func _on_Level_Completed():
	Events.level_completed.emit()
	
