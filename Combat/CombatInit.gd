class_name CombatInit

const CharacterScene = preload("res://Combat/Character.tscn")
const MonsterScene = preload("res://Combat/Monster.tscn")
const ItemScene = preload("res://Combat/Item.tscn")


func create_battlers(scene: PackedScene, combat: Node, creature_stats: Array) -> Array[Battler]:
	var battlers: Array[Battler] = []
	for i in range(creature_stats.size()):
		var x = i + 1
		var battler = create_battler(scene, creature_stats[i], Vector2(x, 1))
		battler.battler_died.connect(combat._on_battler_died)
		battler.battler_attacked.connect(combat._on_battler_attacked)
		battler.turn_ended.connect(combat.next_battler)
		
		combat.add_child(battler)
		battler.set_sprite_frames(creature_stats[i].texture)
		battlers.append(battler)
	return battlers


func create_battler(scene: PackedScene, creature_stats: CreatureStats, position: Vector2) -> Battler:
	var battler = scene.instantiate()
	battler.position = position * Battlefield.TILE_SIZE
	battler.name = creature_stats.name
	battler.set_creature(creature_stats)
	return battler


func create_items(combat: Combat, itemEntries: Array) -> Array:
	var items = []
	for itemEntry in itemEntries:
		var frame_coords = itemEntry["frame_coords"]
		var position = itemEntry["position"]
		var item = create_item(frame_coords, position)
		items.append(item)
		combat.add_child(item)
	return items


func create_item(frame_coords: Vector2, position: Vector2) -> ItemArea2D:
	var item = ItemScene.instantiate()
	item.set_frame_coords(frame_coords)
	item.position = position * Battlefield.TILE_SIZE
	return item


