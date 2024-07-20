class_name WeaponSlot
extends Slot


func _can_drop_data(_at_position, data):
	return data.item_resource is WeaponResource



