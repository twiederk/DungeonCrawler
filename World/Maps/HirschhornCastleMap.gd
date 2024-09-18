class_name HirschhornCastleMap
extends Map


func _ready():
	super._ready()
	Dialogic.start("C_HRN_Intro")
	if not OS.has_feature("editor"):
		get_window().mode = Window.MODE_EXCLUSIVE_FULLSCREEN	
