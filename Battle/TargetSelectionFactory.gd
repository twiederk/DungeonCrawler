class_name TargetSelectionFactory
extends Node2D

const RangedTargetSelectionScene: PackedScene = preload("res://Battle/RangedTargetSelection.tscn")


static func create_target_selection() -> TargetSelection:
	return RangedTargetSelectionScene.instantiate()
