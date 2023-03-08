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
@onready var name_label = $NameLabel


var _creature = Creature.new()
var _inventory = Inventory.new()


func _ready():
	hitboxCollisionShape.disabled = true
	name_label.text = _creature.get_name()


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
		move_and_turn(Vector2.RIGHT, 0, ray_cast_right)
	if Input.is_action_just_pressed("ui_left"):
		move_and_turn(Vector2.LEFT, 180, ray_cast_left)
	if Input.is_action_just_pressed("ui_up"):
		move_and_turn(Vector2.UP, 270, ray_cast_up)
	if Input.is_action_just_pressed("ui_down"):
		move_and_turn(Vector2.DOWN, 90, ray_cast_down)


func move_and_turn(direction: Vector2, rotation_degree: int, ray_cast: RayCast2D) -> void:
	turn(rotation_degree)
	if can_move(ray_cast):
		move_step(direction)


func turn(rotation_degree: int) -> void:
	hitboxPivot.rotation_degrees = rotation_degree


func can_move(ray_cast: RayCast2D) -> bool:
	return not ray_cast.is_colliding() and _creature.can_move()


func move_step(direction: Vector2) -> void:
	_creature.step()
	position += direction * TILE_SIZE


func attack() -> void:
	_creature.attack()
	animationPlayer.play("Attack")


func _on_Item_picked(dict: Dictionary) -> void:
	_inventory.add_gold(dict["gold"])
	print(str(_creature.get_name(), " picked up ", dict["gold"], " gold."))


func get_inventory() -> Inventory:
	return _inventory


func is_done() -> bool:
	return _creature.is_done()


func start_combat_round() -> void:
	_creature.start_combat_round()
