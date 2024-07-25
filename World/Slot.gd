class_name Slot
extends PanelContainer

@onready var item_name = $ItemName
@onready var item_texture = $ItemTexture


func set_property(item: ItemResource):
	item_name.text = item.name
	item_texture.texture = item.texture
