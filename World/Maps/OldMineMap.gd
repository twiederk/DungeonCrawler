class_name OldMineMap
extends Map


func _ready():
	super._ready()
	if not Dialogic.VAR.OLD_MINE.intro:
		Dialogic.VAR.OLD_MINE.intro = true
		Dialogic.start("D_OM_Intro")
	if Dialogic.VAR.OLD_MINE.completed and not Dialogic.VAR.OLD_MINE.congratulation:
		Dialogic.VAR.OLD_MINE.congratulation = true
		Dialogic.start("D_OM_Congratulation")
