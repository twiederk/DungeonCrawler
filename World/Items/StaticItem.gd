class_name StaticItem
extends Item

@export_enum("ARMOR:0", "WEAPON:1", "GOOD:2") var item_type: int
@export var item_id: int


func _ready():
	match item_type:
		0:
			item_resource = ItemData.get_armor(item_id)
	match item_type:
		1:
			item_resource = ItemData.get_weapon(item_id)
	super._ready()
