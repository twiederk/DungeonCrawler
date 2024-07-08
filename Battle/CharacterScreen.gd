class_name CharacterScreen
extends Control

const CharacterWidgetScene: PackedScene = preload("res://Battle/CharacterWidget.tscn")

@onready var v_box_container = $VBoxContainer

func _ready():
	for character_stat in PlayerStats.character_stats:
		_add_character_widget(character_stat)


func _input(event):
	if event.is_action_pressed("CharacterScreen"):
		visible = !visible


func _add_character_widget(character_stat: CreatureStats):
	var character_widget: CharacterWidget = CharacterWidgetScene.instantiate()
	v_box_container.add_child(character_widget)
	character_widget.set_character_name(character_stat.name)
	character_widget.set_texture(character_stat.texture)
	character_widget.set_hit_points(character_stat.hit_points)
	character_widget.set_max_hit_points(character_stat.max_hit_points)


func connect_characters(characters: Array[Battler]):
	var character_widgets = v_box_container.get_children()
	for i in characters.size():
		characters[i].battler_hurt.connect(character_widgets[i].update_health_bar)
