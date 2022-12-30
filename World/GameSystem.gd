class_name GameSystem
extends Node

func attack(attacker: Creature, defender: Creature) -> void:
	var attack_roll = attacker.roll_attack()
	print(str(attacker.get_name(), " rolls attack die [", attack_roll, "]"))
	
	if attack_roll >= defender.get_armor_class():
		print("...and hits for ", attacker.get_damage(), " points of damage.")
		defender.set_hit_points(defender.get_hit_points() - attacker.get_damage())
	else:
		print("...and misses.")
