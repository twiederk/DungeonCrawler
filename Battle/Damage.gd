class_name Damage
extends Resource

@export var number_of_dice : int
@export var die: DiceBox.Die


func roll():
	return DiceBox.roll(die, number_of_dice)
