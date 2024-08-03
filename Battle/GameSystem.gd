class_name GameSys
extends Node

func attack(attacker: Battler, defender: Battler):
	var attack_roll = attacker.roll_attack()
	MessageBus.message_send.emit(str(attacker.get_creature_name(), " attackiert ", defender.get_creature_name(), " und würfelt [", attack_roll, "]"))

	if attack_roll >= defender.get_armor_class():
		var damage = attacker.get_damage()
		MessageBus.message_send.emit(str("...und trifft mit ", damage, " Schadenspunkten."))
		defender.hurt(damage)
	else:
		MessageBus.message_send.emit("...und verfehlt.")
