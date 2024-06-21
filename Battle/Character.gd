class_name Character
extends Battler

var _inventory: Inventory = Inventory.new()

@onready var hitboxCollisionShape = $HitboxPivot/Hitbox/CollisionShape2D
@onready var hitboxPivot = $HitboxPivot
@onready var name_label = $NameLabel


func _ready():
	super._ready()
	hitboxCollisionShape.disabled = true
	name_label.text = _creature_stats.name


func _input(_event):
	if _battle_state == BattleState.READY:
		if Input.is_action_just_pressed("attack"):
			get_viewport().set_input_as_handled()
			attack()
		else:
			move()


func move() -> void:
	if Input.is_action_just_pressed("ui_right"):
		move_and_turn(Vector2.RIGHT, Battler.Facing.RIGHT)
	if Input.is_action_just_pressed("ui_left"):
		move_and_turn(Vector2.LEFT, Battler.Facing.LEFT)
	if Input.is_action_just_pressed("ui_up"):
		move_and_turn(Vector2.UP, Battler.Facing.UP)
	if Input.is_action_just_pressed("ui_down"):
		move_and_turn(Vector2.DOWN, Battler.Facing.DOWN)


func move_and_turn(direction: Vector2, facing: Facing) -> void:
	var ray_cast = _ray_casts[facing]
	turn(facing)
	if can_move(ray_cast):
		move_step(direction)


func turn(rotation_degree: int) -> void:
	hitboxPivot.rotation_degrees = rotation_degree


func can_move(ray_cast: RayCast2D) -> bool:
	return not ray_cast.is_colliding() and _creature_stats.movement > 0


func move_step(direction: Vector2) -> void:
	step()
	position += direction * Battlefield.TILE_SIZE


func get_target():
	var facing = degree_to_facing(hitboxPivot.rotation_degrees)
	var ray_cast = _ray_casts[facing]
	if ray_cast.is_colliding():
		return ray_cast.get_collider()
	return null


func _on_Item_picked(dict: Dictionary) -> void:
	_inventory.add_gold(dict["gold"])
	print(str(_creature_stats.name, " picked up ", dict["gold"], " gold."))


func get_inventory() -> Inventory:
	return _inventory


