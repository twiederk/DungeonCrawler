class_name Character
extends Battler

@export var TILE_SIZE: int = 16

var _inventory = Inventory.new()

@onready var animationPlayer = $AnimationPlayer
@onready var hitboxCollisionShape = $HitboxPivot/Hitbox/CollisionShape2D
@onready var hitboxPivot = $HitboxPivot
@onready var ray_cast_left = $RayCastLeft
@onready var ray_cast_right = $RayCastRight
@onready var ray_cast_up = $RayCastUp
@onready var ray_cast_down = $RayCastDown
@onready var name_label = $NameLabel


func _ready():
	hitboxCollisionShape.disabled = true
	name_label.text = _creature_stats.name


func _input(_event):
	if _combat_state == CombatState.READY:
		if Input.is_action_just_pressed("attack"):
			get_viewport().set_input_as_handled()
			attack()
		else:
			move()


func move() -> void:
	print(name, ".move()")
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
	return not ray_cast.is_colliding() and _creature_stats.movement > 0


func move_step(direction: Vector2) -> void:
	step()
	position += direction * TILE_SIZE


func attack() -> void:
	print(name, ".attack()")
	animationPlayer.play("Attack")
	var target_battler = get_target_battler()
	if target_battler != null:
		battler_attacked.emit(self, target_battler)
	turn_ended.emit()


func get_target_battler():
	match int(hitboxPivot.rotation_degrees):
		0:
			if ray_cast_right.is_colliding():
				return ray_cast_right.get_collider()
		90:
			if ray_cast_down.is_colliding():
				return ray_cast_down.get_collider()
		180:
			if ray_cast_left.is_colliding():
				return ray_cast_left.get_collider()
		270:
			if ray_cast_up.is_colliding():
				return ray_cast_up.get_collider()
		_:
			return null


func _on_Item_picked(dict: Dictionary) -> void:
	_inventory.add_gold(dict["gold"])
	print(str(_creature_stats.name, " picked up ", dict["gold"], " gold."))


func get_inventory() -> Inventory:
	return _inventory
