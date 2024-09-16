class_name RangedTargetSelection
extends TargetSelection


func _get_selectable_targets(character_position: Vector2, battlefield: Battlefield) -> Array[Battler]:
	var selectable_targets: Array[Battler] = []
	for monster in battlefield.monsters:
		selectable_targets.append(monster)
	return selectable_targets
