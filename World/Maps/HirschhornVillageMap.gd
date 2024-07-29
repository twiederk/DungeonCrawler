class_name HirschhornVillage
extends Map

@onready var party_screen: PartyScreen = $GUI/PartyScreen


func _on_dialogic_signal(argument:String):
	if argument == "heal_party":
		_heal_party()


func _heal_party():
	for i in PlayerStats.character_stats.size():
		var character = PlayerStats.character_stats[i]
		if character.hit_points < character.max_hit_points:
			party_screen.play_animation(i, "heal")
			character.hit_points = character.max_hit_points
			character.state = CreatureStats.State.ALIVE


