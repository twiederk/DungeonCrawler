class_name MeleeTargetSelection
extends TargetSelection


func _get_selectable_targets(character_position: Vector2, battlefield: Battlefield) -> Array[Battler]:
	var selectable_targets: Array[Battler] = []

	for direction in battlefield.directions:
		var target_position: Vector2 = character_position + (direction * Battlefield.TILE_SIZE)
		for monster in battlefield.monsters:
			if monster.position == target_position:
				selectable_targets.append(monster)
	return selectable_targets
