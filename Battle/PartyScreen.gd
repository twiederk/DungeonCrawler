class_name PartyScreen
extends Control

const CharacterWidgetScene: PackedScene = preload("res://Battle/CharacterWidget.tscn")

var _character_widgets: Array[Control] = []

@onready var v_box_container = $VBoxContainer

func _ready():
	visible = PlayerStats.show_character_stats
	for character_stat in PlayerStats.character_stats:
		_add_character_widget(character_stat)


func _input(event):
	if event.is_action_pressed("PartyScreen"):
		PlayerStats.show_character_stats = !PlayerStats.show_character_stats
		visible = PlayerStats.show_character_stats


func _add_character_widget(creature_stats: CreatureStats):
	var character_widget: CharacterWidget = CharacterWidgetScene.instantiate()
	v_box_container.add_child(character_widget)
	character_widget.assign_creature_stats(creature_stats)
	_character_widgets.append(character_widget)


func play_animation(widget_id: int, animation_name: String):
	_character_widgets[widget_id].play_animation(animation_name)
	
	
func get_character_widget(index: int) -> Control:
	return _character_widgets[index]
