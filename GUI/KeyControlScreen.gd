class_name KeyControlScreen
extends Control

static var _show_screen: bool = true

@onready var key_controls_container = $KeyControls


func _ready():
	visible = _show_screen
	MessageBus.key_control_registerd.connect(_add_key_control)


func _input(event):
	if event.is_action_pressed("KeyControlScreen"):
		_show_screen = !_show_screen
		visible = _show_screen


func _add_key_control(key_controls: Array[KeyControl]):
	for key_control in key_controls:
		var label: Label = Label.new()
		label.text = str(key_control.key, " - ", key_control.action)
		key_controls_container.add_child(label)
