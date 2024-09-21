class_name RangedTargetSelection
extends TargetSelection

@warning_ignore("shadowed_global_identifier")
var range: float


func _draw() -> void:
	draw_circle(Vector2.ZERO, range, Color(0.85, 0.34, 0.39, 0.65))


func get_selectable_targets(battler: Battler, possible_targets: Array[Battler]) -> Array[Battler]:
	var targets: Array[Battler] = []
	range = battler.get_weapon().range * Battlefield.TILE_SIZE
	for target in possible_targets:
		var distance = battler.position.distance_to(target.position)
		@warning_ignore("shadowed_global_identifier")
		if distance <= range:
			targets.append(target)
	return targets
