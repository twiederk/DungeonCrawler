class_name HitEffect
extends Sprite2D

@onready var audio_stream_player = $AudioStreamPlayer

func _ready():
	audio_stream_player.play()


func _on_audio_stream_player_finished():
	queue_free()
