class_name MeleeTargetSelection
extends TargetSelection


func get_selectable_targets(battler: Battler, possible_targets: Array[Battler]) -> Array[Battler]:
	var targets: Array[Battler] = []

	for direction in Battlefield.directions:
		var target_position: Vector2 = battler.position + direction
		for target in possible_targets:
			if target.position == target_position:
				targets.append(target)
	return targets
