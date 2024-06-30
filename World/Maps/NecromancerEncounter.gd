class_name NecromancerEncounter
extends Encounter


func _change_scene():
	Dialogic.VAR.OLD_MINE.completed = true
	super._change_scene()







