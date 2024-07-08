class_name DamagePopup
extends Node2D

@onready var damage_label = $DamageLabel

var damage_text: String


func _ready():
	damage_label.text = damage_text


func set_damage_text(damage: int):
	damage_text = "-" + str(damage)
