class_name NecromancerEncounter
extends Encounter


func _change_scene():
	Dialogic.VAR.OldMine.completed = true
	super._change_scene()







