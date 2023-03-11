class_name Person
extends CharacterBody2D

@export var timeline : String

var can_talk = false


func _input(event):
	if get_node_or_null("DefaultDialogNode") == null:
		if can_talk and event.is_action_pressed("talk"):
#			get_tree().paused = true
			var dialog = Dialogic.start(timeline)
#			dialog.process_mode = Node.PROCESS_MODE_WHEN_PAUSED
#			dialog.timeline_ended.connect(unpause)
#			add_child(dialog)


func _on_talk_detection_zone_body_entered(body):
	if body.name == "Avatar":
		can_talk = true


func _on_talk_detection_zone_body_exited(body):
	if body.name == "Avatar":
		can_talk = false


func unpause(_timeline_name):
	get_tree().paused = false
