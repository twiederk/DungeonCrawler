class_name CharacterHitbox
extends Area2D


func _draw():
	var extents = $CollisionShape2D.shape.extents
	draw_rect(Rect2(extents.x * -1, extents.y * -1, extents.x * 2, extents.y * 2), Color(Color.RED, 0.5))

