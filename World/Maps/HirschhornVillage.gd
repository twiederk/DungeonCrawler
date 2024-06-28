class_name HirschhornVillage
extends Map


func _on_dialogic_signal(argument:String):
	if argument == "heal_party":
		_heal_party()


func _heal_party():
	for character in PlayerStats.character_stats:
		character.hit_points = character.max_hit_points

