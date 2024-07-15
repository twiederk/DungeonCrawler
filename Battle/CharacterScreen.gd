class_name CharacterScreen
extends Control

const CharacterWidgetScene: PackedScene = preload("res://Battle/CharacterWidget.tscn")

var _character_widgets: Array[Control] = []

@onready var v_box_container = $VBoxContainer

func _ready():
	visible = PlayerStats.show_character_stats
	for character_stat in PlayerStats.character_stats:
		_add_character_widget(character_stat)


func _input(event):
	if event.is_action_pressed("CharacterScreen"):
		PlayerStats.show_character_stats = !PlayerStats.show_character_stats
		visible = PlayerStats.show_character_stats


func _add_character_widget(character_stat: CreatureStats):
	var character_widget: CharacterWidget = CharacterWidgetScene.instantiate()
	v_box_container.add_child(character_widget)
	character_widget.set_character_name(character_stat.name)
	character_widget.set_texture(character_stat.texture)
	character_widget.set_hit_points(character_stat.hit_points)
	character_widget.set_max_hit_points(character_stat.max_hit_points)
	character_stat.hit_points_changed.connect(character_widget._on_hit_points_changed)
	_character_widgets.append(character_widget)


func play_animation(widget_id: int, animation_name: String):
	_character_widgets[widget_id].play_animation(animation_name)
