class_name OldMineMap
extends Map


func _ready():
	super._ready()
	if Dialogic.VAR.OldMine.completed and not Dialogic.VAR.OldMine.congratulation:
		Dialogic.VAR.OldMine.congratulation = true
		Dialogic.start("congratulation")
