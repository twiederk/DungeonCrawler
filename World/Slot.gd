class_name Slot
extends PanelContainer

var item_resource: ItemResource = null:
	set(value):
		item_resource = value
		_item_changed()

@onready var item_texture: TextureRect = $ItemTexture


func set_item(item: ItemResource):
	item_resource = item
	if item != null:
		item_texture.texture = item.texture
	else:
		item_texture.texture = null


func _get_drag_data(_at_position):
	set_drag_preview(get_preview())
	return self


func _drop_data(_at_position, data):
	var temp: ItemResource = item_resource
	set_item(data.item_resource)
	data.set_item(temp)


func get_preview():
	var preview_texture = TextureRect.new()

	preview_texture.texture = item_texture.texture
	preview_texture.expand_mode = 1
	preview_texture.size = Vector2(30, 30)

	var preview = Control.new()
	preview.add_child(preview_texture)

	return preview


func _item_changed():
	pass
