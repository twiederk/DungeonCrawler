class_name Person
extends CharacterBody2D

@export var timeline : DialogicTimeline
@onready var animated_sprite_2d = $AnimatedSprite2D

var can_talk = false


func _ready():
	var number_of_frames = animated_sprite_2d.sprite_frames.get_frame_count("default")
	animated_sprite_2d.frame = randi_range(0, number_of_frames)
	animated_sprite_2d.play("default")


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
