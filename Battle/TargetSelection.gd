class_name TargetSelection
extends Node2D

signal target_selected(target: Battler)
signal target_canceled

@onready var crosshair: Node2D = $Crosshair

var selectable_targets: Array[Battler] = []
var selectable_targets_index: int = 0


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("cancel_target"):
		target_canceled.emit()
		queue_free()
		return
	if selectable_targets.is_empty():
		return
	if event.is_action_pressed("next_target"):
		selectable_targets_index = (selectable_targets_index + 1) % selectable_targets.size()
		crosshair.global_position = selectable_targets[selectable_targets_index].global_position
	if event.is_action_pressed("previous_target"):
		selectable_targets_index -= 1
		if selectable_targets_index < 0:
			selectable_targets_index = selectable_targets.size() - 1
		crosshair.global_position = selectable_targets[selectable_targets_index].global_position
	if event.is_action_pressed("select_target"):
		target_selected.emit(selectable_targets[selectable_targets_index])
		queue_free()


func start_selection(battler: Battler, battlefield: Battlefield, possible_targets: Array[Battler]) -> void:
	selectable_targets = get_selectable_targets(battler, possible_targets)
	battlefield.add_child(self)
	position = battler.position
	if selectable_targets.is_empty():
		MessageBus.message_send.emit("Keine Ziele in Reichweite")
		crosshair.hide()
	else:
		crosshair.global_position = selectable_targets[selectable_targets_index].global_position


@warning_ignore("unused_parameter")
func get_selectable_targets(source: Battler, possible_targets: Array[Battler]) -> Array[Battler]:
	return []
