class_name TargetSelection
extends Node2D

signal target_selected(target: Battler)
signal target_canceled

@onready var crosshair: Node2D = $Crosshair

var selectable_targets: Array[Battler] = []
var selectable_targets_index: int = 0


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("next_target"):
		selectable_targets_index = (selectable_targets_index + 1) % selectable_targets.size()
		position = selectable_targets[selectable_targets_index].position
	if event.is_action_pressed("previous_target"):
		selectable_targets_index -= 1
		if selectable_targets_index < 0:
			selectable_targets_index = selectable_targets.size() - 1
		position = selectable_targets[selectable_targets_index].position
	if event.is_action_pressed("select_target"):
		target_selected.emit(selectable_targets[selectable_targets_index])
		queue_free()
	if event.is_action_pressed("cancel_target"):
		target_canceled.emit()
		queue_free()


func start_selection(character_position: Vector2, battlefield: Battlefield) -> void:
	selectable_targets = _get_selectable_targets(character_position, battlefield)
	match (selectable_targets.size()):
		0:
			MessageBus.message_send.emit("Keine Ziele in Reichweite")
			target_canceled.emit()
		1:
			target_selected.emit(selectable_targets[0])
		_:
			battlefield.add_child(self)
			position = selectable_targets[selectable_targets_index].position


@warning_ignore("unused_parameter")
func _get_selectable_targets(character_position: Vector2, battlefield: Battlefield) -> Array[Battler]:
	return []
