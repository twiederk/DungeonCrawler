class_name GameSystem

func attack(attacker: Battler, defender: Battler) -> void:
	var attack_roll = attacker.roll_attack()
	print(str(attacker.get_creature_name(), " rolls attacks at ", defender.get_creature_name(), " and rolls [", attack_roll, "]"))

	if attack_roll >= defender.get_armor_class():
		var damage = attacker.get_damage()
		print("...and hits for ", damage, " points of damage.")
		defender.hurt(damage)
	else:
		print("...and misses.")
