class_name BattleInit

const CharacterScene = preload("res://Battle/Character.tscn")
const MonsterScene = preload("res://Battle/Monster.tscn")
const ItemScene = preload("res://World/Items/Item.tscn")


func create_battlers(scene: PackedScene, battle: Battle, character_screen: CharacterScreen, creature_stats: Array) -> Array[Battler]:
	var battlers: Array[Battler] = []
	for index in creature_stats.size():
		var battler = create_battler(scene, creature_stats[index])
		battler.battler_died.connect(battle._on_battler_died)
		battler.battler_attacked.connect(battle._on_battler_attacked)
		battler.turn_ended.connect(battle._on_next_battler)
		if not character_screen == null:
			battler.turn_started.connect(character_screen.get_character_widget(index)._on_focus)
			battler.turn_ended.connect(character_screen.get_character_widget(index)._on_unfocus)

		battle.get_battlers_node().add_child(battler)
		battlers.append(battler)
	return battlers


func create_battler(scene: PackedScene, creature_stats: CreatureStats) -> Battler:
	var battler = scene.instantiate()
	battler.name = creature_stats.name
	battler.set_creature(creature_stats)
	return battler
