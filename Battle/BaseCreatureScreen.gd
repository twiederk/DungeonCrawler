class_name BaseCreatureScreen
extends Control

@export var CreatureScene: PackedScene

var _creature_widgets: Array[Control] = []

@onready var v_box_container = $VBoxContainer


func _create_creature_widgets(creature_stats: Array[CreatureStats]):
	for creature_stat in creature_stats:
		_add_creature_widget(creature_stat)


func _add_creature_widget(creature_stats: CreatureStats):
	var creature_widget: BaseCreatureWidget = CreatureScene.instantiate()
	v_box_container.add_child(creature_widget)
	creature_widget.assign_creature_stats(creature_stats)
	_creature_widgets.append(creature_widget)


func play_animation(widget_id: int, animation_name: String):
	_creature_widgets[widget_id].play_animation(animation_name)
	
	
func get_creature_widget(index: int) -> Control:
	return _creature_widgets[index]
