class_name MonsterWidget
extends BaseCreatureWidget


func _on_state_changed(state: CreatureStats.State):
	match state:
		CreatureStats.State.UNCONSCIOUS:
			queue_free()
		_:
			_set_texture("idle")
