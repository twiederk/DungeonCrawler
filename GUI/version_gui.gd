class_name VersionGUI
extends Control

@onready var version_label = $VersionLabel


func _ready():
	version_label.text = ProjectSettings.get_setting("application/config/description")
