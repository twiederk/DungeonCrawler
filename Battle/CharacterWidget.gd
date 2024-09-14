class_name CharacterWidget
extends BaseCreatureWidget


func _on_state_changed(state: CreatureStats.State):
	match state:
		CreatureStats.State.UNCONSCIOUS:
			_set_texture("dead")
		_:
			_set_texture("idle")


func _on_image_texture_rect_item_dropped(item_resource: ItemResource):
	MessageBus.message_send.emit(str(_creature_stats.name, " hat ", item_resource.name, " erhalten."))
	_creature_stats.inventory.add_item(item_resource)
