class_name RangedTargetSelection
extends TargetSelection


func _get_selectable_targets(_character_position: Vector2, battlefield: Battlefield) -> Array[Battler]:
	var targets: Array[Battler] = []
	for monster in battlefield.monsters:
		targets.append(monster)
	return targets
