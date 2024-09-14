class_name PartyScreen
extends BaseCreatureScreen

static var _show_party_screen: bool = true

func _ready():
	visible = _show_party_screen
	_create_creature_widgets(PlayerStats.character_stats)


func _input(event):
	if event.is_action_pressed("PartyScreen"):
		_show_party_screen = !_show_party_screen
		visible = _show_party_screen
