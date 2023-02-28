class_name Character
extends CharacterBody2D

@export var TILE_SIZE: int = 16

@onready var animationPlayer = $AnimationPlayer
@onready var hitboxCollisionShape = $HitboxPivot/Hitbox/CollisionShape2D
@onready var hitboxPivot = $HitboxPivot
@onready var ray_cast_left = $RayCastLeft
@onready var ray_cast_right = $RayCastRight
@onready var ray_cast_up = $RayCastUp
@onready var ray_cast_down = $RayCastDown

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
	if Input.is_action_just_pressed("ui_right"):
		if not ray_cast_right.is_colliding():
			hitboxPivot.rotation_degrees = 0
			position += Vector2(TILE_SIZE, 0)
	if Input.is_action_just_pressed("ui_left"):
		if not ray_cast_left.is_colliding():
			hitboxPivot.rotation_degrees = 180
			position += Vector2(-TILE_SIZE, 0)
	if Input.is_action_just_pressed("ui_up"):
		if not ray_cast_up.is_colliding():
			hitboxPivot.rotation_degrees = 270
			position += Vector2(0, -TILE_SIZE)
	if Input.is_action_just_pressed("ui_down"):
		if not ray_cast_down.is_colliding():
			hitboxPivot.rotation_degrees = 90
			position += Vector2(0, TILE_SIZE)


func attack() -> void:
	animationPlayer.play("Attack")


func _on_Item_picked(dict: Dictionary) -> void:
	_inventory.add_gold(dict["gold"])
	print(str(_creature.get_name(), " picked up ", dict["gold"], " gold."))


func get_inventory() -> Inventory:
	return _inventory
