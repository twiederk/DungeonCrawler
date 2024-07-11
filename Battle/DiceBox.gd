class_name DiceBox
extends RefCounted

enum Die { D1 = 1, D2 = 2, D3 = 3, D4 = 4, D6 = 6, D8 = 8, D10 = 10, D12 = 12, D20 = 20, D100 = 100}


static func roll(die: Die, number_of_dice = 1)-> int:
	var result: int = 0
	for i in range(number_of_dice):
		result += randi_range(1, die)
	return result
