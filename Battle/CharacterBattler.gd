class_name CharacterBattler
extends Battler


@onready var hitboxCollisionShape: CollisionShape2D = $HitboxPivot/Hitbox/CollisionShape2D
@onready var hitboxPivot = $HitboxPivot
@onready var name_label: Label = $NameLabel
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var hitbox_pivot = $HitboxPivot

func _ready():
	super._ready()
	hitboxCollisionShape.disabled = true
	name_label.text = _creature_stats.name


func _input(_event):
	if _battle_state == BattleState.READY and not PlayerStats.display_item_pickup_screen:
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
	return not ray_cast.is_colliding() and get_movement() < get_max_movement()


func move_step(direction: Vector2) -> void:
	step()
	position += direction * Battlefield.TILE_SIZE


func get_target():
	var facing = degree_to_facing(hitboxPivot.rotation_degrees)
	var ray_cast = _ray_casts[facing]
	if ray_cast.is_colliding() and not ray_cast.get_collider() is CharacterBattler:
		return ray_cast.get_collider()
	return null


func dead():
	animated_sprite_2d.play("dead")
	animated_sprite_2d.z_index = 0
	hitbox_pivot.hide()
	collision_shape_2d.disabled = true
	super.dead()


func get_armor_class() -> int:
	return _creature_stats.armor.armor_class
