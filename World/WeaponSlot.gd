class_name WeaponSlot
extends Slot

signal weapon_changed(weapon: WeaponResource)

@onready var damage_label = $DamageLabel


func _can_drop_data(_at_position, data):
	return data.item_resource is WeaponResource


func _item_changed():
	var weapon_resource = item_resource as WeaponResource
	damage_label.text = weapon_resource.damage.to_string()
	weapon_changed.emit(weapon_resource)



