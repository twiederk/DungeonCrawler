class_name MeleeTargetSelection
extends TargetSelection


func _get_selectable_targets(character_position: Vector2, battlefield: Battlefield) -> Array[Battler]:
	var targets: Array[Battler] = []

	for direction in battlefield.directions:
		var target_position: Vector2 = character_position + (direction)
		for monster in battlefield.monsters:
			if monster.position == target_position:
				targets.append(monster)
	return targets
