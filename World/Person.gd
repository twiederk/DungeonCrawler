class_name Person
extends CharacterBody2D

@export var timeline : String

var can_talk = false


func _input(event):
	if can_talk and event.is_action_pressed("talk"):
		Dialogic.start(timeline)


func _on_talk_detection_zone_body_entered(body):
	if body.name == "Avatar":
		can_talk = true


func _on_talk_detection_zone_body_exited(body):
	if body.name == "Avatar":
		can_talk = false


func unpause(_timeline_name):
	get_tree().paused = false
