class_name CharacterBattler
extends Battler

@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D


func _input(_event):
	if _battle_state == BattleState.READY:
		if Input.is_action_just_pressed("next_battler"):
			get_viewport().set_input_as_handled()
			turn_ended.emit()
		elif Input.is_action_just_pressed("action"):
			get_viewport().set_input_as_handled()
			select_target()
		else:
			movement()


func movement() -> void:
	if Input.is_action_just_pressed("ui_right"):
		move(Vector2.RIGHT)
	if Input.is_action_just_pressed("ui_left"):
		move(Vector2.LEFT)
	if Input.is_action_just_pressed("ui_up"):
		move(Vector2.UP)
	if Input.is_action_just_pressed("ui_down"):
		move(Vector2.DOWN)


func move(direction: Vector2) -> void:
	var ray_cast = _ray_casts[direction]
	if can_move(ray_cast):
		move_step(direction)


func can_move(ray_cast: RayCast2D) -> bool:
	return not ray_cast.is_colliding() and get_movement() < get_max_movement()


func move_step(direction: Vector2) -> void:
	if not _battlefield.monsters.is_empty():
		step()
	position += direction * Battlefield.TILE_SIZE


func dead():
	animated_sprite_2d.play("dead")
	animated_sprite_2d.z_index = 0
	collision_shape_2d.disabled = true
	super.dead()


func get_armor_class() -> int:
	return _creature_stats.armor.armor_class


func select_target():
	_battle_state = BattleState.TARGETING
	var melee_target_selection = TargetSelectionFactory.create_target_selection()
	melee_target_selection.target_selected.connect(_on_target_selected)
	melee_target_selection.target_canceled.connect(_on_target_canceled)
	melee_target_selection.start_selection(self, _battlefield, _battlefield.monsters)
	

func _on_target_selected(target: Battler):
	_battle_state = BattleState.READY
	_target = target
	attack_animation(_target)


func _on_target_canceled():
	_battle_state = BattleState.READY
