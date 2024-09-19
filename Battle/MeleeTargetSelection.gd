class_name MeleeTargetSelection
extends TargetSelection


func get_selectable_targets(source_position: Vector2, possible_targets: Array[Battler]) -> Array[Battler]:
	var targets: Array[Battler] = []

	for direction in Battlefield.directions:
		var target_position: Vector2 = source_position + direction
		for battler in possible_targets:
			if battler.position == target_position:
				targets.append(battler)
	return targets
