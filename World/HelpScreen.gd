class_name HelpScreen
extends Control

static var _show_help_screen: bool = false


func _input(event):
	if event.is_action_pressed("HelpScreen"):
		_show_help_screen = !_show_help_screen
		visible = _show_help_screen


