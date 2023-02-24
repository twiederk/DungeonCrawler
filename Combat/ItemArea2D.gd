class_name ItemArea2D
extends Area2D

signal picked


func get_frame_coords() -> Vector2:
	return get_node("Sprite2D").frame_coords


func set_frame_coords(frame_coords: Vector2) -> void:
	get_node("Sprite2D").frame_coords = frame_coords


func _on_Item_body_entered(body: CharacterBody) -> void:
	#warning-ignore:RETURN_VALUE_DISCARDED
	connect("picked",Callable(body,"_on_Item_picked").bind(),CONNECT_ONE_SHOT)
	emit_signal("picked", {gold = 5})
	queue_free()

