class_name WeaponSlot
extends Slot

signal weapon_changed(weapon: WeaponResource)


func _can_drop_data(_at_position, data):
	return data.item_resource is WeaponResource


func _emit_changed_signal():
	weapon_changed.emit(item_resource as WeaponResource)



