class_name EncStats
extends Node

var monsters: Array[MonsterResource] = []

func get_monster_stats() -> Array[CreatureStats]:
	var monster_stats: Array[CreatureStats] = []
	for monster in monsters:
		monster_stats.append(monster.to_creature_stats())
	return monster_stats
