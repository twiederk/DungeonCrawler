class_name RangedTargetSelection
extends TargetSelection


func get_selectable_targets(_source_position: Vector2, possible_targets: Array[Battler]) -> Array[Battler]:
	var targets: Array[Battler] = []
	for battler in possible_targets:
		targets.append(battler)
	return targets
