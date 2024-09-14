class_name MonsterScreen
extends BaseCreatureScreen


func _ready():
	_create_creature_widgets(PlayerStats.monster_stats)
