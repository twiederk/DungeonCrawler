class_name BattleInit

const CharacterScene = preload("res://Battle/CharacterBattler.tscn")
const MonsterScene = preload("res://Battle/MonsterBattler.tscn")
const ItemScene = preload("res://World/Items/Item.tscn")


func create_battlers(scene: PackedScene, battle: Battle, creature_screen: BaseCreatureScreen, creature_stats: Array) -> Array[Battler]:
	var battlers: Array[Battler] = []
	for index in creature_stats.size():
		var battler = create_battler(scene, creature_stats[index], battle.battlefield)
		battler.battler_died.connect(battle._on_battler_died)
		battler.turn_ended.connect(battle._on_next_battler)
		battler.turn_started.connect(creature_screen.get_creature_widget(index)._on_focus)
		battler.turn_ended.connect(creature_screen.get_creature_widget(index)._on_unfocus)

		battle.get_battlers_node().add_child(battler)
		battlers.append(battler)
	return battlers


func create_battler(scene: PackedScene, creature_stats: CreatureStats, battlefield: Battlefield) -> Battler:
	var battler = scene.instantiate()
	battler.name = creature_stats.name
	battler.set_creature(creature_stats)
	battler.set_battlefield(battlefield)
	return battler
