class_name Slot
extends PanelContainer

signal item_changed(index: int, item: ItemResource)

var index: int
var item_resource: ItemResource = null:
	set(value):
		item_resource = value
		item_changed.emit(index, item_resource)

@onready var item_name: Label = $ItemName
@onready var item_texture: TextureRect = $ItemTexture


func set_property(item: ItemResource):
	item_resource = item
	if item != null:
		item_name.text = item.name
		item_texture.texture = item.texture
	else:
		item_name.text = ""
		item_texture.texture = null


func _get_drag_data(_at_position):
	set_drag_preview(get_preview())
	return self


func _can_drop_data(_at_position, data):
	return data.item_resource is ItemResource


func _drop_data(_at_position, data):
	var temp: ItemResource = item_resource
	set_property(data.item_resource)
	data.set_property(temp)


func get_preview():
	var preview_texture = TextureRect.new()

	preview_texture.texture = item_texture.texture
	preview_texture.expand_mode = 1
	preview_texture.size = Vector2(30, 30)

	var preview = Control.new()
	preview.add_child(preview_texture)

	return preview
