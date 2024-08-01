class_name Monster
extends Battler

signal item_dropped(item_resource: ItemResource, global_position: Vector2)

var loot_table_name: String
var path : Array[Vector2] = []

@onready var movement_timer = $MovementTimer


func start_turn(battlefield: Battlefield):
	super.start_turn(battlefield)
	if get_target() != null:
		attack()
	else:
		move(battlefield)


func move(battlefield: Battlefield):
	var attack_position = battlefield.find_nearest_attack_position(get_battlefield_position())
	path = battlefield.bfs(get_battlefield_position(), attack_position)
	move_animation()


func move_animation():
	if get_movement() < get_max_movement() && get_movement() < path.size():
		position = path[get_movement()] * Battlefield.TILE_SIZE
		step()
		movement_timer.start()
	else:
		attack()
	

func get_target():
	for facing in Battler.Facing.values():
		var collider = _ray_casts[facing].get_collider()
		if collider != null and collider is Character:
			return collider
	return null


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


