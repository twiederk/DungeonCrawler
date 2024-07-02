class_name OldMineMap
extends Map


func _ready():
	if Dialogic.VAR.OldMine.completed and not Dialogic.VAR.OldMine.congratulation:
		Dialogic.start("congratulation")
