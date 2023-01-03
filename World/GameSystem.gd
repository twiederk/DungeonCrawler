class_name GameSystem
extends Object

func attack(attacker: Creature, defender: Creature) -> void:
	var attack_roll = attacker.roll_attack()
	print(str(attacker.get_name(), " rolls attack die [", attack_roll, "]"))

	if attack_roll >= defender.get_armor_class():
		var damage = attacker.get_damage()
		print("...and hits for ", damage, " points of damage.")
		defender.hurt(damage)
	else:
		print("...and misses.")
