class_name Slot
extends PanelContainer

@export_enum("BAG:0", "WEAPON:1") var slot_type: int

var item_resource: ItemResource = null

@onready var item_name = $ItemName
@onready var item_texture = $ItemTexture


func set_property(item: ItemResource):
	item_name.text = item.name
	item_texture.texture = item.texture


func _get_drag_data(at_position):
	set_drag_preview(get_preview())
	return item_resource


func _can_drop_data(at_position, data):
	return data is ItemResource


func _drop_data(at_position, data):
	var temp = item_resource
	item_resource = data
	data = item_resource


func get_preview():
	var preview_texture = TextureRect.new()

	preview_texture.texture = item_texture.texture
	preview_texture.expand_mode = 1
	preview_texture.size = Vector2(30,30)

	var preview = Control.new()
	preview.add_child(preview_texture)

	return preview
