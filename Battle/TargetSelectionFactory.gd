class_name TargetSelectionFactory
extends Node2D

const MeleeTargetSelectionScene: PackedScene = preload("res://Battle/MeleeTargetSelection.tscn")
const RangedTargetSelectionScene: PackedScene = preload("res://Battle/RangedTargetSelection.tscn")


static func create_target_selection(weapon_type: WeaponResource.WeaponType) -> TargetSelection:
	if weapon_type == WeaponResource.WeaponType.RANGED_WEAPON:
		return RangedTargetSelectionScene.instantiate()
	return MeleeTargetSelectionScene.instantiate()
