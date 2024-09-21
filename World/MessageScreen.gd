class_name MessageScreen
extends Control

static var _show_message_screen: bool = true

var max_lines: int = 100000

@onready var rich_text_label : RichTextLabel = $RichTextLabel


func _ready():
	MessageBus.message_send.connect(_on_message_send)


func _input(event):
	if event.is_action_pressed("MessageScreen"):
		_show_message_screen = !_show_message_screen
		visible = _show_message_screen


func _on_message_send(message: String):
	add_message(message)


func add_message(text: String):
	rich_text_label.append_text(text + "\n")
	if rich_text_label.get_line_count() > max_lines:
		var lines_to_remove = rich_text_label.get_line_count() - max_lines
		for i in range(lines_to_remove):
			rich_text_label.remove_line(0)
	rich_text_label.scroll_to_line(rich_text_label.get_line_count())
