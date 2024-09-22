class_name MonsterBattler
extends Battler

signal item_dropped(item_resource: ItemResource, global_position: Vector2)

var loot_table_name: String
var path : Array[Vector2] = []

@onready var movement_timer = $MovementTimer


func start_turn():
	super.start_turn()
	if get_target() != null:
		attack()
	else:
		move()


func attack():
	_logger.debug(str(get_creature_name(), ".attack()"))
	_target = get_target()
	if _target != null:
		attack_animation(_target)
	else:
		turn_ended.emit()


func move():
	var attack_position = _battlefield.find_nearest_attack_position(position)
	path = _battlefield.bfs(position, attack_position)
	move_animation()


func move_animation():
	if get_movement() < get_max_movement() && get_movement() < path.size():
		position = path[get_movement()]
		step()
		movement_timer.start()
	else:
		attack()


func get_target():
	var target_selection = TargetSelectionFactory.create_target_selection()
	var selectable_targets = target_selection.get_selectable_targets(self, _battlefield.characters)
	if selectable_targets.is_empty():
		return null
	return selectable_targets[0]


func dead():
	drop_loot()
	super.dead()


func drop_loot():
	var file: FileAccess = FileAccess.open("res://Data/" + loot_table_name + ".json",FileAccess.READ)
	var loot_table = JSON.parse_string(file.get_as_text())
	file.close()

	var total_weight: int  = 0
	var cumulative_weight: Array = []

	for i in loot_table:
		total_weight += int(loot_table[i]["weight"])
		cumulative_weight.append([loot_table[i]["ItemId"], total_weight])

	var chance: float = randf_range(0, total_weight)

	for i in cumulative_weight:
		if chance < i[1]:
			var item_resource = ItemData.get_weapon(i[0])
			item_dropped.emit(item_resource, global_position)
			break
