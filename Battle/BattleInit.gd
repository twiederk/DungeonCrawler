class_name BattleInit

const CharacterScene = preload("res://Battle/Character.tscn")
const MonsterScene = preload("res://Battle/Monster.tscn")
const ItemScene = preload("res://Battle/Item.tscn")


func create_battlers(scene: PackedScene, battle: Node, creature_stats: Array) -> Array[Battler]:
	var battlers: Array[Battler] = []
	for creature in creature_stats:
		var battler = create_battler(scene, creature)
		battler.battler_died.connect(battle._on_battler_died)
		battler.battler_attacked.connect(battle._on_battler_attacked)
		battler.turn_ended.connect(battle.next_battler)
		
		battle.add_child(battler)
		battlers.append(battler)
	return battlers


func create_battler(scene: PackedScene, creature_stats: CreatureStats) -> Battler:
	var battler = scene.instantiate()
	battler.name = creature_stats.name
	battler.set_creature(creature_stats)
	return battler


