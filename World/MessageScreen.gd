class_name MessageScreen
extends Control

var max_lines: int = 100 

@onready var rich_text_label : RichTextLabel = $RichTextLabel


func _ready():
	MessageBus.message_send.connect(_on_message_send)


func _input(event):
	if event.is_action_pressed("MessageScreen"):
		PlayerStats.show_message_screen = !PlayerStats.show_message_screen
		visible = PlayerStats.show_message_screen


func _on_message_send(message: String):
	add_message(message)


func add_message(text: String):
	# Append new text at the end
	rich_text_label.add_text(text + "\n")
	# Check if the total line count exceeds the maximum allowed
	if rich_text_label.get_line_count() > max_lines:
		# Calculate how many lines to remove
		var lines_to_remove = rich_text_label.get_line_count() - max_lines
		# Remove lines from the beginning
		for i in range(lines_to_remove):
			rich_text_label.remove_line(0)
	# Scroll to the bottom to ensure the new text is visible
	rich_text_label.scroll_to_line(rich_text_label.get_line_count())
