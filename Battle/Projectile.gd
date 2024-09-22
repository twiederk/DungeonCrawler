class_name Projectile
extends Node2D

signal destination_reached()

const EPSILON: int = 4

@export var speed: int = 250

var velocity: Vector2 = Vector2.ZERO
var destination: Vector2

@onready var animated_sprite_2d = $AnimatedSprite2D


func _physics_process(delta: float):
	position = position + (velocity * delta)
	if global_position.distance_to(destination) <= EPSILON:
		destination_reached.emit()
		queue_free()


func set_destination(dest: Vector2):
	destination = dest
	var direction = position.direction_to(destination)
	velocity = direction * speed


func set_sprite_frames(sprite_frames: SpriteFrames):
	animated_sprite_2d.sprite_frames = sprite_frames
